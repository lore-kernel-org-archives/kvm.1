Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D332D77E6;
	Wed,  8 Apr 2026 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640969; cv=none; b=ZQQ639A9xMamO/S5adq4XldaLxqbqrq1N03zdqINAlRfcCfCiP2P5GnNsh4BIKBbSs2RELhRDm7IY/kTgYACBsuXghNHdKeLqsy9q/FDNRDhClYFxTNBrzCTuikpCj8GSUEdqF0qPBw3efBn2gZiCQnM0J0+dyVn6PcNUO1g7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640969; c=relaxed/simple;
	bh=tLmtEqT3nQJkerWwT/2xKCwohdoa/FWXOxDdyOmlKVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5Zxgsvm3kKHfG/AEGVev8OMuQW8jCtHCZSPPD+HtMJs/htcifg+OZyq4HBDqDtxwzT7Len74ksKLTXVKmMKH38SEhI2pxd6eZMjBijclEGSJYYKZ6vzjBck8QV3QVvgLQsBLwt85i2fQxx7YystvyqmXQ15/VP7bOyDDhxiAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EqOi91cy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EqOi91cy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63841D4X2302396;
	Wed, 8 Apr 2026 09:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CHMnB6
	UBLSoY+nvWPQMjI8ztiE+YcuX6XyZnJvMfn94=; b=EqOi91cyrSMJc5fxramC0u
	DN7dcZs1Xnwz0Qd3XGnVwr2e3SUj/XKwniFVoZ3XYKBBaEgPRL2zwfc0r3NJEShz
	GBWxgEbi9A81v2wCnVEsxYevHBLX2PeOGXYtVr+eyFw+vlrGGsjjEge0Xzzg7H8/
	YsaZf8twzoUfV5JQqTJuPjUC8jSHdqDMCj5s/G6/jI/Lbd1K6HZqXRet2lfUes4f
	OTJ0aW7yGxuBrScTxW4gXhYgqwPdIV5Cu5j7mIPfD3K5Rq6yorTHnWcnpOpYSy84
	lU9CrS5DEibCa27ZH2Uocp3wNOUJcVKeI2hFpcHl74Yc4kmSMWhnwZ/rp3Ua5Z/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ff8uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 09:35:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6386Icpc014423;
	Wed, 8 Apr 2026 09:35:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4pt88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 09:35:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6389ZUoF46268786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 09:35:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90A9A20043;
	Wed,  8 Apr 2026 09:35:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F6420040;
	Wed,  8 Apr 2026 09:35:29 +0000 (GMT)
