Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F333F5B4
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926004; cv=none; b=CkSdiV6elycidZKKkuNppbNhWG3x/J7nozYq6WOPna1uphrL53HzyRLOh2xjrgZc9tmyrXshoXjb3Cw044h7UA9/2nO1oEBEM5ka0KAa/IRnU8YyjmuJXAY1ohLdATskyOzBbnEcqS1voy/IhPsn4maURfHKTP/HNJa6lYbzaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926004; c=relaxed/simple;
	bh=z+1Wz9+DPxD65TmCQuzRccNFI/4SeWS3AgLc0eD4f34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIqI8pEs4pwiHpcs+1jBe66k7lORdf4Pyw1UJXgjEKHsvO+cDrRuBqF/h70K82Mbtjkwu3PYGzJ+OyvdjyOhcIThENz+OpV+WwI0m6RMWz/EC9umkiIPjqaWlVPxllwVjVBZVkI8Bvkw+kJHjGU+AiKDLqg3rETJciqRUivIVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIZKxC5j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIZKxC5j"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b68a33adso17130833a91.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779926002; x=1780530802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7Ev2ts7Jym1NJMb3G2uVBKct2ImZO6Q4kknAYq5ess=;
        b=hIZKxC5jnK/yUvmNWSGCY/TnZTVLb2zTJONADcQv1zg4uFh5TJMBY54dy2wdEXl60p
         1dlv4uGNqKeEd+m1FibmtLj9moUN+8W+0HFaw8zF4frsi5q70947K/q+hjpIM7dkFEE5
         X7zH7e5SWvNuo4CB+Am8RYj93qgJ0Kww7MXi/UnzJk0ndSDWslt5ZB3H9R6195HtIvJE
         25oRTE9aXoUCvgL4qQSZI9HbcuVjhLjIw7p0nYAmyMY+WHGBva7T2jeWhjPnR/tkvM+F
         /5LXrC6mEIGu06xiEA1QppP8CU/d3zJo/19tddeZH355+m5LxEB/i8r6PXCx2j3CC3Lk
         zgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779926002; x=1780530802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7Ev2ts7Jym1NJMb3G2uVBKct2ImZO6Q4kknAYq5ess=;
        b=LkODKMYt2slqGmcQbJLa1D6hk58Xat+4mYJ+y/TCF7vsckYJGbg21EmucSy4hDzlBZ
         pQroXUoRsws2OVCZe681cw4N1NOSu7eeBr6rwzrPign6fuaYYdT1F4MwDmXtP1psxaKY
         piFfE7LofrLZnw9Ed6zOVtaGSAfjy9uFXcDmPOgeWs3zRE560+NCxb5ND1+2SgkHk2RN
         Vt71+jB/pzULRK0y2vZ2TwYrpJuPnDeXueJ/ndebi+8KF5/WWsUzcPkvzwA7X4SW9aEy
         SHAPZY1Sq89HZYqMqsZqUBvYLzbvSNgewfxatHs12egm4X84a2VAdPhOJWQSOX5Bt5pY
         BlZg==
X-Forwarded-Encrypted: i=1; AFNElJ9GZGBmjuCQGkFkmMC0fMMVwTMGbekKiMmqBaDgoHhmjT+yarfb5JkFQKEHoPgEmMZI/tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGt1MWGd264mcRpDSpgziaOAFJ8kf75/ayxbiyyGexbZ5v6MW
	BT6okhV6tY8PLz6E50HgOaKqsDPPYjQcePl79mD0hgHKvPIbnXjvLVXSw3Tlv9Z4LXV0E1IVP52
	1x5OvtA==
X-Received: from pgjo19.prod.google.com ([2002:a63:e353:0:b0:c79:71c6:fd98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3647:b0:36a:8ce7:b879
 with SMTP id 98e67ed59e1d1-36a8ce7be66mr12851863a91.5.1779926001724; Wed, 27
 May 2026 16:53:21 -0700 (PDT)
Date: Wed, 27 May 2026 16:53:21 -0700
In-Reply-To: <20260527120600.20696-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527120600.20696-1-pbonzini@redhat.com> <20260527120600.20696-4-pbonzini@redhat.com>
Message-ID: <aheD8XjfMrL9wGFa@google.com>
Subject: Re: [PATCH 3/4] KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Paolo Bonzini wrote:
> When L2 runs under nested NPT and uses PAE paging, KVM's cached PDPTRs
> in mmu->pdptrs[] can hold stale or wrong values after nested
> transitions and across migration restore, because both
> nested_svm_load_cr3() and svm_get_nested_state_pages() only refresh
> PDPTRs on the !nested_npt path.
> 
> The user-visible bug is on migration restore of an L2 running with nested
> NPT and 32-bit PAE paging, if userspace uses KVM_SET_SREGS rather than
> KVM_SET_SREGS2.  In that case, load_pdptrs() leaves VCPU_EXREG_PDPTR
> marked as available, and kvm_pdptr_read() will use a stale translation
> that used L1 GPAs instead of L2 nGPAs.  svm_get_nested_state_pages()
> runs on first KVM_RUN but skips the refresh because nested_npt_enabled()
> is true.  The CPU itself reads L2's PDPTRs correctly from memory via
> L1's NPT, but KVM-side walking of guest PAE page tables uses the bogus
> cached values.
> 
> Unlike Intel's GUEST_PDPTR0..3 fields in the VMCS, SVM has no
> VMCB-cached PDPTR state: the in-memory PDPTEs at the current CR3 are
> the only source of truth, and svm_cache_reg(VCPU_EXREG_PDPTR) simply
> reloads them from memory via load_pdptrs().  Clearing the avail
> bit (and the dirty bit because !avail/dirty is invalid) to force
> a reload when PDPTRs as needed fixes the bug.
> 
> Do the same for nested_svm_load_cr3()'s nested_npt branch, so that
> the invariant "PDPTRs need reloading" is handled similarly for both
> immediate and deferred loading.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/kvm_cache_regs.h |  8 ++++++++
>  arch/x86/kvm/svm/nested.c     | 27 ++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 2ae492ad6412..6bae5db5a54e 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -77,6 +77,14 @@ static inline bool kvm_register_is_dirty(struct kvm_vcpu *vcpu,
>  	return test_bit(reg, vcpu->arch.regs_dirty);
>  }
>  
> +static inline void kvm_register_mark_for_reload(struct kvm_vcpu *vcpu,
> +					       enum kvm_reg reg)

I would rather use kvm_clear_available_registers() than add yet another API,
which isn't even a good fit here since SVM never expects the PDPTRs to be dirty.

Though I think it's a moot point, because nSVM should be clearing *all*
lazy-loaded registers.  It just so happens that PDPTRs are the only such "register".

I haven't checked to see if this would actually be correct, I'm just mimicking
the nVMX code.  But conceptually, I think we want something like so:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e74fcde6155e..0c6ab00766b1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1303,6 +1303,8 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 {
        svm->current_vmcb = target_vmcb;
        svm->vmcb = target_vmcb->ptr;
+
+       kvm_clear_available_registers(&svm->vcpu, SVM_REGS_LAZY_LOAD_SET);
 }
 
 static int svm_vcpu_precreate(struct kvm *kvm)
