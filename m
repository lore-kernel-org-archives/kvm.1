Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC873A83BF
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496685; cv=none; b=RavMoFmfQ5gizGHe2yuyLkJp8h21Epv5q/QzAjdJxchecP1wRorHtn8jOIZuAcH2pANA1jmPWfVD7AY70y6pwxUSJPtgvRvEvG/IGL2g4rN5O7eioVgDqmJBj9utUa9BciNTTbFOcPo0QJ2oOCkbmxxTLX4aLdQHZm/L6z/w2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496685; c=relaxed/simple;
	bh=mLJ6qa3SxjBHXmVRNnpFIHRJLOWkU67gn3D6zirLQIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kT5ZHaZk8Gb/3zpUUrRJQPxyV6j0ZAtOrsn25Lq2HwMntC/QQPsW7smrrN8tuHNeBjsNb6DcmNlRiNrV82khhfkqYsTqYFkrDxPQc/uxQ80QOkU+VlnWd+qIJFRD7duJCMcahKRE1fglfu48MQQ2v/2qf7uFyHP8iAvVC6b1B0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9ntnJa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9ntnJa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C41F000E9;
	Fri, 26 Jun 2026 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496683;
	bh=PvqMtnXZZlVIC+UHx1NTSpAZlptYjS5Lzho+gtDQEKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9ntnJa0tog9yNqxXLb6glBLy2RvmoGcTkN1czGQT2/dT+Avl3oc4Kp30l3+voAaC
	 AVbcvJbbzIvAmQ1IrVPkf0407Z/UNpDcU4Hnu1LxRsd6XZfIoUw0GZPDsjltD14qNV
	 LzkAprSp2LJ0ak4O4ZynsocBN449HDFFAvvjg2T/ygnrO/72lgqtupP09IU1z2Oe3G
	 SHqegRuuPpJ0i7ez4wbaoJTcRs4ViEPT6RpLysPZL8aa0WWWzBEqQNvFrsoz/59Pz9
	 9begVmX6zWJv9xLpShIIl9fSbiHbQzoH49zagVLzAl26eQpJaAbYzzNxEda/4ospat
	 NE3LdvU1LVzRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v2 4/8] KVM: x86/mmu: Always pass 0 for @quadrant
 when gptes are 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626174620.1819772-5-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
 <20260626174620.1819772-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 17:58:03 +0000
Message-Id: <20260626175803.D20C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a guest-triggerable WARN_ON_ONCE in mmu_alloc=
_root(), which causes a host denial of service (DoS) when panic_on_warn is =
enabled.
--

commit 8c0238e94cdb540684953deca3c7dac664d9db92
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes

This commit simplifies quadrant passing for PAE page directories by only
passing a non-zero quadrant when actually necessary. It also adds sanity
warnings to enforce these invariants.

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
Does this new assertion assume that direct-mapped roots only occur with TDP?

When a guest runs with paging disabled (CR0.PG=3D0) on a host using the sha=
dow
MMU, KVM operates the shadow MMU in a direct-mapped configuration. In this
context, kvm_calc_shadow_mmu_root_page_role() sets role.base.direct =3D 1 a=
nd
role.base.gpte_is_8_bytes =3D 0.

When KVM loads the MMU context, it invokes mmu_alloc_direct_roots(), which
subsequently calls mmu_alloc_root(). Under these conditions, the new
assertion evaluates to true and triggers unconditionally.

Since this path is reachable during a normal guest boot sequence, or
maliciously by a guest repeatedly disabling paging, could a guest use this =
to
trigger host warnings or kernel panics when panic_on_warn is enabled?

> =20
>  	sp =3D kvm_mmu_get_page(vcpu, gfn, role);
>  	++sp->root_count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626174620.1819=
772-1-pbonzini@redhat.com?part=3D4
