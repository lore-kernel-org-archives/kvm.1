Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA7524AE8
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883532; cv=none; b=KMUX544KR/9B372PhRih0oztTNoRrTEa9Kcpfdudq3g1Yk/5or+20M/6O/w35gVOdea4dKcozKe9hIVY3CRglWy+XnOOjhs/u4sf+i5XAq+jrJ+00T3HUQejDRd6eDmYqyioPq9WIXAtIHRulPEnzQK4NalG/yN9SlZoZsbhESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883532; c=relaxed/simple;
	bh=DWacxacXZnJq6gLe9vEPvXA7VtMQmtw2LkMJ7ZAXGQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VvslLyDbnA8ckvv+ZOjslaF4rCqmPZRXpXYKA9gTjuAzjsxkKSyL17G+RLYdNRrj9hpFnObjaS05i6symyku+NFQHNLjsvjzqDp1tMvqKfxyAEj2S2h28DnRV7hRnmsKi35PpokdtLQcAeOPWmHT8VHhmEp2Kw9XhNA4dGb5D0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwKHb1Tm; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwKHb1Tm"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3822039a12.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883528; x=1791488328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+kZwO8v0d2m0Lzd0UkJQQs14ynfzrrPb/419nonwBE=;
        b=rwKHb1TmnGFYqcUrvrfiXr1gmKem+Y4MrWMzQCgtb04gGjzgEdLRTOtywnTtPmcdT4
         I2Dy64jDpNGI7CgUYVuXWPQfxGNrO8f3z3ei3rS1g1CeoXlmAqOPzuj2KfLweJoVS52x
         y0VFFheB70zotfyN+gcZiOhR7Re1LnZ7R5bcyTxf0kIgXLs3XqXE8v3YSU4VIB04gwg7
         ckKBxcri99Ur6vyCsAONBkk4Ds4bO9UZ2eNbFDxDgYz/XlCBNts7w0IPToTDAWUy7DfT
         y18BuQeO6k7U6Axnp+cE2coCVTgRQU8S/TsA+7rbIpmO2iU/4RhHbhSn+7e/thy3QaSL
         /bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883528; x=1791488328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+kZwO8v0d2m0Lzd0UkJQQs14ynfzrrPb/419nonwBE=;
        b=qReVRkM1m69KJI6Fv6AlXEiZQUdBsiU+rxzx3ZvPi2zaIB7LAENFt2uLvt31WPwORm
         gJMrgq8T18h1B32Xny03+9aOlF61/wYlWQBB+aOyz3b5Kk7ZkpYf8dxrD3OK8uUUk07U
         ytTImL+JGRjSCeN3ot7sb1/NwnYnL1AQPtq586nJEatj88UmtK3M5sHVJh4Ltv2hOOKT
         wM/UR4SwKf9Cvlwp0kQnunZ/e5EahCov4EXylY5BV2UbxM2386RXVwXNI2OFM+STo1qd
         bHVyfbkPe6pbIKK+51AHsJFi/hnwAj7LKMaOE9umHfDA1bqafyUqD1uvWHFUuyFeVUvU
         mbRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+dJAZtky3iFFt7dvngn7oAVrSpvjHo2jfQwJUZxL6eApNiOShZPNBvox3BmcOPw2KkEg=@vger.kernel.org
X-Gm-Message-State: AFuF++kgEOdj4BCoBFxpvwmYALeOAZ7u1NImCJKx1dIrnkJ/mw0NVisF
	RLYA3RZoKT6e3dJY3u1axuiQJ3orlrzk0WrAwPxnPkPvVe/0GRtKiDBA9F/4MZenK5fRwza/4jw
	IBT+9Zg==
