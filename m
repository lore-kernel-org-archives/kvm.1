Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4643E4BE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080006; cv=none; b=eTZp77a+hao6mwci01sOlJX9yICuWkYHkUFRe7ZJamJyxEXllB3SzXprfKUxqq5BD5RW8HK+OIWx77V7cdCzXz4ZibRfqd5f+sDT9OymNMA13n9nMp4PrzaVBlkzoV+u3wY3IWuv9KkbHTKEiBhMhX+c/n+/Z0WS9jKhoSLF7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080006; c=relaxed/simple;
	bh=ieUxBwUahgYUW+bsS3PI75MZp3uJFM3uig6v6zcYf1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPbDWbRFXUSOLBW3dxRi3nW/oIIZXWVc7eofnFNJt0l3xs+a14KdfAgSn0CrtSY/BJbz9vJ33au+RMXL4WL2H0SGkhxh7IMeA+p7UvrsBW38Lf+mmP/TQGoMsZnU8Vq700VnfX5y+BXXz/qk8E3NVtO1Wr/9m2s4/JQmmPrw7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xyug3sSA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHksifS0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xyug3sSA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHksifS0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2HXN198960
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RkEQuCKrcklDQCnz7aw4dOFoxK8gdGG2aMehc/BQwV4=; b=Xyug3sSARIlWYX/x
	Ith4qLI6J3gFfn034GMoPyUZGRGz01GgUWgzQodTVoaQbf+D5iYVBEPAfBjbYOgu
	3sgwxEIwJTLzUI/5dWp925AnGKUF/Y+vc2f3B8QNi71qhXLjRqySpYN6SS37s3iF
	zZB4d8EoPsWt3+CaWMtsNbSyorkl2v1tmgsINEypFM+rCTPSeVgLr5BJfzaO7nzn
	NxL95tzLw/WgUCPobmhbCjzTiI9Zq8hOCPSVFgR5d9cXl2vHTg24Idi8g/GEXIj5
	uKdYWhz2vqakLkEJYxzVeI7gWCrXR/6i+1DZyE3628UZlmr+ntZcwN6kMiBAxn1/
	sH1ixg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnh757-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:40:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ea1eea05so2870160eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780080002; x=1780684802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkEQuCKrcklDQCnz7aw4dOFoxK8gdGG2aMehc/BQwV4=;
        b=CHksifS0ZlKVZ7bu1T4gIlBNc5vf+7zmdGhSBmla9dZg2ewRLx6J27Xn89LEEYszFj
         avDISHBscIIGbg+6+vyecnYHNqLu9f2m49ZD6/hTLGVogms6mNR9KJi9EaJ74vlWILpV
         zmzZO6ZgpbNt+z50u26FwhpQMTOQuolKPMVVgK5TQzQ6CAp3g2v42E0+FDYKrZl8bjYN
         XSg5tCKBnfBmlvHQC+D65ZXkyNKnF+jjuvSsoWQob7uhb9qHQobK6XPDnau4wbjAn1TQ
         8vzA6IlKCn+l+7yliHzqDvXXlq+YZNWsjtKHsogJD88iEU350heBbRTKIyLfPftLaPit
         di/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080002; x=1780684802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkEQuCKrcklDQCnz7aw4dOFoxK8gdGG2aMehc/BQwV4=;
        b=DoQhD1wnB/hTe9ad2tr4uhixQoppcQ6Bxs6VTZ27suqCVxZQiOqk57ItLWwR72JT5N
         GjywDSSSXYmbw0fNbN9TPA6VzhF8QKeluqCowsjNV8lsepmgtxoym8n51ZmiNqxrGK37
         hM545kvWef34HWjsuwswPdNr7P83a02HfFklV5chKZq1nOqFDuVzjpEZS801A/ykxmaJ
         5349ZgBdBvwHM1qDN9X4le2m8rsyHyc37MpCFL2s5g4j+jByJC1NNxn2zTbhnnQBVCNj
         A92QkwzquE0ijsU6jckt9jDSQtiojgxCPiW2jvn9IAqxX0EzX7Ju0FAv5dBmx/AE0RWU
         u4Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/kvyQUGGODNboDPTPgatCgYWyOdio4nn4L0wkhkETewSAyb3PNHtDEfXJJHnaHtdvHep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQabCkPAw+EQtoMpFxS1Yuz7trdLBxYu2UfNW/2/StCwEAVWW
	S1EXNCP6RE3fINX3ZVdGINBdz4ZrAOAgyt8jsuv2mrJI7f8vfhdtUL51RqQYrz7NfY1oNU4OiHl
	QdGjGquLT60X38ipl1NGQZ9fePKHPmISKh6JTdzfCA1O2LNfKmEG5BWY=
