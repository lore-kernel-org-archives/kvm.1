Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591413;
	b=BFIiqQct8IZKvtDxVoZVVq/vAePBhozs2e+ougO0UCMIQqiMES27f5LFO3mjaySe0jKG
	 C09QVOc5reExNdfT5NUA325Rz9kLrZlUPkOfjgnJXdzlW2txWmVzSebvzCNMkT2NT8BFK
	 LMgopVdjZGCSsVv1/bhZ/DLstbm6OJDfXW0WuF2AvHrpJf/fpBIcqQT9cpKAbqkPhnjk+
	 n7Lv5kxBiU8W1PulqDC5tHK0gTSjqQcgeiwUfDccfp6EtxwrdiAsfk2+e9QVDCNiKbepE
	 tNM3WWcHvRksiSqEt0NoxhgfPt9/gpELij5SmtuAeuVUzRjGrCP/CZdLUg3rhQfk7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tsdsxAtx5ur2RfR41Vo9KuL0BIud70CGmTbCcTeUdhY=;
	b=n1/EqUnjdwyQapgoqtH+KlS6s6x8QNw2WCjN8wvTIzO4NzB1kMcU96GGaO57fy4UzOMs
	 3/vy4pFWvstMlRkhOp23zxEHGnvh6xKV3aeIdk2LvWsY4Mg/h+4gjjGaClMtzIHMUYuff
	 zm20C4Vyn2kYtQdN2DTMq3Bxo7y+0tqrUvJYIHxrBKO/inKpQ5oXntRydqJTwGj50iz0i
	 UsBEX6c+dC/6n1AO/aDRJEL93NFfhng3jsqj8+Le3XctHmDz2gG+UQe9nMJqahz7cdhiT
	 vteQIUBUncwornbAMH3NPwcQZ3VMcJXljSjCJ/dsRA7ahPPm0J+KsN7yz3+fD2J/Qrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4g4SEyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEB6079D6A
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4g4SEyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46C71F000C6;
	Fri, 13 Nov 2026 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591412;
	bh=tsdsxAtx5ur2RfR41Vo9KuL0BIud70CGmTbCcTeUdhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4g4SEyXB9j8pLLUtk3wSaj03PnLe4JwZSqPe1CCuZsaJVhP4KhWlKiSnZqaxLVwI
	 31H7mqUQ4H8DnCF/Jz4vNnRVJ2ZWDersdM4zRCcSJMibhyQbUVtKANZH9XbkNbXtUo
	 TRLufB6STiVHE3LtN0AQVNGT778a++Ysj6wq0i5BxZ4p5oGIN+Km95Grx1ccmffCm3
	 wRzI6ujkDW83FQS3RUUP8DUgNVn93kiu0VNaAkT0KHrT/yFg1JzQwMPEKGz92Wi2l9
	 K0OnKCn1rBg9LTJtz0ArCQP90e45p3lsQA23Vb8D71N/Ni4g57ESwXGvoZzVrKg95h
	 2uf0vIsdEgolQ==
Message-ID: <sashiko-outbox-213330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <avdGNbOO4562tk10@google.com>
References: <20261113164000.467175-1-seanjc@google.com>
 <sashiko-outbox-213282@kernel.org> <avdGNbOO4562tk10@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:36:52 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] KVM: x86/mmu: missing Signed-off-by trailer in commit message
- [Medium] KVM: x86/mmu: commit title and message do not match change in
  kvm_mmu_prefetch_sptes()
- [Low] KVM: x86/mmu: missing Fixes trailer for commit f029f04ddbec
--

commit 0029f5853016e6378c3fb60ef0b654f4ef090476
Author: Sean Christopherson <seanjc@google.com>

> KVM: Skip gfn-based MMU notifier invalidations for guest_memfd-only memsl=
ots
>
> On Fri, Nov 13, 2026, sashiko-bot@kernel.org wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index cf4cb586f1407..599dea22afb81 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_h=
va_range(struct kvm *kvm,
> > >                     unsigned long hva_start, hva_end;
> > >
> > >                     slot =3D container_of(node, struct kvm_memory_slo=
t, hva_node[slots->node_idx]);
> > > +
> > > +                   if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gme=
m_only(slot))
> > > +                           continue;
> >
> > [Severity: Critical]
> > Can skipping guest_memfd-only memslots here leave writable SPTEs instal=
led by
> > x86's kvm_mmu_prefetch_sptes() unzapped when the VMA at slot->userspace=
_addr
> > is unmapped?
> >
> > While __kvm_mmu_faultin_pfn() resolves the primary fault from guest_mem=
fd for
> > gmem-only memslots, the post-fault PTE prefetch paths (such as FNAME(fe=
tch)()
> > -> FNAME(pte_prefetch)() for nested EPT/NPT or shadow paging) call
> > kvm_mmu_prefetch_sptes() for neighboring GFNs without checking
> > kvm_memslot_is_gmem_only():
> >
> > arch/x86/kvm/mmu/mmu.c:kvm_mmu_prefetch_sptes() {
> >       slot =3D gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRIT=
E_MASK);
> >       if (!slot)
> >               return false;
> >
> >       nr_pages =3D kvm_prefetch_pages(slot, gfn, pages, nr_pages);
> >       if (nr_pages <=3D 0)
> >               return false;
> >
> >       for (i =3D 0; i < nr_pages; i++, gfn++, sptep++) {
> >               mmu_set_spte(vcpu, slot, sptep, access, gfn,
> >                            page_to_pfn(pages[i]), NULL);
> >               ...
> >               kvm_release_page_dirty(pages[i]);
> >       }
> > }
> >
> > kvm_prefetch_pages() resolves PFNs from slot->userspace_addr via
> > get_user_pages_fast_only(), and kvm_mmu_prefetch_sptes() installs writa=
ble
> > SPTEs and drops the page references.  With kvm_handle_hva_range() ignor=
ing
> > gmem-only memslots, unmapping or reclaiming the VMA at slot->userspace_=
addr
> > will not zap those prefetched SPTEs, giving the guest a host page
> > use-after-free.
>
> Well fudge.  That's a bug that needs to be fixed irrespective of this pat=
ch,
> though it obviously needs to land first.
>
> The TDP MMU doesn't support automatic prefetching, yet[*], and I'm planni=
ng on
> using the "normal" fault flow for that support, so I think we can just di=
sable
> prefetching for gmem-only slots without negatively impacting any real-wor=
ld
> workload, and punt on proper support until someone cares, e.g.

[Severity: High]
The commit message is missing a Signed-off-by trailer.

[Severity: Medium]
The commit subject and message are an unedited email reply to a different
patch and end mid-sentence, rather than describing the change in
kvm_mmu_prefetch_sptes() to skip SPTE prefetching for guest_memfd-only
memslots.

[Severity: Low]
Since commit f029f04ddbec ("KVM: x86/mmu: Handle guest page faults for
guest_memfd with shared memory") updated __kvm_mmu_faultin_pfn() to fault
in pages from guest_memfd for gmem-only memslots while leaving
kvm_mmu_prefetch_sptes() resolving PFNs from slot->userspace_addr, should
this include:

  Fixes: f029f04ddbec ("KVM: x86/mmu: Handle guest page faults for guest_me=
mfd with shared memory")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/avdGNbOO4562tk10@go=
ogle.com?part=3D1
