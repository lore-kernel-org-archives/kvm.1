Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25E30569F
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272384; cv=none; b=ARGsJAH22AqjEx6q5Am/TFfZSZ+9Jyb+Go3pDj+xykO1pKOI/viYKKYV7HD0+Mj2omax0Dj/s0aXjJVPmfPIOUtZM8Hg3dbNxX6IUV+liGW8F2rnbYka9OGhKxMM55RHtVHPu9qiGGuZpM8nkcAZDFLdpjpCKtsbWFVnwYFaL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272384; c=relaxed/simple;
	bh=NvPRagMoAGcllsF3+R+yX9QMlZcU+f9paSqsxYW8mnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8rEWzjVtuYQNERJ6yq+67HtVKgWcU06YBJwm9Q+40S/u0ieir1dYi2SSIt5p8VF8eYE6ujcf5asUWb7RFQMT0sXqZtUwW2KlW3qA4swfDkzvtSh9WdxAy8MJNJtqJKBgZBrvcmMyXjISowAh+WGQ2MerLb6GfUQrt5r8U9YFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLHgDTcp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MhSVX6eU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLHgDTcp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhSVX6eU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCiwAM3617519
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 13:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=; b=FLHgDTcpt2TthnL2
	emeB9tkPhqYDjVnpLoCAewlnGUHvhg5rHgDTlQG/CV3zrNbI8ucmPw7/X/NjQWvk
	rHsQ3nYKhC99twMLALdxCuTI8O6MBpGQCioik9YlAmhXCmPUCR0rwQ7aHO1tD6hb
	gxOEfqqlzwvOmsuI/WSbGnrGc7LGUMw5zXl/j5pEJcD9ikevcEU3DqoO5P9oMLD2
	pefuRGOInO6tQrmXmKzLOD1VzvZ5AIBXA2bNlqAiXq4bRlVt9ApTFR0dwLPxbU8m
	RzntX8556NNuGO413MEQn6dnHYpdeAiccwIHFamtdtPXjj+JkxrtPM1BvDkWzZuF
	DV4IuA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gb109-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 13:53:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91574ad681eso152486085a.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781272381; x=1781877181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=;
        b=MhSVX6eUjul5TNNXQgdN/mTgqri87IRJ0WMUBw9cTezAEMQfPZ72/YxAmJ/UB1CLwE
         haSeYIe9osW706s1Qr0fGCKFbkWDNkktdmnr7PZ3rVqg18qsxQ8gsMVJYrTU+uX8eaTG
         XKrp3QBAC6hOT/hnOL7WplGfJ0lzHvR+q+ds/IoJTbALc2tUsn4Xn9fnqkudQYQsaodu
         GWvaIxLdxdwYj0UJ9k3EvHuBD3zyAFcBG4r4b7YXuvKLuTZMUw+D3j9bOgbihZKe02yo
         nFeB+yBk0uT4hvcxqncCeWPQXTRTy4i80bAozy5I1r9eoPhz5Wu0X9kfrJQzPlyIui8P
         0V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272381; x=1781877181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=;
        b=dzl9ffm1vZwoark5QLdILU3GFSSeBqx92c92KGpauhqh3+GFcnuSFgjsWuju7nZrmS
         iV821zUWWP1xUDWNa3wdKB5sxxI7oPkPxI4EysYxIU5q35MrDmClxCy3WVnJzwiEHkjZ
         jFhJLLe9IJZlB+vDbHxbMuZmD9Vaw4oE7YRPM1OSvATD6itIJoytoSfSh/ey68cw6A1e
         yOQfAazooR34Acey7gpiK9+JlWHrC6sfzZnufgVjyoXHRZKdNY3LScqg7C4SiiCLp0jf
         HEWMv34amEQwDzkMpjG3HenAKO6fPIwnL8EQsaZLq76hsQywPdDMo4hj/Hbz5qWKGNuR
         wImw==
X-Forwarded-Encrypted: i=1; AFNElJ8zsKWLLenttGYqw1ygptEFoU9Retn7Pa852K1RFcRdPqk2vFXfFZQygOfySydTf73UO5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OHlgf5eo+BmWPU99BxbouydNDdBlEWUSb3WUBXYrXaAVDrCD
	z5DcR6qpaailzpJGO+8hdXEbaAonnfWhkrjd8pm12Rzvo4oPqOzvmgQa1m1ZPhQAHwFHC9gQkhj
	WRPqQ5F09vDyCqXOObyoxhRhJ0qfKrl48nGnflq4wYWXRNA2WvaIlZXo=
