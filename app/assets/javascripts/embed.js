import Embed from 'flat-embed';

var container = document.getElementById("embed-container");
var embed = new Embed(container, {
  "width": "100%",
  "height": "450",
  "score": "<%= @score.id %>",
  "embedParams": {
    "mode": "edit",
    "branding": false,
    "appId": "5ecd978ef0aa2b501cf8cf25",
    "controlsPosition": "top"
  },
});

var headers = new Headers();
headers.set('Authorization', 'Bearer ' + '<%= current_user.flat_key%>')
headers.set('Content-Type', 'application/json')

document.getElementById('export-xml').addEventListener('click', function () {
  embed.getMusicXML().then(function (xml) {
    editScore(btoa(xml))
  });
});

function editScore(document) {
  fetch('https://api.flat.io/v2/scores/<%= @score.id %>/revisions', {
    method: 'post',
    headers: headers,
    body: JSON.stringify({
      "title": "<%= @score.title %>",
      "data": `${document}`,
      "dataEncoding": "base64",
      "autosave": true
    }),
    mode: 'cors'
  })
};