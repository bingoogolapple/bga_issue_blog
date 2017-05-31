import axios from 'axios'
import Vue from 'vue'
import App from './App'

import VueRouter from 'vue-router'
import lodash from 'lodash'
import store from './store'

Vue.use(VueRouter)
Vue.prototype._ = lodash
Vue.prototype.$http = axios

const router = new VueRouter({
  routes: [
    { path: '/index', component: App },
    { path: '*', redirect: '/index' }
  ]
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  render: h => h('router-view')
})
