Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268635F60F
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932605; cv=none; b=ozmqh9z+tcyiTM61EFUP2PwI3t1kPTEYzxTpnuRwY9G8PR/aQRQjd6YVdyBkCQuQB61o4//TK3dqkvMvQTeizRRfHKMJWEdNDeWUN8dY9AqsLUrUajANBWaFd1HZQjAlgDn+DAZg1sx+gFgHGL/T2kElK+H6+hwUZ4nUchAAiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932605; c=relaxed/simple;
	bh=bwf3wgw8Ow9i7V6VSkZPObElrTqyQ9wXT8lgAru7010=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJYQb1oxUaXmWwjjkefEpHyQFKWqB2cCzYmzv9JZScZ/1LW/395dlcYoYmrIXwQtOcS3GmMQyCLpIp/51EYU5X/jidvNldwZyChyxT1H5Kix0/jjSRk5rzPqBaH1M01zwx4R/L5ZxVGUlnX2EDQvKTyQ1dPIqIg3ccX22Mijlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4uvyCH3; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4uvyCH3"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so956004a12.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784932602; x=1785537402; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gnNZYBG6kNExWwUYtiO9RXH6OHCACWNFg35dGbNpD4=;
        b=r4uvyCH3/e0RqjLWmb1DdbPZf3n5qbQoIQKZd1H6DivmLQf3sD3fLbBD4G7IPRHT8h
         4QHiPDFyp/jhIvzqjMLqMtjNdTeF2A965F1i3/UuoLHfV3T48TGoJwi55N3RKqs6zgQe
         e4Lf6I0A6hwH2Rt18bnEb4+f3JLz87xBz6sQ2Zm41qyhJhCkIGl/NpABzYqW2PE5sq2r
         QLmBZu+misKnQ40csN+xYdDX84TbyVRy9Vm134Zvn5J4keR8EIIBXxGbr0jlUidHQkGi
         rRCii+RCWSjfarFiNs2FwCVWbqvXfcRYblJLFsuNR/FpFXTTW0X78sf22Z8uTLycmrGi
         96ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932602; x=1785537402;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8gnNZYBG6kNExWwUYtiO9RXH6OHCACWNFg35dGbNpD4=;
        b=AgS4GQQ0xzbGBEL2vJMtwCWmGaJfafV6opxLrw8hJW8YvjkDG7j/OYNrDELExfcNWI
         5e5GoaDFSlxNimPwgbDjIeWOZiuemilNYCoA+3YKuEA1WNmIEfJplPSN8XMIaxGwT1Lz
         TFZwceBLtQ7CclDeR2LR0IJOGL4YmjHtFo6myMLR1oZpCAv6FOwa5Ap+kwn0I0K3toK9
         bTsB4g/XBd5g7Woh9xFQMT9En6DzCAxuYVD5iJZKxGjOMizAGzZSsfLvxzWGUTGWuTmu
         gWRgmvNLDUXF7xUqLO9t9aoj5VnxXNmOo+NprYtbuItZCaSGFGw86wpcPPvPVMH+yw//
         zcaw==
X-Forwarded-Encrypted: i=1; AHgh+Rrj/oOn3RyM4Z45MWSY9vj9sCNwwMZ9NLKC5KNlhObfn9DQAhV/WgMdScuSycuwu5g6jQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiRlgzRyNsX2yDO0j4eII9ut+KmfWvfZoxk7LTPTCD986JAk0
	KPwqcX2XH0SPkOHghp4GMWNxlFNMmjTBJnY60HyqPL0git/dvKAxlBfNakl65WXP+aiJrSuV0Ie
	vom7RfQ==
