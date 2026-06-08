Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5443B19B5
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941204; cv=none; b=eZ9YgR5FnLOgFYZU8m4iArFRnDesuv0DDO6gvvc4P+HhvDTn78dSvFJrRhNfPLC2KgzbYvMUOe6DRWjuXqp6b36je3pIA3zjo4HdS34RQHpn0MlF2hVi0GkEG7hxwjKgtG8bJKDMO8CU7Xz16Kr8hIwg6lBl+T0CTYJP+tttIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941204; c=relaxed/simple;
	bh=qPwlDVrYAoqzTbKJhw46a365nFwiREkN7/4tu5U8WJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZGZtS85oe/THdW84OWWww+RNcG9WR56jdATWVRFopiAd2siakYtnNw03ODjehuTRmDMTKUZ55m23r114pwofokz1raJWNMAT2BREw7dx2ncbNEaWPZdW5fHO+EvpDqchf3FwfLxMtQFbVFaJJbtToPbi0qURNqNEb12QRVUqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLj/jx3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLj/jx3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E91F00898;
	Mon,  8 Jun 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941203;
	bh=1GjPVJ6Pk/53XEA6IENP0xKIG43A1uC+eDCIVcuOyxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLj/jx3QInzAT5+FX3kS70sVPfvrP/CqTp/5ulGzBVexFikKYo1Hz8PH8an2JOj0Y
	 3tSMnQGESXbBDIu9WoP3mSrbp3gqUPK61K0FX4YFa7hu4e4q/i8CaFN0yY8OA5PQgO
	 qrpCCR8yxmeWKqCVciLrW28GlXGM/q5UuqNnfe86ap4Pebnzf2xysMnDAMJ4H5Gn1f
	 McujCS+NoZjYkFtzoqgTfI21H0o9pFOC/wiFb4Wl+5M6niq0QFB1eXJarxAewWOQFh
	 XbwFYs2eOiCs0fKoqQikvX1oJWeif1V+uGE0c9yMhcryDfylsRcr/BCcFHJflbNVuE
	 BeLatjv6/0z1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/60] kvm: Allocate struct kvm_run only for struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-33-joro@8bytes.org>
References: <20260608144252.351443-33-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:53:22 +0000
Message-Id: <20260608175323.2E7E91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free of the shared `kvm_vcpu_common` struct and its =
`run` page during VM teardown due to lack of reference counting.
--

commit 7fd60c1bd4dd10b32f1fba34d759b1ff92afdd4f
Author: Paolo Bonzini <pbonzini@redhat.com>

Share the struct kvm_run across all planes for one VCPU id.

This commit shares the kvm_run structure across all planes for a single
VCPU by allocating it and storing it within the shared kvm_vcpu_common
structure.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4f2c8f46a0d3..2d0d5f4fd356 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -546,6 +557,7 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *=
vcpu)
>  	struct kvm *kvm =3D common->kvm;
> =20
>  	vcpu->common =3D NULL;
> +	vcpu->run =3D NULL;
> =20
>  	if (vcpu->plane_level !=3D 0)
>  	       return;

[Severity: Critical]
This is a pre-existing issue, but could this cause a use-after-free during
VM teardown?

The common struct and its shared run page are freed when destroying the
plane 0 VCPU:

kvm_vcpu_common_destroy() {
        ...
        if (vcpu->plane_level !=3D 0)
               return;
        ...
        free_page((unsigned long)common->run);
        kfree(common);
}

If the VM teardown process happens to destroy the plane 0 VCPU before the
non-zero planes, wouldn't the later calls to kvm_vcpu_common_destroy() for
the remaining planes dereference a freed vcpu->common pointer?

For instance, the function begins by accessing common->kvm, which would be
a use-after-free if plane 0 has already been destroyed:

kvm_vcpu_common_destroy() {
        struct kvm_vcpu_common *common =3D vcpu->common;
        struct kvm *kvm =3D common->kvm;
        ...

Would it be safer to use a standard refcount mechanism to manage the lifecy=
cle
of this shared structure across independent teardown paths?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D32
