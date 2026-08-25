Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15853E5EFA
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647932; cv=none; b=U1JGWIy63lL0TlLDdRPYwoOUk0cs/FfHZRpKDWU1BlIQyxCKb2XdoglzpCm3GfOQjD4OZLE0TEEaBzjpEdh6PmvLk3c/heik5T12sMaLw9ajLFso63K4I+d2067Jw0+yo4pPTQvmBWpAMkZdtRBuMiEG312wtKHtjzmEbJGibf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647932; c=relaxed/simple;
	bh=sYNp0/ATG2/dfOrVb7nyj7kpOwJuCqTawT2Wg093Dfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpi+Hv6oRfA3T34ARuh41liU8+MPM8zo5aPpwX/OK5W7u+qLY5OvImKF/4iZdK3Wqys6zzBjgZh7EmVjYdicwPESgscDcofKONX1pVaCH9oy39ZL0E8HnJf3oU7tEX4w8YvCZsOY4xXQkKzUHqYGkBZQhcEGVbO4xtSjPIRfE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpUwO1Jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpUwO1Jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F25A1F00A3D;
	Tue, 25 Aug 2026 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647931;
	bh=X+loAQLMAXx2JeRU/LEgikG4ByHWyptA4LWEwe6Pa/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpUwO1Jnd4tCaHYd/CuwphnV5j82NoThf6e9Dt0GijR2qpeZkNifDAEsd89Tbk7oq
	 GrEePIBKr7cy9QxGT7FoJ5FwhDHhEHzh7P/B4otHmb9rwPTBl9BoReWs+qlrm6Vyxf
	 BaIOxBDyB7gAWmKd5l1VnUQoER9flawPWVcOPgiSDn3stLR+dEh9tWADXSdP1yQHgZ
	 Kc1lAl2v3tb53CqcnDW85pQtb8udcJLaXn8rcqAZuidSZPUwjNdxbkoouaDwDZwr9G
	 DseINNQYTQcZd++atfiowjsMarNGaFlCiuuEIp0jv4Qs6YVIHH2ga0l3f2OiF3NlW/
	 AXlUhPj3CT8PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] RISC-V: KVM: Preserve firmware counter value
 across stop/start
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260825083719.643970-2-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
 <20260825083719.643970-2-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:52:10 +0000
Message-Id: <20260825085211.2F25A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The guest can trigger a host kernel panic and memory leaks by =
intentionally failing the shared memory setup.
- [High] The `sbiret` error variable is not reset per iteration in the `for=
_each_set_bit` loop of `kvm_riscv_vcpu_pmu_ctr_stop`, causing subsequent su=
ccessfully stopped counters to silently drop their snapshot updates.
--

--- Patch [1]: [PATCH v1 1/3] RISC-V: KVM: Preserve firmware counter value =
across stop/start ---
commit 1ea35d28d13ff19e21fbca9d91839aa79150c9a5
Author: SeungJu Cheon <suunj1331@gmail.com>

RISC-V: KVM: Preserve firmware counter value across stop/start

Firmware events accumulate in kvpmu->fw_event[].value while running,
but counter stop only clears fw_event[].started without saving the
value back to pmc->counter_val. A subsequent counter start without
SBI_PMU_START_FLAG_SET_INIT_VALUE reloads the stale counter_val into
fw_event[].value, losing all events counted so far.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2025b664961c8..56dd5b1b2846c 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -671,10 +671,12 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vc=
pu, unsigned long ctr_base,
>  				goto out;
>  			}
> =20
> -			if (!kvpmu->fw_event[fevent_code].started)
> +			if (!kvpmu->fw_event[fevent_code].started) {
>  				sbiret =3D SBI_ERR_ALREADY_STOPPED;
> -
> -			kvpmu->fw_event[fevent_code].started =3D false;
> +			} else {
> +				kvpmu->fw_event[fevent_code].started =3D false;
> +				pmc->counter_val =3D kvpmu->fw_event[fevent_code].value;
> +			}
>  		} else if (pmc->perf_event) {
>  			if (pmc->started) {
>  				/* Stop counting the counter */
> @@ -692,9 +694,7 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu=
, unsigned long ctr_base,
>  		}
> =20
>  		if (snap_flag_set && !sbiret) {

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for sbiret to
remain set for subsequent iterations of the loop?

Looking at kvm_riscv_vcpu_pmu_ctr_stop() in arch/riscv/kvm/vcpu_pmu.c, if t=
he
guest provides a counter mask with multiple counters and an early counter is
already stopped, sbiret is set to SBI_ERR_ALREADY_STOPPED.

Because sbiret isn't reset at the beginning of each loop iteration in the
for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) loop, subsequent running coun=
ters
in the mask will be stopped, but the condition if (snap_flag_set && !sbiret)
will evaluate to false.

Does this cause successfully stopped counters to silently skip their snapsh=
ot
updates?

> -			if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> -				pmc->counter_val =3D kvpmu->fw_event[fevent_code].value;
> -			else if (pmc->perf_event)
> +			if (pmc->perf_event)
>  				pmc->counter_val +=3D perf_event_read_value(pmc->perf_event,
>  									  &enabled, &running);
>  			/*

[Severity: Critical]
This is a pre-existing issue, but can the guest trigger a host kernel panic
here if it intentionally fails the shared memory setup?

If the guest calls SBI_EXT_PMU_SNAPSHOT_SET_SHMEM with a valid GPA,
kvpmu->snapshot_addr is set and kvpmu->sdata is allocated.

If the guest calls it again with an unmapped GPA:

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_snapshot_set_shmem() {
    ...
    kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
    ...
    if (kvm_vcpu_write_guest(vcpu, shmem_base, kvpmu->sdata,
                             snapshot_area_size)) {
        kfree(kvpmu->sdata);
        kvpmu->sdata =3D NULL;
        sbiret =3D SBI_ERR_INVALID_ADDRESS;
        goto out;
    }
    ...
}

This unconditionally allocates a new kvpmu->sdata without freeing the old o=
ne,
causing a memory leak. Since kvm_vcpu_write_guest() fails, kvpmu->sdata is
freed and set to NULL, and the goto out bypasses updating kvpmu->snapshot_a=
ddr.

If the guest then calls SBI_EXT_PMU_COUNTER_STOP with
SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT, kvpmu->snapshot_addr is still the old valid
GPA. The stop operation bypasses the INVALID_GPA check in
kvm_riscv_vcpu_pmu_ctr_stop() and eventually executes:

        if (snap_flag_set && !sbiret) {
            ...
            kvpmu->sdata->ctr_values[i] =3D pmc->counter_val;

Will this dereference the NULL kvpmu->sdata pointer and cause a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825083719.6439=
70-1-suunj1331@gmail.com?part=3D1
