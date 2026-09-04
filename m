Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8D327C18
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481491; cv=none; b=Yzi+roBv8LxBRrDCd7oaw+yZ/j7yeG9oGZSLeR58GCgGFvcw5FRj8pBY9vGlBd/xlGG8pnBvxnRCg27mdvkqFQWzo4Ox5fm0dAexAmtbgXyxTuIk8HxdAqSh8sMwty4mIOrP/7qPYuuK/RRzN0ROLkCYUR1T8nY3uCIM2bny84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481491; c=relaxed/simple;
	bh=nIh+VB4EjbMHRVZbj5aW5Kwq70HSg9OREbwMKl7LPSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6kW3+9zJnILnpxhz2XZXmxmIPmWQi1Wz4HOA+Ig2akD3+eTZIgs9ii+oRey8oUGnPpMGrjOfTkSpIJI6LgMY96Tx0g7xnwYzCnGhem1UvNyGpWNMeqGbaVeB+HNta9zXglpO6qOlgzEHT6LJj/RDrf3ZJ3F6g67rU1N03I2w8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2gO1rD7; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2gO1rD7"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-85599cf98e5so694851b3a.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481486; x=1789086286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fobeK2AzEKwQOMdkiKT8N96SjHDY9A8YvJp1nlyUn/I=;
        b=j2gO1rD7YEE/Y5RgVZt6hkgg/s8+pZkRJ+4Q5+0iQtBpRIsn4/xeQfwd0QmpM4zh6a
         BUP6w42MfaL8bzpAVBbs+sU5qlhET3uWWOdJlBPZcDcdSpAbDLXKP6m4I7zFqV+wJVbo
         +oA1ps6rJzasbSQ1FfiE3+pzah2e64pOVeUk2OgqA0SoWu0Q1Nm2L2mpBqgh/uUjUS3n
         0h5SXKdasojUbcorVvGRW+Lc7NE9uMp020TNyfpEqGY5ux6l+b1i4CzCrnSHhJf2qFhE
         ZVpYWF8urZib2S/FxLuJJqWsIhwZHhr8OBvfheIt4S3pm2dCeJrNRLdsMVfPCo+Rl9JU
         B9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481486; x=1789086286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fobeK2AzEKwQOMdkiKT8N96SjHDY9A8YvJp1nlyUn/I=;
        b=GZ+xKYTfvyLKOl6r8HYDk20HfJxD1GBxH3z5/ZdPq/wss5UWDgRcwDV7tBvJfNg9mr
         UtN6RyrCCm1zJxdE0tXTIjPc9MBY5qT28bqu034dNTpkmiN1AnXYvzJ/YlNpa/PDLu2N
         s+ISRWB7X916nkXsHeAOK7cliG0heKSqqcBkCDQoWqcI7xt+VeXZ4gV8kSIFetZTqG81
         OR3c6pZTKr0J2915KgAcoSTpodUPuApmF6LjZyZEoV17d0VNiyihjm3OSZf95igf/rbZ
         s1puI3Blk8mm+fZr5woOM3/Cfeeutfy/mVMtZt3MNIcLdtVSnhWG1hgfkurCgUq4q2c2
         6dwQ==
X-Gm-Message-State: AFuF++mS85YpAB4ScB6M6M7sI9vKAsobcZBhVqd+siFz7bt+CWkJ35z6
	b5DcYqzlH8SwHZ62dqHOxxHUlWyssxA3ptpmhJgqEDyU730YV5FgqXSmIl58xhhLbd2S52Wpqqz
	m7gNoXg==
