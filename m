Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633628;
	b=tGtvttyDHW5VRNuwOW8HRoMaqGUa2Jt5ilJLvuHT4bI4Psdc7l9y9+wQ9lqpkgAN0faw
	 8IOU0TYb5LfXuZ43Z8MEtSk9y+xyDMOy6bt8exqdXCpqM4+ct6Hwff45z2ezAdl4NMopT
	 MzEIneBK+H/clX73cJCXLIP3DCOO06rNMigI8XgesHf8kFaMaNzOTU4rreHxXY34ixi1A
	 lonFm1E/yNBhgHZqsVmKVPvZ33IUrMwGESiZv9okZj216cjbwN5HhIh2GfsVPKkjnnfpV
	 hG84rrF8m0zA6eyJs6w/9ubMpbaFcM264EqpLUFBvn/TNrR6aO7aA6oOFGqxCDBeNmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
	b=TohXON0jSFLjb//kG3rZHyLUPTwdj8LLAzUNvlWvusFJQCxDx486aHCJ9BKAHfy+vdM2
	 gLQd0b2p1I2chnndI2AqETubvCUo/Sik6HuQ8/3PxY46I9P9LkO85uONLMPyfks/9TVc/
	 hDckQBDzJ4xSHSWIXSnVppG7kq8rYAHT9yCeZNZhM9Wh/ZQjAd2qy+dGEx7tee1MCzPjR
	 wd9OOYBBbzVzI4P8T+nwtlAQByIKEzimmzfLG/pfQTfCb5QQj/YAGSSFGXxeK/b+LkwZt
	 DiKUo8ZkC2vI7qEc8fRyTIdeM+eSAV6hf71a3+0lW0OeYPOB/LEm3RqJCroTikB4Otg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZFlbIGvN;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886A609FDA1
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C886A609FDA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZFlbIGvN
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93e2f72bfso53651965ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633627; x=1794238427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
        b=ZFlbIGvNZK++z9i7Ef9M3Lts5+mhjELqChWtTNzX7naRDDHhxWhVpiCbxMAYXELwHA
         XqUuHHIHRWx+/ZrqDHx3/+0poo/8s3SXXL4AcNg1kW6zh/dUh+BfSYSK/rIjBa3FXACq
         EUyuTtJaak+y7eMle0v9fg7eC3HSzeZwScYN3+5RXD95nVvvj6b8cGCCsSZ2gC6najfw
         3MMtILykbBmQdGcCot1TZJyBRinqjOJ0atTaX9qcAx6Wwc3QKTNZXAgaqyIbkKpzelMA
         aXeSGxZCTqj0VFzzPmAJrwziqvUFjxh40xr1ZS37G5cET2BoWOw5B8lA2MWJBj0pnM9m
         Vneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633627; x=1794238427;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
        b=iz2xKAyGKUOUreWnT+WG0GQfIWeXHA85VahCl41q4/QqzmnecVk0eo8k/IGCNQtxQd
         jVeau+6bkJP58zhHKGfTJT8A7IuLI5nvBnp2ItHhrQfB9y3RfgpEbLs+8IDINIGPjOQo
         3Zbni3O4Q+mwRDyVf2TRByyibAoZikmpb6ebBwMtenBfs9df/P4ALx4RT4rZU4G6ZrxV
         /sdq+IHK1NxbsU/WP/9KstE9nypC2FcyY5/zNZocC73nGEou5pk002dUz8uUETnC586M
         OpJYNjm29DO/a2CLQjpdcB6iDQyeUU5UjIeNCNidRC3mMklz45NNqMa+2vj5lI30LZm2
         r+lA==
X-Gm-Message-State: APuU4Z8q0PJrKegTetimYm8Fz3EvEjIyLjSd5yCen/miYR1BgLM5bH5x
	+sAI96jXYlKUCAPuG7t7ilZgsgook8DTKPhnOA2StCn5vLXJE3upPKMPAkGIlGt1sK2hXBGAwpb
	Sv71n1g==
