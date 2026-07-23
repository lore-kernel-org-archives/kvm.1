Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421F3B8BB6
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803336; cv=none; b=tR+MdjpV66rXDcN6AANJcTNy39kkll6dkyMi8f153tv1DLL7l3vSTLi/+DRd/S8pa1DOC8Svd0wdBTfFkDFPNeVvJAj9b3MNsKXDSsJgR1xk9uTpJYIS0z3MW9Zk8E957Ff9ogdgkB5FtKKbXy0/jhZtXUQIjEG8P9NUtWvLKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803336; c=relaxed/simple;
	bh=7YYmCp1dn/aLPj9FzMYgNxEn06YdMvXMQM909PaYx2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ6V72jZv3eG/PA6xyrPVUzxpDNGSNX89mMhoamBpPcJXlII4bcKQ8QdFjgjR84LYR3e2pq5TgELX11s8n+scU8DGUBsKZ1Zq+73pYIZjcnMxTChfHDU4q+2HO8D+KZdiEHdyvFBFQ+V6hRJpwYI4oCnZbxt09smKLgAOLMP8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIhOJVFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGVfVgKq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIhOJVFc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGVfVgKq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qkfq3642784
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=; b=VIhOJVFcJplmZD8Y
	xzfmJxRfRWiilxy1Xqe2jmuHksd4oGh6qhq6hI6iiXEzPCGCmUMqDhSIgVe/lTma
	g1e+9xGoB3yhB3fo5tLvfRdVsq+RVOMBpu7CEUAf4DpMDAJjtR1Nm/1zY782veg5
	HcX2Vxo/ZBVXPiRUQ5mxSrmndGYJiQItxOuc8T/hqRTkNdBriZOdzlsWQFJC46NK
	RW5AMZeWdQpjkZlXdCLLeGLVQwCow0fi8hlK7gv8tOsEMpZjjDmZ6e6NFeSSbxdn
	JfLf/hNnNM5QyuGO4A8uPwNUfBBkBDzZSa0ohkIFycoMCPqrrjR0nidJBiUdVBgZ
	lnOLeA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayh9mdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:42:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1c7f135bso8606221cf.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784803333; x=1785408133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=;
        b=kGVfVgKqbYXLPGJEEl6unqrfWgzKeboLisTmu8AdNIwhMDcvDyNvhSpxRY4N2E43xv
         VeQnHkFYX598by7MK7hZ8x9YN+bmWAxPkusyV/g4MpPmPiD847egCd6m8bLSrAaygfFc
         Y7yDm955bSVZ/YWTnICP/DMujzlZ0w5VmQqR4c9Lcs8wxf74ZP9T+8GWrSLU4FzQPbXG
         M5eNQYsmszyHNs4gsQ6LpfnFNKQws6SGSY3veS+w/FXjltD939H9iliTuvJeQ7IjsS9i
         6Lrl4eiLOG3ASbucmBdjh0mYSOLzLi1vHqKX3mkD2Krwlp09J1Fg2vGQQyZ5xso65CT+
         mL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784803333; x=1785408133;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9cujVT+57YtBztmVSqn/dI7dbXsu7Rs9Z6S/SDBy0A=;
        b=P8MS6hHcMNkGuqPBPBP7c6c2HYK1YWHqeMrOyFvby9m5kgPdAPM0PWnQkcwGgMU0aN
         9XqdeniEwdniz6inbmPxnJTbV1LvS9ASjZWYpxthnrdpFZwJWy0nrAHsnoYQgbXvm2C2
         6IsYrZiOrvmszzDwS7uFfVHSJPIlk/iWE9F0/p1PqAzT4EA9tTIye7VxQoD8svsM83LX
         W5aNdMwXR5zSR4wpoZ79559W3PEzKWFMwwzCT4giwKfiNIIF10BHDKuqbeUK4HBBbsIa
         auQVgn07vKFy6QkGe3N+VrCinkogRaQDOccq+8IEg1Unx409hwDTJNzaRpRbJxiTqXZQ
         zR5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq775EvuJKgCYFTyZD0k2YvX49cpUcnEaDd7/+w3g8BalUaDOqP4ZDAjNidQB0mrS1O8rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2JeJRrh19BdE2zMILp1duA/MXh8Dw3RyMzJ41uwYQeCV4bAL
	kNjxHWKXEry7zqI9ZCigUFdjNzSusQGooEZNn0epufHQ5Wf0vsiZYGpZcpQHrFQ5+suiEMUcKJe
	H54w+LmGmIsdrMd6+r4I/qKc6md4vqmwzTdjzLHOcB2P4yf0Bd1qHf68=
