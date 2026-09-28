Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24503CBE79
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622701; cv=none; b=nqv3ffi+eS+JCYXZ5x3O0qB77yZgPTfURSPBIWMDelnCFCyOAxa6+RFVHiaBntTZCjdM1mRCfjFQ5KYV0MD+Qal8HfudjpL95yqrUSHpLCBDv22f4j2e/dEkGVtMvVDrKbYLi+t24iTbIVOTG9zQ0olGGTfDxmgz0Xd9J0iQIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622701; c=relaxed/simple;
	bh=2ncwJcYMrMLeCMi/NGaKZHVNVB0PfWA33A8o7fq29M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5JDNjYXMYTHQjbf28Ha9h/65f3Un5y4GE+U1ueJg9/QARSWrfgZB5GPg4XtrYKW8ZvEMvpSYa4NWkH5DRT0H9T4HOiQMRciy97nS0GutL6atIOETlkz1ttUSjiwpYx1y6/DXq9KVC4EwczYC1OCvwSKFASYmbKJUS/M8jszWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h2DV2rw6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cuXSlGC0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h2DV2rw6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cuXSlGC0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SHwmWl2740944
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	noXi+LkqsQh0kWWpkaXUVI5QBYODwErkMjSelrhWYLY=; b=h2DV2rw6RQ7RdiPo
	4EIItDp4xDn3k47JoY0cFKL3BxBg8kqK2Vl4HkE/8YvVZ7zcqiwOAwy5jCyjSRsc
	rY0R9xfu9/377T0xRF/uGJicRkv72Kl6YOsyyaqpuE6QoP3TQzRMSktz5FVMHz5k
	aU6Xb6rvmLthopPr548M035o9H8Qjhjc6+wer8DOu7Ruxse6aq4NSxPwzoQQXpkq
	4VGMMxDFO9wgpn1H73xO8kTgJeBQ4mU6tECKfhhjsg615YUHzs9JWnBPgno9YhHI
	4uVF1ZJlTLhBiDusE407PeRg8HVovuzlqmdpm7QWemjmdjPXJdRr+u91GLVSpXnB
	+C9EJQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6jets-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:11:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso674284585a.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790622698; x=1791227498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=noXi+LkqsQh0kWWpkaXUVI5QBYODwErkMjSelrhWYLY=;
        b=cuXSlGC0abnusOuhmTtv+QqNP9jTJ5jbrx7F9TIzzoQTRAh1hXQ19zA21wadb8wQ23
         Lilg8eKCu3SakRHAcAAJ7ZYHRC85GWL74m4EGe7Z1xQkfQXW2PxHk2QoY5t70bp7Q4j0
         AZ/zE9TMJ4BChTJW2zRgSKZ61R/etQpfsR78vguaXE6v2RNRGX4NvnfYB6D66P1pYlCy
         NfKqNQY1NTPg7WyRjE6u9QLarPdfH+pfU3j+N4ULW89mLy+HpVGfbu+wmQdNFwR6Xhim
         k9nc/e8K9YQb+G5a54nOpUQGw96Z7+YGlVgYjLxtSebMscE4AejYLOKC+tWiu9GCOFF6
         CckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790622698; x=1791227498;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noXi+LkqsQh0kWWpkaXUVI5QBYODwErkMjSelrhWYLY=;
        b=xgdVKhUwD9zc0wosM/WRTz/n2pGi+8BxCGQnBW+nxc+/niHpY4wxcr/LD/ItZNviGQ
         l+RzfRa85H4ZSTrWd8IYp3s0mFpzHOFrw3kXzLLRdqRFWFUNup5i+7yY605RA6h2/Ah4
         DqTl1comgh6ICZ9pQjp2RsSc9LiVZXhHnm7Db/AY0nRn234+BeNpibIacnkAoL+uJMhX
         XxOduSHMgwMtvH6ZSfoOGAa3nvAv9w4MPTAmFXOnobnp7kHq4lkTQHf21LLVq7aSQrGJ
         9nIBa4CDUqFzz8TDqNpPQRTBtYdn1DFOEDzd+ENtPcBGAE1vBuqmTHvSjNGENRW5Cn93
         P36w==
X-Forwarded-Encrypted: i=1; AKwUvByjNAbLyW//+F3mQGWaZaQW/gN8ObXIrUWgfq2F6TrrI/8NZmMSYV1Wij0KQ9gW7IAOwJg=@vger.kernel.org
X-Gm-Message-State: AFuF++nmXYCSheuXzdXt87iobX/VfiJYqnCljSkEykVyrFjYCLaZOO/G
	mEfBWDNBs+q6Ppumng98SnxrB73so8bp0Pmfs9l4tPBnNFo6xUKUaJHLMnzublGdRH3Hbfsj0Mr
	MgyZ83dRFu7Yl1RfgmxYUIEBY/7dhtXbZZCLqoYL1WjtiASW0N8FZ0Lg=
