Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E42314B9A
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277840; cv=none; b=O8/YH/6aO314JJv1JxHig3SK7Wr5xa7DIeWyGCm62cXfVq7Tp3OQ2go5rDdQ8MtSBLDYiCSGje0FH5RABJHl6Urj9e/jsS1egyVlcXWZDT38710tJIlRUl/Ni/bYLICrjjriMzZm7i60RhrI7TLJr8dB6pvirETJ6Sc+Qe5Yw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277840; c=relaxed/simple;
	bh=Rkoywyq1OJu+40P8EVNwNOeBsh3whe7p3XH++VBHy5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGtXvR7fARqsNTGf02l1bjMWBuRgytuTH9h18mOaaGOB8fGgsbArWKQlL2sU3iaDucoMGsiiuJloMSNmQZjnnWO5tEr0aE/phP6QONi3BgRj7R8cEGV7DiYsjE1zZCZ+lhFfVr/odODk8rHqeeO6vIC3EhR7RPZKdtS5r5G4m8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0xFHgoP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LR/Lmsu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0xFHgoP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LR/Lmsu1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FGEv1g506980
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=; b=d0xFHgoPGAWGY4L6
	c7Zi8iYnnZfveSVHOd7hc1pFKTi2TIVTvyBUduWCLEh67mzGuuV0L+WNDO1iH6I2
	G1Sm+wYPJTttIsFn1F97lzcHwc/GeSujR6FL/maiehUmBop9E/Jp0FHFfq9HZsWs
	SnV9F7dT31+BmG5C1l3puftUWn1yW/bNIENLVDsMrJ/PQ9Cgck7ayuCs6loqlxiG
	OjY9aOfSXMEObmDSiKGzegu5qA4t+4S46xlmCWwg1XkxSCNfCv0Pw0ERWB1rh6wa
	X0vs4IV51XrbbdeubB14hKAJFQLHT68R+Hfjic24TvPoeRpQPtAwkiK0CMt78aA6
	18CO+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dje1e0fau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:30:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so5599664eec.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776277837; x=1776882637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=;
        b=LR/Lmsu100q2fCtJCEbHYjDqQQGGq9YMWtOI0E2by6VcWBB1akAK14XgJefFUJgF1L
         4JL//DsBSfXTLyTcFEzVZUBOL28D4OllvwJuSRyZZRPa52EjbwDbYYVIP6+hlAnBIrnq
         XnAQmOAdvN5qTVr7enFUl46VhZWoO2FzljsxHfhqPz0c5QsP8ERn2K02vm5KIGmFrauj
         KHsrIpNezJ1+Gh99b08Y4zDT4sRvhoGHf0xCbtKWfa9JSucfafFpsqWn8++y2CrCJTyg
         0o2bUvVxVKMn+dGT6LWeB6ivC1ftdH/lORZ80wiCsH8qxn5I+zj1jNMeDrTLihmdwuS3
         zUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277837; x=1776882637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=;
        b=czo8kW1338YTrNmOBNnmv8OkQSNCZ8WEoI95fBg93tcf7ZeHI83CCKo/NpedM4y+Dj
         aunklf0MdR7RFJVaM5XSGp4YpWeF2qoPPbNXMlBPT2Jx3CLZJ6TetaTne6yernczyZp2
         Dsl/lVOWzL9q7XHO8T7EpKDSQc34ELdxYzthXLYPjhvd5MYGfnIICl5xwrN856UtPQEW
         TCA+NBOno9TwTRDGTSJrY0cGKmc5D12r2aRr18cvtS3VR+87i9BQ0Pt+Xsw4QG6JfNoJ
         cZhDGPDEQ6xiJtISfqioZmnmYnCjY4U2xQY5TnAMhsg1nNgNPb+6/v+hRoNOeFw81Jr6
         wyrA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q5th4sz1dl7bPRoRAXOodOD9Qim5St+jYenUd/krVmhPWkC+6ngKwpKsFx8GTGfWFjM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWFx8zTtNzlG9AwS0FbJJzWZNQjICIzKxtrpZUTLIThwyYxJ8
	L+xkGNN8tFL4Jzgt6ylAxDOrJWDVf3lfr5qozuGprclf+GRkyjaAOoz7uRrXFCw8SDNNteOP3xO
	DFHNr5p5MkNTd3GZG8xE0v4hFdenhffHiqiZiTV6kxQ1SHf1pI1y85N4=
