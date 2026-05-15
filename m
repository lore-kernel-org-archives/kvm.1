Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA53F788A
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884008; cv=none; b=lzQBZelqTErGzbDnPBPQysTE4SYLEMXgwwFQ+xffhn+7rEdp+mmHJo3SJj8Rk+xPrzM6ptsRbsLu+H45tBzGp8WDZpNFoWfT7rJ+jRM1w9aGw1VVKra4w7t4lIXxE+goq0KhT+XkrmVaMGIvTvbywEpY85MKJQX3txMEIEgE2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884008; c=relaxed/simple;
	bh=gjrJfPZjzhQ4ULgHXz7xKpU7NK6WzO2sZbl4EXGLNjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pf1Yscn6+1I5hqiEVq2FlfO6iIA0wQ0tAI6t8ucRQmZCcrNsQFgolQifiBMx7VnHqOtrTJR3ZmqWhEXp3RLeAy06jYvm2q7oNwdOypQ8koMze5cZ57CGZ3Lo2PCHJ0L9E4L7+a+e0MZWUz4MU+nmxKAAKINbTYIuPUqQnxwFOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ej/KFD6Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ej/KFD6Z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f85179263so441520b3a.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884004; x=1779488804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/ST410FWBR8XeDDgTjdEJIxkuKYadmvMFEj7n/DilPs=;
        b=ej/KFD6ZsA5h+9OR3cRwwJxYf73MFImswHu8otNuRQKPuJR/wOhg0xoYRlIrH10awT
         PavaALl4pd0PO1/evRVbuBlC++HBpmxmd7lXGm9M28yaOdGXN5tKL36zOhHEsUmoyp0r
         UPRG1HTiJSyCoY4fhwFO3NYCHdjNHaEzJI/S1I4tX8Tnrf13itr7PbGfrVlM4ybRVMdP
         23rUQDSXqbvM7jT3l+2W/HRZNuyBdvpD4Wd21xmblmK6UCxXCNCJjtvOa+WRvjW6va/H
         EkuGpc47ZjgKIwbRCjkfUDkvg43aOTBWxzYyGGXFw2uZhkYVijG6iy+ULP864ERbvgJp
         ZnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884004; x=1779488804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ST410FWBR8XeDDgTjdEJIxkuKYadmvMFEj7n/DilPs=;
        b=abof27qzd1fSF4egtJ3d/4Wdo8QRO9CzPfb1bW5vN1QIHpSyB+NMCNTGnwCf0eRfzn
         /t/Ma/xhp5ospEGsAboG+69dipRaxky/jN2XS1TyfoMhEIjGqZdfdjCYfe5Wxere+FVn
         cG2BwQ18xokHwNvbngVKFlGluoWHmFkk1qrpsYoFvuMi1VFsIJ4A6DwbYPzD97DkjDqF
         Frms2lnOO/7f3F6TKl24jIctXNgGOKGWoXRBmQ9K30QSf/UejIdZrDZJtpvqt6HSQE3A
         fIhOfxvX/dqUXMdPE3wkt4sufENvL+D2O8JA0MGTibnAXF7Y7dFKOi1ZOOUE9qGDyfUs
         4/WQ==
X-Gm-Message-State: AOJu0YzeT9iuXKkmUm5DMbJQgJs2FK0xaAuVGVPApUFVu7DEKuRqJseJ
	6z2xEVwtk3wLon74YfyKBQg8f0Bli0X7OOc9E+lXImSc0BI37zl/6oHF93Cgh79wksi3kh9h6ys
	jQpE1LQ==
