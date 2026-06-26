Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED603CB8F1
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453310; cv=none; b=FbnDy+kUBrOsQ1fFFRhOD2ko//t8YtDjeQlKzqRvR4FGmhwUc+jKw9qii6M3ZtuCFMd5kn9b2XTgHz02uI3qQQmDnJ2xo4bBS7dBFTL43sG9jYKOw5tO2vtYzOklSZZqM4z1f8RClEa2UqN6nPGZmr5UxfloPGgTMePU0tLDiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453310; c=relaxed/simple;
	bh=hjCAj7gzPZ5zTDlyqEW20DJxnuFzNoQTqDaeqxSSkGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0Mzg5a98r/G/uusv/tpCcipshLDUgw1NH/rY/blIn4Yuz1pMmdRV3HnWNQ8fAIEx0Nt5mh+nnzCVbOPCoEg4xWwtpBb1xc/g+EDo9XBOxV6/4RiepOmh0jdDVPCtoqzkKfspr0yZmNuZW1y6NrTKM9ggtd1xWqVUKQnhW8V6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPpRrwGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPpRrwGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5291F000E9;
	Fri, 26 Jun 2026 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782453309;
	bh=l+gmQ5k9y2On7SrE/ez+01ZXS7mHNaCit7HYOL1kzpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPpRrwGo8LQUlEzw3gsEatjNu5SA1ZYwgvemh7hZ6T9AcOU7Hr0WgA1+KDGrJtsM3
	 VVtB/38yq/ZzupFZavBSGxD0y6z6taX3pCpSFiATZo1XwgR9MBNmJotKsI8fJKBklb
	 nW1EGTWc77qA3VOuxncYGXxrRDv40I7nKiFzjbgUXrGeIalgyUhKeT/bhdIdtFRzms
	 kNmCLg7jV6kTAS4Ih1+8scB4To01kss98Tkw+Vjhdh0ZhkGE8vTizoj8sKqvdtmB5M
	 t7FB1MHqMZQQzXXKsH3XvD5hqy2Z3Qrk/hHKdbAjrOsdWYW/9s8V5XjjL2kLPH/g6r
	 aEaPRJ2Jx9LaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: PMU: Bound counter mask scan to
 BITS_PER_LONG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengwen Cheng" <shengwen1997.tw@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626054051.3360865-1-shengwen1997.tw@gmail.com>
References: <20260626054051.3360865-1-shengwen1997.tw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:55:08 +0000
Message-Id: <20260626055509.1A5291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Failing to write to guest memory in `kvm_riscv_vcpu_pmu_snapsh=
ot_set_shmem` frees `kvpmu->sdata` without invalidating `kvpmu->snapshot_ad=
dr`, leading to a memory leak and a guest-triggerable host NULL pointer der=
eference.
- [Critical] Global `cmask` variable is accessed out of bounds using `RISCV=
_MAX_COUNTERS`, causing memory corruption.
- [Critical] Integer overflow in `kvm_riscv_vcpu_pmu_event_info` leads to a=
 massive heap buffer overflow.
- [High] Unbounded host log spam triggered by guest-controlled PMU SBI call=
s.
- [High] Clearing the overflow mask using `~BIT(i)` unconditionally zeroes =
the upper 32 bits of the 64-bit mask on 32-bit systems.
- [High] Shift out of bounds using the `BIT()` macro on indices >=3D 32 in =
the host PMU driver.
- [High] The 64-bit counter width mask is truncated to 32 bits on RV32, cau=
sing incorrect PMU counter delta calculations.
- [High] When stopping and resetting a PMU counter with snapshotting enable=
d, KVM fails to record the final counter value in the guest memory snapshot.
--

commit f7a49cefb133d73d5845f2033e5cc03b53b00223
Author: Shengwen Cheng <shengwen1997.tw@gmail.com>

KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG

