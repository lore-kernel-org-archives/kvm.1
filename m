Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AB370AFA
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405453; cv=none; b=grsZvgjKkwwu1My8g4EMzwEcM8iuFRqyMLB4h40JSN1qHZd6XkWjZ3Z6rUfBU2B+N2v1aEFwMTbv7sUw8snBOsO2URKWiE1Rrl3tZYNaHJI3/qtyiJWf2pxk+hLCk2kAzv0h8opyqOtunknPWMXY6F9PXoYQLtiCeiHMnA+vIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405453; c=relaxed/simple;
	bh=Twi6LbeJb/qWz0kw5rs4LmRND6hdRFCsRXfOjFCgReU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVvd2nOp5u4qtky/hI1QMQ1SMkChw3ShRjo7omSLJTu09thuzdl79COg/mTTQWRI/PbWZ+GswoXklI2GY2SzSM+l82D66w371FC8toJqKg64RIhE7pRORlCL29Mf4mamzCN+KnpAWvGbpHPOUniKcFpn58i2fq87wro2sYp/juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/vOMnoG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/vOMnoG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b68a33adso10080243a91.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405451; x=1780010251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inUMdvUCNu2M2y+Grbjs2dQB2rkNDqtn35hXxq+mv+8=;
        b=v/vOMnoGKrW3OxjCaKp107IRkAfhta7i8KVbPusETRl4ei7R/KWOY8uPzdzRLQhQis
         YLe7g0COw3tG//35D7LJsbIfl2qxUAhyVETRLI68PPT0zfe4OKQQ8RvjBrm3f7uTvnZl
         CKx8lJDi/gv/GbL42lUL9BMQTbY2yOBc/KNmS2pY6GsLVK8P/FhJzviSu0yepjVbui0o
         hDv7BjfYlluHwBfrMG3C5TZKZtjtqRbTWgK5jrwR6iTSC6tQysoyAxJZXL4xYFYdUnPs
         U+DHsPvUeLasBriSIXXz4GA327vpBfWzmzNmrmkDRQ1OkFvcvPfcwTwRVg0jtOCoJxCJ
         rE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405451; x=1780010251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inUMdvUCNu2M2y+Grbjs2dQB2rkNDqtn35hXxq+mv+8=;
        b=cXwuw4WW3aR3XpFr5ND3WFkrkPEXf5GriU/QzMoulx/lk2DA5/iXHDmVcYxp+oQzFf
         WuT1ewdcLQociknlHZZR3ok29X+/rYDPHurUYmeda0sm44+0ys1fo1uw6f+JmWudWF/v
         6CWHZCewbSAFGxvv+9gTlaFMd+iEO3ejcGqiyuLlKuOMIbFKBsGjL2oUpMTmOO3vka3q
         vZa5nqtYQeReh5H4EXS5b3qnghjIxoMw3c9jOLV84xFVc+MDPjNVnHJv0WwL2jI+PkC7
         agRmWzLdUbL1ycLzw2jWh7YGZbuLqs0Bwoul5mJIUpQqiiz42fQVhG8kAdUFx8CVrMwh
         3vHA==
X-Forwarded-Encrypted: i=1; AFNElJ+x2jtWu0PPN3F9H3vC9fx4yMmmiB1wW48GIM5EXm+maYM8ajyEoiiTfU+GyDjp17QHJgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07+h13oNztLD9P31C7LxEU4A9Z920WOyF5Ib+nEfbto55r5ZF
	gup2/JLKfo6+1e2xU1btVWSVCGQYQyMKFcSClEynTMwd1zbrhcx+SzGLiGdlIF8HC4JMdMQZHco
	7ADsxZA==
X-Received: from pjbbk4.prod.google.com ([2002:a17:90b:804:b0:369:1a1a:82d5])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5284:b0:35f:b7f5:9b3
 with SMTP id 98e67ed59e1d1-36a67420e95mr1028347a91.3.1779405450507; Thu, 21
 May 2026 16:17:30 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:50 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=3213;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=YzcxNqD8InBoCzxGDzSUndemb08iklf9U0GqXNz3VQU=; b=20surOhD4fpUaOe9xSIctRm4Vjy3SYL4qB3WReCuRwhQNngpwUjkFV2A5i/tb/E9LKw8ys4fX
 L0TpMBGzsGeAzf1supT64zNI/9GaDxF6tC0cHq/KV43fM7x0SO3wAi4
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-9-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 09/22] KVM: selftests: Expose functions to get default
 sregs values
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
default values of certain sregs used by TDX VMs so they can be set
manually.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../testing/selftests/kvm/include/x86/processor.h  | 33 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 18 ++++--------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 0aa6eecfcbde..1ebf161ec5d0 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -29,6 +29,10 @@ extern u64 guest_tsc_khz;
 #define MAX_NR_CPUID_ENTRIES 100
 #endif
 
+#ifndef NUM_INTERRUPTS
+#define NUM_INTERRUPTS 256
+#endif
+
 #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
@@ -1562,4 +1566,33 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
 
 bool sys_clocksource_is_based_on_tsc(void);
 
+static inline u16 kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+static inline u16 kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+static inline u64 kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+static inline u64 kvm_get_default_cr4(void)
+{
+	u64 cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	return cr4;
+}
+
+static inline u64 kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 62abfe27fe3a..5027411665bf 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -15,10 +15,6 @@
 #include "tdx/tdx_util.h"
 #include "vmx.h"
 
-#ifndef NUM_INTERRUPTS
-#define NUM_INTERRUPTS 256
-#endif
-
 gva_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
@@ -647,16 +643,12 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs.idt.limit = kvm_get_default_idt_limit();
 	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
-
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	if (vm->mmu.pgtable_levels == 5)
-		sregs.cr4 |= X86_CR4_LA57;
+	sregs.gdt.limit = kvm_get_default_gdt_limit();
+
+	sregs.cr0 = kvm_get_default_cr0();
+	sregs.cr4 |= kvm_get_default_cr4();
 	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 	kvm_seg_set_unusable(&sregs.ldt);

-- 
2.54.0.746.g67dd491aae-goog

