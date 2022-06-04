<p align="center">
  <img src="https://github.com/terkelg/prompts/raw/master/prompts.png" alt="Prompts" width="500" />
</p>

<h1 align="center">❯ Nano.to CLI</h1>

<p align="center">
  <b>Nano.to Command Line Interface (CLI)</b><br />
  <!-- <sub>>_ Easy to use CLI prompts to enquire users for information▌</sub> -->
</p>

<br />

* **Simple**: prompts has [no big dependencies](http://npm.anvaka.com/#/view/2d/prompts) nor is it broken into a [dozen](http://npm.anvaka.com/#/view/2d/inquirer) tiny modules that only work well together.
* **User friendly**: prompt uses layout and colors to create beautiful cli interfaces.
* **Promised**: uses promises and `async`/`await`. No callback hell.
* **Flexible**: all prompts are independent and can be used on their own.
* **Testable**: provides a way to submit answers programmatically.
* **Unified**: consistent experience across all [prompts](#-types).


![split](https://github.com/terkelg/prompts/raw/master/media/split.png)

## ❯ Install

```
$ curl -L "https://github.com/fwd/nano-cli/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

> This package supports Node 6 and above

![split](https://github.com/terkelg/prompts/raw/master/media/split.png)

## ❯ Usage

<img src="https://github.com/terkelg/prompts/raw/master/media/example.gif" alt="example prompt" width="499" height="103" />

```js
const prompts = require('prompts');

(async () => {
  const response = await prompts({
    type: 'number',
    name: 'value',
    message: 'How old are you?',
    validate: value => value < 18 ? `Nightclub is 18+ only` : true
  });

  console.log(response); // => { value: 24 }
})();
```

> See [`example.js`](https://github.com/terkelg/prompts/blob/master/example.js) for more options.


![split](https://github.com/terkelg/prompts/raw/master/media/split.png)


## ❯ Examples

### Single Prompt

Prompt with a single prompt object. Returns an object with the response.

```js
const prompts = require('prompts');

(async () => {
  const response = await prompts({
    type: 'text',
    name: 'meaning',
    message: 'What is the meaning of life?'
  });

  console.log(response.meaning);
})();
```

## 👤 Author

**Fresh Web Designs**

📍 Miami, Florida (Crypto Capital of the World)

* Github: [@fwd](https://github.com/fwd)
* Website: [https://fwd.dev](https://fwd.dev)

## 🤝 Contributing

Give a ⭐️ if this project helped you!

Contributions, issues and feature requests are welcome! Feel free to check [issues page](https://github.com/fwd/nano-cli/issues).


## 📝 License

MIT License

Copyright © 2022 [Fresh Web Designs](https://fwd.dev).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Stargazers

[![Stargazers over time](https://starchart.cc/fwd/nano-cli.svg)](https://starchart.cc/fwd/nano-cli)