Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C92D0603;
	Fri, 17 Apr 2026 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425501; cv=none; b=nYnFx5uSWhE0r/jGtHViTN6nBzQ6bcxZVPIX715XZPMZT8V+1fWS7PVfYTXOQM847VY+gmi7Vro+O8hxP0GDkWU2dHZ7sqZa3uJdZq2QdaJjnQASXtXGkyC8n4/LNUM8ZJ+S0am8MtbvmkCbxlBtFV9Mi8jzEylqOX+mrSxmQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425501; c=relaxed/simple;
	bh=CMYgaEzbwsFmPfJV1FUIjlIFl6Br14/SHWJG2BAdpjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D0Yyvo+tJEVA2HeWUcXiqKlGc1nTuJIsDowF5uukP+xyqD+GxQSngODK2DPhVmG15ykuGwfN6v1JkZkqgb0aIXAeprVuCDiY25bUdnTkXs2RU5F9EexG3biuiBUu2PI1ZmSngv4/Fdmtv4BSYtvJVDG2gCGG0a1VM6wWsRld0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qC3dx2j5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qC3dx2j5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H0uxOR2131790;
	Fri, 17 Apr 2026 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uHifNx
	hief/eppsuNM113BK3s2bvlz/zEsWKSLVCWgU=; b=qC3dx2j5VMEPjlG4uf6wuQ
	KmPF2r4stGQyKFI0rbXEdZ472QdnSCZwOpm39kBlD7OYrfR+TTQcPtCKg50gPpX4
	Q6/2h9WP9d8e5ortSPntsnKgzDhJyRmS9uh9ERIJyGafj66aAc0UJwOP3zTHxBee
	pgvyaaq7+v2/VvyAtJX5IS5hpj/N0sTwjdm0Rw1XiWeB4dCVpXfFXn665c0BPkf9
	vPh3i/lLEys640Usa5uT2ytZEsjoH9ghrp3TVbtMvcer1sqWK4k3cXphJufltH6l
	ID+FEhNaf0obXb2zwTlQDovVgH4rGRTkoIRdiX8HQUvYgrQND4cf12Hx7eCw60qQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ntbb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 11:30:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HBIXvA015216;
	Fri, 17 Apr 2026 11:30:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msy6gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 11:30:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HBUtNW51970448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 11:30:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F0820043;
	Fri, 17 Apr 2026 11:30:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42B2220040;
	Fri, 17 Apr 2026 11:30:54 +0000 (GMT)
