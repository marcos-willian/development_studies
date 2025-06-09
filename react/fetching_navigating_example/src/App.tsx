import { useEffect, useState } from 'react';
import axios from 'axios';
import { CatCard } from './components/CatCard';

export type Cat = {
  readonly id: string,
  url: string,
};

function App() {
  const [cats, setCats] = useState<Cat[]>([]);
  document.title = "Home";

  useEffect(() => {
    axios
      .get('https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=20&include_breeds=1',
      )
      .then(res => setCats(res.data))
  }, []);

  return (
    <>
      <h1 className='text-center'>Cats Book list</h1>
      <div className='container text-center'>
        <div className='row'>
          {cats.map(cat =>
            <div className='col-3' key={cat.id} style={{ marginBottom: 10 }}><CatCard cat={cat} /></div>
          )}
        </div>
      </div>
    </>
  )
}

export default App