X-Received: from pfblc11.prod.google.com ([2002:a05:6a00:4f4b:b0:84e:2062:2edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4290:b0:85c:2d83:bbf1
 with SMTP id d2e1a72fcca58-86168e8bc6emr3427066b3a.20.1788481485393; Thu, 03
 Sep 2026 17:24:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:23 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-18-seanjc@google.com>
Subject: [PATCH v4 17/17] KVM: selftests: Always assert that vmreadz() succeeds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Rename vmreadz() => vmread() (and vmread() => __vmread()) and have it
assert success instead of returning garbage on failure.  While the eVMCS
path avoids clobbering *value on failure, the VMREAD path unconditionally
stores tmp to *value, without ever zeroing tmp.  I.e. if VMREAD did fail,
*value would be loaded with random stack data, not '0'.

An audit of the code confirms that nothing is actually relying on vmreadz()
to zero the result on failure, as all paths either check for a non-zero
value, propagate the result into vmwrite(), or guard the vmread() with a
pre-check that the field exists.

Opportunistically fix the bug in what is now __vmread(), so that the code
isn't consuming uninitialized stack data.  Begrudgingly keep zeroing
value in vmread(), as gcc-15 at least isn't smart enough to figure out
that value won't be used uninitialized (though to be fair, strictly
speaking it isn't actually unreachable code).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 15 +++---
 .../testing/selftests/kvm/lib/x86/memstress.c |  2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 52 +++++++++----------
 .../selftests/kvm/x86/aperfmperf_test.c       |  2 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 24 ++++-----
 .../selftests/kvm/x86/nested_dirty_log_test.c |  2 +-
 .../selftests/kvm/x86/nested_emulation_test.c |  8 +--
 .../kvm/x86/nested_exceptions_test.c          | 10 ++--
 .../kvm/x86/nested_invalid_cr3_test.c         |  6 +--
 .../selftests/kvm/x86/nested_tdp_fault_test.c | 10 ++--
 .../kvm/x86/nested_tsc_adjust_test.c          |  4 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |  6 +--
 .../kvm/x86/save_restore_pf_stress_test.c     |  4 +-
 tools/testing/selftests/kvm/x86/state_test.c  | 24 ++++-----
 .../kvm/x86/triple_fault_event_test.c         |  2 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  | 12 ++---
 .../kvm/x86/vmx_apicv_updates_test.c          |  8 +--
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |  6 +--
 .../kvm/x86/vmx_nested_la57_state_test.c      |  4 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |  8 +--
 20 files changed, 104 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index be10028c51b9..a4807e41fe69 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -386,7 +386,7 @@ static inline void vmcall(void)
 			       "r10", "r11", "r12", "r13", "r14", "r15");
 }
 
-static inline int vmread(u64 encoding, u64 *value)
+static inline int __vmread(u64 encoding, u64 *value)
 {
 	u64 tmp;
 	u8 ret;
@@ -399,18 +399,17 @@ static inline int vmread(u64 encoding, u64 *value)
 		: [encoding]"r"(encoding)
 		: "cc", "memory");
 
-	*value = tmp;
+	if (!ret)
+		*value = tmp;
 	return ret;
 }
 
