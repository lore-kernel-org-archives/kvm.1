Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1438D40D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941896; cv=none; b=JSB0R90uAdOq177cotq36TecjZyrj/IPMfidnFBT/sMrD9f2JLCDqAse2tUTS9pGyJIbk+UhZVhsphZaXt88zeV0/bVmQf0WrfVtk7O5ONfRV/Ay3yT9iwVqOC6X+wcrDIHJLlopixANTXtHaAnE0DKt4vq92szyB3E4svBmTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941896; c=relaxed/simple;
	bh=XxDkK1CzYWk3XE0fHq7AAip4FpbUukMZ9P+K7DjIAuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbEVo2AAPCJnKRrNA9KNsZJ3rPOXjAJotGNYx5uOnYUOQWOJbLMybMGPOYVm4pk/ft4RH4u54/zsJCNPxEMn0VTZ3ixtKDOY6qPs/rty/4D4aj1x/6q0wsAF1QlvQSh9VKPu2kv/uz6UNc8hVbYq5RbWSL7iGQ8U2D8LLzJL2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwLm4/Ro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBDFX7Zy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwLm4/Ro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBDFX7Zy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DAsvpt731611
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=; b=PwLm4/Ro/AC9Tuc3
	0BUB2GXzAuhaeIOibPLWrwzqsotbqoExj1cGGurRnHw2Zul/i/PhwiT9yyVVfWdP
	LW5uhUpz298Xp0fsBwrcAM5hM4OnRG9ZMSPwUrcXvtgW7qvixHNwwS+AmH4zVLzy
	IE36LohwLOm91nqsNpn3MurMpGZWaASeYu3e5cDUMiA4LNoj5KWB2Tt9iEUo1AVe
	7ZgsfGhQMvytWklcQbL/3G20A5QO4WKG0tWoZQSCXwM4h/QEt/oW3ZqGGnW0e2I5
	Gw/gnYjtwD1UX6sJKTjZRSymgdE2tXxZ7wum+h1swRDoVzyvlEWYd/T+H0qG5hH6
	F2MW2w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3a84c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:24:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90410c668adso39301766d6.1
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941893; x=1784546693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=;
        b=LBDFX7Zyd/IqEqo7mMWMfyNtyGCaWvyhi9zjxLLRV7g+rZ1cu/BE2SrRk/w3JH/K13
         rjvut/GSWSHouKpnqPQhL7QMEYaGjHAuM+U0LSKNyE3bTkSC/ESX1PTYCgmj/O390cqn
         8RgJt+Ph+KZL6YAF7hPKyZ4rzxQtXDxTDOVrIUSaLQbVwGsIoib0+CI0YhKEAEyXhCnh
         qleBhQJv6P0/CmaEgu7NcoYEbgO/l11cT5wIwrMVDf56lgg2ic/8oYeJFJdSNvxk6x37
         K03L8ywxJKHKMIMdo87/Tb7XOGdHpGP8bvgACArAV4DK8BGvH3cF5v6tRopR8PQhDI7s
         9baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941893; x=1784546693;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=;
        b=FpcMAixss4H3a4Wsx1VPA+uJlX1u3KDeTyyTyzRWdowYjnvJbnHFm8g3GF16L8W0Q7
         IxGEo8QTNe5j24UYa5JbYLV8JxtpwISfGmTAWv5Jjd5K09X22bRsJ593t67ZcFFigjyW
         dFM7Sg3hGkwEbwp402bQ1l66Ccp8dCRS/PklvPmSQTXfK8LAp17E4x0aqew/RJ1Ueh7y
         ku+XV+EyolWCMuZdz2Vqqbe2OZL51zYHoOQgVeSzEPnPj82OS/4VBRa7BxWLZZ9zEcAO
         SO9QMRUVOOSjNwQXXvgvK3iflkz+C0VFyJ+9rm7YooIt8djwOXoQL6XkN420pDLEG8IC
         0kDw==
X-Forwarded-Encrypted: i=1; AHgh+RrRUJLJ6K+uID5K0pRM57oI+rmOEHetJlS1L9BrMtML/F/A+jmvlZ4t3N4BDSZbUqNRjVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkpbREinTEGOSjwMnDE/LzTkmEq8IY4kKZ4xUrjccIARECtW+
	ynqxkCp0LAd65XZskDCZ01WI9Y44B1++48atHBIC7a+7tTmZORJWe6c3qBNxBLiKjyuh1flxfIO
	qHQCJl5OH19+SLvlmufD7/9Yswptaywo3MbiE1azQNoP+PqyEEuT6WP4=
