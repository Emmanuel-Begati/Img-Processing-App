from flask import Flask, request, jsonify
import json

app = Flask(__name__)

@app.route('/process_image', methods=['POST'])
def process_image():
    try:
        # Save the POST data to a file
        with open('post_data.json', 'w') as f:
            json.dump(request.json, f)

        base64_string = request.json.get('base64String', '')

        # Process the base64 string as needed
        # Your processing logic here

        # Prepare the response
        response = {'message': 'Image processed successfully'}

        # Send the response back to MATLAB
        return jsonify(response)
    except Exception as e:
        response = {'error': str(e)}

        return jsonify(response), 500

if __name__ == '__main__':
    app.run(debug=True)