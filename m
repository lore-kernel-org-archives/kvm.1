Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C2371071
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273291; cv=pass; b=MVGRNtYfgKNpAOFcvkdI5VxT7u1U/ZPQO52SbgJlw+3lZZ9t5xcsFnl0biX3bnt6NNQmgCGzXlL8SdER4MPYWtnmK19veM8vUooe0anv67Q8PZvnrVT1/b6S2B9tLedIZVdLKhkWdwmee6cdIi+q2GfjV5zf6QOlCHQMvVjhmus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273291; c=relaxed/simple;
	bh=46RT1jTZuKzAnBJy6jbQeAlgc6F9Ih5O1Vy5HojrR48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At8X3+5Sye+BV/f9oQ3R/RnGavyyqGCQgKdkrit/xEBD+FAu8VbNC1JU3gU2LCJ2Pyu0e2XutnQRyRaOqGFDXaWYMsJLsJQpiJF0+ORxL7eYjjdVR5Str6zpv7UJnXO+LkNBnu1a7sl5dSAC31dW7neSfU4HPgj+QMBXLqYn2+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdEutsX4; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdEutsX4"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48662d16d08so448487b6e.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781273289; cv=none;
        d=google.com; s=arc-20240605;
        b=BG10RIZ8JoV5TcVc4aCu2X5y5m/Lyhd1MtsQlQ8j7488YcXtpbqiIARzV+3Dv8jUQL
         sN2S8Hp8+4VyV0CSJrfcrVfP6UjGpGEn8z08VTZoEmIDUJlBSBRBujuwx2XjbUPjVsR9
         iWJTnkY82UNIZaJl/DJ5w64eoQ9RnrcmuNLYVmOMCmkIodRpJhCw75zpTXD+cYAsi3ga
         eDO+ZKQtZNeYTiEoJyYTw9ij8ZkwWgUXPcZbtrmfLegpojj8XHIlIfex5el3l+20B1P0
         Q7X8O2wz2P8VTkjod3sXVOod/k8p+TSsBftKMJ7v7WXqT08zd2Gl1We/RzsJhhbmLoYM
         ASJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wk3F39AcD/mFD7/HEl3Mw+6gpauUrapzwQCXBQgCh8g=;
        fh=52VYddopx7juaP5VsKvItvUtu03OSN0gUiHXe4EMZNM=;
        b=d8xzSU6k/tIbQP5EHGRuS4+VXh8ykL0jfP1JavVlaqqEVhBaWoRE1de5YsjpDFX0kx
         RvakooH2pOiteEG3UQC/E2a6CXBdQkVSQflXw9AX9c/AoY0wLa4rYm8FnhlfTojgzHq+
         uvT0QWCwxISJ+xX7vL8ZjPfjfqgD02SIIf3ELjdumCul5AkDDVRj+OBYuZIz8Nvq1WRi
         fXENzceERdtqNI/Sg3KqYI38LWwzbpntyKHGQiJ229DzAGS/nFPaBs/a2p6TFtghZ0kI
         lJU9Wn00YyoI5l92V1iiE8oGe+gCHPPCvBPHsYkU3rbxi6g/ultpJDIt64gyWvmmma1Y
         9Ltw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781273289; x=1781878089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk3F39AcD/mFD7/HEl3Mw+6gpauUrapzwQCXBQgCh8g=;
        b=rdEutsX4sdhsA0NdB/nQbIhISuyY9ZFZptvhHj4JEC1J92ktPs9ECVGvmm59wX7HUQ
         0CPMcdUm3f8X5CqN4YGw3LZ5GtIej515D3wPsDfFq4OQnBQbPDJM102Xc/g/QmR5h/KB
         nZCzpplXUC09mk7j2wKgrocGidhctCHZGMKJJy5/4VKZtCtSrKvOnQoeCH+YXTuNk0ui
         RxP8055nXBI/5znmrSmtvwyBXo0DFLVuFDrAYabs9g499ARK65mKUoSZTVhzdy4rSRPu
         XAIoFMY8r+Jki/6qLev6BySuVCfyOB5MjNgat/RaNWo0LbEEXnGABo9lBqIRXvxQjUAm
         lRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273289; x=1781878089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk3F39AcD/mFD7/HEl3Mw+6gpauUrapzwQCXBQgCh8g=;
        b=UVKeAcc+ZDS+IKbb1Z/B0wOLrFUcxfgP/vy2eWoF7F9fMV0KjVnrBPtgiXsOUjL3CA
         IVKwlg0k3mOdDXni88uTYql9PBryqB5G2DU4p0K5nZo6F5Rt56FOWCjuliO1vF+91JNz
         STb1A3RUJ/lEb87R2Gi/0vGlzkClVjrEu8aENkgJ1cTi6RPW8jqD+1bzTzCHoEoPcvA3
         xtvxTT2ovz04MBQ/BYmGCRBQw5DZJvwKGs55coQm0VOr0Y0pTS1U4GMKVOVEOwwSgH3e
         JZAs4o/0VZYLPbCKgyK/0UFIk/NsMNL+eP71hskEnvlak0SjO/fPo5NYIkM+zZwtrb+l
         p3pQ==
