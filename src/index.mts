import { render } from './canvasInlinePdf.mjs'

const init = async () => {
    const canvas: HTMLCanvasElement | null = document.getElementById(
        'canvas-inline-pdf'
    ) as HTMLCanvasElement

    if (canvas === null) {
        console.log('canvas not present')
        return
    }

    const queryString: string = window.location.search

    const urlParams = new URLSearchParams(queryString)

    console.log(urlParams)

    const encodedUri: string | null = urlParams.get('signedUrl')
    const pageNumber: number = parseInt(urlParams.get('pageNumber') ?? '1')
    const scale: number = parseFloat(urlParams.get('scale') ?? '1.0')

    console.log({ encodedUri, pageNumber, scale })

    if (encodedUri === null) {
        return
    }

    const signedUrl: string = decodeURI(encodedUri)

    render({ canvas, scale, pageNumber, signedUrl })
}

addEventListener('DOMContentLoaded', init)
