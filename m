Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7923E2747
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942030; cv=none; b=UwUHC5K6NDX+AxcplbvB0ju9GvFyzVXR23p3JDMblLrypA73lO+eVCh3nyP/Ogg1vg77e5FYlRDq+JgiDTj6josvwqGUnOGZs7A6/SJmy/Pc2d4rfAXPIjWeDQIigF8TpqrD6ujI45AS7ZBldb6+dA7n4gJ6/TH+2qr8+KH5g80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942030; c=relaxed/simple;
	bh=r8E6ANc2bdat8K6Js2WzQE0M8P9rKxMuNNW+k8Ya+0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AYM2HrqLZiP5pgk9QEyZsJAtAAVC498fGIDDRWEaDz2MOTd6FgYGtD0tQefkABr2taPEvjlXEA76fRFcPQ9+aM5zzKu9EPQwzFN0fN21Fh3bkhrv1k6/v3dsoI/dTU4H8Djfg7mLzJWLjdABs+ik9NBl2RzYQhBy3q3umGjYnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDq6iiYx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TAXt1G0U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDq6iiYx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TAXt1G0U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D77VU8810641
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=; b=iDq6iiYxuBQ7p1Q5
	vDHAi9+Rfl9zJ6WqMq3Iv80y34norXsOHOpi72/p99gpidooLNZ2m6/qQi+LryHq
	f6BNeh9B9HluOOphzYbz9c+YRzpWGOqZSkCKHPy+e9nsCFfEqozIlACtcfsM3hXk
	452fgqw6hQ5+6cZY5h/OUf9T0aHRwISEW2WmTBWuHLTtcGqDP1WUK1Q4pkct1nS+
	HvIdvY2NvwJp5XKGGo9WwxGQM9zbcCrW/5rJFipLSMzY7OL9iO/i1k2KtM3ddqAv
	/dKJs/ANPDcM7CdsIuHursMi4ivEd4d3e/qiCblkqAkfFo/GwVOyq7nG55K/uV5f
	czPfiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrx7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:27:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso51178061cf.2
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783942027; x=1784546827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=;
        b=TAXt1G0UFuj71gr5wvdHlM3eXNA+fuyTNJIOWcdEOSDIag0wGtaMh8eBZfpAU0G+Lx
         JvgzFr+0E0hZOq0o2d/InnkPlNprTKJZ/IlvoILNL7fLfkJYc/OXipV5dKaNWx8M8iDl
         NdQ1fyEksGZb3YIW+moV/rGu2rXsTrSPuyZ1SAjwQDJeX9oinYCyXYcA2qZTboExYGa9
         0ZH+Lx6OrKJIoYSEAmHXfMh5yPg0NYQU1XDka4PFtuGMEIS2+Lw+Mki8ey+8L/G3w3Et
         98YE7tgzMyqveOPD7+HxDyIESwAPwZYUJW+rFK3jzN+vFOEP2x/MOFxAUSJt0OLFoBt+
         CX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942027; x=1784546827;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTjzMXsLBbJ0LOu77n6+XLc2W3meQJWwjiZ9dKgFbWg=;
        b=fsIydGgts5FlyCBs/AgRE0EbcEXolkvEG33SY6RHy8Lo0byuXH/lf3NsG9+kqPiC02
         FSPHx8jfmHRHskzVPj/vrTDPa8Bq5w2epzRWytpWDW1UYrBbISl01qIrSFQ2QutnzbU5
         H11VCuB0w3BjtGsv2c7emMXxyDixaoHvKrZowoUq0D6zUheAgQtUB231wPenjCVOEVPn
         EA3t7BZbZR04CHPW3psAy3nTnRaC2YEVujWw/OHbQ6VDqn/mmyLEIKCYgkspH42yWiB/
         pN9WMDOg6HN3SvzxHfK9jHHwsvovwkXDH/jSZpWwxFbfKHOOg/bRm0IyWW1SXI7qMMtp
         gDNA==
X-Forwarded-Encrypted: i=1; AHgh+RoTs4In3MDn1UvqRk2pIcqF5+9XHQKj//7xcIJFFS9Q5NHjWCLMnHeX2CPebns63f6ZA14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X5Z/skEl3od2DHBCV/sZeMPoiGFXWnHfm4VS+bG3w+HIUE9h
	8NlauElbCPP29JbqffAJKoaV5tpABkwCBnw/w2hfz2PXtYmqsANP7zGis8Su1Om/Xxdt9Qmd8Wo
	K+fCwgPpo2vl1huP3rb1yxsR44+Sy143nPFaXH3AAxYaSat3idv1hsIQ=
X-Gm-Gg: AfdE7cnfugqZznHVDz8oghQ2XGZveJBMDmmBvWOfSNQKLlnrCAIqgMPN5ZrnAjMr51I
	NISwtpyeyBQrHQq2LAWFek3lMYEYVr+93P3GNy+yppg9l3YEG7En0QoAZQwMjpPNaJYO4VO4RUw
	gSULGO4R/xSZAISkwCJyo6O++DP8HhOXvkXfiPkCDG9mJh8lRhLMQiOaSdWOeAeUU7iyqBv0NZv
	3irzsVM0cdv7dAlCnOapuxYzEWPBOIXTB4/nI/UDta00+Qgq+qgtnpHXgGYuqAZ+rxuhKoVZJ1G
	AIa9PObPBEQVguVSV/T7Ga0aA3QlLd/9+poK/kUzs73CdNOBcQduz8AYWpK+D68X4ji/G/dML77
	zlOr1y6JJNusfm5Udq7CZtovFA2wokeclcZGIDobjJh+zmhT9OqSHq+nUUVLFeQ==