The PMU SBI handler passes the guest argument registers directly to the
PMU start/stop helpers. On RV32, RISCV_MAX_COUNTERS is 64 while
BITS_PER_LONG is 32, so find_next_bit() can access bits beyond the storage
of ctr_mask. Limit the scan to BITS_PER_LONG to avoid an out-of-bounds read.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24da..2025b664961c8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -586,7 +586,7 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>  		}
>  	}
>  	/* Start the counters that have been configured and requested by the gu=
est */
> -	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> +	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
>  		pmc_index =3D array_index_nospec(i + ctr_base,
>  					       RISCV_KVM_MAX_COUNTERS);
>  		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
> @@ -658,7 +658,7 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu=
, unsigned long ctr_base,
>  	}
> =20
>  	/* Stop the counters that have been configured and requested by the gue=
st */
> -	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> +	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
>  		pmc_index =3D array_index_nospec(i + ctr_base,
>  					       RISCV_KVM_MAX_COUNTERS);
>  		if (!test_bit(pmc_index, kvpmu->pmc_in_use))

[Severity: High]
This isn't a bug introduced by this patch, but does KVM fail to record the
final counter value in the guest memory snapshot when resetting a counter?

In kvm_riscv_vcpu_pmu_ctr_stop(), if the reset flag is set, the perf event
is eagerly released:

	if (flags & SBI_PMU_STOP_FLAG_RESET)
		kvm_pmu_release_perf_event(pmc);

