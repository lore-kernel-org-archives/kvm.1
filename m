Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8B3D25C2
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795648; cv=none; b=mv0TKui+c5odlKbZ5VusVy/wdp7bMk0E1gIRzdugvKE3aM6BqgoiTOriZRVquiYH/xZ3AQiO1ct9bLvmZ/+RzGsYfDFyKaqafRRepbnQJBbQN3Vo9KTZoIvizrrdPtIW8iqF1naDcfvMQt6CqJShSaycJ15By9TUtYuISiD5ILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795648; c=relaxed/simple;
	bh=G1jqVtRGMHHU2pYLXqlDWhngOFL0xaMmd6fXfWamkcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CwaZghyTA58LMP92n9a2bPZe0qnOJZhR5o4wkHU68byxGk2yeIetrUsipMonY8XkhAyGSGNbNH5Gv1oM2tiK+HP6y38bnTflZRqxcC5AxszZktAA+io/nYmB4+mQ6qZWbu1BHREpyr+kwSSVQZNw4BqsndLN/r+Rzsnwy6REoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B86sVLIA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B86sVLIA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so193699b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795644; x=1779400444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uJv9wi2J1zMACcV+TLkHPu/SNZnF0/LBSZ3jiwDXSHs=;
        b=B86sVLIAji13Vhv8ayDrTAAyqeHmgRAxOi9nPMRs7EoF2uvuXMJk9LJ5AbYs7Ftf8K
         WgvgF++rSUHDl+uIenBIuB3qSxq0Rlk30gKZ8qGi0xGqad72nQX2mK/XSmDlJy90nweK
         It8t8jGrCL6eCS34HASDbiD8UrKZ4Mpprh27iXHPFXQtOaBcnY9sxLhvywSuBLG2qpjU
         TwSBACfcrATQ0fw+DAm7KipoSdjNGvx59lPcwYMWZ81hmfzAvLclR4I78A521BgN2uaQ
         3HEthi9uCpsW80BeQBXJfunHnAP2JY+V+QFqSpVPAnJacYmoqPTV6bSyKpG3nMHu1RD7
         4Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795644; x=1779400444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJv9wi2J1zMACcV+TLkHPu/SNZnF0/LBSZ3jiwDXSHs=;
        b=O8n8+0wDdP/WXZmFn/NwYemZh+CPS/yoiawBS6B2OqMGpdrzUcfDYb22ivft6Op7b1
         OyP7fSQlGwiz/UylbyQHms5gHSPsUqrw/KpXtl1sBne9HT2zko/5s43NdfFZV3gmM2/R
         aSRFy5Y8oWZpPFb4wY8Q/bKozObXMsRPCMHECNcl3ceO0wTyjRfMeztexOWL7tUwYy01
         5wapvZp14f/gBZYPaSPG15yYR/5lzMYk+OyVEXbhwf2o5ycy4WGYhGz+L/n5OawmhCrz
         5U34P9tIFvsTDkTPJKTE/b+TVr+tX5uudh4ZA2DUUYyCr1DnuLn7cioGVAfNmrsq2vn5
         z8hA==
X-Forwarded-Encrypted: i=1; AFNElJ/TRr/4JycRNsnvugTDOJdfioNKCQ62dxLfZ/XZfIVR9eWa5OsnWhxYJOMZyoivhUHINHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWIxKRQcAHl60NX8C2004REwUMYZ6r5Ee0FT7GAlhIHuxoPMR
	np1D4v1d1ccr7SSMa7Ua9tEyMhyZAG6SVcA54enNiT8WvLsr4vFHTjGy1vdKhHq768Yz62ZBSxV
	DbKQNrQ==
