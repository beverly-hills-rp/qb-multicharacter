<script setup lang="ts">
import type { ShowState } from "@/typings";

defineProps<{
    show: ShowState;
    translations: Record<string, any>;
    deleteCharacter: () => void;
    cancel: () => void;
}>();
</script>

<template>
    <div
        class="character-delete"
        :class="{
            'slide-top-fade-leave-active': show.delete == false,
            'slide-top-fade-leave-to': show.delete == false,
        }"
    >
        <p class="characters-delete-block-header">
            {{ translations["deletechar_header"] }}
        </p>

        <p>{{ translations["deletechar_description"] }}</p>

        <div class="character-delete-btns">
            <v-btn
                :disabled="!show.delete"
                color="#2f8643"
                v-ripple
                class="character-delete-btn"
                @click="deleteCharacter()"
                >{{ translations["confirm"] }}</v-btn
            >
            <v-btn
                :disabled="!show.delete"
                color="#90293e"
                v-ripple
                class="character-delete-btn"
                @click="cancel()"
                >{{ translations["cancel"] }}</v-btn
            >
        </div>
    </div>
</template>
