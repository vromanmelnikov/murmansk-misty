import { Link } from 'react-router-dom'
import Styles from '../Auth.module.css'

import { CardBody, CardHeader, Form, FormGroup, Input, Label, Alert } from "reactstrap"

const Login = (props) => {

    return (
        <>

            <CardHeader className={`${Styles.header}`}>
                Авторизация
            </CardHeader>

            <CardBody>
                <Form onSubmit={
                    (event) => {
                        props.submit(event)
                        console.log(event)
                    }
                    
                }>
                    
                    <FormGroup>
                        <Input type='text' placeholder="Почта" name='email'
                            id="email"
                            value={props.form.name}
                            onChange={props.onChange}
                        />

                    </FormGroup>
                    <FormGroup>
                        <Input type='password' placeholder="Пароль" name='password'
                            value={props.form.name}
                            onChange={props.onChange} />
                    </FormGroup>

                    <p>Перейти на страницу <Link to='/auth/registration'>регистрации</Link></p>

                    <Input type='submit' value='Авторизоваться' />
                    
                </Form>
            </CardBody>

        </>
    )
}

export default Login