X-Forwarded-Encrypted: i=1; AFNElJ97kmWd+ehpZq63BV1s/gt+AVs5MfmPkmYy6StFx8E5mcfgr+YiPLXu1VVYoRBW3K3+13E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZizRWfT5MjP1tTsIRGwMqRbMAJTrYb0+teCCe/iQpqFmhGMr
	9JXmwrceqO66nC0hB0oZvRTDdHNqCYQw4JAusRuhMVwpfJlIrQEoxBy/1mUSAoHIt+PmW++5boQ
	H1FUNPnuEMmmlU1gZGbbJ0sGcu/FWdyw=
X-Gm-Gg: Acq92OGUc87l0c1Alc4I4/21MBWninFA9xu6/n/Bmpt7CnxPAC4O5IUINF+EhRzGJTJ
	iHJuYtK/MenR6UkYlQSAKNFPwBE4L6LNU9U0WEBEcWJUm7FmUqakA5gV/098nuXq3qsBV0x9Cte
	LilHy+IkKVvO0BjShCtDUXrf1/6sGCJO16B/mORwHKMSQt5u/R/OlycUY/V748XwYSq9Gq5LPDU
	E5kSEITG0d5j/Vw/f+uaFDxElN1SY9kxXnBnHWBAOMHzHsDnsWVcaIbAOGJOuiFRUs26ZosI84N
	+Wge+kND
X-Received: by 2002:a05:6808:190a:b0:482:c2f2:7bde with SMTP id
 5614622812f47-4872f31352dmr1829096b6e.4.1781273288528; Fri, 12 Jun 2026
 07:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219035334.39790-1-kernellwp@gmail.com> <9a8c1bd7-5d95-4d79-aae2-fc06c448b9a3@linux.ibm.com>
 <CANRm+Cz8Lh+AdsLSSy-u-KQhOpOqBOOAfC1-N7eTO_UM46f6Uw@mail.gmail.com>
 <d5bb7e5d-94d3-4b6c-b1a6-e11d13db38f3@linux.ibm.com> <1d99d7ea-e8c0-4afd-a6cb-58d3a09a7dfa@linux.ibm.com>
 <f8b453e9-0f62-4183-ae6a-d3982ae0827f@linux.ibm.com>
