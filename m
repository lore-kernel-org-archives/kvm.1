Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731091;
	b=n0ccDlyDDtoTyzXqAkIc2vU2M/dqLqqwNfqfJGOzqNGvT9+jI8EGJ7h4COAtplXLSqjc
	 XNHWvB5Ed7htIn963Q2cdfC7svXJ6+IU20zEK8jU/h2YDqAm/QZPvknNhUZoyfqF0gQp3
	 O7Fecoj3lzuxmofFk2vjlrED9h+yJMoymo2qVOZBYWTLnDsHkDVX8GDHsfFmZq4gCcdw5
	 n8Y+aRtuK9OXUU5YJCJV/XAr8lY2Avhrf7Ltm0vOEHCnNk6+JYEtFpiVB0BDdr8RaDG3z
	 OORJvw8gso5bwdRQrF2+ABriPdq87pq9b7ah6scwBfSDT1k8tWjltrkys6ISCK1Z+tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Date:Message-ID:References:MIME-version:Content-type:
	 Content-Transfer-Encoding;
	bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
	b=f9PddPPyFig9Nbm3PvC7b64G2GOdMlzU7W9K7PfZhdk9LYqI8hwVROjnIsjKbkU1/gmB
	 k6051WgX9lpoUevAJ+8qZHmDK2ERo2Mzd+b3hfIoilhkPqWGeaDwk8nd5oOekevrfRXmk
	 Ys/ejjJH+WIiDU9TPew1PJQuZOdc2rAIUiLbczFl+VN5a1e9g4mVmdje7NT78uXpuLYwL
	 9cUvP+JlkwyRPOZU+s5q0P82XbNlNLpeyOOF6J8V23CdHesMaPibv9EhE1JfPjqk+qJg+
	 XnEVF/sgwi901X00xI3zFMouuaD+q6IqMlqhop54T9yp1xE0qFp2T0KWLYHYrhfSjRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N77tECFO;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADC606A332
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 18:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBADC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N77tECFO
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5567637eec.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731090; x=1794335890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
        b=N77tECFOK+jFc4mrx0DzrYcG5T2MhGgENcgEIM2Ky4hBvuFW3J/DIfDguu08+Jv6Ta
         iw4FfIvRGKou3uAeOqUdh22iN6tkoPKLg2LBST01In8gq6R4P7o+iRoEGLDULSKrwsD4
         dUu0GupdU5be0+79svQotANZW5jxyKHvlfYVYFLjuNsRCXraR6uTDKFiW6p/fTF2usUP
         LNTNYImbXbYY+cxuRbFMzcRXFHq4MjniKOzxn3jsb37F783OpzlDoYYvN/SFvmhc5Sq3
         14G/mYUxCTk+rcupAe2nQEsNojujYFVHYrBa5LzTWer4RZqDQaYm3f5FlmmAJq4o3FUf
         2Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731090; x=1794335890;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
        b=jCj0uHr91Y+SuOWcPqWw0QUgIdnkZMRsbI3V09jMMsZwTYl15XYbRslBlBfNRfsZe0
         /dEsrLNcoWih98lnlI+y5FRvzi0eha5b5kfYtQkJVgPvmjuz2j9XMDXL+BFsn36mkGHv
         m186yPFBANWjLoWXJgqAuk9ZkYREh6cE+s+82Liyoh0loq2UituC2jKVSB1v61qd4a+J
         Y4lLvdqvTyOg0A+j3l4NpawGai2NWfykg+SSJJKkB3OogHBscdmaWB0F8y70qvBAgm3+
         l0kAv/jzxT72E43rdqof5YT5GMuJN8SG1Fz6mbuP7PU+h2FbpSxOCZNGRGDzITbhYtso
         FM5w==
X-Gm-Message-State: APuU4Z9Br42FOhnQ8t5/OfgMn8TWsNNdAsqsitVur/87OTPaCKguEjwi
	GBWpBPze5trg6mv/cLiES+o+cYLOPKy1UKfdbTPXn6X2nGe1Uyz3XzWR
X-Gm-Gg: AYBFou0uJKr82Poh5U+WRI6Zdla73RH8ct15aKL2U20voeayN3wGi7USb+GyGRQsV/+
	ZtZSmXHfs5n0H0VKO5LbcCWmgpDwb9ZC1Hi3237eW4L/+VL4eXVXTPjkwduDprs34ZL8GhO6muX
	f4Rsu+BFarMewG2yUEklJ8PtRiDQg3izGdERTSx6AblszwnKx4ejcAqkGmS7qD6KRWmKq8IzfRD
	Upz2gcIYaoQQe73OzRrLxL62ypjYgOvrI+Pj32GPj3a6r6DkkjCxXnfhM9Etj6caj1XlzmAUgLD
	zL+QfDQy6fpYPkpHjImMRBIraFG81gos1u/KhxZ/kXLcv1fsCCLaVfU6wYKnzVdxNWNtIslJK8r
	2rmWQX5aoEurXw6y0yabY/mKWZyTi08OsbEsFxUUCzclp1pXsSxeiDCP2OFTURi5wwk+LndLeS9
	dHoN8VtqKBIgKYMeRnmGHzGHD6l4NbJfJC6t4WdUgU7JmNSuBVjkdORw9jTyyS/MBn6BU2n/JN0
	Bqenz19l7ooykvJVYLwEd0Yfc2f9H4N7teMqBBfqUow+SW0p33hEJH0A4+7vr+IdLvyAdMcRtAo
	iNp3/hnXf32xhbshG/+VToWQ1QY=
