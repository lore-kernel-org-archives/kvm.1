Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02A2DCF4C
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481484; cv=none; b=np8VZUn95QKZApZYuy+/mCVZyyO4QgG1AfFYGuSxt4iAaMXRr21PcKYcD6mPKfEhHFjMUKk/UlEbuGGr95Fp1VIO9Ogqx2djIJXFhkXBvsVHR4SwaabwDf+lsjmx6tkasDr7FcqxKDv6FwCfs/BAZdbjKnrn4mCQd4RDtRO+tgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481484; c=relaxed/simple;
	bh=lOLkDhC+0jEEmaJA/kJ3+0nq2l0G4q+uHGVmRu7NGRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4xPzOG7UJHApH0maxX8s+5T8hpkjuFyI980GATMtZV+v+szt+HCWemePsBcKqHnHpWxGXV1yrqNQgqwc/cFBeZsKtnNa6AcXhn8ofvc9KDpx/jHSXJ8k/Xm7cppwO84e0UjHFY/+cscyJ9EGak+sy2RPDQ+aWvrDouDqwITiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhNDZMrt; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhNDZMrt"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso5667765ad.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481481; x=1789086281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ldmCfKYtALnNcT6kPjdmhY8VFTLAAtrBH06PwWUQQDg=;
        b=BhNDZMrt6y6pj+f/M6ZqL5ZOby9XPobh/+CpccYQsIqaagm244Q3j3PkRIIKBhSVL1
         gvynXcD37YIuotZEBKWQ5Kh+TGM6gqZI1w2IBXYJfTnMelsEGgB3B7yO+qqkupjZVwXg
         05TEWfP+uPa8NjYMqkMN2Vm1EgfsBNA1lyOsGdeMIHJH3mGTsvy22v2OrTMwfi/I7GNC
         GzHbwL6OHPqf4ErFFlUgIHPSYN0ys4MvYjrWnphnSOgBZqO8R0wnQQPyvkDVsGJWutvi
         HJHuAAKzFmaOh4TyKKnrRYVjMTuK9MGfOxmWJJ5X6JfE2+wHt90kmcyyfJ4OAPMJMQhD
         Z6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481481; x=1789086281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldmCfKYtALnNcT6kPjdmhY8VFTLAAtrBH06PwWUQQDg=;
        b=UpoGMK/1WLea9jwgTiQlmiHJjazhLJENo5U+iSPNAmk21j6D///aLYJRMDZdR5ZSyZ
         f+Ws2koRiYx482Dk8FyIoPczb2iOsirvA3h4izKprM9/Mk+fldHkAGxCi3QZHZGH9Cb9
         RJsYp6fO1PJMqh4/B8cVu8H9oHmGDtSqpciELHYaZ44bIFj/CXGMtpy53pPACudFFfRM
         yRc6YoQIII9ZGrtMd7RULY4kzZlGSYi5wZy3VnFud+q6MqLnf+GGiFHfLn7NHOm1m+jv
         vTK4F6jAwF4CVhA7LLg2rJPqnxdxkJuBe9/mUzPTXmAaZX8TxiD/h57gIRTARK9MXEd3
         Lrjg==
X-Gm-Message-State: AFuF++nRg+sIVverwlCM59PaaXbXFUnhgE4RPv5Hn6fjRwlr7rargx9T
	vMvJDiSvw/6/JwUtUPe+9hZLgHcT2Z8wE56+bKVmjeP6aV0NEcfCbgXAocyvOo4G0iDPUfkWxji
	wFyJDjA==
