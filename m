Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962B31C56D
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660763; cv=none; b=lbUA+z2nKK97a+BjeDPgWs1oqeCYenVSwqvyABis7CHv8YJ7f+DoAtGXvFmYsElPqlyGAHep9wPkG00KB8u/r42uuZHCnCIJ96guP062LbIqYxl3bDEBrFCIXBLhNU6IFxOm0BXNc2Khvd7eCBoBR1AsWMbu+tERQJzey0oZkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660763; c=relaxed/simple;
	bh=/FcMfFePowVPbIY/nVi+bxBmjIYYJfenpBNb3hnfWCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=osfGKMF6WT9C+F0xqSyuOfLE8kX88QtM8d1s+l+S7Eaxd8D5kMju6pOhKf4Rka+YWg4dv59ASQfd0QhFk0gbFK24Nxp7GxtOZ0zP4CytjND9Fttb5Mz/9yy8uUgJlq67juVZZhefl+iKArpwcBPzG+bHJijn5hIe/BmYZYXW3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0qk8CJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0qk8CJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283901F000E9;
	Thu, 13 Aug 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660762;
	bh=TWO9mf7347J4T9b1ErWeafy3Wy1+Mz7yk+On/NuxT94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0qk8CJ5UJkoKTVzVkwtvG5MRiM3GkqNLGAHhCSgRKkdHQ7Go/i4wPjA7BSkAdl3D
	 CTRrKcGPk7pOygadIBLVuVR/LOOk45YvNNTvxy57lEj0rF3BIjbr4Ar7ylozXC0qJc
	 6ombb11Jbli+dCtG566iKIPhbvRK0MBwEP46A3qhxxcNvcg8C3NGHtN4+aDdgRMm+D
	 vHAiFGCdBdMXrAuaTLRAtKbMwwLYPZ+boRAkU+x6WShQGLmZPsGlVlG3gkIJr7eUqv
	 xjFX5VkYcO6lz6ObVBoAMnVNKr/2HeSBlyM0MPBL2n4zAQxSX1gZUsX14PMSoDQiMT
	 XkVsotXzjvc3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] KVM: selftests: teach sev_*_test about revoking
 VM types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tycho Andersen" <tycho@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260324194034.1442133-6-tycho@kernel.org>
References: <20260324194034.1442133-6-tycho@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:39:21 +0000
Message-Id: <20260813223922.283901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch updates SEV-ES and SEV-SNP support checks to use `KVM_=
CAP_VM_TYPES` instead of `CPUID` to handle cases where VM types are revoked=
 (e.g., due to ASID exhaustion), but misses applying this logic to basic SE=
V, leading to test crashes.
--

--- Patch [5]: [PATCH v2 5/5] KVM: selftests: teach sev_*_test about revoki=
ng VM types ---
commit 2ec0ef2342e44224fa7c2705ca4877c7bb8e8605
Author: Tycho Andersen (AMD) <tycho@kernel.org>

KVM: selftests: teach sev_*_test about revoking VM types

Updates KVM selftests to use the VM type bit instead of CPUID to
determine SEV-ES and SEV-SNP support. This accommodates environments
where kernel and firmware configurations revoke VM types.

> diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/te=
sting/selftests/kvm/x86/sev_init2_tests.c
> index b238615196ade..97bd036b4f1c5 100644
> --- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> @@ -133,9 +133,8 @@ int main(int argc, char *argv[])
>  	have_sev =3D kvm_cpu_has(X86_FEATURE_SEV);
>  	TEST_ASSERT(have_sev =3D=3D !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KV=
M_X86_SEV_VM)),
>  		    "sev: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
>  		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_VM);
> =20
>  	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM));

[Severity: Medium]
This isn't a bug introduced by this patch, but does the same logic need to
be applied to basic SEV here?=20

If base SEV ASIDs are exhausted, the kernel revokes KVM_X86_SEV_VM support,
but CPUID still advertises X86_FEATURE_SEV. Since this code asserts that
CPUID perfectly matches KVM_CAP_VM_TYPES, won't this cause a test crash when
they inevitably diverge?

> -	have_sev_es =3D kvm_cpu_has(X86_FEATURE_SEV_ES);
> +	have_sev_es =3D kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM=
);

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/=
testing/selftests/kvm/x86/sev_migrate_tests.c
> index 0a6dfba3905b6..3f2c3b00e3bc4 100644
> --- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> @@ -374,7 +374,7 @@ int main(int argc, char *argv[])
> =20
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));

[Severity: Medium]
This is a pre-existing issue, but should this TEST_REQUIRE check
KVM_CAP_VM_TYPES instead of CPUID?=20

If the SEV VM type has been revoked, CPUID will still report support, which
might lead to crashes upon VM creation when the migration tests execute.

> -	have_sev_es =3D kvm_cpu_has(X86_FEATURE_SEV_ES);
> +	have_sev_es =3D kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM=
);
> =20
>  	if (kvm_has_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM)) {
>  		test_sev_migrate_from(/* es=3D */ false);

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/tes=
ting/selftests/kvm/x86/sev_smoke_test.c
> index 8bd37a476f159..f3c39335ff39a 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -247,8 +247,8 @@ int main(int argc, char *argv[])
>  {
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
> =20
>  	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);

[Severity: Medium]
This is a pre-existing issue, but does gating execution on CPUID rather
than KVM_CAP_VM_TYPES cause an issue here?=20

If KVM lacks SEV support despite CPUID, won't it crash when calling
test_sev_smoke() for base SEV?

> -	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
> +	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM))
>  		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324194034.1442=
133-1-tycho@kernel.org?part=3D5