X-Gm-Gg: AeBDieue4YLaX+FWjyQt6JaSQqVdm1FRfXOvE7cOQ5ITUZ14H7ubFhvZuq6pW80yDUZ
	wdOIQ+P0O2JFIg8HdGMp59ElT6aQ2it1qoDY06bzdW6MEZ7eQaOIVFAC5d9SOkh9I2YJy2+LYlm
	I97Z3sLklD67HhDVlGc8W6+LUO+IVSHOlLkRGdBk1Spvgexnu59b/pnPHwgWPWYly1ka+Kmqf/j
	IGzENjSKHSp1jIvLMP8y69pHmotOHM4r4seN1C1URjPj7EV7uVDeCYvga+eoNCz1YjqE/8L5Tb+
	g6szGwqhT1SSFLXdABn0KgDRmiZnzhWtzmIuPVvLC395oXxW4+R156fDY/NUviZweHoFxDUjQWe
	7+tenc2hU7GcM7q87PcHIDA1UpOXCvhH6J3dST1UjqNt+IiSa4mmEJFv/zoG5/ftpPB3CvmVBTx
	rNbuHyBrsXxQ==
X-Received: by 2002:a05:7300:d4ce:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2dd5641154bmr3878757eec.25.1776277836379;
        Wed, 15 Apr 2026 11:30:36 -0700 (PDT)
X-Received: by 2002:a05:7300:d4ce:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2dd5641154bmr3878738eec.25.1776277835851;
        Wed, 15 Apr 2026 11:30:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606db2sm3683595eec.11.2026.04.15.11.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 11:30:35 -0700 (PDT)
Message-ID: <f74f30f6-14cc-4b4c-8331-dbc2c196792f@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:30:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/27] stubs: Rename monitor* -> qmp* files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
        Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
        kvm@vger.kernel.org, qemu-ppc@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZwkiCE8 c=1 sm=1 tr=0 ts=69dfd94d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lK6l18eX4yI4KgfliCwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfX+LxoEzCd/Ech
 jaKC011leHOZmEclPc4fGTXE7s5Gy06IKrcGxfqLHSVUGLif3i8Bpn2NNiuosGbMxYWyRlrHFVm
 fsBBaxRIzJoN8SJxV5GlD23QASlVxjbSWL3lM/XeNsQQgPW4kcHkpJEmTNInh/JR8qZydpr2ZZD
 UfAvXNNFlyHGi5cwnE+IAD/ZQYH9ZwHZ4/ArKdw3FM7jgGPwqFOLvDxBbd5WR1zz9a4i+j5ScgR
 p7yWqb/e1TidvVtFzA+Lpq0oesMAjqDqORMywTDAQE9ThIMmuCtP7fuehaSx53CXNRVxrPtcih8
 z2AIqLGMclUjtueDoAslOF6LxvObwdKDdX+sWL9Mp/N17P0ek7OAC8UWQlOW/PZOMa9xegzuN6F
 zGHqUso4FGRKlzJ1oeqIcjVbyFL7amGGm1LzJ7th7OQ2W8pMTHKVokpIX6utHAsCs4QkQMX1aC/
 wLnxm8aA+WWt6J86cqA==
X-Proofpoint-ORIG-GUID: ygGCN1HMGAFj2PRASbLce0ThQlkDhDsP
X-Proofpoint-GUID: ygGCN1HMGAFj2PRASbLce0ThQlkDhDsP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173

On 4/10/2026 12:53 PM, Philippe Mathieu-Daudé wrote:
> We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
> These files aren't about human monitor but QMP, so rename them
> for clarity using the 'qmp-' prefix instead of 'monitor-'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                      |  6 ++++++
>   stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
>   ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
>   stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
>   stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
>   stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
>   stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
>   stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
>   stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
>   stubs/meson.build                                | 16 ++++++++--------
>   10 files changed, 14 insertions(+), 8 deletions(-)
>   rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
>   rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
>   rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
>   rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
>   rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
>   rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
>   rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
>   rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
