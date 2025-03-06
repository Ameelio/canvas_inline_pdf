#!/usr/bin/env node

import * as esbuild from 'esbuild'

const isProd = process.env.NODE_ENV == 'production' ? true : false
const isDev = !isProd

await esbuild.build({
    entryPoints: ['src/index.mts'],
    bundle: true,
    minify: isProd,
    outfile: 'dist/index.js',
    sourcemap: isDev,
})
