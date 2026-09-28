Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9F4A92DF
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594973; cv=none; b=n5lfvDvrGKuwss5kuteXCV9AYq8met8x9+mbdEqH7b5B12Z7gFx91uJBhZPS6kc1+X9tjHIFaC+x7PxffNZtdrqnPEy012xRax17f9I1EF4GzC6Oqj0IxcjNZB9eqWzM14EwHjK8RDx9CdxhfWFHZfvk8DdO71wBW7ETRxxo1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594973; c=relaxed/simple;
	bh=BV4/azRzc8VihEhPY77GBXP2bgwxCJBH6WH7vyaRveU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/9LRI0Amk+y3ZWxilptzCsSfEEexg7IzhCQRvkKB0p96mvD4Kyueg2pRmps8rebSXi4ucYRXmxE/QPl4NXrNtEN5vmBE8jJTbC9OVjE/XacmaP9VL8zcRlZdji0P12a0eqOL/hEL0le3aPqxfRYus2zEPJde0TFgX+Jmjz5G6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlhFArqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOaPKktY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlhFArqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOaPKktY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAXX21189846
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=; b=jlhFArqLwsLAEYsN
	s+r+yj0woskk839hHrPFxHO+Qbiy2QMkskMPM1vI9juVV+IIXnPITqMfOZD19ROi
	ApoJZVo9i5X+UcqQqdz8W0rcq1EwriJFSVHN5ug3j7VBO8B4nFFrrqHl6Ou7xH2s
	q27y/yw6VSDuJfQfFtblta2AQR77f/kWNq4GkGNuyUwhyD/k+GedXwHK2nBHkWY/
	m1rm0V3aAliNLBQCr0FHPa8yywAuz79AhoE0+4nbreEB0HjJvRHOyMRpS+9sWWYH
	wyCMNEUvjC54WpFzcoGN7T4THjDaMIMgAWWin96lZr/i1l3S6BgD2egQP3Gy8oXP
	E3Pf6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0fwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:29:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so605829385a.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790594970; x=1791199770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=;
        b=JOaPKktYcPk9F1Pk/O/Bgn5Zh81ksz9AqpQFLHocjk9miBY2VE8dj4uPRq8WZmA76c
         PFPIrL3xSVs6D8+BUa0sQCCQA4KUmD/9yjJoZJLQAxAdxAOYXRxKBsCbZE0wmlJ3LkJu
         cXUb/XRtvOPnF4SunKdlUSkEfYziqA9qUWupQdb+MeE4oQlusmGSnNYijwcXYWNBIM+X
         cN+zGr1IlbUd7L/8Q974qSd8CFlbkA3tkTKPPPBGyrXIVthpPJiI8wZa7Cb4x+R3WlxM
         71HIaPzyGovBM5eEBn6CI4NKJw6swv4MFea6pbgpuwPdAholIJ/uNKbhGxurpfmkALvJ
         DNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594970; x=1791199770;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=;
        b=x4FSZUDik0jsRHI79oXM005gmOQMUN6xrVPYidhdebRNqm2jwUUrVm41DTMIE5FIw0
         j5pulfAssP6N1m7whY7p5J3d6VEEn6j/Tvufw9+F0nECLesDAWT3zJTbEoyy75CMl20p
         NhB18Mg0igHjNPSAETE8Kc6CsKv2FvHfzHu4ewSoTcGrckG2U/Fjj9s19p7CV9OhyNK1
         QcS2vlRBc58utryfp9oiQnrBpP3ItrqogeSy6hYNeAlkayncImAYcODvb7Ect66PsjfL
         wkqv1P3tgmVOLBtUw/9b4KELnAhSrM1RRDGmXAkjWDqcK0Gn1ImYhKlHzNoZ+vXdz7Ky
         ZtfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxY9Ihix0guEBruTVylF2SQaoo0erlIJ00e0dpXIEF0ZHS5MHOIZyx8V1ORW6kuGPle1ys=@vger.kernel.org
X-Gm-Message-State: AFuF++mCB6+s/74CHvqFUzL8Yd4A1pSpgGqFZ4QWORw5JDkWOEwIjkgl
	Mwwp1lPPW+iYDxjpNTq7rMMeOgtGueCL+ubjOhT08hfatL+pSEHnzUQFnyCAOGDr08N+9cJhrOl
	K3hiczz/ZBsAxtqlKGPDMsMZN8PqqRdXvcEK4rS2s0x2JMLb7UUHCuQc=
X-Gm-Gg: AYBFou2t4UaL9ih6WJPW1GwvelKSbtowOtVPH3kOuHTx1MeO3cUEC/X/58gY01H6qK9
	kGASyYnpLRHfzcYJUqc8sEKpehmNyCME0AIab5SaIET8A/VlHew8yAYqlylJZNrOGDXPVFarg7Z
	cCNTKxBZW4w66j5LAJ3FM3HlmPl0ujPn/XqLg8jMf1fUbZuRIZY+WRMxkhwNueHwuhY1BrgD98b
	WVKKJG93DPCvc9L4TA4qHAtz8O5ZNQm49XQAI0WQUmHfYVV1tYOHYNo9DgLlBlpUiRXR3/FEJJt
	NY/10zcayLA2d2kZ0wfpVN+/kJ2HQwDqjOPoyx5oZ55sUFKtqwofPXpoty4sVxiI3loei8rr07B
	Ghv4FU05oEZkpIGbN3ideUhFQP2zkuUwppw==
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id af79cd13be357-93c43c9fcddmr2067539085a.38.1790594969644;
        Mon, 28 Sep 2026 04:29:29 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id af79cd13be357-93c43c9fcddmr2067529985a.38.1790594968934;
        Mon, 28 Sep 2026 04:29:28 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff141948esm5976215e9.1.2026.09.28.04.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 04:29:28 -0700 (PDT)
