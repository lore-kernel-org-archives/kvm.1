Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D62D0606
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226400; cv=none; b=iE5Zij0EyIA6NIOsaFQJE8lzy4Lqu/exmSm8+44ITO4ea9duwP8ReAAxxv4EsazIu4O5OmGl9aZPOOx1eAu3OZ4MEq3+WT6b/zqeDGpFYzMXpFzYdEB93YkYVkfaiazVAKo0jLxPBK582lBol/Ush1PiUJJ/RkumBfTOp3X3D/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226400; c=relaxed/simple;
	bh=Ak8lGbAo+y2GOxjeBJgEUUDfDtZ1Ym+nPZZxyXB5laE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n4PAhLHB0PxR67UheZ2XFxhx8t1mcgcgVmWthJffjuzGEsnaYCoR0JqNpIy2EBM4XiP8a2XUVD713GgAGKXNQXV0feFphih1GC+XTR9fZXwLVufTRBCmexmEus+eOt8yfiOzrsdqg7eq+u7ah/64xVdJ6OiSJLrYOuJvvPvzNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuOubpK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuOubpK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A058A1F000E9;
	Thu, 16 Jul 2026 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226391;
	bh=VBF9YcRArln6xmpvfpd1kkDWXn7EvQoGmDWwkHZeN20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuOubpK/TK5t7HULwJ40ropYiMs9V25SaRpdizp6q3MdGSCqJowB5gyuPOkYIAblW
	 XBZ+CxrDjOUSE913+PapmniCPaB/46wPzaWlWE48UteR8toXGKpGZhVC62OlSTf9xl
	 0v8A0w+Rx/G3+3/oG8JTKyiTL0vRm5ecGtVl7/0y0/dYoLwUQGFnocz7Q2ZjYNZF0b
	 dLx8WkGy/E1iNxRbbE4k4n/vR5hB/8C8WWc3bTfdSTgsYMLWlwApP2g4nyl+DWiihm
	 t/6ZR1tgee7pM1Req80pnD/SHeZ0HkjjJa8OTjBOkvRMK4ECXudSSxGd9He6yfy934
	 iikqXq3li2i3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/24] KVM: Introduce
 kvm_check_gen()/kvm_memslots_check_gen()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-14-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:26:31 +0000
Message-Id: <20260716182631.A058A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The refactoring to use the new `kvm_check_gen()` helper was not app=
lied to `arch/loongarch/kvm/vcpu.c`.
--

--- Patch [13]: [PATCH 13/24] KVM: Introduce kvm_check_gen()/kvm_memslots_c=
heck_gen() ---
commit 80a164bf326fe8a6112aa42a54b4beddb26e73c6
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()

This commit introduces kvm_check_gen() and kvm_memslots_check_gen() helper
functions to combine retrieving kvm_memslots and checking the generation of
the slots. It refactors several sites in x86 and core KVM code to use the
new helpers.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e2240f817c22e..58f544df47e14 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2032,7 +2032,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
[ ... ]
> -	slots =3D kvm_memslots(vcpu->kvm);
> -
> -	if (unlikely(slots->generation !=3D ghc->generation ||
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
>  		     gpa !=3D ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {

[Severity: Low]
Should arch/loongarch/kvm/vcpu.c also be updated to use this new helper?

It looks like kvm_update_stolen_time() and kvm_vcpu_set_pv_preempted() in
that file still use the old pattern:

arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
    ...
    slots =3D kvm_memslots(vcpu->kvm);
    if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {
    ...
}

Does LoongArch need similar updates to maintain consistency across the
codebase?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D13
