export function convertDurationToTimeString(duration: number): string {
    const hour = Math.floor(duration/3600);
    const minutes = Math.floor((duration%3600)/60);
    const seconds = duration % 60;
    return String(hour).padStart(2,'0') + ':' + String(minutes).padStart(2,'0') + ':' + String(seconds).padStart(2,'0')
}