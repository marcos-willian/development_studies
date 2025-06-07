import { useState } from "react";
import Alert from "./components/Alert";
import Btn from "./components/btn";

function App() {
  const [showAlert, setShowAlert] = useState(false);

  return (
    <>
      <Btn text="Click me" onClick={() => setShowAlert(true)} />
      {showAlert && (
        <Alert onClose={() => setShowAlert(false)}>
          <strong>Success!</strong> You clicked the button.
        </Alert>
      )}
    </>
  );
}

export default App;
