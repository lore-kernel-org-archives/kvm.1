Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897239;
	b=t3kFufPslzT4jTr96sU/aD38DxcUB9jNwe8E+qiQeRFwvqZDvkxOas7Q8w8SMiu9SvCe
	 OqqDCUgDJaKVvt/EPNmofduoSjAfNHVNbJ7sRtKDWobpFJ/QxFVh7VLtaObJkx8eqMq06
	 STeS1PDuXkS6ucwiFl+l6n+X4rnjXJRV2FuqUjTtk4C7DuRvF1nHiMR9/nokvsCvhCMIW
	 2458u+s2/nK1fimmhjocJwrIGM6ivP5Md6msJGiUGhFHc93csv4XgtlS5LjgLY8Hlw8nX
	 iipgFZzibz4z/d7UV7gJ7bx3JKKEZ3ItjmqFBg9bN7IDKXgRJtbBG/ZoFUbA1AXJKSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rFf1qnc98UvpcRrwc9tilPDdMRiRsHzmi79PVY9Ht7s=;
	b=F42PXrqtwS6hFZe4G4if1LX6sD9mBEK1td/MrbxVzmJj668F04Bl6R23F46L75i7Zy5d
	 YVqwmK226vxBiCJZgODHrPsRNvvem4tgwP53tGTIX+k0Ft9yNsUOWIyAkbHOJgceHb4NW
	 eFI2AeTMiQQy9dkJU/fKB2zsbej1kT+GvXbnYPOO27aXugzDUP2J3ik41+lDJySU9OH2h
	 THOjlIcyvmPaNI2U17c1pGifyx6m9KOXC9VcE1RfgU5Of5WdLcD0t1mejh7HL9lV65mtL
	 Sb6ugSM4Y2Yii1nLdJTXugagkax+edJm1vwTyM1eiLODcTGEPiCl1fcTul99l1EO9OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKMWxoA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A66606A33F
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKMWxoA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571971F00A15;
	Thu,  5 Nov 2026 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897238;
	bh=rFf1qnc98UvpcRrwc9tilPDdMRiRsHzmi79PVY9Ht7s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aKMWxoA1LxRQAiNLRGsmwwoPUyw1W3rBXzADvQPyJybloh96aUZmDsM+STO56puBW
	 h2c9/Ti8ZEJdlPtXKivntB1JHpqtX+fDLoPz7ikMdLlRSMjpnjFmlIJNN8y3OVR//j
	 L9AoyDh5GrBuegbI9yPsq5/rqO66JfGIQUeFYnWoIudCYqcZiF51aY7SEfe00RZrcL
	 fG8Tr100zsS5+dJvrjYkKRVyLlqz9WJ6sgIi2WkVFerSgU5t1B9bpUkPFUdGpHgv7b
	 QC/JDOacy4c9JdQYCNOrt4GEIvC03+eBqYyQG9LNV2vJg0ZBVF5JG1bVGjAGGccXbz
	 kERiqfRdEaXiw==
Message-ID: <sashiko-outbox-199530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/23] KVM: x86: Kill last_tsc_{nsec,write,offset}
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-3-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:47:17 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: x86: cur_tsc_nsec diverges from cur_tsc_offset after backwa=
rds TSC
--

commit 12f55d317226d504abbc980263077a541c5123db
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Kill last_tsc_{nsec,write,offset} fields

This commit removes the redundant last_tsc_{nsec,write,offset} fields from
struct kvm_arch and renames last_tsc_{khz,scaling_ratio} to
cur_tsc_{khz,scaling_ratio}. It also updates kvm->arch.cur_tsc_offset during
backwards-TSC compensation on resume and clears pending per-vCPU
tsc_offset_adjustment during TSC synchronization.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7a2b0b99373fe..90f9b07ef7491 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1395,7 +1400,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64=
 *user_value)
