import $axios from '../common';
import {
    newMusic,
    personalized
} from './config';

export const getNewMusic = $axios.get(newMusic);
export const getPersonalized = $axios.get(personalized);