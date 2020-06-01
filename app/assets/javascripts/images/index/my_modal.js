class MyModel {
  constructor(modelSelector) {
    this.modelSelector = modelSelector;
  }

  attachEventHandlers() {
    console.log(this.modelSelector);
    console.log('attached');
  }
}

export default MyModel;
