Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05C38A729
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188512; cv=none; b=UqEkX1i8R4Ne5CR8jn19rSLRbvQTmrYPL9z+JfrcX6RzRU70vKs1zzoRNRnK2IBtMYN0StOpiTwIhPh+tJuXmpv+IdRzYESA4nv2n1U9vIjpe3neckCle2Ic32kA+P2jHScDce/QChB28Js6TwfUEQ2sVY1+9XfyZSXGjL1LcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188512; c=relaxed/simple;
	bh=U4iNUDAb4jXdvLx4OakCF3ro4Gb5mcNTvdKqJtEweNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgFfdKZe3szjvrTcvYj5Y7o7MnFR9cnNRWMNeru8eIQ6qP48Zzmkwx4BydrExmgY+r/Yxhvo2cqKF1xbmIn2MEtxPtcZyJnxfFzRufF76+asv3ikWMonP5evyiJtJJA+zxPLvYx8RUuOW+GjG4zL3UypoHxWBNC4o/BknlnOK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTp+R9gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTp+R9gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14BE1F000E9;
	Thu, 16 Jul 2026 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188510;
	bh=CbIyvNFtZzbrxyKacYpcv05Bkq912AtgUuVsw0uUr58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTp+R9gtUz8hlVZdlOeKRduNqcjb8EODuNmchwpUPC6Iy/weM562C57zqrhILgxLh
	 seKKv/FMEWFpoTKcGW7Hlxa+ofuV9D6dusLG8Zmfgb4tFa8ujJghypQ1dS2PARZaC8
	 KeoUQUsSiS8MoQsADJMLKrGVU6UZlSOMFR06gJ0g5QMuk2olKjlv26WX/alXv0QNgM
	 f7Yje1xfFKo+rHMm6VkiRODJSzFNmbbs3TjGaGCib6nCihsbnsmjyckj64LLImJWj2
	 DPPMlPQ8VZuq9IAHlBGydxmxpgz0h4PHILhpw5jtbOVI8YifeKyYLnDuFCIqW53POn
	 4EO9lK7raB3tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zongmin Zhou" <min_halo@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716073756.44153-1-min_halo@163.com>
References: <20260716073756.44153-1-min_halo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:55:10 +0000
Message-Id: <20260716075510.B14BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Silent drop of critical guest TLB flushes when the shared memory q=
ueue is full

Pre-existing issues:
- [High] Unsafe usage of this_cpu_ptr() in preemptible context leads to los=
t TLB flushes and data races
- [High] TOCTOU race and memory ordering violation in NACL shared memory up=
date
--

--- Patch [1]: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry a=
llocation ---
commit 30204e283205d026c21e76906b9dab006ad09704
Author: Zongmin Zhou <zhouzongmin@kylinos.cn>

KVM: riscv: Fix infinite loop in NACL hfence entry allocation

try_count is initialized to 5 but never decremented in the retry path,
making the if (try_count) check always true. If all NACL shared memory
hfence entries remain in the pending state after sync, the function loops
forever, causing a soft lockup. Decrement try_count on each retry so the
fallback warning and return become reachable.

> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 08a95ad9ada2c..54a0158bd38a9 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -33,7 +33,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>  	}
> =20
>  	if (ent < 0) {
> -		if (try_count) {
> +		if (try_count--) {
>  			nacl_sync_hfence(-1UL);
>  			goto again;
>  		} else {

[Severity: High]
Does this silent return leave stale translations in the hardware TLB?

By making the fallback return reachable when the queue is full:

		} else {
			pr_warn("KVM: No free entry in NACL shared memory\n");
			return;
		}

the caller is unaware the flush failed. Missing a mandatory guest TLB flush
violates core memory management invariants and could allow the guest to
access invalid physical memory.

Should KVM propagate an error to userspace or fall back to a synchronous
local flush instead of silently discarding the request?

[Severity: High]
This is a pre-existing issue, but could the subsequent write sequence cause=
 a
TOCTOU race with the L0 hypervisor?

Looking further down in __kvm_riscv_nacl_hfence():

	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
	*entp =3D cpu_to_lelong(control);
	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
	*entp =3D cpu_to_lelong(page_num);
	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
	*entp =3D cpu_to_lelong(page_count);

The CONFIG field, containing the SBI_NACL_SHMEM_HFENCE_CONFIG_PEND flag,
is written before the PNUM and PCOUNT payload fields without any memory
barriers.

If the compiler or a weakly ordered RISC-V CPU reorders these writes, could
the L0 hypervisor read the PEND bit while the payload is incomplete, leading
to incorrect or missing TLB invalidations?

[Severity: High]
This is a pre-existing issue, but does the TLB flush processing happen while
preemption is still enabled?

Looking at kvm_arch_vcpu_ioctl_run() in arch/riscv/kvm/vcpu.c:

	ret =3D kvm_riscv_check_vcpu_requests(vcpu);
	if (ret <=3D 0)
		continue;

	preempt_disable();

If kvm_riscv_check_vcpu_requests() processes TLB flushes via
kvm_riscv_hfence_process(), it resolves the shared memory pointer using
nacl_shmem(), which relies on this_cpu_ptr().

If the VCPU thread is preempted and migrated to a different physical CPU
immediately after the pointer is resolved, will it write to the old CPU's
memory and cause lost TLB flushes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716073756.4415=
3-1-min_halo@163.com?part=3D1
