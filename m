Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648449D5A1
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742557; cv=none; b=Wh+exr4pwttODnnxo+uahdtcuohi4Gflvg9dEZlAMXikmVLWNSNAKkQy3fJww2OwQNIU2rFvIxmfvJOkBiA7HDVxjzce5j/KxnC99Ey0b4rwQ6kyLymDaaBtPFNBvg4ii0ECGpueiuRJsRJVhrUu3/B2h1V0AGXHyYGLDn3tBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742557; c=relaxed/simple;
	bh=IJrVQsf15DglAdyWNMKN38l3VhvmLcgy/D8RDsaOq/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qo2NPYbJ03ZYJnvry0IFFLG6pZ3dYC9ggmrdORZbugT29+LNKj8yREc0nCkPOmG80TivwTc1BfrIoLpkXsg3JuPs7/g5O+DYFuU+0RFPX1PX5OLTXwn7PiYjz6Rbcd45pu0/sE+AFDw4beGa+cIoJ51aTc2pUP1ArOX208v/tLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dawbnSDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dawbnSDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19941F000FF;
	Fri, 18 Sep 2026 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742556;
	bh=D+WJAvwZ2++7KTTQxlD/mgYcbqmofm+uYvkaQ52hB+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dawbnSDOHu7u3c951jAp4AIK3UCZujv3WxS1g4btacfiH3RNELF7SDYS3WoOr8j/3
	 JDMxo8vlgR5PPqdUpJq4Fr4RgmoMiEJnXwnaJE+i3YX9qvgwOEqg6Sk5lg5Yx6B3uW
	 YgDGMSK7cfEYae9NWfEx2KzKm74+eZg9EqS7+AWMMld/+3d3UIawO/Sa6pu78oejh3
	 X2DJMDujRA7Yv1z3FGnRF+DRUVZpbeng0G2T6V1rYXqgTyciXHGwQOifTqIlB8OTHX
	 X9kMmULe1wEQwVN7jzzsnNTxm9/1MLTZ2hc6K757z87bM8hEqTMTXbzA4nvF7XcDhB
	 C2uDaKmJrSmYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/31] KVM: Take memory protections into account for
 accesses with cached gfn->hva
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-23-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:42:35 +0000
Message-Id: <20260918144235.C19941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: missing closing parenthesis for unlikely() in kvm_update_stole=
n_time()
--

commit 3448cba8fa9867cc077bee10fde46930ff148f4b
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Take memory protections into account for accesses with cached gfn->hva

This patch accounts for memory attributes when accessing guest memory throu=
gh
kvm_get/put_guest(). It tracks the memory attributes generation in
gfn_to_hva_cache's data and fails to refresh the cache if restrictive memory
attributes are found.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index ed9e092c97ba7..1179c413b048f 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -164,8 +163,9 @@ static void kvm_update_stolen_time(struct kvm_vcpu *v=
cpu)
>  		return;
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
> -	slots =3D kvm_memslots(vcpu->kvm);
> -	if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
> +		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Does this missing closing parenthesis for the unlikely() macro cause a build
failure in kvm_update_stolen_time()?

>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;

[ ... ]

> @@ -1810,8 +1809,9 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
pu *vcpu)
> =20
>  	gpa &=3D KVM_STEAL_PHYS_MASK;
>  	ghc =3D &vcpu->arch.st.cache;
> -	slots =3D kvm_memslots(vcpu->kvm);
> -	if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {
> +	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attr=
s_generation) ||
> +		     gpa !=3D ghc->gpa ||
> +		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {

[Severity: Low]
Is the closing parenthesis for the unlikely() macro also missing here in
kvm_vcpu_set_pv_preempted()?

>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D22
