Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE53B38BF
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058801; cv=none; b=HBXANDaevyyhGlQcA9jh2TIde9V0RHsMZu1BEGoSZ9msttgbBwo8P4/C7uNwUUInF6+cv/Hkw8YWp9pHDXH1UizUgn4qDwF6zVeEPLy4/RgQuHGdxEghjeiC8lMAcQMFKXF4R0FAJu4tORSV54+YrBUtau8alpJqJtbVYBFvJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058801; c=relaxed/simple;
	bh=MtoWeA55Bs2YjWy/YgwYvBdXP31YZOiX0PTrX4B18d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rubbA78RJKSQMr9yRJ2G8ZGzPiVVpAh06c1SX6N82+Gbyckld0IY75IJSkcoE4bA9j2tRVT/yn9ixMRWUOQXVuIsghbsIYLR0iYpbq8TQD++jccqFNxBPs4F0NPfh/LApJKI/fHq4YgeknkrhX6NlH54bUOysBQ+q/dhTxbqrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aG7d8IC4; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aG7d8IC4"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a6f4ba619so722727b3a.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789058793; x=1789663593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsW6Qm+aSslCH5e3RaevgVxgzzrweE8oFKyJCoFEERE=;
        b=aG7d8IC4FF0PMgQfjYp8hrJvorS062Yoo7NoVchEAOHoh673DnAYxMyvi37c5au/AQ
         fCjRSXGHsat/LcTdjl4trxkVvGH7VvP4yn9isXze+Z0r/1vmgwA4vSMPsgY1OkifSM6C
         /NHNlUPyASOS6FgpDGhxLN1NJ/8ifc137xNZ4Md3Lg/JelldGw8v6TbXadGTeo8WbC83
         79p1ZlnomWxKZg36O7jilSMyL2Z9oJZq2nNNPa6LSpSoQjhswQGGCyfAbLxSx7fGLQC8
         NGrHjScBkMUkiBsG5RScySCu00MyRPdBuOaPrcKWE0pUxmyLdArPyS/b1rSA08KqDwFP
         Gk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058793; x=1789663593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsW6Qm+aSslCH5e3RaevgVxgzzrweE8oFKyJCoFEERE=;
        b=AT+PUnyCmra1fmF+sxEtSGHsmDBXqTtGHJpPDrffEX/lJV7UAwuS811vlxRkxaDU6Z
         ma4J6eMhJKi7dIwrnKGOvH7UQBape9nODNhBvKXYK5q1KGPBo3CiacIbJIRNxEEIvgyG
         9yHfpzuh2KM6UkuPAmZdTnv5f+MZuIUS25p9AoLSDc3iO+Y5LBmiXcGoEzxyq/pLebke
         5ISoCLobDCOboY91S0x2uZsELKtvx0Jxb/JEMMvhgmPP+tKniL1Pfiyf4FKFki6T/8hk
         DiQswiEVYcKjiWXdgRav45Z0qQxqTxOMPtiM1gaCWGAnRKCJLqCteFfERJedQBaRkti/
         YeTg==
X-Forwarded-Encrypted: i=1; AKwUvBxm1/9oIwrWS4qgfk11QvBdHR2W2X5EyZBtfvpFVJM9JIwxF4dB82vY8EliN1mM7/7dNM4=@vger.kernel.org
X-Gm-Message-State: AFuF++n29lYj3d4+z7HB3l5T1sIePpCbZ/L1rpYJVix9M9sDUHdJ07WE
	Lsj5TrWX8ztPNkzMQqsgoA4Bgmb/bS7SxwpSK4ZsCCzygzr11adQTT3O1QQN+pf68Pfk+qqc3tF
	2MSRrDQ==
