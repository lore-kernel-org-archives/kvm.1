Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3739DBF8;
	Fri, 17 Apr 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421645; cv=none; b=Gt1SmR8txLH8o80PwyF3a+/Z31dWzTCOclbiyy46Co7grXqqM5EgvhI/VQR0wLp2HiCggH5l69iiOy1Aix3tjxOjpm+hqNHQmwyISUslTW6veZixt0cZnLwYe/ZXN85IDbO9Trr58Ekn6ewLZcBRte+pCWLrQGvJoZfZzsP22q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421645; c=relaxed/simple;
	bh=kPN3fYv1k2oBMOegJcCnoPZE0WBaIYPuj1+SVg6BV2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AsaPIZzvqQjNZEP3UsNg67/bw0YKyM/VUSEOqPvxdOevdgd0SJNSZQ9JMnYi9eCIP5jIQSh55D6Sq8NHNAU3Cun9EjQI9UZi9Cqp95Nh35BYiyHQzlJAJPLWMVGaDgs9ik4IEphxnYZnaombwrZF5MztJ7U+uuG1y/9DUG2ZoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NLBfB/yI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NLBfB/yI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GMiYGW1804477;
	Fri, 17 Apr 2026 10:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iHtBU1
	e9/Lpd+QxGjIVTK+LBcWy4q6gdzOjMjqY78R0=; b=NLBfB/yIgZ9HxST/EeKNWZ
	/fGslxco3AIGOgYnFu+o2/k0fMM9iXnr30SaPuAP8CufyvjZ2W1kF6t2n0xyJ2wP
	M/xjoT876r+ZgmrN+9aO+lEZNVjGsHCHq9BOUms0lDPFsu0Az4e4yk6IjKAUPZAu
	zdTvx7koXnDJdNyQsCXci0LvMRWCKnbMWEL30lLE5HXE86W8my98OohBt/v7z2iK
	76NitosjYAHQ5oejT8D1k4eRglx+bfvmejPZvuNJMw+ksgnLjXPB3RFqFPqPonSP
	/FEHqrt3oCpZpFq4D50Ve/zra3S+Em8UJKItU4xOjpL6l/J0EqlstONJ1Nvo2KAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kgucn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 10:26:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H6UevR015164;
	Fri, 17 Apr 2026 10:26:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msxy4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 10:26:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HAQZMt52625864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 10:26:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46922004B;
	Fri, 17 Apr 2026 10:26:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3549620043;
	Fri, 17 Apr 2026 10:26:35 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 10:26:35 +0000 (GMT)
Message-ID: <4a6c794e-ee67-4615-880c-130dddfdaccf@linux.ibm.com>
Date: Fri, 17 Apr 2026 12:26:34 +0200
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
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com
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
X-Proofpoint-GUID: e0pN4OCe3CLCLAkwp23oSy9oMt40NMfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEwMyBTYWx0ZWRfX+F7A7UAyoBb+
 ecgHn8xpcOyqaTNWnl9rUNEmslJyEWdT97E874aHzL2ZfPE9ngO2Bk9Y2Vkppu+0S1Z3FkRV3+H
 qROTon/mCdfYWbvvgMRACRpiVKDWZUmCG8MNJPc08H8kMTQatZBbdbxGQTeA7hCy4/+WDms20g4
 ZYsYR/LXKirh33qz38TaT5l4ukqZ2gCvXsN9O+I+mDSJJigEs91+HAawzTcQ5LXNWgHdJyLlRIp
 gwOfALt8M/Y79wUVWVhvkbtgs52tavLHofTt+DZnumOyoX7sBZUa2AIqYHXwkPeIgxmrBJZy3/0
 5GJIZyljECykMR/mIc3OzkRg8wEvHxhtIfFotDX0ZKEDj+iU8uW8Q4HMKpAtAxZqkp7vADqtSFp
 W0Ued4glwpr5Mi5XSIVVw2d3oWba7UZI/n7WET60/JFEZeuh1bYGU8mzEt3hRIOTM/CllNKhYOx
 a8q3pbs9qIcJCcwFGAg==
X-Proofpoint-ORIG-GUID: nmiZQdTs8r2AJ9FepjUa5C1xesi2_oBS
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e20ae0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bTDSsSjtds8SPOVyGFwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170103


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

Yes, it should certainly avoid some cycles in some cases.
Let me try to understand what exactly triggered the increases system time after
the original patch and then I will send some patches.


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

