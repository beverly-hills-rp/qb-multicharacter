<script setup lang="ts">
import "@/style/components/CharacterInfoComponent.css";

defineProps<{
    show: boolean;
    translations: Record<string, any>;
    characters: any[];
    selectedCharacter: number;
    dollar: Intl.NumberFormat;
}>();
</script>

<template>
    <div
        class="character-info"
        :class="{
            'slide-top-right-fade-leave-active': show == false,
            'slide-top-right-fade-leave-to': show == false,
        }"
    >
        <span class="char-info-header">{{ translations["charinfo_header"] }}</span>
        <span class="no-char" v-if="characters[selectedCharacter] == undefined">{{
            translations["charinfo_description"]
        }}</span>
        <table v-if="characters[selectedCharacter] !== undefined">
            <tr>
                <td>{{ translations["name"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].charinfo.firstname }}
                    {{ characters[selectedCharacter].charinfo.lastname }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["birthdate"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].charinfo.birthdate }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["gender"] }}:</td>
                <td>
                    {{
                        characters[selectedCharacter].charinfo.gender == 0
                            ? translations["male"]
                            : translations["female"]
                    }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["nationality"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].charinfo.nationality }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["job"] }}:</td>
                <td>{{ characters[selectedCharacter].job.label }}</td>
            </tr>
            <tr>
                <td>{{ translations["jobgrade"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].job.grade.name }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["cash"] }}:</td>
                <td>
                    &#36;
                    {{ dollar.format(characters[selectedCharacter].money.cash) }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["bank"] }}:</td>
                <td>
                    &#36;
                    {{ dollar.format(characters[selectedCharacter].money.bank) }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["phonenumber"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].charinfo.phone }}
                </td>
            </tr>
            <tr>
                <td>{{ translations["accountnumber"] }}:</td>
                <td>
                    {{ characters[selectedCharacter].charinfo.account }}
                </td>
            </tr>
        </table>
    </div>
</template>
