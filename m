Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989F23EA83;
	Wed,  1 Jul 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929119; cv=none; b=YEvIIpehJEZXtMYxTJ///lItHlep4hybLMi3FrGSNCyGfMIihzhg6qTK2oDooZYffkMboXrsPL4n3eaPZl4vkUEhssL5gMLZrfkC25QvOlK+cn9bfGOxzkuK2CwJmvMhQMcyzR/N69wYy0uo/2GHhMkwx7PEOCt2fi2wV57RDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929119; c=relaxed/simple;
	bh=nLjajmQi1J5FJfayF5TV3rP6NthhUhpRX9w72ZQtJcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWMOnfSVa9nBOMTUgHNjeA14pVi745hIa5jEXYHFwh5tfuP3MD7joux4o6HRsYtVYs6a10qXjRxS7HtUEeHC4zLs6bNJ9fgUneiAbLVJleso9WcuGVaLkIwvAvABY/76cGvGN8Y2Hmer0oHvKmiFZnm70ybqBhDjgeYlbRKLp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gwJJolis; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gwJJolis"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmeJo1398715;
	Wed, 1 Jul 2026 18:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=shndhi
	Zek8hzHKFimPlGuQnjukXHCg1p9/th+He453Q=; b=gwJJolis11WcLYk7PLWrbD
	HCM4cJI50WCrt0kJCDgPusp71oIAGo0euuevQtWE0Ob/zm7u9ROQQlfy8hT45zcD
	zXyffEExx/JLX5S2q2fIJYv8l7BNPB8q90d87Bu1OmPtElmv3alsPBgj3N7BDIxl
	hBHF+lONvyzVBR4cVPXCWYl7IROW88UEl5WijPhvwXppXykEOnJJqWQeyQRivZVU
	YLDk9//RHv5lIr2Vx7qI95D2hbAjGGPH7rM2CkEO1/YjDA6F+l9Rs2CPpyocbNJ1
	LcH6VwmdGikTHGdEOhMYAJm9PSDeiTchkglA4uDczJHFiP4MCNRp850NbRq0ym9Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5wyj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:04:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661I4hiS018051;
	Wed, 1 Jul 2026 18:04:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ggc8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:04:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661I4tPp47644928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 18:04:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51A0D20049;
	Wed,  1 Jul 2026 18:04:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A704F20040;
	Wed,  1 Jul 2026 18:04:52 +0000 (GMT)
Received: from [9.39.23.199] (unknown [9.39.23.199])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 18:04:52 +0000 (GMT)
Message-ID: <08b76ac0-9c01-450a-a54c-bdae7379af74@linux.ibm.com>
Date: Wed, 1 Jul 2026 23:34:51 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] KVM: powerpc/book3s_hv: Use generic xfer to guest
 work function
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        gautam@linux.ibm.com, bigeasy@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
References: <20260626105449.2897924-2-vishalc@linux.ibm.com>
 <20260626105449.2897924-4-vishalc@linux.ibm.com>
 <ba65ad87-2d59-49c3-9b76-7068a9c0dac2@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <ba65ad87-2d59-49c3-9b76-7068a9c0dac2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MCBTYWx0ZWRfX7pKeK+Uf+y/e
 UFZRxFZslFqbtRHL9boRhTVshV7RNV5wJWx0vmJYb/9PZFiiypHUHzi5hTuJuc0Q4egqUb087c2
 zRQjQVxsXEOyLsQgda0bkJuPfdE+VgvfpLW8O2QTf7fXusWhp0fEz/D2YiQgkL1F3f6l/2bVE6m
 FOlbUqZf3ueuD8w4D3KiSmlh7m3vNj3Gk8yGKHTwTE5YEXBRkH00glJ0a3hkkZ0IQQHVBoBS8Kq
 Z8p4bPkCeHiWG8URzyOrdgGddL1xTHiM3cnYzGHyJUSTDv0+GkpJAvxADkYKHsD8UWCBqBtaN0u
 4C+7H+dwcpHNC5mjreKO6wsBmewReL1vV5rLZDmJZvFjoNmKUzBIbRGxsvSlvmyC/IQ2D9mBAnW
 EnVKOG4OnrFmmYY+bUpNkbqByBrHw/OKuDMasKioBJclKNaOWpKN/lBqzXyuuEiaoiLog/w/JEE
 Q2bZ1N08Hm5OILNw98Q==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4556cc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=e6rxw4hy6MCZb7Uc7toA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VDK6S743VZ7OE1HVem1gJFUIGIxaMUT4
X-Proofpoint-GUID: oclSDBocyI5B2lDTuGbqyEJ9fE0R23Y5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MCBTYWx0ZWRfX4Es0U7GjBnAt
 9QY0PAoCjUYGiXRbscJWLdpON8ET0r8duQQpwMVUX+1iND4dU8bkNyAbW5Heelv1EJ/M5BjKzb8
 1yJFcL8LesZh8YIQBvZxnQH4ADO33D8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010190


