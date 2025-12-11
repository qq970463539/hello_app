import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="bootstrap"
export default class extends Controller {
  connect() {
    document.querySelectorAll('.dropdown-toggle').forEach((dropdownToggleEl) => {
      new bootstrap.Dropdown(dropdownToggleEl);
    });
  }
}