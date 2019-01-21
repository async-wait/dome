import $axios from '../common';
import {
    newMusic,
    personalized,
    privatecontent
} from './config';

export const getNewMusic = $axios.get(newMusic);
export const getPersonalized = $axios.get(personalized);
export const getPrivatecontent = $axios.get(privatecontent);