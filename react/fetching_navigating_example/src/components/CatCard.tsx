import { Link } from "react-router-dom";
import type { Cat } from "../App";


interface Props {
  cat: Cat,
}


export function CatCard({ cat }: Props) {
  return (
    <div className="card" style={{ width: 200 }} key={cat.id}>
      <img
        className="card-img-top"
        src={cat.url}
        style={{ width: "200px", height: "150px", marginBottom: 8 }}
      ></img>
      <Link className="btn btn-outline-primary" to={`/details/${cat.id}`}>
        See More
      </Link>
    </div>
  );
}