X-Gm-Gg: AYBFou2p60vjc0LsTC1EI02whgUlKNCe/dGwIwn+oaV3YEnfx6/yZP2tITXH01hcUS+
	Wt6thXubstHj6vxxOxcQrhTzRinZyng6ec6uCGBabe056Ad4PuhmNZ6u2ezvp/R7cHLCX+l4YaF
	McGwjBl61rTH4S2JbaUEZ2e7bw0O/VGvQBQyQSWTxUFW6W+ZOOGREGmBaSwlGrEm5XxDRvEy1aq
	1V/I6LinnnSdqpOQ3vHb8FsdXlEz0xLf0i3ndkrwk50crDabOdnwHAVjLctVZjugwQx9RVxVyd4
	qh9ilxzoE2I7KJD6IJEKhM3pb8DY8fcFBBa4Lz+h38HNDZbHVxNb5ZtGr+jLpykKVO475hAEP1W
	FR8qj+MZpoUTqb0QbQiUiLrNBxwSoyMbw8g==
X-Received: by 2002:a05:620a:4492:b0:939:2c5c:7977 with SMTP id af79cd13be357-93c43c75a3emr2262498185a.20.1790622698122;
        Mon, 28 Sep 2026 12:11:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4492:b0:939:2c5c:7977 with SMTP id af79cd13be357-93c43c75a3emr2262490385a.20.1790622697476;
        Mon, 28 Sep 2026 12:11:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48aecf40a8dsm4822929f8f.18.2026.09.28.12.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 12:11:36 -0700 (PDT)
Message-ID: <1f46d3a3-1275-4ae0-be07-717c643cf0ae@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 21:11:35 +0200
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
 <CAE2XoE8Fp8w4m0WBjEXF3LceFXUqKDcXhdSmhCThgkAM3wRVaQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE8Fp8w4m0WBjEXF3LceFXUqKDcXhdSmhCThgkAM3wRVaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX5zXrcCClasdN
 cBJR2dbkjIEtX5A6OKqJ0maHwAv/WmpZnFaKrZ4BNmDZrXKB809LWJPad+xRm8TSVDPp8KhI23d
 E7ImDjKjRd3gwGy5oGYHNvRomlTl5fLHUSxfjO6TQ9RQp96f5nZnhn9DSCLYpmzqrZ7qG1m7Py5
 iX3Fd9Zkq09UOjqp6fTN0bNDRVqSpdC9lSEDmjQRLxb3hlb/0zKdy8ZAYkVC4LejawMHT6XmyMx
 JAxe/vwp1qoktaobuBuA4Ma7OpOz57HOo2FD9x8hYfuINTHywglEspzXNfofDRtbW+b/t/+eJuZ
 jaRhNBpHmxPomezgSj6ArvtvAzfuklrSXoXsiD0QtJj48LqRLdYZiRDiDPrNVlsYmhxcpIlBusx
 0RMS4Sfsz7JCvQdoLnp83OQgKm39pANdl23/DLFMPvoG+Yy9ZvLInHvRscleqIaj6sD697wJMa/
 iqp5Z6/TMPz/ZSiRU2A==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6ababbea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=kO6CZMfuzHV47rAn5AgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX3kmevLXSC9B4
 wIkXyxxhrcHo5qsk3Ep63+YNryZfyxk9+qzxqFfMVJFsHSy3wGAmjrPu94DO0xD5NhlzQp/77qg
 UiVkfgBrj19y7OpxephI14kIL6ul2IM=
X-Proofpoint-ORIG-GUID: yszYyfLExVZ1ImfuPTbgj-cU8Evu83Q1
X-Proofpoint-GUID: yszYyfLExVZ1ImfuPTbgj-cU8Evu83Q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280076

On 28/9/26 20:34, Yonggang Luo wrote:
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
>>
>> See commit 0e2c5647d92 and surrounding for MicroBlaze for
>> example.
> 
> Please take a look at
> https://gitlab.com/lygstate-qemu/qemu/-/pipelines/2890507627
> 
> I do not have clue to fixes it properly

What are you asking here? I'm seeing failures on targets supporting
dual endianness. I can not try to help you until I understand what
your goal is (I asked it multiple times but you don't reply explaining).