X-Received: by 2002:a05:693c:4153:20b0:358:8f02:e0ca with SMTP id 5a478bee46e88-36a4236903fmr21434174eec.9.1793731089637;
        Tue, 03 Nov 2026 10:38:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm58473902eec.25.2026.11.03.10.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:38:08 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after mmu_notifiers are unregistered
In-Reply-To: <auitWWkOopYYbBH3@google.com>
Date: Tue, 03 Nov 2026 23:38:34 +0530
Message-ID: <se1h6b4t.ritesh.list@gmail.com>
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com> <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sean Christopherson <seanjc@google.com> writes:

> +Gautam and PPC lists/maintainers
>
> On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_all_nested()
>> --
>> 
>> commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
>> Author: Sean Christopherson <seanjc@google.com>
>> 
>> KVM: Destroy memslots immediately after mmu_notifiers are unregistered
>> 
>> This commit replaces active memslots with an empty memslot set and frees all
>> memslots immediately after unregistering the MMU notifier in kvm_destroy_vm(),
>> prior to calling kvm_arch_destroy_vm().
>> 
>> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> > index fa548b12228ff..2eda12a52bf4b 100644
>> > --- a/virt/kvm/kvm_main.c
>> > +++ b/virt/kvm/kvm_main.c
>> 
>> [ ... ]
>> 
>> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
>> >  		kvm->mn_active_invalidate_count = 0;
>> >  	else
>> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
>> > +	kvm_destroy_memslots(kvm);
>> > +
>> >  	kvm_arch_destroy_vm(kvm);
>> >  	kvm_destroy_devices(kvm);
>> > -	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>> > -	}
>> 
>> [Severity: Medium]
>> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
>> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV when
>> destroying a VM with nested virtualization enabled?
>
> I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()",
> should free the rmaps in response to kvm_arch_flush_shadow_all().   From what I
> can tell, the page tables have to be in radix mode, and so the rmaps are freed via:
>
>   kvmppc_radix_flush_memslot()
>   |
>   -> kvmppc_unmap_pte()
>      |
>      -> kvmhv_remove_nest_rmap_range()
>         |
>         -> kvmhv_remove_nest_rmap_list()
>

That's correct. Maybe, I think Sashiko didn't consider patch-3 of the series
during review of this patch-12.

> And if that doesn't work, it means memslot deletion on an active VM is completely
> broken.
>
> However, it means the memslot code in kvmhv_release_all_nested() is
> dead code,

Not really. I do see a caller of this, for when we switch from radix
to HPT. So we still need it.

INCOMING CALLS
- f kvmhv_release_all_nested
  - f kvmppc_switch_mmu_to_hpt    [arch/powerpc/kvm/book3s_hv.c:5591]
    + f kvmppc_alloc_reset_hpt    [arch/powerpc/kvm/book3s_64_mmu_hv.c:144]
    + f kvmhv_configure_mmu       [arch/powerpc/kvm/book3s_hv.c:6330]
  + f kvmppc_core_destroy_vm_hv   [arch/powerpc/kvm/book3s_hv.c:5930]



So FWIW patch-12 as such looks good to me from PowerPC perspective,
since those rmap entries will get freed up as part of the
mmu_notifier_unregister() (after patch-3). Agreed that Sashiko
comment does not look correct.

Thanks for looking into this.

-ritesh


> so this as follow-up to patch 3?  Or maybe folded in?
>
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
> index a6ff42d7666c..27985210f972 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  	int lpid;
>  	struct kvm_nested_guest *gp;
>  	struct kvm_nested_guest *freelist = NULL;
> -	struct kvm_memory_slot *memslot;
> -	int srcu_idx, bkt;
>  
>  	spin_lock(&kvm->mmu_lock);
>  	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
> @@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  		freelist = gp->next;
>  		kvmhv_release_nested(gp);
>  	}
> -
> -	srcu_idx = srcu_read_lock(&kvm->srcu);
> -	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> -		kvmhv_free_memslot_nest_rmap(memslot);
> -	srcu_read_unlock(&kvm->srcu, srcu_idx);
>  }
>  
>  /* caller must hold gp->tlb_lock */
> 			
>
> [*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.com
>
>> In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i]
>> with kvm_empty_memslots and frees each memslot via
>> kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memslot_hv()
>> in arch/powerpc/kvm/book3s_hv.c:
>> 
>>     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
>>     {
>>             vfree(slot->arch.rmap);
>>             slot->arch.rmap = NULL;
>>     }
>> 
>> which frees the slot->arch.rmap array without freeing the linked
>> struct rmap_nested entries.
>> 
>> Previously, those entries were freed before memslot destruction via
>> kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
>> kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
>> 
>>     srcu_idx = srcu_read_lock(&kvm->srcu);
>>     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
>>             kvmhv_free_memslot_nest_rmap(memslot);
>>     srcu_read_unlock(&kvm->srcu, srcu_idx);
>> 
>> With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
>> kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
>> already been freed when kvmhv_release_all_nested() runs, so
>> kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
>> entries remaining in slot->arch.rmap at teardown (for example, when
>> KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return early,
>> or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte())
>> will be leaked.
>> 
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20261030212112.2598640-1-seanjc@google.com?part=12
>> 
