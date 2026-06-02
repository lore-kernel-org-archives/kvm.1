Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731031987D
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423719; cv=none; b=Wsrgm1+bMvETLSv89SknZa99DfrsmxGe5WXnuxJ9ih1qKhn3/lVMaOE8e3O9+W3FheaPGx16gYB6AUO5wAJqb6S3srlZQah+UFTzWIBhu12syfhK93eQULQAm4UcHAxpo9bJZNmg8uWv9RqAenq/FPnGNJdOUQc4toSbpgbB48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423719; c=relaxed/simple;
	bh=VQy3UBT7Tf3Zw/cRpJ3DHU3/f7dRerS2WWRusrtgB1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aH1iQxNFsjQz5oZMbQGWloVf2mpHxRoM1ryeVso5kbrGbVVNTwuwqBKcUXwllf3+ct+DFZ0rZBpAwl5k+DZkCpkSy1wkemzrDm7UBY+W/5BL+URw+XWwhpQFFq/5CU7kQFSE8cIW5aZUy23QB0d7ETS0WbFtGLYjq4XKIKUFkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwoEEBCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwoEEBCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE091F00893;
	Tue,  2 Jun 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423717;
	bh=OH70ZDAihi6ZQs1FF7cJAiK8KEoz070UfUMo283+1Fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CwoEEBCG79XCJZEyQsimBDidOrYxP1X7jiIKASb8flrcDgrXNZVH861iz2v2Pnc8g
	 Hb04bizqXNTiks0B0fjaL+631rsF2x6IFfLoJ1ceMtLo2REGv3mjGYhJc6AeszoyOx
	 lFDr4IKF+TXhXrAXyid87OdMeJUpg+LnK6r9OTyWV1KtRPB4t+f8br5Jh30QPfNg7U
	 rNdbaJCB3aMI+xOkq231lt+rgTUMmYn7EwxPrAzVBr5tdnX40JOPRPREFdzqgKtW5a
	 81oBktaGTpnsRbqN7UjOxKwjoIHFMdTCNAAWMb7Mtsf+V/Yl0zNN2EPQcbWoIasTVP
	 TJ1YXDqIZAU+A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 07/10] KVM: s390: Lock pte when making page secure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602174819.255785-8-imbrenda@linux.ibm.com>
References: <20260602174819.255785-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 18:08:37 +0000
Message-Id: <20260602180837.8EE091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Acquiring and releasing `mmap_lock` (an rw_semaphore) while execut=
ing in an atomic context (holding `kvm->mmu_lock`) violates lockdep wait-ty=
pes and triggers splats.

Pre-existing issues:
- [Critical] `pfn_folio()` is called blindly on a potentially raw PFN from =
VM_PFNMAP, leading to an out-of-bounds dereference and kernel panic.
--

commit 83c652464cb64cf12a4f9414062b55776fc795bf
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Lock pte when making page secure

Make sure _kvm_s390_pv_make_secure() takes the pte lock for the given
address when attempting to make the page secure, blocking gup functions.

> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index c2dafd812a3b2..4b865e75351c1 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c

[ ... ]

> @@ -103,9 +105,21 @@ static void _kvm_s390_pv_make_secure(struct guest_fa=
ult *f)
>  {
>  	struct pv_make_secure *priv =3D f->priv;
>  	struct folio *folio;
> +	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
> +	pte_t *ptep;
> =20
>  	folio =3D pfn_folio(f->pfn);

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to call
pfn_folio() here without checking if f->page is valid first?

If the guest targets a raw device PFN (like a VM_PFNMAP from a VFIO
pass-through device), f->page will be NULL and the PFN won't have a
backing struct page.

Could calling pfn_folio() on such a PFN result in an out-of-bounds pointer,
which would then cause a host kernel panic when passed to folio_trylock()
just below?

>  	priv->rc =3D -EAGAIN;
> +
> +	if (!mmap_read_trylock(priv->kvm->mm))
> +		return;
> +
> +	ptep =3D try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn=
), &ptl);
> +	if (IS_ERR_VALUE(ptep)) {
> +		priv->rc =3D PTR_ERR(ptep);
> +		goto out;
> +	}
> +
>  	if (folio_trylock(folio)) {
>  		priv->rc =3D __kvm_s390_pv_make_secure(f, folio);
>  		if (priv->rc =3D=3D -E2BIG || priv->rc =3D=3D -EBUSY) {
> @@ -114,6 +128,11 @@ static void _kvm_s390_pv_make_secure(struct guest_fa=
ult *f)
>  		}
>  		folio_unlock(folio);
>  	}
> +
> +	if (ptep)
> +		pte_unmap_unlock(ptep, ptl);
> +out:
> +	mmap_read_unlock(priv->kvm->mm);

[Severity: High]
Can mmap_read_unlock() safely be called in this context?

_kvm_s390_pv_make_secure() acts as a callback triggered by gmap_link().
When called from kvm_s390_faultin_gfn(), kvm->mmu_lock (an rwlock_t) is
held in read mode, which disables preemption:

arch/s390/kvm/faultin.c:kvm_s390_faultin_gfn() {
    ...
    scoped_guard(read_lock, &kvm->mmu_lock) {
        ...
        rc =3D gmap_link(mc, kvm->arch.gmap, f, slot);
    }
}

Because mmap_read_unlock() operates on an rw_semaphore, it might attempt
to wake up waiting writers, which can sleep. Does calling this from a
preemption-disabled atomic context trigger lockdep wait-type violations
and BUG splats?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602174819.2557=
85-1-imbrenda@linux.ibm.com?part=3D7
