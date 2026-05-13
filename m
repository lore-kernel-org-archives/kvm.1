Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1440758F;
	Wed, 13 May 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676819; cv=none; b=cUb6J1h5ChzB0v7vLZgMfYYfE79ulUbjw0FWCZ++XuXe9lVEdk0DmMVnEaO6NBbHcT6G2mGqE0LQ8+VTiq6ZyG6tLLBZ/XnIxjMS5sTEQG1WV2j1LezqCqIkypLCg3vY4ovI+jEBgJGo3MDqUf5oPFhLHV38xik7QpKB+oDzbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676819; c=relaxed/simple;
	bh=XuWXFM+eKnXbBY9eErz37OVMFUcYn6vf9L0nbKwlbmE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kY088w3z4wfhTRNeCSo/gXn+WDfDccvFt70qlrrioGxiFIAO9vmJ+5CVwaQqoFa1lQEUsUPm3YlD7e2oQBRb320QbBKDM/R6PmK408O/aDFUbiEjSU8itZUCR3gICSXFbzopWjbwHTCaIvuGSpe2CVFi46tcP9XKn5BwyKCAb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LufkTSAK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LufkTSAK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D7ol2G3874784;
	Wed, 13 May 2026 12:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1APpEh
	L0YVU6LN3uFHSEX1tbex9YXW0Qo0ZkwqsSUzA=; b=LufkTSAKAuwdHdlUjtPHar
	H27p+msPYcD9veaGT6lpRhYmFDRlN9qrzyBTUNBYtBeyrVj3CfqNgTU+16vR1COQ
	uUu27Nxbs+8kVXyAmkCfux1j0jO+J6HKJiqWai4xf+Od24nIBdt0lU4HPpJ+LSfS
	k4qjCL7SK9lZfYr5RFhSOIXxYGTgeg72CXtp5C84/qLJvFiqGj6+xNMu2+auNFoF
	6F/x3knH6zinLgzypih0QBZy5gbQy+Cnn7ndtorZhKCmzliVJ6dzhXZKte38i41y
	ilOLWefbY3oRowxCQEvyt3MnSKF9Yg2w/Z2i2wUVqmzltPdxTRP9SnvbBe/mSmog
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6qd4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 12:52:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DCdQl3030271;
	Wed, 13 May 2026 12:52:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgfsc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 12:52:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DCqoTb49676694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 12:52:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4DC20043;
	Wed, 13 May 2026 12:52:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57F1C20040;
	Wed, 13 May 2026 12:52:49 +0000 (GMT)
Received: from [9.111.78.101] (unknown [9.111.78.101])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 12:52:49 +0000 (GMT)
Message-ID: <f8b453e9-0f62-4183-ae6a-d3982ae0827f@linux.ibm.com>
Date: Wed, 13 May 2026 13:52:48 +0100
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
 <1d99d7ea-e8c0-4afd-a6cb-58d3a09a7dfa@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1d99d7ea-e8c0-4afd-a6cb-58d3a09a7dfa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a047425 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=GvQkQWPkAAAA:8 a=qhrAOcthnf8THf3nuK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: luDS1YZ_xvSkxJoudlOuMTfwcwnC6r6G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzMSBTYWx0ZWRfX45w7dk/xp4Wl
 JiVxL1G1/gaTdDUw+Dr0Nvz94jM2R5CqjNN/pAIHHkEvl7oafbfn+JqsxGjGRV1rbycqshZ3GZa
 PJFM1DFQ4zosTW+u267MLTFk+/HXzh/2CE2TLDKqYCw+Vg6G13VIHPkJxznoH+w8nb5zdNI36X3
 1dy9Xe7J+xUceKZPdD1uh0Sr1YHc7BKvxlQdSxUlzHk3XI54K83oLjFeiRGOktLC6bgrJ4fk/PU
 IswabjmTb9dZied2CGS8aF7zmnla43PUIYQ7ZPdiHbRl15eh7hSHAAz+RMYL1avbPKdvdQwV4Y8
 eiQm6dUsecQE78pZIiebnqkP1qsoMMd5FZC8TAbK/VpDUOMhTKwqiIOuOPc4MTK3/sXA9z9KEMf
 YCuk8FA0UXZvK//BNSUUjVtCW0JOHifwp+r/JGx24492wz5kKrCuz5I4GwBqy/q2atTS48wbgI1
 SODS0QNdc016yME/8XA==
X-Proofpoint-ORIG-GUID: fwzMqjzm1zI0PdFe6OSANVS9Tq90_Qfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130131


