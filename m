Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DB38E121;
	Wed, 19 Aug 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118720; cv=none; b=AlhvdATrGP6Oa6EHvHrR5U0+ZrluM61EknL1L5JRZE+e6ZUrb5YXCNoxT5pwhzY5sPOLQNtpLXc9aA/yP9vMzMgyDaurW9PByoCkMWS4t6Ql69mgvcCb9DLFQqB23T3Qe0VhReJOQQKUovcTYmRFEy8s//N4F4AFtvrzs3b7OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118720; c=relaxed/simple;
	bh=GsnpkmCIPyv9ZAasBX9WcyUu+mWDeO7svIZ66F5oO5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUVBatN7VuDPx0ybL3d0LIzgT5vlTmnXdSjtEPtVXZRCaT58H9wreMeT4ej2GI7f4/b+uRiQ3dR8Fmf9wxX0ygexa9Yx4RgnHzGizvU4otduA/yuKhn9cHkikpLTNdOJO2Ym4Z2G3LtVLoNlM/yRaNh1nPrX+5oiXVYBSA7SST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07444032|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00615457-0.000311121-0.993534;FP=3346480228037516029|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ir-3HfY_1787118710;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ir-3HfY_1787118710 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 13:51:50 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v4 5/9] KVM: x86: Track emulator-originated nested #PF VM-Exits
Date: Wed, 19 Aug 2026 13:51:20 +0800
Message-ID: <e1860aaffc3a07d289dd083d2f3dd37b4d4bcc9c.1787116250.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add has_emulator_context to kvm_queued_exception to record whether a
queued exception VM-Exit originated from the current emulator exception.
This provenance allows nested virtualization code to determine whether
the emulator decode state can be used for a nested #PF VM-Exit.

Explicit provenance is needed because a matching emulator RIP does not
prove that the fetch cache describes the faulting instruction. For
example, completing pending emulated I/O can advance RIP while leaving
the fetch cache populated with the completed instruction.

Determine provenance in kvm_inject_page_fault() and carry it through
exception queueing so that it is stored as part of the nested VM-Exit
event. Userspace-injected and other unrelated exceptions leave the flag
clear.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..eb9f1b9afeb7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -688,6 +688,7 @@ struct kvm_queued_exception {
 	bool pending;
 	bool injected;
 	bool has_error_code;
+	bool has_emulator_context;
 	u8 vector;
 	u32 error_code;
 	unsigned long payload;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..75d00340c71f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -444,7 +444,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_deliver_exception_payload);
 
 static void kvm_queue_exception_vmexit(struct kvm_vcpu *vcpu, unsigned int vector,
 				       bool has_error_code, u32 error_code,
-				       bool has_payload, unsigned long payload)
+				       bool has_payload, unsigned long payload,
+				       bool has_emulator_context)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception_vmexit;
 
@@ -452,6 +453,7 @@ static void kvm_queue_exception_vmexit(struct kvm_vcpu *vcpu, unsigned int vecto
 	ex->injected = false;
 	ex->pending = true;
 	ex->has_error_code = has_error_code;
+	ex->has_emulator_context = has_emulator_context;
 	ex->error_code = error_code;
 	ex->has_payload = has_payload;
 	ex->payload = payload;
@@ -459,7 +461,8 @@ static void kvm_queue_exception_vmexit(struct kvm_vcpu *vcpu, unsigned int vecto
 
 static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 				   bool has_error, u32 error_code,
-				   bool has_payload, unsigned long payload)
+				   bool has_payload, unsigned long payload,
+				   bool has_emulator_context)
 {
 	u32 prev_nr;
 	int class1, class2;
@@ -473,7 +476,8 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	if (is_guest_mode(vcpu) &&
 	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
-					   has_payload, payload);
+					   has_payload, payload,
+					   has_emulator_context);
 		return;
 	}
 
@@ -519,7 +523,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, false, 0);
+	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, false);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception);
 
@@ -527,14 +531,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr,
 			   unsigned long payload)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, true, payload);
+	kvm_multiple_exception(vcpu, nr, false, 0, true, payload, false);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_p);
 
 static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
-				    u32 error_code, unsigned long payload)
+				    u32 error_code, unsigned long payload,
+				    bool has_emulator_context)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code, true, payload);
+	kvm_multiple_exception(vcpu, nr, true, error_code, true, payload,
+			       has_emulator_context);
 }
 
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
@@ -580,6 +586,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_complete_insn_gp);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
 			   bool from_hardware)
 {
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	bool has_emulator_context = ctxt && fault == &ctxt->exception;
+
 	++vcpu->stat.pf_guest;
 
 	/*
@@ -589,10 +598,12 @@ void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
 	if (is_guest_mode(vcpu) && fault->async_page_fault)
 		kvm_queue_exception_vmexit(vcpu, PF_VECTOR,
 					   true, fault->error_code,
-					   true, fault->address);
+					   true, fault->address,
+					   has_emulator_context);
 	else
 		kvm_queue_exception_e_p(vcpu, PF_VECTOR, fault->error_code,
-					fault->address);
+					fault->address,
+					has_emulator_context);
 }
 
 void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
@@ -627,7 +638,7 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0);
+	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, false);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_e);
 
@@ -8957,7 +8968,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	    kvm_nested_call(is_exception_vmexit)(vcpu, ex->vector, ex->error_code)) {
 		kvm_queue_exception_vmexit(vcpu, ex->vector,
 					   ex->has_error_code, ex->error_code,
-					   ex->has_payload, ex->payload);
+					   ex->has_payload, ex->payload, false);
 		ex->injected = false;
 		ex->pending = false;
 	}
-- 
2.43.7