On 01/07/26 11:43, Shrikanth Hegde wrote:
> Hi Vishal,
Hi Shrikanth, Thanks for looking into it.
>
> On 6/26/26 4:23 PM, Vishal Chourasia wrote:
>> Use the generic infrastructure to check for and handle pending work
>> before transitioning into guest mode, replacing the open-coded
>> need_resched() and cond_resched() checks.
>>
>> This picks up handling for TIF_NOTIFY_RESUME, which was previously
>> ignored, meaning task work will now be correctly handled on every
>> guest re-entry.
Yes
>
> It would indeed be good if powerpc moves go generic 
> VIRT_XFER_TO_GUEST_WORK.
> It does take care of RESUME.
>
> In addition today, I doubt powerpc kvm works well for LAZY preemption.
> generic infra will take care of it too.
>
nice
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>>   arch/powerpc/kvm/Kconfig     |  1 +
>>   arch/powerpc/kvm/book3s_hv.c | 58 +++++++++++++++++++++++++++++++-----
>>   2 files changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
>> index 9a0d1c1aca6c..36aec58c5f22 100644
>> --- a/arch/powerpc/kvm/Kconfig
>> +++ b/arch/powerpc/kvm/Kconfig
>> @@ -81,6 +81,7 @@ config KVM_BOOK3S_64_HV
>>       depends on KVM_BOOK3S_64 && PPC_POWERNV
>>       select KVM_BOOK3S_HV_POSSIBLE
>>       select KVM_BOOK3S_HV_PMU
>> +    select VIRT_XFER_TO_GUEST_WORK
>
> This takes care of HV only.
> Does PR/booke run into the same problem?
Yes, I would think so, if the KVM vCPU runs inside system.
> Does anyone out there who runs them still and care about cgroup 
> bandwidth control mechanism on it?
>
> It may be worth adding comment that PR still runs into the same issue.
>
>>       select CMA
>>       help
>>         Support running unmodified book3s_64 guest kernels in
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 61dbeea317f3..b012512342e6 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -3850,10 +3850,20 @@ static noinline void kvmppc_run_core(struct 
>> kvmppc_vcore *vc)
>>        * and return without going into the guest(s).
>>        * If the mmu_ready flag has been cleared, don't go into the
>>        * guest because that means a HPT resize operation is in progress.
>> +     *
>> +     * xfer_to_guest_mode_work_pending() is the IRQs-disabled 
>> recheck for
>> +     * pending guest-mode work (reschedule, signals, and 
>> TIF_NOTIFY_RESUME
>> +     * task_work such as the deferred CFS throttle). It is the 
>> pre-POWER9
>> +     * analog of the final gate in kvmhv_run_single_vcpu(), and a 
>> superset
>> +     * of the old need_resched() check: it catches work that raced 
>> in after
>> +     * the drain in kvmppc_run_vcpu(), so a CPU-bound vCPU is 
>> throttled here
>> +     * instead of running one more guest dispatch past its quota. 
>> IRQs are
>> +     * hard-disabled just above, so the non-__ variant (which 
>> asserts that)
>> +     * is the correct one.
>>        */
>>       local_irq_disable();
>>       hard_irq_disable();
>> -    if (lazy_irq_pending() || need_resched() ||
>> +    if (lazy_irq_pending() || xfer_to_guest_mode_work_pending() ||
>>           recheck_signals_and_mmu(&core_info)) {
>>           local_irq_enable();
>>           vc->vcore_state = VCORE_INACTIVE;
>> @@ -4824,10 +4834,24 @@ static int kvmppc_run_vcpu(struct kvm_vcpu 
>> *vcpu)
>>           vc->runner = vcpu;
>>           if (n_ceded == vc->n_runnable) {
>>               kvmppc_vcore_blocked(vc);
>> -        } else if (need_resched()) {
>> +        } else if (__xfer_to_guest_mode_work_pending()) {
>>               kvmppc_vcore_preempt(vc);
>> -            /* Let something else run */
>> -            cond_resched_lock(&vc->lock);
>> +            /*
>> +             * Let something else run, and run pending guest-mode
>> +             * work (reschedule, and TIF_NOTIFY_RESUME task_work such
>> +             * as the deferred CFS throttle) before we would re-enter
>> +             * the guest, so a CPU-bound vCPU is actually throttled
>> +             * here instead of running past its quota. This is a
>> +             * superset of the old need_resched() check. Use the raw
>> +             * helper, not the kvm_ wrapper: signals (KVM_EXIT_INTR
>> +             * and the signal_exits stat) are accounted by this path's
>> +             * existing handling below, so going through the wrapper
>> +             * here would double-count them. The helper may schedule(),
>> +             * so the vcore lock is dropped around it.
>> +             */
>> +            spin_unlock(&vc->lock);
>> +            xfer_to_guest_mode_handle_work();
>> +            spin_lock(&vc->lock);
>>               if (vc->vcore_state == VCORE_PREEMPT)
>>                   kvmppc_vcore_end_preempt(vc);
>>           } else {
>> @@ -4899,8 +4923,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu 
>> *vcpu, u64 time_limit,
>>           }
>>       }
>>   -    if (need_resched())
>> -        cond_resched();
>> +    /*
>> +     * Run pending work before (re-)entering the guest, most 
>> importantly
>> +     * task_work queued via TWA_RESUME (e.g. the deferred CFS bandwidth
>> +     * throttle, which only sets TIF_NOTIFY_RESUME). Without this a 
>> CPU-bound
>> +     * vCPU that keeps returning RESUME_GUEST never reaches an 
>> exit-to-user
>> +     * point, so the throttle is never enforced and the task runs 
>> far beyond
>> +     * its quota. The helper also handles reschedule and signals, 
>> replacing
>> +     * the cond_resched() that was here. It may schedule(), so it 
>> runs before
>> +     * preemption and IRQs are disabled, with no vcore/KVM locks 
>> held. This
>> +     * is the per-reentry site shared by the bare-metal and pseries 
>> (nested)
>> +     * paths, so both are covered.
>> +     */
>> +    r = kvm_xfer_to_guest_mode_handle_work(vcpu);
>> +    if (r)    /* -EINTR: signal pending, exit to userspace 
>> (KVM_EXIT_INTR) */
>> +        return r;
>>         kvmppc_update_vpas(vcpu);
>>   @@ -4916,7 +4953,14 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu 
>> *vcpu, u64 time_limit,
>>         if (signal_pending(current))
>>           goto sigpend;
>
> xfer_to_guest_mode_work_pending checks for signals too right?
>
> #define XFER_TO_GUEST_MODE_WORK                                         \
>         (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_SIGPENDING | \
>          _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |                      \
>          ARCH_XFER_TO_GUEST_MODE_WORK)
Yes, I see originally we only had need_resched() check. will remove in v2
>
>> -    if (need_resched() || !kvm->arch.mmu_ready)
>> +    /*
>> +     * Re-check for pending guest-mode work with IRQs disabled, to 
>> catch
>> +     * anything (e.g. a TIF_NOTIFY_RESUME task_work such as the 
>> deferred CFS
>> +     * throttle) that raced in after the check above. Bail back to 
>> the outer
>> +     * loop, which re-enters here and runs the work. This is a 
>> superset of
>> +     * the previous need_resched() check.
>> +     */
>> +    if (xfer_to_guest_mode_work_pending() || !kvm->arch.mmu_ready)
>>           goto out;
>>         vcpu->cpu = pcpu;
>
> Copying from the discussion thread at that time,
>
> """
> on x86:
> kvm_arch_vcpu_ioctl_run
>     vcpu_run
>         for () {
>             .. run guest..
>             xfer_to_guest_mode_handle_work
>                 schedule
>         }
>
>
> on Powerpc:  ( taking book3s_hv flavour):
> kvm_arch_vcpu_ioctl_run
> kvmppc_vcpu_run_hv  *1
>     do while() {
>         kvmhv_run_single_vcpu or kvmppc_run_vcpu
>             -- checking for need_resched and signals and bails out *2
>     }
>
>
> *1 - checks for need resched and signals before entering guest
> *2 - checks for need resched and signals while running the guest
>
>
> This patch is addressing only *1 but it needs to address *2 as well 
> using generic framework.

Not sure about *2 (while running the guest) part. Here the patch checks 
twice before entering the guest.
Once when IRQs are not disabled and once after disabling IRQs.

> I think it is doable for books3s_hv atleast. (though might need rewrite)
do what exactly?
> """
>
>
> A few questions that comes to my mind.
>
> 1. I think you are doing for both *1 and *2 right? Is *1 necessary 
> still for powerpc?
yes, before entering the guest we check twice. Once when IRQs are not 
disabled and once after disabling IRQs.
> 2. There is a for loop. What is it doing? Does this still need similar 
> checks?
>
>         if (is_kvmppc_resume_guest(r) && 
> !kvmppc_vcpu_check_block(vcpu)) {
>                 kvmppc_set_timer(vcpu);
>
>                 prepare_to_rcuwait(wait);
>                 for (;;) {
>                         set_current_state(TASK_INTERRUPTIBLE);
>                         if (signal_pending(current)) {
>                                 vcpu->stat.signal_exits++;
>                                 run->exit_reason = KVM_EXIT_INTR;
>                                 vcpu->arch.ret = -EINTR;
>                                 break;
>                         }
>
>                         if (kvmppc_vcpu_check_block(vcpu))
>                                 break;
>
>                         trace_kvmppc_vcore_blocked(vcpu, 0);
>                         schedule();
>                         trace_kvmppc_vcore_blocked(vcpu, 1);
>                 }
>                 finish_rcuwait(wait);
>         }
>         vcpu->arch.ceded = 0;

IIUC, the vCPU has voluntarily went idle in the guest and it's
about to re-enter, but there's genuinely nothing to deliver yet.
So, it parks itself here until, something actually wake this vCPU.

I am not quite sure, if signal_pending() should be replaced with
xfer_*_pending() check, because vCPU is not re-entering the guest.

Adding the xfer_*_pending() check here will break the loop even
when other flags causing busy spins (cede/re-enter).

>
> PS: cc'ing me would have helped me to see the mail earlier since you 
> had referred
> to the patch I had sent.

Yes. I missed it.

