<script setup lang="ts">
import "@/style/components/CharacterListComponent.css";

defineProps<{
    show: boolean;
    translations: Record<string, any>;
    characterAmount: number;
    characters: any[];
    selectedCharacter: number;
    allowDelete: boolean;

    selectCharacter: (index: number) => void;
    playCharacter: () => void;
    deleteCharacter: () => void;
}>();
</script>

<template>
    <div
        class="character-list"
        :class="{
            'slide-fade-leave-active': show == false,
            'slide-center-left-fade-leave-to': show == false,
        }"
    >
        <div class="header">
            <p>{{ translations["characters_header"] }}</p>
        </div>
        <div class="list">
            <template v-for="index in characterAmount">
                <div
                    v-if="characters[index] == undefined"
                    class="item"
                    v-ripple
                    :class="{ 'selected': selectedCharacter == index }"
                    data-cid=""
                    @click="selectCharacter(index)"
                    :key="index"
                >
                    <span class="name">{{ translations["emptyslot"] }} </span>
                    <span class="cid"></span>
                </div>
                <div
                    v-if="characters[index] !== undefined"
                    class="item"
                    v-ripple
                    :class="{ 'selected': selectedCharacter == index }"
                    :data-citizenid="characters[index].citizenid"
                    @click="selectCharacter(index)"
                    :key="index"
                >
                    <span class="name">
                        {{ characters[index].charinfo.firstname }}
                        {{ characters[index].charinfo.lastname }}
                    </span>
                    <span class="cid">{{ characters[index].citizenid }}</span>
                </div>
            </template>
        </div>
        <div class="buttons" v-if="selectedCharacter !== -1">
            <v-btn large class="btn play" v-ripple @click="playCharacter()">
                {{
                    characters[selectedCharacter] !== undefined
                        ? translations["play_button"]
                        : translations["create_button"]
                }}
            </v-btn>
            <v-btn
                large
                class="btn delete"
                v-if="
                    characters[selectedCharacter] !== undefined &&
                    allowDelete == true
                "
                v-ripple
                @click="deleteCharacter()"
            >
                {{ translations["delete_button"] }}
            </v-btn>
        </div>
    </div>
</template>
