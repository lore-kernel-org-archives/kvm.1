Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAC3403EC
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497280; cv=none; b=mJKQ9aBR321GIJtG1ng2fIvfGI7xa7iBAbUwmwAmxPjqXaGfsZ1ot/kOV+m5FCrso280kMOfKyfR+JMMpyH871cgooz3iIqPVMToXfjBQMSaxuteyVOz3iPtrmYmtmliasopWd8ybcR4x8hQVbu3IY3JfnzGQdFvRU4cI7Q35pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497280; c=relaxed/simple;
	bh=if1gwpiv6k6PzCdV7CGHJesLtyoraI1A/pEIroOt6NA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nac6sXWfu017mVFlWipiQulSLus/Rr4qD0EiACzRINctoChbe1+84waq291mBbJhBCtiiaQwgTTWaBpm3eQW/pTFktLUXMv3mBLDS0mKqFTxqWPw+riJJ5ux8DPVNA/we9SngfVwv8ZwjDezXL+Pc7U1mVOQh1ZypXwJSw2gZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWrB0UPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWrB0UPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A08C1F000E9;
	Fri, 26 Jun 2026 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782497279;
	bh=xxjnxEiubfS8KgHYjKU1f28NFFs9xdXsLo7rKY/e4iA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWrB0UPjfzXulBhNelbHQbrEk5nBzBl0wZJN6cotfWMW2ZK5Tr1TO+WD/+tPxE6Gf
	 29K7KUpuJQqZKKd+UFuBRtMsNCUq9XyWHqlzBiMkW+i1ocUkR+8GQOHegtHi++q4IN
	 3ID/nyYoBW5rvqD9SMpVuNWGaJFp8+vDHMtfPLgGtfjdOGAdmUAcuGbeVuBsVLt/Gt
	 nT+NH3aowGXe9E+AsT0F+YdbbrjdtPE9dsmphpH/TsiZfgxsI/5GuxVFZ7kNdxLDPt
	 xYVO5kWFd+bKdp3nqes78CAUimQmv0c+UiDcCof6xagCl+KyZfBHI7KJoVSOtx+JUW
	 bj6SUbE+BfTMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v2 3/8] KVM: x86/mmu: Derive shadow MMU page role
 from parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626174620.1819772-4-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
 <20260626174620.1819772-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:07:58 +0000
Message-Id: <20260626180759.2A08C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct shadow pages can be allocated with `gpte_is_8_bytes =3D fal=
se`, violating KVM MMU invariants.
--

commit 0b01cee575924096aea0e7bca6d1f776d55aa386
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Derive shadow MMU page role from parent

This patch refactors how shadow page roles are computed, deriving most
information from the parent shadow page rather than calculating it from
scratch. This eliminates the dependency on the vCPU root role when
allocating shadow page tables.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -2171,6 +2153,54 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struc=
t kvm_vcpu *vcpu,
> +static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direc=
t, unsigned int access)
> +{
> +	struct kvm_mmu_page *parent_sp =3D sptep_to_sp(sptep);
> +	union kvm_mmu_page_role role;
> +
> +	role =3D parent_sp->role;
> +	role.level--;
> +	role.access =3D access;
> +	role.direct =3D direct;
[ ... ]
> +	if (!role.gpte_is_8_bytes) {
> +		WARN_ON_ONCE(role.level !=3D PG_LEVEL_4K);
> +		role.quadrant =3D (sptep - parent_sp->spt) % 2;
> +	}
> +
> +	return role;
> +}

[Severity: High]
Will this result in direct pages inheriting an incorrect quadrant and byte =
size?

When breaking down a huge page for a 32-bit non-PAE guest, FNAME(fetch) cal=
ls
kvm_mmu_get_child_sp() with direct set to true. kvm_mmu_child_role() derives
the role from the indirect parent, leaving gpte_is_8_bytes as false. It then
incorrectly calculates a quadrant for the direct page. Does this violate the
core MMU invariant that direct pages must always use 8-byte PTE semantics?

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
>  	struct kvm_mmu_page *sp;
> =20
> -	sp =3D kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
> +	role.level =3D level;
> +
> +	if (!role.gpte_is_8_bytes)
> +		role.quadrant =3D quadrant;
> +
> +	sp =3D kvm_mmu_get_page(vcpu, gfn, role);

[Severity: High]
Could this cause issues for non-paging guests?

For non-paging guests where TDP is disabled, the base role has direct
set to true but gpte_is_8_bytes set to false. This role is passed
unmodified to mmu_alloc_root(), which seems like it might propagate the
inconsistent state (direct with 4-byte PTEs) to the root allocation.
If a later check asserts that all direct pages use 8-byte PTEs, would
this trigger a host warning or panic on boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626174620.1819=
772-1-pbonzini@redhat.com?part=3D3
