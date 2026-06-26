Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378825B663
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496761; cv=none; b=ZQacH4ndZUBGuK1NCkI8QRDL3KCXcGjwEiYyoLnEJPnEnmIevRUcTFClx1kFHIkyT1aeb1pbm8B9QaER6Svg1YHSQw/5+m/kAnNLFeTedcClnOaIAnnnzMZmqVB3iG/uhmZKFi/qe5yN7BHmjF6QjJsDExQi5b2iwfmjfLx4c5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496761; c=relaxed/simple;
	bh=F82WLG00VFsxuww5k02C08i2swdBn7DnCMAxy3JcasI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYrclpdUyxgd6M/FybMs2OoxXVQnCDId2ZtzldJanngrTYYDiV6XpOwDpEL0cs8iCcWOp6tJ9aSSX8CwaJCQsbS0RylaY5GDkePKHge/OfSMqlxvmOX9w0zk22YdJR+qdwYlUvxf8rLcqFBf6bBG3pGG3pD7edsBz2M4ZAinCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps8o04TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps8o04TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C61F000E9;
	Fri, 26 Jun 2026 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496760;
	bh=Sm7POneGl5b7kTTZKAmWex8CFdH/vgj2I6JQVMFPTRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps8o04TDt6zymUqUAFs3bTgKXN6EiNIbgFyGT4RvGTL4XxrZUazNjFZafGxULjHXz
	 cwAZn7Ql7p18B+HDlt8ZrkT3Lk6bk02dn2ruCswfLV+bIBATgPPQ1EkU9ZM8It2Dkq
	 hrEiXMS91G6uUQLlhzJvkgtv2rdvfDD/IfCAsFDy9yB8QWwlmkFkVh8xEIhrIUt3bM
	 pumpJ69fOkNELZUCDZWPs8X7JFhJ7rd4gBVi9awbIr7awcTpOIm+YejsOiOBAUkJ9r
	 vcPMLHRsM7+L11kCAgcaw0ghV1LtLmsjr/PKJka5m1RdoRvQshefi/Qzx2JrJHBD1T
	 Ffo+qQLPtKIsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v2 5/8] KVM: x86/mmu: pull call to
 drop_large_spte() into __link_shadow_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626174620.1819772-6-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
 <20260626174620.1819772-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 17:59:19 +0000
Message-Id: <20260626175920.6F0C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `cache` parameter added to `__link_shadow_page` is unused.
--

commit ed55c138ec7737d6fb972fc8e93a6a6549ebcdf9
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()

This commit moves the drop_large_spte() call out of individual callers
and directly into __link_shadow_page() before the shadow page is installed.
It also updates kvm_mmu_get_child_sp() to return an error pointer when a
shadow page already exists.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index dbc18d4cc572c..d58be2e698f79 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -2264,13 +2257,21 @@ static void shadow_walk_next(struct kvm_shadow_wa=
lk_iterator *iterator)
>  	__shadow_walk_next(iterator, *iterator->sptep);
>  }
> =20
> -static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
> -			     struct kvm_mmu_page *sp)
> +static void __link_shadow_page(struct kvm_vcpu *vcpu,
> +			       struct kvm_mmu_memory_cache *cache, u64 *sptep,

[Severity: Low]
This isn't a bug, but is the cache parameter used anywhere inside
__link_shadow_page()?

Looking at the full function body, it seems to rely on
mmu_page_add_parent_pte(vcpu, sp, sptep), which implicitly uses
vcpu->arch.mmu_pte_list_desc_cache rather than this new parameter.

> +			       struct kvm_mmu_page *sp)
>  {
>  	u64 spte;
> =20
>  	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK !=3D PT_WRITABLE_MASK);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626174620.1819=
772-1-pbonzini@redhat.com?part=3D5
