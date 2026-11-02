Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635694;
	b=GI7xnnEHUdIrUxzl+tV/tzdgj3rZxw9bTLIwsD+48qlax0pRnGWK6N1BHH0Hgu1J8t8W
	 3cw33VXShsRwQ4wp96DFkhD3DwaNo1lFblhDc9K1kTHxL5cd/xeG/7nhUKDTLOa97IJni
	 CBVdhzvlzBaumsKch7zKAphg+4vo/KOtBXc2Folxn/DxBFGyJ/aBYHBfM96E+aTJSKJYE
	 eBM8oynyKfSuFzeSdC7L87JN/yK+bm1bar9620tYYsN19XXdcYbGlxk7FUOiiz7j0UH50
	 bH3Y7rzFW5zHbX18PXurWW+RgmtUXS7qKXH24X518qP+dXWwAAmRZ/sxcaxYjGOKvqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
	b=jTLyOvrcpmRjwJ+5aFexnaIF1no/twMONrxRytqj570VMMMJeR7KwcpVMEE0IkDqbblP
	 O5UCW+rhx/n9Rb8k8b2EAvScB5VUfYTRBThhBlT0hCFhqC2lwt4800vKO19QeneujG230
	 8smUPMoRvphwsnhFQIsnjB+f5a7qKqg9nBNDoEDTbqnmE1snC7Opq4c9P1TJKNxy5MA0P
	 6Mp/0eisacvgX80ZdxMafgQE+XP5xVJQtJWrCdjolh4Qo1CMb4958gzdEB9DrEwngjrNF
	 6uDkbqDrr+BKf67xvGE5p+eTltCXgz7sFQoqNpTf+683pGNuDMvovycNd+Vdwhxd4VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hOTZHYWB;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63E60703B1
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 16:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A63E60703B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hOTZHYWB
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3acd21ba24eso2111126a91.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793635694; x=1794240494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
        b=hOTZHYWBYFp6aEqyIZFm0ze6tQ0rtLsrsBYC48IiZtIruPcvTpvP7mkmEfRybj4y/X
         INFTdukAb/2Xh0OQQ4dE+koAXZ10kyWTyPGXQ9sBPDjn0IaenDsWmZf4Nd029PMaqFb9
         fLMtw8zQ+9XRZF1xFPfHC5mbhiLt1lpQ6ng+UgzfKng9Ift4LIvMrGVJUxKhXQEA5mPw
         PhUNuXu0unM4ls6GyYYMO+sG2G4oXi2dqXFzApkIYWj1UJEroX6VB1HtwhDrOdaXEZoO
         qS/qaz49lXVXR58TdLmQu/2qrxar/J0cM1HS8JxRZ6+S4xmzO/2chWvBDQWqvBRZ1Kuj
         dtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635694; x=1794240494;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
        b=QaZ1sJAfACjY65VHtcSxgbat5Wq/XOy89nIW9q4NsE0ApoCd7NVTBVmgNocRi7KPvo
         9WexCCwpwfu01ICaWAlZyexQxwD1WQaAIjxU54/8jcgXy//hc3JRJLPM9SGuIV0QSvjp
         CQOEO8ae7CNdnOqnEusPcY7KXHD9rPB3OzoHUBAjxpPFpOb63Yzg/Qj5KN7MamFG0bWo
         VeZPdBy7CR9LrzPo7I8zEJk/xlJsCN7GG61K6p59i+b/J4iJnGTK2FaWWQpGORtkH6qN
         t+G1JP/pB9Sz84iGekct3yepDv/ixy2RUoXYpXY3bdvjK1OW409LPPMzESMAr2wtyNCE
         /+Eg==
X-Gm-Message-State: APuU4Z8on52bzPIgn7omj2GnVrt3jChEVMhso5oi300HBLTfOg++3NHw
	9+a5QmqXxM5z/6MdiSPaiV3cP65zcv5NQaBaICJMGy6h8eMtzyOeihxirmAXLKvkNEUAnAtEDUl
	X11H6qQ==
