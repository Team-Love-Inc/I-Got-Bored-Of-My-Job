using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ProgressBar : MonoBehaviour
{
    [SerializeField]
    private Image ProgressImage;
    [SerializeField]
    private float DefaultSpeed = 1f;
    [SerializeField]
    private TextMeshProUGUI progressValue;

    private Coroutine AnimationCoroutine;

    public void reset(float value = 0.5f)
    {
        if (AnimationCoroutine != null)
        {
            StopCoroutine(AnimationCoroutine);
        }
        setBarFillAmount(value);
    }

    // Assume value between 0 and 100 as 0% to 100%.
    public void setProgress(int value)
    {
        value = value < 0 ? 0 : value > 100 ? 100 : value;
        setProgress((float)value / 100);
    }
 
    public void setProgress(float progress)
    {
        if (progress < 0 || progress > 1)
        {
            progress = Mathf.Clamp01(progress);
        }

        if (progress != ProgressImage.fillAmount)
        {
            if (AnimationCoroutine != null)
            {
                StopCoroutine(AnimationCoroutine);
            }

            AnimationCoroutine = StartCoroutine(AnimateProgress(progress, DefaultSpeed));
        }
    }

    public bool setCountDown(string time, float startValue = 1f)
    {
        if (!float.TryParse(time, out float interval))
        {
            Debug.Log("ProgressBar - countDown: Numeric conversion of " + time + " failed.");
            return false;
        }
        return setCountDown(interval, startValue);
    }

    public bool setCountDown(float time, float startValue = 1f)
    {
        time = time < 0 ? 0f : time;
        if(startValue > 0)
        {
            setBarFillAmount(startValue);
        }

        if (AnimationCoroutine != null)
        {
            StopCoroutine(AnimationCoroutine);
        }

        AnimationCoroutine = StartCoroutine(AnimateProgress(0f, 1/time));

        return true;
    }

    private IEnumerator AnimateProgress(float Progress, float Speed)
    {
        float time = 0;
        float initialProgress = ProgressImage.fillAmount;

        while (time < 1)
        {
            setBarFillAmount(Mathf.Lerp(initialProgress, Progress, time));
            time += Time.deltaTime * Speed;
            yield return null;
        }

        setBarFillAmount(Progress);
    }

    private void setBarFillAmount(float amount)
    {
        ProgressImage.fillAmount = amount;
        if(progressValue != null)
        {
            progressValue.text = ((int)(amount * 100)).ToString();
        }
    }
}
