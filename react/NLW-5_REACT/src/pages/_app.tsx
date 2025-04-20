import Header from '../components/Header'
import Player from '../components/Player'

import '../styles/global.scss'
import styles from '../styles/app.module.scss'
import { PlayerContext } from '../context/PlayerContext';
import { useState } from 'react';

function MyApp({ Component, pageProps }) {
  const [episodeList, setEpisodeList] = useState([]);
  const [currentEpisode, setCurrentEpisode] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);

  function play (episode) {
    setEpisodeList([episode]);
    setCurrentEpisode(0);
    setIsPlaying(true);
  }

  function setPlay(state: boolean) {
    setIsPlaying(state);
  }

  return (
    <PlayerContext.Provider value={{episodeList, currentEpisode, isPlaying, play, setPlay}}>
      <div className={styles.limit}>
        <main >
          <Header/>
          <Component {...pageProps} />
        </main>
        <Player/>
      </div>
    </PlayerContext.Provider>
    );
}

export default MyApp