-/*
- * A wrapper around vmread that ignores errors and returns zero if the
- * vmread instruction fails.
- */
-static inline u64 vmreadz(u64 encoding)
+static inline u64 vmread(u64 encoding)
 {
 	u64 value = 0;
-	vmread(encoding, &value);
+
+	__GUEST_ASSERT(!__vmread(encoding, &value),
+		       "vmwread[0x%lx] hit VM-Fail", encoding);
 	return value;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index 6a1815fb97e9..9bfea36144a7 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -41,7 +41,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 	prepare_vmcs(vmx, memstress_l2_guest_entry);
 
 	vmlaunch();
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
 	GUEST_DONE();
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index b6bd9423e676..9c752739c6c7 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -308,7 +308,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
  */
 static inline void init_vmcs_host_state(void)
 {
-	u32 exit_controls = vmreadz(VM_EXIT_CONTROLS);
+	u32 exit_controls = vmread(VM_EXIT_CONTROLS);
 
 	vmwrite(HOST_ES_SELECTOR, get_es());
 	vmwrite(HOST_CS_SELECTOR, get_cs());
@@ -348,23 +348,23 @@ static inline void init_vmcs_host_state(void)
  */
 static inline void init_vmcs_guest_state(void *rip, void *rsp)
 {
-	vmwrite(GUEST_ES_SELECTOR, vmreadz(HOST_ES_SELECTOR));
-	vmwrite(GUEST_CS_SELECTOR, vmreadz(HOST_CS_SELECTOR));
-	vmwrite(GUEST_SS_SELECTOR, vmreadz(HOST_SS_SELECTOR));
-	vmwrite(GUEST_DS_SELECTOR, vmreadz(HOST_DS_SELECTOR));
-	vmwrite(GUEST_FS_SELECTOR, vmreadz(HOST_FS_SELECTOR));
-	vmwrite(GUEST_GS_SELECTOR, vmreadz(HOST_GS_SELECTOR));
+	vmwrite(GUEST_ES_SELECTOR, vmread(HOST_ES_SELECTOR));
+	vmwrite(GUEST_CS_SELECTOR, vmread(HOST_CS_SELECTOR));
+	vmwrite(GUEST_SS_SELECTOR, vmread(HOST_SS_SELECTOR));
+	vmwrite(GUEST_DS_SELECTOR, vmread(HOST_DS_SELECTOR));
+	vmwrite(GUEST_FS_SELECTOR, vmread(HOST_FS_SELECTOR));
+	vmwrite(GUEST_GS_SELECTOR, vmread(HOST_GS_SELECTOR));
 	vmwrite(GUEST_LDTR_SELECTOR, 0);
-	vmwrite(GUEST_TR_SELECTOR, vmreadz(HOST_TR_SELECTOR));
+	vmwrite(GUEST_TR_SELECTOR, vmread(HOST_TR_SELECTOR));
 	__vmwrite(GUEST_INTR_STATUS, 0);
 	__vmwrite(GUEST_PML_INDEX, 0);
 
 	vmwrite(VMCS_LINK_POINTER, -1ll);
 	vmwrite(GUEST_IA32_DEBUGCTL, 0);
-	vmwrite(GUEST_IA32_PAT, vmreadz(HOST_IA32_PAT));
-	vmwrite(GUEST_IA32_EFER, vmreadz(HOST_IA32_EFER));
+	vmwrite(GUEST_IA32_PAT, vmread(HOST_IA32_PAT));
+	vmwrite(GUEST_IA32_EFER, vmread(HOST_IA32_EFER));
 	vmwrite(GUEST_IA32_PERF_GLOBAL_CTRL,
-		vmreadz(HOST_IA32_PERF_GLOBAL_CTRL));
+		vmread(HOST_IA32_PERF_GLOBAL_CTRL));
 
 	vmwrite(GUEST_ES_LIMIT, -1);
 	vmwrite(GUEST_CS_LIMIT, -1);
@@ -377,42 +377,42 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_GDTR_LIMIT, 0xffff);
 	vmwrite(GUEST_IDTR_LIMIT, 0xffff);
 	vmwrite(GUEST_ES_AR_BYTES,
-		vmreadz(GUEST_ES_SELECTOR) == 0 ? 0x10000 : 0xc093);
+		vmread(GUEST_ES_SELECTOR) == 0 ? 0x10000 : 0xc093);
 	vmwrite(GUEST_CS_AR_BYTES, 0xa09b);
 	vmwrite(GUEST_SS_AR_BYTES, 0xc093);
 	vmwrite(GUEST_DS_AR_BYTES,
-		vmreadz(GUEST_DS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+		vmread(GUEST_DS_SELECTOR) == 0 ? 0x10000 : 0xc093);
 	vmwrite(GUEST_FS_AR_BYTES,
-		vmreadz(GUEST_FS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+		vmread(GUEST_FS_SELECTOR) == 0 ? 0x10000 : 0xc093);
 	vmwrite(GUEST_GS_AR_BYTES,
-		vmreadz(GUEST_GS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+		vmread(GUEST_GS_SELECTOR) == 0 ? 0x10000 : 0xc093);
 	vmwrite(GUEST_LDTR_AR_BYTES, 0x10000);
 	vmwrite(GUEST_TR_AR_BYTES, 0x8b);
 	vmwrite(GUEST_INTERRUPTIBILITY_INFO, 0);
 	vmwrite(GUEST_ACTIVITY_STATE, 0);
-	vmwrite(GUEST_SYSENTER_CS, vmreadz(HOST_IA32_SYSENTER_CS));
+	vmwrite(GUEST_SYSENTER_CS, vmread(HOST_IA32_SYSENTER_CS));
 	__vmwrite(VMX_PREEMPTION_TIMER_VALUE, 0);
 
-	vmwrite(GUEST_CR0, vmreadz(HOST_CR0));
-	vmwrite(GUEST_CR3, vmreadz(HOST_CR3));
-	vmwrite(GUEST_CR4, vmreadz(HOST_CR4));
+	vmwrite(GUEST_CR0, vmread(HOST_CR0));
+	vmwrite(GUEST_CR3, vmread(HOST_CR3));
+	vmwrite(GUEST_CR4, vmread(HOST_CR4));
 	vmwrite(GUEST_ES_BASE, 0);
 	vmwrite(GUEST_CS_BASE, 0);
 	vmwrite(GUEST_SS_BASE, 0);
 	vmwrite(GUEST_DS_BASE, 0);
-	vmwrite(GUEST_FS_BASE, vmreadz(HOST_FS_BASE));
-	vmwrite(GUEST_GS_BASE, vmreadz(HOST_GS_BASE));
+	vmwrite(GUEST_FS_BASE, vmread(HOST_FS_BASE));
+	vmwrite(GUEST_GS_BASE, vmread(HOST_GS_BASE));
 	vmwrite(GUEST_LDTR_BASE, 0);
-	vmwrite(GUEST_TR_BASE, vmreadz(HOST_TR_BASE));
-	vmwrite(GUEST_GDTR_BASE, vmreadz(HOST_GDTR_BASE));
-	vmwrite(GUEST_IDTR_BASE, vmreadz(HOST_IDTR_BASE));
+	vmwrite(GUEST_TR_BASE, vmread(HOST_TR_BASE));
+	vmwrite(GUEST_GDTR_BASE, vmread(HOST_GDTR_BASE));
+	vmwrite(GUEST_IDTR_BASE, vmread(HOST_IDTR_BASE));
 	vmwrite(GUEST_DR7, 0x400);
 	vmwrite(GUEST_RSP, (u64)rsp);
 	vmwrite(GUEST_RIP, (u64)rip);
 	vmwrite(GUEST_RFLAGS, X86_EFLAGS_FIXED);
 	vmwrite(GUEST_PENDING_DBG_EXCEPTIONS, 0);
-	vmwrite(GUEST_SYSENTER_ESP, vmreadz(HOST_IA32_SYSENTER_ESP));
-	vmwrite(GUEST_SYSENTER_EIP, vmreadz(HOST_IA32_SYSENTER_EIP));
+	vmwrite(GUEST_SYSENTER_ESP, vmread(HOST_IA32_SYSENTER_ESP));
+	vmwrite(GUEST_SYSENTER_EIP, vmread(HOST_IA32_SYSENTER_EIP));
 }
 
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip)
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index 7761a8bdf5f6..1ca6495a446f 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -80,7 +80,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	 * in the VMCS by prepare_vmcs()), as MSR exiting mandatory on Intel.
 	 */
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL,
-		vmreadz(CPU_BASED_VM_EXEC_CONTROL) | CPU_BASED_USE_MSR_BITMAPS);
+		vmread(CPU_BASED_VM_EXEC_CONTROL) | CPU_BASED_USE_MSR_BITMAPS);
 
 	vmwrite(GUEST_RIP, (u64)l2_guest_code);
 	vmlaunch();
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index bb31c1aa51bf..32c5de890ba7 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -109,7 +109,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	current_evmcs->revision_id = EVMCS_VERSION;
 	GUEST_SYNC(6);
 
