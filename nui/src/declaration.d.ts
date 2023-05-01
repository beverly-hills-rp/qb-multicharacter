declare module "@/assets/countries.json" {
    export type Country = {
        iso2: string;
        iso3: string;
        country: string;
        cities: string[];
    };

    const countries: Country[];
    export default countries;
}

declare module "@/assets/profanity.json" {
    const profanities: string[];
    export default profanities;
}