In-Reply-To: <f8b453e9-0f62-4183-ae6a-d3982ae0827f@linux.ibm.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 12 Jun 2026 22:07:56 +0800
X-Gm-Features: AVVi8Ccjh6VxrBI9U_UmYa0NIMzCtxzegtwUV3dit8wSBM93yvSn5nAOUui2Qqw
Message-ID: <CANRm+Cxfs+mRy935Xi5KjEy-GjkYYfDFb2f8-O2hxYdG3G92ww@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Richie Buturla <richie@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richie,
On Wed, 13 May 2026 at 20:52, Richie Buturla <richie@linux.ibm.com> wrote:
>
>
> On 17/04/2026 12:30, Richie Buturla wrote:
> >
> > On 08/04/2026 10:35, Richie Buturla wrote:
> >>
> >> On 01/04/2026 10:34, Wanpeng Li wrote:
> >>> Hi Christian,
> >>> On Thu, 26 Mar 2026 at 22:42, Christian Borntraeger
> >>> <borntraeger@linux.ibm.com> wrote:
> >>>> Am 19.12.25 um 04:53 schrieb Wanpeng Li:
> >>>>> From: Wanpeng Li <wanpengli@tencent.com>
> >>>>>
> >>>>> This series addresses long-standing yield_to() inefficiencies in
> >>>>> virtualized environments through two complementary mechanisms: a vC=
PU
> >>>>> debooster in the scheduler and IPI-aware directed yield in KVM.
> >>>>>
> >>>>> Problem Statement
> >>>>> -----------------
> >>>>>
> >>>>> In overcommitted virtualization scenarios, vCPUs frequently spin
> >>>>> on locks
> >>>>> held by other vCPUs that are not currently running. The kernel's
> >>>>> paravirtual spinlock support detects these situations and calls
> >>>>> yield_to()
> >>>>> to boost the lock holder, allowing it to run and release the lock.
> >>>>>
> >>>>> However, the current implementation has two critical limitations:
> >>>>>
> >>>>> 1. Scheduler-side limitation:
> >>>>>
> >>>>>      yield_to_task_fair() relies solely on set_next_buddy() to
> >>>>> provide
> >>>>>      preference to the target vCPU. This buddy mechanism only offer=
s
> >>>>>      immediate, transient preference. Once the buddy hint expires
> >>>>> (typically
> >>>>>      after one scheduling decision), the yielding vCPU may preempt
> >>>>> the target
> >>>>>      again, especially in nested cgroup hierarchies where vruntime
> >>>>> domains
> >>>>>      differ.
> >>>>>
> >>>>>      This creates a ping-pong effect: the lock holder runs
> >>>>> briefly, gets
> >>>>>      preempted before completing critical sections, and the
> >>>>> yielding vCPU
> >>>>>      spins again, triggering another futile yield_to() cycle. The
> >>>>> overhead
> >>>>>      accumulates rapidly in workloads with high lock contention.
> >>>> Wanpeng,
> >>>>
> >>>> late but not forgotten.
> >>>>
> >>>> So Richie Buturla gave this a try on s390 with some variations but
> >>>> still
> >>>> without cgroup support (next step).
> >>>> The numbers look very promising (diag 9c is our yieldto hypercall).
> >>>> With
> >>>> super high overcommitment the benefit shrinks again, but results
> >>>> are still
> >>>> positive. We are probably running into other limits.
> >>>>
> >>>> 2:1 Overcommit Ratio:
> >>>> diag9c calls:                       225,804,073 =E2=86=92 213,913,26=
6  (-5.3%)
> >>>> Dbench thrpt (per-run mean):        +1.3%
> >>>> Dbench thrpt (per-run median):      +0.8%
> >>>> Dbench thrpt (total across runs):   +1.3%
> >>>> Dbench thrpt (avg/VM):              +1.3%
> >>>>
> >>>> 4:1:
> >>>> diag9c calls:                       833,455,152 =E2=86=92 556,597,62=
7 (-33.2%)
> >>>> Dbench thrpt (per-run mean):        +7.2%
> >>>> Dbench thrpt (per-run median):      +8.5%
> >>>> Dbench thrpt (total across runs):   +7.2%
> >>>> Dbench thrpt (avg/VM):              +7.2%
> >>>>
> >>>>
> >>>> 6:1:
> >>>> diag9c calls:                       967,501,378 =E2=86=92 737,178,41=
9 (-23.8%)
> >>>> Dbench thrpt (per-run mean):        +5.1%
> >>>> Dbench thrpt (per-run median):      +4.8%
> >>>> Dbench thrpt (total across runs):   +5.1%
> >>>> Dbench thrpt (avg/VM):              +5.1%
> >>>>
> >>>>
> >>>>
> >>>> 8:1:
> >>>> diag9c calls:                       872,165,596 =E2=86=92 653,481,53=
0 (-25.1%)
> >>>> Dbench thrpt (per-run mean):        +11.5%
> >>>> Dbench thrpt (per-run median):      +11.4%
> >>>> Dbench thrpt (total across runs):   +11.5%
> >>>> Dbench thrpt (avg/VM):              +11.5%
> >>>>
> >>>> 9:1:
> >>>> diag9c calls:                       809,384,976  =E2=86=92 587,597,1=
63
> >>>> (-27.4%)
> >>>> Dbench thrpt (per-run mean):        +4.5%
> >>>> Dbench thrpt (per-run median):      +4.0%
> >>>> Dbench thrpt (total across runs):   +4.5%
> >>>> Dbench thrpt (avg/VM):              +4.5%
> >>>>
> >>>>
> >>>> 10:1:
> >>>> diag9c calls:                       711,772,971 =E2=86=92 477,448,37=
4 (-32.9%)
> >>>> Dbench thrpt (per-run mean):        +3.6%
> >>>> Dbench thrpt (per-run median):      +1.6%
> >>>> Dbench thrpt (total across runs):   +3.6%
> >>>> Dbench thrpt (avg/VM):              +3.6%
> >>> Thanks Christian, and thanks to Richie for running this on s390. :)
> >>>
> >>> This is very valuable independent data. A few things stand out to me:
> >>>
> >>> - The consistent reduction in diag9c calls across all overcommit
> >>> ratios (up to -33.2% at 4:1) confirms that the directed yield
> >>> improvements are effective at reducing unnecessary yield-to
> >>> hypercalls, not just on x86 but across architectures.
> >>> - The fact that these results are without cgroup support is actually
> >>> informative: it tells us the core yield improvement carries its weigh=
t
> >>> on its own, which helps me scope the next revision more tightly.
> >>> - The diminishing-but-still-positive returns at very high overcommit
> >>> (9:1, 10:1) match what I see on x86 as well =E2=80=94 other bottlenec=
ks start
> >>> dominating but the mechanism does not regress.
> >>>
> >>> Btw, which kernel version were these results collected on?
> >>>
> >>> Regards,
> >>> Wanpeng
> >>>
> >> Hi Wanpeng,
> >>
> >> I collected these results on a 6.19 kernel - which should also
> >> include the existing fixes for yielding and forfeiting vruntime on
> >> yield that K Prateek mentioned.
> >>
> > Hi Wanpeng. I'm trying out cgroup runs with libvirt but the results
> > seem to vary when I reproduce and need to look into this again so we
> > should not try to base any decisions on the numbers.
> >
> > I'll also rerun on the kernel version you are using (The 6.19-rc1).
> Hi Wanpeng,
>
> I spent some more time benchmarking the scheduler-side changes on s390
> and I think I can now narrow down where the benefit shows up and where
> it does not.