Received: from [9.111.5.142] (unknown [9.111.5.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 09:35:29 +0000 (GMT)
Message-ID: <d5bb7e5d-94d3-4b6c-b1a6-e11d13db38f3@linux.ibm.com>
Date: Wed, 8 Apr 2026 10:35:29 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20251219035334.39790-1-kernellwp@gmail.com>
 <9a8c1bd7-5d95-4d79-aae2-fc06c448b9a3@linux.ibm.com>
 <CANRm+Cz8Lh+AdsLSSy-u-KQhOpOqBOOAfC1-N7eTO_UM46f6Uw@mail.gmail.com>
Content-Language: en-US
From: Richie Buturla <richie@linux.ibm.com>
In-Reply-To: <CANRm+Cz8Lh+AdsLSSy-u-KQhOpOqBOOAfC1-N7eTO_UM46f6Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4NCBTYWx0ZWRfXz6Z2JXieLIFo
 qbbbI2CHqBXDoQnZzGdvjOG5RErkKL0HAWqi1HOuu+IXIStNkqqsEVrh3CEZlm36tzNo+99uTb8
 FbZDzqsUjknh/nPXHBsmcESjdXFWAu76EcuN1JS/J99RYxAqk7Ob+kLymdr+OO/++sfBXbn8MuN
 UtOkeuvTrnG1xuuovJ/BihnUTL+Sf3VNMkpUF1VQyge8NHWZzdP0azUtvWzG42Ow7tQi5v/BSYu
 auH6fOCwSlaxScyoBu+aWgGozqdDK4KGiC0H6NLxjtxxdd4Enoh8ZNbi9fhn61PT7yxMlctPYf2
 YOonpWHHNsQ1ed89stqfbsWm5t0UIrhd4NRVYzEyxhyVY5WhwjK9FgO6Mbf5gq349j6NbiWWNU6
 jUXRrdy8uwwIjNVm9qxqLzii+06YnjQe3Gt7NTEikE8Z89pLfZG6wvpkpoLk3KXFCzq6NiKPNF+
 6BXPjNCVcHLn1nhENsg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d62165 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=GvQkQWPkAAAA:8 a=89r_iloUKzSEZtGOBo4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T62McCncB8BQkPEOARNpNWIoQoyAcZep
X-Proofpoint-GUID: SypGKFRbrMhVXZaqIkxEoAVQskLka_A5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080084


On 01/04/2026 10:34, Wanpeng Li wrote:
> Hi Christian,
> On Thu, 26 Mar 2026 at 22:42, Christian Borntraeger
> <borntraeger@linux.ibm.com> wrote:
>> Am 19.12.25 um 04:53 schrieb Wanpeng Li:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> This series addresses long-standing yield_to() inefficiencies in
>>> virtualized environments through two complementary mechanisms: a vCPU
>>> debooster in the scheduler and IPI-aware directed yield in KVM.
>>>
>>> Problem Statement
>>> -----------------
>>>
>>> In overcommitted virtualization scenarios, vCPUs frequently spin on locks
>>> held by other vCPUs that are not currently running. The kernel's
>>> paravirtual spinlock support detects these situations and calls yield_to()
>>> to boost the lock holder, allowing it to run and release the lock.
>>>
>>> However, the current implementation has two critical limitations:
>>>
>>> 1. Scheduler-side limitation:
>>>
>>>      yield_to_task_fair() relies solely on set_next_buddy() to provide
>>>      preference to the target vCPU. This buddy mechanism only offers
>>>      immediate, transient preference. Once the buddy hint expires (typically
>>>      after one scheduling decision), the yielding vCPU may preempt the target
>>>      again, especially in nested cgroup hierarchies where vruntime domains
>>>      differ.
>>>
>>>      This creates a ping-pong effect: the lock holder runs briefly, gets
>>>      preempted before completing critical sections, and the yielding vCPU
>>>      spins again, triggering another futile yield_to() cycle. The overhead
>>>      accumulates rapidly in workloads with high lock contention.
>> Wanpeng,
>>
>> late but not forgotten.
>>
>> So Richie Buturla gave this a try on s390 with some variations but still
>> without cgroup support (next step).
>> The numbers look very promising (diag 9c is our yieldto hypercall). With
>> super high overcommitment the benefit shrinks again, but results are still
>> positive. We are probably running into other limits.
>>
>> 2:1 Overcommit Ratio:
>> diag9c calls:                       225,804,073 →  213,913,266  (-5.3%)
>> Dbench thrpt (per-run mean):        +1.3%
>> Dbench thrpt (per-run median):      +0.8%
>> Dbench thrpt (total across runs):   +1.3%
>> Dbench thrpt (avg/VM):              +1.3%
>>
>> 4:1:
>> diag9c calls:                       833,455,152 →  556,597,627 (-33.2%)
>> Dbench thrpt (per-run mean):        +7.2%
>> Dbench thrpt (per-run median):      +8.5%
>> Dbench thrpt (total across runs):   +7.2%
>> Dbench thrpt (avg/VM):              +7.2%
>>
>>
>> 6:1:
>> diag9c calls:                       967,501,378 →  737,178,419 (-23.8%)
>> Dbench thrpt (per-run mean):        +5.1%
>> Dbench thrpt (per-run median):      +4.8%
>> Dbench thrpt (total across runs):   +5.1%
>> Dbench thrpt (avg/VM):              +5.1%
>>
>>
>>
>> 8:1:
>> diag9c calls:                       872,165,596 → 653,481,530 (-25.1%)
>> Dbench thrpt (per-run mean):        +11.5%
>> Dbench thrpt (per-run median):      +11.4%
>> Dbench thrpt (total across runs):   +11.5%
>> Dbench thrpt (avg/VM):              +11.5%
>>
>> 9:1:
>> diag9c calls:                       809,384,976  → 587,597,163 (-27.4%)
>> Dbench thrpt (per-run mean):        +4.5%
>> Dbench thrpt (per-run median):      +4.0%
>> Dbench thrpt (total across runs):   +4.5%
>> Dbench thrpt (avg/VM):              +4.5%
>>
>>
>> 10:1:
>> diag9c calls:                       711,772,971 → 477,448,374 (-32.9%)
>> Dbench thrpt (per-run mean):        +3.6%
>> Dbench thrpt (per-run median):      +1.6%
>> Dbench thrpt (total across runs):   +3.6%
>> Dbench thrpt (avg/VM):              +3.6%
> Thanks Christian, and thanks to Richie for running this on s390. :)
>
> This is very valuable independent data. A few things stand out to me:
>
> - The consistent reduction in diag9c calls across all overcommit
> ratios (up to -33.2% at 4:1) confirms that the directed yield
> improvements are effective at reducing unnecessary yield-to
> hypercalls, not just on x86 but across architectures.
> - The fact that these results are without cgroup support is actually
> informative: it tells us the core yield improvement carries its weight
> on its own, which helps me scope the next revision more tightly.
> - The diminishing-but-still-positive returns at very high overcommit
> (9:1, 10:1) match what I see on x86 as well — other bottlenecks start
> dominating but the mechanism does not regress.
>
> Btw, which kernel version were these results collected on?
>
> Regards,
> Wanpeng
>
Hi Wanpeng,

I collected these results on a 6.19 kernel - which should also include 
the existing fixes for yielding and forfeiting vruntime on yield that K 
Prateek mentioned.
