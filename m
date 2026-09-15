Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956C37B3F2
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511203; cv=none; b=IxRDJl+b8N/Ztd1P81Fv2X6vo24KqYL6LmZn1AZNPlccT8Vp0bDczrvlMUMLjXpYRKFrDfcUsm0hqimxFU4+5WKB02On4BmEghaPxPDqPFXB4SlBfHY6OhZfRCxshTbANnNecyf/Yk1rz90+B8x9H5TzfdIFeW8MME5FgK9oFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511203; c=relaxed/simple;
	bh=zxLy+RnMpqRbUGdUdac6Iud77IQK8Yqs4oc88eYHLd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o32xQE53x8uVriQi8GstB0E42M6xfyPUmZ3pN93EC7RUABKkc8cc/haJyep7YRG8MXq/k6MjF08MhGuIEzwE5a+AnTbB/u1USUWqoECpr7I62byA+TCasB+wrU989srePrxzd3n0dzrxSik/wa75unTGXNP4/y8ppiBatnpanLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YO9NN6/p; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YO9NN6/p"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fcb425fb68so156342a34.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1789511200; x=1790116000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYqZZKG/DZD/1X+PKCjxdvwrhTZwGcGfENkCwnFUN9Q=;
        b=YO9NN6/pNVPHT4vCN9miIIG8l+x9npScxmNMUEbfMwHmGA7JxbneYuqXYITuRmMlMx
         nqhyjIUDg9t8qDMcMAASSl1TEUL6D6AR6sbBejcSniqlJkO2gzJn4MpUUdk8nyn1QdMP
         X665Kbez/0WR4dpLKtc044XDv/LBesWs7csoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511200; x=1790116000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYqZZKG/DZD/1X+PKCjxdvwrhTZwGcGfENkCwnFUN9Q=;
        b=SFDn5dDITHvxim70Jox7YJhkriykR4TFE0CM5DOYUtROZYK75VQ/BmjKdyNy+eK9lT
         lNlDNWgLX6hqV35fsYm3FFzX8LQ99IP5Wt+ozLJFhKCVmLSVg1uVMiHaZ5uncDP1H83N
         4h01hW3U7yo3uv+gEJXotgOlYMeKbSfFZ846N0wd1827j2Y9XUPkwdaw83JGUwonj159
         zpAeC76Ouzb/zxqX41Mrfh4ZcWZFMX4ueMrURKH+QHZavTovx8vQP2ajt2QL2nhFVyLL
         X2++/KleWsqPztBezAj2BqmhbQjZcUNHLk53VDBxPu4ZIotFepJhP8ONPbdNAueB6GOj
         4/lw==
X-Gm-Message-State: AFuF++kdNXuR7JGjOg1OLKOkLRB9TghEpkvhP7Z3XGd8uzR8qjpFq4q0
	ChAoUQu16DdpWKiv1T2P91QHKgjjI5tTZqDmSujRKj8Rw+0oP68rF3GLaXeZ1W1nJmyvmTNF7O9
	ADQBHX1k=
X-Gm-Gg: AYBFou05LFG/CKhcxnNgaQIlbQjHs9VjxTpFHgQGzJ+qC/he+c5TF9AQVpU5ARL1MZ6
	eDymX2CKiFD4O+kxqnmmwTqbbgc4lqAVDWfZS9Y+pEOv7Aeww7p+HZFnds9OQPKTZUS9ve0jJQn
	ckomv+mtdVqJFTC1ViucqXDHfIxXBe4swjBcbyeTSqKudHcQ5WsvNvP8ZKE7j3u1sWaGOuLVwoF
	6Rx0SXCBXvA4B0pKk3ZeoU9qNEFG+VswtKuKtCzTaZvv0ggI6Y8r6otlkfBp1gZz6tJmlZF4EhF
	EAO/3K7U4Mdut+uBeoR8dwJxd5tNXVPRSQgcKBm3clkN7g9rOTTX8mrZkcg892JTjYZX95hK0dK
	5OBYd61a2BgepT6Z+ej5Q4zzWbMrhW7aqf+M7hame6nqy9wUDsbfUnuDECcsD2phJDWfDfN5T/p
	WmxcgFdEe+5FioG227QJgRn+pmPBMIDvKy4tYSp0yJX5nzxSFb7cdRKhshMaYF8qaKZXB56Shrf
	FKkQfThERDh5+DNr2oFs4Oa3o8zBhhCqLeGNGy1/7zOBpDXSz6xRqcr9Vy8pgKX3Bd5/vRzp92W
	OwmdS97PGA==
