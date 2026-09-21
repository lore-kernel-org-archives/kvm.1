Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258844E66F;
	Mon, 21 Sep 2026 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979884; cv=none; b=MxfNBUEzuEEx5h8I790rrgwOOSygqZpvRmqWgad3IY2eACNvFCmsscYIBwwQL07i45iUqMXxsJud8QEfH7w43EOrYYkuxE2BfYLeF5RZtCnwJw2vQjCOvQsnsmy+8sm8TgTvksZI9lK1cuHmTPfTeZNAOk/6ozWdCuBwVgIeVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979884; c=relaxed/simple;
	bh=A15SkhMtnatuSysvz3lwCMm2XnzYJilJK3hvNSz3wFA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LDxi0k057nI9plXgJyJlO8rIbNQYN1Lbf1eYjAZlhkin5GUVLvsKhG93EgU5D5mYH4QWvNq4itmaXPk1cZdY6yRSZdssl8KSPfVlv5hFaXNLwWRepfdKlhZwPCbYAMtCIwB6+oBxaItVrDwma4P5K0nnukGQebakfP9/nMw5SBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cxWHSje9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cxWHSje9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7Zuft3857105;
	Mon, 21 Sep 2026 08:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=//bGK5
	KZ+W/q4WQA4iB/f9z0om/0CgGHDaSjEOETS98=; b=cxWHSje92HFG78+XsSIvv/
	T8xr9J/yBkDyLOOPcrEV3ite51/7agxnkDnO0ODkVjgfmcU6VS0ZnuL/0OzgXshq
	Mwzdkq3Ox4wjX8TK7HKyogRAQMw8/qZT2epVqANN/igfbkyIzJ5a5TbT2Z/noX2d
	SM4rR3saIIQ3ERu9yzgI2Dn4MVR68uNSLrzyyrYIRUEYuuTe9vzkRGvD7GuUhJPK
	e5GzH3tyzkwkv4RFIxvc3ycldbuksjhj4q71itkxd2qCg8PhrNzuJmeiyvxuuQSx
	G3uJIuP6Ue2EQWmzjCA4bjHTSdqOGRrOul0OqCIJnHgd3b4pcOLw0L0Kjtzr97ug
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq7c0b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:38:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HbFH924664;
	Mon, 21 Sep 2026 08:38:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4mhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:38:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8buId41353582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:37:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4660920043;
	Mon, 21 Sep 2026 08:37:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975DD20040;
	Mon, 21 Sep 2026 08:37:55 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:37:55 +0000 (GMT)
Message-ID: <c33aa43e-c96d-42a1-a225-159fdeb721e0@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:07:54 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Gautam Menghani <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
References: <20260918055848.28390-1-gautam@linux.ibm.com>
 <20260918060829.D84C61F000FF@smtp.kernel.org>
 <31320deb-ad24-420e-aded-53031ca43fa4@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <31320deb-ad24-420e-aded-53031ca43fa4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0ece9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yKAn6K1XAAAA:8 a=SfKORpjNdS0z9U1v8aoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6M1ixcW_PCWoKiWyFx5v:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX72R937KySO0H
 LGeUa0trcznyqqs/WmuZZ5ph1KDBjJCQ4q3e1nVim7dpxlunGK7Oa7dXSpHsl8ixHo4fGibdv6Z
 s+sBPdzQVfNkak6C9af7UwpxRuX51jMDmJi2StV/VwIK4hoWa+R/vFTvjsfGRH1522Tpl1wP2Os
 fO+Fe7xgrqPrxNWR4hkPILjcRNOCT7Lqyzru0noQa1liXdMuLHiCQdZOkGEe8Et6lUEPB3FZGlh
 h7djT5J+GOCxtfqaEVhdEae8eBygZ+9F5wVb921kZfeya3UKU+IrQMp853rpOaf8kYaeUl0JqlF
 wYTYKJevh1ETRQvKYAZvIb3/dcExXieT8X4s6YbSAIsduPjbhho3gDNYEIcD7q503rNwIknLvmE
 DYE4eP5V6J4LPH5VDCtxUZM33uVRRirXXNKD9juVbueFLainx2XSPfUPF866BrEF0Ku8HN0IJEY
 3YroXYmDhzIHhUUt3Rw==
