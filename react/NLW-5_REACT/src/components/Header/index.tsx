import styles from  './styles.module.scss'

import formatDate from 'date-fns/format'
import ptBR from 'date-fns/locale/pt-BR'

export default function Header() {
    const  currentDate = formatDate(new  Date(), 'EEEEEE, d MMMM', {locale: ptBR});
    return(
        <header className={styles.headerContainer}>
            <img src="/logo.svg" alt="Logo Podcastr"/>
            <p>O melhor  para você ouvir, sempre...</p>
            <span>{currentDate}</span>
        </header>
    );
}