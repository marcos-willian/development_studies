import Header from "../components/Header";
import  {GetStaticProps} from 'next';
import Image from 'next/image'
import Link from 'next/link'
import { api } from "../services/api";
import {format, parseISO} from 'date-fns';
import ptBR from 'date-fns/locale/pt-BR';
import { convertDurationToTimeString } from "../functions/convertDurationToTimeString";
import styles from "../styles/index.module.scss";
import React, { useContext } from "react";
import { PlayerContext } from "../context/PlayerContext";
 
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
type HomeProps = {
  latestEpisodes: Episode[];
  allEpisodes: Episode[];
}
export default function Home({latestEpisodes, allEpisodes}: HomeProps) {
  const {play} = useContext(PlayerContext);

  return (
    <div className = {styles.homepage}>
      <section className = {styles.latestEpisodes}>

        <h2>Últimos lançamentos</h2>

        <ul >

          {latestEpisodes.map(episode => {
            return (
              <li key={episode.id}>
                <Image width={192} height={192} src={episode.thumbnail} alt={episode.title} objectFit="cover"/>
                <div className = {styles.episodeDetails}>
                    <Link href={`./episode/${episode.id}`}>
                      <a >{episode.title}</a>
                    </Link>
                    <p>{episode.members}</p>
                    <span>{episode.publishedAt}</span>
                    <span>{episode.durationAsString}</span>
                </div>

                <button type="button" onClick = {() => { return play(episode)} }>
                  <img src="/play-green.svg" alt="Tocar episode"/>
                </button>
              </li>
            )
          })}
        </ul>
      </section>
          
      <section>
        <ul className = {styles.allEpisodes}>
          <h2>Todos episódios</h2>
          <table cellSpacing ={0}>
            <thead>
              <tr>
                <th></th>
                <th>Podcast</th>
                <th>Integrantes</th>
                <th>Data</th>
                <th>Duração</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {allEpisodes.map(episode =>{
                return(
                  <tr key={episode.id}>
                    <td style={{width:72}}>
                      <Image 
                        width={120} 
                        height={120} 
                        src={episode.thumbnail} 
                        alt={episode.title} 
                        objectFit="cover"
                      />
                    </td>
                    <td>
                      <Link href={`./episode/${episode.id}`}>
                        <a >{episode.title}</a>
                      </Link>
                    </td>
                    <td>
                      {episode.members}
                    </td>
                    <td style={{width:100}}>
                      {episode.publishedAt}
                    </td>
                    <td>
                      {episode.durationAsString}
                    </td>
                    <td>
                      <button type="button" onClick = {() => { return play(episode)}} >
                       <img src="/play-green.svg" alt="Tocar episode"/>
                      </button>
                    </td>
                  </tr>
                )
              })}
            </tbody>

          </table>
        </ul>
      </section>
    </div>
    
  )
}

export const getStaticProps: GetStaticProps = async () => {
  const {data} = await api.get('episodes', {
    params:{
      _limit: 12,
      _sort: 'publisher_at',
      _order: 'desc'
    }
  });

  const episodes = data.map(episodeData => {
    return{
      id: episodeData.id,
      title: episodeData.title,
      members: episodeData.members,
      publishedAt: format(parseISO(episodeData.published_at), 'd MMM yy', {locale: ptBR}),
      thumbnail: episodeData.thumbnail,
      description: episodeData.description,
      duration: Number(episodeData.file.duration),
      durationAsString: convertDurationToTimeString(Number(episodeData.file.duration)),
      url: episodeData.file.url
    }
  })
  const latestEpisodes = episodes.slice(0,2);
  const allEpisodes = episodes.slice(2,12);


  return{
    props:{
      latestEpisodes,
      allEpisodes
    },
    
    
  }
}
