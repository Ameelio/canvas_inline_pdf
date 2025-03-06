#!/usr/bin/env node

import * as esbuild from 'esbuild'

let ctx = await esbuild.context({
    entryPoints: ['build/index.mjs'],
    bundle: true,
    outfile: 'dist/index.js',
})

ctx.serve({
    port: 8000,
    servedir: 'dist',
})