X-Gm-Gg: Acq92OFWxSu4XE/pe4eZsx6kBY9slkEcDzwSwg3WGoE5FGaF/EmSzFUkS/FeH7WeZHw
	2H+l6VpxwJff051fyIKjuwr/2Qe92BphCKJdtrZ+K9EZ453oSCORzvy1zmiZQWBlER6/lg0cPMw
	KJDH0sde5nOha8QRT0FvHpeZtZbYYsuNgBQcJho+X8Q4yXoiP9zsGnXDUB+eFfQSHiQr5OAA7WV
	eI0HyWhYaplYFVQSYGYX8021d0UQsn2QOGTTkFPzH8sTgkQ+EvazkRNV+AOWH2V5IW1M3DjgCfM
	aFXmJu6XKAiucqrwpXAtvW+yLwD/q4ZyPtTUzQGb06xo8TBGMlLO+xxmRnue69zhHCTvKWwfdfl
	4PEOx0M6x6E8Jp0E3k+p9Dc/3Ch9sCACvUWXlNILgdNTx/lbajXyxIZgOE0ZQeNi1TwrR55YMAU
	KqdSt/R9gU7LJfj7siaHmfvp/I
X-Received: by 2002:a05:7300:3212:b0:304:e72a:d4d1 with SMTP id 5a478bee46e88-304fa75f26bmr499526eec.30.1780080002225;
        Fri, 29 May 2026 11:40:02 -0700 (PDT)
X-Received: by 2002:a05:7300:3212:b0:304:e72a:d4d1 with SMTP id 5a478bee46e88-304fa75f26bmr499498eec.30.1780080001730;
        Fri, 29 May 2026 11:40:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm2028341eec.1.2026.05.29.11.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:40:00 -0700 (PDT)
Message-ID: <d7666e7a-d5cc-411b-a1a5-1c76d0b6d353@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:39:58 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] accel/tcg: Convert RISCV AccelCPUClass ->
 TCGCPUOps::cpu_realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
        qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
        Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
        kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX17Hz59jbZOA9
 fKXVtHjPx2Tlpt33TvtTaljWAOq1tAQMeZt5t3Q05czb3rPAdS4TgT8eUNF1Dx9ZZuUoevuVvB0
 rGincevxWTIsjmHXGFSYn9TxzYRcnS9i4FPQ8/WaPO5xhkI6AoQvqukebNafjyDofRi4hKxCvpv
 xrLUuRdHnA8N1yWWl+jiVJ7klqiPci3TwnTxcOBcjG+Cw7wZaV2LTutCQZd4XCUzv4EYEkN2n80
 iTlMFO5JCVA70NLXC0nth1QTecz7JEPMGuszzmPMGJWRCuoSTlPoP55PBwRzVxXQANqi2SncqZ6
 gE6WYyoCz0mXkLUZZbhM7Ioh9IFXiF8bF1zJ6MOFtRF/i2Q43+NujHz+G0Nm9Q4xP7U15tzi9lU
 G8rO9Peu6QySiox42h68ZcTClC62iCf1QvyaEZqadkgHITQh9c3bRXVUQAsWGltxb8Ox5drkzyB
 F8xVTTccb2v4OtgV7qw==
X-Proofpoint-GUID: mfNq8oyBgHWP3rm3z0DdDGjNU0MmG6xR
X-Proofpoint-ORIG-GUID: mfNq8oyBgHWP3rm3z0DdDGjNU0MmG6xR
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a19dd83 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=TJZcotH2JYSlfeF52QUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register AccelCPUClass::cpu_target_realize as
> riscv_tcg_ops::cpu_realize. RISCV's ACCEL_CPU_NAME("tcg")
> TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/tcg/tcg-cpu.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
