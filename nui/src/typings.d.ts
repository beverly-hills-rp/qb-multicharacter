// typings.d.ts

declare interface RegisterData {
    date: string;
    firstname?: string;
    lastname?: string;
    nationality?: string;
    gender?: string;
}

declare interface ShowState {
    loading: boolean;
    characters: boolean;
    register: boolean;
    delete: boolean;
}

export declare interface AppState {
    characters: any[];
    chardata: Record<string, any>;
    show: ShowState;
    allowDelete: boolean;
    dataPickerMenu: boolean;
    characterAmount: number;
    loadingText: string;
    selectedCharacter: number;
    dollar: Intl.NumberFormat;
    translations: Record<string, any>;
    customNationality: boolean;
}
