# encoding: utf-8
# vim: set ts=2 sw=2 et:
#
# Jekyll category page generator.
# http://recursive-design.com/projects/jekyll-plugins/
#
# Version: 0.2.4 (201210160037)
#
# Copyright (c) 2010 Dave Perrett, http://recursive-design.com/
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)
#
# A generator that creates category pages for jekyll sites.
#
# To use it, simply drop this script into the _plugins directory of your Jekyll
# site. You should also create a file called 'category_index.html' in the
# _layouts directory of your jekyll site.
#
# When you compile your jekyll site, this plugin will loop through the list of
# categories in your site, and use the category_index layout above to generate
# a page for each one with a list of links to the individual posts.
#
# Included filters :
# - category_link: Outputs a category as an <a> link.
# - category_links: Outputs the list of categories as comma-separated <a> links.
#
# Available _config.yml settings :
# - category_dir:          The subfolder to build category pages in (default is 'categories').
# - category_title_prefix: The string used before the category name in the page title (default is
#                          'Category: ').
module Jekyll

  # The CategoryIndex class creates a single category page for the specified category.
  class CategoryPage < Page

    # Initializes a new CategoryIndex.
    #
    #  +template_path+ is the path to the layout template to use.
    #  +site+          is the Jekyll Site instance.
    #  +base+          is the String path to the <source>.
    #  +category_dir+  is the String path between <source> and the category folder.
    #  +category+      is the category currently being processed.
    def initialize(template_path, name, site, base, category_dir, category)
      @site  = site
      @base  = base
      @dir   = category_dir
      @name  = name

      self.process(name)

      if File.exist?(template_path)
        @perform_render = true
        template_dir    = File.dirname(template_path)
        template        = File.basename(template_path)
        # Read the YAML data from the layout page.
        self.read_yaml(template_dir, template)
        self.data['category']    = category
        # Set the title for this page.
        title_prefix             = site.config['category_title_prefix'] || 'Category: '
        self.data['title']       = "#{title_prefix}#{category}"
        # Set the meta-description for this page.
        meta_description_prefix  = site.config['category_meta_description_prefix'] || 'Category: '
        self.data['description'] = "#{meta_description_prefix}#{category}"
      else
        @perform_render = false
      end
    end

    def render?
      @perform_render
    end

  end

  # The CategoryIndex class creates a single category page for the specified category.
  class CategoryIndex < CategoryPage

    # Initializes a new CategoryIndex.
    #
    #  +site+         is the Jekyll Site instance.
    #  +base+         is the String path to the <source>.
    #  +category_dir+ is the String path between <source> and the category folder.
    #  +category+     is the category currently being processed.
    def initialize(site, base, category_dir, category)
      template_path = File.join(base, '_layouts', 'category_index.html')
      super(template_path, 'index.html', site, base, category_dir, category)
    end

  end

  # The CategoryFeed class creates an Atom feed for the specified category.
  class CategoryFeed < CategoryPage

    # Initializes a new CategoryFeed.
    #
    #  +site+         is the Jekyll Site instance.
    #  +base+         is the String path to the <source>.
    #  +category_dir+ is the String path between <source> and the category folder.
    #  +category+     is the category currently being processed.
    def initialize(site, base, category_dir, category)
      template_path = File.join(base, '_includes', 'custom', 'category_feed.xml')
      super(template_path, 'atom.xml', site, base, category_dir, category)

      # Set the correct feed URL.
      self.data['feed_url'] = "#{category_dir}/#{name}" if render?
    end

  end

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    # Creates an instance of CategoryIndex for each category page, renders it, and
    # writes the output to a file.
    #
    #  +category+ is the category currently being processed.
    def write_category_index(category)
      target_dir = GenerateCategories.category_dir(self.config['category_dir'], category)
      index      = CategoryIndex.new(self, self.source, target_dir, category)
      if index.render?
        index.render(self.layouts, site_payload)
        index.write(self.dest)
        # Record the fact that this pages has been added, otherwise Site::cleanup will remove it.
        self.pages << index
      end

      # Create an Atom-feed for each index.
      feed = CategoryFeed.new(self, self.source, target_dir, category)
      if feed.render?
        feed.render(self.layouts, site_payload)
        feed.write(self.dest)
        # Record the fact that this pages has been added, otherwise Site::cleanup will remove it.
        self.pages << feed
      end
    end

    # Loops through the list of category pages and processes each one.
    def write_category_indexes
      if self.layouts.key? 'category_index'
        self.categories.keys.each do |category|
          self.write_category_index(category)
        end

      # Throw an exception if the layout couldn't be found.
      else
        throw "No 'category_index' layout found."
      end
    end

  end


  # Jekyll hook - the generate method is called by jekyll, and generates all of the category pages.
  class GenerateCategories < Generator
    safe true
    priority :low

    CATEGORY_DIR = 'categories'

    def generate(site)
      site.write_category_indexes
    end

    # Processes the given dir and removes leading and trailing slashes. Falls
    # back on the default if no dir is provided.
    def self.category_dir(base_dir, category)
      base_dir = (base_dir || CATEGORY_DIR).gsub(/^\/*(.*)\/*$/, '\1')
      category = category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase
      File.join(base_dir, category)
    end

  end


  module CategoryFilters

    def category_link(category)
      base_dir = @context.registers[:site].config['category_dir']
      category_dir = GenerateCategories.category_dir(base_dir, category)
      "<a class=\"category\" href=\"/#{category_dir}/\">#{category}</a>"
    end

    def category_links(categories)
      categories.sort!.map(&method(:category_link)).join(', ')
    end
  end
end

Liquid::Template.register_filter(Jekyll::CategoryFilters)
