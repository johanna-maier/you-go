// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

const application = Application.start();
const context = require.context("controllers", true, /_controller\.js$/);
application.load(definitionsFromContext(context));


const words = [
  "RUNNING ]",
  " CYCLING ]",
  "SURFING ]",
  "SKIING ]",
  "DANCING ]",
  "PLAYING ]",
  "CLIMBING ]",
];
let i = 0;
let timer;

function typingEffect() {
  console.log('a')
  let word = words[i].split("");
  var loopTyping = function () {
    // console.log('a');
    if (word.length > 0) {
      if(document.getElementById("word")) {
        document.getElementById("word").innerHTML += word.shift();
      }
    } else {
      deletingEffect();
      return false;
    }
    timer = setTimeout(loopTyping, 110);
  };
  loopTyping();
}

function deletingEffect() {
  console.log('b')
  let word = words[i].split("");
  var loopDeleting = function () {
    if (word.length > 0) {
      word.pop();
      if(document.getElementById("word")) {
        document.getElementById("word").innerHTML = word.join("");
      }
    } else {
      if (words.length > i + 1) {
        i++;
      } else {
        i = 0;
      }
      typingEffect();
      return false;
    }
    timer = setTimeout(loopDeleting, 110);
  };
  loopDeleting();
}
console.log('start typing')
typingEffect();

// document.addEventListener("DOMContentLoaded", () => {
//   console.log("--------  DOM")
// });