Received: from [9.111.90.245] (unknown [9.111.90.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 11:30:54 +0000 (GMT)
Message-ID: <1d99d7ea-e8c0-4afd-a6cb-58d3a09a7dfa@linux.ibm.com>
Date: Fri, 17 Apr 2026 12:30:53 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
From: Richie Buturla <richie@linux.ibm.com>
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
 <d5bb7e5d-94d3-4b6c-b1a6-e11d13db38f3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d5bb7e5d-94d3-4b6c-b1a6-e11d13db38f3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hKK-EhfyNiUDRAfC5Soa_S0v_lQUXLQY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDExNCBTYWx0ZWRfX3lyjP/Gw996i
 IB5ZI86kvlpye6MJem8Ps0DTPKUG6fJxM5bNyNNxGQ+2R6qMJ4VRlxBOGYZEPcaAor3+rBdq3Io
 Y3P2/31vEPn64AlSxKZgyGzKo04/sgOOzjDbQGb1A6eFix2Omni/qY5ZCq2u6bHGAT4s916nhzu
 7Pne3WJvc72j5oNGX09Zgd0xdFF5OLfKsSYcU6f65YGLD/fa7tvA2t5G5gZO65YbpsWfjUgsEsl
 5SYKHAjMd27IDmXR+fbQxgC8C8SYSD3Kj6IRgsD9Fg/Edy5OO3vQWbdxNgQJ5x1zmfEPQJrJH3M
 suGL1a29H7KGdI5PH3HHsHXYcfNJitKhh3VgZaMRhrMn+t0Io8+IqwYAVcaUoan5h6HqO5VcjMW
 7suz4/tgFONERC498ERRxn+385wt4/7B8F9Qsbf4PTa77X42Gq33DFerXAy7+olA1YYIbUbkJXC
 RmVRu6jCfWODzN8/7nw==
X-Proofpoint-ORIG-GUID: umylyr50P1v8d3mrm-Ksi4cO_YgyK-9j
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e219f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=GvQkQWPkAAAA:8 a=YG1JYBCiqZ0gNLd67ywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170114


On 08/04/2026 10:35, Richie Buturla wrote:
>
> On 01/04/2026 10:34, Wanpeng Li wrote:
>> Hi Christian,
>> On Thu, 26 Mar 2026 at 22:42, Christian Borntraeger
>> <borntraeger@linux.ibm.com> wrote:
>>> Am 19.12.25 um 04:53 schrieb Wanpeng Li:
>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>
>>>> This series addresses long-standing yield_to() inefficiencies in
>>>> virtualized environments through two complementary mechanisms: a vCPU
>>>> debooster in the scheduler and IPI-aware directed yield in KVM.
>>>>
>>>> Problem Statement
>>>> -----------------
>>>>
>>>> In overcommitted virtualization scenarios, vCPUs frequently spin on 
>>>> locks
>>>> held by other vCPUs that are not currently running. The kernel's
>>>> paravirtual spinlock support detects these situations and calls 
>>>> yield_to()
>>>> to boost the lock holder, allowing it to run and release the lock.
>>>>
>>>> However, the current implementation has two critical limitations:
>>>>
>>>> 1. Scheduler-side limitation:
>>>>
>>>>      yield_to_task_fair() relies solely on set_next_buddy() to provide
>>>>      preference to the target vCPU. This buddy mechanism only offers
>>>>      immediate, transient preference. Once the buddy hint expires 
>>>> (typically
>>>>      after one scheduling decision), the yielding vCPU may preempt 
>>>> the target
>>>>      again, especially in nested cgroup hierarchies where vruntime 
>>>> domains
>>>>      differ.
>>>>
>>>>      This creates a ping-pong effect: the lock holder runs briefly, 
>>>> gets
>>>>      preempted before completing critical sections, and the 
>>>> yielding vCPU
>>>>      spins again, triggering another futile yield_to() cycle. The 
>>>> overhead
>>>>      accumulates rapidly in workloads with high lock contention.
>>> Wanpeng,
>>>
>>> late but not forgotten.
>>>
>>> So Richie Buturla gave this a try on s390 with some variations but 
>>> still
>>> without cgroup support (next step).
>>> The numbers look very promising (diag 9c is our yieldto hypercall). 
>>> With
>>> super high overcommitment the benefit shrinks again, but results are 
>>> still
>>> positive. We are probably running into other limits.
>>>
>>> 2:1 Overcommit Ratio:
>>> diag9c calls:                       225,804,073 → 213,913,266  (-5.3%)
>>> Dbench thrpt (per-run mean):        +1.3%
>>> Dbench thrpt (per-run median):      +0.8%
>>> Dbench thrpt (total across runs):   +1.3%
>>> Dbench thrpt (avg/VM):              +1.3%
>>>
>>> 4:1:
>>> diag9c calls:                       833,455,152 →  556,597,627 (-33.2%)
>>> Dbench thrpt (per-run mean):        +7.2%
>>> Dbench thrpt (per-run median):      +8.5%
>>> Dbench thrpt (total across runs):   +7.2%
>>> Dbench thrpt (avg/VM):              +7.2%
>>>
>>>
>>> 6:1:
>>> diag9c calls:                       967,501,378 →  737,178,419 (-23.8%)
>>> Dbench thrpt (per-run mean):        +5.1%
>>> Dbench thrpt (per-run median):      +4.8%
>>> Dbench thrpt (total across runs):   +5.1%
>>> Dbench thrpt (avg/VM):              +5.1%
>>>
>>>
>>>
>>> 8:1:
>>> diag9c calls:                       872,165,596 → 653,481,530 (-25.1%)
>>> Dbench thrpt (per-run mean):        +11.5%
>>> Dbench thrpt (per-run median):      +11.4%
>>> Dbench thrpt (total across runs):   +11.5%
>>> Dbench thrpt (avg/VM):              +11.5%
>>>
>>> 9:1:
>>> diag9c calls:                       809,384,976  → 587,597,163 (-27.4%)
>>> Dbench thrpt (per-run mean):        +4.5%
>>> Dbench thrpt (per-run median):      +4.0%
>>> Dbench thrpt (total across runs):   +4.5%
>>> Dbench thrpt (avg/VM):              +4.5%
>>>
>>>
>>> 10:1:
>>> diag9c calls:                       711,772,971 → 477,448,374 (-32.9%)
>>> Dbench thrpt (per-run mean):        +3.6%
>>> Dbench thrpt (per-run median):      +1.6%
>>> Dbench thrpt (total across runs):   +3.6%
>>> Dbench thrpt (avg/VM):              +3.6%
>> Thanks Christian, and thanks to Richie for running this on s390. :)
>>
>> This is very valuable independent data. A few things stand out to me:
>>
>> - The consistent reduction in diag9c calls across all overcommit
>> ratios (up to -33.2% at 4:1) confirms that the directed yield
>> improvements are effective at reducing unnecessary yield-to
>> hypercalls, not just on x86 but across architectures.
>> - The fact that these results are without cgroup support is actually
>> informative: it tells us the core yield improvement carries its weight
>> on its own, which helps me scope the next revision more tightly.
>> - The diminishing-but-still-positive returns at very high overcommit
>> (9:1, 10:1) match what I see on x86 as well — other bottlenecks start
>> dominating but the mechanism does not regress.
>>
>> Btw, which kernel version were these results collected on?
>>
>> Regards,
>> Wanpeng
>>
> Hi Wanpeng,
>
> I collected these results on a 6.19 kernel - which should also include 
> the existing fixes for yielding and forfeiting vruntime on yield that 
> K Prateek mentioned.
>
Hi Wanpeng. I'm trying out cgroup runs with libvirt but the results seem 
to vary when I reproduce and need to look into this again so we should 
not try to base any decisions on the numbers.

I'll also rerun on the kernel version you are using (The 6.19-rc1).
