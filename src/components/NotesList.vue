<template>
  <div id="notes-list">
    <div id="list-header">
      <h2>Notes | bingoogolapple.cn</h2>
      <div class="btn-group btn-group-justified" role="group">
        <!-- all -->
        <div class="btn-group" role="group">
          <button type="button" class="btn btn-default"
                  @click="toggleShow('all')"
                  :class="{active: show === 'all'}">All Notes</button>
        </div>

        <!-- favorites -->
        <div class="btn-group" role="group">
          <button type="button" class="btn btn-default"
                  @click="toggleShow('favorite')"
                  :class="{active: show === 'favorite'}">Favorites</button>
        </div>
      </div>

      <div class="btn-group btn-group-justified" role="group">
        <div class="input-group search">
          <input type="text" class="form-control" v-model="search" placeholder="Search for...">
          <span class="input-group-addon">
            <i class="glyphicon glyphicon-search"></i>
          </span>
        </div>
      </div>

    </div>

    <!-- 渲染笔记列表 -->
    <div class="container">
      <div class="list-group">
        <a v-for="note in filteredNotes | filterBy search"
           class="list-group-item" href="#"
           :class="{active: activeNote === note}"
           @click="updateActiveNote(note)">
          <h4 class="list-group-item-heading">
            {{note.title.trim().substring(0,30)}}
          </h4>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import { updateActiveNote, updateShow } from '../vuex/actions';
  import { show, filteredNotes, activeNote } from '../vuex/getters';
  export default {
    data() {
      return {
        search: ''
      }
    },
    vuex: {
      getters: {
        show,
        filteredNotes,
        activeNote
      },
      actions: {
        updateActiveNote,
        updateShow
      }
    },
    methods: {
      toggleShow(show) {
        this.updateShow(show);
      }
    }
  }
</script>

<style lang="scss" scoped>
  #notes-list {
    float: left;
    width: 300px;
    height: 100%;
    background-color: #F5F5F5;
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    #list-header{
      padding: 5px 25px 25px 25px;
      h2{
        font-weight: 300;
        text-transform: uppercase;
        text-align: center;
        font-size: 22px;
        padding-bottom: 8px;
      }
      .search{
        margin-top: 20px;
      }
    }
    .container{
      height: calc(100% - 204px);
      max-height: calc(100% - 204px);
      overflow: auto;
      width: 100%;
      padding: 0;
      .list-group-item{
        border: 0;
        border-radius: 0;
        .list-group-item-heading{
          font-weight: 300;
          font-size: 15px;
        }
      }
    }
  }
</style>
