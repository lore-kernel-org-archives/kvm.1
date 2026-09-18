Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC33264C7
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742541; cv=none; b=cXKVQF71pXfnXaTtA8ZYrRiLBOdXFmzERAMpbRhXObDqzoVlKGh+wcbtKWYKC318RlOOXi9G0JVrrQbzkcBuI81iHXo41ykrVrKK1EkNJxmv6X4r4WMpfLzjUVO9t+i9GyalSl+N7piZNorO3GTKEqROLYUQfoEpB7lJ4eh37BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742541; c=relaxed/simple;
	bh=iV5t7VQmoRGX7s8sj6n+qjxIQTOQ/P5UCZsy9QDLYZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tynZRHk0B8pPSM/jRk9UzxutKDomB4nirWX0/OAU0ESt8qPSOSHWOD0WD6Qj5GypgV509LpWvRuGLQpJZg8tLcOmTKJlA2cljWLb0D1DrUykoLb4s5EAjpDFIjeVaJL/4F3g608ZVslk/FwPeDgIiVLmwpene7oUDFdFqt/zqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVlJ8X7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVlJ8X7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A81F000FF;
	Fri, 18 Sep 2026 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742540;
	bh=UW/cEDbkWnk+vz692xPGICH3AaZqStbJwy832YAYg4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVlJ8X7umeTguUmG7aGKs4milYPaPhVToiJY4uYum1DdYXUvk1EgsBToJ6gBR+TB8
	 GrgwKsGrtgmVtI9oJeaqGAq84eCHr96Mbc565BEwmD/42QT30ao+eoirn+xJ9lMQcE
	 Nx4wePRBGfpC9ZDDAshrmcRAbRKh7RO1yzgxCe1+X6/RWRN7FasKBMWG4gk1Xm7rJq
	 Jdih5m+ObATegGmQu/jye/SlHUcTcys4BTBGTMrYyOmROd7oHUZ19cmghia8J+k1sX
	 vJ9OIR3RcA5poREO4DfkC/Ovga8+oNIgaxYQ6OH2fHcEdWLrNMQ4o0H1EV8vAJasgd
	 NYhWtUcj3MJKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/31] KVM: Introduce a generation number for memory
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-22-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:42:19 +0000
Message-Id: <20260918144220.148A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: infinite loop in mem_attributes checking due to xas_next() mi=
suse
- [Low] kvm: loongarch: build failure due to missing closing parenthesis in=
 unlikely()
--

commit ca19ec78b0ccf685019346276e3422a33ce7e2e0
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce a generation number for memory attributes

This commit introduces a generation number to track memory attribute
modifications in KVM. It ensures components accessing guest memory via cach=
ed
information validate the generation within a KVM SRCU read-side critical
section.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -163,7 +163,8 @@ static void kvm_update_stolen_time(struct kvm_vcpu *v=
cpu)
>  		return;
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
> -	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Does this missing closing parenthesis for unlikely cause a build regression?

It looks like the macro is left unclosed, which breaks compilation on
LoongArch.

[ ... ]

> @@ -1808,7 +1809,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
pu *vcpu)
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
>  	ghc =3D &vcpu->arch.st.cache;
> -	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Does this missing closing parenthesis for unlikely cause a build regression
here too?

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> +bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, g=
fn_t end,
> +					unsigned long mask)
> +{
> +	XA_STATE(xas, &kvm->mem_attrs.array, start);
> +	void *entry;
[ ... ]
> +	guard(rcu)();
> +	for (;;) {
> +		do {
> +			entry =3D xas_next(&xas);
> +		} while (xas_retry(&xas, entry));
> +
> +		if (xas.xa_index >=3D end)
> +			break;

[Severity: High]
Can this loop regression lead to an infinite loop if the queried range exte=
nds
beyond the populated entries of the XArray?

When xas_next() returns NULL and transitions the state to XAS_BOUNDS,
subsequent calls to xas_next() do not increment xas.xa_index. Because xa_in=
dex
stops advancing, the termination condition xas.xa_index >=3D end is never m=
et.

This can cause a hard lockup inside an RCU read-side critical section when
reachable via untrusted userspace ioctls.

The same xas_next() misuse appears to be present in
kvm_range_has_memory_attributes() which can cause it to incorrectly return
false for ranges beyond populated bounds due to the xas.xa_index !=3D index
check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D21
