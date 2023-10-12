# prsc

[![NPM version](https://badge.fury.io/js/prsc.svg)](https://badge.fury.io/js/prsc)
[![CI](https://github.com/bwrrp/prsc.js/workflows/CI/badge.svg)](https://github.com/bwrrp/prsc.js/actions?query=workflow%3ACI)

Tiny parser combinators library for JavaScript and TypeScript. Heavily
inspired by [nom](https://github.com/Geal/nom).

## Installation

The prsc library can be installed using npm or yarn:

```bat
npm install --save prsc
```

or

```bat
yarn add prsc
```

The package includes both a UMD bundle (`dist/prsc.js`), compatible with
Node.js, and an ES6 module (`dist/prsc.mjs`). TypeScript typings are included
(`dist/prsc.d.ts`) and should work automatically in most cases.

## Usage

This library exports [a number of functions](./docs/prsc.md) that make it
easy to build parsers for input represented as a string. Start from primitive
parsers such as `token` or your own functions matching the `Parser` type,
transform results using `map` and `filter` and combine them using the other
functions such as `then` and `star`.

### Example

The following parser accepts a simple arithmetic language consisting of the
`+` and `*` operators:

```javascript
// Create a primitive parser that accepts a single digit
const digit = (input, offset) => {
	if (/^[0-9]$/.test(input[offset])) {
		return ok(offset + 1);
	}
	return error(offset, ['digit']);
};

// Use that to accept a string of one or more digits
const digits = plus(digit);

// Then use recognize to get the matching string and use map to parse that into a number
const number = map(recognize(digits), (str) => parseInt(str, 10));

// Multiplication
const term = then(
	number,
	star(preceded(token('*'), number)),
	// Multiply everything together
	(num, factors) => factors.reduce((product, factor) => product * factor, num)
);

// Addition
const expression = then(term, star(preceded(token('+'), term)), (num, terms) =>
	terms.reduce((sum, term) => sum + term, num)
);

// Parsing some input
console.log(expression('2*3+4*5', 0));
// > { success: true, offset: 7, value: 26 }
```

### Tips

Use functions to provide a layer of indirection for recursive definitions:

```javascript
const term = then(number, optional(preceded(token('*'), termIndirect)), ...);
function termIndirect(input, offset) {
	return term(input, offset);
}
```

Use the typings when working in TypeScript for strongly-typed parsers:

```typescript
const digit: Parser<string> = ...;
const digits = plus(digit); // Parser<string[]>
const number = map(
	digits,
	strs => parseInt(strs.join(''), 10)
); // Parser<number>
```
