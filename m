Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD439CCFA
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615133; cv=none; b=QNyJLtn+fCW6u6croxDf4+qnLVs19FTSwUE5tmWYo3Q13NUf/XLnVaQxjsO0be3jq7U6d4cwdyTdYPfRFUDmyBNMBh0fBNssoe3OxDbD8kf37MYLONMX+prkYQrnWy7P+On9ZmREflkFG/3w1zTUmlp/VdOlVfBx2kqFxbtNCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615133; c=relaxed/simple;
	bh=vRtxxer00uc2U187miiPsg53rKVr+Yn7ChiCt6eg99k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sWCBE6wW/2KZzj81WK6Emeg81CZJsK+eplnwnF6Tbm/xBIAr3Oajm8izHGbJDpZnt3tViRhwsCYRTt9ilf2EZfce/Lx5KHeoKwADUpglPgmlg8EnSA6QZq30iNkbcQFP46qC2XOQX9EjlS1m8RQvtgaxNew/XPJyzlX8CIARNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyuuB02t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyuuB02t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9CD1F000E9;
	Thu, 13 Aug 2026 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615131;
	bh=MOOoPWm58b+obKIqdnYUykn+oeY4/UGYzLcndzimaBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YyuuB02tjfIXg08pCLyfw40zr0yJB7Dbp3TlX6lwgIBr9HUYzDKDCPU8sAivSyDsV
	 aJVpaeUYD9DOBE20dylcRzGK7ufym2j7EeKTnGyqdKMDZNwDihsB4He8mAuppfcPoj
	 2FEwzsTDF7l+sHd/xGEcsvhYeZ73fe8lQknuHd/V3rRYpSYZlwAqD83P7uX1N3UZl0
	 29HuaJrGDtTr2FilWE+w2qhYB95s0SjBzQSMPirohqf40Rp210bo6fxp4ptOFqyO9I
	 LhzaK2JmDHh/TTcDmR7U6/PfVZpRCmP0hMVoEkaFYrIy4cIKA3scHO5Wjx9+pilAxu
	 6m450b2BpmJ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] powerpc/perf: Use the aggregate context switch
 values from vcpu struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260813094535.10083-3-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-3-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:58:50 +0000
Message-Id: <20260813095851.4D9CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Task-bound PMU events cache a stale vCPU pointer, resulting in tra=
cking the wrong vCPU.
- [High] CPU-wide and system-wide PMU events are broken and silently report=
 0 if added when no guest is running.
- [High] Uninitialized event state on task migration leaks stale vCPU point=
ers.
- [Medium] Unbalanced disablement of the global hardware PMU counters.

Pre-existing issues:
- [Critical] Dereferencing `kvm_hstate.kvm_vcpu` leads to a Use-After-Free =
if the previously running VM has been destroyed.
--

--- Patch [2]: [PATCH v2 2/3] powerpc/perf: Use the aggregate context switc=
h values from vcpu struct ---
commit e328e1f6c8baf0140410c1983f559e87d1d0efdc
Author: Gautam Menghani <gautam@linux.ibm.com>
powerpc/perf: Use the aggregate context switch values from vcpu struct

This commit aims to fix inaccurate vpa-pmu counter reporting during vCPU
migrations and when vCPUs are not running by fetching aggregate values
from the vcpu struct instead of relying on the host cpu's PACA.

> diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> --- a/arch/powerpc/perf/vpa-pmu.c
> +++ b/arch/powerpc/perf/vpa-pmu.c
[ ... ]
> @@ -99,19 +99,19 @@ static unsigned long get_counter_data(struct perf_eve=
nt *event)
>  	switch (config) {
>  	case L1_TO_L2_CS_LAT:
>  		if (event->attach_state & PERF_ATTACH_TASK)
> -			data =3D kvmhv_get_l1_to_l2_cs_time_vcpu();
> +			data =3D vcpu->arch.l1_to_l2_cs;

[Severity: Critical]
This is a pre-existing issue, but does dereferencing the vcpu pointer here
lead to a use-after-free if the previously running VM has been destroyed?

When KVM exits a guest, it does not clear local_paca->kvm_hstate.kvm_vcpu,
leaving a dangling pointer in the host's PACA.=20

The PMU driver reads this dangling pointer in vpa_pmu_add() and permanently
caches it in event->pmu_private. Subsequent calls to vpa_pmu_read() pass
this cached pointer to get_counter_data(), which dereferences the freed
memory here.

>  		else
>  			data =3D kvmhv_get_l1_to_l2_cs_time();
>  		break;
[ ... ]
> @@ -126,21 +126,33 @@ static int vpa_pmu_add(struct perf_event *event, in=
t flags)
>  {
>  	u64 data;
> +	struct kvm_vcpu *vcpu;
> =20
> +	vcpu =3D local_paca->kvm_hstate.kvm_vcpu;
> +	if (!vcpu)
> +		goto out;

[Severity: High]
Does this early exit break CPU-wide and system-wide profiling?

If a user initiates a CPU-wide profiling session (e.g. perf stat -a) and no
guest is actively running on that specific CPU at that moment, vcpu is NULL.
The function exits early returning 0 without initializing event->pmu_private
or event->hw.prev_count.=20

Subsequent calls to vpa_pmu_read() check if (!vcpu) and immediately return,
silently leaving the event counter permanently at 0.

[Severity: High]
Could this early exit also leak state from a previous CPU when a task
migrates?

When a task with a vpa_pmu event migrates to a new CPU, perf core calls
pmu->del on the old CPU and pmu->add on the new CPU. If vcpu is NULL on the
new CPU, it returns 0 (success) but jumps to out without updating or
clearing event->pmu_private.=20

The event silently retains the old vcpu pointer and prev_count from the
previous CPU, resulting in corrupted profiling data calculated against an
unrelated CPU's context.

[Severity: Medium]
Are the global hardware PMU counters skipped here on early bailout, leading
to an unbalanced disablement later?

If a user creates a PMU event on a CPU where no vCPU is active, this early
exit skips calling kvmhv_set_l2_counters_status(cpu, true).=20

However, when the event is deleted or scheduled out, vpa_pmu_del()
unconditionally calls kvmhv_set_l2_counters_status(cpu, false). This
unbalanced behavior forcefully disables the hardware counters even when they
were never enabled, which could break legitimate concurrent KVM tracing
sessions.

> +
> +	event->pmu_private =3D vcpu;

[Severity: High]
Is it possible caching the vcpu pointer here results in tracking the wrong
vCPU for task-bound events?

When a user creates a task-bound vpa_pmu perf event, the core perf
subsystem calls vpa_pmu_add() during perf_event_context_sched_in(). At this
point, the task has been scheduled but has not yet invoked the KVM_RUN
ioctl.

Because of this, local_paca->kvm_hstate.kvm_vcpu does not point to the
incoming task's vCPU; it contains a stale pointer to the last vCPU that
executed on this physical host CPU. Caching this pointer permanently means
the event tracks unrelated data.

>  	kvmhv_set_l2_counters_status(smp_processor_id(), true);
> =20
> -	data =3D get_counter_data(event);
> +	data =3D get_counter_data(vcpu, event);
>  	local64_set(&event->hw.prev_count, data);
> =20
> +out:
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813094535.1008=
3-1-gautam@linux.ibm.com?part=3D2
