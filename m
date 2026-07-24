Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADB23C516
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855017; cv=none; b=Z4UTDPWFJPFyMwWIjVxUU+8HzdzIL+9l+dLRjEDGkwIJyIxTipy4QleMUvcyf4nIN5PRv2GdXFcs2ManHGuxKb40WB+0BUWDI/WxL7tliphnl9gvPIJ7sh15mVhJ4MwAgJ+zVuKHZmkgwiSGa4qMMqvU/kKFbmTpqbBdL5j5w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855017; c=relaxed/simple;
	bh=oecGHFI+ANd5JWO5gLb58XyWMcfYgyNy5vg3/R7OvQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKPv7vZtCPynGmTLK20kdau1oIBwxhbEpntZAlIejkbnMev0t3Zibqm93uOBTWEBJJ5a/BHXJ3z7G6td5hpg2x7kAmklJCVaY+4BswHqWDe0YVoEhtYkA8V40/raBuTPEKsSk7FG+YWeYshPIpaM5kSk5o9JVB2JCeViXcir/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcz6St5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcz6St5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FCF1F000E9;
	Fri, 24 Jul 2026 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784855016;
	bh=4KoxvuxQ2EWaCIbL8n3TqZrHC4iwPQuHce+vA9f2KOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcz6St5YgsgcxR+YMMnh5+Y6GdsRMPaxga9zrspc5uorVNqBUnzuxkAuP5StuvMhX
	 h8PsFfk14YlorFmAFm35RLFhmQtJ8gpEsyZOtnHonR4vmQYFBLIT9nmAce+R+g5gnH
	 81xE8+TqoyNvyRUpaQCRodfSN5kOKH7yA80uvGkTtbcoLBbaLrbvArd+GumFulaOfx
	 5nQlTKFf7giO/Z+Q6xt8uW0iTjtt8PVOlXW3bRIKOSugdidDE3KU0aVix+6blIn0og
	 JtPev6DgGjNjD3fZwU0PJWK5izETAioJtL8bCqV+7D+AFVS4KJ++BgPQ+NvmyRR7oX
	 gPY6vjgJN7qyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly)
 for patching dcbz
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724004757.131420-6-seanjc@google.com>
References: <20260724004757.131420-1-seanjc@google.com>
 <20260724004757.131420-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 01:03:34 +0000
Message-Id: <20260724010336.16FCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit title claims to use `CLASS(kvm_vcpu_map_local_readonl=
y)`, but the code uses the writable variant `CLASS(kvm_vcpu_map_local)`.
- [Low] The local variable `r` is declared but never used after the refacto=
ring.
--

--- Patch [5]: [PATCH 5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly)=
 for patching dcbz ---
commit 85b6110c0b5859c4a10a2a8a3cab84580d924a43
Author: Sean Christopherson <seanjc@google.com>

KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz

This commit converts the dcbz patching implementation in KVM PPC to use
the new scope-based CLASS(kvm_vcpu_map_local) infrastructure. It eliminates
the open-coded on-stack struct kvm_host_map to help harden the API against
memory leaks.

> KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz

[Severity: Medium]
The commit title mentions using CLASS(kvm_vcpu_map_local_readonly), but the
code below correctly uses the writable variant CLASS(kvm_vcpu_map_local)
since it needs to modify the memory. Should the title be updated to match
the implementation?

> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c

[ ... ]

>  static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *=
pte)
>  {
> -	struct kvm_host_map map;
>  	u64 hpage_offset;
>  	u32 *page;
>  	int i, r;

[Severity: Low]
Does this leave the variable r unused in kvmppc_patch_dcbz()?

It looks like the original call to kvm_vcpu_map() was replaced, and nothing
else assigns or reads r. This might cause a compiler warning for configurat=
ions
that check for unused variables.

>=20
> -	r =3D kvm_vcpu_map(vcpu, pte->raddr >> PAGE_SHIFT, &map);
> -	if (r)
> +	CLASS(kvm_vcpu_map_local, m)(vcpu, pte->raddr >> PAGE_SHIFT);
> +	if (m.ret)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724004757.1314=
20-1-seanjc@google.com?part=3D5
