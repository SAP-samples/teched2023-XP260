# whynot.js

[![NPM version](https://badge.fury.io/js/whynot.svg)](https://badge.fury.io/js/whynot)
[![CI](https://github.com/bwrrp/whynot.js/workflows/CI/badge.svg)](https://github.com/bwrrp/whynot.js/actions?query=workflow%3ACI)

Generic VM-based formal language matching framework, inspired by [http://swtch.com/~rsc/regexp/](http://swtch.com/~rsc/regexp/)

This library implements a VM able to execute programs aimed at matching
formal languages. It does so by considering all possible branches in
parallel. This could be used to efficiently implement many types of language
matching, including regular expressions and XML schemas. Furthermore, the
program could be set up to record its progress through both the input and the
language's grammar. This enables giving feedback on _why_ a given input does
not match the grammar rules in some way.

For an example showing how this library can be used, see
[Examples.tests.ts](https://github.com/bwrrp/whynot.js/blob/main/test/Examples.tests.ts)
in the test suite.

## Benchmarking

A simple benchmark is included in the `performance` directory. This script runs a simple program
including repetition and records on an input of 1000000 items. These can be run using
[fonto-benchmark-runner commands](https://www.npmjs.com/package/@fontoxml/fonto-benchmark-runner)
which will run the benchmarks in the console. You can see the benchmark results in
the console output.
