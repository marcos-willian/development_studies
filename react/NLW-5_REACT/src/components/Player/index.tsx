import { PlayerContext } from '../../context/PlayerContext';
import styles from  './styles.module.scss';
import {useContext, useEffect, useRef} from 'react';
import Image from 'next/image';
import Slider from 'rc-slider';
import 'rc-slider/assets/index.css'
export default function Player() {
    const {episodeList, currentEpisode, isPlaying, setPlay} = useContext(PlayerContext);
    const episode = episodeList[currentEpisode];
    const audioRef =  useRef <HTMLAudioElement>(null);

    useEffect(() => {
        if (!audioRef.current){
            return
        }

        if(isPlaying){
            audioRef.current.play();
        }
        else{
            audioRef.current.pause();
        }

    }, [isPlaying]);
    
    return(
        <div className={styles.playerContainer}>
            <header>
                <img src="/playing.svg" alt="Tocando agora"/>
                <strong>Tocando agora.</strong>
            </header>
            {episode ? (
                <div className={styles.currentEpisode}>
                    <Image
                        width = {592}
                        height = {592}
                        src = {episode.thumbnail}
                        objectFit="cover"
                    />
                    <strong>{episode.title}</strong>
                    <span>{episode.members}</span>
                </div>
            ) : (
                <div className={styles.emptyPlayer}>
                    <strong>Selecione um podcast para ouvir</strong>
                </div>
            )}
            <footer className={styles.empty}>
                <div className={styles.progress}>
                    <span>00:00</span>
                    <div className={styles.Slider}>
                        {episode ? (
                            <div>
                                <Slider
                                    trackStyle={{backgroundColor: '#04d361'}}
                                    railStyle={{backgroundColor: '#9f75ff'}}
                                    handleStyle = {{borderColor: '#04d361', borderWidth: 4}}
                                />
                                <audio
                                    src = {episode.url}
                                    autoPlay
                                    ref = {audioRef}
                                    onPlay = {() => {return setPlay(true);}}
                                    onPause = {() => {return setPlay(false);}}
                                />
                            </div>
                        ) : (
                            <div className={styles.emptySlider}/>
                        )}
                    </div>
                    <span>00:00</span>
                </div>
                <div className={styles.buttons}>
                    <button type="button" disabled={!episode}>
                        <img src="/shuffle.svg" alt="Embaralhar"/>
                    </button>
                    <button type="button" disabled={!episode}>
                        <img src="/play-previous.svg" alt="Tocar anterior"/>
                    </button>
                    <button type="button" className={styles.playButton} disabled={!episode} onClick = { () => {return setPlay(!isPlaying)}}>
                        <img src={isPlaying ? ("/pause.svg") : ("/play.svg")} alt="Tocar"/>
                    </button> 
                    <button type="button" disabled={!episode}>
                        <img src="/play-next.svg" alt="Tocar o próximo"/>
                    </button>
                    <button type="button" disabled={!episode}>
                        <img src="/repeat.svg" alt="Repetir"/>
                    </button>
                </div>
            </footer>
        </div>
    );
}