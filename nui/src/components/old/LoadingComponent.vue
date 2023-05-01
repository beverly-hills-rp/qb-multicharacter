<script setup lang="ts">

defineProps<{
    show: boolean;
    loadingText: string;
}>();

</script>

<template>
    <div class="welcomescreen" v-show="show">
        <div class="loading-container">
            <div class="loading-circle">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>
            <p>{{ loadingText }}</p>
        </div>
    </div>
</template>
