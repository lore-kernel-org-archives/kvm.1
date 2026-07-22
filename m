Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A5459AEE
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762089; cv=none; b=GI/Ei0TFdwTU23qAdpCyM2/PvDXD6CVqfPripBtjE4q+hfzio1CWFRGTXYRbInxHF0x07RqbRpAFpskRGoKnFCZ0kzaMzQE9uHUQ1SXJk1MI1l4IhY8dFrtqqrapNov6vmrRDDsA8YQ1EudvznRbaWvtPfsbfrAT8o3TzBB3vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762089; c=relaxed/simple;
	bh=Mt5Lh8+8kiaK6W3VjPfbBEwiyc60WE+BOpoJvPyUsrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCzu3x5RTlgf3vWL3jM01YTe6vba08y4X6g5Cg/OwkHtiSX7bQcCo3i0bk/BiRDsKpl/FZOvUazmgVd1HiTK3Rj9Tnvb3jdOPQ/K1Qo0rWmvOaqoqa7gXcgTJX3yCV0Pv8bZEkSxVNLiitq8SzT2QFrv9mZGXFr3hUNGQaA6tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uivej684; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uivej684"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cccfa32670so570465ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762087; x=1785366887; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npQwrp8dxwBrq6gTxtnOVCzjkW4oB/ew6/3QNAsGhNI=;
        b=uivej684E3SuDdNsXPwuDcwHdNhsK1oKyEWAGlvCE5XiJIsvMOCf5nR3MKBlL4IKoq
         UG7bL9hsaUJBaNl4opdhQnqGonvveUhjl/rSsS6oIrE6eP+IbM/wTsx70WdXyvRUindn
         dpMrgLtAJ55p27fikd9L5H97dAS8v7mevE4G4hAux4QiRGiOUuIBrGQR8yyXE8UntuC8
         tLvs7gfsMSgC4T+UtqSz76zaSCJlq00IL7I3CpfQEdhHIyx0OlVluY+gwGWWPYgnv/ii
         ToSOstx1rYvmdcb1EuQOS8VX6lidFpuVJsLklgDtAWA23BFGcALr2H0EpV84Znw+HXOm
         qS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762087; x=1785366887;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npQwrp8dxwBrq6gTxtnOVCzjkW4oB/ew6/3QNAsGhNI=;
        b=rf8VfVsTiTN982Qvt5K3ph5ghTdm6YbWYARfDwKI+lKpk1tmTwVNKLrEP5tQ0xoInZ
         uZjpgLiZ8LvUboInMkRq0ZT6XGVFU0XpM7iEv/0S+sub+xxjY1vDpc73Dj3lt71soiD1
         05fb6u0oXxYIhKzdqAFZB+JpDr0hneY0FpUtOxUBMQszpd7Rxzd/lASmLP4z7HAb1wnC
         kLyp28wOdOuJkI+n8yw60ApURAVny3IL0LFT9YeWe/coVn2WE6kL4GQp7ukVP5RX1TTK
         caDhkl2T8bo027TVTxi8pA8Yd4HyeTocomqmz4S2RZcgLgiKHfwwWO+J8RZx7e14q5yA
         qJCg==
X-Forwarded-Encrypted: i=1; AHgh+RpTBkgkVAsFC0u+pjBX1jhbrODKzfRDNNifBF3ThxDu5TW56rPJ7QKVlXIK+UfyZ8QIe2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTdMp2yf2B2Sjkp0ZcBwpJ6gdTPJGFkP+6J3US0G3Z262kOj0
	pXPimm2/mqC/48t18VTGgNXaAW/nDgROltwWBejQEmIREiXwHneIFkXSGoC/A3Xe7JSADt/wYzJ
	MDVN76A==
X-Received: from plld11.prod.google.com ([2002:a17:902:728b:b0:2c8:7ed:acf4])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac7:b0:2c7:ebfb:618f
 with SMTP id d9443c01a7336-2cfa6b73a76mr9771635ad.14.1784762078730; Wed, 22
 Jul 2026 16:14:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:26 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=3287;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=7diizuo3ArwKIH9Jsi5ICyi9zc8nAkbP5tj3yujaUxE=; b=r/IDcKTeYPBvxZo+9sWeP0LiVNW/DOX6AaP68XXLFLG4gDOoC2whw6k/TQoOk3j3a00HlfP8h
 0OI5SVbn2efDnVqhQHLtWLQ/eyVISA6/dT0Nlv7T+BBa01oHO7mNOiZ
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
Subject: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Ackerley Tng <ackerleytng@google.com>

Implement TDX ucall using TDCALL-based MMIO to pass the ucall address
from the VM to the host.

In standard KVM selftests, ucall uses a PIO instruction as a trigger
to exit to the host, which then retrieves the ucall address by reading
the guest's RDI register. This approach is incompatible with TDX
because the host cannot access guest registers.

Furthermore, PIO exits only expose 4 bytes of immediate data, which
is insufficient for a 8-byte ucall address. By using TDCALL-based MMIO,
the VM can share the full 8-byte address in a single exit without
refactoring the common ucall framework and other non-x86 architectures.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/ucall.h |  6 -----
 tools/testing/selftests/kvm/lib/x86/ucall.c     | 33 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index 0e4950041e3e..7e54ec2c1a45 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -2,12 +2,6 @@
 #ifndef SELFTEST_KVM_UCALL_H
 #define SELFTEST_KVM_UCALL_H
 
-#include "kvm_util.h"
-
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
-{
-}
-
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index e7dd5791959b..7a954b2d0bdd 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,11 +5,35 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
 #define UCALL_PIO_PORT ((u16)0x1000)
 
+/* HPET address is guaranteed to be unused for ucall MMIO */
+#define UCALL_MMIO_GPA 0xfed00000
+
+static u8 vm_type;
+static gpa_t ucall_mmio_gpa;
+
+void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+	vm_type = vm->type;
+	sync_global_to_guest(vm, vm_type);
+
+	if (is_tdx_vm(vm)) {
+		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
+		sync_global_to_guest(vm, ucall_mmio_gpa);
+	}
+}
+
 void ucall_arch_do_ucall(gva_t uc)
 {
+	if (vm_type == KVM_X86_TDX_VM) {
+		tdx_mmio_write(ucall_mmio_gpa, sizeof(gva_t), uc);
+		return;
+	}
+
 	/*
 	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
 	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
@@ -46,6 +70,15 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
+	if (vm_type == KVM_X86_TDX_VM) {
+		if (run->exit_reason == KVM_EXIT_MMIO &&
+		    run->mmio.phys_addr == UCALL_MMIO_GPA &&
+		    run->mmio.len == sizeof(gva_t) &&
+		    run->mmio.is_write)
+			return (void *)(*((gva_t *)run->mmio.data));
+		return NULL;
+	}
+
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
 

-- 
2.55.0.229.g6434b31f56-goog