Thanks a lot for spending more time on this and for breaking the
results down by placement.  This is exactly the kind of data that
helps separate the scheduler effect from general overcommit noise.

> For context, my test runs have libvirt vms running dbench with the
> number of clients equal to the number of vCPUs, and the workload runs on
> tmpfs so that this is primarily measuring scheduler behavior.
> As far as I can tell, the yield/deboost benefit is constrained to cases
> where the relevant vCPUs are competing on the same runqueue. That makes
> placement the key variable.

Agreed.  The scheduler-side part is fundamentally a same-runqueue
optimization.  It does not try to pull the target from another rq; it
makes the nominated entity win the local pick once the waiter and the
lock-holder/target are already competing on the same rq.

That also explains why the 1:1 pinning and the matched vCPU:pCPU case
are neutral.  With no intra-pool contention there is no local
competition for the scheduler-side hint to resolve, so the path should
be inert rather than provide a measurable gain.

>
> In particular:
>
> 1. With explicit 1:1 vCPU:pCPU pinning, I do not see a meaningful benefit=
.
> For 3 VMs with 16 vCPUs each pinned to 16 pCPUs, the results were:
>
>       diag9c calls:                  61,384,968 -> 62,994,594  (+2.6%)
>       Dbench throughput mean:   -0.5%
>       Dbench throughput median:  -0.3%
>
>     That is basically noise from my point of view. This matches the
> expectation that if the lock waiter and lock holder are not sharing an
> rq, the scheduler-side boost/deboost path has little or nothing to act on=
.
>
> 2. When vCPUs are pooled onto a smaller pCPU set, I can reproduce a benef=
it.

