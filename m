Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D43A875A
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702631; cv=none; b=YxdrAWXKYaiUQpK4n1zHhzwp5HA3CTd8aXqa8AKY0K6P5fNm1+v161u3ZtvxNV9gR01fFjCUbSEoB/iPnqyncSrNOhH9ToxwO/qDwZvGwfW905YOPT4ajo748u7jtXfY8sUAvTX0dXb3VP8zzjm4alYLQJC4VjdZSYbMId/EAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702631; c=relaxed/simple;
	bh=vtEl5xEf5y3RfAf2BzauXUG3H+oFpxL3NGHfJCubqJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmx65F7wVocokny7W49CWNNxbQZbrJAw/gn/BSbW/reEQncjzLS1pV5lFSwdbdU52eW9GADsb91CzKFzDi0sQBk+7k+hDfdk7hM0ilbZtF7S7OKPmNMwY3AKnG8PsAxYUwaYHqhcUOHN+l3TqTns+5Yh5Of90PvlTk6uinO6cFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QOS1YNTy; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QOS1YNTy"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80032c08611so170835a34.3
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1789702623; x=1790307423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGpT7n4qfA4PKsft8AtVfWxQ1BUJiyj417wjUaj4GQw=;
        b=QOS1YNTyqfz4QtNURvFjHI11m6L2VfN0ubN8fDn4a2gUio1WsCG21Mgj0YRtZ9QXzN
         Xm43ik1R6612u3/AL1E3pfw1M4yPjt00DzYl33RSGKyfqJuFQXgaFpToVg94ollSPNba
         +VZTYjgb9+cy2sRILJ+58ahHDEl5+00N/bs4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702623; x=1790307423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGpT7n4qfA4PKsft8AtVfWxQ1BUJiyj417wjUaj4GQw=;
        b=TuGqA6bko5tj4g2zVoIkKI8SUvkvIZriOKfgoBE6IqEEhhv22LdOdzCQFsJEYJw/Ps
         6Xl6kVmfIOBhWZuJhhtWAg+9/NOdIA2iXdIxFdflNBtSzo04KhCEiDTB+ZDEwDCEZeB1
         c2Ka3ePQF7qt0wiPkehXumCvIcxfHD30n7A0UU1MuiYT1RWl5C7P3Osa0OHVe7dhPwCV
         DFMAMfwTRaPV1igA75+mx3pKJ90GKd2kEkGl8qyHir2AajvmXNV78enrStHTPjdiIDiV
         IQGAnbKIC+8L8ygAicIz5gwBYiAdRfr35wPheO8vOskBz5egxatrTiHkPfso6srjq/TT
         pPYw==
X-Gm-Message-State: AFuF++lVtfE9Jfw9jFw7BEPOEtYkeEphBlz5CLLAvOYeYvo3RWGE/JJa
	JK6Zfdmm0lkYFmyKyRMGikw7zZTf0u5ES6uEaMKf5MeZBRLppKaqhijBPMxBFQXAAD8fTjXeZ/3
	8YAYHC7k=
X-Gm-Gg: AYBFou0zbxZZrIanw+QG20XtHrcgS5JeKC//mbU2byAXGn31HaMpDxwLgasxT8tEDlI
	bbXKJaOWwLsWzyZzY5DPuU4Qpy31QBJM4soZO5cBPsJIdHg27N4mpUiJUum0TmCPwUPgRxEmN67
	lbkiV0NwqXlDgh3OnaRAL7jPulnMEI4An3g/zRHP+8BY5SLZCzvz5dwz/dSBAeGqnJLL5yvBlFw
	Cw9MR2MTDcxxZKBsofHsPGGmhlTREliPFaoKGAw/KOk3zyV8t03XQjs5lK8a3yVSjjPTgo5H7w7
	5IDqKxpapjQjaXpmESwArQF3tOzojkk2UTNuyqea30HEEZ71jcx+a30MnYgEJfNfUkAsgCujWsE
	rxwiALcgWI9eu7gDC4CjOtAsDJ26lAxbNvenE21+2GkPgLfWfJHtTM+9Hdo+ZbFHI+9NJK+OJn1
	JgDWXI4Z94RE3JHu7hd1wbpLetLf+noR5WtuFbeCbUMyqtrSnOLMzyx7C3TKRzYudDlygUq+CF8
	feAh6FnDTbtaISQXez9UsBbm2OD44qdUrEpP151qfw3AK7JF5MT8DJLUPzEr1OOW8Ii5rU=
X-Received: by 2002:a05:6830:3886:b0:80c:d30f:97d with SMTP id 46e09a7af769-80de33eccf5mr1585782a34.30.1789702623294;
        Thu, 17 Sep 2026 20:37:03 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e42815341sm422853a34.2.2026.09.17.20.37.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 20:37:03 -0700 (PDT)
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
Subject: [PATCH v4] KVM: x86: Restrict saved GPA writes to hardware write faults
Date: Thu, 17 Sep 2026 20:36:58 -0700
Message-ID: <20260918033658.21842-1-kylebot@openai.com>
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
alongside the saved GPA.  For guests without protected page tables, only
reuse that GPA for a write when hardware reported a write access.  Reads
and faults with unknown access direction do not authorize an emulated
write; fall back to the existing permission-aware translation in those
cases.