On 17/04/2026 12:30, Richie Buturla wrote:
>
> On 08/04/2026 10:35, Richie Buturla wrote:
>>
>> On 01/04/2026 10:34, Wanpeng Li wrote:
>>> Hi Christian,
>>> On Thu, 26 Mar 2026 at 22:42, Christian Borntraeger
>>> <borntraeger@linux.ibm.com> wrote:
>>>> Am 19.12.25 um 04:53 schrieb Wanpeng Li:
>>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>>
>>>>> This series addresses long-standing yield_to() inefficiencies in
>>>>> virtualized environments through two complementary mechanisms: a vCPU
>>>>> debooster in the scheduler and IPI-aware directed yield in KVM.
>>>>>
>>>>> Problem Statement
>>>>> -----------------
>>>>>
>>>>> In overcommitted virtualization scenarios, vCPUs frequently spin 
>>>>> on locks
>>>>> held by other vCPUs that are not currently running. The kernel's
>>>>> paravirtual spinlock support detects these situations and calls 
>>>>> yield_to()
>>>>> to boost the lock holder, allowing it to run and release the lock.
>>>>>
>>>>> However, the current implementation has two critical limitations:
>>>>>
>>>>> 1. Scheduler-side limitation:
>>>>>
>>>>>      yield_to_task_fair() relies solely on set_next_buddy() to 
>>>>> provide
>>>>>      preference to the target vCPU. This buddy mechanism only offers
>>>>>      immediate, transient preference. Once the buddy hint expires 
>>>>> (typically
>>>>>      after one scheduling decision), the yielding vCPU may preempt 
>>>>> the target
>>>>>      again, especially in nested cgroup hierarchies where vruntime 
>>>>> domains
>>>>>      differ.
>>>>>
>>>>>      This creates a ping-pong effect: the lock holder runs 
>>>>> briefly, gets
>>>>>      preempted before completing critical sections, and the 
>>>>> yielding vCPU
>>>>>      spins again, triggering another futile yield_to() cycle. The 
>>>>> overhead
>>>>>      accumulates rapidly in workloads with high lock contention.
>>>> Wanpeng,
>>>>
>>>> late but not forgotten.
>>>>
>>>> So Richie Buturla gave this a try on s390 with some variations but 
>>>> still
>>>> without cgroup support (next step).
>>>> The numbers look very promising (diag 9c is our yieldto hypercall). 
>>>> With
>>>> super high overcommitment the benefit shrinks again, but results 
>>>> are still
>>>> positive. We are probably running into other limits.
>>>>
>>>> 2:1 Overcommit Ratio:
>>>> diag9c calls:                       225,804,073 → 213,913,266  (-5.3%)
>>>> Dbench thrpt (per-run mean):        +1.3%
>>>> Dbench thrpt (per-run median):      +0.8%
>>>> Dbench thrpt (total across runs):   +1.3%
>>>> Dbench thrpt (avg/VM):              +1.3%
>>>>
>>>> 4:1:
>>>> diag9c calls:                       833,455,152 → 556,597,627 (-33.2%)
>>>> Dbench thrpt (per-run mean):        +7.2%
>>>> Dbench thrpt (per-run median):      +8.5%
>>>> Dbench thrpt (total across runs):   +7.2%
>>>> Dbench thrpt (avg/VM):              +7.2%
>>>>
>>>>
>>>> 6:1:
>>>> diag9c calls:                       967,501,378 → 737,178,419 (-23.8%)
>>>> Dbench thrpt (per-run mean):        +5.1%
>>>> Dbench thrpt (per-run median):      +4.8%
>>>> Dbench thrpt (total across runs):   +5.1%
>>>> Dbench thrpt (avg/VM):              +5.1%
>>>>
>>>>
>>>>
>>>> 8:1:
>>>> diag9c calls:                       872,165,596 → 653,481,530 (-25.1%)
>>>> Dbench thrpt (per-run mean):        +11.5%
>>>> Dbench thrpt (per-run median):      +11.4%
>>>> Dbench thrpt (total across runs):   +11.5%
>>>> Dbench thrpt (avg/VM):              +11.5%
>>>>
>>>> 9:1:
>>>> diag9c calls:                       809,384,976  → 587,597,163 
>>>> (-27.4%)
>>>> Dbench thrpt (per-run mean):        +4.5%
>>>> Dbench thrpt (per-run median):      +4.0%
>>>> Dbench thrpt (total across runs):   +4.5%
>>>> Dbench thrpt (avg/VM):              +4.5%
>>>>
>>>>
>>>> 10:1:
>>>> diag9c calls:                       711,772,971 → 477,448,374 (-32.9%)
>>>> Dbench thrpt (per-run mean):        +3.6%
>>>> Dbench thrpt (per-run median):      +1.6%
>>>> Dbench thrpt (total across runs):   +3.6%
>>>> Dbench thrpt (avg/VM):              +3.6%
>>> Thanks Christian, and thanks to Richie for running this on s390. :)
>>>
>>> This is very valuable independent data. A few things stand out to me:
>>>
>>> - The consistent reduction in diag9c calls across all overcommit
>>> ratios (up to -33.2% at 4:1) confirms that the directed yield
>>> improvements are effective at reducing unnecessary yield-to
>>> hypercalls, not just on x86 but across architectures.
>>> - The fact that these results are without cgroup support is actually
>>> informative: it tells us the core yield improvement carries its weight
>>> on its own, which helps me scope the next revision more tightly.
>>> - The diminishing-but-still-positive returns at very high overcommit
>>> (9:1, 10:1) match what I see on x86 as well — other bottlenecks start
>>> dominating but the mechanism does not regress.
>>>
>>> Btw, which kernel version were these results collected on?
>>>
>>> Regards,
>>> Wanpeng
>>>
>> Hi Wanpeng,
>>
>> I collected these results on a 6.19 kernel - which should also 
>> include the existing fixes for yielding and forfeiting vruntime on 
>> yield that K Prateek mentioned.
>>
> Hi Wanpeng. I'm trying out cgroup runs with libvirt but the results 
> seem to vary when I reproduce and need to look into this again so we 
> should not try to base any decisions on the numbers.
>
> I'll also rerun on the kernel version you are using (The 6.19-rc1).
Hi Wanpeng,

