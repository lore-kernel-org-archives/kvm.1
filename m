Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F64AA019
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595286; cv=none; b=NvRuW3MvYGC2oo5yE8kmC5yy6sua3XJ0MdoOa2bMVEOMnv59g4qpUcAldXDh0Pb4nJKX1FU5kHmOWWbh29GvkiGNlm3/kg6qZoYnrH1Mc9LxDm6aJGjL+D82iWiXuv3TiueqJxkqwqAeFkqRhdQF9xw55UVpFKEOPMARyK19J+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595286; c=relaxed/simple;
	bh=nMbwPfTbgdanQXhA4w/MfVagx0iKw8ZqdNh57uWUNZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slCCCBCP5rUnIsnTkiJ/PeZH+bT0FPz/70WPMErJ+GXYe8u58D0uLNwKt6BzJOD4Vj4EeXwSOAJfa2w4zg9SNOKKPVAqStNbke2aTXyQG+pcb3C8NiuLM6ewMa5v+28NyBX+xUA2Gvp/GJJatcAftJjnpwzRyg2ujYslwoqFwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cj7mBMJu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YcyyDMct; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cj7mBMJu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YcyyDMct"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBARt7482015
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sRMgH205JmlJ6dUdUN3XjqTRDQ/KTrIRidMWmDxPQUY=; b=cj7mBMJuZe/ct2+7
	y90isdE9iPoNRZb6McaGw8Qi5IPPuoHcJFASgqAzPEDKzTD5twy7w6SpGIwnv/Eb
	8YCatnh5A3Yz7dktDuY0VfhrB/baD5KkALVypegIgzgAsQ4uSiW6cB5PdPmG6fOx
	u0JpRKiegGqSKIHNDgmeycXDtYWOKQXZbnDtNmBs8BkricKT4t9ezB5QlBLzfst4
	AiGq8bG9JgC1jKIv3ig92CtronvA9FRkACMLZgX14o4LYjTR7Mu2p3CrEk3vUnkx
	1pfdspoBEjcbzWO6HaCEl0uT36XqChUYo8E/TxiF7FvPisA9k2JH3lPsvmPUEofY
	hMtSpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt115je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:34:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a05d645acso634254585a.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790595283; x=1791200083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRMgH205JmlJ6dUdUN3XjqTRDQ/KTrIRidMWmDxPQUY=;
        b=YcyyDMct92yHwv7q7upoh3fKXLTl+BfFI8Z64VmEvZRgNMtc7u2d9GZNR1e25h7eNj
         1s1NHR4O2KZ1Aaem8+UrJx31EQb0fCNtumwqQpERLyYOqvK8U3jxuABrisO/avNnKHuQ
         dyZGUdir0sgH06/LH+B4nru+ZfPgi+lMyWfSx5bbCW/DFdxxPBhDoAOqJzW43dkj7u22
         0o59ZxZsKof62gmjtEbDVXgNbgh73JkguE+RvoBgEUyA5skOBNjQPoxkthumeF3UJZVj
         MoqJCewls3Z21sVhtn4gKsWQFH7ZG+dxmotMui6YfiKBDJbtSyH9C/W/9szwBrdK7cF+
         4d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595283; x=1791200083;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRMgH205JmlJ6dUdUN3XjqTRDQ/KTrIRidMWmDxPQUY=;
        b=ecxP2CEtYJ7qX7aqh7e3gKBypFWo7LPl8Oy1vxv1CrxCanhgRZJbVWpLX7RtPHk5K5
         mWW76hX7f+AwGQnyBRT7KJDH5H6RYCauzMYnTskRKt3orNp1I7NkWJAQxRbHpEzEhGA/
         sqPT54pGsPd1ZmBkxqOYsKLi5yUPQuzFf6erd5uXxOLsV7bowdxAXCn0LXSEfxHCQuHd
         CWBRd8F5suPPd340+yHa8vZSjy6UDkTr8JLOgHqwmYSsTMjJ+7fCS2dS5QApAERgh6Wc
         w8A18YSEz0EwpEdyCmm788NSqYe+KM0yPdmoyClmOQibLWwxchdB/CmXDzD+yS5S9JwN
         yaiQ==
X-Forwarded-Encrypted: i=1; AKwUvByIkghcJvckzmjE93FWDLnxVru8cEdPvwG/3YFDNbCwjBg/V/vXrlW0jajRXAx47p80yDY=@vger.kernel.org
X-Gm-Message-State: AFuF++kFD6o2V0nGSqSIuW+trONYDIjTB3ulTirQN2GMZXMRXmj7zEku
	2ET9kkeTNSY1qI2Solgq1BFBb9BwBl1qp7yujqKqKZ+S0FF0ptduCuNIhEpMHyORd5KOjwEblW3
	afJZZxkGmG/zv+CzHWKHIty/EQ7mJKkZJ9j/K3RVprFAcNpfmRySz2Hk=
