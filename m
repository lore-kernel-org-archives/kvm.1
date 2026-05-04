Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00A3932D1;
	Mon,  4 May 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898977; cv=none; b=MOicQVxPGNQ/w6qCR2WL8Lbfs+BCD7EoX+SYQRlR2zmYziy07P538gXLO9jxOt7sJY9sH0iwR7pBCUMHiVQbBHjBGX18Uj+5WVh/qCVlRLX5A7rvbRssdRagkOOhovTwteYyIZXzZOpqjAmgP3XVicgTcfui9U3rTxfvgAPbJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898977; c=relaxed/simple;
	bh=+YyZVtAlm/QP29hnJhYiXDnaRmaBO++ADHlH1vmU3Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LSkmEvnfvGyK+4HK0MojyoTNxjEqNg+LW1AN2N9BOfmcDkS56kGV2GmEEFA5GBK3Ujrjc4JSpR9u50w9qoKfEL1l1ttnHv/AckaYr6HdayqSCZDNH3yfNxoZTvIY+spbd0tUpgN+/zIzEMHuR5xmfK0gPIAHUKc+PwVPhqbbNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWCZJfyC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWCZJfyC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643Mk8AN2727273;
	Mon, 4 May 2026 12:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9MzL74
	2SDGBM0PE9XF2gIlaMFb8sYuUobsWl02XRz30=; b=gWCZJfyCHKX/3Kt9PX3fiT
	NUrYVzmELvn5QssMttxLgNzk0/eUqIbnV413u5RPYt2CXMdNNojGU+CwR0LiD/u6
	DxPHgU4i1LQfKVWPNkIR9UJopBWh0x9FKm7aK2HDuZvX/b/wtPCwipWMeFBwpsRP
	lUt5hZSM07dYN2a5dSCCFoDsla1UdELgCRhkLUbZt02JHKaqrn3/Q2ZmmGsLOoHr
	hh0n2U0B2YoTlkOtXPglkE0rmJDlRmaPtXu09R9qi1COALFTHuQol/SICrSb4qrY
	aMHzS78V7TKltHTKOpslmyBXslG0q4Ilm4aQgesXuNw+psi3H7md1AEn+LC2D+bA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4exus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:48:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644CdM9V001855;
	Mon, 4 May 2026 12:48:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjn3ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:48:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644CmP1548234766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 12:48:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B7D20043;
	Mon,  4 May 2026 12:48:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC7F20040;
	Mon,  4 May 2026 12:48:23 +0000 (GMT)
Received: from [9.111.87.70] (unknown [9.111.87.70])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 12:48:23 +0000 (GMT)
Message-ID: <bd8bafd3-31ba-407e-b355-ec68edf4ad0a@linux.ibm.com>
Date: Mon, 4 May 2026 14:48:22 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/3] KVM: setup empty irq routing when create vm
To: Paolo Bonzini <pbonzini@redhat.com>, Yi Wang <up2wing@gmail.com>,
        seanjc@google.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanpengli@tencent.com, foxywang@tencent.com, oliver.upton@linux.dev,
        maz@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com,
        Parshuram Sangle <parshuram.sangle@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20240506101751.3145407-1-foxywang@tencent.com>
 <20240506101751.3145407-2-foxywang@tencent.com>
 <7e958b82-4eb1-4d61-b301-dde6a19312ba@linux.ibm.com>
 <280451fd-63e9-44b0-9f56-d39dd01861b9@linux.ibm.com>
 <57d1130f-0375-4934-9820-2edbc3860ee1@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <57d1130f-0375-4934-9820-2edbc3860ee1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzNCBTYWx0ZWRfX0BK9pf7sWiKk
 BenRpA2Hw6YpcSzUHjlp3bdVsWTs2xkFJhxlMIRIwbNeBHoW+ZmxjpC3S0F0KNF/Bc/KmiGIBlo
 1j3496zRlgbsbUaqgS/c1Pr+yeBov4BtWWYWExkUXREVhbgJ1aaErB0+kCWGTaMiJX8vKALLdTU
 igACw8fPjfdUHCy5c6LLI0BAPrkFThbmDGC9aKeiu6p43giTYYohjc/xJnfXVpsneHJEkAX7w/I
 2egiMvfVuZ1FnMx3NThLKzxvCErNzFkmxyfUfaRchWSKmkc0PpwN5Lu+9EClKrFBGaFJM+uojR2
 3NjOdBeALO3/3ArLG764igGVtdY3lgYhszRajmwc2st4gOHnio0YaFw7FVlig8Gtx/3kGIsv1ZO
 YdrruxPtHKn3JQqI7kcZQ7w5YSIhSenVvSHpJ++fRmYudOwLdQDHKERmddUlhnR0Va+sh41u/vL
 wROmXdw2WzDDBFMXE5g==
X-Proofpoint-ORIG-GUID: srMHMhmb0VQN6y_ONtyOtSMZMiuazi3Y
X-Proofpoint-GUID: TLlny7jaqKay16AX29ifsTVV0fV-cAV9
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f8959f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=bTDSsSjtds8SPOVyGFwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040134

Am 17.04.26 um 12:19 schrieb Paolo Bonzini:
> On 4/17/26 11:36, Christian Borntraeger wrote:
>>>
>>>
>>>          irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm- >irq_srcu,
>>>                                          lockdep_is_held(&kvm- >irq_lock));
>>>          if (irq_rt && gsi < irq_rt->nr_rt_entries) {  <---------
>>>
>> Hmm, I guess I misread the code and the problem is likely not this.
>> Let me have another look.
> 
> It makes sense anyway, together with a similar extra element in
> kvm_set_irq_routing():


Turns out that the bisect was wrong. the increased cpu consumption came from
commit aeb1b22a3ac8e94c791f06f16e921384794771fa ("KVM: Enable halt polling shrink parameter by default")
which kind of makes sense.


@Paolo, shall I do a patch with 0 nr_rt_entries anyway as discussed or shall we
drop this?



> 
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 462c70621247..c3e4fbbfed94 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -178,11 +178,9 @@ int kvm_set_irq_routing(struct kvm *kvm,
>       for (i = 0; i < nr; ++i) {
>           if (ue[i].gsi >= KVM_MAX_IRQ_ROUTES)
>               return -EINVAL;
> -        nr_rt_entries = max(nr_rt_entries, ue[i].gsi);
> +        nr_rt_entries = max(nr_rt_entries + 1, ue[i].gsi);
>       }
> 
> -    nr_rt_entries += 1;
> -
>       new = kzalloc_flex(*new, map, nr_rt_entries, GFP_KERNEL_ACCOUNT);
>       if (!new)
>           return -ENOMEM;
> @@ -246,11 +244,11 @@ int kvm_init_irq_routing(struct kvm *kvm)
>       struct kvm_irq_routing_table *new;
>       int chip_size;
> 
> -    new = kzalloc_flex(*new, map, 1, GFP_KERNEL_ACCOUNT);
> +    new = kzalloc_flex(*new, map, 0, GFP_KERNEL_ACCOUNT);
>       if (!new)
>           return -ENOMEM;
> 
> -    new->nr_rt_entries = 1;
> +    new->nr_rt_entries = 0;
> 
>       chip_size = sizeof(int) * KVM_NR_IRQCHIPS * KVM_IRQCHIP_NUM_PINS;
>       memset(new->chip, -1, chip_size);
> 
> Paolo
> 

