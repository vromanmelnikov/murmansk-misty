import { useNavigate } from "react-router"
import { useState } from "react";
import Registration from "./Registration"
import AuthService from "../../../services/Auth.service";

const RegistrationContainer = (props) => {

    const [form, setForm] = useState({
        email: '',
        password: '',
        secondPassword: '',
    });
    const onChange = (event) => {

        setForm({
            ...form,
            [event.target.name]: event.target.value,

        })


    }

    const navigate = useNavigate()

    const submit = (event) => {

        event.preventDefault()

        AuthService.register(form.email, form.password).then(
            res => {
                navigate('/auth/login')
            }
        )

    }

    const propsData = {
        submit, onChange, form

    }

    return (
        <Registration {...propsData} />
    )
}

export default RegistrationContainer