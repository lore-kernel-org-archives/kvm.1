Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9832573F;
	Thu, 26 Mar 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536161; cv=none; b=U4WKFQ1oAem67B+xBc1vOBsoMdve8d8cqMC9xPuuDrxvUJdS3lqlAOjjOCH4fhX3t1c4AeJosttVvqzxBCG6weyAWI3WI/fZau0MA2DGu4th9kvYJ4wVapmP7AUduGEMfH/57lHrdKUjPuG9HyBFQW1KhD2swNQHeiOS4W0CxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536161; c=relaxed/simple;
	bh=WZSUkjewi+G+I4jiyyJacg6tE+mFmgkVOE5SqBCLnCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNFvSuE8/GRLw87IZ70t6VkRL84dJDr0Mu7eBpQAowRif4NVG93mCQ7cZa0pptTQGFUFb2HirGIut/vri95qo2FZ33eI+xnVzh3iN5bqXBXyjBw78QUr9ZmQs4oYQG2AAZkcmKZR9rNK+lk7dH6tdlPSdvYeByXIHQd9mcb8Ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZI93bD5x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZI93bD5x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QEaFP01559171;
	Thu, 26 Mar 2026 14:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2+4m+R
	1k59x1VCvTjmjYTfrl6g6JQq+SMm2UdPiwJj0=; b=ZI93bD5x8/U1ST49QFN2wD
	ytReWHWn/qhTN0J55lvxLzqtASS6a0Z/4hCJhmN9IWFgTtK2atC+Eel1OuUWX34u
	LoKNvtZ00M0Jvz7/csjQkixZyyxhHDaD/izJeGmTC65joJ0hrKcdtZ6w4alV5P6T
	k0MC+rmX93fgWLM+LiWBZmaxvv7xr0BorwqrXp38CYg/H6GMa5U+DbRdl/KHVB/l
	sgWcZEt99T1SLiSHqzfW5uGg9EFrEpEYWJ8zLMP0qChjrtmWgw2RXukvLK0aTGXE
	G6Dy2UZsVZha1bngScP0o+XTXBZZZMwuhJ0SVvnk1aOlzwhSYRwQJM2OxKQs8jgQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv4q54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 14:42:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QD0l1E004399;
	Thu, 26 Mar 2026 14:42:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2b47r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 14:42:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QEg0FG23724504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:42:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0AC62004B;
	Thu, 26 Mar 2026 14:41:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B7F20040;
	Thu, 26 Mar 2026 14:41:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 14:41:59 +0000 (GMT)
Message-ID: <9a8c1bd7-5d95-4d79-aae2-fc06c448b9a3@linux.ibm.com>
Date: Thu, 26 Mar 2026 15:41:59 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        richie@linux.ibm.com
References: <20251219035334.39790-1-kernellwp@gmail.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251219035334.39790-1-kernellwp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: erLmoXAei3x8HRURwrQG2FuDCOcPJiSv
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c545bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GvQkQWPkAAAA:8
 a=Biw2TRemLrSBvjo0t4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwMSBTYWx0ZWRfXxe9F2N/ZjXIH
 tJB6yDjkY2ogyl+lfbbRGNGrcIw1rydEExj/bMKjQNzO070sVSocK1lKWrWXXVHaGDPUCSGWdCm
 vCwTjLbiESvyIXPrRZHG5dhkhieOA9xMfhm2HKhUEg0Dq/9wOJLjdXFYqzYdkonda3ZBgW9bDYl
 KGX5LpvDNuXiCdiYsxcAuCogGQFIxjSe2oYw/1c4j2V9lvtvQh7fFa15zuuFiC8fixuTzAWHtTi
 6yWH9uZK/oq2CurtdjglAA9qKTNi/pRtqY97q+/aSUpxKFt1lCjOsZstB64ENiFDAy1LaXLjVAJ
 93MjJkyugrbV9Um6aNLgOrqioSZTxgMRoYW+2LloqUCB6N1MlrVUbVpORuNzGWilaJZ8L1aJJZG
 csEqx/OnUiZFJOJcdYxsafgyNWROCU1R5OOYTsYPtNrFwod2/bT/ynt0324HAkagWhzXmZh/j4j
 9CA857mdEx0CSGl+y4g==
