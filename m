Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C54915BC;
	Fri, 18 Sep 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716645; cv=none; b=LGP3MB2dFlSBC/fyrisM2bfjWbkTVB3IqiHm/Wm8P3JIxYXSJ05x1mfyGhCZcLMr9++Cvi5dZ+eFph50JlCsxzl/YPIvmxNzrPXwRC7tRZEz6zcd6RvtXOf7P+/nNHmtz4mYEA2tQluKTpoW/5LHJ7gOcLymgZMsmGJmrQsdGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716645; c=relaxed/simple;
	bh=Tt8GdfbueXGSkuK4G2fnxFMVppLcaokIDf9ojMSlu20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5ofdZhtrTF/z7X2tEvIBH7PARZdQRctvCEIk7bkIPFUcCRYabN/LdyGixLLr6tMpGq8mNgGi4IQ1XHw7DWmsqc+PLeBiOyKeS09Av1Li3VbEd6Edp/hDaaUNn8xxIcfGj2SgQAoeEDnIQ6v0YqHYCV9nmM99eNof4sqS+ncMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b9GkcDni; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b9GkcDni"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61wOl313701;
	Fri, 18 Sep 2026 07:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VVrcSc
	kwtiGgM8C01h+pd1zrhhl2QR3EIgt6hAK0330=; b=b9GkcDniko72qq1TLuDdAJ
	e+lpqtgR3Jt2PiTMVsDMGNxqKlSK08ZA7sGGaDyMkfh4PpeZfRAu9ympXIP7g0ws
	ZRWnB6RyrVq4qHuwC8qoig4Ne+PeyFXEymSaxQX5D1FcQDHXvYTtm+v3rhtPIhOb
	YYY0Ars+zC7VPH+o/wAlMs35HDD2Z/FEbsDAAPhzbJGWbuIV7W1eUZ/V5rmvL55W
	IFi39NA/q3DDXaHG0ITVDbEgtdqNQtQbkI8qZZgUzbgd+5y8VViHQObD/YjCN3OU
	yTbo/l4ui5IWjXwZBc/EE0CcvVDvjoAHS6YuTW1ENM5aNAvl0Nh9IT/XW6sLtgvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j6hs5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:30:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653bE170840;
	Fri, 18 Sep 2026 07:30:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fdbyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:30:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I7Ubad12059132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 07:30:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD6A2004B;
	Fri, 18 Sep 2026 07:30:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4672B20040;
	Fri, 18 Sep 2026 07:30:37 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 07:30:37 +0000 (GMT)
Message-ID: <31320deb-ad24-420e-aded-53031ca43fa4@linux.ibm.com>
Date: Fri, 18 Sep 2026 13:00:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
To: sashiko-reviews@lists.linux.dev, Gautam Menghani <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
References: <20260918055848.28390-1-gautam@linux.ibm.com>
 <20260918060829.D84C61F000FF@smtp.kernel.org>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260918060829.D84C61F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfXyOobu03mOjJc
 bodtKZzzxpOuOYBxQ30RCBYYY/KPw3ST2h/LRPgSpPT3GsyhrXEKo60XdkpSBusFINdPrgUdxIn
 CbDz5Vbqbhfk7vTkB40pkEaAT95cy/UY8jehUnZ7MF3yNPI2rSgh7bMAd0W6dmnM+rmkiQFd/Y3
 b4C+fJVY1A+4XjwPS40UA4DqjpRsxcIz3iXoxkkZ8E3+JbOrbenOKpS4X/WSfB37KeP5MYoahET
 8e6yJsyfqzbYysqYmj2nYJsl7i2mfAy9hel08eUPWMNP3MRe5GQc43MmwnPLDQfZWOBAlYgW4EZ
 AEuxhO+BAii4vHUvdOD5z3nE5Edc/Caedou/nB/SWT+X8gmxCLFo/VZfSQ6sWxKnkUDfeyuWp/+
 +HwWOUtu3EF8UF5mWpQMn13cRW+YC+YDhWrxaVuBMEYvmS4m9gSAWdKIwIbPN/nazL4ni7npyR5
 PPAV3a8yuUtfhhQF+oA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfX0zRUpPM7f0kx
 um3DNKoZsy9RQmAqoAQhXxgt7vbNHX//J+xJ5EGe5sGhh7934BT262dxOL07W9GCrhRhnaGqjRQ
 SBK2+Lw21xJ/Gjioo5Law0g8Ot39b84=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aace8a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=VnNF1IyMAAAA:8 a=XlwifpPfmKqjG8qNDjIA:9 a=QEXdDO2ut3YA:10
 a=6M1ixcW_PCWoKiWyFx5v:22
X-Proofpoint-ORIG-GUID: 8z_PiAN9i3nFrmeVXNNciFTh7UhUg6dv
X-Proofpoint-GUID: 8z_PiAN9i3nFrmeVXNNciFTh7UhUg6dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180094

Hi

On 18/09/26 11:38 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: ppc: software-injected external interrupts lost on XIVE hosts
> --
> 
> commit 05773d5b089dd4410c7e3e3a1611da5479c7d1a4
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
> 
> This commit aims to avoid a huge number of spurious interrupts on KVM PowerNV
> guests in XIVE mode by not using the LPCR_MER bit when the hardware can
> present interrupts directly. It modifies kvmhv_run_single_vcpu() to skip
> setting LPCR_MER when xics_on_xive() returns true.
> 
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> 
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index dbac3573b2c89..f4d12a97311b9 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>>   			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>>   				kvmppc_inject_interrupt_hv(vcpu,
>>   							   BOOK3S_INTERRUPT_EXTERNAL, 0);
>> -			else
>> +			else if (!xics_on_xive())
>>   				lpcr |= LPCR_MER;
> 
> [Severity: High]
> Does this unconditionally disable LPCR_MER on XIVE hosts, potentially dropping
> software-injected external interrupts when MSR_EE=0?
> 
> The outer condition in kvmhv_run_single_vcpu() checks if either a KVM software
> interrupt (BOOK3S_IRQPRIO_EXTERNAL) or a hardware XIVE interrupt is pending.
> 
> When MSR_EE=0 on guest entry, the patched code evaluates:
> 
>      else if (!xics_on_xive())
>          lpcr |= LPCR_MER;
> 
> Since xics_on_xive() evaluates to true globally on bare-metal POWER9+ hosts
> with XIVE enabled, regardless of whether the guest uses the in-kernel XIVE
> irqchip, bypassing LPCR_MER here seems to cause software-injected interrupts
> (such as those from userspace via the KVM_INTERRUPT ioctl) to lose the
> hardware trap mechanism that normally fires when the guest later sets
> MSR_EE=1.
> 
> Could this lead to dropped or severely delayed external interrupts for guests
> using a userspace irqchip?

No, interrupts are not dropped. KVM_INTERRUPT sets 
BOOK3S_IRQPRIO_EXTERNAL in vcpu->arch.pending_exceptions and kicks the 
vCPU out to the host. On the next kvmhv_run_single_vcpu() entry, 
kvmppc_core_prepare_to_enter() re-evaluates the pending bit. The bit 
persists until MSR_EE=1 allows delivery via vmppc_inject_interrupt_hv(). 
LPCR_MER is not needed here as XIVE hardware handles the delivery 
trigger directly If I am not wrong.


Looks good to me, much better logic than v1. The v1 concern about the
case where xive_interrupt_pending() is true alongside the external
exception bit is now handled cleanly with the xics_on_xive() guard.

Feel free to add:

Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Thanks,
Narayana Murty N.
> 


