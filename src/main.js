import Vue from 'vue'
import axios from 'axios'
import {
  Pagination,
  Loading,
  Message
} from 'element-ui'

Vue.use(Pagination)
Vue.use(Loading)
Vue.component(Message.name, Message)
Vue.prototype.$message = Message

import lodash from 'lodash'
import moment from 'moment'
import marked from 'marked'
import highlight from 'highlight.js'
import 'highlight.js/styles/github.css'
import 'github-markdown-css/github-markdown.css'

import App from './App'
import store from './store'
import router from './router'
import './css/main.css'

import {gitHubApi, isGetUserInfo} from './utils'
import {showMessage, successMessage, errorMessage, warningMessage, infoMessage} from './utils/toastUtil'

Vue.prototype._ = lodash
moment.locale('zh-cn')
Vue.prototype.$moment = moment
Vue.prototype.$http = axios
Vue.prototype.$highlight = highlight
Vue.prototype.$showMessage = showMessage
Vue.prototype.$successMessage = successMessage
Vue.prototype.$errorMessage = errorMessage
Vue.prototype.$warningMessage = warningMessage
Vue.prototype.$gitHubApi = gitHubApi
Vue.prototype.$infoMessage = infoMessage
Vue.prototype.$isGetUserInfo = isGetUserInfo

marked.setOptions({
  renderer: new marked.Renderer(),
  gfm: true,
  tables: true,
  breaks: false,
  pedantic: false,
  sanitize: false,
  smartLists: true,
  smartypants: false,
  highlight: function (code) {
    return Vue.prototype.$highlight.highlightAuto(code).value
  }
})
Vue.prototype.$marked = marked

/* eslint-disable no-new */
const vm = new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: {App}
})

let loadingInstance

// request拦截器
axios.interceptors.request.use((config) => {
  let isGetUserInfo = vm.$isGetUserInfo(vm, config)
  if (!isGetUserInfo) {
    loadingInstance = Loading.service({
      text: '拼命加载中...'
    })
  }
  return config
}, (error) => {
  return Promise.reject(error)
})

// response拦截器
axios.interceptors.response.use((response) => {
  let isGetUserInfo = vm.$isGetUserInfo(vm, response.config)
  if (isGetUserInfo) {
    return response
  } else {
    setTimeout(() => {
      loadingInstance.close()
    }, 500)
    return response
  }
}, (error) => {
  let isGetUserInfo = vm.$isGetUserInfo(vm, error.config)
  if (!isGetUserInfo) {
    loadingInstance.close()
    console.error('response', JSON.stringify(error))

    if (error.response && error.response.statusText) {
      vm.$errorMessage(error.response.status + ' ' + error.response.statusText)
    }
  }

  return Promise.reject(error.response)
})
