<script setup lang="ts">
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
        class="characters-list"
        :class="{
            'slide-top-left-fade-leave-active': show == false,
            'slide-top-left-fade-leave-to': show == false,
        }"
    >
        <div class="character-list-header">
            <p>{{ translations["characters_header"] }}</p>
        </div>
        <div class="characters">
            <template v-for="index in characterAmount">
                <div
                    v-if="characters[index] == undefined"
                    class="character"
                    v-ripple
                    :class="{ 'char-selected': selectedCharacter == index }"
                    data-cid=""
                    @click="selectCharacter(index)"
                    :key="index"
                >
                    <span class="slot-name">{{ translations["emptyslot"] }} </span>
                    <span class="cid"></span>
                </div>
                <div
                    v-if="characters[index] !== undefined"
                    class="character"
                    v-ripple
                    :class="{ 'char-selected': selectedCharacter == index }"
                    :data-citizenid="characters[index].citizenid"
                    @click="selectCharacter(index)"
                    :key="index"
                >
                    <span class="slot-name">
                        {{ characters[index].charinfo.firstname }}
                        {{ characters[index].charinfo.lastname }}
                    </span>
                    <span class="cid">{{ characters[index].citizenid }}</span>
                </div>
            </template>
        </div>
        <div class="character-btns" v-if="selectedCharacter !== -1">
            <v-btn large class="character-btn" id="play" v-ripple @click="playCharacter()">
                {{
                    characters[selectedCharacter] !== undefined
                        ? translations["play_button"]
                        : translations["create_button"]
                }}
            </v-btn>
            <v-btn
                large
                class="character-btn"
                id="delete"
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
