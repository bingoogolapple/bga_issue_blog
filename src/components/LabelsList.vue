<template>
  <ul class="label-list">
    <li @click="setActiveLabel(null)">
      <span class="tag" v-if="!activeLabel" style="background-color: #3593f2;">ALL</span>
      <span class="tag tag-unchecked" v-else>ALL</span>
    </li>
    <li v-for="label in labels" :key="label.id" @click="setActiveLabel(label)">
      <span class="tag" v-if="activeLabel && activeLabel.name === label.name"
            :style="{ backgroundColor: '#' + label.color}">{{label.name}}</span>
      <span v-else class="tag tag-unchecked">{{label.name}}</span>
    </li>
  </ul>
</template>
<style lang="scss" scoped>
  .label-list {
    list-style: none;
    flex-shrink: 0;
    padding: 20px 26px 0px 50px;
    display: flex;
    flex-wrap: wrap;
    li {
      margin-bottom: 20px;
      margin-right: 10px;
    }
  }

  .tag-unchecked {
    background-color: #f2f5f8;
    color: #849aa4;
  }
</style>
<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapGetters([
        'labels',
        'activeLabel'
      ])
    },
    methods: {
      ...mapActions([
        'setLabels',
        'updateActiveLabel'
      ]),
      setActiveLabel (label) {
        if (this.$route.name === 'BlogDetail') {
          this.updateActiveLabel(label)
          this.$router.push('/')
        } else {
          if (this.activeLabel && label && this.activeLabel.name === label.name) {
            this.updateActiveLabel(null)
          } else {
            this.updateActiveLabel(label)
          }
        }
      }
    }
  }
</script>
