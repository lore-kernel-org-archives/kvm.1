Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787C4014B8;
	Mon, 29 Jun 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739772; cv=none; b=E3wxKIUlhV5sueJnFsU11xug+Pq97yjK1xg5zU9YdPq7Ku79KEFvWPiryaFQQCJ2pSuwlkDIbEYvJkA5BiP8JU9oV8vJ0L7BkIyDTo0hdjuNZNGdfmIW6Hwd2jB1hZpaQcl2Tik2IM8wDOr7dhRgBowMJCdJ4XZ59PxLsOEjE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739772; c=relaxed/simple;
	bh=hHGkUIL3XbzTEtEdl2KLoIec5eWy0rJ8aTHDI8/RaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUHyi9dHngaeEtY6uzRfrpFeoP8PrNuf2NYkyc46JqGtFtuphic6uE4l/lnEJ2REJ1jZad90Kfi989/23htl9bURjBLozj2rQthQMFJwSfb90urqR6Rg3IWsmqI43p/uls8jsi7oyFODM/d/SyUV8CNMxBeOU91JSA8BzbmQwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTF5aPGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTF5aPGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE1B1F000E9;
	Mon, 29 Jun 2026 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739771;
	bh=k4fPROCs1/T0mIyB4kYzuUwM6bdcJBB7jz2kwBE/rvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTF5aPGs0GAgr49vmxLmdCLyXPRoSqAh1q0h0Enl0xSpL7g0EqH97VBO1BlJMXYF4
	 k9kWd/G9wptb3QSsCvDvGTBV/oH9GtxZPeLWxsAI2PiTDW3GAGho8BbmiJWtypGQt+
	 6AetcN/460T1pZi5sYDxqrn7rvtIwSMkYbGLPuBL3Z7d2xjVF8Kb+mC0SfxAESPYGK
	 UCqQdfbhOJZEVI/qHBKvIkDX8bZa3Ki0GQSfQVFeIqMxTOf/bpnBKba2EeurYPyeLI
	 KOVPZ09ZK7FgvM48rQeYcpNZWz7BsO72znMrQIUqNIPHQlmH/EEgqjIxakI9jIOIJq
	 fMroW9KzNm2Lg==
Date: Mon, 29 Jun 2026 18:57:32 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: SVM: Drop unnecessary avic_vm_destroy() call on
 init failure
Message-ID: <akJw3nXeWO-Xavc5@blrnaveerao1>
References: <20260625220933.3357733-1-seanjc@google.com>
 <20260625220933.3357733-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625220933.3357733-3-seanjc@google.com>

On Thu, Jun 25, 2026 at 03:09:33PM -0700, Sean Christopherson wrote:
> Don't bother calling avic_vm_destroy() when allocating the logical ID table
> fails, as there is nothing to clean up now that the physical ID table is
> allocated later, on-demand at first vCPU creation.
> 
> For all intents and purposes, no functional change intended, as calling
> avic_vm_destroy() is a big nop in this case.
> 
> Fixes: 54ffe74cc4ab ("KVM: SVM: Move AVIC Physical ID table allocation to vcpu_precreate()")
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

This LGTM, though I'm not sure this deserves a fixes tag.

FWIW, I have had a patch (part of a larger series I am going to post 
soon) to move the logical_id_table allocation alongside the physical ID 
table allocation. I'm fine if you want to queue your patch first, but 
this is what I have locally:

--
    KVM: SVM: Consolidate allocation of AVIC Physical and Logical ID 
    tables
    
    Allocate AVIC Logical ID table alongside AVIC Physical ID table
    allocation in avic_alloc_physical_id_table() so as to keep allocations
    of both AVIC related data structures together. Rename the function to
    avic_vcpu_precreate() to reflect when it is invoked since it no longer
    allocates only the Physical ID table. Convert avic_vm_init() to return a
    void since it can no longer fail.
    
    Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..722855be706f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -945,9 +945,9 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 bool __init avic_hardware_setup(void);
 void avic_hardware_unsetup(void);
-int avic_alloc_physical_id_table(struct kvm *kvm);
+int avic_vcpu_precreate(struct kvm *kvm);
 void avic_vm_destroy(struct kvm *kvm);
-int avic_vm_init(struct kvm *kvm);
+void avic_vm_init(struct kvm *kvm);
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
 int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
 int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0726f88e679a..fb5933c7421d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -293,7 +293,7 @@ static int avic_get_physical_id_table_order(struct kvm *kvm)
 	return get_order((__avic_get_max_physical_id(kvm, NULL) + 1) * sizeof(u64));
 }
 
-int avic_alloc_physical_id_table(struct kvm *kvm)
+int avic_vcpu_precreate(struct kvm *kvm)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 
@@ -303,10 +303,16 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
 	if (kvm_svm->avic_physical_id_table)
 		return 0;
 
+	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!kvm_svm->avic_logical_id_table)
+		return -ENOMEM;
+
 	kvm_svm->avic_physical_id_table = (void *)__get_free_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
 								   avic_get_physical_id_table_order(kvm));
-	if (!kvm_svm->avic_physical_id_table)
+	if (!kvm_svm->avic_physical_id_table) {
+		free_page((unsigned long)kvm_svm->avic_logical_id_table);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -328,20 +334,15 @@ void avic_vm_destroy(struct kvm *kvm)
 	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
 
-int avic_vm_init(struct kvm *kvm)
+void avic_vm_init(struct kvm *kvm)
 {
 	unsigned long flags;
-	int err = -ENOMEM;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	struct kvm_svm *k2;
 	u32 vm_id;
 
 	if (!enable_apicv)
-		return 0;
-
-	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!kvm_svm->avic_logical_id_table)
-		goto free_avic;
+		return;
 
 	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
  again:
@@ -360,12 +361,6 @@ int avic_vm_init(struct kvm *kvm)
 	kvm_svm->avic_vm_id = vm_id;
 	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
 	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
-
-	return 0;
-
-free_avic:
-	avic_vm_destroy(kvm);
-	return err;
 }
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6408c3e8419..a9a4fc105c6b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1308,7 +1308,7 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 
 static int svm_vcpu_precreate(struct kvm *kvm)
 {
-	return avic_alloc_physical_id_table(kvm);
+	return avic_vcpu_precreate(kvm);
 }
 
 static int svm_vcpu_create(struct kvm_vcpu *vcpu)
@@ -5302,12 +5302,7 @@ static int svm_vm_init(struct kvm *kvm)
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_PAUSE);
 
-	if (enable_apicv) {
-		int ret = avic_vm_init(kvm);
-		if (ret)
-			return ret;
-	}
-
+	avic_vm_init(kvm);
 	svm_srso_vm_init();
 	return 0;
 }



 - Naveen
