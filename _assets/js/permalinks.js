/* Script to add hover anchor links to all headers (2-4) with ids */
var tags = ['h2', 'h3', 'h4'];

for(var i = 0; i < tags.length; i++) {

    headers = document.getElementsByTagName(tags[i]);

    for(var j = 0, header; header = headers[j]; j++) {

        if (header.id) {

            var a = document.createElement('a');

            a.href = '#' + header.id;

            a.innerHTML = a.title = a.className = 'permalink';

            header.appendChild(a);
        }
    }
}
