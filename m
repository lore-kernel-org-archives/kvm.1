Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFF19DF62
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103360; cv=none; b=OUYLuZ2OtiYZVWNqyazNbwKfdDPVAX1HkfnpPuFkGys6JLL2ewdSyZeAOVm/OP5g4MFP0Uu98z9GeZ/JZqS7WAndRBnJEewE+SVP25OQel4JrsU+T/nzeSOImWfkIxfE809L5qtzpn1fCtknXMeX/9ilbBHlP9gp6ov2XsaU06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103360; c=relaxed/simple;
	bh=NP+N16WTR2RkVW23azPQsK/6e90/lf5TDjj/kqrBV6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZwPQ76FagxR0Sa06rUdam9pl6RXYLpubuto/Y9h4rfC/rM0+J1k9JP9bnB22FbfBEMqWlfTSfRlBHHRb4qWbn8l+gOvYIHzOCKlKVgzc05dQLF/LfapPdVspjQ8CBywPyY8mwP8Wv44guqRVVkJjyG4FdGZ1CeqMkwJN7fG3tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht7u6qnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht7u6qnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D671F000FF;
	Fri, 11 Sep 2026 05:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789103359;
	bh=Az4sQKwf8i6mPFkJJvUq2rYEYTMhxgBT1Y7+ccn4ULk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ht7u6qnr7waUKB/M2be2zUHexnhyqqv3ORmSFr4WotmyhwRTy2+6YBD20qqKkKUUI
	 lwo3bLNSx1cf8PaU5iolyFH57gSnlj4vvetpJu0hJDxT2IILuqhz/HX1uYiKhjDrJ1
	 wSV+KOuOKfy/5x77R94XeiJ20gkET3Cjg4R1lOOhLQ6pPG01ZwMpaS7/WrOBRc9cco
	 EOBclEgzYkKzb6WpQ5307G2jkFeaIf28jLGnH4U90WB+nQq937ZgQk6OblF9jb9JZw
	 1ukzgSIRlIo3XpwawKNm6UgO4yTSa3OSd11xlF8DFTxbWDbNfsTncN4rlOXr/1rUbf
	 T8m9axsTvqf9w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/3] KVM: PPC: Book3S: Don't call __ffs() on an empty
 pending_exceptions bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3578c377329d39a4a9063c24496d2ac4c31a169d.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
 <3578c377329d39a4a9063c24496d2ac4c31a169d.1789099725.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 05:09:18 +0000
Message-Id: <20260911050919.23D671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a Time-of-Check to Time-of-Use (TOCTOU) vulne=
rability by reading `*pending` twice without `READ_ONCE()`, failing to full=
y prevent the undefined behavior it intends to fix.

Pre-existing issues:
- [High] The exact same `__ffs(0)` undefined behavior bug exists in the `bo=
oke.c` architecture variant but was omitted from this fix.
--

commit 2aea5bb81e74db6e15dcd388923821301dd8cce8
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap

This patch adds a check to ensure the pending_exceptions bitmap is not empty
before calling __ffs() in the Book3S KVM PPC code. This prevents undefined
behavior that previously caused arbitrary interrupt delivery and guest hang=
s.

> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 2efbe05caed76..e4152e9a0d967 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -401,17 +401,19 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *v=
cpu)
>  	if (vcpu->arch.pending_exceptions)
>  		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exce=
ptions);
>  #endif
> -	priority =3D __ffs(*pending);
> -	while (priority < BOOK3S_IRQPRIO_MAX) {
> -		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
> -		    clear_irqprio(vcpu, priority)) {
> -			clear_bit(priority, &vcpu->arch.pending_exceptions);
> -			break;
> -		}
> +	if (*pending) {
> +		priority =3D __ffs(*pending);

[Severity: High]
Does this read *pending twice without READ_ONCE() and introduce a=20
Time-of-Check to Time-of-Use (TOCTOU) vulnerability?

The KVM_INTERRUPT ioctl can be invoked concurrently by a host userspace
thread. It calls kvm_arch_vcpu_unlocked_ioctl(), which does not hold
vcpu->mutex, and proceeds to kvmppc_core_dequeue_external() where it
clears bits in vcpu->arch.pending_exceptions locklessly using the atomic
clear_bit().

Since the compiler can emit two separate memory loads for *pending, if the
last pending bit is cleared by a concurrent KVM_INTERRUPT ioctl between
the if (*pending) check and the __ffs(*pending) evaluation, could the
second load read 0 and still trigger the __ffs(0) undefined behavior this
patch intends to fix?


[Severity: High]
This isn't a bug introduced by this patch, but does the same __ffs(0)
undefined behavior still exist in the BookE architecture variant?

Looking at kvmppc_core_check_exceptions() in arch/powerpc/kvm/booke.c:

arch/powerpc/kvm/booke.c:kvmppc_core_check_exceptions() {
    ...
    priority =3D __ffs(*pending);
    while (priority < BOOKE_IRQPRIO_MAX) {
    ...
}

This is called unconditionally by kvmppc_core_prepare_to_enter() on every
VM entry:

arch/powerpc/kvm/booke.c:kvmppc_core_prepare_to_enter() {
    ...
    kvmppc_core_check_exceptions(vcpu);
    ...
}

Since there is no check against 0, it appears __ffs(0) is executed on every
guest entry when no exceptions are pending on BookE guests. Should a similar
fix be applied to booke.c as well?

> +		while (priority < BOOK3S_IRQPRIO_MAX) {
> +			if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
> +			    clear_irqprio(vcpu, priority)) {
> +				clear_bit(priority, &vcpu->arch.pending_exceptions);
> +				break;
> +			}
> =20
> -		priority =3D find_next_bit(pending,
> -					 BITS_PER_BYTE * sizeof(*pending),
> -					 priority + 1);
> +			priority =3D find_next_bit(pending,
> +						 BITS_PER_BYTE * sizeof(*pending),
> +						 priority + 1);
> +		}
>  	}
> =20
>  	/* Tell the guest about our interrupt status */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789099725.gi=
t.ritesh.list@gmail.com?part=3D2