X-Proofpoint-ORIG-GUID: xK31Kh4--xJsU_R7JVIj45qdNLZd0OoI
X-Proofpoint-GUID: xK31Kh4--xJsU_R7JVIj45qdNLZd0OoI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX//IFy2eA5Xt0
 qRVLTminyFpK0MyR9St0pDSEBEhT0QalqLqZPE1UNChmYrn3O5Pak1UxEtnR/2zqKhNSSQHIqoO
 pVzLCEJJamy6jpOh9Pl9SeRJF9P++I8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123


Hi,

Correction to my previous reply.

On 18/09/26 1:00 PM, Narayana Murty N wrote:
> Hi
> 
> On 18/09/26 11:38 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [High] kvm: ppc: software-injected external interrupts lost on XIVE 
>> hosts
>> -- 
>>
>> commit 05773d5b089dd4410c7e3e3a1611da5479c7d1a4
>> Author: Gautam Menghani <gautam@linux.ibm.com>
>>
>> KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
>>
>> This commit aims to avoid a huge number of spurious interrupts on KVM 
>> PowerNV
>> guests in XIVE mode by not using the LPCR_MER bit when the hardware can
>> present interrupts directly. It modifies kvmhv_run_single_vcpu() to skip
>> setting LPCR_MER when xics_on_xive() returns true.
>>
>> Closes: https://lore.kernel.org/linuxppc- 
>> dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
>>
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>> index dbac3573b2c89..f4d12a97311b9 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu 
>>> *vcpu, u64 time_limit,
>>>               if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & 
>>> MSR_EE))
>>>                   kvmppc_inject_interrupt_hv(vcpu,
>>>                                  BOOK3S_INTERRUPT_EXTERNAL, 0);
>>> -            else
>>> +            else if (!xics_on_xive())
>>>                   lpcr |= LPCR_MER;
>>
>> [Severity: High]
>> Does this unconditionally disable LPCR_MER on XIVE hosts, potentially 
>> dropping
>> software-injected external interrupts when MSR_EE=0?
>>
>> The outer condition in kvmhv_run_single_vcpu() checks if either a KVM 
>> software
>> interrupt (BOOK3S_IRQPRIO_EXTERNAL) or a hardware XIVE interrupt is 
>> pending.
>>
>> When MSR_EE=0 on guest entry, the patched code evaluates:
>>
>>      else if (!xics_on_xive())
>>          lpcr |= LPCR_MER;
>>
>> Since xics_on_xive() evaluates to true globally on bare-metal POWER9+ 
>> hosts
>> with XIVE enabled, regardless of whether the guest uses the in-kernel 
>> XIVE
>> irqchip, bypassing LPCR_MER here seems to cause software-injected 
>> interrupts
>> (such as those from userspace via the KVM_INTERRUPT ioctl) to lose the
>> hardware trap mechanism that normally fires when the guest later sets
>> MSR_EE=1.
>>
>> Could this lead to dropped or severely delayed external interrupts for 
>> guests
>> using a userspace irqchip?
> 
> No, interrupts are not dropped. KVM_INTERRUPT sets 
> BOOK3S_IRQPRIO_EXTERNAL in vcpu->arch.pending_exceptions and kicks the 
> vCPU out to the host. On the next kvmhv_run_single_vcpu() entry, 
> kvmppc_core_prepare_to_enter() re-evaluates the pending bit. The bit 
> persists until MSR_EE=1 allows delivery via vmppc_inject_interrupt_hv(). 
> LPCR_MER is not needed here as XIVE hardware handles the delivery 
> trigger directly If I am not wrong.
> 
> 
> Looks good to me, much better logic than v1. The v1 concern about the
> case where xive_interrupt_pending() is true alongside the external
> exception bit is now handled cleanly with the xics_on_xive() guard.
> 
> Feel free to add:
> 
> Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> 
> Thanks,
> Narayana Murty N.
>>
I misunderstood the case raised by Sashiko. On a PowerNV/XIVE host, QEMU 
can still run with:

kernel_irqchip=off

In that case interrupts are emulated in userspace, while xics_on_xive() 
is still true for the host.

A KVM_INTERRUPT can set BOOK3S_IRQPRIO_EXTERNAL without a corresponding 
XIVE interrupt pending. If MSR_EE is clear, the exception remains 
pending, and with:

else if (!xics_on_xive())
	lpcr |= LPCR_MER;

LPCR_MER is not set. The interrupt could then be delayed until some 
unrelated guest exit.

So my previous Reviewed-by was premature. Please drop:

Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Thanks,
Narayana
> 
> 

