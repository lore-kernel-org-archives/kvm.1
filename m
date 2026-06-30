Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A962F8EB8
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853322; cv=none; b=fsemB8vYRVtxUOqKNgKyL0mOKWVtp7qDkWxsv8RiLJzEADPX4P9rQLc3W/bi7PfrjoMUfHPFVe0IS7Ix/3SmoAFtL98tbHP1AvgZg7mr9l8suVSjAM+J1UDLOL9d3eH/R4GgcfzRhegxg26KJyCiJV43+YLzVAYM2iqdXHeEaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853322; c=relaxed/simple;
	bh=pbC6R6FugF3jLSVxvh6S4MeaBJJSfum6aHXootXQ+ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMfWAe01kXdty9ntYl91WZ55NXnnJS7qaHWk2qi0Z4yMIaCpTPAJeg5M3m2+bkNCFNSlB/Dyecbgh43TYOqKxzITu1ozoS/gfRrabL/lJmUCC79hJfbtB5JlIXBiDwh9FUIswsPzm76OEXdzSFMoTDj5hcclxvbIT1AgJiHqKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BipbuYdr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BipbuYdr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38096457d3aso299436a91.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782853321; x=1783458121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/gPuMfRopVySKkSVF2U3+PoY6Wuy42Q7PfF0+cN84ds=;
        b=BipbuYdrcmvnduhci7bR+DMwaMehDaWzwq7myzIAkh4SDptn7xCrskN5PFwyoCZxAt
         mwjBYGNf3d+7RWssYKqKEnKmhR6VkvdN8DgGIWlPIdJxHKC5LZBvUB68EnnUJ7r7XqdO
         kcc9SU1HgKLhhhntgjUpv7DwesNYIRN9O5yKQ6a0DT+ym377Z2+huxcXYrjEiJjfltux
         LOmCAbV+UMH6RQTAGvx2DxFP3l+JWdKh6t1oOqSivDcdMxxkajDq5zfvmo1vrdTLXhD7
         WMTfib/9BIMNlPC3VmlkZm5e2mBgL/vJNomelZraAiY9dbnEvoMzDqwM5njywjtGSmay
         PUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853321; x=1783458121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gPuMfRopVySKkSVF2U3+PoY6Wuy42Q7PfF0+cN84ds=;
        b=AM+tl25VkN4I3iq7FVse/H06ZPCpWjP4xjlKMbJ5akUkMoIhCDwpnJll4T5O0IJROX
         dba70eKUZtNQeXuDH1zaa5ELoD7+HQLwrlrMMvwYU6B1oH3k2G29pULr6V1lizV4Bl35
         K25pVfrcChIkVmGZGenO4p/zVKoDltQ2hY2ChdJSdGYc7nbpM51Ucckq81NWEKKonxRK
         VmeeCgqoR5nXzXaQJQSmJPlq5js/ANIh2FHvhMMDK5HqGbIpnAIS7LObD5wzboe5Swlj
         9tmAk1GX7eZW5RLguuqhRGizzJitZMWQqrTI+1G9sRPUyKRRAGcVG5fyO+I7IkO3keM/
         mcvA==
X-Gm-Message-State: AOJu0YyS9St23prybwftVh6x+SjwgwqwqMmiHYocQyFgraxHXk7Ocw+Y
	B02khH9i+nszOTMAzwNiww8YHHnqUDX4RkkGuJkfmtPuL6XdGSU99BW5keFn/sISAA+6uiVI7kV
	5bK+b4w==
X-Received: from pjer23.prod.google.com ([2002:a17:90a:ad7:b0:36b:d248:5f89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:314e:b0:37f:b966:5f1b
 with SMTP id 98e67ed59e1d1-380525177e2mr4923601a91.4.1782853320547; Tue, 30
 Jun 2026 14:02:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:01:54 -0700
In-Reply-To: <20260630210156.457151-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630210156.457151-2-seanjc@google.com>
Subject: [PATCH v2 1/3] KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully
 AVIC specific
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Xiao Wu <xiaowu.417@qq.com>
Content-Type: text/plain; charset="UTF-8"

In anticipation of deferring all per-VM AVIC initialization until a vCPU
is first created, move SVM's kvm_x86_ops.vcpu_precreate() hook into avic.c
as avic_vcpu_pre_create() and nullify the hook if AVIC is disabled (and
WARN if the hook is somehow invoked without AVIC enabled).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 13 +++++++++----
 arch/x86/kvm/svm/svm.c  |  8 ++------
 arch/x86/kvm/svm/svm.h  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 58e493a80cb0..4a0a2dbd1687 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -293,13 +293,10 @@ static int avic_get_physical_id_table_order(struct kvm *kvm)
 	return get_order((__avic_get_max_physical_id(kvm, NULL) + 1) * sizeof(u64));
 }
 
-int avic_alloc_physical_id_table(struct kvm *kvm)
+static int avic_alloc_physical_id_table(struct kvm *kvm)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 
-	if (!irqchip_in_kernel(kvm) || !enable_apicv)
-		return 0;
-
 	if (kvm_svm->avic_physical_id_table)
 		return 0;
 
@@ -311,6 +308,14 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
 	return 0;
 }
 
+int avic_vcpu_precreate(struct kvm *kvm)
+{
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
+		return 0;
+
+	return avic_alloc_physical_id_table(kvm);
+}
+
 void avic_vm_destroy(struct kvm *kvm)
 {
 	unsigned long flags;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..a7d141f7e76c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1306,11 +1306,6 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 	svm->vmcb = target_vmcb->ptr;
 }
 
-static int svm_vcpu_precreate(struct kvm *kvm)
-{
-	return avic_alloc_physical_id_table(kvm);
-}
-
 static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
@@ -5333,7 +5328,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.emergency_disable_virtualization_cpu = svm_emergency_disable_virtualization_cpu,
 	.has_emulated_msr = svm_has_emulated_msr,
 
-	.vcpu_precreate = svm_vcpu_precreate,
+	.vcpu_precreate = avic_vcpu_precreate,
 	.vcpu_create = svm_vcpu_create,
 	.vcpu_free = svm_vcpu_free,
 	.vcpu_reset = svm_vcpu_reset,
@@ -5712,6 +5707,7 @@ static __init int svm_hardware_setup(void)
 	enable_apicv = avic_hardware_setup();
 	if (!enable_apicv) {
 		enable_ipiv = false;
+		svm_x86_ops.vcpu_precreate = NULL;
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..3c5459374969 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -945,7 +945,7 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 bool __init avic_hardware_setup(void);
 void avic_hardware_unsetup(void);
-int avic_alloc_physical_id_table(struct kvm *kvm);
+int avic_vcpu_precreate(struct kvm *kvm);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

