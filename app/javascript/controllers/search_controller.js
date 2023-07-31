import { Controller } from "@hotwired/stimulus";
import { useDebounce } from 'stimulus-use'

export default class extends Controller {
    static debounces = ['search']
    static targets = ['preview', 'search']

    connect() {
        useDebounce(this, { wait: 1000 })
    }

    search() {
        let q = this.searchTarget.value
        this.previewTarget.src = '/search?q=' + q + '&preview'
    }

    handleEnter(event) {
        if (event.key === 'Enter') {
            this.previewTarget.src = null
        }
    }

    clear() {
        this.searchTarget.value = null
        this.previewTarget.src = null
    }

}
