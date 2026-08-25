Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EF1A680C
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648038; cv=none; b=cTryjAGbBPGNhBMB9mmgsmYqWcO54QzzlclJJhgYcs5iCSBkgJ63V1uZLewwjJRLFSVeSA5IrrpI4Gksgft411optvvMpH6VTMHWHzBTT7+7ImEbJ8lENdHvh9zXBmrJiEoW6OjtU1bWNMg3VIZP/44LLLkgr4yGgAimpzbU9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648038; c=relaxed/simple;
	bh=OyC4Sg1Ouvvc4Io+csDOSqDHTfHFXBBiC2Pb9BUHyKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I7B9Tr0iPB9O6Dkr8hR41FACS0m3sad3+BUJBtQCQSY5fF2/VS9iAJk4rmqKlXx5vlScNWUHSdfRFjxAiasnnJYD0ILVX57UaCxF4VaUUtzKwMP5xNinX2ywJICd+hl0BU/mP9VDsPmg5LardZPOMRniBmnzsH6oRqzlK4ZkLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCiQmAHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCiQmAHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C41F00A3A;
	Tue, 25 Aug 2026 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787648037;
	bh=9b0mTVLdLZE7sTqBGZbSKiwA9nqaNiCnfuj4Q2QDxu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCiQmAHhnlMt5949cXnijyHhxIzfpui/Yyxi96JYRXPoL9NeRIILrtil2BAFPTLql
	 UaZr/CNbZOOKmRUfbJ2awevjH5u1+TbUfC0fhNr+D2scBWLm+J3XSZ5KMlUfV6Ogqs
	 7/n82pVsM/Jd8QptIFe05Ro4Kl1r0dJC4pC9lr1FFIGeCD8v2d7DUI2PzhBe4zVPlI
	 QvUetq5DII+iojC/oBDXbg2EqFOa64kZlWzyqjhGNXxSEP0dAT+cXsEPJIXr3zDMjo
	 tO1sDK5hH2ufBV52zDys6JIp297rd41dweF+I1hgg/FYGh8gxe7mk9NolqE7WD0kBM
	 f5/L1vgdSNbJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] RISC-V: KVM: Report snapshot write failure to
 the guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260825083719.643970-3-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
 <20260825083719.643970-3-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:53:56 +0000
Message-Id: <20260825085356.E92C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Repeated or failed calls to SBI_EXT_PMU_SNAPSHOT_SET_SHMEM cau=
se a memory leak and lead to a NULL pointer dereference.
- [Critical] Integer overflow in kvm_riscv_vcpu_pmu_event_info causes a mas=
sive heap buffer overflow.
- [High] A failure while stopping one PMU counter prevents snapshot updates=
 for all subsequent successfully stopped counters.
- [High] Starting an already-started counter silently corrupts its base val=
ue and violates state atomicity.
--

--- Patch [2]: [PATCH v1 2/3] RISC-V: KVM: Report snapshot write failure to=
 the guest ---
commit 2b7f150df4c06e5c182586d3b92e176b5a3ac870
Author: SeungJu Cheon <suunj1331@gmail.com>

RISC-V: KVM: Report snapshot write failure to the guest

If kvm_vcpu_write_guest() fails while updating the PMU snapshot area
on counter stop, the guest may receive SBI_SUCCESS without the
snapshot being updated, leaving stale data in shared memory. This
commit ensures SBI_ERR_FAILURE is returned when the write fails.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 56dd5b1b2846c..45dd5233340dc 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -723,9 +723,10 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>  		}
>  	}
> =20
> -	if (shmem_needs_update)
> -		kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
> -					     sizeof(struct riscv_pmu_snapshot_data));
> +	if (shmem_needs_update &&
> +	    kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
> +				 sizeof(struct riscv_pmu_snapshot_data)))
> +		sbiret =3D SBI_ERR_FAILURE;
> =20
>  out:
>  	retdata->err_val =3D sbiret;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the loop earlier =
in
kvm_riscv_vcpu_pmu_ctr_stop():

	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
		/* ... */
		if (snap_flag_set && !sbiret) {
			/* ... */
			kvpmu->sdata->ctr_values[i] =3D pmc->counter_val;
			shmem_needs_update =3D true;
		}

Does a failure while stopping one PMU counter prevent snapshot updates for =
all
subsequent successfully stopped counters?=20

The loop relies on sbiret being zero to update the snapshot, but sbiret acts
as a global error flag that is never cleared between iterations.


[Severity: High]
This is also a pre-existing issue, but I noticed a potential concern in
kvm_riscv_vcpu_pmu_ctr_start():

	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
		/* ... */
		pmc =3D &kvpmu->pmc[pmc_index];
		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
			pmc->counter_val =3D ival;
		} /* ... */

		} else if (pmc->perf_event) {
			if (unlikely(pmc->started)) {
				sbiret =3D SBI_ERR_ALREADY_STARTED;
				continue;
			}

Does starting an already-started counter silently corrupt its base value?

The pmc->counter_val is modified before validating the pmc->started state,
which could permanently overwrite the active counter base value.


[Severity: Critical]
This is a pre-existing issue, but can repeated or failed calls to
SBI_EXT_PMU_SNAPSHOT_SET_SHMEM cause a memory leak and lead to a NULL
pointer dereference?

In kvm_riscv_vcpu_pmu_snapshot_set_shmem():

	kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
	if (!kvpmu->sdata) {
		sbiret =3D SBI_ERR_FAILURE;
		goto out;
	}

	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does =
it internally */
	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
		kfree(kvpmu->sdata);
		kvpmu->sdata =3D NULL;
		sbiret =3D SBI_ERR_INVALID_ADDRESS;
		goto out;
	}

It unconditionally overwrites kvpmu->sdata without freeing the previous
allocation. Additionally, upon error, it sets kvpmu->sdata to NULL without
clearing kvpmu->snapshot_addr.

Later, in kvm_riscv_vcpu_pmu_ctr_stop():

		if (snap_flag_set && !sbiret) {
			/* ... */
			if (test_bit(pmc_index, kvpmu->pmc_overflown))
				kvpmu->sdata->ctr_overflow_mask |=3D BIT(i);
			kvpmu->sdata->ctr_values[i] =3D pmc->counter_val;

The mismatch between a valid snapshot_addr and a NULL sdata could cause a
direct NULL pointer dereference here.


[Severity: Critical]
This isn't a bug introduced by this patch, but does the shmem_size calculat=
ion
in kvm_riscv_vcpu_pmu_event_info() overflow?

	struct riscv_pmu_event_info *einfo =3D NULL;
	int shmem_size =3D num_events * sizeof(*einfo);
	/* ... */
	einfo =3D kzalloc(shmem_size, GFP_KERNEL);
	/* ... */
	for (int i =3D 0; i < num_events; i++) {
		/* ... */
		einfo[i].output =3D (ret > 0) ? 1 : 0;
	}

The integer truncation of shmem_size results in a small allocation when
num_events is very large (e.g., 0x10000001), while the loop uses the
untruncated num_events.=20

Can this cause out-of-bounds heap writes during the loop execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825083719.6439=
70-1-suunj1331@gmail.com?part=3D2