X-Received: from plww3.prod.google.com ([2002:a17:902:d103:b0:2ce:fa2c:7de3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a981:b0:2d8:de9f:9a44
 with SMTP id d9443c01a7336-2db12879178mr27625465ad.19.1788481480684; Thu, 03
 Sep 2026 17:24:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:19 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-14-seanjc@google.com>
Subject: [PATCH v4 13/17] KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dedup the assembly code for VMLAUNCH vs. VMRESUME, for both architectural
VMCS and eVMCS, as the difference is literally only the actual VM-Enter
instruction for VMLAUNCH vs. VMRESUME, and VMWRITE vs. MOV for VMCS vs.
eVMCS.

Opportunistically place the implementations in vmx.c so that the lengthy
sequence (~580 bytes of code) aren't inlined for every single VM-Enter.

000000000041b910 <__vmlaunch>:
  41b910:       80 3d 61 5e 10 00 00                            cmpb   $0x0,0x105e61(%rip)        # 521778 <enable_evmcs>
  41b917:       0f 85 13 01 00 00                               jne    41ba30 <__vmlaunch+0x120>
  41b91d:       ba 14 6c 00 00                                  mov    $0x6c14,%edx
  41b922:       b9 16 6c 00 00                                  mov    $0x6c16,%ecx
  41b927:       6a 00                                           push   $0x0
  41b929:       0f 79 d4                                        vmwrite %rsp,%rdx
  41b92c:       48 8d 05 82 00 00 00                            lea    0x82(%rip),%rax        # 41b9b5 <__vmlaunch+0xa5>
  41b933:       0f 79 c8                                        vmwrite %rax,%rcx
  <xchg GPRs>
  41b9ae:       0f 01 c2                                        vmlaunch
  41b9b1:       48 ff 04 24                                     incq   (%rsp)
  <xchg GPRs>
  41ba2d:       58                                              pop    %rax
  41ba2e:       c3                                              ret
  41ba2f:       90                                              nop
  41ba30:       48 8b 35 39 5d 10 00                            mov    0x105d39(%rip),%rsi        # 521770 <current_evmcs>
  41ba37:       c7 86 38 03 00 00 00 00 00 00                   movl   $0x0,0x338(%rsi)
  41ba41:       6a 00                                           push   $0x0
  41ba43:       48 89 a6 68 02 00 00                            mov    %rsp,0x268(%rsi)
  41ba4a:       48 8d 05 83 00 00 00                            lea    0x83(%rip),%rax        # 41bad4 <__vmlaunch+0x1c4>
  41ba51:       48 89 46 50                                     mov    %rax,0x50(%rsi)
  <xchg GPRs>
  41bacd:       0f 01 c2                                        vmlaunch
  41bad0:       48 ff 04 24                                     incq   (%rsp)
  <xchg GPRs>
  41bb4c:       58                                              pop    %rax
  41bb4d:       c3                                              ret

No functional change intended (though the code generation will be quite
different).

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86/evmcs.h | 58 -------------------
 tools/testing/selftests/kvm/include/x86/vmx.h | 47 ++-------------
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 55 ++++++++++++++++++
 3 files changed, 60 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index f18ebfb10ee0..491fb8107473 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -1187,62 +1187,4 @@ static inline int evmcs_vmwrite(u64 encoding, u64 value)
 	return 0;
 }
 
-static inline int evmcs_vmlaunch(void)
-{
-	int ret;
-
-	current_evmcs->hv_clean_fields = 0;
-
-	__asm__ __volatile__("push $0;"
-			     "mov %%rsp, (%[host_rsp]);"
-			     "lea 1f(%%rip), %%rax;"
-			     "mov %%rax, (%[host_rip]);"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmlaunch;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"
-			       ((u64)&current_evmcs->host_rsp),
-			       [host_rip]"r"
-			       ((u64)&current_evmcs->host_rip),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
-}
-
-/*
- * No guest state (e.g. GPRs) is established by this vmresume.
- */
-static inline int evmcs_vmresume(void)
-{
-	int ret;
-
-	/* HOST_RIP */
-	current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1;
-	/* HOST_RSP */
-	current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
-
-	__asm__ __volatile__("push $0;"
-			     "mov %%rsp, (%[host_rsp]);"
-			     "lea 1f(%%rip), %%rax;"
-			     "mov %%rax, (%[host_rip]);"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmresume;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"
-			       ((u64)&current_evmcs->host_rsp),
-			       [host_rip]"r"
-			       ((u64)&current_evmcs->host_rip),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
-}
-
 #endif /* !SELFTEST_KVM_EVMCS_H */
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 3def8df902a2..d0ac8e128d98 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -359,54 +359,17 @@ static inline u64 vmptrst(void)
 	return value;
 }
 
+int __vmlaunch(void);
+int __vmresume(void);
+
 static inline int vmlaunch(void)
 {
-	int ret;
-
-	if (enable_evmcs)
-		return evmcs_vmlaunch();
-
-	__asm__ __volatile__("push $0;"
-			     "vmwrite %%rsp, %[host_rsp];"
-			     "lea 1f(%%rip), %%rax;"
-			     "vmwrite %%rax, %[host_rip];"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmlaunch;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"((u64)HOST_RSP),
-			       [host_rip]"r"((u64)HOST_RIP),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
+	return __vmlaunch();
 }
 
 static inline int vmresume(void)
 {
-	int ret;
-
-	if (enable_evmcs)
-		return evmcs_vmresume();
-
-	__asm__ __volatile__("push $0;"
-			     "vmwrite %%rsp, %[host_rsp];"
-			     "lea 1f(%%rip), %%rax;"
-			     "vmwrite %%rax, %[host_rip];"
-			     VMX_SWITCH_GPRS_ASM
-			     "vmresume;"
-			     "incq (%%rsp);"
-			     "1: ;"
-			     VMX_SWITCH_GPRS_ASM
-			     "pop %%rax;"
-			     : [ret]"=&a"(ret)
-			     : [host_rsp]"r"((u64)HOST_RSP),
-			       [host_rip]"r"((u64)HOST_RIP),
-			       GUEST_REGS_OFFSETS
-			     : "memory", "cc");
-	return ret;
+	return __vmresume();
 }
 
 static inline void vmcall(void)
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 5c6cadc08405..1a8515de42b0 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -179,6 +179,61 @@ void load_vmcs(struct vmx_pages *vmx)
 	vmclear(vmx->shadow_vmcs_gpa);
 }
 
+#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwrite_operand,	\
+				    __host_rsp, __host_rip)				\
+static int __##prefix##_##insn(void)							\
+{											\
+	int ret;									\
+											\
+	__asm__ __volatile__("push $0;"							\
+			     __stringify(vmwrite_insn) " %%rsp, %[host_rsp];"		\
+			     "lea 1f(%%rip), %%rax;"					\
+			     __stringify(vmwrite_insn) " %%rax, %[host_rip];"		\
+			     VMX_SWITCH_GPRS_ASM					\
+			     __stringify(insn)";"					\
+			     "incq (%%rsp);"						\
+			     "1: ;"							\
+			     VMX_SWITCH_GPRS_ASM					\
+			     "pop %%rax;"						\
+			     : [ret]"=&a"(ret)						\
+			     : [host_rsp]__stringify(vmwrite_operand)(__host_rsp),	\
+			       [host_rip]__stringify(vmwrite_operand)(__host_rip),	\
+			       GUEST_REGS_OFFSETS					\
+			     : "memory", "cc");						\
+	return ret;									\
+}
+
+#define BUILD_VMX_VM_ENTRY_HELPER(insn) \
+	__BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite, r, (u64)HOST_RSP, (u64)HOST_RIP)	\
+	__BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov, m,				\
+				    current_evmcs->host_rsp, current_evmcs->host_rip)
+
+BUILD_VMX_VM_ENTRY_HELPER(vmlaunch)
+BUILD_VMX_VM_ENTRY_HELPER(vmresume)
+
+int __vmlaunch(void)
+{
+	if (enable_evmcs) {
+		current_evmcs->hv_clean_fields = 0;
+		return ____evmcs_vmlaunch();
+	}
+
+	return ____vmlaunch();
+}
+
+int __vmresume(void)
+{
+	if (enable_evmcs) {
+		/* HOST_RIP */
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1;
+		/* HOST_RSP */
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		return ____evmcs_vmresume();
+	}
+
+	return ____vmresume();
+}
+
 static bool ept_vpid_cap_supported(u64 mask)
 {
 	return rdmsr(MSR_IA32_VMX_EPT_VPID_CAP) & mask;
-- 
2.55.0.979.g7e5102b832-goog

