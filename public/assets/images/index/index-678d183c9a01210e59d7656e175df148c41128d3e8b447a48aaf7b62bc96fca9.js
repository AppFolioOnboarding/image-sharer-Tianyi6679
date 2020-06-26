class MyModal {
  constructor(modalSelector) {
    this.$modal = $(modalSelector);
  }

  attachEventHandlers() {
    this.$modal.on('show.bs.modal', (event) => {
      const modalTrigger = event.relatedTarget;
      const modalTitle = modalTrigger.dataset.title;
      const modalUrl = modalTrigger.dataset.url;
      
      this.$modal.find('.modal-title').text('Share your image ' + modalTitle + ' with your friends');
      this.$modal.find('#request_image').val(modalUrl);
    });
  }
}


const myModal = new MyModal('#myModal');

myModal.attachEventHandlers();
