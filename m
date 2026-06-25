Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6A3BF679
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367729; cv=none; b=EOOQupuzTSxigtqOspi8UH8Q17isfznOVXXG5ifmK5XW9obvMJiDbLMMuwm0xzyEElojrnG0ORQaAwrBAUwHr0bJSnsDRJmT5vV/QHZ8XCKRy0DLBFqpi8kHXkbWmqEAQSvts7MWtqlwXQGIVXSd+RpfJzfak1JGAoMrrwEKLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367729; c=relaxed/simple;
	bh=9Td5OJFe608Ilnd0Z8Qq6AY4LIjAPp/38LxLnb5kvp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2Jz1B7n2MM7UJN43Ywnw54L56HolkyQqG+TW3uHYXAdaahPlbqk+bIJIfb4gDDcway3p6j7d5t4tn0CXnl+OCBt/9NES+nO5f55gO0JcupW7DN0rlpAHsbv5Bgh58dLl3KPKNP3T0Nc5Xhqg2Gazw9RjM3iGRjmVZzpIhRpG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IX3rMXqt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IX3rMXqt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mNs42889202;
	Thu, 25 Jun 2026 06:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bSV3dJ
	Gz7vjlm2IWNkVQl/IKf9n913HrKidCc1q6+1M=; b=IX3rMXqtnzwwJNYhYirKRL
	S4WNToLa8mU49fhAp2670w5/EaWswwhGrL4T4YnAgm+ddW3eQEzLUpWDvAgnHxo3
	mLaqm5deqYNtiumsAwOdc5P8NPakeZDCDoKLloH5pgV+t+odAyHvHd/Kz09wllxK
	hSYWOYGe5meuEKcfK5X7Ox9mxpwf1zEkKUIW9rtOh9Si/pIsoqt7gZnvbAVmivwL
	e6o16yvmZbP8SHLhcXSGoQoiOAfNjHoSsJ/r4bZdObIPJ65oliHp3zP76l55TlpD
	jSIJPcfP3xUjBvtXFSwAN6DvNn+jlmYvBdMd6LPUHwTtmPY6kV8k7t74rKvDOdHQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsyur8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:08:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P64gb8030689;
	Thu, 25 Jun 2026 06:08:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phmncd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:08:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P68PYK11534962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 06:08:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44A858051;
	Thu, 25 Jun 2026 06:08:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596635805C;
	Thu, 25 Jun 2026 06:08:19 +0000 (GMT)
Received: from [9.123.1.190] (unknown [9.123.1.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 06:08:18 +0000 (GMT)
Message-ID: <95280841-3f37-4e90-8e8e-149d659c3f1b@linux.ibm.com>
Date: Thu, 25 Jun 2026 11:38:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Content-Language: en-GB
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
 <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX0WWmy5lPRc/p
 uu5DsUDBgoZDr5ljmP2tjxxD/DNN15x2xfbQeGaD0Wh/0uN96395YItSm7Vp3pgThrKbLgZTpg+
 R8lcHtj/Y4lmvJXm2XhGAmM73OstDkAh8hkK2cHjz6j2g92tlh8mS3JSoV1eaMo3XwWHjuQ3AKf
 fuFFuChievDS3es6BVLv89pDU7n2425r0tVhNePYGPX+WaOVgHbMsRaXcZ9ZENJTmo6v4P/3/cL
 gScolxfuUNQBX+UMXZWz4bMmFvyO8PRVOvhSVO6uEe7yWLZW8MW/JOCSdMUXq4FNlCHQMitCjpO
 EDy8ad8nB6QmS0RbCGecbFe0bKyQUHYlxppChzOsk78sBd2WtLciPGXeu10w8Y/oRPEG2sZfslc
 I5OG97srXpXu7qmGPUvZk5OCuwTApKU1P2fdTUG0HRANh2fRJSUymiyaVEvDY1JHogFnltsyGUx
 hxbwMbOL8M5/eYYLptg==
X-Proofpoint-GUID: kZ33jlWSHrfl-3pnnUOUmM3OCXxaYTGB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX+tYTXVEMNwlG
 GQA9kKCWuNOfpCj0ylmXbRjUAekq8BKcfbbvEggmXP4vsSv9bRKpCb/P+EQ2/DJVdnP5NN9v+po
 0q7qTMn0a2oFDgaTqqRuwUhbmTNamOo=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3cc5dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=K921VAwX_w4cuZeCnOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ulxAsjOvQ8vn7N-_ZS5LQ1YqVbd8fhG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250048



On 25/06/26 11:33 am, BALATON Zoltan wrote:
> On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
>> On 24/06/26 7:14 pm, Aditya Gupta wrote:
>>> On 26/06/23 09:24PM, Shivang Upadhyay wrote:
>>>> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
>>>>> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
>>>>> +{
>>>>> +    if (chip_type == PNV_CHIP_POWER8) {
>>>>> +        return "powernv8";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER9) {
>>>>> +        return "powernv9";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER10) {
>>>>> +        return "powernv10";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER11) {
>>>>> +        return "powernv11";
>>>>> +    } else {
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>> +}
>>>>
>>>> How about refactoring to the following?
>>>>
>>>>      static const char *const machine_types[] = {
>>>>          [PNV_CHIP_POWER8]  = "powernv8",
>>>>          [PNV_CHIP_POWER9]  = "powernv9",
>>>>          [PNV_CHIP_POWER10] = "powernv10",
>>>>          [PNV_CHIP_POWER11] = "powernv11",
>>>>      };
>>>>      return machine_types[x];
>>>
>>> Has a subtle difference, that it may not assert/segfault on unknown
>>> value for x, I want the test to crash/fail if this is called with an
>>> unknown/new processor chip. I believe the if-else/switch is better as it
>>> handles (by 'crashing') unknown values too.
>>
>> We could just do:
>>
>> if (chip_type >= PNV_CHIP_MAX) {
>>    g_assert_not_reached();
>> } else {
>>    return machine_types[chip_type];
>> }
> 
> Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?

Absolutely :)

> 
> Regards,
> BALATON Zoltan
> 
>> That way just adding new array entry would work for future chips.
>>
>>>
>>> - Aditya G
>>>
>>>>
>>>> ~Shivang.
>>
>>
>>

