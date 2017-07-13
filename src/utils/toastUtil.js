/**
 * Created by bingoogolapple on 2017/7/14.
 */

const showMessage = function (data) {
  if (data.message) {
    this.$message({
      showClose: true,
      message: data.message,
      type: data.type
    })
    let messageArr = document.querySelectorAll('div.el-message')
    if (messageArr && messageArr.length > 0) {
      let messageNode = messageArr[messageArr.length - 1]
      if (data.type === 'warning') {
        messageNode.style.backgroundColor = '#F7BA2A'
      } else if (data.type === 'error') {
        messageNode.style.backgroundColor = '#FF4949'
      } else if (data.type === 'success') {
        messageNode.style.backgroundColor = '#13CE66'
      } else {
        messageNode.style.backgroundColor = '#50BFFF'
      }
    }
  }
}

const successMessage = function (message) {
  this.$showMessage({
    message: message,
    type: 'success'
  })
}

const errorMessage = function (message) {
  this.$showMessage({
    message: message,
    type: 'error'
  })
}

const warningMessage = function (message) {
  this.$showMessage({
    message: message,
    type: 'warning'
  })
}

const infoMessage = function (message) {
  this.$showMessage({
    message: message,
    type: 'info'
  })
}

module.exports = {
  showMessage,
  successMessage,
  errorMessage,
  warningMessage,
  infoMessage
}
