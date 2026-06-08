Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3E3DF011
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943051; cv=none; b=ToDDu19hrRmX1saoDLfgvGMhPEkR053AoHaIrGjHPotztqjjh4ByVK2bJ/SK/XD4gyrTKV6KvVOS6y6KfqUZ3Y+hg8w7dlCORF2jA7qJUKDrwEMaNiQwT+hSGU7JQtwpDg6IFLVHLw/MB5QAZIvc/IqhzaDLhY6iYvR8gVFYFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943051; c=relaxed/simple;
	bh=RhmdXR+Nc6mzbWvZTXftnj2cObmN71gI4MCPNKC1G9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkhwmF6OhjkR9jIZeBS+vuKJ0/kbBuYv5mfG8U3/XTCaJ1Qlm7abauX0VW7EB3LaWwWAYJLrdvKqhp9lkyFxpA+9GGd3ZUDgeK/5YRMwrKiTEw04xEZkLdxPknuir++7oSeKLbWHN7X/rYLhaIQnxBZmaDlDt52b3eb7bnIsZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbscHbIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbscHbIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689A11F00893;
	Mon,  8 Jun 2026 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943049;
	bh=BipP0OWKIzViVqX7Xnvt3pJEiXa9aszNAw6kGn5o/9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbscHbIpAqyH5mB9wh9m4JhaL4iHBCiUMQBMzBegnpZGUB4eCSwvx2KTPCSCSJh9t
	 4BXz2UlUOA/pbXbfsXQVMLJVqtN0WL3+7YyBQo86b4sVqAOg/4QJhGAyx3kj28zPT1
	 Va9vlYrUUFVChMjQZYNsP2/qM/qtgHnBcJS5wcX9wJ1XgBQKTAHsD2a4Tay1ewdmD/
	 RGDBJpi+IvrhGZFImVoEAEIwFKrG1Jc4fs6JgR3sh14U3PW1Jmk67OvefiGkfFW3XR
	 ++TyCPOrcIeKUSSu8dyo54vuc/hJCDhduxfO+myZlW5mYGYegb43g1R+cURreI4Fcb
	 ci6ONHUI9vhNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/60] kvm: Keep track of plane VCPUs in struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-35-joro@8bytes.org>
References: <20260608144252.351443-35-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:24:09 +0000
Message-Id: <20260608182409.689A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Lack of reference counting in `kvm_vcpu_common_destroy` leads =
to a Use-After-Free write on the shared `common` structure.
- [High] The `vcpu_for_each_plane` macro contains an unclosed `if` statemen=
t, creating a severe dangling `else` vulnerability.
- [High] Missing memory barrier before publishing the VCPU pointer leads to=
 lockless data races and read of uninitialized data.
- [Low] Missing parentheses around the `common` parameter in the `vcpu_for_=
each_plane` macro.
--

commit f70085341f8e117bed07bbc3da5525ab9b2b6aa4
Author: Joerg Roedel <joerg.roedel@amd.com>

Introduce an array which keeps track of per-plane VCPU instances for a
single VCPU index.

This commit adds an array to struct kvm_vcpu_common to track per-plane
VCPU instances and introduces a macro to iterate over them on plane
switches.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> @@ -382,6 +384,10 @@ struct kvm_vcpu_common {
>  	struct kvm_vcpu_arch_common arch;
>  };
> =20
> +#define vcpu_for_each_plane(common, i, v)			\
> +	for ((i) =3D 0; (i) < KVM_MAX_PLANES; ++(i))		\
> +		if (((v) =3D common->vcpus[(i)]) !=3D NULL)

[Severity: High]
If a caller uses this macro inside an unbraced if block followed by an
else branch, will the C parser attach the else block to the macro's
internal if condition instead of the intended outer if? Could this
cause the else branch to execute for every NULL plane during iteration?

[Severity: Low]
Should the common argument be parenthesized as (common)->vcpus[(i)] to
ensure correct operator precedence if a caller passes a complex
expression to the macro?

[Severity: High]
Since the vcpu pointer is published without an smp_store_release() and
read here using plain loads instead of READ_ONCE(), could a concurrent
reader observe the VCPU pointer before its initialization is complete?

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -524,6 +524,8 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu=
, struct kvm *kvm, unsigned
> =20
>  static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
>  {
> +	WARN_ON(vcpu->common->vcpus[vcpu->plane_level] !=3D NULL);
> +	vcpu->common->vcpus[vcpu->plane_level] =3D vcpu;
>  	smp_wmb();

[Severity: High]
Because the vcpu pointer is published to the shared array before the
smp_wmb() executes, could the CPU reorder the initialization stores to
happen after the pointer is visible? Would an smp_wmb() before the
assignment (or an smp_store_release) be needed to ensure concurrent
readers don't see uninitialized data?

>  	if (vcpu->plane_level =3D=3D 0) {

[ ... ]

> @@ -555,6 +557,7 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *=
vcpu)
> =20
>  	vcpu->common =3D NULL;
>  	vcpu->run =3D NULL;
> +	common->vcpus[vcpu->plane_level] =3D NULL;
> =20
>  	if (vcpu->plane_level !=3D 0)
>  	       return;

[Severity: Critical]
If plane 0 is destroyed before secondary planes (for instance, during VM
teardown or an error path), will the shared common structure be freed
via kfree(common) when plane_level is 0?=20

If a secondary plane is destroyed later, won't it write to the freed
memory when executing common->vcpus[vcpu->plane_level] =3D NULL? Does the
shared structure need a reference count to manage its lifetime safely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D34
