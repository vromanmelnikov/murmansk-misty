import { Form, FormGroup, Input } from 'reactstrap'
import Styles from './PersonalInfo.module.css'

const PersonalInfo = (props) => {

    return (
        <Form className={`${Styles.form}`} onSubmit={event => props.onSubmit(event)}>
            <FormGroup className={`${Styles.nameFields}`}>
                <Input onChange={(event) => props.onChange(event)} id='lastname' type='text' placeholder='Фамилия' value={props.user.lastname} />
                <Input onChange={(event) => props.onChange(event)} id='firstname' type='text' placeholder='Имя' value={props.user.firstname} />
                <Input onChange={(event) => props.onChange(event)} id='patronymic' type='text' placeholder='Отчество' value={props.user.patronymic} />
            </FormGroup>
            <Input onChange={(event) => props.onChange(event)} id='birthdate' type='date' value={props.user.birthdate} />
            <Input className={`${Styles.btn}`} type='submit' />
        </Form>
    )

}

export default PersonalInfo