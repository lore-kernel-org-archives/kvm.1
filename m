Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF512CDBE
	for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684940; cv=none; b=aj+M8jejbSI1AQIG0CHSR/4LPvrLumacpe6Cl72Btn5Eo7ZcDpVMs9WgFaPisqeThGc9mLb7QkTqQoZQ1GGiYy7hn0WjNImvCnGeuorcw7uGDl2xKn7wwUSSaGCsH2Z5PAGwtjPsD79eywPz+iYAc5qYAqwikua7nNOKzgBdf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684940; c=relaxed/simple;
	bh=M11swhKJ9uZOHN0QyAUno+WGVelD3hzvBM9CS7/r0Lc=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udvnnGOQ44amxVkO+SsDu3iTHyoTrmlhsTs2NGnC1xDh99Bj1CPXy6HcCzJaW59DpFepUJPgv0ZBj5BB+Q2Ghpg558S0PpyZQvueXBw4SihodezQ/2nWqzNkndsi2+5RIWU4p5pNjEPKGQsbCgk2q1DaZseNCOvH/0y9nlo2RRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgQmDuPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgQmDuPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4440E1F000E9
	for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684939;
	bh=Zx0uyWhiEu/rOtluCZbNk/Hh2qle8q8xPj1V/IRaACc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EgQmDuPOpIhPwVH55/48uSWcm04hxu4B7nR/8+ekTssiHbl1etRXCeuchJOmQuhZB
	 UacVqoqb9bAku8Nhcm6EGZmQoQtv7Dg/XcVii5XmrRGSo8ptzL9H2G+xbp0UJZRHBX
	 PG9exanW3vcfRdTtTT1oi8H1jWlG20QTj1m9xfDzHbwhCR4UmMWuXcCPajy3U7TPk7
	 0lZnz5dz5OWBssy4an5XSPxBHI/fav/KJZOaWsgBWBCyatQEOLC/aVB8xT3o3HiaOs
	 UuINyCoRsU0qF3exO7DVZJWuEh1vqoPWTgITQRPql1vCVnHsivikqzNJnCtlwRHMQY
	 S3589JPbJJssA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] LoongArch: KVM: Add include defining struct
 cpu_feature
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <dd99dd31bbdb74884b27ea940e76872913b6dc1e.1782682124.git.ukleinek@kernel.org>
References: <cover.1782682124.git.ukleinek@kernel.org>
 <dd99dd31bbdb74884b27ea940e76872913b6dc1e.1782682124.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 22:15:38 +0000
Message-Id: <20260628221539.4440E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete error unwinding in LoongArch KVM initialization leads t=
o memory leaks and dangling pointers, risking Use-After-Free crashes.
--

commit 602d2e1391a7bf96f3c1245862be546acdc24faa
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>
LoongArch: KVM: Add include defining struct cpu_feature

This commit explicitly includes linux/mod_devicetable.h in
arch/loongarch/kvm/main.c. This ensures that struct cpu_feature remains
available as header dependencies change.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index f105a86143f5b..aa0fb4c90d906 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -5,6 +5,7 @@
> =20
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h> /* for struct cpu_feature */
>  #include <linux/kvm_host.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
regarding incomplete error unwinding during module initialization in this f=
ile.

If kvm_loongarch_env_init() or kvm_init() fails, it appears we return the
error directly without unwinding previous initialization steps:

arch/loongarch/kvm/main.c:kvm_loongarch_env_init() {
    ...
	kvm_register_perf_callbacks();

	/* Register LoongArch IPI interrupt controller interface. */
	ret =3D kvm_loongarch_register_ipi_device();
	if (ret)
		return ret;
    ...
}

and similarly in kvm_loongarch_init():

arch/loongarch/kvm/main.c:kvm_loongarch_init() {
    ...
	r =3D kvm_loongarch_env_init();
	if (r)
		return r;

	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
}

If module loading fails here, does this leave dangling pointers since we
don't call kvm_unregister_perf_callbacks() or free vmcs and
kvm_loongarch_ops?

Could this lead to a use-after-free crash if the perf subsystem retains a
pointer to kvm_guest_cbs after the kvm module memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782682124.gi=
t.ukleinek@kernel.org?part=3D13
