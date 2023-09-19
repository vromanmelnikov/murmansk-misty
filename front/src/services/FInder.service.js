import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config";

class FinderService {

    static URL = `${API_CONFIG.PROD_AI_URL}`
 
    static findProducts (text) {

        const url = `${this.URL}/find_products`

        const data = {
            text
        }

        let config = {
            method: 'post',
            url,
            data
        };

        return axiosInstance.request(config)

    }

}

export default FinderService