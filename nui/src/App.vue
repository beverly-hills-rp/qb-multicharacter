<script setup lang="ts">
import { ref, onMounted } from "vue";

import type { AppState } from "./typings";
import { fetchNui } from "./utils/fetchNui";

import LoadingComponent from "@/components/LoadingComponent.vue";
import CharacterListComponent from "./components/CharacterListComponent.vue";
import CharacterInfoComponent from "./components/CharacterInfoComponent.vue";
import CharacterRegisterComponent from "./components/CharacterRegisterComponent.vue";
import CharacterDeleteComponent from "./components/CharacterDeleteComponent.vue";

const appState = ref<AppState>({
    characters: [],
    chardata: {},
    show: {
        loading: false,
        characters: false,
        register: false,
        delete: false,
    },
    allowDelete: false,
    dataPickerMenu: false,
    characterAmount: 0,
    loadingText: "",
    selectedCharacter: -1,
    dollar: Intl.NumberFormat("en-US"),
    translations: {},
    customNationality: false,
});

onMounted(() => {
    var loadingProgress = 0;
    var loadingDots = 0;
    var loadingInterval: any;

    window.addEventListener("message", ({ data }) => {
        console.log(data);
        switch (data.action) {
            case "ui":
                appState.value.customNationality = data.customNationality;
                appState.value.translations = data.translations;
                appState.value.characterAmount = data.nChar;
                appState.value.selectedCharacter = -1;
                appState.value.show.register = false;
                appState.value.show.delete = false;
                appState.value.show.characters = false;
                appState.value.allowDelete = data.enableDeleteButton;

                if (!data.toggle) break;

                appState.value.show.loading = true;

                appState.value.loadingText = translate("retrieving_playerdata");

                loadingInterval = setInterval(function () {
                    loadingDots++;
                    loadingProgress++;

                    switch (loadingProgress) {
                        case 3:
                            appState.value.loadingText = translate("validating_playerdata");
                            break;
                        case 4:
                            appState.value.loadingText = translate("retrieving_characters");
                            break;
                        case 6:
                            appState.value.loadingText = translate("validating_characters");
                            break;
                        default:
                            break;
                    }

                    if (loadingDots == 4) loadingDots = 0;
                }, 500);

                setTimeout(function () {
                    fetchNui("setupCharacters");
                }, 2000);

                break;
            case "setupCharacters":
                var newChars: any[] = [];

                for (var i = 0; i < data.characters.length; i++) {
                    newChars[data.characters[i].cid] = data.characters[i];
                }

                appState.value.characters = newChars;

                setTimeout(function () {
                    clearInterval(loadingInterval);
                    loadingProgress = 0;

                    appState.value.loadingText = translate("retrieving_playerdata");
                    appState.value.show.loading = false;
                    appState.value.show.characters = true;

                    fetchNui("removeBlur");
                }, 2000);

                break;
            case "setupCharInfo":
                appState.value.chardata = data.chardata;
                break;
        }
    });
});

function selectCharacter(idx: number) {
    appState.value.selectedCharacter = idx;

    fetchNui(
        "cDataPed",
        appState.value.characters[idx] !== undefined
            ? {
                  cData: appState.value.characters[idx],
              }
            : {}
    );
}

function deleteCharacter() {
    if (appState.value.show.delete == true) {
        appState.value.show.delete = false;
        fetchNui("removeCharacter", {
            citizenid: appState.value.characters[appState.value.selectedCharacter].citizenid,
        });
    } else if (appState.value.show.characters == true && appState.value.show.register == false) {
        appState.value.show.characters = false;
        appState.value.show.delete = true;
    }
}

function playCharacter() {
    if (appState.value.selectedCharacter && appState.value.selectedCharacter !== -1) {
        var data = appState.value.characters[appState.value.selectedCharacter];

        if (data !== undefined) {
            fetchNui("selectCharacter", {
                cData: data,
            }).then(() => {
                appState.value.show.characters = false;
            });
        } else {
            appState.value.show.characters = false;
            appState.value.show.register = true;
        }
    }
}

function translate(phrase: string) {
    return appState.value.translations[phrase] || phrase;
}
</script>

<template>
    <LoadingComponent v-if="appState.show.loading" :loadingText="appState.loadingText" />
    <CharacterListComponent
        :show="appState.show.characters"
        :characterAmount="appState.characterAmount"
        :selectedCharacter="appState.selectedCharacter"
        :allowDelete="appState.allowDelete"
        :characters="appState.characters"
        :translations="appState.translations"
        :selectCharacter="selectCharacter"
        :playCharacter="playCharacter"
        :deleteCharacter="deleteCharacter"
    />

    <CharacterInfoComponent
        :show="appState.show.characters"
        :selectedCharacter="appState.selectedCharacter"
        :dollar="appState.dollar"
        :characters="appState.characters"
        :translations="appState.translations"
    />

    <CharacterRegisterComponent
        v-if="appState.show.register"
        :show="appState.show"
        :customNationality="appState.customNationality"
        :dollar="appState.dollar"
        :translations="appState.translations"
        :selected-character="appState.selectedCharacter"
        :close="
            () => {
                appState.show.register = false;
                appState.show.characters = true;
            }
        "
    />

    <CharacterDeleteComponent
        v-if="appState.show.delete"
        :show="appState.show"
        :characters="appState.characters"
        :selectedCharacter="appState.selectedCharacter"
        :translations="appState.translations"
        :deleteCharacter="deleteCharacter"
        :cancel="
            () => {
                appState.show.delete = false;
                appState.show.characters = true;
            }
        "
    />
</template>
