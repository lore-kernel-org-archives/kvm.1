Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798E3C4175
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093380; cv=none; b=Su5kjJQcrMfJgS1GfzNItjzSZxufA957D9+Wh2341+3FK9ZesW12euVn2i2jKQQmCJ5swzzCjYcfYh0GQu1O0tcfJbQRnJi71YhbVQLP1ZIk3PWmo8gPvanhtsCxqvuWBrgxYu/4fRzhG1VMBAGZiZ80d5HSfy3YNdgEJEXWjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093380; c=relaxed/simple;
	bh=qorWr+Wuyaa1/wm5b2Bbu4vbtL+yom4vUJcmXV5SO2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SKnKDyziCsarXPd4fDUFfuxZ6CF55xNuPg0UnCmnt+zJECgh2W/EQbl2uDHes110fZe1FXg0pn/GL0BWQuzgIIIpNIiOqAFtqEh1y5TuFWa4JCs2xCdt9spbrcjyGC/Sf5QPHqAUWa+IGNtivKEu9BOEloxvDSNF10VPQTF+KWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6Azm6q6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6Azm6q6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c477290bso8252363a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093370; x=1780698170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R6G4651Su27Kldq1bd8liUGC3loQ5pH7nVS2++qmd+w=;
        b=s6Azm6q6hxsxbWLYouE2YomLASFoK3XgkqAwVFCwAL1dkVakHVo0qwJV0jg14nlTey
         cYuWS1V9x3u5AOp/b7oi/GP8IGeagAfcRLKADbN+uuS03OAml7Rwvhlavbj/uica+gXD
         ZqM8QUVUF+x6y7YIJ/klzGOCPNDnNSBWVVvXz0CA/hpkDJb1jkzdJxrZxE7D9TRRYFO0
         KWUmjHKP9E2Fk2a7xr6D8fot33sBavrHwbuFa19xPfb0fohR9Lz/RgiMqYwWrkTA9ZFF
         calPiLm5C4JcTvpkuGwv8ApPEinikigl+/hogcNR8ZOAYyZLrpjUhYiAgNFI6OIpWMdv
         6tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093370; x=1780698170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6G4651Su27Kldq1bd8liUGC3loQ5pH7nVS2++qmd+w=;
        b=sa/DH7jVv8/4+m4O1lN42UpAvlWWkiSyyaAyrITR3otrwWY0LWhcF5RVAi/6jwfp1d
         nagVkPrmWcRT7hLmwdalFpMt5xBMNQQgXE8eoafr3CL3Wu9A/oGku2uazwXxeIwTrX6s
         jEOTnMwgEUvJE0AOQks//3EfjOc3t/b8A8Uzkl+PFrcASLHLmzAV8yD1hxUJWRmONHXv
         USeFfkPMD9iQ/E46by3Mu/BvzbTujQKCwnBo5+NfBnCNvDgPMqHsHRULp9UXIXnsCLwn
         inulZuX406hqMb9GYF2eW24XG8eU+6ZhNSR0GE3WEq7MegL5lAJ0UvJ+WQyB/8d4hGJN
         l7Nw==
X-Gm-Message-State: AOJu0YwyyPRY6dBlBGqfdCzk8IiajNK9MF95h5NWTgt1BmnKrQkUwcW3
	YZK9XhK7hFZ08zMgaK9etqI0TX36a6TLq5lsCcY50mUe2NHtOUjBRs/L8en1auUbmOxNVb3Z4iB
	44nfHJw==
X-Received: from pgjw1.prod.google.com ([2002:a63:fb41:0:b0:c79:788d:5b72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ad98:b0:3a2:e0d3:37d2
 with SMTP id adf61e73a8af0-3b427f97d94mr1274269637.35.1780093370067; Fri, 29
 May 2026 15:22:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:49 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-7-seanjc@google.com>
Subject: [PATCH v3 06/40] KVM: x86: Rename kvm_cache_regs.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
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

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
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
index 585a8ceab220..b566ab5c7515 100644
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
index 4e34f75e705d..15777869b292 100644
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
index 7d8a433b5c5e..d4bfda10f1df 100644
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
index 87c6b105deef..cbc716885398 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -23,7 +23,7 @@
 #include <asm/sev-common.h>
 
 #include "cpuid.h"
-#include "kvm_cache_regs.h"
+#include "regs.h"
 #include "x86.h"
 #include "pmu.h"
 
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
index cbc2034d7924..bb19f6df921b 100644
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
index 634a6d0197f6..4fe2fb3ceba6 100644
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
index a49424f9c968..a6b2be462e6d 100644
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
2.54.0.823.g6e5bcc1fc9-goog

