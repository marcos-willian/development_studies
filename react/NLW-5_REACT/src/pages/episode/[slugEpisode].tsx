import {format, parseISO} from 'date-fns';
import ptBR from 'date-fns/locale/pt-BR';
import { convertDurationToTimeString } from "../../functions/convertDurationToTimeString";
import { GetStaticPaths, GetStaticProps } from "next";
import { api } from "../../services/api";
import styles from "../../styles/episode.module.scss"
import Image from 'next/image'
import Link from 'next/link'
import { useContext } from 'react';
import { PlayerContext } from '../../context/PlayerContext';

type Episode  = {
    id: string;
    title: string;
    members: string;
    publishedAt: string;
    thumbnail: string;
    description: string;
    duration: number;
    durationAsString: string;
    url: string;
}

type EpisodeProps ={
    episode: Episode;
}

export default function Episode ({episode} : EpisodeProps) {
    const {play} = useContext(PlayerContext);
    return(
        <div className={styles.episode}>
            <div className={styles.episodeContent}>
                <div className={styles.thumbnailContainer}>
                    <Link href="/">
                        <button type="button"><img src="/arrow-left.svg" alt="Voltar"/></button>
                    </Link>
                    <Image 
                        width={700} 
                        height={300} 
                        src={episode.thumbnail} 
                        alt={episode.title} 
                        objectFit="cover"
                    />
                    <button type="button"><img src="/play.svg" alt="Tocar episódio" onClick = {() => play(episode)}/></button>
                </div>
                <header>
                    <h1>{episode.title}</h1>
                    <span>{episode.members}</span>
                    <span>{episode.publishedAt}</span>
                    <span>{episode.durationAsString}</span>
                </header>
                <div 
                    className={styles.description}
                    dangerouslySetInnerHTML={{__html: episode.description}} 
                />
            </div>
        </div>
    );
}
export const getStaticPaths: GetStaticPaths = async () => {
    const {data} = await api.get('episodes', {
        params:{
          _limit: 2,
          _sort: 'publisher_at',
          _order: 'desc'
        }
    });
    const paths = data.map(episode =>{
        return({
            params:{
                slugEpisode: episode.id,
            }
        })
    });
    return({
        paths,
        fallback: "blocking",
    })
}

export const  getStaticProps: GetStaticProps = async (ctx) =>{
    const {slugEpisode} = ctx.params;
    const {data} = await api.get(`episodes/${slugEpisode}`)
    const episode = {
        id: data.id,
        title: data.title,
        members: data.members,
        publishedAt: format(parseISO(data.published_at), 'd MMM yy', {locale: ptBR}),
        thumbnail: data.thumbnail,
        description: data.description,
        duration: Number(data.file.duration),
        durationAsString: convertDurationToTimeString(Number(data.file.duration)),
        url: data.file.url
    }
  
    return{
      props:{
        episode,
      },
      revalidate: 60*60*24, //* 24 horas é revalidadoS
    }

}