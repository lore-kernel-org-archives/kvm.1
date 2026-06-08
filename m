Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D331E827
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934893; cv=none; b=oAjGEWMMfBWvdlxcSXC4dQ+bHRLwu+mhoGTYbFy0tCIC82Vb0CL6JhiDvFuUtFzLmyWZ8RemkFyo6Vt28LMfasqryucM9FM1SYz8robNVKlymv19ObnefIK7dtDmBk2YzzQ0eTj14bvOOn2vXn+F4Abjw+nks+qKUk0qLim6HDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934893; c=relaxed/simple;
	bh=qawFykfB03MgF4oYCwCePh/OamoSy85ZapP3BM4uvz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGn0Kbwfu9brMmSigSWKLZl8emdFOa2d7umE2KRp955GkbeAq+zdQaNNNNM7AdaFvSOJ/nTW5sL//OuvPNRGW2JLVAES/Xi2nIpJsyVIIl+VOt2sN0Lhfh+h2q+jhrofBglK4IhqBxR/cWjS1RiyljKJInj3wYCQDoli/cVFnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce4OIU1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce4OIU1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA71F00893;
	Mon,  8 Jun 2026 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934892;
	bh=YtjOQeUtOc3J3bEa8qiwKnu31jbs+td4xswegOx841g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ce4OIU1MpaBnguQUSqlMqZqb2EuC4LxrRevB10MXZiSNfouAtfPkviB5awfrRadNm
	 SeQJuRBcOw33ksC2hO2TRtojrNY9c0l8Ace3F76nZtzLszImL2NWo10qwaOfu4bHHO
	 BPRIrui56uGL45XLjZgut3+c3KJyEd/Gdh5xsAHuogMRLT5qvpd2CmdI5dar2OYT4K
	 iEG1pVqQ/UxFMuTJet6V+7j2WuC4bmkfN0fx7v6LbzuhVfRvX3o+cbq7CjEzn0MywL
	 KAzwbZ9ccHMwGxDoP2Z8ddzuG5Jua5O2oo74yy/zx82HLtiIRqg0GXs4uc1WmN2+nz
	 7HwN3lOt9Wb0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] riscv: kvm: Use endian-specific __lelong for NACL
 shared memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Chang" <seanwascoding@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608155252.4292-1-seanwascoding@gmail.com>
References: <20260608155252.4292-1-seanwascoding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:08:11 +0000
Message-Id: <20260608160811.D6AA71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite loop in `__kvm_riscv_nacl_hfence` due to missing `try_cou=
nt` decrement.
- [High] Race condition and memory ordering bugs in NACL shared memory upda=
tes.
--

commit 041fd3e0bc4c133e6f04a198d4795da99daa15bb
Author: Sean Chang <seanwascoding@gmail.com>

riscv: kvm: Use endian-specific __lelong for NACL shared memory

This patch fixes bitwise type warnings from sparse by introducing __lelong
and replacing raw unsigned long pointers in SBI NACL shared memory. It also
adds a __force cast to __get_user_asm to safely suppress implicit cast
warnings.

> diff --git a/arch/riscv/include/asm/kvm_nacl.h b/arch/riscv/include/asm/k=
vm_nacl.h
> index 4124d5e06a0ff..f45407bcaa26a 100644
> --- a/arch/riscv/include/asm/kvm_nacl.h
> +++ b/arch/riscv/include/asm/kvm_nacl.h

[ ... ]

> @@ -176,7 +178,7 @@ __kvm_riscv_nacl_hfence(__shmem,					\
>  do {									\
>  	void *__s =3D (__shmem);						\
>  	unsigned int __i =3D SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
> -	unsigned long *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
> +	__lelong *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
>  	u8 *__b =3D (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
>  	__a[__i] =3D cpu_to_lelong(__val);				\
>  	__b[__i >> 3] |=3D 1U << (__i & 0x7);				\

[Severity: High]
This is a pre-existing issue, but does the lack of a memory barrier between
the CSR value update and the dirty bit update risk a race condition?

On RISC-V's relaxed memory model, these stores could be reordered without an
smp_wmb(), potentially allowing the hardware or firmware to observe the
dirty bit before the payload is visible in nacl_csr_write.

> @@ -186,7 +188,7 @@ do {									\
>  ({									\
>  	void *__s =3D (__shmem);						\
>  	unsigned int __i =3D SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
> -	unsigned long *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
> +	__lelong *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
>  	u8 *__b =3D (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
>  	unsigned long __r =3D lelong_to_cpu(__a[__i]);			\
>  	__a[__i] =3D cpu_to_lelong(__val);				\
>  	__b[__i >> 3] |=3D 1U << (__i & 0x7);				\

[Severity: High]
This isn't a bug introduced by this patch, but similar to nacl_csr_write,
could these writes be reordered by the CPU in the nacl_csr_swap macro?

[ ... ]

> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 08a95ad9ada2c..6f9f8963e9ddc 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -20,7 +20,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>  			     unsigned long page_count)
>  {
>  	int i, ent =3D -1, try_count =3D 5;
> -	unsigned long *entp;
> +	__lelong *entp;
> =20
>  again:
>  	for (i =3D 0; i < SBI_NACL_SHMEM_HFENCE_ENTRY_MAX; i++) {

[Severity: High]
This is also a pre-existing issue, but does this retry loop run infinitely
if the queue remains full?

Looking at __kvm_riscv_nacl_hfence(), it appears try_count is never
decremented before taking the goto:

    if (ent < 0) {
        if (try_count) {
            nacl_sync_hfence(-1UL);
            goto again;
        } else {
            pr_warn("KVM: No free entry in NACL shared memory\n");
            return;
        }
    }

Additionally, there seems to be a pre-existing ordering hazard when writing
the entry payload further down in __kvm_riscv_nacl_hfence():

    entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
    *entp =3D cpu_to_lelong(control);
    entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
    *entp =3D cpu_to_lelong(page_num);
    entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
    *entp =3D cpu_to_lelong(page_count);

Since the CONFIG element contains the valid bit, writing it before PNUM and
PCOUNT could allow another vCPU on the same physical CPU to trigger
nacl_sync_hfence() if KVM is preempted right after the CONFIG write. Would
this cause the firmware to process uninitialized payload data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608155252.4292=
-1-seanwascoding@gmail.com?part=3D1
