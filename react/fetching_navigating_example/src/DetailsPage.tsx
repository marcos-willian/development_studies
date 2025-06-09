import axios from "axios";
import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
interface Cat {
    id: string;
    url: string;
    breeds: Breed[];
    width: number;
    height: number;
}

interface Breed {
    weight: Weight;
    id: string;
    name: string;
    cfa_url?: string;
    vetstreet_url?: string;
    vcahospitals_url?: string;
    temperament: string;
    origin: string;
    country_codes: string;
    country_code: string;
    description: string;
    life_span: string;
    indoor: number;
    lap?: number;
    alt_names: string;
    adaptability: number;
    affection_level: number;
    child_friendly: number;
    dog_friendly: number;
    energy_level: number;
    grooming: number;
    health_issues: number;
    intelligence: number;
    shedding_level: number;
    social_needs: number;
    stranger_friendly: number;
    vocalisation: number;
    experimental: number;
    hairless: number;
    natural: number;
    rare: number;
    rex: number;
    suppressed_tail: number;
    short_legs: number;
    wikipedia_url?: string;
    hypoallergenic: number;
    reference_image_id: string;
}

interface Weight {
    imperial: string;
    metric: string;
}


export function DetailsPage() {
    const params = useParams<{ catId: string }>();
    const [catInfo, setCatInfo] = useState<Cat>();

    useEffect(() => {
        axios
            .get(`https://api.thecatapi.com/v1/images/${params.catId}`)
            .then(({ data }) => setCatInfo(data))
    }, []);

    return (
        <>
            <h1>Breed: {catInfo?.breeds[0].name}</h1>
            <p>{catInfo?.breeds[0].description}</p>
            <Link to={catInfo?.breeds[0].wikipedia_url ?? ""}>Wikipedia</Link><p></p>
            <Link className="btn btn-primary" to={'/'}>Back</Link>
            <img src={catInfo?.url}></img>
        </>
    );
}