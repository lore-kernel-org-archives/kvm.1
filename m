Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A731AF3B
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853325; cv=none; b=EgFaophRLDjie60G5a6SelKP8YWW2Tz9bQ+6crCOfSxEkV0UgEMoqCdNGtB7XUF+a4FOXgDIhbd76/KpFIx9Y9hSgmcCiU6AmU55vq2JB8oso5Lx4okRKWkJtOwGn55KB2lz5cVRlJFXS1JG88XJ4HPr+iJW6YhDdzANphhMUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853325; c=relaxed/simple;
	bh=g/L3DJKrHg64nYCoxQJnLxJnhOFjR6s4vtRvxa4Qe6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FnO5AIMHByv2vUh6sAjk0X7Gd0/WnXnxXeGfjyXzYMBHy4JeIekgOMuG8NKhtm83XI9oq9R7tKA6JVFEHGOeFcg55J2uLuwVecEsnRGP9KXCXjCu+SxTxjQuR8+/u/EugS+eyGdFaCGALPHYRM72pzpWsf6tEC8vDmZAJD44ZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oOgrp5Fu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oOgrp5Fu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0331d0b1so36101085ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782853323; x=1783458123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm44LkpKzS920zpMLEvo1Va71SohrObzExpOrRG2/Y8=;
        b=oOgrp5FuspbAuzAph5V5SiN+683P1Y54ihGxKVq8pBbmMEKXVdpza5LfOxeJ624gdd
         mbkY1S8tI2KTbmGR9c+F0BjRfWG7CUIlPgppTo+RJ7AERXZGW+T1TwU5XCqdQ7Y5u9Eh
         rCTbNOcPYFkDO63K6eVDPxgYVwmXm8J+4a45STOBTy0MyBdhalVhOOU5MGQGDtvu7YZp
         3l3Oww4fCqoobu7yEJIUn2ueUfFaYfQka2RsoGtLYw+RlMNU6aPdDUKkBc2cpvdRoGXU
         AHHPAR0O6I+fbuV7q6GsWsUC1ejmCDCEYgY5AB9SenZVh4dqETHOmqHLkssu9nGOMyLP
         mUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853323; x=1783458123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gm44LkpKzS920zpMLEvo1Va71SohrObzExpOrRG2/Y8=;
        b=WT0ZEMM/qJdwJyDdLCkJd23UHuS2d+M2BJ7w0PXjusWESGNvp7hwfnxs2EXLPNSeyi
         49r76rTv7HhHLQdPYHhVvFex5r2T7Sl7uS2Jj29LgDqChIU/38G2U+bau4twtAbk/kHv
         57G8P65YeAAI014H+tTN/ucOBj0a6VaBCeEIG6g8aURAvmg6FlciSO+GtpX0zSPh/8Ha
         X2J5yyTgvlcUTi2y3+4bkyOtjdI1cDlEKGJcMSHWjBF+rPSCDpCA0p48pA+v1p1c9ChK
         kO/SrNtYc3OWIQvbC6iZCe3XYwAdx8XYMK/4teDe9h15qA1j2CB+Mvpe8quqkaa5JFih
         4eBg==
X-Gm-Message-State: AOJu0Yxnx1VuBSGbv22QnLfLKUdKZcdoDKa784X9cKfzEe5xX4km2r6l
	hh4focW9wEp1pbuOdX2+1gkcc+9pRjxdybFAJ7xmw5MN2DiEpewk4VTiXQuIJvccQqWM0P5nWof
	DK9mzew==
X-Received: from plbi11.prod.google.com ([2002:a17:903:20cb:b0:2c7:4399:f6c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b84:b0:2c9:97a7:3275
 with SMTP id d9443c01a7336-2ca5a638149mr16284935ad.38.1782853322795; Tue, 30
 Jun 2026 14:02:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:01:56 -0700
In-Reply-To: <20260630210156.457151-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630210156.457151-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: SVM: Remove VM from the GA Log notifier list
 before VM destruction
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Xiao Wu <xiaowu.417@qq.com>
Content-Type: text/plain; charset="UTF-8"

When a VM is being destroyed, delete it from the list used to process GA
Log interrupts before vCPUs are freed, otherwise avic_ga_log_notifier()
could theoretically hit a use-after-free if a GA Log notification arrives
for a vCPU after the last reference to the VM has been put.

Note, in practice, it's likely all but impossible to trigger UAF, as all
all irqfds and thus all IRTEs are cleaned up by:

  kvm_irqfd_release()
  |
  |-> irqfd_deactivate()
      |
      |-> irqfd_shutdown()
          |
          |-> irq_bypass_unregister_consumer()

And kvm_irqfd_release() is guaranteed to run before the last reference to
the VM is put.  KVM also configures GA Log interrupts only when a vCPU is
blocking (older versions of KVM configre GA Log interrupts at all times,
but AVIC is off by default on those kernels).  Hitting UAF would require
tearing down a VM shortly after a vCPU stopped blocking, and with a very,
very delayed IRQ from hardware.

Opportunistically use guard() to avoid a local "flags" variable.

Fixes: 5881f73757cc ("svm: Introduce AMD IOMMU avic_ga_log_notifier")
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Cc: Xiao Wu <xiaowu.417@qq.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 19 ++++++++++++-------
 arch/x86/kvm/svm/svm.c  |  2 ++
 arch/x86/kvm/svm/svm.h  |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d71a2fed1a08..c5b1d294b15a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -374,9 +374,20 @@ int avic_vcpu_precreate(struct kvm *kvm)
 	return 0;
 }
 
+void avic_vm_pre_destroy(struct kvm *kvm)
+{
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+
+	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
+		return;
+
+	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
+
+	hash_del(&kvm_svm->hnode);
+}
+
 void avic_vm_destroy(struct kvm *kvm)
 {
-	unsigned long flags;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 
 	if (!enable_apicv)
@@ -385,12 +396,6 @@ void avic_vm_destroy(struct kvm *kvm)
 	free_page((unsigned long)kvm_svm->avic_logical_id_table);
 	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
 		   avic_get_physical_id_table_order(kvm));
-
-	if (kvm_svm->avic_vm_id) {
-		spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
-		hash_del(&kvm_svm->hnode);
-		spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
-	}
 }
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7f3a815d737f..0e0dd9618750 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5329,6 +5329,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_size = sizeof(struct kvm_svm),
 	.vm_init = svm_vm_init,
+	.vm_pre_destroy = avic_vm_pre_destroy,
 	.vm_destroy = svm_vm_destroy,
 
 	.prepare_switch_to_guest = svm_prepare_switch_to_guest,
@@ -5702,6 +5703,7 @@ static __init int svm_hardware_setup(void)
 	if (!enable_apicv) {
 		enable_ipiv = false;
 		svm_x86_ops.vcpu_precreate = NULL;
+		svm_x86_ops.vm_pre_destroy = NULL;
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3c5459374969..616e45624f4c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -946,6 +946,7 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 bool __init avic_hardware_setup(void);
 void avic_hardware_unsetup(void);
 int avic_vcpu_precreate(struct kvm *kvm);
+void avic_vm_pre_destroy(struct kvm *kvm);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

