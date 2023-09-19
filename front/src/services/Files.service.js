import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config"

class FilesService {

    static URL = `${API_CONFIG.PROD_BASE_URL}/files`

    static addFile(file) {

        const url = `${this.URL}`

        const data = new FormData()
        data.append('file', file)

        let config = {
            method: 'post',
            url,
            data
        };

        return axiosInstance.request(config)

    }

}

export default FilesService