Keep the authorization across MMIO completion without decoding a new
instruction, and reset it when initializing a fresh emulator context.
This also covers writes reached through the cmpxchg fallback.

Preserve the shortcut for hardware-reported writes and for the read side
of read-modify-write emulation after such a fault.  For guests with
protected page tables, preserve the existing behavior and always allow
writes through the saved GPA.  An RMW instruction can fault on its
initial read, and KVM cannot walk the protected guest page tables to
check the subsequent write.

Track this property in common KVM state for SEV and TDX.  Also account
for legacy SEV initialization and encryption-context copies and moves.

Fixes: 0f89b207b04a ("kvm: svm: Use the hardware provided GPA instead of page walk")
Reported-by: Oleg Boiko <oboiko@openai.com>
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v4:
- Replace the SVM-specific check with has_protected_page_tables.
- Set the property for SEV/SNP and TDX guests.
- Cover legacy SEV initialization and encryption-context copy and move.
- Set EMULTYPE_PF_WRITE for both direct and indirect MMUs.

Changes in v3:
- Preserve saved-GPA writes for SEV guests, including RMW read faults.
- Drop the instruction-mutation and RMW read-access comments.
- Guard the SVM-private SEV helper with the host SVM capability check.

Changes in v2:
- Track saved-GPA access with an explicit access mask.
- Allow saved-GPA writes for any direct hardware write fault.
- Preserve read access on write faults for RMW emulation.

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/kvm_emulate.h      |  4 ++--
 arch/x86/kvm/mmu/mmu.c          |  3 +++
 arch/x86/kvm/svm/sev.c          |  4 ++++
 arch/x86/kvm/vmx/tdx.c          |  1 +
 arch/x86/kvm/x86.c              | 17 ++++++++++++++---
 arch/x86/kvm/x86.h              |  3 +++
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..285962b13e34 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1165,6 +1165,7 @@ struct kvm_arch {
 	u8 mmu_valid_gen;
 	u8 vm_type;
 	bool has_private_mem;
+	bool has_protected_page_tables;
 	bool has_protected_state;
 	bool has_protected_eoi;
 	bool has_protected_pmu;
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
index 064ecc33b926..504cc75d5155 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6632,6 +6632,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		return r;
 
 emulate:
+	if (error_code & PFERR_WRITE_MASK)
+		emulation_type |= EMULTYPE_PF_WRITE;
+
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
 				       insn_len);
 }
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..96a8700d3dae 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -560,6 +560,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	INIT_LIST_HEAD(&sev->regions_list);
 	INIT_LIST_HEAD(&sev->mirror_vms);
 	sev->need_init = false;
+	kvm->arch.has_protected_page_tables = true;
 
 	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
 
@@ -2036,6 +2037,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	unsigned long i;
 
 	dst->active = true;
+	dst_kvm->arch.has_protected_page_tables = true;
 	dst->asid = src->asid;
 	dst->handle = src->handle;
 	dst->pages_locked = src->pages_locked;
@@ -2907,6 +2909,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	mutex_unlock(&sev_mirror_lock);
 
 	mirror_sev->active = true;
+	kvm->arch.has_protected_page_tables = true;
 	mirror_sev->asid = source_sev->asid;
 	mirror_sev->fd = source_sev->fd;
 	mirror_sev->es_active = source_sev->es_active;
@@ -2965,6 +2968,7 @@ void sev_vm_init(struct kvm *kvm)
 		kvm->arch.has_protected_state = true;
 		fallthrough;
 	case KVM_X86_SEV_VM:
+		kvm->arch.has_protected_page_tables = true;
 		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
 		to_kvm_sev_info(kvm)->need_init = true;
 		break;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..b1163c580442 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -619,6 +619,7 @@ int tdx_vm_init(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 
+	kvm->arch.has_protected_page_tables = true;
 	kvm->arch.has_protected_state = true;
 	/*
 	 * TDX Module doesn't allow the hypervisor to modify the EOI-bitmap,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..70b83ccc7561 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5089,7 +5089,8 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
+	    emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5938,7 +5939,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
-	ctxt->gpa_available = false;
+	ctxt->gpa_access = 0;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6454,7 +6455,17 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			ctxt->gpa_available = true;
+			ctxt->gpa_access = ACC_READ_MASK;
+			/*
+			 * Always allow writes for guests with protected page
+			 * tables, as KVM can't walk the guest's page tables,
+			 * i.e. KVM can't get the RMW protections for a given
+			 * GVA to see if the write side of a RMW operation
+			 * should be allowed.
+			 */
+			if ((emulation_type & EMULTYPE_PF_WRITE) ||
+			    vcpu->kvm->arch.has_protected_page_tables)
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
