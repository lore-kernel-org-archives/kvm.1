Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4113957E
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318159; cv=none; b=r5YikBUBbSXMOOxq6U6EL/kBSAxrmM+t0NTw+UNhMJJYl4N4vibxlzXg702NW9W6CjwI/H/V9XDtm16zOUkRn+kQulKts0/WIVCZSxToyjTwTJZPvaWVdEAGF6dOYnKjQn1JrFiJfTAmmPVvjJZjYpO+B9q9aWsCbpfHWUQoqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318159; c=relaxed/simple;
	bh=6lmerasI0wH+rNOCb0x2wv1me7Ovu4JWwZlv4kMsd8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1a1xqhi8jiFxvcGLTcvahLf9OB4Z7iDdtg9GEUQ71IJWom7hORcpIbPVd51F8RX879c+QQbyDGFbqDe66orfsWTlbN3JxNelvmGFmEXcCdL1bdydx4eXdjQK/WsKXDur6zCpyh2Tk7RcLWTe+FwrYVcGLN1Fvc3d8ZWZgfDsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exFurzIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exFurzIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F2C1F000FF;
	Sun, 13 Sep 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789318158;
	bh=vTFDrm2h+8hq9W1V11Z7BgNHvamcmYJ4u1FgyFQCHw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exFurzIkLl36UdOg66qqe/vpYuGbbFGYA02QGvCyH43G9ZUcTVfhy/LCtyW7v01f/
	 oaE+KzTcsepdGJhJAg+oKHRvNxxTv7SDV6CeJPln7Mqp8GOk/VkavkijYBS2qrcNRR
	 6+7t6vQIJe8+f4Z4JZ/TsH09eagafWfnYf2DLH14T7Mh1bod1qjPQI9AzZJrEFbOoB
	 Bp7v5bdsVd9T4YFAQFdubuSaaen3XXKeVQID025UEogK0fbOdP12FPXiHXc9gorogx
	 sCFUs/UFp63Cjw7vEsCPvSUK/cfyXkaUe1jfNu28nMqeYWyZuxI9l42dzlV15amj/v
	 YonsYFEl2LvsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v3 4/7] KVM: x86/mmu: Always pass 0 for @quadrant
 when gptes are 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260913155523.7423-5-k@mgml.me>
References: <20260913155523.7423-1-k@mgml.me>
 <20260913155523.7423-5-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:49:17 +0000
Message-Id: <20260913164917.E2F2C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest-triggerable WARN_ON_ONCE in mmu_alloc_root causing host DoS.
--

commit 990a474db7a6b43a7cc3e9446db94141ba6c88d1
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b0504d40ac8c6..b7801690ea175 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3474,9 +3474,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu,=
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
Can this assertion be triggered by a guest on a host using a shadow MMU?

If a guest disables paging (CR0.PG=3D0) while the host is using a shadow MMU
(e.g., TDP is disabled), KVM computes the MMU role in
kvm_calc_shadow_mmu_root_page_role(), setting role.base.direct =3D 1 and
role.base.gpte_is_8_bytes =3D 0.

When KVM later allocates roots for this direct MMU via
mmu_alloc_direct_roots(), it calls mmu_alloc_root(), which causes this
WARN_ON_ONCE to evaluate to true and fire, resulting in a host DoS
that is reachable by any malicious or misconfigured guest.

This issue does not appear to be fixed in subsequent patches in this series.

> =20
>  	sp =3D kvm_mmu_get_page(vcpu, gfn, role);
>  	++sp->root_count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913155523.7423=
-1-k@mgml.me?part=3D4
