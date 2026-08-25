Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBA3AA182
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647922; cv=none; b=RJzYVfWEXZMWbdyZxEv5SOCWrfljPuWgb9gH5VOeLlRVuc2OpZy/MUrLsSmeOS943gV3WDs1tDSU8Owgk5MGw0mwnlNIVidRhzpBVmOMLn8teop3opqre1m0GwwudIqBjYXWH1j9zleIXcpZSqARnVL7we8TfqUBo6RlymSw7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647922; c=relaxed/simple;
	bh=wqRb2lPt30ZWAFQFSQdzXyuK6gQGrFDQr2FTiHNb37o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JyIwkCvRrugUymk+k+nJAm3zTkS0FEkbXejCaGu6rS+QOvEVS15+fNsB2lV155kXIBtMd72HTu7B+3hbgQENHBBsRf6oNxsvjBoh5g9GJ5CRjBGardIsVXiKxpoE3WHgENtS5Oj2EJ8bxPOJfeeY/InfoPaLksv/P2TZyZ0myq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl+VVukS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl+VVukS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F281F000E9;
	Tue, 25 Aug 2026 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647920;
	bh=Iyko7pmo48Sy0NoIuxKTda5tx1/1ShrgXniT7IXxW78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zl+VVukSWPBo2HtSQ0MYyQjjfZmltKELA8NZ5rirlS+OQFqY31X/0eVKSPcHuO5dQ
	 LOe2NMsyqCi3/ids2YjmdUo3Tzp5nBGvI962Qni257z+FgHljZpJxmD13lGWtIi1X9
	 7ZMpMsHtoT0J4ATS94DDcW5a+bO0bITt6TBO0xeIwJLmrGSw47UzekTRg5jqWVYdMl
	 7xJZwTqrCW7sXHZVbCFuiz7g8kmPVRdycUox0leJQWqe0VvFbHnn38MFgzqWZxC/GA
	 dEuHV0KJQsLy0ey+plsjODOQdMWhwp1E2LR+7tn0tH1sgXqxuhJJtjcij+Nr/ASio1
	 FqQe+qWUnEcNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] RISC-V: KVM: Fix perf-backed counter accounting
 across stop and read
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260825083719.643970-4-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
 <20260825083719.643970-4-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:51:59 +0000
Message-Id: <20260825085200.85F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Starting an already-started counter overwrites its internal value =
before failing, causing subsequent reads to return corrupt data.
- [High] Hardware counters configured with `SBI_PMU_CFG_FLAG_AUTO_START` ar=
e not marked as started, preventing them from ever being successfully stopp=
ed.
- [High] Reading high 32-bit PMU CSRs (like CSR_CYCLEH) in a 32-bit RISC-V =
KVM guest results in an illegal instruction trap, breaking hardware perform=
ance monitoring on RV32.
- [Medium] The variable `sbiret` accumulates the error state across iterati=
ons of the counter mask, causing subsequent valid counters to fail snapshot=
ting if an earlier counter was already stopped.
--

--- Patch [3]: [PATCH v1 3/3] RISC-V: KVM: Fix perf-backed counter accounti=
ng across stop and read ---
commit 4a25612420d054353a1af5f2be56663ddf614797
Author: SeungJu Cheon <suunj1331@gmail.com>

RISC-V: KVM: Fix perf-backed counter accounting across stop and read

pmu_ctr_read() adds the event count returned by perf_event_read_value()
to counter_val, which can accumulate the same count repeatedly across
reads. kvm_riscv_vcpu_pmu_ctr_stop() also leaves counter_val stale by
not folding the current event count into it.

