Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F028725B
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475305; cv=none; b=PBygMGeinLXN68TBS/1kvDCeOrvQM3LWzTdMqdmzfMdzAzksd3+obUZab9QDSP51ynNPaAQl6IiUs5YGc5I+5pfghG2KXR63pC9G2tcEo12SjjBN1rpIYY65543+UilG1oFJz3owQsPbYuKB+HfJjVrSjUEUOcBr+V7s3/5ioWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475305; c=relaxed/simple;
	bh=tjxKuacwQjoME5YJtnVddd+6ueFS6k1ycQDUqvKWyZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaINixLr67TDJnD+I21AK2Je2OtpByHMT0rgq4jSbYXBfWoc5JY498UuQZcj6fqIEF4+NC8J6rz0XroXlHfv00o0iDJIJ/vSADmWdjXmW89BeWkgyrSpAZpRIBoJSXFbTMfYL1oadLh9gMfdQGyNaAyrB2wrhwKHuzRUiK4kiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2iiE3d0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2iiE3d0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651001F000E9;
	Fri, 26 Jun 2026 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475303;
	bh=09zd8DfYltv9QFPgpshFSzK5Zg343kf32j7GrdW2MuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2iiE3d084w+/X4I1+PimGuiaJjNNxfjvOJ90vf4ZRicbEkaIbdcy/v4m8dQKvcgB
	 6eKyKnGVrgMBfvwxe/rH6BESlGf8cj4Odz+n2B4g22e/eCADzrQszVwIVwSMyzRevT
	 tOJ9Lf3YutlAJ8ul+21CkGw9c8Q9iCMd0QVowGAOemsZZNQlLYW9NWFhIbRnGZz+Lf
	 ywBy5v4st1X6UX4x+Fcykr1gF2XfIpCfTqyKPI/uxXO3asVgXPcA9RxA6/S3AHzlQ7
	 ZqJ4GJqvPUvjBzsJUJcIqkHsaaD8E30831j46UpK/HKr9jCXUUiXZOTQ6kwM5ZZ5k9
	 qo0wsr+I6bGzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y 3/8] KVM: x86/mmu: Derive shadow MMU page role
 from parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112606.1778248-4-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
 <20260626112606.1778248-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:01:41 +0000
Message-Id: <20260626120143.651001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `gpte_is_8_bytes =3D true` override for direct pages cause=
s KVM invariant violations, memory bloat, and guest-triggerable host panics=
 (DoS).
--

commit 9e9bc7152f4bea9d4c30ffc781d2f28f82a2c951
Author: Paolo Bonzini <pbonzini@redhat.com>
Subject: KVM: x86/mmu: Derive shadow MMU page role from parent

This commit refactors how the shadow MMU page role is computed by
deriving it from the parent shadow page. This removes the reliance on
the vCPU root role when allocating shadow page tables.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2070,33 +2070,15 @@ static void clear_sp_write_flooding_count(u64 *sp=
te)
[ ... ]
> -	role.direct =3D direct;
> -	if (role.direct)
> -		role.gpte_is_8_bytes =3D true;

[ ... ]

> @@ -2171,6 +2153,54 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struc=
t kvm_vcpu *vcpu,
> +static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direc=
t, unsigned int access)
> +{
[ ... ]
> +	if (!role.gpte_is_8_bytes) {
> +		WARN_ON_ONCE(role.level !=3D PG_LEVEL_4K);
> +		role.quadrant =3D (sptep - parent_sp->spt) % 2;
> +	}
> +
> +	return role;
> +}

[Severity: High]
Does this missing gpte_is_8_bytes override cause issues for direct maps
when a guest has paging disabled?

Since we no longer set gpte_is_8_bytes =3D true when role.direct is true,=20
if a guest runs with CR0.PG=3D0, mmu_role.base.gpte_is_8_bytes will be fals=
e.

In kvm_mmu_child_role(), child direct pages inherit this false value
from their parent. When building non-leaf shadow pages for direct maps,
this will enter the if (!role.gpte_is_8_bytes) block.

Won't this trigger the WARN_ON_ONCE(role.level !=3D PG_LEVEL_4K) assertion
for non-leaf direct maps, and also calculate a bogus quadrant? This
could fragment the cache keys and cause duplicate shadow page allocations
for the same GFN.

[ ... ]

> @@ -3408,13 +3437,18 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, =
gfn_t root_gfn)
> -static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
> +static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadra=
nt,
>  			    u8 level)
>  {
> -	bool direct =3D vcpu->arch.mmu->mmu_role.base.direct;
> +	union kvm_mmu_page_role role =3D vcpu->arch.mmu->mmu_role.base;
[ ... ]
> +	if (!role.gpte_is_8_bytes)
> +		role.quadrant =3D quadrant;
> +
> +	sp =3D kvm_mmu_get_page(vcpu, gfn, role);

[Severity: High]
Could the lack of the direct override here cause the root page to have
invalid role properties?

When mmu_alloc_root() is called by mmu_alloc_direct_roots() for a guest
with paging disabled, the role is extracted from mmu_role.base. If we
don't override gpte_is_8_bytes to true for direct pages, the root page
will have gpte_is_8_bytes =3D false.=20

Because of this, sequentially all children will inherit these invalid
properties, leading to the problems mentioned above in
kvm_mmu_child_role(). Should we ensure gpte_is_8_bytes is set correctly
for direct pages during root allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112606.1778=
248-1-pbonzini@redhat.com?part=3D3
