<template>
  <div class="app">
    <toolbar></toolbar>
    <labels-list></labels-list>
    <issues-list></issues-list>
    <issue></issue>
  </div>
</template>

<style>
  html, body, .app {
    height: 100%;
  }
</style>

<script>
  import Toolbar from './components/Toolbar'
  import LabelsList from './components/LabelsList.vue'
  import IssuesList from './components/IssuesList.vue'
  import Issue from './components/Issue.vue'

  import store from './vuex/store'
  import {initStore} from './vuex/actions'
  export default {
    components: {
      Toolbar,
      LabelsList,
      IssuesList,
      Issue
    },
    store,
    vuex: {
      actions: {
        initStore
      }
    },
    ready() {
      this.initStore()
    }
  }
</script>
