Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394231355C
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487580; cv=none; b=XQq5wgmBcq2wjYQU9KjLxYJwBH9/7NfpKz5OZrpchcYPkvnuVpkGaKVzkW9m81HshBH7xvpUWDj41C+o75rbzGgNz70mcAgtE/umz8ao1ST9oTHdgyXXlBEacbZdevfq+JyQCu5WotjT/P40/WKAdXmz3SRYprfDQ+N+PbRz7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487580; c=relaxed/simple;
	bh=FhSkyxFiONpHFBrqfT6QQfRxsF/5YLTzFwhvmH7C2wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3eO0tfrWucdBulS5GUIHy/oHuup/4HvTHzsWOha5D2PuyJtm9PClvZc62n9ZJG8BUD/WE3xSy5JSoQkXAHjGjpDd/B4HySIy4jKkGrCyKNnSFcd2Eh0d06G9boOFIQdnMK2/FUUcN3gVKXirTF7rhHqN6eQEpTxt24GmSl4f1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TY0Gnb2W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds1rCYZr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TY0Gnb2W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds1rCYZr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842OQL1695664
	for <kvm@vger.kernel.org>; Wed, 8 Jul 2026 05:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=; b=TY0Gnb2WDFFmWXoI
	I3UoDnZVONgL2JvGQYJ259jruLmsqWaEd5ujnAEet5OSwTvjnsur9JldouZVdvNw
	hs9GP2x7fzIehHITLnvMUEIO8XPh4S2RIV18qA00BbvMQRmaxscQC0URmP2YlqqZ
	B7vGHYpfVZRchhlW5EojuZuYXJCNmaVExR/uH62ID4rU2qaRjswzE0EW5zcR75P/
	m/ch4mnKups3UZHBoYLVPYke2MlOPUtzoIt3i5pmlUOM7esrF+eMDXywA63ILDNI
	r3gZHzSP6b/Dq6k7QytJQ/a22CYUDOwbkKI3rgHGkbEViFrSwVTHyCCY6LlG86dk
	RBDFKg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csw8qdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 05:12:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8eac2620cb0so4240786d6.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 22:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783487577; x=1784092377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=;
        b=ds1rCYZrVNn2glM17UsE3cho4lKDx4AZwx6rHka44PrHWgGMVadvQGT14YgbFBCcEg
         zBzpflb0YqYkjSw2PHky+Ls377G/DzM9zAXDaeEQoTbunVl2lq6M7fep4xyXeYsitEFI
         693o22NwcEBhCEaAFoBFHQHNWZIjLLIf/fY1UGQ7YSgj+DI8/Co9QK4PDPh2lC2wYZHM
         fcOTtlWTAOGWnV3eQpMH3arBcwkzVchuhIVrysfCngHPOQwd43pmXzfXj45i6oPy1ZyZ
         ds7k7H5MDnrfYLHsUd3ylJscV6YG/VpSFLE1sOrLUvqgV45xrZB8NLBYyheXZa0eCheE
         Md4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783487577; x=1784092377;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=;
        b=QpmGEjmL2Oev/c48fJqzrJYlpLdngRXwx+y1mEwf7GkrFS5vqWoQjusqyF3Mk46ehd
         lUqTiwtAPeH6J+z13y4761wc2KzksrlEdYfF4GhJHI23c6EjXyplVNAZV46rCy9hGZmd
         xCIfuHoxaFXe8MzzugLqcQ22rrkdt35cgXshSQbcE1U0e+Y91KcmfwVQdGO8j+NCPWSt
         4dgay4fFBHFEyqJZIG9RlMmvcjOAaJi6anoedd+7YlVOfygBCsdDHbr/s0GQ6+7Sj5la
         uQdYt8wuLeUD/HMV9wUXalBJrFXtTLzkH8WCFyaoph4YrgkfCCBqM+5qPkwCL7Up7LdO
         VSyA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg+JbA1RN1engFMb7q2m+jDnwPT4Nxm5I+JhGVUeZbYtJXuVKSn5wd+Sbz3e4sxTRVHZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCxmZbyicOAk5yG4E3aqvUooDzyw6IsSN5YkiweOlwV92S/CC
	99HYEN9E33/vwmoo4qJ5s1X2WTfkK7kywGRSrnAbi0Xony9+i/KulHFeqnjGTOTuBte762Is/V4
	jkD51K5gck9G+dfmcaV4GVUJkJNaG67953lZjeR/oi2reEU/UwArLbyc=
