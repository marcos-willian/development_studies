import axios from 'axios';

export const api = axios.create({
        baseURL: 'http://http://node67880-podcastr.jelastic.saveincloud.net/db/episodes/episodes'
})