Make reads of perf-backed counters side-effect free, and use
perf_event_pause() when stopping a counter to fold the current event
count into counter_val while resetting it. This preserves the counter
value across stop/start and lets the snapshot path use counter_val
directly.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 45dd5233340dc..7d50490cc6222 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -268,12 +268,13 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsi=
gned long cidx,
>  			return -EINVAL;
> =20
>  		pmc->counter_val =3D kvpmu->fw_event[fevent_code].value;
> +		*out_val =3D pmc->counter_val;
>  	} else if (pmc->perf_event) {
> -		pmc->counter_val +=3D perf_event_read_value(pmc->perf_event, &enabled,=
 &running);
> +		*out_val =3D pmc->counter_val +
> +			   perf_event_read_value(pmc->perf_event, &enabled, &running);
>  	} else {

[Severity: High]
This isn't a bug introduced by this patch, but does reading high 32-bit
PMU CSRs in a 32-bit RISC-V KVM guest result in an illegal instruction trap?

If an RV32 guest executes a CSR read instruction on a high PMU CSR (like
CSR_CYCLEH), kvm_riscv_vcpu_pmu_read_hpm() calculates the index:

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_read_hpm() {
    ...
    cidx =3D csr_num - CSR_CYCLE;

    if (pmu_ctr_read(vcpu, cidx, val) < 0)
        return KVM_INSN_ILLEGAL_TRAP;
    ...
}

For high CSRs, which are offset by 0x80 from the base CSRs on RV32, cidx
would be out of bounds. Will this cause the bounds check at the beginning
of pmu_ctr_read() to fail and reject the high CSR read, breaking hardware
performance monitoring entirely on RV32?

>  		return -EINVAL;
>  	}
> -	*out_val =3D pmc->counter_val;
> =20
>  	return 0;
>  }

[ ... ]

> @@ -679,8 +679,11 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>  			}
>  		} else if (pmc->perf_event) {
>  			if (pmc->started) {
> -				/* Stop counting the counter */
> -				perf_event_disable(pmc->perf_event);
> +				/*
> +				 * Stop the counter and fold the live count into counter_val.
> +				 * Reset the event value to avoid redundant accumulation.
> +				 */
> +				pmc->counter_val +=3D perf_event_pause(pmc->perf_event, true);
>  				pmc->started =3D false;
>  			} else {
>  				sbiret =3D SBI_ERR_ALREADY_STOPPED;
>  			}

[Severity: High]
This is a pre-existing issue, but does pmc->started accurately track the
running state for counters configured with auto-start?

In kvm_pmu_create_perf_event(), the perf event is enabled for AUTO_START
without updating the tracking state pmc->started:

arch/riscv/kvm/vcpu_pmu.c:kvm_pmu_create_perf_event() {
    ...
    if (flags & SBI_PMU_CFG_FLAG_AUTO_START)
        perf_event_enable(pmc->perf_event);
    ...
}

When the guest later tries to stop the counter here in
kvm_riscv_vcpu_pmu_ctr_stop(), will it hit this !pmc->started branch,
skip calling perf_event_pause(), and leak the running state of the counter
on the host?

> @@ -694,9 +697,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu=
, unsigned long ctr_base,
>  		}
> =20
>  		if (snap_flag_set && !sbiret) {
> -			if (pmc->perf_event)
> -				pmc->counter_val +=3D perf_event_read_value(pmc->perf_event,
> -									  &enabled, &running);

[Severity: Medium]
This is a pre-existing issue, but does sbiret accumulate the error state
across iterations of the counter mask?

If a guest VM calls SBI PMU stop with a counter mask containing multiple
counters, and an earlier counter is already stopped, sbiret is set to
SBI_ERR_ALREADY_STOPPED and never reset.

Will subsequent running counters be successfully stopped, but have their
snapshot update bypassed in shared memory because sbiret remains non-zero?

>  			/*
>  			 * The counter and overflow indices in the snapshot region are w.r.to
>  			 * cbase. Modify the set bit in the counter mask instead of the pmc_i=
ndex


While looking at this area, I also noticed another pre-existing issue relat=
ed
to starting counters:

[Severity: High]
This is a pre-existing issue, but does starting an already-started counter
overwrite its internal value before failing?

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_ctr_start() {
    ...
    if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
        pmc->counter_val =3D ival;
    }
    ...
    if (unlikely(pmc->started)) {
        sbiret =3D SBI_ERR_ALREADY_STARTED;
        continue;
    }
    ...
}

If a guest VM calls SBI PMU start on an already-started counter with the
initialization flag set, pmc->counter_val is overwritten unconditionally
before the pmc->started check aborts the operation.

Could this cause subsequent reads to return corrupt data, allowing a guest
OS to corrupt the internal state machine of its own PMU counters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825083719.6439=
70-1-suunj1331@gmail.com?part=3D3
