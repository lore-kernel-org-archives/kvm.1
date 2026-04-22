Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7136BCCA
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841990; cv=none; b=I/JNE8da0XWP2lpGQ0DfgogU/WMN4ggVAsBthxbcyoG3YVGzmO3ViVaOYSZgRBGY4kmIktXWfWwLFThbAfCTnvwEzBC0BMxzxtRzY2fcaMUh0YH1WFlkro2ONZ4fzwoDrCQqewg8jvIGS9StqRgHJ9260nookv/lKs0glUySxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841990; c=relaxed/simple;
	bh=ctNB7OuFRAFq5o70bcXAZ///pIEX10u+BxqYtSSZtRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJuIuolzkH//nZxRrB5HwET9sXTTvcmIVG7UXLvPcHcsosvlr3CLv7tiyTIIuRP2ZQpj00v06mbioXwxqV2SIec/lzjyYrbdRHdylz2C9T/ArHVD1OjUHL48loAFBg0P5eb+HXvwqztlQdJ++owYeO4uqEojlgl5pqZhPU+hxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HVrAyWKi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HVrAyWKi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIlhOQ589847;
	Wed, 22 Apr 2026 07:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RWbt/a
	h76YcoI5hYN1E5wI+MJoULhx0ce77jifk4aYU=; b=HVrAyWKiWjnY3pYg1hwmIf
	VL767EwcfXyzDZD96GBgx2MVjzn1ph+/6Wjb+85chNlCjL2FBPCcRMsDdCmaymz+
	0hMVSyzOwY7mSjN4avOfsPa0y/Ky6jr/l5oxD+byQ5/cPv71T++Q11sFxL5Opvci
	IysPtK8SQWB/+rZKDcYF0B2VlurczBcVmZPmV5FYuSux3CeoDkMw3dOzPY0S61Zf
	45/wzm62u4MYunf3mu/XR0FlhqjhmgJoBeInrjeKsZMpe5touxmOs+KOEOHTVya+
	Vrod+rh8PsaqkxnPB7eEa2VH5HjAHvnCUNwX+2cLlL+7OANqk5aAK1dUVL+qLspQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu226un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 07:12:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M75TA1001655;
	Wed, 22 Apr 2026 07:12:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyh7f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 07:12:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M7Cj2U42926484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 07:12:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90BD058052;
	Wed, 22 Apr 2026 07:12:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4D858045;
	Wed, 22 Apr 2026 07:12:41 +0000 (GMT)
Received: from [9.39.31.8] (unknown [9.39.31.8])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 07:12:41 +0000 (GMT)
Message-ID: <61318a9d-578d-438c-ac76-e7579f0eb743@linux.ibm.com>
Date: Wed, 22 Apr 2026 12:42:39 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
        qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-6-philmd@linaro.org>
 <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
 <d64dff93-7129-4c39-bf9f-d2a8cf2ee4fb@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <d64dff93-7129-4c39-bf9f-d2a8cf2ee4fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JEy_Qw61y7-2Psv0sYq5GE7-ggZAumDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA2MiBTYWx0ZWRfXztkTpwG2EiP+
 zIe3JA5kQl3AKZ+FmvWnDJv0Efb5L1g+AspPRaZaq2UoQ02K6WapRgFHd5cYsuElCfjj5ZF64JU
 QnmG3fK7W8ENse8OQj5KzGf1Nq7KVDq09RJXkDC6M9tGoBK+GMiI2wQyFOXdDLDIVf0BwwfEUat
 2hdM2BgaL9wOyAANF1qXPDFzlxKfucY31fO6At1RwPfXSGUj1Bp1wsgt6bIrIGZZGx+D1CG5EOQ
 NTkqUb/Yxaoc30zz2pEeewmDd4rVCWGgJs6F1ceKWRIQY+7Qu7uXs+4lwbg0IYxGmzIApkMDErT
 gNVVOmIod2EbOCtjp/ZiNyVLiVGKwikbVTnrVFFpTptYWqiLzxjoY0ZElHR8lIgHgvndl+HAfd/
 R+ZokjfXbtX0xlUrwbI8NWbHRTFCH3u8PLL473FU/Gr5DYhPXswDS+o+xtKofXxRXx60Dx6b/7M
 AoRw76SZVN3bqYLtEYA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e874f0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=6uq8Rgr9QLxLrv8afR8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cy9uItKEJDEWOI1-2bUh_MaU6_lYrtmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220062



On 19/04/26 9:40 pm, Philippe Mathieu-Daudé wrote:
> On 19/3/26 13:59, BALATON Zoltan wrote:
>> On Thu, 19 Mar 2026, Philippe Mathieu-Daudé wrote:
>>> Prefer the address_space_ld/st API over the legacy ld_phys()
>>> because it allow checking for bus access fault.
>>>
>>> This code however doesn't check for fault, so we simply inline
>>> the calls (not specifying any memory transaction attribute nor
>>> expecting transation result) per the definition in
>>> "system/memory_ldst_phys_endian.h.inc":

Nit: "include/system/memory_ldst_phys_endian.h.inc"

>>
>> Recently when trying to remove _nomigrate memory region functions I 
>> was told if some convenience function has more than 1 use it's 
>> probably worth to keep it. This looks like similar case even more so 
>> as the replacement is unnecessarily more complicated. So what's the 
>> problem with ld_phys in the first place and why do you want to replace 
>> it with a less convenient function? If there's a reason maybe say that 
>> in the commit message.
> 
> We want to remove the legacy API because it does not "allow checking
> for bus access fault." The cases where we can safely ignore it are
> rare, and often ignoring it led to subtle bugs.

It would be nice to have an ack from BALATON or Glenn as well since rest 
of the patches are specific to pegasos/ppc32, although no funtional 
change intended here.

If we do not have any further comments from them/others, could you
please post v2 addressing the comment in patch 2/8 reg keeping 
declaration within !CONFIG_USER_ONLY block? It  could be moved to one of 
the existing block as well.

Thanks
Harsh
