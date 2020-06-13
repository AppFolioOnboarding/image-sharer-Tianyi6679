class ShareImageModal {
  constructor(modalSelector) {
    this.$modal = $(modalSelector);
  }

  attachEventHandlers() {
    this.$modal.on('show.bs.modal', (event) => {
      const modalTrigger = event.relatedTarget;
      const modalTitle = modalTrigger.dataset.title;
      const modalImgId = modalTrigger.dataset.id;
      this.$modal.find('.modal-title').text(`Share your image ${modalTitle} with your friends`);
      this.$modal.find('#share_form').attr('action', `/images/${modalImgId}/send_email`).submit();
    });
  }
}


const shareImgModal = new ShareImageModal('#shareModal');

shareImgModal.attachEventHandlers();