>  	}
> =20
>  	offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
> -	elapsed =3D ns - kvm->arch.last_tsc_nsec;
> +	elapsed =3D ns - kvm->arch.cur_tsc_nsec;
> =20
>  	if (vcpu->arch.virtual_tsc_khz) {
>  		if (data =3D=3D 0) {
> @@ -1405,7 +1410,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64=
 *user_value)
>  			 */
>  			synchronizing =3D true;
>  		} else if (kvm->arch.user_set_tsc) {
> -			u64 tsc_exp =3D kvm->arch.last_tsc_write +
> +			u64 tsc_exp =3D kvm->arch.cur_tsc_write +
>  						nsec_to_cycles(vcpu, elapsed);
>  			u64 tsc_hz =3D vcpu->arch.virtual_tsc_khz * 1000LL;
>  			/*
> @@ -1436,15 +1441,12 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u=
64 *user_value)
>  	 * it's better to try to match offsets from the beginning.
>           */
>  	if (synchronizing &&
> -	    vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.last_tsc_khz) {
> +	    vcpu->arch.virtual_tsc_khz =3D=3D kvm->arch.cur_tsc_khz) {
>  		/*
>  		 * If synchronizing, advance the reference point to "now"
>  		 * so the matching window slides forward with each vCPU.
> -		 * Extrapolate from the generation's own origin: 'elapsed'
> -		 * is measured from the most recent write, which lies on
> -		 * the generation's line only for the first matched write.
>  		 */
> -		u64 delta =3D nsec_to_cycles(vcpu, ns - kvm->arch.cur_tsc_nsec);
> +		u64 delta =3D nsec_to_cycles(vcpu, elapsed);
> =20
>  		data =3D kvm->arch.cur_tsc_write + delta;

[ ... ]

> @@ -9874,6 +9876,24 @@ int kvm_arch_enable_virtualization_cpu(void)
>  	if (backwards_tsc) {
>  		u64 delta_cyc =3D max_tsc - local_tsc;
>  		list_for_each_entry(kvm, &vm_list, vm_list) {
> +			/*
> +			 * Hold tsc_write_lock across the per-vCPU adjustments
> +			 * AND the generation reference offset adjustment, so
> +			 * that a concurrent TSC synchronization cannot observe
> +			 * one without the other (it would compute an offset
> +			 * with the delta applied twice, or not at all).
> +			 *
> +			 * The generation's reference offset is adjusted by the
> +			 * same (guest-scaled, as adjust_tsc_offset_host()
> +			 * does for each vCPU) delta, so that future
> +			 * KVM_SET_TSC / vCPU creation still matches against
> +			 * the adjusted TSC timeline. The recorded
> +			 * {cur_tsc_nsec, cur_tsc_write} pair needs no
> +			 * adjustment: the guest TSC is kept continuous
> +			 * across the host TSC jump, and that pair lives in
> +			 * the wall-clock/guest-cycle domain.
> +			 */
> +			raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
>  			kvm->arch.backwards_tsc_observed =3D true;
>  			kvm_for_each_vcpu(i, vcpu, kvm) {
>  				vcpu->arch.tsc_offset_adjustment +=3D delta_cyc;
> @@ -9881,14 +9901,10 @@ int kvm_arch_enable_virtualization_cpu(void)
>  				kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
>  			}
> =20
> -			/*
> -			 * We have to disable TSC offset matching.. if you were
> -			 * booting a VM while issuing an S4 host suspend....
> -			 * you may have some problem.  Solving this issue is
> -			 * left as an exercise to the reader.
> -			 */
> -			kvm->arch.last_tsc_nsec =3D 0;
> -			kvm->arch.last_tsc_write =3D 0;
> +			kvm->arch.cur_tsc_offset +=3D
> +				kvm_scale_tsc(delta_cyc,
> +					      kvm->arch.cur_tsc_scaling_ratio);
> +			raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);

[Severity: Medium]
Does leaving kvm->arch.cur_tsc_nsec and kvm->arch.cur_tsc_write unadjusted
here cause them to diverge from kvm->arch.cur_tsc_offset by the host sleep
duration after a suspend or hibernate?

In kvm_arch_enable_virtualization_cpu(), delta_cyc =3D max_tsc - local_tsc =
only
compensates for the host TSC resetting from max_tsc (recorded at the last
vcpu_put before suspend) to local_tsc. As the earlier comment in
kvm_arch_enable_virtualization_cpu() explains, it does not advance the guest
TSCs by the real time elapsed while the host was suspended. Adjusting
kvm->arch.cur_tsc_offset by the scaled delta_cyc therefore keeps the guest
TSC timeline continuous with its pre-suspend value, excluding the sleep
duration.

However, kvm_synchronize_tsc() obtains ns via kvm_get_time_and_clockread() =
or
get_kvmclock_base_ns():

arch/x86/kvm/x86.c:get_kvmclock_base_ns() {
	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
}

During resume, timekeeping injects the suspend/hibernate sleep time into
TK_OFFS_BOOT. As a result, elapsed =3D ns - kvm->arch.cur_tsc_nsec in
kvm_synchronize_tsc() includes the entire host sleep duration, whereas
kvm->arch.cur_tsc_offset and the running guest TSCs do not.

After a suspend or hibernate longer than 1 second where backwards_tsc is
triggered, won't tsc_exp =3D kvm->arch.cur_tsc_write + nsec_to_cycles(vcpu,
elapsed) be ahead of the guest TSC timeline by the sleep duration, causing
kvm_synchronize_tsc() to mismatch userspace writes that match the post-resu=
me
guest TSC (or falsely match writes that include the sleep duration and snap
their offset back to the unadvanced kvm->arch.cur_tsc_offset), and causing
synchronizing vCPUs (such as data =3D=3D 0 on vCPU creation) to record
vcpu->arch.last_guest_tsc ahead of the actual guest TSC by the sleep
duration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D2