I spent some more time benchmarking the scheduler-side changes on s390 
and I think I can now narrow down where the benefit shows up and where 
it does not.
For context, my test runs have libvirt vms running dbench with the 
number of clients equal to the number of vCPUs, and the workload runs on 
tmpfs so that this is primarily measuring scheduler behavior.
As far as I can tell, the yield/deboost benefit is constrained to cases 
where the relevant vCPUs are competing on the same runqueue. That makes 
placement the key variable.

In particular:

1. With explicit 1:1 vCPU:pCPU pinning, I do not see a meaningful benefit.
For 3 VMs with 16 vCPUs each pinned to 16 pCPUs, the results were:

      diag9c calls:                  61,384,968 -> 62,994,594  (+2.6%)
      Dbench throughput mean:   -0.5%
      Dbench throughput median:  -0.3%

    That is basically noise from my point of view. This matches the 
expectation that if the lock waiter and lock holder are not sharing an 
rq, the scheduler-side boost/deboost path has little or nothing to act on.

2. When vCPUs are pooled onto a smaller pCPU set, I can reproduce a benefit.
    For 2 VMs with 16 vCPUs each placed on a 8 pCPU pool per VM, I saw:

      diag9c calls:                  62,893,856 -> 20,033,920  (-68.1%)
      Dbench throughput mean:   +4.2%
      Dbench throughput median:  +4.0%

    For 3 VMs with 16 vCPUs each placed on a 5 pCPU pool per VM, I saw:

      diag9c calls:                 107,915,379 -> 35,393,080  (-67.2%)
      Dbench throughput mean:     +4.4%
      Dbench throughput median:    +4.4%

    I also saw the same pattern with heavier pooling. For 5 VMs with 16 
vCPUs each placed on a 3 pCPU pool per VM, the results were:

      diag9c calls:                 130,986,144 -> 58,153,006  (-55.6%)
      Dbench throughput mean:     +3.4%
      Dbench throughput median:    +3.6%

These are the configurations where I consistently see an improvement in 
reduction of diag9c calls (again our yieldto hypercall) and some 
throughput improvement. This works because the VM is actually 
overcommitted onto its allowed pCPU set, so multiple vCPUs from the same 
VM can contend on the same rq and exercise the mechanism.

3. If there is no intra-VM overcommit, the effect disappears again.
    For 3 VMs with 5 vCPUs on a 5 pCPU pool per VM, the results were:

      diag9c calls:                     696,548 ->    718,219  (+3.1%)
      Dbench throughput mean: -0.8%
      Dbench throughput median:  -0.7%

    Again, no meaningful benefit.

So my final takeaway is that on s390 I can only demonstrate a benefit 
when the test setup intentionally causes multiple vCPUs of a VM to share 
runqueues. Plain pinning does not show an effect, and a matched 
vCPU:pCPU configuration such as 5 vCPUs on 5 pCPUs does not either. The 
interesting case is specifically vCPU pooling / overcommit onto a 
smaller pCPU set, not just "more VMs on the host".

I suppose this mechanism does help once the waiter/holder pair can 
actually meet on the same rq. If something similar could somehow target 
useful cross-runqueue cases as well, that would seem like a natural way 
to stretch this benefit further.

Thanks,
Richie