X-Gm-Gg: AfdE7ckKhCudkrKm+pgvvNuiRJmntedhSwbfkgYv4+WQTSZkBLjZInPErioRc48MVMI
	SztZlR1Z1RnDGTTTqk06i2H7keMalbZ7TjOgh0D0AqYINdQs/09uCFxPtC6OjTAy53tuPqaj1rr
	YXGB4x20bSK7Vb9U3I2ER9ooNFd2qhf9QqChqZzyfxeSY5hUDooJVZmaFT+cz9hrtYA9EKz7gZl
	7Td9+3MEr9Dd4TQ3rihK7NG3ei8+SIjFpdluULdFhVAYk4N0e1BgIVKHm/mEUMksx5hrhGhHNep
	jalGpeYg5enB9QKiGWH1BPavfru0iT5WV0h+DGk5fqCm3phzVXAWHcRKcMLEhbAcvq8SONVfuoi
	C1YAJ1Gd9pnWEzY6G9InAqxn5TpONPsy9UydDP00MZSjzKeAu/upq7Hn9Hs2Mxg==
X-Received: by 2002:ac8:5a82:0:b0:517:c65c:488b with SMTP id d75a77b69052e-51c8b13d7bbmr11048831cf.0.1783487577057;
        Tue, 07 Jul 2026 22:12:57 -0700 (PDT)
X-Received: by 2002:ac8:5a82:0:b0:517:c65c:488b with SMTP id d75a77b69052e-51c8b13d7bbmr11048681cf.0.1783487576628;
        Tue, 07 Jul 2026 22:12:56 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a6d752sm20576035e9.2.2026.07.07.22.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 22:12:55 -0700 (PDT)
Message-ID: <56424482-5a3e-4afa-b9c4-8d93c37ab737@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:12:54 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 16/25] hw/arm/virt: Set proper conduit method for Realms
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
        kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
        peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
        jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-17-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-17-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3YEmMO5MxzVvfTtuQKE7WStpvaUItDAF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX/1T6aiW9OnM+
 8q3gAsx6AgmSQokshib0TTgQh+H2bt4lOzrFURsUAVYgbzsa9pta40eg/edleM7q/2JYLILwRAh
 QuuxhLonFOy9Y2+DiCZzyrz0ZICvR1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX8m9v46XKK9/G
 /P9YgHzV/YpCt+KgmrqWhUnYw+sH6yoabHZ1K830MF/D9V/YhAKYrLX+2MdxkLgYzx6DIQPCVt9
 12k4p8PMJtj6whOkA6X1p7R5UqmvWcV0WcK+kGOYnrvyBUB5gmEoZasq2FhIOLI7yfkHIMNVZ+Z
 tZ2r49T13zJqBG7eYtRSJ688Ycw2sHi1Zmrrcw0QsIzmfHNaDIJTJpPukVXiZo56M6uvq7rJvzT
 JQweRGojlf+/eZP/S2Qh5kZifRrOriM8W3f1zsjMmGWPbTVQZLVDXQyI2umH5snGI8iz7gby3or
 YJBdlDSrvJD2ZUxAWPsA+qIt1pRgRfrFbFOPovkpPzlsUT70u3idV8GSEVtb0WhnX7zQoUTTCi8
 TOpok7ErMwkIDQkashj1NCU9eavJoP5tVc9zgs0VcG/DcxD3E4XGMMX9AocYZ7IsiNfz1c9WWaB
 yt9QewE4pSmQt0ziX1Q==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4ddc59 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3YEmMO5MxzVvfTtuQKE7WStpvaUItDAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080047

On 8/7/26 00:42, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The HVC conduit for PSCI is not supported for Realms, so default
> to SMC.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
