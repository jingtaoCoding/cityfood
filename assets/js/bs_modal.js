// assets/js/bs_modal.js
export const BsModal = {
  mounted() {
    // ... other code
    // Add this below

    this.el.querySelector('form').addEventListener('submit', event => {
      const backdrop = document.querySelector('.modal-backdrop')
      if (backdrop) backdrop.parentElement.removeChild(backdrop)
    })
  }
}