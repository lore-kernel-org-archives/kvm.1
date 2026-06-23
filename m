Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1730C164
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234420; cv=none; b=LxWnmwKNdJmP970aS8F+P8WIneNPWot5aE+RrizQ0k9sJhHDb2jnMxVfIwzp4ou4HaQ8sODNmF2vvA1ryIObVE/dSfuz9msXaqKxpSLbIwcsLUuyFfA2cfRbHlvivOqj2H/u99y/mMzDx2wpgrN5+qGcu+UnNfXkqkWWPgowBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234420; c=relaxed/simple;
	bh=CjvCVpvBxwEqhTxlGcGGQeLlmSyEEavMT66mg4tZURQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q24mzhho9OpYHYZUUyHBXsijdW06sIzm8wjymp627JWw8YiFX3c4LrbyOHRQ4p+rZf4hHHP7bZxXmiJoPUFZkDXgaKxRgApotf6jPXCKZD0aeLOPXjiD1+ViDubtphOE2kDdVfDIXi6b+SY0g4wNYEuCLfpkllGYnA7Aie/1A8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNarHwkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNarHwkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC91F000E9;
	Tue, 23 Jun 2026 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782234419;
	bh=Wq8ifD4D8CykYjVdhMFLsxvLc8ZJPeGcdKnpi69gH3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNarHwkPVWf690Oitq46mg+FaNXUhg3Nl6EgOoFNXH2A5aHGny7uyi6Q+NRpDZzrl
	 e/1ZzyQ0xlg3eLBNOsUJ0eSXFQAxg5CPLrM7HMr69G8vVqd3qo557lCpLlBZnUGRbF
	 ZlYLPLEAvrZmPJjdqn4M2wiAp/RgBlb3zBce6o4Ju+tR/ju3AVZkcdAofeEYyhbtdD
	 zTuHR+7Ln07upoCNoC26pUl7xtl6+7yrlvfBL50oKP46uxJXhoM/OWsuGlRdhwx0yr
	 9q6v1Xfztih6VMLl+T0a9nKTRZJUFP+peMRavgIfPlXsoBzpCDntvMozQrfW5UpOzh
	 4dZsuR0HjaMEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: gmap: protect entire guest top-level table
 when shadowing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <178223359030.58041.119573473883113694@digiscrypt.com>
References: <178223359030.58041.119573473883113694@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:06:58 +0000
Message-Id: <20260623170659.0CFC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing AB-BA deadlock between the gmap `children_lock` a=
nd the `kvm->mmu_lock`.
--

commit adfa2afc574e2132990a75c0f57245c13f93a6d8
Author: Naveed Khan <naveed@digiscrypt.com>

KVM: s390: gmap: protect entire guest top-level table when shadowing

This commit updates the top-level guest table protection to use the table
length rather than the designation type. This ensures that the entire table
is write-protected, preventing nested guests from modifying writable
trailing pages and retaining stale translations.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1263,7 +1263,7 @@ static int gmap_protect_asce_top_level(struct kvm_s=
390_mmu_cache *mc, struct gma
>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>  	smp_rmb();
> =20
> -	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt =
+ 1, false);
> +	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl =
+ 1, false);
>  	if (rc > 0)
>  		rc =3D -EFAULT;
>  	if (!rc)
>  		rc =3D _gmap_protect_asce_top_level(mc, sg, &context);

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a pre-existing AB-BA
deadlock between the gmap children_lock and kvm->mmu_lock here?

When unshadowing an existing real-space mapping, gmap_create_shadow() takes
the locks in this order:

arch/s390/kvm/gmap.c:gmap_create_shadow() {
	scoped_guard(spinlock, &parent->children_lock) {
		...
		scoped_guard(write_lock, &parent->kvm->mmu_lock) {
		...
}

Concurrently, when creating a virtual-space shadow, gmap_create_shadow()
releases children_lock and calls gmap_protect_asce_top_level(), which
eventually calls __gmap_protect_asce_top_level() where the locks are
taken in the reverse order:

arch/s390/kvm/gmap.c:__gmap_protect_asce_top_level() {
	guard(write_lock)(&sg->kvm->mmu_lock);
	...
	scoped_guard(spinlock, &parent->children_lock) {
	...
}

Since sg->kvm is identically parent->kvm, could this cause a deadlock
if one VCPU creates a real-space shadow while another concurrently creates a
virtual-space shadow for the same parent gmap?

>  	if (rc)
>  		kvm_s390_release_faultin_array(sg->kvm, context.f, true);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178223359030.58041.=
119573473883113694@digiscrypt.com?part=3D1