-	vmwrite(PIN_BASED_VM_EXEC_CONTROL, vmreadz(PIN_BASED_VM_EXEC_CONTROL) |
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL, vmread(PIN_BASED_VM_EXEC_CONTROL) |
 		PIN_BASED_NMI_EXITING);
 
 	/* L2 TLB flush setup */
@@ -121,8 +121,8 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	*(u32 *)(hv_pages->partition_assist) = 0;
 
 	vmlaunch();
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
-	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+	GUEST_ASSERT_EQ((vmread(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);
 	GUEST_ASSERT(vmptrst() == hv_pages->enlightened_vmcs_gpa);
 
 	/*
@@ -134,21 +134,21 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 
 	GUEST_SYNC(10);
 
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	current_evmcs->guest_rip += 3; /* vmcall */
 
 	/* Intercept RDMSR 0xc0000100 */
-	vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmreadz(CPU_BASED_VM_EXEC_CONTROL) |
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmread(CPU_BASED_VM_EXEC_CONTROL) |
 		CPU_BASED_USE_MSR_BITMAPS);
 	__set_bit(MSR_FS_BASE & 0x1fff, vmx_pages->msr + 0x400);
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
 	/* Enable enlightened MSR bitmap */
 	current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
 	/* Intercept RDMSR 0xc0000101 without telling KVM about it */
@@ -157,13 +157,13 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	current_evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
 	vmresume();
 	/* Make sure we don't see EXIT_REASON_MSR_READ here so eMSR bitmap works */
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	current_evmcs->guest_rip += 3; /* vmcall */
 
 	/* Now tell KVM we've changed MSR-Bitmap */
 	current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
 	/*
@@ -171,15 +171,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	 * no VMCALL exit expected.
 	 */
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 	/* Enable synthetic vmexit */
 	*(u32 *)(hv_pages->partition_assist) = 1;
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH);
 
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
 
 	/* VMPTRLD instruction causes #UD after enlightened VMLAUNCH */
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index 7987ce50c382..7e5f9ae1cb00 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -106,7 +106,7 @@ void l1_vmx_code(struct vmx_pages *vmx)
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
 	vmlaunch();
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
 	GUEST_DONE();
 }
 
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index 009932b1604e..68d9ce9dc6ba 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -74,7 +74,7 @@ static void guest_code(void *test_data)
 		vmwrite(GUEST_RIP, (u64)l2_guest_code);
 		vmwrite(EXCEPTION_BITMAP, 0);
 
