var frisby = require('frisby');

frisby.create('hello world')
  .get(url_base + 'hello-world')
  .expectStatus(200)
  .expectHeaderContains('content-type', 'application/json')
  .expectJSON('0', {
    message: "hello world"
  })
.toss();

