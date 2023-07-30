import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="visible"
export default class extends Controller {
    static targets = [ "field", "show", "hide" ]

    connect() {
        this.fieldTarget.type = 'password';
        this.hideTarget.style.display = 'none';
        this.showTarget.style.display = 'block';
    }

    show() {
        this.fieldTarget.type = 'text';
        this.showTarget.style.display = 'none';
        this.hideTarget.style.display = 'block';
    }

    hide() {
        this.fieldTarget.type = 'password';
        this.hideTarget.style.display = 'none';
        this.showTarget.style.display = 'block';
    }
}
