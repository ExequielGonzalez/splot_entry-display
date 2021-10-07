<template>
  <section v-if="!noPlace" class="information">
    <h2 class="information__title">Lugares disponibles</h2>
    <h1 class="information__number">{{freePlaces}}</h1>
  </section>
  <section v-if="noPlace" class="information">
    <h1 class="information__error">No hay lugares disponibles</h1>
  </section>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useSocketIo, webSocketNewEntry } from "src/service/socket.js";
import { getOccupationDetails } from "src/utils/http-handler";

export default defineComponent({
  name: "Home",
  setup() {
    return {
      noPlace: ref(false)
    };
  },
  data() {
    return {
      wsNotification: false,
      parkPlaces: {
        total: 0,
        free: 0,
        busy: 0
      },
      motorbikePlaces: {
        total: 0,
        free: 0,
        busy: 0
      }
    };
  },
  computed: {
    freePlaces() {
      return this.parkPlaces.free ?? 0;
    }
  },
  mounted() {
    const socket = useSocketIo(5000);
    webSocketNewEntry(socket, this.newMessage);

    this.newMessage();
  },
  methods: {
    async newMessage() {
      let response;
      let occupation = {};

      response = await getOccupationDetails();
      if (response.status === 200) occupation = response.data;
      // console.log(occupation);
      this.parkPlaces = occupation.carsAndVans;
      this.motorbikePlaces = occupation.motorbikes;
      console.log(response);
      if (this.parkPlaces.free === 0) this.noPlace = true;
      else this.noPlace = false;
    }
  }
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
  text-align: center;
  border: 8px solid #5155c3;
  &__error {
    color: #aa0000;
    line-height: 160px;
    font-weight: bold;
    letter-spacing: 5px;
    font-size: 9rem;
  }
  &__title {
    font-size: 8rem;
    line-height: 100px;
    margin: 30px 0px 110px 0px;
    font-weight: bold;
    // margin-bottom: 50px;

    // padding: 4rem 0px;
  }
  &__number {
    height: 100%;
    font-size: 28rem;
    margin: 0;
    font-weight: bold;
    padding-top: 4rem;
    padding-bottom: 0rem;
    color: $green-10;
  }
}
</style>