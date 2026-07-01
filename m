Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A23612EE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870705; cv=none; b=Hjg1Luh4Yp9+pKiHNNegvcTdQ4aJqkv161G0vPyYD4bJdYQhTca/hK5NEcEaZVUcXKh5gHlM+5ccJHWaLtP1uiTA32Uc5cVIJZzA2TdzO0pwdfiWLo64830p5Pq7UgG5ro/w8lEtULSK4+b+cEgWxpZtsvkEE4wDc6oFbroLbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870705; c=relaxed/simple;
	bh=BqYWcgHoyzSObWenQW4pBTjNmVsRCfcInpne2k3r42k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BwyfY0EqfsB4IG6+TvRIhGljl7HoGHlUkNcO8s/9Kb0Tz1QEb8pSak5vufrIL4L5ultTJbYTfBcMaUSDudqun+Ifuy2uQefMQ/pJ11oI9+VDJZqNclPF6tUGbcW56oSZXpsYWI7+AHbwmejiO6VuzQaXNmJumHZmupcAGv23q14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUJRuxp4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUJRuxp4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNIinO3447412;
	Wed, 1 Jul 2026 01:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zg9Gso
	g+INwMexCAZDnVjLCwm7LGqdvw/U+v0xEm5Zk=; b=cUJRuxp4C9RaZyhK1BFv8C
	Mff0HfkY8oxt13vSqEm57/ZM+FvlUiseV5gKnRCTIB5exTtZcniUil0r7x50k/QF
	QJoI+64JUNskkWVxVGqo+/9WEVI8tQBhyDbBbA1WfxeW1dM5n5ef6Eh82mEiV98z
	j3WuBaUKdgOX4rmvUfGz8ypXjAu0GZTfvMd0Sp2dPUYafdCo/JYQ6Dlh24gIBsrh
	/xhXsrAu55w/UdenVvgEcmXzA8UnfD6aDgts0Sb6U3P8JGWkgBsQRvcGwpbEI42Q
	8xByX1gvd41KjPvIuHqpGFifoq1eII1ck3K6itrxEwjmtCn3hF15MklxmNRWQc1A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe209y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 01:51:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6611o336005094;
	Wed, 1 Jul 2026 01:51:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhd30y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 01:51:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6611pPmC59703640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 01:51:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9B2B2004B;
	Wed,  1 Jul 2026 01:51:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4651720067;
	Wed,  1 Jul 2026 01:51:17 +0000 (GMT)
Received: from [9.67.23.244] (unknown [9.67.23.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 01:51:16 +0000 (GMT)
Message-ID: <d225ef6f-14c9-4bce-8f6b-12590071114c@linux.ibm.com>
Date: Wed, 1 Jul 2026 07:21:12 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
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
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
 <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
In-Reply-To: <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vZyHofFPYV6323zKUTAmiRoshqRFA1uJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX8brOzZwxeLru
 CrYEhVrmddV+r0S9MkqVnqzMV02QT16JuNXbGny3FY8ru5TGkROSJ/yyvqs/IqNXksfQB3oBKU9
 pwIQWJvfcpWzH450ctTr7WVfD/L+lSs=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4472a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jFxEIJLJGxOkPOqaoPIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX/djNckrFoscy
 EvvdJ+pywS7wHCT9ceMMA16NcG6dCDh6KveuMIMO9rFaBmwsL2QqPwNC2It2N55xhPQ6u/Wmsh7
 MwR4vFtBZ1rBgn1J0Z1Rv+NGkfnLGqQYjtoOuzFlkpM4WyaKzBIOWx5H+H/i/iernOh6lDHlAsV
 XWuvACvbeHRNEyQTL+kZMrdcLAviG6Jq36ASy9AyyX/rhhJIKafQ444yrIU+P34WQb4BOtqOQYr
 N4XZmIp4mAmVegkdrzFfcG5z4tRFzpZr4fSSxeQOfyxv1Erj8M9eYKEa3ldkdOSI9ToaqJ06gty
 1CG9wSa/ytpbNO0lLlXXMZjYFBQ8SYRAwVC3Y9HiEqUO6BK1IGdw4rpnpEsQT0dquKCvd1T4/RG
 OG+BPyoRSKCvVlc+983IskGlpOJjsmYExV82YcGT5+iUYhm0YxRbXwjJqV6lJMEHPvo4oMb4Dfu
 92bZKJuEB/l8pKRgWIw==
X-Proofpoint-ORIG-GUID: qv15DRiyvtH463WVSpSlniXiS2nFTvqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017


On 01/07/26 00:22, Aditya Gupta wrote:
> On 26/06/30 09:55AM, Nikhil Kumar Singh wrote:
>> Hi Aditya,
>>
>> One comment below.
>>
>> On 23/06/26 19:49, Aditya Gupta wrote:
>>> @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
>>>        const PnvChip *chip = data;
>>>        QTestState *qts = NULL;
>>>        g_autofree char *tmp_path = NULL;
>>> +    const char *machine = "powernv10";
>> Would it make sense to introduce `pnv_get_machine_type()` in patch 2
>> instead of patch 3? That would avoid hardcoding `"powernv10"` here and
>> allow this patch to use the helper directly.
> Could be done, but i will prefer to keep it in current state, as of this
> patch, power11 wasn't added to this test, and the test only runs for
> powernv10, later as powern11 gets added in next patch this is changed to
> use pnv_get_machine_type.
>
> If pnv_get_machine_type gets introduced in this patch, it makes sense to
> modify all other tests also to use it, which is more than what this
> patch intends to do (just remove hardcoded index in spi test).
> To me, it seems okay to keep it as is, what do you say ?
Thanks for the explanation. I agree with keeping it as is for this 
patch. Looks good to me.

  ~ Nikhil
>> Otherwise, the patch looks good to me.
> Thanks for reviewing, Nikhil !
>
> - Aditya G
>
>> Thanks,
>> Nikhil
