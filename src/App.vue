<template>
  <div id="app" class="app">
    <toolbar></toolbar>
    <labels-list></labels-list>
    <issues-list></issues-list>
    <markdown></markdown>
    <notes-list></notes-list>
  </div>
</template>

<style>
  html, #app {
    height: 100%
  }

  body {
    margin: 0;
    padding: 0;
    border: 0;
    height: 100%;
    max-height: 100%;
    position: relative
  }
</style>

<script>
  import Toolbar from './components/Toolbar'
  import LabelsList from './components/LabelsList.vue'
  import IssuesList from './components/IssuesList.vue'
  import Markdown from './components/Markdown.vue'
  import store from './vuex/store'
  import {initStore} from './vuex/actions'
  export default {
    components: {
      Toolbar,
      LabelsList,
      IssuesList,
      Markdown
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
