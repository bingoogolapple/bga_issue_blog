<template>
  <div id="notes-list">
    <div id="list-header">
      <h2>Issues</h2>

      <div class="btn-group btn-group-justified" role="group">
        <div class="input-group search">
          <input type="text" class="form-control" v-model="search" placeholder="Search for issue...">
          <span class="input-group-addon">
            <i class="glyphicon glyphicon-search"></i>
          </span>
        </div>
      </div>
    </div>

    <!-- 渲染Label列表 -->
    <div class="container">
      <div class="list-group">
        <a v-for="issue in issues | filterBy search"
           class="list-group-item"
           href="#"
           :class="{active: activeIssue === issue}"
           @click="setActiveIssue(issue)">
          <h4 class="list-group-item-heading">
            {{issue.title.trim().substring(0,18)}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import {setIssues, updateActiveIssue} from '../vuex/actions';
  import {issues, activeIssue, activeLabel} from '../vuex/getters';
  export default {
    data() {
      return {
        search: ''
      }
    },
    vuex: {
      getters: {
        issues,
        activeIssue,
        activeLabel
      },
      actions: {
        setIssues,
        updateActiveIssue
      }
    },
    watch: {
      activeLabel: function (label) {
        this.$http.get('https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/issues?labels=' + label.name).then(function (response) {
          this.setIssues(response.json())
        }, function (response) {
          console.log(response.data);
        });
      }
    },
    methods: {
      setActiveIssue: function (issue) {
        this.updateActiveIssue(issue)
      }
    }
  }
</script>

<style lang="scss" scoped>
  #notes-list {
    float: left;
    width: 250px;
    height: 100%;
    background-color: #F5F5F5;
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    #list-header {
      padding: 5px 25px 25px 25px;
      h2 {
        font-weight: 300;
        text-align: center;
        font-size: 22px;
        padding-bottom: 8px;
        color: #009de7;
      }
      .search {
        margin-top: 10px;
      }
    }
    .container {
      max-height: 100%;
      overflow: auto;
      width: 100%;
      padding: 0;
      .list-group-item {
        border: 0;
        border-radius: 0;
        .list-group-item-heading {
          font-weight: 300;
          font-size: 15px;
        }
      }
      .active {
        background-color: #2a3541;
      }
    }
  }
</style>
