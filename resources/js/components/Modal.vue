<template>
<div>
  <transition name="modal">
        <div class="modal-mask" @click="close" v-show="show">
            <div class="modal-container" @click.stop>
              <slot></slot>
            </div>
        </div>
    </transition>
</div>
</template>
<script>
  export default {
      name:'NewModal',
      props: ['show'],
      
      methods: {
        close: function () {
          this.$emit('close');
        }
      },
      mounted: function () {
        document.addEventListener("keydown", (e) => {
          if (this.show && e.keyCode == 27) {
            this.close();
          }
        });
      }
  }
</script>