X-Received: from pjbfh3.prod.google.com ([2002:a17:90b:343:b0:3ac:7545:d82e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b51:b0:39e:6795:f7da
 with SMTP id 98e67ed59e1d1-3ae897c7d22mr8880600a91.19.1793635693550; Mon, 02
 Nov 2026 08:08:13 -0800 (PST)
Date: Mon, 2 Nov 2026 08:08:12 -0800
In-Reply-To: <auitWWkOopYYbBH3@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com>
 <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com>
Message-ID: <aui1bOy-PwIgKOFk@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Ritesh as well

On Mon, Nov 02, 2026, Sean Christopherson wrote:
> +Gautam and PPC lists/maintainers
>=20
> On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_releas=
e_all_nested()
> > --
> >=20
> > commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
> > Author: Sean Christopherson <seanjc@google.com>
> >=20
> > KVM: Destroy memslots immediately after mmu_notifiers are unregistered
> >=20
> > This commit replaces active memslots with an empty memslot set and free=
s all
> > memslots immediately after unregistering the MMU notifier in kvm_destro=
y_vm(),
> > prior to calling kvm_arch_destroy_vm().
> >=20
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index fa548b12228ff..2eda12a52bf4b 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> >=20
> > [ ... ]
> >=20
> > > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> > >  		kvm->mn_active_invalidate_count =3D 0;
> > >  	else
> > >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> > > +	kvm_destroy_memslots(kvm);
> > > +
> > >  	kvm_arch_destroy_vm(kvm);
> > >  	kvm_destroy_devices(kvm);
> > > -	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> > > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> > > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> > > -	}
> >=20
> > [Severity: Medium]
> > Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> > struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV =
when
> > destroying a VM with nested virtualization enabled?
>=20
> I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_a=
rch_flush_shadow_all()",
> should free the rmaps in response to kvm_arch_flush_shadow_all().   From =
what I
> can tell, the page tables have to be in radix mode, and so the rmaps are =
freed via:
>=20
>   kvmppc_radix_flush_memslot()
>   |
>   -> kvmppc_unmap_pte()
>      |
>      -> kvmhv_remove_nest_rmap_range()
>         |
>         -> kvmhv_remove_nest_rmap_list()
>=20
> And if that doesn't work, it means memslot deletion on an active VM is co=
mpletely
> broken.
>=20
> However, it means the memslot code in kvmhv_release_all_nested() is dead =
code, so
> this as follow-up to patch 3?  Or maybe folded in?
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index a6ff42d7666c..27985210f972 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  	int lpid;
>  	struct kvm_nested_guest *gp;
>  	struct kvm_nested_guest *freelist =3D NULL;
> -	struct kvm_memory_slot *memslot;
> -	int srcu_idx, bkt;
> =20
>  	spin_lock(&kvm->mmu_lock);
>  	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
> @@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  		freelist =3D gp->next;
>  		kvmhv_release_nested(gp);
>  	}
> -
> -	srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> -		kvmhv_free_memslot_nest_rmap(memslot);
> -	srcu_read_unlock(&kvm->srcu, srcu_idx);
>  }
> =20
>  /* caller must hold gp->tlb_lock */
> 		=09
>=20
> [*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.co=
m
>=20
> > In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i=
]
> > with kvm_empty_memslots and frees each memslot via
> > kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memsl=
ot_hv()
> > in arch/powerpc/kvm/book3s_hv.c:
> >=20
> >     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slo=
t)
> >     {
> >             vfree(slot->arch.rmap);
> >             slot->arch.rmap =3D NULL;
> >     }
> >=20
> > which frees the slot->arch.rmap array without freeing the linked
> > struct rmap_nested entries.
> >=20
> > Previously, those entries were freed before memslot destruction via
> > kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
> > kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
> >=20
> >     srcu_idx =3D srcu_read_lock(&kvm->srcu);
> >     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> >             kvmhv_free_memslot_nest_rmap(memslot);
> >     srcu_read_unlock(&kvm->srcu, srcu_idx);
> >=20
> > With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
> > kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
> > already been freed when kvmhv_release_all_nested() runs, so
> > kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
> > entries remaining in slot->arch.rmap at teardown (for example, when
> > KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return e=
arly,
> > or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte(=
))
> > will be leaked.
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.=
2598640-1-seanjc@google.com?part=3D12
> >=20
>=20
