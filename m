Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6E2E8897;
	Fri, 17 Apr 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414029; cv=none; b=evPIsRx2Y5sLhTx8mDEH8roB/ofA9JHHDtBk8aeYHCLAJj6hs+KUcIO3SWCBswlN348HsP8Gw3rebHOmr3c/aI0NqO2nCrYLmuF/AOYDSpttfWOOVMorVmNVxuo54LJfTgZutzR3uUqxKs8Pqq/3UrQNXX4nRN4o/fxQYmbu5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414029; c=relaxed/simple;
	bh=MA2H7Kl5c6no0p0Wyg1ZNiHvN3GI7FFO3KZFQV2XmJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u4AAYghZStS0yIh00sQAlPwmJ3WoIr15eWYJGHBa9cQDoncKqZHJ94HdWS/wMC+7+MWNjKm++aDkZ8U922yWdkoObcH46+dU8YDPvf+bbR6CfBYz+K1qid1im1Zs+l2Bn1EMMPCniA8cMfvw+/09ZK1l8EoaXGtZiKYFdhJUBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHtc6n3F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHtc6n3F"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GIF6rC1285416;
	Fri, 17 Apr 2026 08:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gl6k8m
	EdMe5Ti1aovwvawsLZhb9TwAmcy5I4WDUdGTM=; b=FHtc6n3Fr/YJ0O+ppT3W0P
	uSwEVbWqRtrHL/PaVziV0TiJvD5+0xw4HIAmHtaSfPZoAniT4CrjGVZRDr9HK+kF
	N+j186pWOMLXDmr8iVN/1huyIa9HKQ8KZ5C6UThIVWqHqdev9dlPi8oApt9JwnmQ
	gdtjsJXU2c75avGj8PZrN2ckpw83X9+ba4OPCBB1JI+NxRBnIzOtAdSSCwHFRof1
	omd09AB9aVsI2w2metqoDU3H9lezRIiG+d5E8qpWfL7O1yrPp8pQB4Icv0j3O2a3
	AGXBq1MmeYBTz+AJgoJvYES9ZbEIpb9UyS5Erzz67n/PO2XHylZWjttH0Mv5aJzA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kgdxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 08:19:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H71xWs031138;
	Fri, 17 Apr 2026 08:19:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yphax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 08:19:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H8JLjW39715322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 08:19:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A63B20043;
	Fri, 17 Apr 2026 08:19:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F402004D;
	Fri, 17 Apr 2026 08:19:20 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 08:19:20 +0000 (GMT)
Message-ID: <7e958b82-4eb1-4d61-b301-dde6a19312ba@linux.ibm.com>
Date: Fri, 17 Apr 2026 10:19:20 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/3] KVM: setup empty irq routing when create vm
To: Yi Wang <up2wing@gmail.com>, seanjc@google.com, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanpengli@tencent.com, foxywang@tencent.com, oliver.upton@linux.dev,
        maz@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com
References: <20240506101751.3145407-1-foxywang@tencent.com>
 <20240506101751.3145407-2-foxywang@tencent.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240506101751.3145407-2-foxywang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0uzar6nrKdRb7SO7x4mcTPGseGD7EeAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4MiBTYWx0ZWRfX89Usk02ahl3j
 KFf9D9Qs1gRz6XSx9C0nPsOLnQ3PYwpuQqcbfpHjxlkaDA/cO06ROJ+mXZmubMYt9T/TZB72QMb
 jfAbYYI+zhsupx8OGKf42WtgLD2yc6RqDKkyy18ie+jUhfVjNMerAgmmg7Grz4hS1Uf2ENGc2D6
 DPZdhTwtcXpmFMnMku9IPZSgrp/qoTGa8DDzM69fpNaTpFzupI5n1CMUJEFIsSDGUyLhy7LvcPZ
 I9IogM/GZ9eO3RsRmN/ED8f5WraH5uEjY6GNF+WHdwVuxFUrShtqLBZS8ey7yZSBolkA25wLND3
 /1QHkAd2wxdaT7NfHSXH2npcalkRPhh6VV4NBVe6j7MEfVB0s+PcJxKy2NSZSBzd9JydhrsyQqR
 b8/9Or3OUqvayQgzMuvqL9jSRc4/f5vxykyz86cDoYOItjtoSN4zxGledCmzYlDGepmNu9h+jp0
 pIQc3id/uIl1DCJg6dw==
X-Proofpoint-ORIG-GUID: fgjGWk1uB-8HfJ_mDNgAgGABPjUaDeZg
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e1ed10 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=GvQkQWPkAAAA:8
 a=mX7PQYiRIvXAHxrb9bMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170082

Am 06.05.24 um 12:17 schrieb Yi Wang:
> From: Yi Wang <foxywang@tencent.com>
> 
> Add a new function to setup empty irq routing in kvm path, which
> can be invoded in non-architecture-specific functions. The difference
> compared to the kvm_setup_empty_irq_routing() is this function just
> alloc the empty irq routing and does not need synchronize srcu, as
> we will call it in kvm_create_vm().
> 
> Using the new adding function, we can setup empty irq routing when
> kvm_create_vm(), so that x86 and s390 no longer need to set
> empty/dummy irq routing when creating an IRQCHIP 'cause it avoid
> an synchronize_srcu.
> 
> Signed-off-by: Yi Wang <foxywang@tencent.com>

We have recently looked into cpu consumption for virtio.
So interestingly enough, this increases cpu consumption for things like uperf
ping pong on s390.
Bisect points to this commit.
I originally thought that this is a no-op for s390, but it is not.

The reasons seems to be that nr_rt_entries is now 1 instead of 0 making every
interrupt inject more expensive as we no longer drop out in

int kvm_irq_map_gsi(struct kvm *kvm,
                     struct kvm_kernel_irq_routing_entry *entries, int gsi)
{
         struct kvm_irq_routing_table *irq_rt;
         struct kvm_kernel_irq_routing_entry *e;
         int n = 0;

         irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
                                         lockdep_is_held(&kvm->irq_lock));
         if (irq_rt && gsi < irq_rt->nr_rt_entries) {  <---------


[...]

> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 1e567d1f6d3d..ec1fda7fffea 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -237,3 +237,26 @@ int kvm_set_irq_routing(struct kvm *kvm,
>   
>   	return r;
>   }
> +
> +/*
> + * Alloc empty irq routing.
> + * Called only during vm creation, because we don't synchronize_srcu here.
> + */
> +int kvm_init_irq_routing(struct kvm *kvm)
> +{
> +	struct kvm_irq_routing_table *new;
> +	int chip_size;
> +
> +	new = kzalloc(struct_size(new, map, 1), GFP_KERNEL_ACCOUNT);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->nr_rt_entries = 1;

Does anyone see a problem with changing that to

	new->nr_rt_entries = 0;

?

