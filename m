Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C582315D33
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100202; cv=none; b=Ii9KRTtmeUHy0QBF2vSlcMawj5XbE5N47P8hu7EA6SDBqg1sPEtwXhWb4ETOeVKO1rj5mC82+hY3mmxK6suwG+g/gmH6X2BSKvnbmik9ykAYAFvejM5qSLZDFdZDU/jUKLnYPrPplye6onG2iLxCbOdXrOXtPmRfhWtn6CxJtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100202; c=relaxed/simple;
	bh=qwVkZvhzmK6X1/8IFtRpM1j1TsT9GMes71X1D6Polgc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TDisptpAagUuuGNZiJdWsPxDCJkV3IXIKMNKavvMBQQDYJC4+A8FY2QWlYKBXL4WD4k9XWa+ZuZgdUm1vuHk7hex0IjLoMOhS+UT+bquqWGqz1PDuZkWxDvHS030/kTmZx51hTlj3dzT2Jp+nRjtaIL2bDiLVj16zcvjoye1hXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbLICQD5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbLICQD5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DAZo7O2032997;
	Mon, 13 Apr 2026 17:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jvkv1E
	hOM9FjUKEgFLeZl8Kti3qQYiTZqztepQsUBs8=; b=bbLICQD58duJcama1Y40HF
	BsyxfGmIvwtjciTzAouk4xIdOn3ufHagO2FFwNibK1+t53DSnrd9IZ5mVAyQ+CsF
	lO0PRbY3HwOefFxtDj/yPswqkOpjy50wFQzlkWVNKt+ffu30PdrxK8qmpWd/6HyS
	KOO2vjkDU4ZoWUy35hAxGTKd+87e0oHdZ5UBcAN/dj3dA1hlWHQgICnJ4KpBVmKv
	2cLPW/gfoPWhOQDLBC56fwe912SlQ5Hfln26OJZKylEYvno2pLCEVOSAN25prjHe
	iugm+J0UEPK6+wxrS1y0VTZVFWmKHNLLzk+sQ8GPXkU7AS670X12EAVuxZH48oMw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxx0cgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 17:09:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DCshLc003514;
	Mon, 13 Apr 2026 17:09:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn630r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 17:09:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DH9DAR56623426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 17:09:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC7B65805D;
	Mon, 13 Apr 2026 17:09:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 242B558054;
	Mon, 13 Apr 2026 17:09:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 17:09:38 +0000 (GMT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Apr 2026 22:39:37 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Ani Sinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>,
        peter.maydell@linaro.org, Harshpb <harshpb@linux.ibm.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
        Qemu Devel
 <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
In-Reply-To: <20260413090010.60339-1-anisinha@redhat.com>
References: <20260413090010.60339-1-anisinha@redhat.com>
Message-ID: <d91f22b1e74f8159c0ab4ac0aea44ef3@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NSBTYWx0ZWRfXyw05g0Jv+net
 eYbLEPhpxtNeeiy5ZHJF1ZmXZI6hnx8CzmKVUVAYJYhwt70Ipoe+gnnMfOXosviA8sfbiBmhtuq
 SsbG140BfLr9KicYuvCMbEX62paaR/AbILqo96DRcNyBhzhKtkkgVJxhU3d9Gg0kQET+enc2nbs
 owFiAe0t0EKxqL6rYvAzsF6c9rlEucN5Temn20wTecdpU7r6ynuh1OZkEGvlF1hcpb6B69T+oyf
 klPViGv0QkODw0N8o8xMyOcdJVohHDqy4INDYfl1hNRAurHdjtS1aOyBLGcrZ3DBPAkmJy2sOKe
 qWnkvpV5XOBmpbAEMwtzqStgrCNPvVAofvHB2iUgaSuj30PgsvchWi59JXsyg2SN5/0zO/C55RN
 ZxSj0P1QEdAnoxwivMXruABiXZbQicnFxVeKuYTOcc2UG2acdF/qR3lO3zuFIM9BFCWRjk6aoY4
 owE36j8QUMkNdq7iKxQ==
X-Proofpoint-ORIG-GUID: RR-QX_Ye8Rkbetis9C7Xq27ImKT7O_1t
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69dd2354 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ErzlIeVuY194znd37YUA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: RR-QX_Ye8Rkbetis9C7Xq27ImKT7O_1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130165

Hi Ani,
I've tested the v1 patch: [PATCH for-11.0] accel/kvm: return early from 
kvm_irqchip_create if kvm does not support irqchip, on PowerPC machine 
and it resolves the boot hang issue seen when booting KVM guest with >1 
smp value.

Regression Details:
Commit 98884e0cc1 ("accel/kvm: add changes required to support KVM VM 
file descriptor change") led to a regression which caused KVM guests on 
ppc64le to hang indefinitely during boot when SMP was configured. Single 
vCPU guests booted successfully, but any configuration with more than 
one vCPU would hang.
The hang occurred at bql_lock() in qemu_default_main() 
(system/main.c:49), where the system would become completely 
unresponsive after successfully completing qemu_system_reset().
Reference: 
https://lists.nongnu.org/archive/html/qemu-ppc/2026-03/msg00035.html

Test Environment:
- Host Arch: ppc64le
- Host and Guest OS: Fedora 42
- Machine Type: pseries with KVM acceleration
- QEMU: Latest master with this patch applied

Test Results:
All the following SMP topologies now boot successfully:

Single and simple multi-CPU:
- -smp 1
- -smp 2
- -smp 4
- -smp 32

Various socket/core/thread combinations (8 vCPUs):
- -smp 8,sockets=8,cores=1,threads=1
- -smp 8,sockets=1,cores=8,threads=1
- -smp 8,sockets=1,cores=1,threads=8
- -smp 8,sockets=2,cores=4,threads=1
- -smp 8,sockets=1,cores=4,threads=2
- -smp 8,sockets=2,cores=1,threads=4
- -smp 8,sockets=2,cores=2,threads=2

Higher vCPU count:
- -smp 16,sockets=2,cores=4,threads=2
- -smp 32,sockets=1,cores=8,threads=4

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>

On 2026-04-13 14:30, Ani Sinha wrote:
> During refactoring of kvm_irqchip_create(), the refactored code was 
> returning
> early from do_kvm_irqchip_create() function if the required 
> capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is 
> because,
> do_kvm_irqchip_create() did not have a means to notify the caller of 
> the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() 
> return
> EOPNOTSUPP error when required capabilities are absent and then the 
> caller
> can check the return code and return early.
> 
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM
> file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..92af42503b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s,
> qemu_irq irq, int gsi)
>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>  }
> 
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>  {
>      int ret;
>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>              exit(1);
>          }
>      } else {
> -        return;
> +        return -EOPNOTSUPP;
>      }
> 
>      if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> @@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
>          fprintf(stderr, "Create kernel irqchip failed: %s\n", 
> strerror(-ret));
>          exit(1);
>      }
> +
> +    return 0;
>  }
> 
>  static void kvm_irqchip_create(KVMState *s)
>  {
>      assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
> 
> -    do_kvm_irqchip_create(s);
> +    if (do_kvm_irqchip_create(s) < 0) {
> +        return;
> +    }
>      kvm_kernel_irqchip = true;
>      /* If we have an in-kernel IRQ chip then we must have asynchronous
>       * interrupt delivery (though the reverse is not necessarily true)
> @@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>      }
> 
>      if (s->kernel_irqchip_allowed) {
> +        /* ignore return from this function */
>          do_kvm_irqchip_create(s);
>      }
