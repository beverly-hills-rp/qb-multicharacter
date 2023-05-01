<script setup lang="ts">
import type { RegisterData, ShowState } from "@/typings";
import { ref } from "vue";

import Swal from "sweetalert2";

import VueDatePicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";

import countries from "@/assets/countries.json";
import profanities from "@/assets/profanity.json";
import { fetchNui } from "@/utils/fetchNui";

import "@/style/components/CharacterRegisterComponent.css";

const regTest = new RegExp("(" + profanities.join("|") + ")\\b", "i");

const props = defineProps<{
    show: ShowState;
    customNationality: boolean;
    translations: Record<string, any>;
    selectedCharacter: number;
    close: () => void;
}>();

const registerData = ref<RegisterData>({
    date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substr(0, 10),
    firstname: undefined,
    lastname: undefined,
    nationality: undefined,
    gender: undefined,
});

const nationalities = ref<string[]>(countries.map((country) => country.country));

function createCharacter() {
    const data = registerData.value;

    if (
        data.firstname === undefined ||
        data.firstname === "" ||
        data.lastname === undefined ||
        data.lastname === "" ||
        data.gender === undefined ||
        data.nationality === undefined ||
        data.nationality === "" ||
        data.date === undefined
    ) {
        Swal.fire({
            icon: "error",
            title: props.translations["ran_into_issue"],
            text: props.translations["forgotten_field"],
            timer: 5000,
            timerProgressBar: true,
            showConfirmButton: false,
        });

        return;
    }

    var profanityTest =
        !regTest.test(data.firstname) &&
        !regTest.test(data.nationality) &&
        !regTest.test(data.lastname);

    if (!profanityTest) {
        Swal.fire({
            icon: "error",
            title: props.translations["ran_into_issue"],
            text: props.translations["profanity"],
            timer: 5000,
            timerProgressBar: true,
            showConfirmButton: false,
        });

        return;
    }

    props.close();

    fetchNui("createNewCharacter", {
        firstname: data.firstname,
        lastname: data.lastname,
        nationality: data.nationality,
        birthdate: data.date,
        gender: data.gender,
        cid: props.selectedCharacter,
    });
}

function dateFormat(date: Date) {
    return new Date(date.getTime() - new Date().getTimezoneOffset() * 60000)
        .toLocaleString("pt-BR")
        .substr(0, 10);
}
</script>

<template>
    <div class="character-register-container">
        <div
            class="modal"
            :class="{
                'slide-top-fade-leave-active': !show.register,
                'slide-top-fade-leave-to': !show.register,
            }"
        >
            <div class="characters-register-block-header">
                <p>{{ translations["chardel_header"] }}</p>
                <span id="close-reg" class="material-symbols-outlined" @click="close()">
                    close
                </span>
            </div>
            <div class="char-register-inputs">
                <v-text-field
                    :placeholder="translations['firstname']"
                    variant="solo"
                    hide-details="auto"
                    bg-color="#32456759"
                    v-model="registerData.firstname"
                    :disabled="!show.register"
                    density="compact"
                ></v-text-field>
                <v-text-field
                    :placeholder="translations['lastname']"
                    variant="solo"
                    hide-details="auto"
                    bg-color="#32456759"
                    v-model="registerData.lastname"
                    :disabled="!show.register"
                    density="compact"
                ></v-text-field>
                <v-text-field
                    v-if="customNationality"
                    :placeholder="translations['nationality']"
                    variant="solo"
                    hide-details="auto"
                    bg-color="#32456759"
                    v-model="registerData.nationality"
                    :disabled="!show.register"
                    density="compact"
                ></v-text-field>
                <v-select
                    v-else
                    variant="solo"
                    :placeholder="translations['nationality']"
                    :items="nationalities"
                    hide-details="auto"
                    bg-color="#32456759"
                    v-ripple
                    v-model="registerData.nationality"
                    :disabled="!show.register"
                    density="compact"
                    :menu-icon="undefined"
                ></v-select>
                <v-select
                    variant="solo"
                    :placeholder="translations['gender']"
                    :items="[translations['male'], translations['female']]"
                    hide-details="auto"
                    bg-color="#32456759"
                    v-ripple
                    v-model="registerData.gender"
                    :disabled="!show.register"
                    density="compact"
                ></v-select>
                <VueDatePicker
                    v-model="registerData.date"
                    min-date="1900-01-01"
                    max-date="2100-12-31"
                    :placeholder="translations['birthdate']"
                    no-today
                    :show-now-button="false"
                    :hide-navigation="['time', 'minutes', 'hours', 'seconds']"
                    prevent-min-max-navigation
                    :enable-time-picker="false"
                    :format="dateFormat"
                />
            </div>
            <v-btn
                :disabled="!show.register"
                class="character-reg-btn"
                color="#DC143C"
                v-ripple
                @click="createCharacter()"
                large
                >{{ translations["create_button"] }}</v-btn
            >
        </div>
    </div>
</template>
