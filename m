Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A73EFFD2
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480506; cv=none; b=Fk7+5rUdeLTQztbyQk+jY0SoOPFwAEMsi4MYOOegRPNeMaKQ+nIEsDeHxIJ/wJguS3LFdEm6TSxqHGQeMZmI3eveMQslpXUspHQtOFQ537A5BduAuyg8CXtcYf4Adn4WLOzfIQmGD7L+nXUrOAtfSpzI0hzFfk8vId83fY6xZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480506; c=relaxed/simple;
	bh=3OFxxx8kS5Cdmy7AVq4wnLk/WzsyoXnvtqZpyeshVUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEPM7L0BrW0Hk323oqPorltba/MDu0R3F20yid1kcIvx+ncbEh2XgV4HSquZCu8DIq9j17GngE3VRml706dmNWq7ON26qkgmWjsTTTpr5b8vfCwHz4A5vTw1L1+HlhvqyvLTdXm8AiOU6JLOf1KtQwVO7GV72gl5BykisciE7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYeLyCIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYeLyCIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432A1F00A3A;
	Fri, 26 Jun 2026 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480503;
	bh=kNyq6Y3prIe42y3Ryu+3RLPykCCsL9vi1GPmxhwcmzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYeLyCIAHXjXuEh7AHp6TDRIsi+mYvk5CumxQ97kdRytCud1fkkWqrtz0Qt3AY3Ke
	 Atpjxks96QT0MoD3Lvf6KgRaBrHf1N9u/ksc0nUOUH5eC4xlUcrO28jxG7/vNgsvLh
	 k3IPtMUaZxXfPCUXJENbg7y6nPTbZGIhyErd8C+mdwlPiQmCICKrJ0m/THPnRSeWsd
	 wY4kNa/KUzNiTRLY2oVUSuGBVLxMMIHH7bE7l3j57CYPBJx+s+lhaGBkz3nChujudi
	 m6vUM7s57Ou+0nOJpE1jk/wh4RYX4VYUHDvTqZVwNtqt/VABXpHJw+UDCTakiTsvk8
	 JZi3qq4Vj5feg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 11/17] KVM: x86/mmu: Always pass 0 for @quadrant
 when gptes are 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112634.1778506-12-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <20260626112634.1778506-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:28:22 +0000
Message-Id: <20260626132823.3432A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added `WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes=
)` is factually incorrect and trivially triggerable by an unprivileged gues=
t, leading to a host-side Denial of Service if `panic_on_warn` is enabled.

Pre-existing issues:
- [High] In direct MMU mappings for non-paging guests, child shadow page al=
location incorrectly applies 32-bit quadrant logic and triggers a warning.
--

commit 890f97eba3156db8c16203bd93e23c5a69ffdd15
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Message-Id: <20220516232138.1783324-6-dmatlack@google.com>

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e4759156a2dc8..76d87da1d0712 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3263,9 +3263,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu,=
 gfn_t gfn, int quadrant,
>  	struct kvm_mmu_page *sp;
> =20
>  	role.level =3D level;
> +	role.quadrant =3D quadrant;
> =20
> -	if (!role.gpte_is_8_bytes)
> -		role.quadrant =3D quadrant;
> +	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
> +	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);

[Severity: High]
Can this new warning be triggered by an unprivileged guest?

If a guest runs with TDP disabled (Shadow MMU active) and disables paging
(e.g., boots in real mode), kvm_calc_shadow_mmu_root_page_role() sets
role.base.direct =3D 1 and role.base.gpte_is_8_bytes =3D 0.

When mmu_alloc_direct_roots() calls mmu_alloc_root() for a direct MMU
root, won't this unconditionally hit the WARN_ON_ONCE and potentially
cause a host panic if panic_on_warn is enabled?

>  	sp =3D kvm_mmu_get_page(vcpu, gfn, role);
>  	++sp->root_count;

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but a prior patch in the series
appears to have introduced a similar issue for direct MMU mappings for
non-paging guests.

When a guest operates without paging using the Shadow MMU, the root shadow
page has role.direct =3D 1 and role.gpte_is_8_bytes =3D 0.

During page faults, __direct_map() allocates intermediate shadow pages by
calling kvm_mmu_get_child_sp() -> kvm_mmu_child_role():

arch/x86/kvm/mmu/mmu.c:kvm_mmu_child_role() {
        ...
        if (!role.gpte_is_8_bytes) {
                WARN_ON_ONCE(role.level !=3D PG_LEVEL_4K);
                role.quadrant =3D (sptep - parent_sp->spt) % 2;
        }
        ...
}

Since role.gpte_is_8_bytes =3D=3D 0, does this erroneously execute the 32-b=
it
guest PAE-shadowing path, triggering the warning when allocating level 2
shadow pages and incorrectly assigning a quadrant to direct mapping pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112634.1778=
506-1-pbonzini@redhat.com?part=3D11
