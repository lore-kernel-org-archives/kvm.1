Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060573;
	b=pHSNOPX5ZqKOw9CkF9rnpJqk0CbTNmxLH+nQQzOWx7KO9RvAYcoTwbUkBQkGgQBlr4Kd
	 VRIRNpxW1VMhgRmLwl0YZq+uVch7vO2zh/zzaSZNR58e49hUgtlgM8U66dnMmYYdGfkCj
	 m5pdIwZhf+jvqNQnwTXzDaqrBeqlV/TrzbuwwFfVfSD0RxVvQzN14TVHWedQHnME2RaOc
	 iq3uCtmAnZFrH61tYBoEOM+b94/2YzaXxjb4DgSjgpsZlfaSdbJg/Zfa2CSnRa7CQxuHQ
	 I1azcWlHPcixW/IAUsad/A9rrjT1RM43xlorO/GvuGGG4pbDeu/Y6CcBl6m/1X4QTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dOMPY9WUSUWLYEvW493dk7aTnS5OLqAXoLwrmutfcZY=;
	b=AxKkPwcgskOcvRrudhHaeJVVee4TpbGixrZO0Qb55uKfJP2w60yvyJzGR8WfNeSohEJJ
	 9Yx/CLLkiO9pZ9fI6F147LpwhTjsqspaicZEGVuSP/aHKJX7cojWKzmwFnXkEtsyoofoY
	 BrAbXEY0Cus1E4xqfrv76x6n8imiqPFihbaWwnKJCSCd4WjJjYbqbq5WoydEyg1/WhoTa
	 9UktCYPuvERoHBP7V3t/r2lQGLZpVNwjQ/re+mWDv9OIg4O+x3PiPvTXelc9pxcI7e0qV
	 PYMtXBBtBvyuL+AgV6bXFOhMQQ0Pm8joq2siS3QrtPoHWhVAV61jjXyYn52BMGtbLRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnUOSC5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B9606A336
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnUOSC5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A163D1F000CA;
	Thu, 19 Nov 2026 03:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795060572;
	bh=dOMPY9WUSUWLYEvW493dk7aTnS5OLqAXoLwrmutfcZY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bnUOSC5MHMRAfiAL2AtmpWyouCc1wftpyerIxIBUvhZpZMiNw1JtOgMev9l5bSiIw
	 y+ibS2/+k3VZc/RP6EKd5q7r83mC9bI3kWUx/acbIqLelkxglTlh64N3Z9OOaSs6ou
	 3hMlFrdxQXmJpdhSU8ovhw3pUmiQxSdvliAYhVUboiLYPIp9FUwVmBopud5BIj86HE
	 1Af03fkVFaE5c73eGVx/I46w9z75xQB+tKmCK1iT19Z+vmTfDSyFeXnTPl5OUrGlrK
	 Q6B17KOt2ljoIA2SncbrnuACrR0j3vjA69BOxED4LIVjqJa0TsqY/GhbMfIPiWW4im
	 O6qaiJufTruuA==
Message-ID: <sashiko-outbox-222423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Fix stalled descriptor table accesses to MMIO
Reply-To: sashiko-reviews@lists.linux.dev
To: weichenchen <weichen.chen@linux.alibaba.com>, kvm@vger.kernel.org
In-Reply-To: <20261119032912.94364-1-weichen.chen@linux.alibaba.com>
References: <20261119032912.94364-1-weichen.chen@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 03:56:12 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: x86: split single-page reads in em_lgdt_lidt() miss
  saved GPA
--

commit db71a6d851801384a40299e7d8acce741f81c256
Author: weichenchen <weichen.chen@linux.alibaba.com>

KVM: x86: Fix stalled descriptor table accesses to MMIO

This commit switches LGDT, LIDT, SGDT and SIDT from standard guest memory
accessors to emulated memory accessors so that descriptor table accesses
targeting MMIO queue MMIO fragments and complete properly across userspace
exits.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..3bd720d983f8e 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -3465,14 +3447,35 @@ static int em_sidt(struct x86_emulate_ctxt *ctxt)
> =20
>  static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
>  {
> -	struct desc_ptr desc_ptr;
> +	struct segmented_address addr =3D ctxt->src.addr.mem;
> +	struct desc_ptr desc_ptr =3D {};
> +	unsigned long limit_addr, base_addr;
> +	unsigned int base_bytes, desc_bytes;
>  	int rc;
> =20
>  	if (ctxt->mode =3D=3D X86EMUL_MODE_PROT64)
>  		ctxt->op_bytes =3D 8;
> -	rc =3D read_descriptor(ctxt, ctxt->src.addr.mem,
> -			     &desc_ptr.size, &desc_ptr.address,
> -			     ctxt->op_bytes);
> +	base_bytes =3D ctxt->op_bytes =3D=3D 2 ? 3 : ctxt->op_bytes;
> +	desc_bytes =3D sizeof(desc_ptr.size) + base_bytes;
> +
> +	/* Check both fields before an MMIO read can have side effects. */
> +	rc =3D linearize(ctxt, addr, sizeof(desc_ptr.size), false, &limit_addr);
> +	if (rc !=3D X86EMUL_CONTINUE)
> +		return rc;
> +	addr.ea +=3D sizeof(desc_ptr.size);
> +	rc =3D linearize(ctxt, addr, base_bytes, false, &base_addr);
> +	if (rc !=3D X86EMUL_CONTINUE)
> +		return rc;
> +
> +	/* Defer userspace MMIO until both pages have been translated. */
> +	if (offset_in_page(limit_addr) + desc_bytes > PAGE_SIZE) {
> +		rc =3D read_emulated(ctxt, limit_addr, &desc_ptr, desc_bytes);
> +	} else {
> +		rc =3D read_emulated(ctxt, limit_addr, &desc_ptr.size, sizeof(desc_ptr=
.size));
> +		if (rc !=3D X86EMUL_CONTINUE)
> +			return rc;
> +		rc =3D read_emulated(ctxt, base_addr, &desc_ptr.address, base_bytes);
> +	}

[Severity: Medium]
Why split the single-page case into two read_emulated() calls instead of
always issuing a single read_emulated(ctxt, limit_addr, &desc_ptr,
desc_bytes)?

On a single-page MMIO operand, the first read at limit_addr matches the
hardware-saved GPA in emulator_read_write_onepage(), but the second read on
resume passes base_addr (limit_addr + 2), which misses the page-offset
check:

arch/x86/kvm/x86.c:emulator_read_write_onepage() {
    ...
	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
	    emulator_can_use_gpa(ctxt) &&
	    (addr & ~PAGE_MASK) =3D=3D (ctxt->gpa_val & ~PAGE_MASK)) {
		gpa =3D ctxt->gpa_val;
		ret =3D vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
	} else {
		ret =3D vcpu_mmio_gva_to_gpa(vcpu, addr, &gpa, exception, write);
    ...
}

Because vcpu->arch.mmio_gva is 0 when TDP is enabled,
vcpu_mmio_gva_to_gpa() falls back to walking the guest page tables in
software after the first 2-byte MMIO read has already exited to userspace.
On SEV guests with encrypted guest page tables, that software walk reads
ciphertext as PTEs and injects a spurious #PF or translates a bogus GPA; on
SMP guests, a concurrent PTE update between the two MMIO exits can fault mi=
d-
instruction after the first MMIO read has already taken effect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119032912.9436=
4-1-weichen.chen@linux.alibaba.com?part=3D1
