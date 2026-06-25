Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30B375F80
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425379; cv=none; b=euymd2dwNe5v/mDAdgWb3K1bzdCcduhuqd6gq99vInKrXKXVsGZY+/Cc+a4CQty+c5TrV1ae4pe5+AN3bJlTymuEZiMtmZ9tAlHuTo1H4oVPDgoS146HkkX2Mu6NoNPFMNPKuvI7Eg+rOGGO4Fmd5MhBA5We8uc09OkLEu5mqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425379; c=relaxed/simple;
	bh=Mo4M4KhIBki3hnrgcIgHI2OamzBV33d0O9pAF3lXGEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d36sy870Ow59eA885VYvoAleTHguFAbkGIUysR3Fc7YANnjIJitQx4Nv88EMjrky+e7m5G+/M/HiYyGlCpFaIUFEG0wpInsIOW9jOL0JnCNFq8vE06gVcC6i/bXlugO3gIXVLSEDVuPrb86IriebYrEyoeQAeOxhmqukG+o4Dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiLgxq+L; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiLgxq+L"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efbfb61so147272b3a.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425377; x=1783030177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqm4xqFqdHybDdimsg3P1RB+dpQZhiPi0ujTrPHTD3Y=;
        b=PiLgxq+Lj6LNcjoilAN1yGLe9ykHqZKuvwkU2H86eufmJolZpsyjtr1drEXokqT0UR
         noaTfuxbS42Tf0k6RSqBFVDly1urTUC9DfGD07zQWrFDeeOI5PdxUNa2TNYlyGdKj5Za
         S7KkRn4IEfVIODz++X+pEtF2+K0SOq5/f/KOLnY7RaU2EB+rFeEpsC+vupu++RgqSs7K
         MeeCbYn3ecu96nvRnjJ8LVj1LOXazh2ek7tPCoMvMqcpDAWXCyb+tQYA7Nqhi2MxMtj+
         gujgXOsPxHYI2nvWIGs3jC60hRyHsgKWWiCkFB2bfrjhHNcXpm67H3jtwjtNellq9zVh
         +/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425377; x=1783030177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqm4xqFqdHybDdimsg3P1RB+dpQZhiPi0ujTrPHTD3Y=;
        b=kHWOw0SbnnprwYKKhWQb4I3dK5vW5fHZzKv1cMYKK6jNma16hMU4uJGfy9FrO5Cwag
         vwm6zzfrxVi8tLANu4ermWoEzOYaxqDWJI1niGzLXhzzeP9yuMV3qMBn6CwNM5Fs9IUU
         hOCHXiORwrJpLP3uPrkyfEND/8Nt5AZIoBq9PcLZCF1AkyNCIDNb4xebywXUuDijUFCL
         oETZUfFWI96eWoszuthJjSY0xtnvfR2SUn1WmszD43r1Y/G2TVmuK+m/McrAfKJbggZC
         1f/I7AAbTqVK7FsSd3PiDXNUhqTbAq88oQIxEqY7NfaIqb+OXA2TIgCOWFeu2EC0on8q
         1bXw==
X-Gm-Message-State: AOJu0YxpOxzeSTcoontFyc5xwZG2Y8FR80DRA0yPzUFuI42/mGanDHYA
	R2NKqQajcImWG8G7g906MiJ8MxZVBYGQD1AUnxxiEOdik1wSHTkweZMM5U4NVA5qy0nw/aTRfqe
	pS5LHvA==
X-Received: from pgbdk2.prod.google.com ([2002:a05:6a02:c82:b0:c8b:fa4f:f001])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d05:b0:3b4:731e:6f95
 with SMTP id adf61e73a8af0-3bd4b2b2ae7mr5798276637.39.1782425376636; Thu, 25
 Jun 2026 15:09:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:09:32 -0700
In-Reply-To: <20260625220933.3357733-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220933.3357733-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220933.3357733-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: SVM: Remove VM from the GA Log notifier list before
 VM destruction
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When a VM is being destroyed, delete it from the list used to process GA
Log interrupt before vCPUs are freed, otherwise avic_ga_log_notifier()
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

Note, calling avic_vm_pre_destroy() if avic_vm_init() fails is unnecessary,
as the VM hasn't yet been added to the list (the VM structure is zeroed on
allocation, and so hash_del() is a nop).  In fact, doing avic_vm_destroy()
at all on init failure is unnecessary now that the physical ID table is
allocated elsewhere; that will soon be remedied.

Opportunistically use guard() to avoid a local "flags" variable.

Fixes: 5881f73757cc ("svm: Introduce AMD IOMMU avic_ga_log_notifier")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 15 ++++++++++-----
 arch/x86/kvm/svm/svm.c  |  2 ++
 arch/x86/kvm/svm/svm.h  |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 58e493a80cb0..6b100fb014a6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -311,9 +311,18 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
 	return 0;
 }
 
+void avic_vm_pre_destroy(struct kvm *kvm)
+{
+	if (WARN_ON_ONCE(!enable_apicv))
+		return;
+
+	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
+
+	hash_del(&to_kvm_svm(kvm)->hnode);
+}
+
 void avic_vm_destroy(struct kvm *kvm)
 {
-	unsigned long flags;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 
 	if (!enable_apicv)
@@ -322,10 +331,6 @@ void avic_vm_destroy(struct kvm *kvm)
 	free_page((unsigned long)kvm_svm->avic_logical_id_table);
 	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
 		   avic_get_physical_id_table_order(kvm));
-
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
-	hash_del(&kvm_svm->hnode);
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
 
 int avic_vm_init(struct kvm *kvm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..91b1e582d16f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5340,6 +5340,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_size = sizeof(struct kvm_svm),
 	.vm_init = svm_vm_init,
+	.vm_pre_destroy = avic_vm_pre_destroy,
 	.vm_destroy = svm_vm_destroy,
 
 	.prepare_switch_to_guest = svm_prepare_switch_to_guest,
@@ -5712,6 +5713,7 @@ static __init int svm_hardware_setup(void)
 	enable_apicv = avic_hardware_setup();
 	if (!enable_apicv) {
 		enable_ipiv = false;
+		svm_x86_ops.vm_pre_destroy = NULL;
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..a25f8994b877 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -946,6 +946,7 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 bool __init avic_hardware_setup(void);
 void avic_hardware_unsetup(void);
 int avic_alloc_physical_id_table(struct kvm *kvm);
+void avic_vm_pre_destroy(struct kvm *kvm);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