This is the target case.  The diag9c drop is particularly useful: the
~55-68% reduction shows that the mechanism is cutting yield-to churn,
and the few-percent dbench improvement is consistent with that
reduction showing up as useful work once multiple vCPUs of the same VM
contend within the same CPU pool.

>     For 2 VMs with 16 vCPUs each placed on a 8 pCPU pool per VM, I saw:
>
>       diag9c calls:                  62,893,856 -> 20,033,920  (-68.1%)
>       Dbench throughput mean:   +4.2%
>       Dbench throughput median:  +4.0%
>
>     For 3 VMs with 16 vCPUs each placed on a 5 pCPU pool per VM, I saw:
>
>       diag9c calls:                 107,915,379 -> 35,393,080  (-67.2%)
>       Dbench throughput mean:     +4.4%
>       Dbench throughput median:    +4.4%
>
>     I also saw the same pattern with heavier pooling. For 5 VMs with 16
> vCPUs each placed on a 3 pCPU pool per VM, the results were:
>
>       diag9c calls:                 130,986,144 -> 58,153,006  (-55.6%)
>       Dbench throughput mean:     +3.4%
>       Dbench throughput median:    +3.6%
>
> These are the configurations where I consistently see an improvement in
> reduction of diag9c calls (again our yieldto hypercall) and some
> throughput improvement. This works because the VM is actually
> overcommitted onto its allowed pCPU set, so multiple vCPUs from the same
> VM can contend on the same rq and exercise the mechanism.
>
> 3. If there is no intra-VM overcommit, the effect disappears again.

Right, and that is the expected flip side of the same case: 5 vCPUs on
5 pCPUs has no intra-pool contention, so the path stays inert for the
same reason as strict pinning.  The interesting variable is genuinely
the pooling/overcommit onto a smaller pCPU set, not simply "more VMs
on the host", and I think your framing captures that precisely.

For v3, I reworked the scheduler side substantially.  It no longer
applies a vruntime penalty to the yielder; instead it credits bounded
EEVDF lag to the nominated next-buddy and rate-limits only the forced
local reschedule.  That removes the LCA/debounce/penalty-tracking
machinery from v2, but the placement property you observed remains the
same: it is useful under same-rq vCPU pooling/overcommit, and neutral
when there is no such local contention.  I will make that scope
explicit in the v3 cover letter.

>     For 3 VMs with 5 vCPUs on a 5 pCPU pool per VM, the results were:
>
>       diag9c calls:                     696,548 ->    718,219  (+3.1%)
>       Dbench throughput mean: -0.8%
>       Dbench throughput median:  -0.7%
>
>     Again, no meaningful benefit.
>
> So my final takeaway is that on s390 I can only demonstrate a benefit
> when the test setup intentionally causes multiple vCPUs of a VM to share
> runqueues. Plain pinning does not show an effect, and a matched
> vCPU:pCPU configuration such as 5 vCPUs on 5 pCPUs does not either. The
> interesting case is specifically vCPU pooling / overcommit onto a
> smaller pCPU set, not just "more VMs on the host".
>
> I suppose this mechanism does help once the waiter/holder pair can
> actually meet on the same rq. If something similar could somehow target
> useful cross-runqueue cases as well, that would seem like a natural way
> to stretch this benefit further.

Yes, agreed.  Extending this to useful cross-runqueue cases would
likely need load-balancing or migration decisions, rather than just
directed yield, and that comes with a separate set of fairness and
cache-affinity trade-offs.  I would rather keep that as follow-up work
than fold it into this series.

Thanks again for the careful, well-isolated testing.

Wanpeng
