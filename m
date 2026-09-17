Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D94A7C98
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639432; cv=none; b=VRisbSM4eK+jwQR8wDEQcHqxsW47+AnUT2OoyWJmktZqi+VIRL4qrwFnyYhFu0NA/slqoBLpeOrG/P+9n/8D6o4nA72fTnAe+2tQcgZX1J9rcRKK0lHfDIDsuSILw3J21A5I+smcADTry6qb4V8vOE2la3/hyos1t7sgspyHyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639432; c=relaxed/simple;
	bh=El1SDhqL0VkLIW5Sh+Zz192N587q+4iY48iKL8JBv0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVy8H9+NgBprmzw80JdnqMVPG0+scmBpw66MZ7z1uF58keQovOJmp6xkqMc/bspWI7IApai1lvMyC6mWabi0dRQt97vC5ZA/nj2tXq1CHJCc0oADdhLDDYHNLS/8kTcUMRp5swuC9oujkJDKcya1FS7d6P7IajUGnwP8Tnp/SUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEy6xpNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEy6xpNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789639403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EeBRoyZCve99duqFqW1lbroVXhrD9TMpia4ydx6eOvE=;
	b=WEy6xpNxINAYjhPqnX4x3YUtKC54z8fTVEt0ZOOglN3z/xiPzoYhFK8IBVQOZQbLDAFhys
	yqdPfNkfDX3J0UTHLHrTI8Tmf87PPdorAEzAYLd9HHI1rEib++0hIkOjAInhxtbC5joMSm
	Zx1MLcnDMg1mFHPdV37JKvZGtcLNPhM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-umu6d2ZXPQSGDaCFkK-lNw-1; Thu,
 17 Sep 2026 06:03:22 -0400
X-MC-Unique: umu6d2ZXPQSGDaCFkK-lNw-1
X-Mimecast-MFC-AGG-ID: umu6d2ZXPQSGDaCFkK-lNw_1789639401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FE8C1828ACB;
	Thu, 17 Sep 2026 10:03:21 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8FA11800370;
	Thu, 17 Sep 2026 10:03:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH] KVM: x86: remove "full" out-argument from flush_tlb_gva
Date: Thu, 17 Sep 2026 06:03:20 -0400
Message-ID: <20260917100320.21899-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The "full" out-argument in flush_tlb_gva is only ever set on AMD
processors, where the TLB flush is little more than a memory write and
thus extremely cheap anyway.

Simplify the code by letting the implementation of Hyper-V TLB flush
hypercalls always go through all the addresses queued in tlb_flush_fifo;
there are no performance concerns since that is already the case on
VMX, and also was on SVM prior to commit 26505e1b5b54 ("KVM: SVM: make
svm_flush_tlb_gva do a full asid flush if NPT enabled", 2026-08-06).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/hyperv.c           | 7 +++----
 arch/x86/kvm/mmu/mmu.c          | 2 +-
 arch/x86/kvm/svm/svm.c          | 4 +---
 arch/x86/kvm/vmx/main.c         | 4 ++--
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 arch/x86/kvm/vmx/x86_ops.h      | 2 +-
 7 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..283847619ff8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1578,7 +1578,7 @@ struct kvm_x86_ops {
 	 * Can potentially get non-canonical addresses through INVLPGs, which
 	 * the implementation may choose to ignore if appropriate.
 	 */
-	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr, bool *full);
+	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr);
 
 	/*
 	 * Flush any TLB entries created by the guest.  Like tlb_flush_gva(),
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 604651cb2739..3ee6bf35d1e4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1995,7 +1995,6 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
 	int i, j, count;
 	gva_t gva;
-	bool full = false;
 
 	if (!tdp_enabled)
 		return -EINVAL;
@@ -2006,7 +2005,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 
 	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
-	for (i = 0; i < count && !full; i++) {
+	for (i = 0; i < count; i++) {
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
@@ -2015,11 +2014,11 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		 * pages to flush.
 		 */
 		gva = entries[i] & PAGE_MASK;
-		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1 && !full; j++) {
+		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1; j++) {
 			if (is_noncanonical_invlpg_address(gva + j * PAGE_SIZE, vcpu))
 				continue;
 
-			kvm_x86_call(flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE, &full);
+			kvm_x86_call(flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE);
 		}
 
 		++vcpu->stat.tlb_flush;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..3d4c4937f679 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6704,7 +6704,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
-		kvm_x86_call(flush_tlb_gva)(vcpu, addr, NULL);
+		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 
 		if (tdp_enabled)
 			return;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea647938a2a6..835e59ca982c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4245,7 +4245,7 @@ static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	svm_flush_tlb_asid(vcpu);
 }
 
-static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva, bool *full)
+static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -4261,8 +4261,6 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva, bool *full)
 	}
 
 	svm_flush_tlb_guest(vcpu);
-	if (full)
-		*full = true;
 }
 
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d0786..0ff3230fd95e 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -543,12 +543,12 @@ static void vt_flush_tlb_current(struct kvm_vcpu *vcpu)
 	vmx_flush_tlb_current(vcpu);
 }
 
-static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full)
+static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	if (is_td_vcpu(vcpu))
 		return;
 
-	vmx_flush_tlb_gva(vcpu, addr, full);
+	vmx_flush_tlb_gva(vcpu, addr);
 }
 
 static void vt_flush_tlb_guest(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 504630f0eb40..e3bfe6aca1a0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3377,7 +3377,7 @@ void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
 
-void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full)
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	/*
 	 * vpid_sync_vcpu_addr() is a nop if vpid==0, see the comment in
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..cdb38d940cfb 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -82,7 +82,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 bool vmx_get_if_flag(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_all(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_current(struct kvm_vcpu *vcpu);
-void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full);
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr);
 void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu);
 void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
 u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
-- 
2.52.0