Immediately following this, the snapshot logic checks for pmc->perf_event:

	if (snap_flag_set && !sbiret) {
		if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
			...
		else if (pmc->perf_event)
			pmc->counter_val +=3D perf_event_read_value(...);

Because kvm_pmu_release_perf_event(pmc) sets pmc->perf_event to NULL, this
condition is false. The read is skipped, and the old, stale pmc->counter_val
is written into the guest's snapshot memory.


[Severity: High]
This is a pre-existing issue, but does clearing the overflow mask using
~BIT(i) unconditionally zero the upper 32 bits of the 64-bit mask on 32-bit
systems?

Also in kvm_riscv_vcpu_pmu_ctr_stop():

	if (flags & SBI_PMU_STOP_FLAG_RESET) {
		...
		if (snap_flag_set) {
			kvpmu->sdata->ctr_overflow_mask &=3D ~BIT(i);
			shmem_needs_update =3D true;
		}

The snapshot field ctr_overflow_mask is a u64. On RV32, BIT(i) evaluates to
a 32-bit unsigned long. ~BIT(i) produces a 32-bit value (e.g., 0xFFFFFFFE).
When bitwise ANDed against the u64 mask, it is zero-extended to
0x00000000FFFFFFFEULL, clearing bits 32-63 of the mask.


[Severity: Critical]
This is a pre-existing issue, but does failing to write to guest memory in
kvm_riscv_vcpu_pmu_snapshot_set_shmem() lead to a memory leak and a host
NULL pointer dereference?

If a guest first calls SBI_EXT_PMU_SNAPSHOT_SET_SHMEM with a valid address,
kvpmu->sdata is allocated and kvpmu->snapshot_addr is set. If the guest
calls it again with an invalid address:

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_snapshot_set_shmem() {
	...
	kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
	...
	if (kvm_vcpu_write_guest(vcpu, snapshot_addr, kvpmu->sdata, ...)) {
		kfree(kvpmu->sdata);
		kvpmu->sdata =3D NULL;
		sbiret =3D SBI_ERR_INVALID_ADDRESS;
		goto out;
	}

The error path frees the newly allocated kvpmu->sdata and sets it to NULL,
but fails to revert kvpmu->snapshot_addr to INVALID_GPA.

Later, in kvm_riscv_vcpu_pmu_ctr_stop(), the snapshot address check passes
because it still holds the stale valid address:

	if (snap_flag_set && kvpmu->snapshot_addr =3D=3D INVALID_GPA) {
		...

And then dereferences the NULL kvpmu->sdata:

	if (test_bit(pmc_index, kvpmu->pmc_overflown))
		kvpmu->sdata->ctr_overflow_mask |=3D BIT(i);

Could this crash the host?


[Severity: Critical]
This is a pre-existing issue, but does an integer overflow in
kvm_riscv_vcpu_pmu_event_info() lead to a massive heap buffer overflow?

The size is calculated using the guest-provided num_events:

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_event_info() {
	...
	int shmem_size =3D num_events * sizeof(*einfo);

If the guest supplies 0x10000001, shmem_size evaluates to 4,294,967,312
bytes. Because shmem_size is a 32-bit int, the result overflows and is
truncated to 16.

The allocation succeeds, and then the code loops using the original
num_events:

	for (int i =3D 0; i < num_events; i++) {
		...
		einfo[i].output =3D ...

Since i < 0x10000001 is true, the loop wildly overwrites memory past the
16-byte allocation. Can this be triggered by a malicious guest?


[Severity: Critical]
This isn't a bug introduced by this patch, but is the global cmask variable
accessed out of bounds, potentially causing memory corruption?

In drivers/perf/riscv_pmu_sbi.c, cmask is defined as:

	static unsigned long cmask;

In pmu_sbi_get_ctrinfo(), it is written using an index up to 63:

	*mask |=3D BIT(i);

And in riscv_pmu_get_hpm_info(), the mask is read using:

	for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS)

Since cmask is only 4 bytes on RV32, and find_next_bit() expects an array
large enough to hold RISCV_MAX_COUNTERS bits (8 bytes), reading 8 bytes
starting at the 4-byte cmask results in an out-of-bounds read into adjacent
BSS memory.


[Severity: High]
This isn't a bug introduced by this patch, but can a malicious guest trigger
unbounded host log spam via PMU SBI calls?

In pmu_ctr_read() and pmu_fw_ctr_read_hi(), a warning is unconditionally
printed if the requested counter index is out of bounds:

arch/riscv/kvm/vcpu_pmu.c:pmu_ctr_read() {
	...
	if (cidx >=3D RISCV_MAX_COUNTERS || cidx =3D=3D 1) {
		pr_warn("Invalid counter id [%ld] during read\n", cidx);
		return 0;
	}

Since these functions are directly reachable via
SBI_EXT_PMU_COUNTER_FW_READ and SBI_EXT_PMU_COUNTER_FW_READ_HI, a guest can
repeatedly issue these calls with an invalid index in a tight loop. Should
this be ratelimited or converted to pr_warn_once()?


[Severity: High]
This is a pre-existing issue, but does shifting out of bounds using the
BIT() macro on indices >=3D 32 in the host PMU driver cause undefined
behavior?

In drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler(), variables such as
overflowed_ctrs are defined as u64. However, bits are set using BIT(lidx):

	overflowed_ctrs |=3D BIT(lidx);

On RV32, BIT() operates on unsigned long (32 bits). Since lidx can be as
large as 63 (RISCV_MAX_COUNTERS - 1), shifting 1UL by 32 or more results in
undefined behavior.


[Severity: High]
This isn't a bug introduced by this patch, but is the 64-bit counter width
mask truncated to 32 bits on RV32, causing incorrect PMU counter delta
calculations?

In drivers/perf/riscv_pmu.c:riscv_pmu_event_update(), cmask is defined as
an unsigned long:

	unsigned long cmask;
	...
	cmask =3D riscv_pmu_ctr_get_width_mask(event);

riscv_pmu_ctr_get_width_mask() returns a u64. On RV32, the upper 32 bits of
this mask are discarded. Later, the delta is calculated using:

	delta =3D (new_raw_count - prev_raw_count) & cmask;

This masks off any increment in the upper 32 bits of 64-bit hardware
counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626054051.3360=
865-1-shengwen1997.tw@gmail.com?part=3D1
