Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE563E2756
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913728; cv=none; b=lWOsPUBcibGWQvElVzSGquJyW3nPr9yyds5FWrpS0CofvnN+3XZk1lEMg6woKlzYZ7yyvBOpigX5m33RAkfz84dKVjbaWwnGVso/FuJ7vEA7lJqmS98BE0JtRtQFdQksPA4p+otqN7j1BzlPqVNgY59U5bSL72gfOM+qm8YBuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913728; c=relaxed/simple;
	bh=Wm1qz49AumbzIDHDFRGZlIszm+RHQsT081CuAi7Y5uY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJFUKnjFnqMsJoOPAStqRmxkgcHxSXuLEVcuGp/fy0ypcGzIh5oF+dCt2PhHX8IBbZc6g6wQcgXDY8D39ybP0GPdjN1IVkXtpRaLRdcmrdjoazoBrmLtVyCJjuQvevSw7b0/W6LPZCHraYt1OK7PYX7ND9iyjooWUTl4Cv799lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgxVJyWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgxVJyWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B281F000E9;
	Wed,  5 Aug 2026 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913727;
	bh=u0h2/Z+UcRxDVpL1uIdzWWD7zL3ZNj7uqObQGQGFolY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgxVJyWw09eQnLQlftY3PKLvEK1GfL6rfWXybFOT0ImtgJDVBbGUbN6j9zZvtPUAh
	 xHFDtIG4gwuPrWMYFck8FpDOldtyXnYei3IoO0tPnVX0nFfxQ9mnBzF2vRpnXcPZeZ
	 5u0Yq9GV6f6i/MYVGzk7PPqaPznWd17sc3K+tpfvRq4g3Cm/Fme5/jcDxu1EBZKSs3
	 bKb42Waet/dRaeV4V/ICwnXMr5VY1U1tDwbdamvz3Or+MMGz3owp3soR2hUx6fRwh1
	 oCX4I1Yv0FDVrrVGdo1HumXH7DAvu8yi8fNvgslxML7j6WF8KlO+NyiXP3ojVuDkDY
	 7vQWCRFrcR8rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] KVM: guest_memfd: add
 GUEST_MEMFD_FLAG_MIGRATABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805-shivank-gmem-migrate-v3-4-00d8bdec4e1d@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
 <20260805-shivank-gmem-migrate-v3-4-00d8bdec4e1d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:08:46 +0000
Message-Id: <20260805070846.D3B281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Global capability check for KVM_CAP_GUEST_MEMFD_FLAGS falsely ad=
vertises GUEST_MEMFD_FLAG_MIGRATABLE on unsupported architectures.
- [Low] Typo in API documentation for GUEST_MEMFD_FLAG_MIGRATABLE.
--

--- Patch [4]: [PATCH v3 4/9] KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRAT=
ABLE ---
commit f12765f58cf3ad7c38abcf69c609570a66578e93
Author: Shivank Garg <shivankg@amd.com>

KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRATABLE
   =20
This patch adds architecture support checks and a new flag,
GUEST_MEMFD_FLAG_MIGRATABLE, to allow the MM to migrate guest_memfd folios.
It updates the mapping GFP mask and removes a redundant WARN_ON_ONCE.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index e3003a241d5b0..976921527ef9a 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6461,6 +6461,9 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently de=
fined flags:
>                                 without INIT_SHARED will be marked privat=
e).
>                                 Shared memory can be faulted into host us=
erspace
>                                 page tables. Private memory cannot.
> + GUEST_MEMFD_FLAG_MIGRATABLE   Allow MM to migrate guest_memfd folios.
> +                               Availability is architecture sepecific. W=
ithout

[Severity: Low]
This isn't a bug, but there is a typo here (sepecific instead of specific).

> +                               this flag, folios remain unmovable.
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 47cb9eba113b1..7087b0b8f973f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14130,6 +14130,15 @@ bool kvm_arch_supports_gmem_init_shared(struct k=
vm *kvm)
>  	return !kvm_arch_has_private_mem(kvm);
>  }
> =20
> +/*
> + * Migration of guest_memfd with private memory is not supported yet
> + * as this may require architecture-specific handling.
> + */
> +bool kvm_arch_supports_gmem_migration(struct kvm *kvm)
> +{
> +	return !kvm_arch_has_private_mem(kvm);
> +}

[ ... ]

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ab8cfaec82d31..7b2f15b219705 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -731,6 +731,7 @@ static inline bool kvm_arch_has_private_mem(struct kv=
m *kvm)
> =20
>  #ifdef CONFIG_KVM_GUEST_MEMFD
>  bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
> +bool kvm_arch_supports_gmem_migration(struct kvm *kvm);
> =20
>  static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
>  {
> @@ -738,6 +739,9 @@ static inline u64 kvm_gmem_get_supported_flags(struct=
 kvm *kvm)
> =20
>  	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
>  		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;
> +	if (IS_ENABLED(CONFIG_MIGRATION) &&
> +	    (!kvm || kvm_arch_supports_gmem_migration(kvm)))
> +		flags |=3D GUEST_MEMFD_FLAG_MIGRATABLE;

[Severity: Medium]
When userspace queries KVM_CAP_GUEST_MEMFD_FLAGS on the global /dev/kvm
file descriptor, kvm is NULL. Does the !kvm check here cause the API to
unconditionally advertise GUEST_MEMFD_FLAG_MIGRATABLE for all architectures
where CONFIG_MIGRATION is enabled?

If so, architectures that do not support migration (relying on the weak
default returning false) would advertise support globally, but then return
-EINVAL when userspace actually attempts to create a guest_memfd with this
flag.

If we drop the !kvm bypass to fix the capability advertisement, would the
x86 implementation of kvm_arch_supports_gmem_migration() shown above need an
explicit check for a NULL kvm pointer before passing it to
kvm_arch_has_private_mem()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-shivank-gm=
em-migrate-v3-0-00d8bdec4e1d@amd.com?part=3D4
