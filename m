Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7B45D5FD
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762068; cv=none; b=aGCON1W90eYTD5KUFme6d/eGDDJ3Ng7prDjfqt1Kohg29cD2YY0FuX/E7KqHhpC5pJXN5pb2oLsuxVSLtZu8brypsPwkZiz8qj+19Xdjzivaq5bGVlrA73/tF7ACevQ89O4anVSrjpYeRxEo9YWq0k1p6b1k8u7stfQcHys2MVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762068; c=relaxed/simple;
	bh=2nZtselLGRQA+iGH9lWqBntxKtAC+MyMjj+0gP5igAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUhkvftal1uROs+v6Y7nfoJvCE6hH+i1b+CL2MlMRnSKA8SvAToKUoSN9Ej1vG5RaCl+eS7uDQjOZ2Eq+bL4IXBJz92Q18zYUKDRGMCr4l5iv2OV0SQr3MIyuO+J9LOuOIa+Njz+0GN2dAlVuH58rbCOVxaeNvVzPBiIMNwMO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPJq7J+s; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPJq7J+s"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso910475ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762064; x=1785366864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHjIow7FRD/o8g9hVMX5NwnfmgyNmUnSSABYjO98n7Y=;
        b=kPJq7J+sxIMSOzmcu7SgGsNP1k+B6WrpwIme1+k1C7ercWnma2ugL7Ggl6aqOu6OAC
         Oxkh42+sXEzqC5eQKau9pirjlTYsLwEnbRlpcwwQAS9LeQjqVRTSOtlHYg5T4Kn/iVOE
         Q1IheUY7ed7RZGtVZ1TzOHuxF3gzRY4XYZg8hdBfzEQidGMtU/EAUwYwcDdSYBMqnetE
         bc+S/+vcKBTaBnDJ8eXHLPXPPqZsECVX2bp7uPMkpbp3JL2ETtaxnNzDIz+5wqW7c6xS
         FBnDYKiyAGq6SH9aDVJDPZHlKfGUqSqEpl/SZjmHwrvc7qRCvljQ6qbRtS+My/MPG+pk
         RdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762064; x=1785366864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHjIow7FRD/o8g9hVMX5NwnfmgyNmUnSSABYjO98n7Y=;
        b=WwMkyFpTvOFcgvqdGLIQ0XdCLBDBX8+pNxQ0u4VhaFj30ti6ahfpgdQAlXQxG9CQaf
         wKvbJ9Y/+Wukav5RjbIMbniu/GWaqIZOk+PXdybMNf+IpiRXSsPWEOpxE1FY8kjhMJk+
         b3gTEfGIzuz+NUvvtRdSwEwrMZURKLjYijy7+0lu9Md9mL0mAWuB48yTq3Pc3pHh/MDX
         /O1qpWaS5IOk9w2xs0G6hChUwcG2fY9uadHxRZBtWNG/WMsGiRoLsXXniyNGpyNYP/0b
         /X7hUdFsyjXh5Pm7mYsOIP5iRyIqu7118IuEnD6fe4v8ylh3JPILXNb8LLGO3UMlCwE7
         VgOw==
X-Forwarded-Encrypted: i=1; AHgh+RpEVszBloKLhIGG3z07qnS7TTKhmJyhR34HFJfYUqlvSUaf2L3dti6BxggfAbqsfrQzZJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhdA6En2cH6aWFqSEfDSXYFPJd55ZY71/2ObX6yw1GO42f70E
	wE79ou/fxFWSaZ3ZLj2a5x+LkOwsSrSvR4QrH5KRgcPBluI/BxEaidh/Sam5pQwCTCco5bmHpnS
	BQbBtWw==
X-Received: from plpo3.prod.google.com ([2002:a17:903:3e03:b0:2ca:b8f5:2d26])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f681:b0:2c9:cf5d:d9bc
 with SMTP id d9443c01a7336-2cfa74b13famr9003555ad.35.1784762064085; Wed, 22
 Jul 2026 16:14:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:13 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=4661;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=nkYYec/Kj5J9dGXmWp9KVDsgzg3Lhpo8ptfotZieFvo=; b=9nFbAkjgrBrpCjn1Htarcq44COVIT6r0M3Rh5Jfk4tBIFtZ1wfV4g+2qidhFCsL4BlNEev3HK
 Api70IZ2v1/C4QZZOUqpmTSCmkTjRWxdeF7Q51i0ohVbAV/vVczBAXO
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-8-15ad654a50db@google.com>
Subject: [PATCH v14 08/22] KVM: selftests: Add TDX boot code
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

From: Erdem Aktas <erdemaktas@google.com>

Add code to boot a TDX test VM. Since TDX registers are inaccessible to
KVM, the boot code loads the relevant values from memory into the
registers before jumping to the guest code.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../selftests/kvm/include/x86/tdx/td_boot.h        | 22 ++++++--
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  | 61 ++++++++++++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 397afebbb34b..645d9aac61db 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -32,6 +32,7 @@ LIBKVM_x86 += lib/x86/svm.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
+LIBKVM_x86 += lib/x86/tdx/td_boot.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
index bf2282931d49..89cf6c3485be 100644
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
+#if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)
+
+#include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * The exact memory layout for LGDT or LIDT instructions.
@@ -63,4 +72,11 @@ struct td_boot_parameters {
 	struct td_per_vcpu_parameters per_vcpu[];
 };
 
+void td_boot(void);
+void td_boot_code_end(void);
+
+#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
+
+#endif /* !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__) */
+
 #endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
new file mode 100644
index 000000000000..bca9a4c3d8f8
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
@@ -0,0 +1,61 @@
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
+	 * In this procedure, edi is used as a temporary register.
+	 * Paging is turned off.
+	 */
+	cli
+
+	movl $TD_BOOT_PARAMETERS_GPA, %ebx
+
+	/*
+	 * Find the address of struct td_per_vcpu_parameters for this
+	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
+	 * struct address into register for indirect addressing.
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
+	 * Set up control registers (There are no instructions to mov from
+	 * memory to control registers, hence use edi as a scratch register).
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
2.55.0.229.g6434b31f56-goog

