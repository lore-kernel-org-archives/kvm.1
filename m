Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642644;
	b=bM88cvtcPRgLj02mWRuWY1VaWdv3W7AM1vHlVVxK3ewU6j9wm8aBCJWo/ZKMRVCKiUVD
	 po1DYLExwS8QC523VcM/e02pdVZufAE0nIokpUi851FbFfV7k3Z2MsOEhzWtOwuqK01BY
	 w8QkigfDxpJbdoPkSnN9h8PGVP8yuxF8RfHwKQJeemmadFHCsKSPmX7cyXQjg1UvNQ/OO
	 RDJiDKZEDj9K2BERqR48UN2pB9TTyIQy0gGNsYLCi8DPoyNjd+OwryWfGK2GSr/CqaKcY
	 O5APDKsgNUsLsqCJ0F5YrXPjHRM2mYKIhczdefKqBV9/u0Xz4UNvPkAuQa4RmsDByKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ggCp4O2HjoiHT3eumzlptAA5I+LbWK1iv/S3HzcrHO8=;
	b=19DArdrkrMLEDx5qTlec0rtqSJeNTvcNYFVcL/8Ph87+67DDvx7nFbuJxa7CDFYo65iE
	 HRAgPLEYU1v6+6boz4NlEmTOX9+TLFmgtFSzqKZe2bRVPDl5AGKeYIuj0OJ238UjDN1xN
	 u330Uhha+Mil8a3NcOMO3VLCNHuzTAIuaRZnMNYA7wibbgG2xQ8roZ6yTOHvgnRyJ2vHG
	 Gb29bXy8S382OgPvbuzGTXiB9QDyzbkn20xSDDTPQGlHohFg/nDnSBy8cCAxpG6rPggku
	 a6aHJx6bMOLgGOEi9ChmYglR2m0T2wpgQjUVaSUm6pDkAyXJD4F3YSCJWw1t7AjwuCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibYvdm3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA7606D81B
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibYvdm3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642C01F00A16;
	Mon,  2 Nov 2026 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642643;
	bh=ggCp4O2HjoiHT3eumzlptAA5I+LbWK1iv/S3HzcrHO8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ibYvdm3Vzf7HeGuqeLWa1lf5VZV3gTWd59XIODpLtIcyzZ3T+/14lYd3MylIo9MLK
	 Me3ayQpLPAJ4n5EON4jmIbnzfALObxHuWY79wdVPeVgKyIXNP/DdVHF0RLyfMXa/57
	 9FYnTvjepeebCBFeLb2aWMt7dVTfkhRxOdOVQv+PprmNitXH51CYAuQoe/FpXBuaXk
	 kU+R1JwhhsNYbEKY5EfRtauJUFHw+giBaDjCgnVnhxE193io7qik8wA/raXhm6mwBa
	 ng/4SBV0h0B9UDYVB09DeKrN+aakcqxSTe780jMQ5ny9wQvJjbbUQoFPD8hrsDN+TI
	 8kWdWeWbbvlfQ==
Message-ID: <sashiko-outbox-193899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/45] KVM: Introduce
 kvm_check_gen()/kvm_memslots_check_gen()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-7-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:04:02 +0000
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
- [Low] KVM: loongarch: missing closing parenthesis in steal time if condit=
ions
--

commit 12eefe95ee8b4f21b2235f3a2ed98ccc73873acc
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()

This commit introduces the kvm_check_gen() and kvm_memslots_check_gen()
helper functions to check the memslot generation and optionally return the
kvm_memslots pointer, converting several callers across KVM to use them.

Link: https://patch.msgid.link/20260918135030.171564-21-pbonzini@redhat.com

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 059a6d605de77..c3e71ef983bcb 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -154,7 +154,6 @@ static void kvm_update_stolen_time(struct kvm_vcpu *v=
cpu)
>  	u32 version;
>  	u64 steal;
>  	gpa_t gpa;
> -	struct kvm_memslots *slots;
>  	struct kvm_steal_time __user *st;
>  	struct gfn_to_hva_cache *ghc;
> =20
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
>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;
> @@ -1803,7 +1801,6 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
pu *vcpu)
>  {
>  	gpa_t gpa;
>  	struct gfn_to_hva_cache *ghc;
> -	struct kvm_memslots *slots;
>  	struct kvm_steal_time __user *st;
> =20
>  	gpa =3D vcpu->arch.st.guest_addr;
> @@ -1820,9 +1817,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vc=
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
>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
>  			ghc->gpa =3D INVALID_GPA;
>  			return;

[Severity: Low]
In both kvm_update_stolen_time() and kvm_vcpu_set_pv_preempted() in
arch/loongarch/kvm/vcpu.c, replacing the generation check dropped one of
the closing parentheses at the end of !ghc->memslot)) {, leaving the outer
if condition unclosed and breaking the LoongArch KVM build.

Note that a later commit in the series (c500cbe0be12) updates the arguments
to kvm_check_gen() at both sites without restoring the missing closing
parenthesis.

Should both conditions end with !ghc->memslot)) { instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D23
