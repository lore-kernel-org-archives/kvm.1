Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7B316905
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853324; cv=none; b=EGyeYpBTgvYRlH7ot+ilMvWi+TaOGWfHS5lYxAv3sEc3+HMtM57DNFu0OjaX3m3yNF+AyE3bsTSjep0PnARdgSpO1h+InqTEqoFRBAQY1S3ESzBoa1VhXfh16WhnxhjG95zMlzUOKTkYzbABajgjvO0Pl2EkD+pOv0r50WCDfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853324; c=relaxed/simple;
	bh=pHiaMaPKfZ+XS+g3wDeoa1u8Bp8Ey9bx49lJn7fXu5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMpnFoNlw54JXKnow+Jx/WXpQOtMQqX3eioEdlwu0JfZM3BKkdX11db9uPmbAz5KdofgTag9f9UQg9Y+jK/8xk5cvjXDofePnY8dqCCR+eBDL7/z9N7N29efihjjUHgY9Lq2opSwrI8mOANpaAjjPuyvIVvMKZAToGonHjjPiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAkEE8Gb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAkEE8Gb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c354050c34so33236775ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782853322; x=1783458122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oVa4bpsWu1aR9sIrcwkyGVMzb2qnAxW7RdDP4mEELrY=;
        b=HAkEE8GbU9gI6fXkeeKQfowEpRfoJocKOLarZA8vw28y1xEFB3Opys39delVIAq9gA
         yXbjtTmpne6ut1ufaYJ49IM+ja6HxabDoU+52taDkjo0Di4z5j0zPoLw8ih8EH7BkzbP
         x5RqkUu9xrVspoe+z0X8N2HVZUV1ODuFzxhmMUMYjhVmoRPdvBJgDRlSNxIwkXWg1fIq
         /7rQSrXwMbt3Q0rnpW3DvSu/6b5DMsqRbvVURfn+fyN0VeqxCMOyt229CC8kRjZnfCqJ
         GFqTFtsDyUspKGiMlbgU4bJ9WhfLUxGxZhRZi7lbKWWuUPuMbCiQVKD2TO952JDj7q9V
         FBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853322; x=1783458122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVa4bpsWu1aR9sIrcwkyGVMzb2qnAxW7RdDP4mEELrY=;
        b=emCOn5aViYu6hg5tjhx6Km20WipDkHcPylOevMmGREFzA+vBBhAWxd5dnaF4C2YEvI
         F5MpThGNm3Yfozllh879YfZM20Dxf1DavO6zX31q6WhBwPH1iEJVej28EIs4ORMSSuvU
         uTovPwy1HBoCJtnCcUfpkWzfjrdCm1okqUW+FP9ekrf+uJL4+8CQRQCriRL1EmcoL8ZV
         dRNcGj0w8Mb3SvTXBNtmXvVRZkmNmSTh+sygqavqtTfFU9oDSeeBYm2UYBvC0EKOSgKo
         10k96Lg3BhZ73gaiptLXR8jdfpceQJBnP4eIB7LclLpp29dCSU/v5arqJK8DhsIDX/+f
         AE1g==
X-Gm-Message-State: AOJu0YxNg3DIxX2D8QEYeAqgD6E/bhOwlp6CIeZ5ZM63x7TJiGQf157h
	leabEg51UHgfd962+z5S71pc+rQ9qpVDaN1dxrXZvaXAN6YvpjjY0GrAKFcIvwQ7rCYJLJcblJw
	dCzFAqw==
