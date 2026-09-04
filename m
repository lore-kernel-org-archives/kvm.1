Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007130C60D
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483853; cv=none; b=omq57HW+iDIj2/bG00FmGPGDsxqqLvpwVQHZmpmaotPoasExize1oHRAf/jXQ54Ag8oiT8C3x0KOxeMlQWwWkTSVLcMyDl903EyOh0Bz8RylAtRKuG0zl3F+hu5X5F1AvaMj/v8iwMyX6LIGqIJZfG2skO1pshzKAc0WUzm5DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483853; c=relaxed/simple;
	bh=l4kUd/yWDPJzl0Cfuv69NdJUn93tzn+b1PJKjxDHVIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GvLhz7rOM/IjfRBHyvjWk4Zp5gbHtZHJNqG17NbyEwGlOYYMuz1S98Wy5cF0Mb+FL1MxMuf94BMH7NiDYz0IZWiyXmk/v70Q8IiEsTjn5AdZmmKfKG+kPs7GqsFb8ukuUxaPnLxWNP3voU53F7G6dlYnQOvLffUaAYw6oX6F8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X93mITEA; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X93mITEA"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso492230a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483844; x=1789088644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sl/i6fy4LSsllHV3Bhew/nOEKF0l8TqNOkYiE2Q8/uw=;
        b=X93mITEA8o6ow1iTBtPwPCyuP5r23OZZogzxVmHGc9ayy+I3egpDsRQf+Yi2AIdRx2
         BRBdg8+LKYewHBey6qNs+MFM686+tP3WW1aDtSmthbkM2fWG7ULViekaRxIFW/sF5eQO
         tfEzjAF1JLsd4eo/MPCBWGJO384zufxVSQVDUj8s2FWaG7kp/eA57ntWjeY1RAIlBUpl
         0KCTc8UNvHxXdimHhuhBEKQpzW5FTY94u5s5iQjKleJF9rjg62doq5SkyeO3v68EYy3N
         0rLAw4XTja+eWZ5uRftc6MEEBVMsuNPFRciK++g/RTEs905Z8+GChDAD//0pCWcsiBWk
         AAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483844; x=1789088644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sl/i6fy4LSsllHV3Bhew/nOEKF0l8TqNOkYiE2Q8/uw=;
        b=sdEM+H1eLZQnDBbYWC3rckfjNsuCjm6Fe1bVyrOZDUtW2zuBePbiKYu7rOVFgOVchP
         W80N0Vy6QIX1HJ6B9lpubMqbsR9bn8Syn7mrppIF+aCSzsyDgq/Kf6Mi1mkfMCwfxxKW
         nz1J7Ol2Raa1BUKwiv1WjOE4jRv56SCUWXGRoxw26UeW4kuzItg4Ekwe4DsQ4L307GfH
         tA82hmhqol7spB9xUClG739TQKq7k3n5In0ek1+9SaMVwI6md8RGeTbjHGQdwhwzeI3O
         NEEVmaXFgIljJs4JqpXc4KzIKJR/9ht58kSIUhczYMik7NH1nOmeaIC0PDeigwhga5os
         sPWA==
X-Gm-Message-State: AFuF++lPLbOxwMilI1aNS4Vs7xoTFpx71N7OcFsoGUyY0ftrU+YO2bgB
	ANIgLRJztif0TUyl4sNy3IhToPBaZ5d7l4SxZiUAPzgCmdsgsrPxEI/4q7m1R8hdKbSJTjRO8Xe
	dW8T81A==
X-Received: from pfj21.prod.google.com ([2002:a05:6a00:a415:b0:84e:a25:1e6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2885:b0:860:507d:503e
 with SMTP id d2e1a72fcca58-8616a26965emr3667088b3a.20.1788483843524; Thu, 03
 Sep 2026 18:04:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:52 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-8-seanjc@google.com>
Subject: [PATCH v3 7/8] KVM: VMX: Move common VT getters/converters to common.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the "to" vCPU converters and common exit information getters from
vmx.h to common.h to capture that they are indeed common VT code.  Defer
renaming their prefixes to isolate the code movement from the massive
churn that will result from said renaming.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h | 44 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h    | 42 -------------------------------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 35b54938a5f5..c9ca0824734a 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -2,10 +2,12 @@
 #ifndef __KVM_X86_VMX_COMMON_H
 #define __KVM_X86_VMX_COMMON_H
 
+#include <linux/container_of.h>
 #include <linux/kvm_host.h>
 #include <asm/posted_intr.h>
 
 #include "mmu.h"
+#include "vmx_ops.h"
 
 union vmx_exit_reason {
 	struct {
@@ -74,6 +76,48 @@ static __always_inline bool is_td_vcpu(struct kvm_vcpu *vcpu) { return false; }
 
 #endif
 
+struct vcpu_vmx_tdx {
+	struct kvm_vcpu vcpu;
+	struct vcpu_vt vt;
+};
+
+static __always_inline struct vcpu_vt *to_vt(struct kvm_vcpu *vcpu)
+{
+	return &(container_of(vcpu, struct vcpu_vmx_tdx, vcpu)->vt);
+}
+
+static __always_inline struct kvm_vcpu *vt_to_vcpu(struct vcpu_vt *vt)
+{
+	return &(container_of(vt, struct vcpu_vmx_tdx, vt)->vcpu);
+}
+
+static __always_inline union vmx_exit_reason vmx_get_exit_reason(struct kvm_vcpu *vcpu)
+{
+	return to_vt(vcpu)->exit_reason;
+}
+
+static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vt *vt = to_vt(vcpu);
+
+	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_1) &&
+	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
+		vt->exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
+
+	return vt->exit_qualification;
+}
+
+static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vt *vt = to_vt(vcpu);
+
+	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_2) &&
+	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
+		vt->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
+
+	return vt->exit_intr_info;
+}
+
 static inline bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.guest_fpu.fpstate->xfd &&
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 0415d328e1a5..3247b55b3484 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -304,48 +304,6 @@ struct kvm_vmx {
 	u64 *pid_table;
 };
 
-struct vcpu_vmx_tdx {
-	struct kvm_vcpu vcpu;
-	struct vcpu_vt vt;
-};
-
-static __always_inline struct vcpu_vt *to_vt(struct kvm_vcpu *vcpu)
-{
-	return &(container_of(vcpu, struct vcpu_vmx_tdx, vcpu)->vt);
-}
-
-static __always_inline struct kvm_vcpu *vt_to_vcpu(struct vcpu_vt *vt)
-{
-	return &(container_of(vt, struct vcpu_vmx_tdx, vt)->vcpu);
-}
-
-static __always_inline union vmx_exit_reason vmx_get_exit_reason(struct kvm_vcpu *vcpu)
-{
-	return to_vt(vcpu)->exit_reason;
-}
-
-static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vt *vt = to_vt(vcpu);
-
-	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_1) &&
-	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
-		vt->exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
-
-	return vt->exit_qualification;
-}
-
-static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vt *vt = to_vt(vcpu);
-
-	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_2) &&
-	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
-		vt->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
-
-	return vt->exit_intr_info;
-}
-
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
 int allocate_vpid(void);
 void free_vpid(int vpid);
-- 
2.55.0.979.g7e5102b832-goog

