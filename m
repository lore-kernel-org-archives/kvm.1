Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A03451B3
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318577; cv=none; b=lGAIWUAa17a1uABwZQfwRRdvfBZrTONxrZeVNOsjuD6tLmBwjlRq32IN4D4uf0XxQc43dIQhs5XRjE6ntRP+gMIo0GucFKb9HVGFjqHHJZojilff6B0TcaoWJP+S7DGt//gGgwtd+Y9PuFqHVplzHP0sXX+hWTDrcaAIxPZZN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318577; c=relaxed/simple;
	bh=4eSXApBtrcINSssuugxWX/HSnL/IZs0D2iVGkFYmsIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/psYXnudCny+ZeQIn4qWaSHYI2ekAOBwJNKl8nqN1Kv8GSLq2JKmsUqOO8xmH6M+8Q9sjwJzTF71dlEX8xood9d2oNKiEV9umLrvT1aDw0gGb807HTnR1jVd6uGey9yx76Kyq+o0E1iEfxYIAY5DDXqLu+qeJVwIVJjrUXShjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbInZ5IN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbInZ5IN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F7F1F000FF;
	Sun, 13 Sep 2026 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789318576;
	bh=FwuDK9LveY8bOQuH4iarS7KNEcRil/Yw2lem6zDL4qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbInZ5INDO25czTuSHB8knGP4aGOvcK+uSU+0KLnMtzgQNjTWDj8JoYCnENVTo+sq
	 n2miurevZWtzBYJIf9NlFTg7rxLifdV08aI4mc8W5GLRliAeHE6WrbU2ilLTEpfs4P
	 EvEb8en9z/cHZofgrQxpGlbAW8j6CuIDjzIurKcl6PDV9jGD2INYI98woifc9HluzL
	 tS9LgwRgFPpS+ZYbSqN84IT3vSz71uvGK5m1NjjFsOMgVDF5xKKLHWylgKHjvl+k/9
	 9sV+XmOCvdW5AMRtteyYHy/gnLX3OUQJNK7kA/7/kuebsaFFNtGYXrJ0af8xEUzMr+
	 XWpFY59V2AcaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v3 3/7] KVM: x86/mmu: Derive shadow MMU page role
 from parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260913155523.7423-4-k@mgml.me>
References: <20260913155523.7423-1-k@mgml.me>
 <20260913155523.7423-4-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:56:15 +0000
Message-Id: <20260913165616.09F7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct shadow pages erroneously inherit `gpte_is_8_bytes =3D 0` an=
d are incorrectly assigned quadrants.
--

commit 6bad5f356476627b0df5994e2be62a19a71f499f
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Derive shadow MMU page role from parent

This patch modifies the shadow MMU page role calculation to derive most
information from the parent shadow page rather than computing it from scrat=
ch.
It preemptively splits the role calculation into a separate function to red=
uce
dependencies on the vCPU root role when allocating shadow page tables.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9f193b1620a95..b0504d40ac8c6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -2176,6 +2158,54 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struc=
t kvm_vcpu *vcpu,
>  	return sp;
>  }
> =20
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
> +
> +	/*
> +	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
> +	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
> +	 * (i.e. 8-byte PTEs). The difference in PTE size means that KVM must
> +	 * shadow each guest page table with multiple shadow page tables, which
> +	 * requires extra bookkeeping in the role.
> +	 *
> +	 * Specifically, to shadow the guest's page directory (which covers a
> +	 * 4GiB address space), KVM uses 4 PAE page directories, each mapping
> +	 * 1GiB of the address space. @role.quadrant encodes which quarter of
> +	 * the address space each maps.
> +	 *
> +	 * To shadow the guest's page tables (which each map a 4MiB region), KVM
> +	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
> +	 * @role.quadrant encodes which half of the region they map.
> +	 *
> +	 * Note, the 4 PAE page directories are pre-allocated and the quadrant
> +	 * assigned in mmu_alloc_root(). So only page tables need to be handled
> +	 * here.
> +	 */
> +	if (!role.gpte_is_8_bytes) {
> +		WARN_ON_ONCE(role.level !=3D PG_LEVEL_4K);
> +		role.quadrant =3D (sptep - parent_sp->spt) % 2;
> +	}
> +
> +	return role;
> +}

[Severity: High]
Because this patch removes the earlier enforcement of gpte_is_8_bytes being
true for direct pages, will direct child pages (like NX huge page workaround
pages shadowed from a 32-bit parent) inherit gpte_is_8_bytes =3D 0 from the
parent here?

If so, doesn't this incorrectly assign a quadrant to these direct pages,
violating the KVM invariant that quadrants are never used for direct pages?
This broken invariant appears to cause the WARN_ON_ONCE(role.direct &&
!role.gpte_is_8_bytes) check to trigger when introduced in later patches,
which creates a potential host-side denial of service if panic_on_warn is
enabled.

[ ... ]
> @@ -3438,13 +3467,18 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, =
gfn_t root_gfn)
>  	return ret;
>  }
> =20
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
>  	++sp->root_count;
> =20
>  	return __pa(sp->spt);

[Severity: High]
When a guest runs in non-paging mode (CR0.PG=3D0), mmu_role.base has
gpte_is_8_bytes set to 0. Since the code no longer forces gpte_is_8_bytes to
true for direct pages, will this block erroneously assign a quadrant to the
direct root?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913155523.7423=
-1-k@mgml.me?part=3D3