X-Received: by 2002:a05:6830:82e6:b0:7f6:4f6f:1a2 with SMTP id 46e09a7af769-80b2bb83b88mr505836a34.5.1789511200494;
        Tue, 15 Sep 2026 15:26:40 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b0668755esm673069a34.9.2026.09.15.15.26.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 15:26:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kyle Zeng <kylebot@openai.com>,
	Oleg Boiko <oboiko@openai.com>
Subject: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware write faults
Date: Tue, 15 Sep 2026 15:26:25 -0700
Message-ID: <20260915222625.99965-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GPA supplied by a hardware page fault describes the access that
faulted, not an arbitrary instruction decoded afterwards.  A guest can
change an MMIO read into a store before KVM fetches the instruction.  The
saved-GPA shortcut then skips the write-aware guest page-table walk and
can issue a write through a guest-read-only mapping.

Carry hardware write-fault information into the emulator and retain it
alongside the saved GPA.  For non-SEV guests, only reuse that GPA for a
write when hardware reported a write access.  Reads and faults with
unknown access direction do not authorize an emulated write; fall back
to the existing permission-aware translation in those cases.

Keep the authorization across MMIO completion without decoding a new
instruction, and reset it when initializing a fresh emulator context.
This also covers writes reached through the cmpxchg fallback.

Preserve the shortcut for hardware-reported writes and for the read side
of read-modify-write emulation after such a fault.  For SEV guests,
preserve the existing behavior and always allow writes through the saved
GPA.  An RMW instruction can fault on its initial read, and KVM cannot
walk the encrypted guest page tables to check the subsequent write.

Fixes: 0f89b207b04a ("kvm: svm: Use the hardware provided GPA instead of page walk")
Reported-by: Oleg Boiko <oboiko@openai.com>
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v3:
- Preserve saved-GPA writes for SEV guests, including RMW read faults.
- Drop the instruction-mutation and RMW read-access comments.
- Guard the SVM-private SEV helper with the host SVM capability check.

Changes in v2:
- Track saved-GPA access with an explicit access mask.
- Allow saved-GPA writes for any direct hardware write fault.
- Preserve read access on write faults for RMW emulation.

 arch/x86/kvm/kvm_emulate.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c     |  3 +++
 arch/x86/kvm/x86.c         | 19 ++++++++++++++++---
 arch/x86/kvm/x86.h         |  3 +++
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..10886bea82c9 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -354,8 +354,8 @@ struct x86_emulate_ctxt {
 	bool have_exception;
 	struct x86_exception exception;
 
-	/* GPA available */
-	bool gpa_available;
+	/* Saved GPA and permitted emulated accesses. */
+	u64 gpa_access;
 	gpa_t gpa_val;
 
 	/*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..95b9eac9962a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6632,6 +6632,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		return r;
 
 emulate:
+	if (direct && (error_code & PFERR_WRITE_MASK))
+		emulation_type |= EMULTYPE_PF_WRITE;
+
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
 				       insn_len);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..de7fc8efeadc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -33,6 +33,7 @@
 #include "lapic.h"
 #include "xen.h"
 #include "smm.h"
+#include "svm/svm.h"
 
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -5089,7 +5090,8 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
+	    emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5938,7 +5940,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
-	ctxt->gpa_available = false;
+	ctxt->gpa_access = 0;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6454,7 +6456,18 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			ctxt->gpa_available = true;
+			ctxt->gpa_access = ACC_READ_MASK;
+			/*
+			 * Always allow writes for SEV guests, as the guest's
+			 * page tables are encrypted, i.e. KVM can't walk the
+			 * guest's page tables and so must always use the GPA
+			 * from the initial fault.  Restricting use of the GPA
+			 * to the access type that faulted would prevent KVM
+			 * from emulating RMW operations for SEV guests.
+			 */
+			if ((emulation_type & EMULTYPE_PF_WRITE) ||
+			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
+				ctxt->gpa_access |= ACC_WRITE_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
 	} else {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..667465680ccd 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -407,6 +407,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
  * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
  *		 the CR2/GPA value pass on the stack is valid.
  *
+ * EMULTYPE_PF_WRITE - Set with EMULTYPE_PF when hardware reports a write access.
+ *
  * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
  *				 state and inject single-step #DBs after skipping
  *				 an instruction (after completing userspace I/O).
@@ -445,6 +447,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 #define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+#define EMULTYPE_PF_WRITE	    (1 << 10)
 
 #define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
 #define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