X-Received: from plll3.prod.google.com ([2002:a17:902:d043:b0:2bd:56ce:d8ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32ca:b0:2c9:97a7:b1e9
 with SMTP id d9443c01a7336-2ca5a610bcemr17910255ad.40.1782853321608; Tue, 30
 Jun 2026 14:02:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:01:55 -0700
In-Reply-To: <20260630210156.457151-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630210156.457151-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: SVM: Do all per-VM AVIC initialization during
 vCPU precreation phase
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Xiao Wu <xiaowu.417@qq.com>
Content-Type: text/plain; charset="UTF-8"

Move all per-VM AVIC initialization from VM creation to vCPU pre-creation,
i.e. defer allocating the logical ID table and adding the VM to the GA Log
list until vCPUs are created.  This will allow removing the VM from the GA
Log list before vCPUs are destroyed without needing yet another kvm_x86_ops
hook (.vm_pre_destroy() is very intentionally called if and only if VM
creation fully succeeds).

As a bonus, this re-unites physical and logic table allocation, and avoids
allocating a logical table in the unlikely scenario that userspace creates
a VM without an in-kernel local APIC.

Another bonus to hooking .vcpu_precreate() is that there is no need to
unwind on failure, as the VM has already been created, i.e. KVM will run
through all phases of VM destruction.  In fact, unwinding is undesirable,
as KVM tries to keep VM-wide behavior idempotent/sticky across creaton of
multiple vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 94 +++++++++++++++++++++++++----------------
 arch/x86/kvm/svm/svm.c  |  6 ---
 2 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4a0a2dbd1687..d71a2fed1a08 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -308,47 +308,32 @@ static int avic_alloc_physical_id_table(struct kvm *kvm)
 	return 0;
 }
 
-int avic_vcpu_precreate(struct kvm *kvm)
+static int avic_alloc_logical_id_table(struct kvm *kvm)
 {
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
-		return 0;
-
-	return avic_alloc_physical_id_table(kvm);
-}
-
-void avic_vm_destroy(struct kvm *kvm)
-{
-	unsigned long flags;
-	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
-
-	if (!enable_apicv)
-		return;
-
-	free_page((unsigned long)kvm_svm->avic_logical_id_table);
-	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
-		   avic_get_physical_id_table_order(kvm));
-
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
-	hash_del(&kvm_svm->hnode);
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
-}
-
-int avic_vm_init(struct kvm *kvm)
-{
-	unsigned long flags;
-	int err = -ENOMEM;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
-	struct kvm_svm *k2;
-	u32 vm_id;
 
-	if (!enable_apicv)
+	if (kvm_svm->avic_logical_id_table)
 		return 0;
 
 	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 	if (!kvm_svm->avic_logical_id_table)
-		goto free_avic;
+		return -ENOMEM;
 
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
+	return 0;
+}
+
+static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
+{
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+	struct kvm_svm *k2;
+	u32 vm_id;
+
+	lockdep_assert_held(&kvm->lock);
+
+	if (kvm_svm->avic_vm_id)
+		return;
+
+	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
  again:
 	vm_id = next_vm_id = (next_vm_id + 1) & AVIC_VM_ID_MASK;
 	if (vm_id == 0) { /* id is 1-based, zero is not okay */
@@ -364,13 +349,48 @@ int avic_vm_init(struct kvm *kvm)
 	}
 	kvm_svm->avic_vm_id = vm_id;
 	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
+}
 
+int avic_vcpu_precreate(struct kvm *kvm)
+{
+	int r;
+
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
+		return 0;
+
+	/*
+	 * Don't unwind on failure, all actions must be idempotent with respect
+	 * to creating multiple vCPUs, i.e. must persist until the VM is destroyed.
+	 */
+	r = avic_alloc_physical_id_table(kvm);
+	if (r)
+		return r;
+
+	r = avic_alloc_logical_id_table(kvm);
+	if (r)
+		return r;
+
+	avic_add_vm_to_ga_log_list(kvm);
 	return 0;
+}
 
-free_avic:
-	avic_vm_destroy(kvm);
-	return err;
+void avic_vm_destroy(struct kvm *kvm)
+{
+	unsigned long flags;
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+
+	if (!enable_apicv)
+		return;
+
+	free_page((unsigned long)kvm_svm->avic_logical_id_table);
+	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
+		   avic_get_physical_id_table_order(kvm));
+
+	if (kvm_svm->avic_vm_id) {
+		spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
+		hash_del(&kvm_svm->hnode);
+		spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
+	}
 }
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7d141f7e76c..7f3a815d737f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5297,12 +5297,6 @@ static int svm_vm_init(struct kvm *kvm)
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_PAUSE);
 
-	if (enable_apicv) {
-		int ret = avic_vm_init(kvm);
-		if (ret)
-			return ret;
-	}
-
 	svm_srso_vm_init();
 	return 0;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