X-Received: from pgbgb9.prod.google.com ([2002:a05:6a02:4b49:b0:c8b:2b50:846b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e30b:b0:3c6:4b29:1181
 with SMTP id adf61e73a8af0-3c67e3d4671mr204069637.76.1784932602101; Fri, 24
 Jul 2026 15:36:42 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:36:41 -0700
In-Reply-To: <20260723094419.630204-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com>
Message-ID: <amPo-XdhFGIZquES@google.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Yosry, who has been digging deep on SVM TLB crud.

On Thu, Jul 23, 2026, Paolo Bonzini wrote:
> The flush is issued from kvm_hv_vcpu_flush_tlb(), which receives the
> cross-CPU requests from the Hyper-V TLB flush hypercalls via a kfifo
> and is invoked by the KVM_REQ_HV_TLB_FLUSH request.  The mechanism is
> the same for both Intel and AMD, and the handler for both vendors is
> a simple INVVPID(ADDR)/INVLPGA instruction.
> 
> Because the request is handled on the destination CPU, there is a question
> of what happens if the VM is migrated across physical CPUs.  In that case,
> the INVLPGA instruction would use a stale svm->vmcb->control.asid; but
> if anything that might do an *unnecessary* flush (on an asid that's being
> used for another VM) and then pre_svm_run() would force a full TLB rebuild.
> 
> So, for lack of better ideas, this patch forces a full ASID bump in
> svm_flush_tlb_gva().  To avoid paying the price on Intel and also to
> avoid unnecessary loops on AMD, the flush_tlb_gva op now returns whether
> it did a full flush or not; kvm_hv_vcpu_flush_tlb() takes note and exits
> its loops immediately.  While there is an obvious performance impact,
> about half of the benefit from Hyper-V tlbflush is preserved (10% vs. 20%
> on the SQL Server workload).
> 
> kvm_mmu_invalidate_addr() is the only other caller of the flush_tlb_gva op.
> The change would have a performance impact on every intercepted INVLPG and,
> for nested SVM, on every L1 INVLPGA.  For INVLPGA specifically, this covers
> the same suspected issue but for nested hypervisors, so it is correct to
> apply the workaround; for INVLPG on shadow paging, instead, the impact
> would be stronger and, due to lack of data, for now the use of INVLPGA is
> left in place in svm_flush_tlb_gva().
> 
> Analyzed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Analyzed-by: Alexander Lougovski <alougovsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/hyperv.c           |  7 ++++---
>  arch/x86/kvm/mmu/mmu.c          |  2 +-
>  arch/x86/kvm/svm/svm.c          | 27 ++++++++++++++++++++-------
>  arch/x86/kvm/vmx/main.c         |  4 ++--
>  arch/x86/kvm/vmx/vmx.c          |  2 +-
>  arch/x86/kvm/vmx/x86_ops.h      |  2 +-
>  7 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b517257a6315..eca04d4b974e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1751,7 +1751,7 @@ struct kvm_x86_ops {
>  	 * Can potentially get non-canonical addresses through INVLPGs, which
>  	 * the implementation may choose to ignore if appropriate.
>  	 */
> -	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr);
> +	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr, bool *full);

LOL, why on earth are you using an out-param?  If we do this at runtime, just
return a bool, at least that way we don't have to churn every call-site.

But I would much rather handle this by nuking .flush_tlb_gva at setup, e.g.


diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3776cf5382a2..4235331b71a0 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -61,7 +61,7 @@ KVM_X86_OP(flush_tlb_current)
 KVM_X86_OP_OPTIONAL(flush_remote_tlbs)
 KVM_X86_OP_OPTIONAL(flush_remote_tlbs_range)
 #endif
-KVM_X86_OP(flush_tlb_gva)
+KVM_X86_OP_OPTIONAL(flush_tlb_gva)
 KVM_X86_OP(flush_tlb_guest)
 KVM_X86_OP(vcpu_pre_run)
 KVM_X86_OP(vcpu_run)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..7b1c6391f878 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1978,7 +1978,8 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
        count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
        for (i = 0; i < count; i++) {
-               if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
+               if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY ||
+                   !kvm_x86_ops.flush_tlb_gva)
                        goto out_flush_all;
 
                /*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f0144ae8d891..bf16119640dc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6555,7 +6555,10 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
                if (is_noncanonical_invlpg_address(addr, vcpu))
                        return;
 
-               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+               if (kvm_x86_ops.flush_tlb_gva)
+                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+               else
+                       kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
        }
 
        if (!mmu->sync_spte)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c46a34aeb3df..9e04f016d939 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5688,6 +5688,15 @@ static __init int svm_hardware_setup(void)
        if (!enable_pmu)
                pr_info("PMU virtualization is disabled\n");
 
+       /*
+        * INVLPGA has had errata on Genoa and Turin, and even on older
+        * generations there were reports of Windows BSODs if INVLPGA
+        * was used for Hyper-V tlbflush.  Use it only for shadow paging
+        * where it seems to be okay.
+        */
+       if (npt_enabled)
+               svm_x86_ops.flush_tlb_gva = NULL;
+
        svm_set_cpu_caps();
 
        kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