-		vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmreadz(CPU_BASED_VM_EXEC_CONTROL) |
+		vmwrite(CPU_BASED_VM_EXEC_CONTROL, vmread(CPU_BASED_VM_EXEC_CONTROL) |
 						   CPU_BASED_PAUSE_EXITING |
 						   CPU_BASED_HLT_EXITING);
 	}
@@ -106,9 +106,9 @@ static void guest_code(void *test_data)
 				vmlaunch();
 			else
 				vmresume();
-			exit_reason = vmreadz(VM_EXIT_REASON);
-			exit_insn_len = vmreadz(VM_EXIT_INSTRUCTION_LEN);
-			GUEST_ASSERT_EQ(vmreadz(GUEST_RIP), (u64)l2_instruction);
+			exit_reason = vmread(VM_EXIT_REASON);
+			exit_insn_len = vmread(VM_EXIT_INSTRUCTION_LEN);
+			GUEST_ASSERT_EQ(vmread(GUEST_RIP), (u64)l2_instruction);
 		}
 
 		__GUEST_ASSERT(exit_reason == insn->exit_reason[f],
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index d0beaa7b280b..d23e24f35790 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -120,10 +120,10 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 	if (vector == FAKE_TRIPLE_FAULT_VECTOR)
 		return;
 
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
-	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), vector);
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_ERROR_CODE), error_code);
-	GUEST_ASSERT(!vmreadz(GUEST_INTERRUPTIBILITY_INFO));
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+	GUEST_ASSERT_EQ((vmread(VM_EXIT_INTR_INFO) & 0xff), vector);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_ERROR_CODE), error_code);
+	GUEST_ASSERT(!vmread(GUEST_INTERRUPTIBILITY_INFO));
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
@@ -149,7 +149,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS);
 	vmx_run_l2(l2_ss_injected_tf_test, FAKE_TRIPLE_FAULT_VECTOR, 0);
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);
 
 	GUEST_DONE();
 }
diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index 101c1fe79eeb..6e147826bc90 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -46,16 +46,16 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/* Try to run L2 with invalid CR3 and make sure it fails */
-	save_cr3 = vmreadz(GUEST_CR3);
+	save_cr3 = vmread(GUEST_CR3);
 	vmwrite(GUEST_CR3, -1ull);
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) ==
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) ==
 		     (EXIT_REASON_FAILED_VMENTRY | EXIT_REASON_INVALID_STATE));
 
 	/* Now restore CR3 and make sure L2 runs successfully */
 	vmwrite(GUEST_CR3, save_cr3);
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_DONE();
 }
