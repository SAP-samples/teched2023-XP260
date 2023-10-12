# xspattern

[![NPM version](https://badge.fury.io/js/xspattern.svg)](https://badge.fury.io/js/xspattern)
[![CI](https://github.com/bwrrp/xspattern.js/workflows/CI/badge.svg)](https://github.com/bwrrp/xspattern.js/actions?query=workflow%3ACI)

XML Schema Regular Expression engine

This library is a complete implementation of an engine for the regular
expression language defined in XML Schema 1.0 and 1.1. It follows the XML
Schema 1.1 specification, which corrects some errors in earlier versions but
should be considered fully compatible with XML Schema 1.0.

For Unicode-related functionality, this implementation follows Unicode
version 12.1.0. For compatibility with XML Schema 1.0, Unicode block names
that existed in Unicode 3.1.0 are accepted as aliases for their current
counterparts in `\p{Is...}` and `\P{Is...}` expressions.

## Installation

The xspattern library can be installed using npm or yarn:

```bat
npm install --save xspattern
```

or

```bat
yarn add xspattern
```

The package includes both a UMD bundle (`dist/xspattern.umd.js`), compatible
with Node.js, and an ES6 module (`dist/xspattern.esm.js`). The `whynot`
library is used as a dependency, but is not included in the bundles. It
should be automatically installed and included in most configurations.

## Usage

The library currently exports a single function `compile`, which expects a
string containing a single pattern and returns a function. This function
accepts a single string representing a value to test and returns a boolean
indicating whether the value matches the pattern.

```javascript
// for ES6 / Typescript:
import { compile } from 'xspattern';
// or for CommonJS / Node.js:
const { compile } = require('xspattern');

// This pattern matches sequences of one or more lower case consonants
const matchesPattern = compile('[a-z-[aeoui]]+');
console.log(matchesPattern('asdfgh')); // false
console.log(matchesPattern('zxcvbn')); // true
```