X-Received: from plgv20.prod.google.com ([2002:a17:902:e8d4:b0:2ea:3bc:770d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24b:b0:2e9:776f:66b4
 with SMTP id d9443c01a7336-2eb364f6eafmr93325065ad.44.1793633625745; Mon, 02
 Nov 2026 07:33:45 -0800 (PST)
Date: Mon, 2 Nov 2026 07:33:45 -0800
In-Reply-To: <sashiko-outbox-191627@kernel.org>
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
 <sashiko-outbox-191627@kernel.org>
Message-ID: <auitWWkOopYYbBH3@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Gautam and PPC lists/maintainers

On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_=
all_nested()
> --
>=20
> commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
> Author: Sean Christopherson <seanjc@google.com>
>=20
> KVM: Destroy memslots immediately after mmu_notifiers are unregistered
>=20
> This commit replaces active memslots with an empty memslot set and frees =
all
> memslots immediately after unregistering the MMU notifier in kvm_destroy_=
vm(),
> prior to calling kvm_arch_destroy_vm().
>=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index fa548b12228ff..2eda12a52bf4b 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
>=20
> [ ... ]
>=20
> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >  		kvm->mn_active_invalidate_count =3D 0;
> >  	else
> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> > +	kvm_destroy_memslots(kvm);
> > +
> >  	kvm_arch_destroy_vm(kvm);
> >  	kvm_destroy_devices(kvm);
> > -	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> > -	}
>=20
> [Severity: Medium]
> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV wh=
en
> destroying a VM with nested virtualization enabled?

I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arc=
h_flush_shadow_all()",
should free the rmaps in response to kvm_arch_flush_shadow_all().   From wh=
at I
can tell, the page tables have to be in radix mode, and so the rmaps are fr=
eed via:

  kvmppc_radix_flush_memslot()
  |
  -> kvmppc_unmap_pte()
     |
     -> kvmhv_remove_nest_rmap_range()
        |
        -> kvmhv_remove_nest_rmap_list()

And if that doesn't work, it means memslot deletion on an active VM is comp=
letely
broken.

However, it means the memslot code in kvmhv_release_all_nested() is dead co=
de, so
this as follow-up to patch 3?  Or maybe folded in?

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_=
hv_nested.c
index a6ff42d7666c..27985210f972 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 	int lpid;
 	struct kvm_nested_guest *gp;
 	struct kvm_nested_guest *freelist =3D NULL;
-	struct kvm_memory_slot *memslot;
-	int srcu_idx, bkt;
=20
 	spin_lock(&kvm->mmu_lock);
 	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
@@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 		freelist =3D gp->next;
 		kvmhv_release_nested(gp);
 	}
-
-	srcu_idx =3D srcu_read_lock(&kvm->srcu);
-	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
-		kvmhv_free_memslot_nest_rmap(memslot);
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
=20
 /* caller must hold gp->tlb_lock */
		=09

[*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.com

> In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i]
> with kvm_empty_memslots and frees each memslot via
> kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memslot=
_hv()
> in arch/powerpc/kvm/book3s_hv.c:
>=20
>     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
>     {
>             vfree(slot->arch.rmap);
>             slot->arch.rmap =3D NULL;
>     }
>=20
> which frees the slot->arch.rmap array without freeing the linked
> struct rmap_nested entries.
>=20
> Previously, those entries were freed before memslot destruction via
> kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
> kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
>=20
>     srcu_idx =3D srcu_read_lock(&kvm->srcu);
>     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
>             kvmhv_free_memslot_nest_rmap(memslot);
>     srcu_read_unlock(&kvm->srcu, srcu_idx);
>=20
> With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
> kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
> already been freed when kvmhv_release_all_nested() runs, so
> kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
> entries remaining in slot->arch.rmap at teardown (for example, when
> KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return ear=
ly,
> or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte())
> will be leaked.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.25=
98640-1-seanjc@google.com?part=3D12
>=20
