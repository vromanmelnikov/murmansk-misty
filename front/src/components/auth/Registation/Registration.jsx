import { Link } from 'react-router-dom'
import Styles from '../Auth.module.css'

import { CardBody, CardHeader, Form, FormGroup, Input, Label } from "reactstrap"



const Registration = (props) => {

    return (
        <>
            <CardHeader className={`${Styles.header}`}>
                Регистрация
            </CardHeader>
            <CardBody>
                <Form onSubmit={
                    (event) => {
                        props.submit(event)
                    }
                }>
                    <FormGroup>
                        <Input type='text' placeholder="Почта" name='email'
                            value={props.form.name}
                            onChange={props.onChange} />

                    </FormGroup>
                    <FormGroup>
                        <Input type='password' placeholder="Пароль" name='password'
                            value={props.form.name}
                            onChange={props.onChange} />
                    </FormGroup>
                    {/* <FormGroup>
                        <Input type='password' placeholder="Повторите пароль" name='secondPassword'
                        value={props.form.name}
                        onChange={props.onChange}/>
                    </FormGroup> */}

                    <p>Перейти на страницу <Link to='/auth/login'>авторизации</Link></p>

                    <Input type='submit' value='Зарегистрироваться' />
                </Form>

            </CardBody>
        </>
    )
}

export default Registration