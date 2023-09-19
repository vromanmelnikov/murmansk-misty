import Login from "./Login"
import { useNavigate } from "react-router"
import { useState } from "react";
import AuthService from "../../../services/Auth.service";
import JWTService from "../../../services/JWT.service";

const LoginContainer = (props) => {

    const [form, setForm] = useState({
        email: '',
        password: '',
    });
    const [corpasswrod, setCorpassword] = useState({
        email: '123',
        password: '456'
    })

    const onChange = (event) => {
        const value = event.target.value
        const name = event.target.name
        setForm({
            ...form,
            [name]: value,
        })
    }

    const navigate = useNavigate()

    const submit = (event) => {

        event.preventDefault()
        const email = form.email
        const password = form.password

        AuthService.signIn(email, password).then(
            (res) => {
                const data = res.data
                JWTService.setTokens(data)
                navigate('/profile')
            }
        )
    }

    const propsData = {
        submit, onChange, form
    }
    return (
        <Login {...propsData} />
    )
}

export default LoginContainer