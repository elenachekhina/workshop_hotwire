import { Controller } from "@hotwired/stimulus";
import { useDebounce } from 'stimulus-use'

export default class extends Controller {
    static debounces = ['search']
    static targets = ['preview', 'search']
    enterPressed = false;

    connect() {
        useDebounce(this, { wait: 1000 })
    }

    search() {
        if(this.enterPressed) {
            this.enterPressed = false;
            return;
        }
        let q = this.searchTarget.value
        this.previewTarget.src = '/search?q=' + q + '&preview'
    }

    handleEnter(event) {
        if (event.key === 'Enter') {
            this.enterPressed = true
            this.previewTarget.src = null
        } else {
            this.enterPressed = false
        }
    }

    clear() {
        this.enterPressed = false
        this.searchTarget.value = null
        this.previewTarget.src = null
    }

}
