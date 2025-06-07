

interface Props {
    text: string;
    onClick: () => void;
}

function Btn({ text, onClick }: Props) {
    return (
        <button className="btn btn-primary" onClick={onClick}>
            {text}
        </button>
    );
}

export default Btn;