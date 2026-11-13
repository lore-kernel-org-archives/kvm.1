Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589856;
	b=XYKzVFUDZgV5Q6PG8l/rQlg6iPjyU26LYS2eB6qpzRREGl9oYtZ+NrcuCx9XqV8cMMCP
	 uQeKeWyEMV5KKEf9/Az7KqZ02YsGq0TMlUsfThy/MyfvsZRdsCjEAt8oxSL45fID5G/sP
	 A8x4LS77xii5bSEOYHh7MsNCeJ8QTF17VrwJAqgtYxOYITgasjH7LGwrVOzb8HE1xedn3
	 rBdHYZS6qAlRZEWJ73EcSPV3MleY9PIGmhxoGobLY9SnCdHK8ER8zTJjuI3s744D+wt8q
	 pT/F9bGMVncE87NApyDOYWNxuRI+y5euaqaWHzMvszKYxCASoMSvdLXOXTRhG5L8yIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VcsUBtcfEb+DOu7/PKI5+iOLyfgJedraq8j9OhG6L1M=;
	b=BYYuFgr7tkd08paDBxKA9G8tFyBLHT561zUjF7GfunudmqR+t8R7VC1KJhA5pDAQkGj7
	 idh5iXeqyfEqHWOJ1lQyar35jSOaq1qOm+ib4s+V9xkPHRqAd2IL08zngGO3FVIC3Kc4+
	 U7j+auCeBHkU1ez4V/7XIkNCaByqBvVF976gjGyT1uxiUO94+qzwZh6GDEhAjzrLdFvdV
	 zHt0603lwUr3DvNX02HBYXG99yxLn38U8hA4vf8VhjtYmK/o3+jHgUXsOo2PZjqYBc5hU
	 Nl/GPwVXmga04Cl9GA2rcYvYW8lW/0ENI+73Kt3p+7pcsjIhFaWktMHisxNFeEdmh9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeYHWBws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33675606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeYHWBws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A01F000C5;
	Fri, 13 Nov 2026 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589855;
	bh=VcsUBtcfEb+DOu7/PKI5+iOLyfgJedraq8j9OhG6L1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WeYHWBws378UZI+kBHCNBpuckQ3wVg9WLy7D/BlxwdVkdS4ABsutb19uftER2PHrQ
	 IefWEDCrj/qdoOIONAOCjTrtzBDW2tJpKJS/jFY5eis/sQFuMoYExteZA2DPYnye/e
	 eRZjFqDszJnaSJ31uSq54SrtClZ/N9lRvlzN08lAwb9Smfw8r+wPdb8VIeKfMgi/xC
	 5PjdKr9FpCU2+zJj3s7VunEViecWDth2cbar7JrFkwSYR/0c5eABuByn2Ag/9fH9Hd
	 gowljHukj3CrNptfZM00Iy0tFO8zF80HTq8xa7z3XvdvBZiVj0XyafW8V666Yj1hxq
	 MdfLUalV2Z5gg==
Message-ID: <sashiko-outbox-213282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113164000.467175-1-seanjc@google.com>
References: <20261113164000.467175-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:10:55 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Critical] KVM: x86/mmu: host page UAF via kvm_mmu_prefetch_sptes() on
  gmem-only memslots
--

commit 8fb2cb0acca2cbb14c599c1c5881381eb579d79c
Author: Alexandru Elisei <alexandru.elisei@arm.com>

KVM: Skip gfn-based MMU notifier invalidations for guest_memfd-only memslots

This commit skips guest_memfd-only memslots in kvm_handle_hva_range() when
handling MMU notifier invalidations.

Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@=
arm.com
Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..599dea22afb81 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_r=
ange(struct kvm *kvm,
>  			unsigned long hva_start, hva_end;
> =20
>  			slot =3D container_of(node, struct kvm_memory_slot, hva_node[slots->n=
ode_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;

[Severity: Critical]
Can skipping guest_memfd-only memslots here leave writable SPTEs installed =
by
x86's kvm_mmu_prefetch_sptes() unzapped when the VMA at slot->userspace_addr
is unmapped?

While __kvm_mmu_faultin_pfn() resolves the primary fault from guest_memfd f=
or
gmem-only memslots, the post-fault PTE prefetch paths (such as FNAME(fetch)=
()
-> FNAME(pte_prefetch)() for nested EPT/NPT or shadow paging) call
kvm_mmu_prefetch_sptes() for neighboring GFNs without checking
kvm_memslot_is_gmem_only():

arch/x86/kvm/mmu/mmu.c:kvm_mmu_prefetch_sptes() {
	slot =3D gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
	if (!slot)
		return false;

	nr_pages =3D kvm_prefetch_pages(slot, gfn, pages, nr_pages);
	if (nr_pages <=3D 0)
		return false;

	for (i =3D 0; i < nr_pages; i++, gfn++, sptep++) {
		mmu_set_spte(vcpu, slot, sptep, access, gfn,
			     page_to_pfn(pages[i]), NULL);
		...
		kvm_release_page_dirty(pages[i]);
	}
}

kvm_prefetch_pages() resolves PFNs from slot->userspace_addr via
get_user_pages_fast_only(), and kvm_mmu_prefetch_sptes() installs writable
SPTEs and drops the page references.  With kvm_handle_hva_range() ignoring
gmem-only memslots, unmapping or reclaiming the VMA at slot->userspace_addr
will not zap those prefetched SPTEs, giving the guest a host page
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164000.4671=
75-1-seanjc@google.com?part=3D1
