Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5138657D
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780125131; cv=none; b=aGh3KDOEn+XI8nq4EFZCOEcWTKKTUEk8KJ+xVY+ZvUxeM5cEe85ol7ZIMSzM8TxlEptoJ4cE2ucxQGSo34LzsKxJHUWcwh9N094ckwWHsZLN8ZIMLNkqPiGrRbB/HjMxSEwwDgDcz2fvIZbevPhIccbFRlTmgM9iqgaXVxr8TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780125131; c=relaxed/simple;
	bh=wjbtirUt74zy1Hwo+KO+zCUKv9OheD2CDcsdh50AXpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UwYKhNQeQY2wPgi4l+MbXmxyVPZkEJbgtDosSYE+xxpzl6jnclR6P82aEe7oftuIPusPHWK1mW+QtcZiDM4paQgDrjcv0vVwuUU1kYzOnW66E6yyd3yByMoWHKKHPtxq32l1YoW4p93K0qcxSwO9nkUynMdr/Qt/9UTKLVqNOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzEEVeaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzEEVeaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766CD1F00893;
	Sat, 30 May 2026 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780125129;
	bh=5Lk8Xa5fx14cHTN/u3CNZunukLPgsPnnh+I/V5phSLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzEEVeaMf2ccHvLk1foAOgOg+ReWA73XYByphV9b196EK6za+39EmkrpWacLUhl9+
	 oqcffhyL/66PNky9vIHl6mv75yjAgTf8tecsUkaRWHm6/0+0vB7kRx3lwCdzuc35Tg
	 2fMoH2xBy9aGMu72fX/ZJUabjH0n2ztKgE7eSPPGe44Oko3MMwEoq7wJKe8FsC/Cuc
	 43kK3+KtcBjZFJ0g4MOCHdKqK4GvkDQB5Bbl4xUD1TFsLDdp5+dZueNTGPL9B1HBHy
	 nMGxMs7vQRfF1KoM/8IPTnTX64Di8IFWnRLT/QV1JgVW5zE8k8bFQRQtfMiybPOJe6
	 /Dyx4P/vns5IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/27] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-17-seiden@linux.ibm.com>
References: <20260529155050.2902245-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 07:12:09 +0000
Message-Id: <20260530071209.766CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked debugfs directory and Use-After-Free on module initializati=
on failure.
--

commit 04c2f7cc9b71f864ca5d4b3147f1edb93f37b395
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Make device name configurable

This commit allows KVM implementations to configure the device name, which
is particularly useful for architectures providing multiple implementations.
It introduces kvm_init_with_dev() and updates kvm_init_debug() to accept a
device name.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -6505,7 +6512,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  	kvm_preempt_ops.sched_in =3D kvm_sched_in;
>  	kvm_preempt_ops.sched_out =3D kvm_sched_out;
> =20
> -	kvm_init_debug();
> +	kvm_init_debug(kvm_dev.name);

[Severity: High]
This is a pre-existing issue, but does the error handling in
kvm_init_with_dev() leak the debugfs directory on failure?

kvm_init_debug() creates the debugfs directory and populates it with
stats files. If any of the subsequent initializations fail (such as
kvm_vfio_ops_init(), kvm_gmem_init(), or misc_register()), the rollback
path jumps to error labels like err_vfio or err_register.

None of these error paths appear to call debugfs_remove_recursive() or
an equivalent cleanup function for the debugfs directory. If KVM is
compiled as a module and fails to initialize, the module memory is freed.
Would this leave stale debugfs entries behind, potentially causing a
use-after-free if a user accesses those files and triggers the fops
pointing to the freed module memory?

> =20
>  	r =3D kvm_vfio_ops_init();
>  	if (WARN_ON_ONCE(r))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D16
