Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407130CD85
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941821; cv=none; b=X+3XgIp2ItcAogKKg9+2N/ODStYMd1jLRJit6x7y4NMOX5mUQK7rbB6YPgB2IjuxYSOiIwVjUJ135peExRlrPU7Hu/hmK7q63cWvF9llmupZpNWUpTeNn05bZIqo0mLj0yKDePYHlYRGnAt35+CJxJa11Dcgvqk1srMlGYX8Ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941821; c=relaxed/simple;
	bh=e+B3LBky6omI7QQrugSOoPE1KmLMHoZC2B94izpxnyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFzymTpW0D7p3lTCVR/41bUScjHw51dl+3y43xoYExgTorSxBhyRDz/nmdy0OByRX+Sgf82HKBMQAQmntw/6NCs4OTDov+duPJB45sSKQU7KrHLfgyC4JgeYFaZm86g2XIn0D/fmjriNlaATzb0w3QS4yCyaGCCSDUV+j6FZ5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPhRryu7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4z1v18e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPhRryu7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4z1v18e"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7YlXg794235
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=; b=aPhRryu7QJsNEoZJ
	/MzJ+rSAbO9RMFEdeDH5+o/ooPzmcrR3rc0cvY1t8hONDsn3veBlbaF5s6bw8jhM
	k2STG9f0TUO4iaWzOMyfqEgaDw9CA2rHElkezLBSugG5hJksrjR24OytSUUF2o8d
	TU4YQPWZw6C60PhaQg+tSMBrSwpttaOe8VAhz/0/yLIShJFq47lBBxMsysbRX5Oe
	GfHUd4tsmBzZiMIjb4Wr5+PlFhAaUA/3SrmmxXjw2Jm3pAWdclZlJrwUk4y4die9
	SnHSIhAdQdH5UgL/9wukTcUi6areUGKjYfkp/4e92yZ6SCrbOwEpEHceL731ZwR5
	nBiilg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn0sy4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:23:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so33537231cf.2
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941818; x=1784546618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=;
        b=A4z1v18eLupq+NNhQOS0Za4QMAlAHCTR12s4CsYkNV9klYHhZOVoTxAws/6/dALq4o
         GSVrAMoNyD4sLXNNwCXX9LxRolKpJ4DafJkKt2/j8wmBHklQCfKLWW/wJuAkzDTe9VsP
         Xdxif1BulAi1HcUw/jxIksuY6mhnwUm2suSkzUS8KoxvbbDgJjhma8QrZIzhjBbxb2Xn
         FxSdOaH5Vfze6SC4cSA6Dc/Z37n6neBXpCP3JFn3gkdzqgDhlM6Rhl/q4tQnxFU2G5VQ
         DMS14HmBiYT0zjX+UZTmOLwrqFzWr7b8lSyAkuiZa+FmvAk+z1T+ffzOjgIesxpssmLm
         uLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941818; x=1784546618;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=;
        b=KFmC0I87FZVaFhmbw659D2svqrQ/FNVghM8Wg9OqYVBJGHP28J+4A8eVujJ78vq2Zg
         CdwIqAPbmoiO7nDUdVeJ76VrZUv8RGXjOK6zXsFCdTqZ9+LUnI+1hUookAYpbGhg9+eZ
         omfQMkE0n2/C/hpdxuYDRNTEtI0TaYodR21dKhRnoCzGwOiftOBxfs+EYMgN35OJjI0j
         zIDayinEH5BV5jwf2sEoch0I00i3CopG3/cdegp236LatD8vjU86zxEkSPPImWhNdm1z
         Goueq9fRqFfaZtv9/vjVtE9f0o66iROyQbocpwylV77z+RKiPP/fL2eAr6dzpUq9ICN1
         1+Sg==
X-Forwarded-Encrypted: i=1; AHgh+RqE5BpmlkSYreFGqLPN59OPXd4yM/3aSrmSrWN2uZnTgy2xV9Am4dbwxuioMkPb8YpY86o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6zcGuJg3VpsGOqs8QLk03myb2c47jm3BEcTyEAU9uhMrYLVy
	cYbH0e4mOAt05rq80aqY1XIoq0GfoeMLQl4Bjy6mNgZV2TKquPSXfBH/jZy5U2SuYWE8Jz0VnEG
	FXQOdpmep8yxAkkltKlIn06UtQC7VaMe4Bv7RSCPhzUJQi8VKw38QVEw=