X-Gm-Gg: AfdE7cmdEd6qaBfcynApXh0bL22V2igXVFlPlHCHiBPuJ5Q3WhFVpnVHjaxUNsH30ji
	nVAd4pSYgSXym7fgQLaGGy1vk72W/c74YkZh/OKPhq5ziwue15yJedGGwnIgV0W4DZRwiRmq37I
	TkmoedwZngv1qc2SN7gmNRc3XNMG/9y5REq96fDgCC/j8rYTSwHzvw1HfrPlI4XfPFYAkD0DnqO
	8cgkZK6J9fWT5/RABvgLHBv68NnA0ABcbNSqoY3Hc1zEhDX0DZHU3jyrP1Om0yFu0fGZcbxqkOm
	wG0kQi8+Wcp6SqxDx1XkYUNbjccFYHl7foVFsv+2PBKdpQM8Iwvvsg7duoqTiZNw2CnJeI3Nb+h
	6ZfztpSCvrr7gTrlSPFsz5k3bYChSfpSVTjBA6LDvBUk4F0+B9jH9YPI10dRUaw==
X-Received: by 2002:ac8:5f89:0:b0:51c:241f:a6ef with SMTP id d75a77b69052e-51cbf30be71mr88277881cf.70.1783941893267;
        Mon, 13 Jul 2026 04:24:53 -0700 (PDT)
X-Received: by 2002:ac8:5f89:0:b0:51c:241f:a6ef with SMTP id d75a77b69052e-51cbf30be71mr88277701cf.70.1783941892828;
        Mon, 13 Jul 2026 04:24:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm548705105e9.10.2026.07.13.04.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:24:52 -0700 (PDT)
Message-ID: <889c5e27-8597-4d0c-9627-448bb5b6d51f@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:24:51 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX94M1Kc9U5TUm
 B0cMVujtyt3JomRa02HtgzMYojOZus5MMmRw8PKGt+NGVMDnwmxEk9l/TiR2NrfjoHZ8e4DlAf6
 UHnK9opMIVeVzaGO9Bq6mEpc0hD4HCMDfkPtFplHwnOVMMHKPkmqsE/M9bhtrQ4S3PBttJTaEzx
 Hr17J+LKWmplWMG+2niC4LAf+LZzYBU25xR0ahBk/+OTMninN07tPPAD1mgcXBSEi1diYs6xHPE
 WyObGI+P/nGquMEwJaUZ/kbvxZLOcxYGwJD4fa5cYeTM0yW1BgKznYMH2h5iVI9a8T1Ho94FAPl
 yvYu88RlH+PbC6GahBuvRoV31ou6ZOC0e2u1spVQLXNgXXPheeDea6VcyXplWwSh15uU25N+kbJ
 mxdGsFhJFl5vKFeyjWeRBW41Iq9CTKb6zqBQsxYM5cKNYM+yc0GMeOhUb9lKAhZtAXitBmqy6E9
 BiighnOdyDxeif6e1rg==
X-Proofpoint-ORIG-GUID: Lnwhul1M9pGm481irJMYiz03FSfm870F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX3Wo6SyTp+PCm
 Ve1eq3ANwuaZhrUhBGw76S2QQmZa4F56GTqcPoTZzWqylAtWRXPUjEFfQLCyT5UKVHDmRK0T7re
 rmq1rfWcy6x63nr4yrE5iaf4hOEfHkY=
X-Proofpoint-GUID: Lnwhul1M9pGm481irJMYiz03FSfm870F
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54cb06 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=JmANKVZToQFHMbjcn94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
> as dirty when refreshing a lossy tile. When the display height is not
> a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT = 2160), the bottom
> tile is partial -- the last tile at y=2112 has only 48 valid rows.
> The unclamped loop writes to vs->dirty[2160..2175], past the end of
> the VNC_MAX_HEIGHT-sized array.
> 
> Clamp the row count to the actual surface height so partial bottom
> tiles only mark valid dirty bitmap entries.
> 
> Fixes: CVE-2026-48002
> Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index b2b69923b75..559d3954b87 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3004,10 +3004,18 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
>       int sty = y / VNC_STAT_RECT;
>       int stx = x / VNC_STAT_RECT;
>       int has_dirty = 0;
> +    int height = MIN(pixman_image_get_height(vd->guest.fb),
> +                     pixman_image_get_height(vd->server));

This could deserve some helper, anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    int rows;
>   
>       y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
>       x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
>   
> +    rows = MIN(VNC_STAT_RECT, height - y);
> +    if (rows <= 0) {
> +        return 0;
> +    }

