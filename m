Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7A34A786;
	Fri, 17 Apr 2026 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418659; cv=none; b=CZX7MwsJyCrtQZu4sMcvXYfBZuTy2vAa8suHLYQOe4Jp1NcyEkRyojO5YqAwVAlQc7SY8drgKwGiG/xOR+bGBMme4zjjr0CQx05B1QosWjsS1rDt5fxxXONUeVg0NKHrAIPusri+iMypFZ7SUIRX83PEziKKz3BPo1nnJKWKAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418659; c=relaxed/simple;
	bh=v8yU9HegQivSIJ6KeZL3cwoUwujyWbR6PKrHHxwpFZI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bIMIzA1RhYCvO/O4D4hD7tcDaCK6tEmYJlDugqCLd1DsiuqMXg6zX5KiQsWAPiFVipAnMIbyD+D7NAYToFLysllqI+NDFcF9zUHQf9pUDVt6difvnyKwvOqu8m1U2Ey22TciSvHw0dXAzfWVGekgSNysh58nHQ9DJcYnHGeqTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VBblfl0+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VBblfl0+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GI5GRN1733184;
	Fri, 17 Apr 2026 09:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oG5IOc
	ERn2jQwZSxAmEMYeoP+GM2UHC8Y439NkXn3DQ=; b=VBblfl0+wrv+CYxHcAmes3
	SHuElLT2iS6z9a0nF/lC0ZHEvzd8KERZeIwu5QMY027KdUGKfAxKr9WJhmBFwYzf
	yK4cGj198sydoef6TMBtdePpBt4mU/AnT6nGh/cWLse/L23f5P1f8E0KCQpBvysS
	uMTr1woT7VdAnPr2WbKZ+dpNlabBmHM/GD22CKG6WyqjNctFE1vSyDa5vvh1wepw
	ysKJOlf4KCcX+aAjR8ET0RQRMEV/sNqjzMujgUtLpmWSXycf/OSPMnhqRjJ4fUvz
	IhaFe4jDuKCL0pb/hXBpQEPUr5lqb7yv3McYXBUP+kImzWbjbkQ96zAuLKNgMB6Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mgnjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:36:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H870K4004175;
	Fri, 17 Apr 2026 09:36:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kpjau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:36:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H9ajJi18219388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:36:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A642004D;
	Fri, 17 Apr 2026 09:36:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A80C20043;
	Fri, 17 Apr 2026 09:36:45 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 09:36:44 +0000 (GMT)
Message-ID: <280451fd-63e9-44b0-9f56-d39dd01861b9@linux.ibm.com>
Date: Fri, 17 Apr 2026 11:36:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/3] KVM: setup empty irq routing when create vm
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Yi Wang <up2wing@gmail.com>, seanjc@google.com, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanpengli@tencent.com, foxywang@tencent.com, oliver.upton@linux.dev,
        maz@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com
References: <20240506101751.3145407-1-foxywang@tencent.com>
 <20240506101751.3145407-2-foxywang@tencent.com>
 <7e958b82-4eb1-4d61-b301-dde6a19312ba@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7e958b82-4eb1-4d61-b301-dde6a19312ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69e1ff32 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=GvQkQWPkAAAA:8
 a=oTrqkLahvbBJYE7AxasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GXgCTZd_852EhieiTlcFFnvQsmFISx7r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5MiBTYWx0ZWRfX+Sq9dtCI7foy
 Hd+YtfeLYyp+1E25BwrS1ReBjZsxUybS0Qzj/I5hV0QlYgxkZg8Tc3hJSHPrHO+PmDfjPeldEt/
 hSeefByq6Vm4SD6Xb6NiLiIRayizB00A6/vVbwxIEh4iC3+CDFrJMJh/AC2e/ezQcvJddKO14GV
 f8ZmohdS4VBWjsiMnXmt92XU7LfQDGevKfc+0t+oWKalOdQsSB2Uvf/aQrLoyaMiUPMaNhauAjn
 3cgzEzqVoyj8/e/r0k+mbghsL4KMJ/q4VmAafX7c7F5b8MqZZyTmlO8l+XWZJ03rrXDah4QO55B
 jyL8jBSkOpwWO2f9d8luA1nD6mSj2hk1K5j41oTxoOBBdQC1ohHsuLJXWTZeDkSZCw5UA/YYW7V
 hy7uTFGE3wAwez4G7n+xA3Ko1VtyrRl8TSTS7zQ/wHR0NsbetDKmfydckurUZQl9HvULTjDhkN4
 YcXPQzj0bZDpF9mjVkQ==
X-Proofpoint-ORIG-GUID: qspBRwwm02j-0K59fBlo7JYVpPT0zndm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170092

Am 17.04.26 um 10:19 schrieb Christian Borntraeger:
> Am 06.05.24 um 12:17 schrieb Yi Wang:
>> From: Yi Wang <foxywang@tencent.com>
>>
>> Add a new function to setup empty irq routing in kvm path, which
>> can be invoded in non-architecture-specific functions. The difference
>> compared to the kvm_setup_empty_irq_routing() is this function just
>> alloc the empty irq routing and does not need synchronize srcu, as
>> we will call it in kvm_create_vm().
>>
>> Using the new adding function, we can setup empty irq routing when
>> kvm_create_vm(), so that x86 and s390 no longer need to set
>> empty/dummy irq routing when creating an IRQCHIP 'cause it avoid
>> an synchronize_srcu.
>>
>> Signed-off-by: Yi Wang <foxywang@tencent.com>
> 
> We have recently looked into cpu consumption for virtio.
> So interestingly enough, this increases cpu consumption for things like uperf
> ping pong on s390.
> Bisect points to this commit.
> I originally thought that this is a no-op for s390, but it is not.
> 
> The reasons seems to be that nr_rt_entries is now 1 instead of 0 making every
> interrupt inject more expensive as we no longer drop out in
> 
> int kvm_irq_map_gsi(struct kvm *kvm,
>                      struct kvm_kernel_irq_routing_entry *entries, int gsi)
> {
>          struct kvm_irq_routing_table *irq_rt;
>          struct kvm_kernel_irq_routing_entry *e;
>          int n = 0;
> 
>          irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
>                                          lockdep_is_held(&kvm->irq_lock));
>          if (irq_rt && gsi < irq_rt->nr_rt_entries) {  <---------
> 
Hmm, I guess I misread the code and the problem is likely not this.
Let me have another look.
