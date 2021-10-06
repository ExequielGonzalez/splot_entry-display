<template>
  <section class="information">
    <h1 class="information__title">Lugares disponibles</h1>
    <h2 class="information__number">25</h2>
  </section>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "Home"
});
</script>

<style lang="scss" scoped>
.information {
  display: flex;
  width: 100%;
  height: 100vh;
  align-items: center;
  justify-content: center;
  align-content: center;
  flex-direction: column;
  //   &__title {
  //   }
}
</style>