X-Received: by 2002:a05:622a:115:b0:51c:7b11:41af with SMTP id d75a77b69052e-51cbf2e0d38mr85008401cf.75.1783942027367;
        Mon, 13 Jul 2026 04:27:07 -0700 (PDT)
X-Received: by 2002:a05:622a:115:b0:51c:7b11:41af with SMTP id d75a77b69052e-51cbf2e0d38mr85008101cf.75.1783942026920;
        Mon, 13 Jul 2026 04:27:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm41878791f8f.16.2026.07.13.04.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:27:06 -0700 (PDT)
Message-ID: <7a7985b6-2a62-4159-8d22-d11d0739d843@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:27:05 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
 <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
In-Reply-To: <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54cb8c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=QD95cOeK318sXTfxYfAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: L48fHwannDstVECmIbizlGTsqXfRYCih
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfXwkayyX3YLHaC
 dw8h/MbSeaVRiu3HvXamZnuNVnRsIQpBVaRyv9wuXXRmDAg218vmYQwXeySJ+weZBHSRbfatWM+
 M8n6VJ7HVpRCwSuPDR518iMewdXKFC0=
X-Proofpoint-GUID: L48fHwannDstVECmIbizlGTsqXfRYCih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX9xmKAae5+ENX
 u4ZGXEIL2YKa6ETTF6OtohOxjtIeaaSStjOD24GYbhjGbRwKufcgrkN2CYzJyKGAYZ33W7NDb9E
 FNKa1x3TyrAzT3QYRO0M8EStSopns5RWU4IbMeQGj0XhJjG2npbN2R9DPRc6pwJxcZosSjcQcvt
 64WoI2ZZFCNGDh3OS+E0E30+8BFnsRbYdgBLxcfKHCS6wc57Llv6TeW2WfdxYsJ44IxGFfuy2E9
 SOWNXn9Aoxna6SjSxQte7iTfiVfHygt1uOGBvkLbGsvDdjEoEd491gZrSsG+GI4+OKcoUa9TkkE
 arBw7hM99IMv1BY1vNceFoTYpbQhYmaYbqAa0Q1UTaJ9bzHJFvNgTUqvqhCMvrVEXzqP3W7yu5p
 DQu3EQyqzirBmIqtnGY8fby5PkGyXhX+b4grYJnVDCOE4s9wpgWNpShpASAoGtmvm8nP5s5mrpb
 6MUZnzYNPH7IG0uKhGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119

On 13/7/26 13:23, Philippe Mathieu-DaudÃ© wrote:
> On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
>> A malicious VNC client can send a SetPixelFormat message with shift
>> values >= 32, causing UB mask computation
>> (e.g. red_max << red_shift where red_shift is 255). Apparently, this is
>> not covered by -fwrapv.
>>
>> Reject color shifts >= bits_per_pixel before computing masks, and cast
>> the max values to uint32_t to avoid signed integer overflow when a
>> valid shift (e.g. 24) would set bit 31 of a signed int.
>>
>> Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
>> Reported-by: huntr bubble
>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>> ---
>>   ui/vnc.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 559d3954b87..94a38242c56 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int 
>> bits_per_pixel,
>>           return;
>>       }
>> +    if (red_shift >= bits_per_pixel ||
>> +        green_shift >= bits_per_pixel ||
>> +        blue_shift >= bits_per_pixel) {
>> +        vnc_client_error(vs);
>> +        return;
>> +    }
>> +
>>       vs->client_pf.rmax = red_max ? red_max : 0xFF;
>>       vs->client_pf.rbits = ctpopl(red_max);
>>       vs->client_pf.rshift = red_shift;
>> -    vs->client_pf.rmask = red_max << red_shift;
>> +    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
>>       vs->client_pf.gmax = green_max ? green_max : 0xFF;
>>       vs->client_pf.gbits = ctpopl(green_max);
>>       vs->client_pf.gshift = green_shift;
>> -    vs->client_pf.gmask = green_max << green_shift;
>> +    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
>>       vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
>>       vs->client_pf.bbits = ctpopl(blue_max);
>>       vs->client_pf.bshift = blue_shift;
>> -    vs->client_pf.bmask = blue_max << blue_shift;
>> +    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
>>       vs->client_pf.bits_per_pixel = bits_per_pixel;
>>       vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
>>       vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
>>
> 
> What about instead of the casts (keeping the if(shift) block):
> 
> -static void set_pixel_format(VncState *vs, int bits_per_pixel,
> -                             int big_endian_flag, int true_color_flag,
> -                             int red_max, int green_max, int blue_max,
> -                             int red_shift, int green_shift, int 
> blue_shift)
> +static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
> +                             bool big_endian_flag, bool true_color_flag,
> +                             uint16_t red_max, uint16_t green_max, 
> uint16_t blue_max,
> +                             uint8_t red_shift, uint8_t green_shift, 
> uint8_t blue_shift)
> 
> ?

Haha this is what the next patch does ;) I got confused by the
(uint32_t) casts, they belong to the next patch.

So with only the if(shift) here:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