X-Received: from pfbgg24.prod.google.com ([2002:a05:6a00:6318:b0:886:2d42:5dc3])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:549d:b0:3dd:85a8:4c57
 with SMTP id adf61e73a8af0-3e0bd194567mr425972637.30.1790883528253; Thu, 01
 Oct 2026 12:38:48 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:34 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=4804;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=3HmQrjnisYGmC7PmL3EWdgB481Qll9XUUbIr7YWGjhI=; b=qk0nviTpDkLXNJm223TqIuGSM4wb8e8FRrxZRbm/TD6HArA07bXME79Nn1Av8wt0a/N8Dw7JN
 gbSgzPd6KmFDWM+DgiJlUCz9VYeCCcGZ3ZOaF07k409ljOQyxGyPGsB
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-7-7c62a5d8a992@google.com>
Subject: [PATCH v15 07/23] KVM: selftests: Add TDX boot code
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
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

From: Erdem Aktas <erdemaktas@google.com>

Add code to boot a TDX test VM. Since TDX registers are inaccessible to
KVM, the boot code loads the relevant values from memory into the
registers before jumping to the guest code.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../selftests/kvm/include/x86/tdx/td_boot.h        | 21 ++++++-
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  | 65 ++++++++++++++++++++++
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8fc38a93a725..9464168e361a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -33,6 +33,7 @@ LIBKVM_x86 += lib/x86/svm.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
+LIBKVM_x86 += lib/x86/tdx/td_boot.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
index bf2282931d49..577e7b23c51c 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -2,9 +2,6 @@
 #ifndef SELFTEST_TDX_TD_BOOT_H
 #define SELFTEST_TDX_TD_BOOT_H
 
-#include <linux/compiler.h>
-#include <linux/types.h>
-
 /*
  * Layout for boot section (not to scale)
  *
@@ -24,7 +21,19 @@
  * |                           |
  * |                           |
  * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
+ *
+ * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
+ *
+ * + be within the 4GB address space
+ * + provide enough contiguous memory for the struct td_boot_parameters such
+ *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
  */
+#define TD_BOOT_PARAMETERS_GPA 0xffff0000
+
+#ifndef __ASSEMBLER__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * The exact memory layout for LGDT or LIDT instructions.
@@ -63,4 +72,10 @@ struct td_boot_parameters {
 	struct td_per_vcpu_parameters per_vcpu[];
 };
 
+extern u8 td_boot[], td_boot_code_end[];
+
+#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
+
+#endif /* #ifndef __ASSEMBLER__ */
+
 #endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
new file mode 100644
index 000000000000..726ec51e040e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "tdx/td_boot.h"
+#include "tdx/td_boot_offsets.h"
+#include "processor_asm.h"
+
+.code32
+
+.globl td_boot
+td_boot:
+	/*
+	 * Paging is turned off.
+	 *
+	 * Register usage throughout td_boot:
+	 * ebx: Address of global boot parameters (Must be preserved)
+	 * eax: Address of per-vCPU parameters (Must be preserved)
+	 * edi, edx: Temporary scratch registers
+	 */
+	cli
+
+	movl $TD_BOOT_PARAMETERS_GPA, %ebx
+
+	/*
+	 * Find the address of struct td_per_vcpu_parameters for this
+	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
+	 * struct address into eax for indirect addressing.
+	 */
+	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
+	mul %esi
+	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
+	addl %edi, %eax
+
+	/* Setup stack. */
+	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
+
+	/* Setup GDT. */
+	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
+	lgdt (%edi)
+
+	/* Setup IDT. */
+	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
+	lidt (%edi)
+
+	/*
+	 * Set up control registers (x86 does not support moving memory
+	 * directly to a control register).
+	 */
+	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
+	movl %edi, %cr4
+	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
+	movl %edi, %cr3
+	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
+	movl %edi, %cr0
+
+	/* Switching to 64bit mode after ljmp and then jump to guest code */
+	ljmp $(KERNEL_CS),$1f
+1:
+	jmp *TD_PER_VCPU_PARAMETERS_GUEST_CODE(%eax)
+
+/* Leave marker so size of td_boot code can be computed. */
+.globl td_boot_code_end
+td_boot_code_end:
+
+/* Disable executable stack. */
+.section .note.GNU-stack,"",%progbits

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

