Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6D3B52E6
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476001; cv=none; b=Dy7XmWfO7xfBmYb5ebE7usrYitMaOrL28CPixt70C05HiaafamNAe7ZvXaOTiSyUxmAJonEn38rz6w9VyW/puUU55L8V34dGhp9PImyJg20GB3J5Sd/tXD+MxtKyPw8QNJWyR5EGg+pNuInNlcy5c5+OjOQ9TgalZSCgLf/g3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476001; c=relaxed/simple;
	bh=NGHuVIceZiHQn4HABesmvlShYQus0ttRkQVGXLAFRHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IT+M0jsOFHMaEPcuyeEbVo7qZOzh/JH2WhXFfrzmJNYsFvI+reF2wKO9g1e4Rk0VMid7BiJ4EL7j8WuXW/zx001yS3hOnIIEv2TjMWsm9Yy+JCl0ksiMhCJib0bIKEHM771n2Q0HMsMX0Ysuq9I0kGmYtO4KWeRx3GK0b9kXxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djfDPuHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djfDPuHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300BD1F000E9;
	Fri, 26 Jun 2026 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476000;
	bh=Biz5bESZIsrjh/XUkfzVhIsGZQGc/nEFUJnV4ybLyXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djfDPuHl7UmGTKokdP9mqWShAXD5YrJ3ozHZCMK4w++7PtaNRESEnGI6/UUR0HVTZ
	 U2qRlP+vqgzfvYjU52+mI0rE0bCWduv6zmv069/sxK8jkHd3Gf6v8lhRiNgKat7O/Q
	 Cg5MPMKrtw7CReDI/6zcET6X3ygh21OdlUrh0mPDMyEUaMFSP7Zi8ljdgDcVQv1CjW
	 93TzNlcKc+NiMYOcmJ4FzRvVfmUDa8ACuRvdy9bJcdMeuL9WHfaTCBn+hQ6TTWfCh5
	 t4/QW9FyhHBiXLSlm67cYgu9LT876PFntD3w0jS/OMn/lLhVPdHeTGqErFmPY/yp90
	 UKr0HO6VFVnGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y 4/8] KVM: x86/mmu: Always pass 0 for @quadrant
 when gptes are 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112606.1778248-5-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
 <20260626112606.1778248-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:13:19 +0000
Message-Id: <20260626121320.300BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes)=
 in mmu_alloc_root incorrectly triggers when KVM uses the shadow MMU for a =
guest with paging disabled (CR0.PG=3D0), enabling a guest-triggerable host =
Denial of Service.
--

commit f4ad49b2fb4e69e5a09cb3c4ffc7f0aaaa670e2f
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Message-Id: <20220516232138.1783324-6-dmatlack@google.com>

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3a5ed96703776..dbc18d4cc572c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3444,9 +3444,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu,=
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
Could this warning in mmu_alloc_root() inadvertently trigger a
guest-triggerable host denial of service?

If KVM uses the shadow MMU (for example, ept=3D0 or nested without TDP) and
the guest disables paging (CR0.PG=3D0), KVM falls back to direct mapping mo=
de.

In this state, kvm_calc_shadow_mmu_root_page_role() in arch/x86/kvm/mmu/mmu=
.c
sets role.base.direct =3D true, but kvm_calc_shadow_root_page_role_common()
leaves role.base.gpte_is_8_bytes as false since paging is disabled.

When handling the next memory access, wouldn't the call chain
kvm_mmu_load() -> mmu_alloc_direct_roots() -> mmu_alloc_root()
cause this warning to unconditionally evaluate to true and trigger a kernel
panic if the host has panic_on_warn enabled?

>  	sp =3D kvm_mmu_get_page(vcpu, gfn, role);
>  	++sp->root_count;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112606.1778=
248-1-pbonzini@redhat.com?part=3D4
