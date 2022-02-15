# Olympics data 
This project downloads 120 years of Olympics data from [this Kaggle dataset](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results) and transform it to a simple [GoodData.CN](https://www.gooddata.com/developers/cloud-native?utm_source=mediumcom&utm_medium=referral&utm_campaign=gdcn&utm_content=zd-dbd) semantic data model.  

![Olympics semantic data model](https://raw.githubusercontent.com/zsvoboda/olympics/main/img/pdm.png)

Data are loaded to Postgres database that is part of GoodData.CN Docker image. This project contains declarative definitions of GoodData metrics, insights, and dashboards that you can import to your local GoodData.CN Docker container. 

You'll get this initial Olympics dashboard out of the box. 

![COVID CZ Dashboard](https://raw.githubusercontent.com/zsvoboda/olympics/main/img/olympics.dashboard.png)

Then you can create your own data visualizations and interactive dashboards using the GoodData.CN analytics tools. You should be able to have everything up and running in less than 15 minutes. 

# Installation steps

1. Install GoodData.CN Community Edition to your computer:

`docker pull gooddata/gooddata-cn-ce`

2. Install [dbd](https://github.com/zsvoboda/dbd) to your computer (make sure that you have Python 3.8+ installed)

```shell
python3 -m venv dbd-env
source dbd-env/bin/activate
pip3 install dbd
```

3. Install [Visual Studio Code](https://code.visualstudio.com) on your computer

Install [REST Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client). You'll use it for convenient GoodData.CM API invocation. 

4. Start GoodData.CN Community Edition

`docker run -t -i -p 3000:3000 -p 5432:5432 --name gd gooddata/gooddata-cn-ce`

Answer 'yes' when prompted. 

5. The olympics data are stored on Kaggle. You'll neet to setup Kaggle account authentication. Modify the `KAGGLE_USERNAME` and `KAGGLE_KEY` environment variables in   the `bin/env.sh` (Linux and MacOS) or `bin\env.bat` scripts. 

To use the Kaggle API, sign up for a Kaggle account at https://www.kaggle.com. Then go to the 'Account' tab  of your user profile (`https://www.kaggle.com/<username>/account`) and select 'Create API Token'. This will trigger the download of kaggle.json, a file containing your API credentials. The file looks like this: 

```json
{"username": "<kaggle-username>", "key": "<kaggle-key>"}
```

Set the `KAGGLE_USERNAME` and `KAGGLE_KEY` environment variables in the `bin/env.sh` or `bin\env.bat` script to to the `<kaggle-username>` and `<kaggle-key>` values. 

**NOTE:** You can double-quote (`"`) these values on Linux or MacOS, but don't quote them on Windows. 

6. Download the Olympics data to Postgres that runs in the GoodData.CN container

```shell
cd etl 
dbd run .
```

7. Open the project in the Visual Studio Code editor

`code .`

8. Load `workspace.code-workspace` file in VSCode (press blue botton in the bottom right area of the file editor)

VSCode shouls reload.

9. Open the `api/rest.http`

Make sure that your environment is set to `GoodData.CN CE` in the bottom right status bar listbox of the VSCode editor. 

10. Create database connection

Find the `# @name createDataSource` on line 11 and click on the small link `Send Request` between line 2 and 3

Sometimes I must click the `Send Request` link twice. Not sure why. I hope that you don't have the same issue. 

11. Create physical data model

Find the `# @name storePhysicalModel` on line 31 and click on the small link `Send Request` between line 22 and 23

Again, you may need to `Send Request` link twice.

12. Create workspace

Find the `# @name createWorkspace` on line 36 and click on the small link `Send Request` between line 36 and 37

13. Create semantic model 

Find the `# @name publishSemanticModel` on line 62 and click on the small link `Send Request` between line 62 and 63

14. Create analytical objects (dashboards, insights, and metrics) 

Find the `# @name createAnalyticsModelObjects` on line 76 and click on the small link `Send Request` between line 76 and 77

15. ENJOY the Olympics analytics at [localhost:3000](http://localhost:3000/)

Username is `demo@example.com`, password `demo123`.

There are quite a few courses on GoodData University. You can talk to us on our Slack community if you have a question or run into issues. Visit University and community on [GoodData website](https://www.gooddata.com/learn/?utm_source=mediumcom&utm_medium=referral&utm_campaign=gdcn&utm_content=zd-dbd) if you need a jumpstart. 
