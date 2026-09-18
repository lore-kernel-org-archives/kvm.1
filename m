Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503F3ACF0F
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741605; cv=none; b=lTpsM01ejeRU8+aJzmmF8OWdRaTnYoHVp8Gzv2pDfnIflmFlZdX8A+9oXsrNvW2rDZl0F8YNUGyXM620UB+S7iSu9D7Vl3HUU9f53l4Iswd6fnBiBcqhW28P4B/u8OpKGx4vBqnB8HOvBmoCCNRav2j9rpDiJrDhyVm8M4Ax0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741605; c=relaxed/simple;
	bh=ckVvui4NLDOmTz+F4OErqwvfOlgJdS5sAiNJLFd1Nlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhCSUCowonC0j+OSZYN1dLh2UH4CZI+m+eCQ+38W0N9wH27Ak2v5vNyNB430uhB6lB4wculU55G9q9BrT/0X8UzasA4pmnV7anpt5YR0nvn5vVuGKll06ZNbcIfHBCAF3EHyWIwbR7rMzH1iIgn8VbfqrCu0mtkVxghtrgXcdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIS+r7yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIS+r7yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ADC1F000FF;
	Fri, 18 Sep 2026 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741604;
	bh=pKr13HUrt8qv/HzLBq38pC6wm/AnrUtHnMWcW6DhSmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIS+r7yCe41B0++vBIFw8V5jFTzJBmQMZJR2sRLZouuNLmj4yhLTrMhVcwncznbac
	 oQTzV312pyCRPpTzDxusbQ6HnG2+zOw1/6W0eUe4gXHslxonmOST1FA4sTwN6mZs6C
	 rK6BJ2Ehy7hMDqEHP86dEF+Xtq5Xd2PQP9jJtLvGlbKRC6/k0DWb+BAKN2KODSCyLL
	 +13qDUGaDqUkwniAtt3o8nwfGYObbpqntYa7CN5BszeKQKztzgtlFJgtmSmPo2iV/r
	 OBu73o+++eisdn8UUPvrot7YIRyNYhrSZi+x078KQZkoj7cjOhcS0sqdnFEyeAK3jt
	 Cawdx6zuwn55g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/31] KVM: Introduce
 kvm_check_gen()/kvm_memslots_check_gen()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-21-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:26:43 +0000
Message-Id: <20260918142644.32ADC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: missing closing parenthesis for unlikely() macro in loongarch
--

commit 173c930f2b4596e5daa23aa65be9736878ddf068
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()

This commit introduces helper functions to retrieve and check the generation
of kvm_memslots. It replaces direct accesses to the generation field with
kvm_check_gen() or kvm_memslots_check_gen() across multiple architectures.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index d540004d74ff6..cf4f4d75374ad 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
[ ... ]
> @@ -164,9 +163,8 @@ static void kvm_update_stolen_time(struct kvm_vcpu *v=
cpu)
>  		return;
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
> -	slots =3D kvm_memslots(vcpu->kvm);
> -	if (unlikely(slots->generation !=3D ghc->generation || gpa !=3D ghc->gp=
a ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Does this missing closing parenthesis for the unlikely() macro cause a build
failure on LoongArch architectures? It looks like we have !ghc->memslot) {
instead of !ghc->memslot)) { here in kvm_update_stolen_time().

>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;
[ ... ]
> @@ -1811,9 +1808,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
pu *vcpu)
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
>  	ghc =3D &vcpu->arch.st.cache;
> -	slots =3D kvm_memslots(vcpu->kvm);
> -	if (unlikely(slots->generation !=3D ghc->generation || gpa !=3D ghc->gp=
a ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa !=3D ghc=
->gpa ||
> +		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Is this the same syntax issue as above? It seems we are also missing the
closing parenthesis for unlikely() in kvm_vcpu_set_pv_preempted().

>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D20