diff --git a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
index d6c443e3d147..fae77d843b13 100644
--- a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
@@ -63,17 +63,17 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 expected_fault_gpa,
 	vmlaunch();
 
 	/* Verify we got an EPT violation exit */
-	__GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_EPT_VIOLATION,
+	__GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_EPT_VIOLATION,
 		       "Expected EPT violation (0x%x), got 0x%lx",
 		       EXIT_REASON_EPT_VIOLATION,
-		       vmreadz(VM_EXIT_REASON));
+		       vmread(VM_EXIT_REASON));
 
-	__GUEST_ASSERT(vmreadz(GUEST_PHYSICAL_ADDRESS) == expected_fault_gpa,
+	__GUEST_ASSERT(vmread(GUEST_PHYSICAL_ADDRESS) == expected_fault_gpa,
 		       "Expected guest_physical_address = 0x%lx, got 0x%lx",
 		       expected_fault_gpa,
-		       vmreadz(GUEST_PHYSICAL_ADDRESS));
+		       vmread(GUEST_PHYSICAL_ADDRESS));
 
-	exit_qual = vmreadz(EXIT_QUALIFICATION);
+	exit_qual = vmread(EXIT_QUALIFICATION);
 
 	/*
 	 * Note, EPT page table accesses are always read+write, e.g. so that
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
index c60dea899624..6a1a88e926f8 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
@@ -90,13 +90,13 @@ static void l1_guest_code(void *data)
 		load_vmcs(vmx_pages);
 
 		prepare_vmcs(vmx_pages, l2_guest_code);
-		control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+		control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 		control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETTING;
 		vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 		vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
 
 		vmlaunch();
-		GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+		GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	} else {
 		struct svm_test_data *svm = data;
 
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index b2fc7f0b5b3c..c763f4cf0f62 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -112,11 +112,11 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/* enable TSC offsetting and TSC scaling for L2 */
-	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETTING;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 
-	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+	control = vmread(SECONDARY_VM_EXEC_CONTROL);
 	control |= SECONDARY_EXEC_TSC_SCALING;
 	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 
@@ -126,7 +126,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 
 	/* launch L2 */
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* check that L1's frequency still looks good */
 	check_tsc_freq(UCHECK_L1);
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index e728f040916f..24056921110c 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -106,8 +106,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 
 	vmlaunch();
 	while (1) {
-		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
-		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
+		GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+		GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
 		vmresume();
 	}
 }
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 7cb1d160e2d9..75e09d5e03eb 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -59,12 +59,12 @@ void vmx_l2_guest_code(void)
 	vmcall();
 
 	/* L1 has now set up a shadow VMCS for us.  */
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
 	GUEST_SYNC(10);
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
 	vmwrite(GUEST_RIP, 0xc0fffee);
 	GUEST_SYNC(11);
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0fffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0fffee);
 	vmwrite(GUEST_RIP, 0xc0ffffee);
 	GUEST_SYNC(12);
 
@@ -89,21 +89,21 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	vmlaunch();
 	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* Check that the launched state is preserved.  */
 	GUEST_ASSERT(__vmlaunch());
 
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_SYNC(7);
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
-	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + 3);
 
 	vmwrite(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
 	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
@@ -116,18 +116,18 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 
 	vmwrite(GUEST_RIP, 0xc0ffee);
 	GUEST_SYNC(9);
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
 
 	vmptrld(vmx_pages->vmcs_gpa);
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmptrld(vmx_pages->shadow_vmcs_gpa);
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(__vmlaunch());
 	GUEST_ASSERT(__vmresume());
 	GUEST_SYNC(13);
-	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(__vmlaunch());
 	GUEST_ASSERT(__vmresume());
 }
diff --git a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
index bb31a1ba8932..b2b796fd9ffb 100644
--- a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
@@ -32,7 +32,7 @@ void l1_guest_code_vmx(struct vmx_pages *vmx)
 
 	vmlaunch();
 	/* L2 should triple fault after a triple fault event injected. */
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
 	GUEST_DONE();
 }
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index fe29c869a235..d6373c414d18 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -43,25 +43,25 @@ static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
-	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
-	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+	control = vmread(SECONDARY_VM_EXEC_CONTROL);
 	control |= SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
 	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 	vmwrite(APIC_ACCESS_ADDR, vmx_pages->apic_access_gpa);
 
 	/* Try to launch L2 with the memory-backed APIC-access address. */
