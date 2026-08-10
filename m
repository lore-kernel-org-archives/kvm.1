Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666ED3B71DF
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357748; cv=none; b=SqERaozOhgImjp2Xy/fOA6xpIakaz+g6xxWaMn/+tgdUpqC/ZlvFHw7hQtHf5izGwNQrn5i/NJylLguuAoTj7LqflDIMS8+pWoQqxSnyIhZ0d4YKvKxQuU5mSMymturgjD2HXZkNSqt/A76pAyA7EduGqntbexzuYkwTwVLGqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357748; c=relaxed/simple;
	bh=JcMDQ5bVpkMEyIsNQyVzefuVxpzneWp9tBWTIBNp3lo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MfeX0YvEbqDxQK2vNTKNGZQOX69BXCiIf17nCJEfC/Wo34USdKKbqDVIo5FdxsKdE2tzxd36QVnYWvHgugtPpnYK5OjNAUjT469e2aownb+fxwjDhhgGQmF9g9Zz7saQ7DREjGSbPK/x5RMQtd1X32HOqYHsK8Jo79o7I195Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCAzePIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCAzePIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9B71F00A3A;
	Mon, 10 Aug 2026 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357747;
	bh=FWeq61VXDbLHMoJCeBdheG0TXrbJXp7BkWQn3uwUd4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCAzePIkz+3lZPORWIvvALwNOzIC9XZqlIjzhGz464UKvnRb85do2FNr4rsQ84yxm
	 G6hwgsPjYDdsvvYypj0JfQiO80+seOrL9dypiHXqX71KDoaPAwHR4P0SvomqTazCOP
	 Kb7WVxvaoxL4667DGWBS7HMNnnpOnUr5VuI+WUlDyRVXwgtaZC2SdwZoKq+ZjMeEmD
	 ejKdtkHwqK5TP4z+6c5Il3rXs917pjciVRRAfzfFoLJycBfdRQ2dOHS26CdCkxPKRz
	 UeUD9Qw8Gvo+7gAZmS6fjO+Ve55OIag0PktXMKF/d74dGVfyv90pULaz4bZaZ78wqX
	 IzoOuUaWK47bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] KVM: x86/pmu: Add mediated PMU capability flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <6ee8548572f74a2ded7e2904e222045c257a9812.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <6ee8548572f74a2ded7e2904e222045c257a9812.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:29:06 +0000
Message-Id: <20260810102906.EA9B71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Transient failure in `perf_create_mediated_pmu` permanently clears=
 `mediated_pmu_caps`, corrupting VM capability state on retry.
- [Medium] `kvm_vcpu_has_mediated_pmu_caps` evaluates to true if *any* capa=
bility matches, rather than *all*.
--

--- Patch [1]: [PATCH 1/8] KVM: x86/pmu: Add mediated PMU capability flags =
---
commit b775f5357bd23699130ac68abbdd7cd26849e026
Author: Sandipan Das <sandipan.das@amd.com>

KVM: x86/pmu: Add mediated PMU capability flags

This commit introduces VM-scoped mediated PMU capability flags to help KVM
determine available hardware assists for saving and restoring guest PMU
state. It defines flags for hardware-switched and hardware-filtered PMU
states, and manages these capabilities during VM initialization.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index a5821d7c87f93..f60856c48462b 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
[ ... ]
> @@ -88,6 +88,26 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kv=
m_vcpu *vcpu)
>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>  }
> =20
> +static inline bool kvm_vcpu_has_mediated_pmu_caps(struct kvm_vcpu *vcpu,=
 u32 caps)
> +{
> +	return kvm_vcpu_has_mediated_pmu(vcpu) &&
> +	       !!(vcpu->kvm->arch.mediated_pmu_caps & caps);

[Severity: Medium]
When a caller checks for multiple capabilities simultaneously, will this
return true if only one of the bits matches, rather than all requested bits?

If a future caller checks kvm_vcpu_has_mediated_pmu_caps() with multiple
flags, it appears it would return true even if only a subset of those flags
are present in mediated_pmu_caps.

[ ... ]
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index afcac1042947a..9f0e072ff466d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -12759,6 +12759,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsi=
gned int id)
>  		if (irqchip_in_kernel(kvm)) {
>  			r =3D perf_create_mediated_pmu();
>  			if (r) {
> +				kvm->arch.mediated_pmu_caps =3D 0;

[Severity: High]
If perf_create_mediated_pmu() returns a transient error like -EBUSY, is it
safe to permanently clear the VM-wide mediated_pmu_caps here?

If userspace receives the error, resolves the host perf conflict, and
retries the KVM_CREATE_VCPU ioctl, the retry might succeed but the VM's
capabilities will have been irreversibly wiped. Does this lead to a silent
downgrade to software switching for the VM on a successful retry?

>  				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
>  				return r;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D1