X-Received: from pfam20.prod.google.com ([2002:aa7:8a14:0:b0:835:687a:d19d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:340c:b0:82c:6b46:271d
 with SMTP id d2e1a72fcca58-83f33d0a2e5mr6269542b3a.48.1778884004123; Fri, 15
 May 2026 15:26:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:32 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-5-seanjc@google.com>
Subject: [PATCH v3 04/10] KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when
 emulating MOV DR (in emulator)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

When emulating a MOV DR instruction, honor KVM_GUESTDBG_USE_HW_BP when
checking DR7.GD, and if there is a general-detect #DB, route it to host
userspace as appropriate.  Consulting only the guest's actual DR7 causes
KVM to fail to report a DR access to userspace (assuming the guest itself
doesn't have DR7.GD=1).

Fixes: ae675ef01cd8 ("KVM: x86: Wire-up hardware breakpoints for guest debugging")
Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: only expose effective DR7 to emulator, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c     |  2 +-
 arch/x86/kvm/kvm_emulate.h |  1 +
 arch/x86/kvm/x86.c         | 41 ++++++++++++++++++++++++++++++--------
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 510244555a74..917a521c299f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3848,7 +3848,7 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
 		return emulate_ud(ctxt);
 
-	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD)
+	if (ctxt->ops->get_eff_dr7(ctxt) & DR7_GD)
 		return emulate_db(ctxt, DR6_BD);
 
 	return X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index bb2a2aee0e13..33bfc9aa948e 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -215,6 +215,7 @@ struct x86_emulate_ops {
 	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
 	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
+	ulong (*get_eff_dr7)(struct x86_emulate_ctxt *ctxt);
 	ulong (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr);
 	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong value);
 	int (*set_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8a862d39302c..8b07bd2f8310 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1601,6 +1601,14 @@ unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dr);
 
+static unsigned long kvm_get_eff_dr7(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
+		return vcpu->arch.guest_debug_dr7;
+
+	return vcpu->arch.dr7;
+}
+
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
 	u32 pmc = kvm_rcx_read(vcpu);
@@ -8548,6 +8556,11 @@ static void emulator_wbinvd(struct x86_emulate_ctxt *ctxt)
 	kvm_emulate_wbinvd_noskip(emul_to_vcpu(ctxt));
 }
 
+static unsigned long emulator_get_eff_dr7(struct x86_emulate_ctxt *ctxt)
+{
+	return kvm_get_eff_dr7(emul_to_vcpu(ctxt));
+}
+
 static unsigned long emulator_get_dr(struct x86_emulate_ctxt *ctxt, int dr)
 {
 	return kvm_get_dr(emul_to_vcpu(ctxt), dr);
@@ -8930,6 +8943,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.get_cr              = emulator_get_cr,
 	.set_cr              = emulator_set_cr,
 	.cpl                 = emulator_get_cpl,
+	.get_eff_dr7         = emulator_get_eff_dr7,
 	.get_dr              = emulator_get_dr,
 	.set_dr              = emulator_set_dr,
 	.set_msr_with_filter = emulator_set_msr_with_filter,
@@ -8976,23 +8990,36 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 	}
 }
 
-static void kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
+static int kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
 {
+	struct kvm_run *kvm_run = vcpu->run;
+
+	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
+		kvm_run->debug.arch.dr6 = dr6 | DR6_ACTIVE_LOW;
+		kvm_run->debug.arch.pc = kvm_get_linear_rip(vcpu);
+		kvm_run->debug.arch.exception = DB_VECTOR;
+		kvm_run->exit_reason = KVM_EXIT_DEBUG;
+		return 0;
+	}
+
 	kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
+	return 1;
 }
 
-static void inject_emulated_exception(struct kvm_vcpu *vcpu)
+static int inject_emulated_exception(struct kvm_vcpu *vcpu)
 {
 	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
 
 	if (ex->vector == DB_VECTOR)
-		kvm_inject_emulated_db(vcpu, ex->dr6);
-	else if (ex->vector == PF_VECTOR)
+		return kvm_inject_emulated_db(vcpu, ex->dr6);
+
+	if (ex->vector == PF_VECTOR)
 		kvm_inject_emulated_page_fault(vcpu, ex);
 	else if (ex->error_code_valid)
 		kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
 	else
 		kvm_queue_exception(vcpu, ex->vector);
+	return 1;
 }
 
 static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
@@ -9501,8 +9528,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				 */
 				WARN_ON_ONCE(ctxt->exception.vector == UD_VECTOR ||
 					     exception_type(ctxt->exception.vector) == EXCPT_TRAP);
-				inject_emulated_exception(vcpu);
-				return 1;
+				return inject_emulated_exception(vcpu);
 			}
 			return handle_emulation_failure(vcpu, emulation_type);
 		}
@@ -9597,8 +9623,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (ctxt->have_exception) {
 		WARN_ON_ONCE(vcpu->mmio_needed && !vcpu->mmio_is_write);
 		vcpu->mmio_needed = false;
-		r = 1;
-		inject_emulated_exception(vcpu);
+		r = inject_emulated_exception(vcpu);
 	} else if (vcpu->arch.pio.count) {
 		if (!vcpu->arch.pio.in) {
 			/* FIXME: return into emulator if single-stepping.  */
-- 
2.54.0.563.g4f69b47b94-goog

