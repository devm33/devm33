These are the files that I keep in the devm33 bucket on s3

Verify with

    s3cmd ls s3://devm33

Add a new file (and make it public) with

    s3cmd put filename.ext s3://devm33 -P --add-header='Cache-Control:max-age=31536000'

