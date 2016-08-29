<template>
  <div id="note-editor">
    <div class="form-group">
      <input type="text" name="title"
             class="title form-control"
             placeholder="请输入标题"
             @input="updateNote"
             v-model="currentNote.title">
      <textarea
        v-model="currentNote.content" name="content"
        class="form-control" row="3" placeholder="请输入正文"
        @input="updateNote"></textarea>
    </div>
  </div>
</template>

<script>
  import {editNote} from '../vuex/actions';
  import {activeNote} from '../vuex/getters';
  export default {
    vuex: {
      getters: {
        activeNote
      },
      actions: {
        editNote
      }
    },
    computed: {
      // 通过计算属性得到的一个对象，这样子我们就能愉快的使用 v-model 了
      currentNote: activeNote
    },
    methods: {
      // 为什么这么做？ 因为在严格模式中不允许直接在模板层面去修改 state 中的值
      updateNote() {
        this.editNote(this.currentNote);
      }
    }
  }
</script>

<style lang="scss" scoped>
  #note-editor {
    height: 100%;
    margin-left: 380px;
    .form-group {
      height: 50%;
    }
    .title {
      border: 0;
    }
    textarea {
      height: 100%;
      border: 0;
      border-radius: 0;
      padding-top: 15px;
    }
  }
</style>
