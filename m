Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C53F5BFE
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884005; cv=none; b=ba1Hd8pTFvdQIWlUgu0B4BD6tRzE0N1QY97rSrbSCatwiwHvUkdO/k/p3doFePvwj3S3+EJZLjUQERkCg+jgKOak+Peft/0TEaeqBUlx32ffjaXPQ38q7IsnouLfFWZik5IUrRexpK8rPbYAP4e1NDJvca/3UPUmXmbChcmoFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884005; c=relaxed/simple;
	bh=jqCUnAqyL81M4kBExO5xbTXvD8p/BANrb5UK56gpGsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azp0VPBX2jySKblDvkb50un5FpgBMHJupkuP2rQPQS4li6Wtg6XcH01GXWsYB2d67MSNc8zl1wzVhO0CPVH0PtsGqrx+H5H2GyiOdXAYC4YLhXsrfKP1UrEngmRnpPF/y0uSujVircBbJLfIbzW0ZT/tGOOEvglP7fWe76k5sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2AcBPIt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2AcBPIt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7aba0af02so4555915ad.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884003; x=1779488803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QKbnE6rd81y7hUrM+ehlz5d1YI3KnWTK03MZ9lCKq6s=;
        b=M2AcBPItnKOZivRecvUxUD2tKNsd54R6ENgeDM8XEE20rCQ6BdqMHURMa/HOj3erTc
         uhBafHdyGsTMmY52XWAOLTupM4ZOmUZrCxuj/yQHbkPNDXUQARqotmm1iia7/7DUl8g4
         m3ELuTn+dR6lA2gE63udpIrlDOA16VT1cRGA4SbjTQpmYVcJO0fF5O6akg2VCWdrAGpJ
         yXRMrQVT0yjdrxpRnKvIBCjgpcgBADks2hXRkhEoRXlm7WbvV4HncLd/0DtV3CMJABJ5
         N/rT9qWgn7m7HYTM478HHOjAUAcGoZpTY0B1ORqM8oIC/QOadjyfnpxjUNBFznqnSM85
         KZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884003; x=1779488803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKbnE6rd81y7hUrM+ehlz5d1YI3KnWTK03MZ9lCKq6s=;
        b=sUx1JKivbwgcVDXMLiS7uvi2Jahe+1jVO808iqUQ0AEf20+28rnSKUcBDTcU3oikAi
         j7rmEcroB7EEMbpwtJYVFB8JJrMBXBQC3faZqrSgaJXC0mqJjPcUMYSy5IFPjCtA/3+0
         a4gEUbqQ/vKfofQCkhG+fMhUFpy4CAaW1mtgTw/jAd5c7DI9jOETnCySQRG5s+71zhjM
         AR+lFoIuqOkloFLctiK0apAydNpq9H/rCbxjFwI71DLRhV+HPZPrab98LwdrH8w/ewjt
         PUa429T80IQRBEIHuoeaHHIRjouio4WHi4itWgGFlt3kGteDWB0U9lE1qzah4KtDGzv3
         Md8g==
X-Gm-Message-State: AOJu0YySUOmzwT6HzQfyVpTBNq0iz5k1qsKjG/zr41aI76KSVreBJA1y
	LKa2kieHQRozLpRitnqvVcV5d2xcS2bMb03+iCQH9th/i5DsxviJ0P63q52/ZaW4mifLjBuSpsX
	kcQFBlw==
X-Received: from pgbcq9.prod.google.com ([2002:a05:6a02:4089:b0:c76:6a98:b777])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d95:b0:3a3:aeb2:73c9
 with SMTP id adf61e73a8af0-3b22e773031mr6641847637.22.1778884003051; Fri, 15
 May 2026 15:26:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:31 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-4-seanjc@google.com>
Subject: [PATCH v3 03/10] KVM: x86: Set guest DR6 by kvm_queue_exception_p()
 in instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

Record DR6 in emulate_db() and use kvm_queue_exception_p() to set DR6
instead of directly using kvm_set_dr6() in emulation, which keeps the
handling of DR6 during #DB injection consistent with other code paths.

No functional change intended.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: fix e vs. p goof, add kvm_inject_emulated_db() right away]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c     | 14 ++++----------
 arch/x86/kvm/kvm_emulate.h |  6 +++++-
 arch/x86/kvm/x86.c         | 10 +++++++++-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8c6cc0406d6..510244555a74 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -540,8 +540,9 @@ static int emulate_exception(struct x86_emulate_ctxt *ctxt, int vec,
 	return X86EMUL_PROPAGATE_FAULT;
 }
 
-static int emulate_db(struct x86_emulate_ctxt *ctxt)
+static int emulate_db(struct x86_emulate_ctxt *ctxt, unsigned long dr6)
 {
+	ctxt->exception.dr6 = dr6;
 	return emulate_exception(ctxt, DB_VECTOR, 0, false);
 }
 
@@ -3847,15 +3848,8 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
 		return emulate_ud(ctxt);
 
-	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD) {
-		ulong dr6;
-
-		dr6 = ctxt->ops->get_dr(ctxt, 6);
-		dr6 &= ~DR_TRAP_BITS;
-		dr6 |= DR6_BD | DR6_ACTIVE_LOW;
-		ctxt->ops->set_dr(ctxt, 6, dr6);
-		return emulate_db(ctxt);
-	}
+	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD)
+		return emulate_db(ctxt, DR6_BD);
 
 	return X86EMUL_CONTINUE;
 }
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..bb2a2aee0e13 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -24,7 +24,11 @@ struct x86_exception {
 	bool error_code_valid;
 	u16 error_code;
 	bool nested_page_fault;
-	u64 address; /* cr2 or nested page fault gpa */
+	union {
+		u64 address; /* cr2 or nested page fault gpa */
+		unsigned long dr6;
+		u64 payload;
+	};
 	u8 async_page_fault;
 	unsigned long exit_qualification;
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ddb878934ed..8a862d39302c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8976,11 +8976,18 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 	}
 }
 
+static void kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
+{
+	kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
+}
+
 static void inject_emulated_exception(struct kvm_vcpu *vcpu)
 {
 	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
 
-	if (ex->vector == PF_VECTOR)
+	if (ex->vector == DB_VECTOR)
+		kvm_inject_emulated_db(vcpu, ex->dr6);
+	else if (ex->vector == PF_VECTOR)
 		kvm_inject_emulated_page_fault(vcpu, ex);
 	else if (ex->error_code_valid)
 		kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
@@ -9025,6 +9032,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 	ctxt->interruptibility = 0;
 	ctxt->have_exception = false;
 	ctxt->exception.vector = -1;
+	ctxt->exception.payload = 0;
 	ctxt->perm_ok = false;
 
 	init_decode_cache(ctxt);
-- 
2.54.0.563.g4f69b47b94-goog

