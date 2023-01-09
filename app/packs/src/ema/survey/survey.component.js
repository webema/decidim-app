import Cookies from "js-cookie";

import { iframeResize } from "iframe-resizer"

$(document).ready(async function() {
  await new Promise(r => setTimeout(r, 2000));
  var surveyModal = $('#emaSurveyModal')
  var modal = document.getElementById('emaSurveyModal')

  if (surveyModal.length) {

    var survey = new Foundation.Reveal(surveyModal);
    survey.open();

    const iframe = modal.querySelector('iframe');
    const loadingIndicator = modal.querySelector('.loading-indicator');

    $(iframe).hide();

    iframe.onload = function() {
      $(loadingIndicator).hide();
      $(iframe).show();
      iframeResize({}, iframe);
    };
  }
})

window.onmessage = function(event){
  if (event.data == 'survey-success') {
    var iframeContainer = $('#emaSurveyIframeContainer');
    var outro = $('#emaSurveyOutro');
    var survey = document.getElementById('emaSurveyModal');

    addToAnsweredSurveys(survey);
    iframeContainer.hide();
    outro.show()
  }
};

$(document).on('closed.zf.reveal', '#emaSurveyModal', function() {
  addToAnsweredSurveys(this);
});

function addToAnsweredSurveys(survey) {
  const surveyId = survey.getAttribute('data-survey-id');
  var answeredSurveys = new Set(JSON.parse(Cookies.get('decidim-answered-surveys') || JSON.stringify([])));
  answeredSurveys.add(surveyId);
  Cookies.set('decidim-answered-surveys', JSON.stringify(Array.from(answeredSurveys)), { domain: 'localhost', expires: 365 });
}
