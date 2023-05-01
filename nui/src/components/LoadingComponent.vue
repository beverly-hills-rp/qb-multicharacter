<script setup lang="ts">
import "@/style/components/LoadingComponent.css";

defineProps<{
    loadingText: string;
}>();
</script>

<template>
    <div class="loading-container">
        <div class="loading-circle">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
        <p>{{ loadingText }}</p>
    </div>
</template>