X-Gm-Gg: Acq92OGcMLYDCrsFz+KYfRzgN56rOKNNvhRqSrpJamNYQ721zyVktBGRNI4KfSSadcS
	wmFrwIe0GTq7hO2avmnkfu9qBxDZd6eQ5GMwpygtlrWr3r+3EON8QlRvrJ0/HkTW9hS/xNO64EF
	v8+6pXr3wlqLkaE4Zv9DK8PFWPYmjOvTkMOJLAxhlhesdfr99H3O1Iwk9S0DF/8K7PNReFPUY+N
	D7YuG9fAZr2SQv559SBdof7BhF2ZCnSACxBrcJBy2TGPJtQ8zIaAtcHogpY87+as3V/h7Cr7DS8
	iu9QSELbHgV5L6Vpl9m1t/0p5eQ2pm5JnsFymF0D08v7v5HD3VsrO9X0tPSJmNolgo5yzGKL0L4
	v6iPehfCdp7GFCSta9Kb+ijsn8FeNCHX+1TGGqQiHWI/vo0l8/JfOlPT+jgGb9lvxdvcQNVm5
X-Received: by 2002:a05:620a:4515:b0:915:a811:1707 with SMTP id af79cd13be357-9161bac4a5cmr404930485a.5.1781272381544;
        Fri, 12 Jun 2026 06:53:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:915:a811:1707 with SMTP id af79cd13be357-9161bac4a5cmr404924685a.5.1781272381098;
        Fri, 12 Jun 2026 06:53:01 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm6259245f8f.8.2026.06.12.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:52:59 -0700 (PDT)
Message-ID: <3e68d61a-6ced-49b0-a122-a184ab83c6df@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:52:57 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
 <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
 <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX5DYRriX9hIiA
 i22zUYL48g86LOfSZ7pZ3fsq4fiLt+BSSTmqhHFrak26gZEO6piDMaSivipWaN1IjWJdpGKphXf
 5dtCeTe96TB/tZZvGVPDLvmM4ty9gz0=
X-Proofpoint-GUID: 4IjSKHa30PDZmcj0vK6accKZeFFuKh9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX26hAq2hOZUEo
 KIFATExRaj2BtGHOFpE9jNXpNxMKvv77TZkr9v6ou8HXIdZPeUTDtndWMoNI0vXZuUoefh3RHCG
 cWN1ZP9JnWGHvqqew+/MzSvrIuwjpz8QpoaqCRdCkE/MUauNTpumuk7bxO56jiOD4bB9muBAVAD
 aaoEgGpGjonlyOq0tG4ZFrUK2rdLkFkXMBLSng1HVGhQuPLGznsptGrmr+1XPRoXwlq39wCfcQs
 YuSuAlWZmRdk8A46p5HHO3xHKgphrnmbiGj/xa968jYx3NM4SQEeoiGXj6G9WKYweD1kGyR7Mw4
 r1uoTku728oTBMTs/rafqUdkDxYxRuUIQNyvmjb1BdJqvCY8xUeAvladkWwe4QLFmIBlq/duRMq
 E4g0HKJK+Ead6Pfpv5VQ/H5gbEzmpmqTyakTi7PUbGoKDAIb8/a9fLpAdGFV9mkdtRwJqZG0xP/
 VPxertOXGJj0KprXQ2Q==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c0f3e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VnNF1IyMAAAA:8 a=dC97xGjGZpUxjfkWrzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 4IjSKHa30PDZmcj0vK6accKZeFFuKh9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120127

On 12/6/26 08:36, Aditya Gupta wrote:
> On 11/06/26 12:12, Philippe Mathieu-Daudé wrote:
> 
>> On 10/6/26 11:07, Aditya Gupta wrote:
>>> Power8E and Power8NVL were deprecated since QEMU 10.1, with
>>> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>>>
>>> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
>>>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
>>>   docs/system/ppc/pseries.rst | 2 +-
>>>   hw/ppc/spapr_cpu_core.c     | 2 --
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> Squash with following?
>>
> Sure, you mean squash into patch #4, the target/ppc change ?

Yes.

> Thanks for reviewing !

;)
