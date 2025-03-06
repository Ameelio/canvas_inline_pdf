import * as pdf from 'pdfjs-dist'

pdf.GlobalWorkerOptions.workerSrc = '/worker.min.mjs'

interface RenderArgs {
    canvas: HTMLCanvasElement
    pageNumber: number
    signedUrl: string
}

// PDF.js default scale is set to 72DPI
// We want 300DPI (Print)
const SCALE = 300.0 / 72.0

export const render = async (args: RenderArgs) => {
    const { canvas, pageNumber, signedUrl } = args

    const page: pdf.PDFPageProxy = await pdf
        .getDocument(signedUrl)
        .promise.then((doc) => {
            return doc.getPage(pageNumber)
        })

    const viewport = page.getViewport({ scale: SCALE })

    canvas.height = viewport.height
    canvas.width = viewport.width

    const canvasContext = canvas.getContext('2d')

    if (canvasContext == null) {
        return
    }

    const renderTask = page.render({
        canvasContext,
        viewport,
    })

    await renderTask.promise
}