X-Received: from pfblg3.prod.google.com ([2002:a05:6a00:7083:b0:82e:7f41:df84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a227:b0:82c:9c90:6ea0
 with SMTP id d2e1a72fcca58-83f33ad8782mr1023609b3a.3.1778795643702; Thu, 14
 May 2026 14:54:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:46 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-7-seanjc@google.com>
Subject: [PATCH v2 06/15] KVM: x86: Rename kvm_cache_regs.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_cache_regs.h to simply regs.h, as the "cache" nomenclature is
already a lie (the file deals with state/registers that aren't cached per
se), and so that more code/functionality can be landed in the header
without making it a truly horrible misnomer.

Deliberately drop the kvm_ prefix/namespace to align with other "local"
headers, and to further differentiate regs.h from the public/global
arch/x86/include/asm/kvm_vcpu_regs.h, which sadly needs to stay in asm/
so that the number of registers can be referenced by kvm_vcpu_arch.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c                    | 2 +-
 arch/x86/kvm/lapic.c                      | 2 +-
 arch/x86/kvm/mmu.h                        | 2 +-
 arch/x86/kvm/mmu/mmu.c                    | 2 +-
 arch/x86/kvm/{kvm_cache_regs.h => regs.h} | 4 ++--
 arch/x86/kvm/smm.c                        | 2 +-
 arch/x86/kvm/svm/svm.c                    | 2 +-
 arch/x86/kvm/svm/svm.h                    | 2 +-
 arch/x86/kvm/vmx/nested.h                 | 2 +-
 arch/x86/kvm/vmx/sgx.c                    | 2 +-
 arch/x86/kvm/vmx/vmx.c                    | 2 +-
 arch/x86/kvm/vmx/vmx.h                    | 2 +-
 arch/x86/kvm/x86.c                        | 2 +-
 arch/x86/kvm/x86.h                        | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)
 rename arch/x86/kvm/{kvm_cache_regs.h => regs.h} (99%)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..6e64761f64b1 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -20,7 +20,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "kvm_emulate.h"
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..d8dbfb107bfb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -37,7 +37,7 @@
 #include <asm/delay.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "irq.h"
 #include "ioapic.h"
 #include "trace.h"
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index ddf4e467c071..e1bb663ebbd5 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -3,7 +3,7 @@
 #define __KVM_X86_MMU_H
 
 #include <linux/kvm_host.h>
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "x86.h"
 #include "cpuid.h"
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c87c26bf4149..b8f2edf2cfeb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -22,7 +22,7 @@
 #include "mmu_internal.h"
 #include "tdp_mmu.h"
 #include "x86.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "smm.h"
 #include "kvm_emulate.h"
 #include "page_track.h"
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/regs.h
similarity index 99%
rename from arch/x86/kvm/kvm_cache_regs.h
rename to arch/x86/kvm/regs.h
index 2ae492ad6412..4440f3992fce 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/regs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_KVM_CACHE_REGS_H
-#define ASM_KVM_CACHE_REGS_H
+#ifndef ARCH_X86_KVM_REGS_H
+#define ARCH_X86_KVM_REGS_H
 
 #include <linux/kvm_host.h>
 
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index f623c5986119..a446487bdd5c 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -3,7 +3,7 @@
 
 #include <linux/kvm_host.h>
 #include "x86.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "kvm_emulate.h"
 #include "smm.h"
 #include "cpuid.h"
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4ad87f8df392..be775d285ce7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4,7 +4,7 @@
 
 #include "irq.h"
 #include "mmu.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "x86.h"
 #include "smm.h"
 #include "cpuid.h"
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2b6733dffd76..b8c7f4535691 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -23,7 +23,7 @@
 #include <asm/sev-common.h>
 
 #include "cpuid.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "x86.h"
 
 /*
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 213a448104af..6d6cd5904ddf 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -2,7 +2,7 @@
 #ifndef __KVM_X86_VMX_NESTED_H
 #define __KVM_X86_VMX_NESTED_H
 
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "hyperv.h"
 #include "vmcs12.h"
 #include "vmx.h"
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 4c61fc33f764..66c315554b46 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -6,7 +6,7 @@
 #include <asm/sgx.h>
 
 #include "x86.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "nested.h"
 #include "sgx.h"
 #include "vmx.h"
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b02d176800f8..67bc6edfd856 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -59,7 +59,7 @@
 #include "hyperv.h"
 #include "kvm_onhyperv.h"
 #include "irq.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "lapic.h"
 #include "mmu.h"
 #include "nested.h"
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index daedf663c0a9..de9de0d2016c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -10,7 +10,7 @@
 #include <asm/posted_intr.h>
 
 #include "capabilities.h"
-#include "../kvm_cache_regs.h"
+#include "../regs.h"
 #include "pmu_intel.h"
 #include "vmcs.h"
 #include "vmx_ops.h"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 23b3957b9ae0..ab13aed2cbd0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -23,7 +23,7 @@
 #include "mmu.h"
 #include "i8254.h"
 #include "tss.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "kvm_emulate.h"
 #include "mmu/page_track.h"
 #include "x86.h"
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..2bbecc83ecc2 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -6,7 +6,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/mce.h>
 #include <asm/pvclock.h>
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
 
-- 
2.54.0.563.g4f69b47b94-goog

