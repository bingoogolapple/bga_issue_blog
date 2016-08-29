import Vue from 'vue'
import App from './App'

import VueRouter from 'vue-router'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(VueRouter)

const router = new VueRouter({
  hashbang: false
})

router.map({
  '/index': {
    component: App
  }
})

router.redirect({
  '*': '/index'
})

router.start(App, '#app')