X-Gm-Gg: AfdE7cm1SK1wsH2LaytkNhxVHnskOdK3zuZMv68KSmhIxo3VCnk3F318pidb7+rrNAZ
	nfqdToPk6VGwPZCGjrDO64gzYz9RJQZneYTSNtcNFWIZlVg3kYwZ1e3OPB8SrMRITIUk7Nfso0E
	56zdYTG2Ct4wBl/hPY/Nauq0PxHKQnuECkYuq3HdJByigpSpHpsGlVbn5miTICm3dO0IxjapydI
	MFGvJHQFUJ2x48aSABeFxL3/CgFf7SdfPx00Ow3LOp2wjQplZmMFl6Gs3806xAE345QmpL85A3A
	E8CpGKecsv5u/19uaWQQXE9hb8l906wFkY2oWYTr0ZjlGxh9YYJKh8YJyCit7pFOUU6B3fW38lI
	bB2ArTQkjpikqhaqyQmfhyKFti0twGJSBRVMSAbz8H50uZifyyyYkQFF8Pt30+w==
X-Received: by 2002:ac8:5985:0:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-51cbf046db1mr98852151cf.5.1783941817847;
        Mon, 13 Jul 2026 04:23:37 -0700 (PDT)
X-Received: by 2002:ac8:5985:0:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-51cbf046db1mr98851231cf.5.1783941817051;
        Mon, 13 Jul 2026 04:23:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm548507325e9.10.2026.07.13.04.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:23:36 -0700 (PDT)
Message-ID: <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:23:35 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mUSyyRnaYDHZK2vs4PU-Rli9A-sY6YA_
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54caba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=d0EF2MyI_0mXo9OA3MwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX6mBG97f3mlNi
 7TyZZIwnmxn1wQlfoFZdXkPVDid1BuonNiuy6FTXHha/VZqxiVxvQ9c17hIvnTbKT5Vjl66ICDL
 vOxMNQnhmBLH3ckIheOR0aCU7CEPqCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX8+1qheHm7T0c
 WvhrBt/T4unjgSJaLyola6WvcyMFm2+cmWrWmZ+f7Jz/VxWOGvO2WTTtRBMYuteRtSXB2vi6Yar
 7Tpcr6PikqC7MV+NajCFnSr86fWzPqAuTXINJUS3C0RTaFtvzRoHqNl1fvqjapo+Dg7cHMKsaAZ
 Fr54O7OUCUuSULNUr9U61EAWr2i2c8O8o50UX1KeqvX66lceoIX+mcTA8uzMGCTzzC+VrMMZCPc
 aaEEFT+QyOgwcB1GcpvWP12XRcYRkkrJxoIezIqEJY32EDwTIQ9L89qFVvqhXw8AkF9C5nfSrHZ
 vAEc0FzMqw64AosiMbMIm4+LeLa2+kXYvGIQ8Iydjed83pcKgAUkAiRx5/W3k0/RpopU2cnenG7
 jqj6lovrYs6238gIerJnttaT/4jYOU5rSdzBy1RkA9bG3RrAfn08CB8wXWZNuVX4nBSN86qNLZR
 Y2ZWrnXTpEnDGmgAkkw==
X-Proofpoint-GUID: mUSyyRnaYDHZK2vs4PU-Rli9A-sY6YA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> A malicious VNC client can send a SetPixelFormat message with shift
> values >= 32, causing UB mask computation
> (e.g. red_max << red_shift where red_shift is 255). Apparently, this is
> not covered by -fwrapv.
> 
> Reject color shifts >= bits_per_pixel before computing masks, and cast
> the max values to uint32_t to avoid signed integer overflow when a
> valid shift (e.g. 24) would set bit 31 of a signed int.
> 
> Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 559d3954b87..94a38242c56 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
>           return;
>       }
>   
> +    if (red_shift >= bits_per_pixel ||
> +        green_shift >= bits_per_pixel ||
> +        blue_shift >= bits_per_pixel) {
> +        vnc_client_error(vs);
> +        return;
> +    }
> +
>       vs->client_pf.rmax = red_max ? red_max : 0xFF;
>       vs->client_pf.rbits = ctpopl(red_max);
>       vs->client_pf.rshift = red_shift;
> -    vs->client_pf.rmask = red_max << red_shift;
> +    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
>       vs->client_pf.gmax = green_max ? green_max : 0xFF;
>       vs->client_pf.gbits = ctpopl(green_max);
>       vs->client_pf.gshift = green_shift;
> -    vs->client_pf.gmask = green_max << green_shift;
> +    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
>       vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
>       vs->client_pf.bbits = ctpopl(blue_max);
>       vs->client_pf.bshift = blue_shift;
> -    vs->client_pf.bmask = blue_max << blue_shift;
> +    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
>       vs->client_pf.bits_per_pixel = bits_per_pixel;
>       vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
>       vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
> 

What about instead of the casts (keeping the if(shift) block):

-static void set_pixel_format(VncState *vs, int bits_per_pixel,
-                             int big_endian_flag, int true_color_flag,
-                             int red_max, int green_max, int blue_max,
-                             int red_shift, int green_shift, int 
blue_shift)
+static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
+                             bool big_endian_flag, bool true_color_flag,
+                             uint16_t red_max, uint16_t green_max, 
uint16_t blue_max,
+                             uint8_t red_shift, uint8_t green_shift, 
uint8_t blue_shift)

?