X-Received: from pgte26.prod.google.com ([2002:a65:689a:0:b0:cc4:bede:3dc7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b40a:b0:3d3:ae1f:d7f3
 with SMTP id adf61e73a8af0-3da3a0763d2mr68289720637.19.1789058792902; Thu, 10
 Sep 2026 09:46:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:46:32 -0700
In-Reply-To: <20260910162343.4092060-2-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <20260910162343.4092060-2-elver@google.com>
Message-ID: <aqLe6FcPZIgj2RA6@google.com>
Subject: Re: [PATCH RFC 01/10] KVM: x86/pmu: Acquire SRCU in
 pmc_is_event_allowed() to protect filter lookup
From: Sean Christopherson <seanjc@google.com>
To: Marco Elver <elver@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Marco Elver wrote:
> Dereferencing kvm->arch.pmu_event_filter via srcu_dereference() requires
> holding kvm->srcu to guard against concurrent filter replacement and
> freeing by kvm_vm_ioctl_set_pmu_event_filter().
> 
> Counter reprogramming can reach pmc_is_event_allowed() without holding
> kvm->srcu. Specifically, on AMD SVM, toggling EFER.SVME via KVM_SET_SREGS
> or KVM_SET_SREGS2 triggers synchronous counter reprogramming outside of
> any SRCU read-side critical section:
> 
>   kvm_vcpu_ioctl(KVM_SET_SREGS{,2})
>     kvm_vcpu_ioctl_x86_set_sregs{,2}()
>       __set_sregs_common()
>         kvm_x86_call(set_efer)()
>           svm_set_efer()
>             svm_pmu_handle_nested_transition()
>               __svm_pmu_handle_nested_transition(..., defer=false)
>                 __kvm_pmu_reprogram_counters()
>                   kvm_pmu_handle_event()
>                     reprogram_counter()
>                       pmc_is_event_allowed()
>                         srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu)
> 
> If userspace concurrently updates the filter (KVM_SET_PMU_EVENT_FILTER),
> a concurrent free and subsequent use-after-free is possible.
> 
> Protect filter lookups directly in pmc_is_event_allowed():
> 1. check rcu_access_pointer() first for the common fast path;
> 2. acquire guard(srcu)(&kvm->srcu) only when a filter is present;
> 3. drop redundant outer srcu_read_lock() in kvm_pmu_trigger_event().
> 
> Found with Clang context analysis.
> 
> Fixes: a02a25a65246 ("KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/x86/kvm/pmu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..3ad1e696edca 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -536,6 +536,11 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
>  	struct kvm_x86_pmu_event_filter *filter;
>  	struct kvm *kvm = pmc->vcpu->kvm;
>  
> +	if (!rcu_access_pointer(kvm->arch.pmu_event_filter))
> +		return true;
> +
> +	guard(srcu)(&kvm->srcu);
> +
>  	filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
>  	if (!filter)
>  		return true;
> @@ -1132,7 +1137,7 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
>  	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct kvm_pmc *pmc;
> -	int i, idx;
> +	int i;
>  
>  	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
>  
> @@ -1145,14 +1150,12 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
>  			     (unsigned long *)&pmu->global_ctrl, X86_PMC_IDX_MAX))
>  		return;
>  
> -	idx = srcu_read_lock(&vcpu->kvm->srcu);
>  	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
>  		if (!pmc_is_event_allowed(pmc) || !cpl_is_matched(pmc))
>  			continue;
>  
>  		kvm_pmu_incr_counter(pmc);
>  	}
> -	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  }

I would very strongly prefer to fix this in __set_sregs_common():

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 8f66438989e4..2ce16e96d796 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -571,9 +571,10 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 			      int *mmu_reset_needed, bool update_pdptrs)
 {
-	int idx;
 	struct desc_ptr dt;
 
+	guard(srcu)(&vcpu->kvm->srcu);
+
 	if (!kvm_is_valid_sregs(vcpu, sregs))
 		return -EINVAL;
 
@@ -605,13 +606,9 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	*mmu_reset_needed |= kvm_read_cr4(vcpu) != sregs->cr4;
 	kvm_x86_call(set_cr4)(vcpu, sregs->cr4);
 
-	if (update_pdptrs) {
-		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		if (is_pae_paging(vcpu)) {
-			load_pdptrs(vcpu, kvm_read_cr3(vcpu));
-			*mmu_reset_needed = 1;
-		}
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	if (update_pdptrs && is_pae_paging(vcpu)) {
+		load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+		*mmu_reset_needed = 1;
 	}
 
 	kvm_set_segment(vcpu, &sregs->cs, VCPU_SREG_CS);

>  
>  void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu)
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