X-Proofpoint-GUID: xYqIeJ0C4J9bawb4bXQpmxX4nzGNpwIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260101

Am 19.12.25 um 04:53 schrieb Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> This series addresses long-standing yield_to() inefficiencies in
> virtualized environments through two complementary mechanisms: a vCPU
> debooster in the scheduler and IPI-aware directed yield in KVM.
> 
> Problem Statement
> -----------------
> 
> In overcommitted virtualization scenarios, vCPUs frequently spin on locks
> held by other vCPUs that are not currently running. The kernel's
> paravirtual spinlock support detects these situations and calls yield_to()
> to boost the lock holder, allowing it to run and release the lock.
> 
> However, the current implementation has two critical limitations:
> 
> 1. Scheduler-side limitation:
> 
>     yield_to_task_fair() relies solely on set_next_buddy() to provide
>     preference to the target vCPU. This buddy mechanism only offers
>     immediate, transient preference. Once the buddy hint expires (typically
>     after one scheduling decision), the yielding vCPU may preempt the target
>     again, especially in nested cgroup hierarchies where vruntime domains
>     differ.
> 
>     This creates a ping-pong effect: the lock holder runs briefly, gets
>     preempted before completing critical sections, and the yielding vCPU
>     spins again, triggering another futile yield_to() cycle. The overhead
>     accumulates rapidly in workloads with high lock contention.

Wanpeng,

late but not forgotten.

So Richie Buturla gave this a try on s390 with some variations but still
without cgroup support (next step).
The numbers look very promising (diag 9c is our yieldto hypercall). With
super high overcommitment the benefit shrinks again, but results are still
positive. We are probably running into other limits.

2:1 Overcommit Ratio:
diag9c calls:                       225,804,073 →  213,913,266  (-5.3%)
Dbench thrpt (per-run mean):        +1.3%
Dbench thrpt (per-run median):      +0.8%
Dbench thrpt (total across runs):   +1.3%
Dbench thrpt (avg/VM):              +1.3%

4:1:
diag9c calls:                       833,455,152 →  556,597,627 (-33.2%)
Dbench thrpt (per-run mean):        +7.2%
Dbench thrpt (per-run median):      +8.5%
Dbench thrpt (total across runs):   +7.2%
Dbench thrpt (avg/VM):              +7.2%


6:1:
diag9c calls:                       967,501,378 →  737,178,419 (-23.8%)
Dbench thrpt (per-run mean):        +5.1%
Dbench thrpt (per-run median):      +4.8%
Dbench thrpt (total across runs):   +5.1%
Dbench thrpt (avg/VM):              +5.1%



8:1:
diag9c calls:                       872,165,596 → 653,481,530 (-25.1%)
Dbench thrpt (per-run mean):        +11.5%
Dbench thrpt (per-run median):      +11.4%
Dbench thrpt (total across runs):   +11.5%
Dbench thrpt (avg/VM):              +11.5%

9:1:
diag9c calls:                       809,384,976  → 587,597,163 (-27.4%)
Dbench thrpt (per-run mean):        +4.5%
Dbench thrpt (per-run median):      +4.0%
Dbench thrpt (total across runs):   +4.5%
Dbench thrpt (avg/VM):              +4.5%


10:1:
diag9c calls:                       711,772,971 → 477,448,374 (-32.9%)
Dbench thrpt (per-run mean):        +3.6%
Dbench thrpt (per-run median):      +1.6%
Dbench thrpt (total across runs):   +3.6%
Dbench thrpt (avg/VM):              +3.6%