Message-ID: <4da49cb4-6044-418e-b003-81c4ec6d6ed6@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 13:29:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
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
 <arpH_2anGV-JU12e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arpH_2anGV-JU12e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba4f9a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GQHC_H0yiGy-f9nngS8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pygCjv9FtzjxOzPAgmfQUZm4WIF4-tsz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfXy6dtITb3hARh
 SxdkmpKAqQSL1LDYqxhfgXNYEqvQvUVAS53CoB/PQGWpGyj2qjEhapg6frD1IvvMgjfC6cClx/a
 A0Zvv4zvJLQSR9dbykpNo8CHHDYxdrLxUxqoYrHwH3Rbs+466ovfxkOP9r051oVb2vuC3z9jWE+
 Lpt4JhejRnk3K8TAcawhYMn/2axTLH6l6fTA6z8WnCC6s+86vwYcrZRfpbHMdWSBmknDNVL4+7J
 tdea6ydqWbyc+BjzAUtAb4re3qz9WmjAjPWfrwNOhF2pS2sULnbgydG3bCLtIEmwYsSb5hlCnhP
 zIcLC9wYMlC3jfSYTzgIFe8qb6eY33dqqqvvtazcIaTie2hh8qLGLZ8unm+CIbz+XziIliCNQ60
 W/4asJrSxnJae3SXYCyp4T5HWZR9Ruk8iwcNrUJEdFktd2gbEpV2MDYTFwg9gJpkR2MgTZ/pwI/
 d6MCcPLCInbwj1WpFDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfX9TNmOMvjmxxD
 SKQGzGBLaUTY4wcvhhu/jt24PnHjvsbzpgBAFGzbrhnWHNSh8K+BW6ZP/P50wYAQjd/mldh+dSu
 XHWc+yH9j6dKvUGoNEJiO1PEQzcNLKU=
X-Proofpoint-ORIG-GUID: pygCjv9FtzjxOzPAgmfQUZm4WIF4-tsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280045

On 28/9/26 12:57, Daniel P. BerrangÃ© wrote:
> On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
>> On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
>> philmd@oss.qualcomm.com> wrote:
>>>
>>> On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
>>>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
>>>>> query-targets lists each linked target, including none, with its
>>>>> arch, endianness, and the machines that target accepts.
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>>>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 65 insertions(+)
>>>>
>>>>
>>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>>> index 6aaa2af709a..d8cdea6203e 100644
>>>>> --- a/qapi/machine.json
>>>>> +++ b/qapi/machine.json
>>>>> @@ -307,6 +307,41 @@
>>>>>    ##
>>>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>>>>>
>>>>> +##
>>>>> +# @TargetMachines:
>>>>> +#
>>>>> +# One registered system target and the machines that can run on it.
>>>>> +#
>>>>> +# @arch: the target architecture
>>>>> +#
>>>>> +# @endianness: the target endianness
>>>>> +#
>>>>> +# @machines: machine type names, not aliases
>>>>> +#
>>>>> +# Since: 11.2
>>>>> +##
>>>>> +{ 'struct': 'TargetMachines',
>>>>> +  'data': { 'arch': 'SysEmuTarget',
>>>>> +            'endianness': 'EndianMode',
>>>>> +            'machines': ['str'] } }
>>>>
>>>> We already have  'QemuTargetInfo' struct which is used
>>>> with 'query-target', that should also be used with the
>>>> new 'query-targets' command.
>>>>
>>>> We need to add the 'endianness' field to QemuTargetInfo.
>>>
>>> Why do we want to expose endianness, and what endianness to
>>> expose? Endianness is a runtime bit state of CPUs. Sometime
>>> this bit is hardwired but that is an implementation detail.
>>
>> For some targets it's, but for some targets it's not. for example
>>
>> mips-softmmu.mak
>> mipsel-softmmu.mak
>> mips64el-softmmu.mak
>> mips64-softmmu.mak
>>
>>
>> mips64el-softmmu.mak
>> mips64-softmmu.mak
>> only differ the endianless
> 
> "EndianMode" is a tri-state including 'unspecified' as a value,
> so we can cope with both scenarios - the targets where endianness
> is runtime switchable in the CPU can use 'unspecified' as the
> EndianMode. That behaviour should be documented in the QAPI
> docs for QemuTargetInfo

OK but still I don't understand the usefulness of exposing that
at the machine level, since this is a CPU property.

Machine != QEMU binary.

Are you trying to expose binary properties to management layer?
Can you explain the use case?