X-Gm-Gg: AYBFou36ZGHy1qQe+qXLYoO87mvNulB4qu0oIYBl51By3o+pif0FOOrLuNGG7Y3feMy
	VHGfgN2McuogxN5pboCHoOLE6+ry9LETkL8nOi3BiaCZPZR1z6BFhlDLB2hK47YT0fQ7j+KlnXd
	zhnKMLbg9JS5wRcbdpd2gBUqz5HMlePMLVBH4tzs9szeekCWx7vg7YBDE1L9ke+sl5Gf32WQ64W
	wfq7+xbIZfW+xemylJj52fJK6Tsb/L8AKD54pbWlS2bLKNZcG2pxExVOckLf95l2FQewLRC4ZXj
	ivY+nYGEwaAc9fiSTT0FiisDA56pIbY1xz7tLquPNcnOyDgu2pGfYFeSEZvHQS3RnFYiv0YaMlj
	e+gCTcojkg3AV+XoadFWe04r9+DCG1CPFQg==
X-Received: by 2002:a05:620a:2954:b0:936:df48:d507 with SMTP id af79cd13be357-93c43baceeamr1894035485a.18.1790595283142;
        Mon, 28 Sep 2026 04:34:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2954:b0:936:df48:d507 with SMTP id af79cd13be357-93c43baceeamr1894030085a.18.1790595282523;
        Mon, 28 Sep 2026 04:34:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001778312sm315502635e9.8.2026.09.28.04.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 04:34:41 -0700 (PDT)
Message-ID: <a4b7056e-1651-4167-86e0-e7eaa3941d02@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 13:34:40 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Content-Language: en-US
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-arm@nongnu.org, kvm@vger.kernel.org,
        Thomas Huth <thuth@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com> <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX27hnoR3Bt5WI
 Ytz1PGXNBPCZM9Lfjlc+Uq54JG+5vyM8RreWGu/WY+9YE8QqUOGer1EVRWKCcUGQMQA5C16AWGL
 xMhY1f4qqnpMXukQ3a3m3FS279Y8p2m040n2PeqQ52+RZG1zWEndzWc+VpXPMRsuLI6b0khpy6r
 VKdxT1w8pLmxy/lBuzqUmiRpME0yIxWG1k5b/SbpNHxUG5UIl53qYpOdlfGbJQI9Nz5Scaa88eb
 aYlpvypeOK/19V6iTEo0+vls3Ekx/h6Dq+ftbAHxwLRWBZsZ0K8j/QkdTqrzumu2b8PkOn55h/V
 osOz2mmaYygAw1EMu2can7+UzykJkJHugcB4SAGdpbaDSP3DpYCGnCDDYuPnej5VxBju4bhhzWG
 NJsWdjhO0XN4Xb1bmWcPwWFsMXMikLu5lkhQW/uukx1CEBNPQC7YZ31cy2H+CqT8rc2pxMEh1qK
 eexZnHdxzuZmUJjfUKg==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba50d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=DzeirrpXcSkLjWCSE7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 8zpgzyJVHlv-sBD8Uk3oZdW2l7QwdpNl
X-Proofpoint-GUID: 8zpgzyJVHlv-sBD8Uk3oZdW2l7QwdpNl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX/TPWfeZGA8rm
 HKAQvy4IM9+Yn6pE2BCWJak5pMhRsr510N2o3kRe7JE3Cieqy/kkEZ0FU4kwsNNhLm78zTuUhhK
 7WVXmiK7qMUlfjYPHOowbRXiQCGyJrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280046

On 28/9/26 12:51, Yonggang Luo wrote:
> On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
>>
>> On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
>>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
>>>> query-targets lists each linked target, including none, with its
>>>> arch, endianness, and the machines that target accepts.
>>>>
>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>> ---
>>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 65 insertions(+)
>>>
>>>
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index 6aaa2af709a..d8cdea6203e 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -307,6 +307,41 @@
>>>>    ##
>>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>>>>
>>>> +##
>>>> +# @TargetMachines:
>>>> +#
>>>> +# One registered system target and the machines that can run on it.
>>>> +#
>>>> +# @arch: the target architecture
>>>> +#
>>>> +# @endianness: the target endianness
>>>> +#
>>>> +# @machines: machine type names, not aliases
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'struct': 'TargetMachines',
>>>> +  'data': { 'arch': 'SysEmuTarget',
>>>> +            'endianness': 'EndianMode',
>>>> +            'machines': ['str'] } }
>>>
>>> We already have  'QemuTargetInfo' struct which is used
>>> with 'query-target', that should also be used with the
>>> new 'query-targets' command.
>>>
>>> We need to add the 'endianness' field to QemuTargetInfo.
>>
>> Why do we want to expose endianness, and what endianness to
>> expose? Endianness is a runtime bit state of CPUs. Sometime
>> this bit is hardwired but that is an implementation detail.
> 
> For some targets it's, but for some targets it's not. for example
> 
> mips-softmmu.mak
> mipsel-softmmu.mak
> mips64el-softmmu.mak
> mips64-softmmu.mak
> 
> 
> mips64el-softmmu.mak
> mips64-softmmu.mak
> only differ the endianless
If you look at git / mailing list history you'll see I spent more
than a year unifying QEMU endianness. It was too much work for a
single person so we decided to reduce the scope to ARM + MicroBlaze
for single binary and we got MicroBlaze unified. We don't want
an endianness-specific single binary. I'm not sure what you are
trying to build, you didn't clearly explained what is your goal here.

You can find series unifying endianness for MIPS, not merged because
more things need to be addressed and not the priority.
