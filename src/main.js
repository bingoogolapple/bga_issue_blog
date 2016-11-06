import Vue from 'vue'
import App from './App'

import VueRouter from 'vue-router'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    { path: '/index', component: App },
    { path: '*', redirect: '/index' }
  ]
})

new Vue({
  el: '#app',
  router: router,
  render: h => h('router-view')
})