X-Gm-Gg: AR+sD13Qf4srl2PUwhhsNPGXB80L13GkH+J0fSlxFblgWYNpO/SnCsgpX9JOd9IUjyZ
	Z1WNIX6PwF2+P3l6j4BNibl/5cf70WyrAcFYeG2sfWneahwfxfbv18JOb1R6ZNrraa9rvh7ROUG
	Pq8jiug5rY20DATFOcForuXBtQrjeTGzZ9vzmGF1yWLBxIIOtUPlO9n5Rqe+i1R32DS88kBtXA5
	2zwmax58dZJd9V0XxuauVUJYr8pp9sED/J8NLpWJGXNDzwSZhd5h4sDgWGAfcGnoI4k28r5sSsb
	mwbHUf01mAF/nFuW+w/a50oI/B73IEr/6c1LR9U5CySpjrUtoSVS9fsGL9BH4MtcZQxSRc6mXh+
	TNWj0pV/m58Dq93LD19Mdj4FV92m8FjFVjKOCDi7A/qBCAkBddJU=
X-Received: by 2002:ac8:5cd0:0:b0:528:972:f597 with SMTP id d75a77b69052e-5283dfa12a0mr20960071cf.60.1784803333273;
        Thu, 23 Jul 2026 03:42:13 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:528:972:f597 with SMTP id d75a77b69052e-5283dfa12a0mr20959911cf.60.1784803332892;
        Thu, 23 Jul 2026 03:42:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bffefsm194425625e9.9.2026.07.23.03.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:42:12 -0700 (PDT)
Message-ID: <be427830-c5df-447d-9ef0-bf921ac1797d@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:42:11 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
 <87mrvightj.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87mrvightj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a61f005 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=8HBRM8kc7f_oyWAv4U8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6getKLDbVhVKp8-Bn1k5CydlEIvDJKX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwNCBTYWx0ZWRfXzRvfxLuZlLd7
 ZyKjlKnqPdT3DJHJIuX2TPGVLORnbjvbU5vYzhHKJdv7819q+w80lQXO2SF+r0aIrTht/BppbZX
 dKkVsTRmkq61vDY6xntWaMCdBaK0OKSDB0oiBTRxnPcFyL4IW9zteIpscU+7bNGcgiXS1zy/TJ4
 RuhnwHE3lNuEoiKSMjKe0SkWJNChP1CpWIDy36PTo/NdnsLBBLS5TpByQT1AuuCMiEmeevFfSLp
 6mspCsW7Seb9BvBy3xSg+wzpWQMHvmqhIi3RL2aKx84v4Zbx8EWl6x+RezWxhLW+wqXLyZ6VvQ2
 Xw0XuZViE+8+vQ3VIbhi5TJfoasGKdQJPmzE1L0Udk1ygtYnV4A7YLxjmrnDVeymXpGrWHIa7fL
 UWbL7MOR5oj6UXFLnwZT+kYx8/BbwEWe/DLXYPj1itcIdsGq8MhEhsCmslGqm3rvL8a+7mz7uSR
 Q9T2quobN45t5n+S14A==
X-Proofpoint-GUID: 6getKLDbVhVKp8-Bn1k5CydlEIvDJKX7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwNCBTYWx0ZWRfX9bUtHzOnQgT4
 xSm9e0fKrdfLM8y7uTbnEIhmaGZCHnYYn7/ceBdJ1nwK1rWrwlhVtOuU3GD3hrHWEyvjQEuPUwW
 xgQqgooZxH/CY0aYNVJ/E2Z2u2hy3lk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230104

On 23/7/26 11:45, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> Hi,
>>
>> On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
>>> (inherited from memory_region_find()), but both SEV callers were failing
>>> to release it.
>>
>> Comment orthogonal to your fix; odd to have a non-monitor code
>> call an undocumented monitor method.
> 
> Which one?

$ git grep -w gpa2hva
hmp-commands.hx:538:        .name       = "gpa2hva",
hmp-commands.hx:546:``gpa2hva`` *addr*
include/monitor/monitor.h:57:void *gpa2hva(MemoryRegion **p_mr, hwaddr 
addr, uint64_t size, Error **errp);
monitor/hmp-cmds.c:715:void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, 
uint64_t size, Error **errp)
monitor/hmp-cmds.c:753:    ptr = gpa2hva(&mr, addr, 1, &local_err);
monitor/hmp-cmds.c:827:    ptr = gpa2hva(&mr, addr, 1, &local_err);
target/i386/sev.c:1579:        hva = gpa2hva(&mr, desc->base, desc->len, 
NULL);
target/i386/sev.c:2093:    hva = gpa2hva(&mr, gpa, data_sz, errp);
$

> 
>>                                       Should the method be moved
>> out of monitor/hmp-cmds.c somewhere into system/ and documented
>> (likely in system/physmem.c, also moving the declaration to
>> "system/memory.h")? Besides some day we should be able to build
>> without monitor.
>>
>>> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 