-	GUEST_SYNC(vmreadz(APIC_ACCESS_ADDR));
+	GUEST_SYNC(vmread(APIC_ACCESS_ADDR));
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	vmwrite(APIC_ACCESS_ADDR, high_gpa);
 
 	/* Try to resume L2 with the unbacked APIC-access address. */
-	GUEST_SYNC(vmreadz(APIC_ACCESS_ADDR));
+	GUEST_SYNC(vmread(APIC_ACCESS_ADDR));
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_DONE();
 }
diff --git a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
index e578221da247..cda9e43e8599 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
@@ -38,7 +38,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code);
-	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_USE_MSR_BITMAPS;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 
@@ -63,8 +63,8 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	 * as KVM should force the APIC ID back to its default.
 	 */
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
-	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN));
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 	GUEST_ASSERT(rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_EXTD);
 
 	/*
@@ -91,7 +91,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	 * is active.
 	 */
 	vmresume();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_ASSERT(!(rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_EXTD));
 
 	xapic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_DM_FIXED | GOOD_IPI_VECTOR);
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index 3017938fa993..bbd188949412 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -52,13 +52,13 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	 * library hasn't enabled it.  Because KVM selftests jump directly to
 	 * 64-bit mode, unrestricted guest support isn't required.
 	 */
-	GUEST_ASSERT(!(vmreadz(CPU_BASED_VM_EXEC_CONTROL) & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) ||
-		     !(vmreadz(SECONDARY_VM_EXEC_CONTROL) & SECONDARY_EXEC_UNRESTRICTED_GUEST));
+	GUEST_ASSERT(!(vmread(CPU_BASED_VM_EXEC_CONTROL) & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) ||
+		     !(vmread(SECONDARY_VM_EXEC_CONTROL) & SECONDARY_EXEC_UNRESTRICTED_GUEST));
 
 	vmlaunch();
 
 	/* L2 should triple fault after main() stuffs invalid guest state. */
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_TRIPLE_FAULT);
 	GUEST_DONE();
 }
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index b3651c5ab138..16f57af5a8e1 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -52,13 +52,13 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	pml4_pa = pml5[0] & PHYSICAL_PAGE_MASK;
 	vmwrite(GUEST_CR3, pml4_pa);
 
-	guest_cr4 = vmreadz(GUEST_CR4);
+	guest_cr4 = vmread(GUEST_CR4);
 	guest_cr4 &= ~X86_CR4_LA57;
 	vmwrite(GUEST_CR4, guest_cr4);
 
 	vmlaunch();
 
-	exit_reason = vmreadz(VM_EXIT_REASON);
+	exit_reason = vmread(VM_EXIT_REASON);
 	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
 }
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index c5f9d9879f61..376c96e68341 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -91,14 +91,14 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 		return;
 
 	vmlaunch();
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
-	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN));
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 
 	/*
 	 * Turn on PIN control and resume the guest
 	 */
 	vmwrite(PIN_BASED_VM_EXEC_CONTROL,
-		vmreadz(PIN_BASED_VM_EXEC_CONTROL) | PIN_BASED_VMX_PREEMPTION_TIMER);
+		vmread(PIN_BASED_VM_EXEC_CONTROL) | PIN_BASED_VMX_PREEMPTION_TIMER);
 
 	vmwrite(VMX_PREEMPTION_TIMER_VALUE, PREEMPTION_TIMER_VALUE);
 
@@ -121,7 +121,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	/*
 	 * Ensure the exit from L2 is due to preemption timer expiry
 	 */
-	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_PREEMPTION_TIMER);
+	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_PREEMPTION_TIMER);
 
 	l1_tsc_deadline = l1_vmx_pt_start +
 		(PREEMPTION_TIMER_VALUE << vmx_pt_rate);
-- 
2.55.0.979.g7e5102b832-goog

