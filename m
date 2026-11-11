Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376815;
	b=RvP4HSw4iuA4NFX8vnGszBlYksiBtGrLK6cj+FhwF8A9a8OrtnhiRAZLPIZPZlSUjtnX
	 YVfM5g3PpYs2hADJmDgzQM0XNCSXTcJaqEm8WLUyyepoNjeVKJbIJAfeGHaMZbqqgT1xV
	 PIY5FtQF1aAErvukX3T0Upa2uBi2WfQyHvi5ca7VbMG9aUr1X2QJTD3UazwxW4ug1Dhrd
	 8OC0R9qdiUte30P5RLj8tT9pvduBSSPoNkpiRC5uwRbCRTJs1QxlGH2jpqP+PTQPdAns6
	 lv1tRXCVtJaAfg0Yd/GuEVL9rgZW+/19BkiTtRyQ+tKdE1oPfDa/vSYpRoUosi32IPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376815;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=7MFXZIdj2HlQkbhckc0+l+zCwbBlVh492hcyewGBnHg=;
	b=ewRWZzn+DkZcd+MPa3EyqAmQ0H8sgDE/sUMHmrRzokcKPggLIYLpALFa44GJOFSEY9md
	 0Lk6Dk/qc2TJavS3S7SDE/Fh+Ksd8A+3fNihTzyGVYTvLnrufhDUK2RgSGsb7GhebiNFz
	 aE+uSKko75JAfStkEXOSApAzR1uyY1Iyd9jqgWfhFCzqwaA8R7I4WoRs/8URjsaKeb0/9
	 yVKY79CeF67PI4erpiNK3+Roq56E7bF/dyUQN09fMC+4bCOyKgCyzzIgqf83z1v4Xdq5i
	 CONw0sIVpuptopI1FiUmEyG3JTtWM5OvRW/Gq5QFCKg3t/KmswLZWUeHpYZVVDGfAdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=B7pcuPJ1;
	arc=none smtp.remote-ip=209.85.222.97
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652760A5BC6
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8652760A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=B7pcuPJ1
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-99c0c1d07feso1269602241.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376814; x=1794981614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MFXZIdj2HlQkbhckc0+l+zCwbBlVh492hcyewGBnHg=;
        b=djs+w1OGxrN49Heb3aW7ee+EeYi3qHLyxHQspp77tjzVg8HxL3itxY8/dGJetd/E4R
         ZG39al4fzPUVPdBLkp8Hc86rHiWWQcP83OQWt6O+hgtbWjOStIUokDEpPpRKuy14DPAO
         shtBlU8pJMNMbjcMmzrDSk/b7FtBmgJjoptmh8UcGX4stbTJV31J1ikf+um8V3zTRiv0
         vWxH7JPMsy2oJWRhNy95hy/QBU5htvuJvZkt2HuUcFgQFp61gr0yohJTYXysP4Jhd+o9
         ukTS4a51n6D4C7EoyQSOiv1LR4Cjbioju29wNN4EgpF3ZM5Siwct4UckLeIvH1wuBrsW
         An7g==
X-Forwarded-Encrypted: i=1; AL+hErHQ68BBBRI/0Lq8T1Fy83JjYPvDARcUqV9b2lEGc90rKGZi3o+8guvNhB8mQR1vLqs2JUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cFf89SAeJXtJUahPtNQtaBiXo6fFYc3pjX97hXHX4dLR1sgeg
	5bofpiB7B4wl8Ffgxz6qyksVSJlk9qAOj+WA/QQo0DPRjm0hTqL6m56sfF6s4WShT5c96wist7A
	Kd8NkG3WNuDdO/RSUvDGT0B4C3PoUDhQ8hUA9esusC3fd+db00TLHDFws/e3LvOb9gfIxQbQ+mb
	q4dC3EpvF0Xpcol3RSemCC9wLbito64EZFX9RNhSmfSPOWxgLbIJ1ppAFBOGiLLK+JVjOYomG/Q
	pjz
X-Gm-Gg: AYBFou0mJIsEr2oiaVqv5w5rc1E/x1F+uxf/EPm1j7WknjcH/5C5fPYz04OtuCTHpl2
	7r771ePM7et21LjsjT8G8+6cxe2VzY2WSENydOlqvFEquJY3F+zzjj9/jMyQAFkpHFXksBn0aCc
	5tFa0Lhs2Iig7uTkhvIjp8wUXF0zcmZIQanCDGv1ZBPXsogIC2m/tTLH88UcRnYylG4cpYXoEcv
	52OJtcpM/Q6w3i66QO8FxaoMuePRVXIi47avAweRVgaeCdm9RRHJz+ZAvHfPlNjllUJxLTsR+zK
	XHOuVWxvFqWa8kxc/Q9uSufKXtOGm7NZI8toNOrf2g4amWhougchbbtLz0Z1bqb+MmiUNplorc6
	fYjh0g+vOyds/quR77X9njcPau1TESiap6zPLGN04yWVcMfpjuKK6UpQdikhKQhGW5p3i4GZeuh
	q7vfzI2ln4WnvXUYmYSskzCSJUXHoDVNET
X-Received: by 2002:a05:6102:50a0:b0:7d0:6cf3:d8f6 with SMTP id ada2fe7eead31-7d5060e8bdamr469983137.28.1794376814418;
        Tue, 10 Nov 2026 22:00:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7d3020a17dfsm43946137.0.2026.11.10.22.00.13
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f6f4fe531so514625885a.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376813; x=1794981613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MFXZIdj2HlQkbhckc0+l+zCwbBlVh492hcyewGBnHg=;
        b=B7pcuPJ1efyA1P+iJnKBh8O1jxhnkgCcMcREwSTUwfGHjuPhVBLLiFlcKfgOAcQ7yz
         6FRSzMJfUCl+GRc3inYvOA6PxXLySDa5B9K9UtvCfmn7S/A+usowmFcGcBCA1xvG1OqA
         wXMX9H776YjKzm4bSqGi0z7bzo8UPT+5FNrmM=
X-Forwarded-Encrypted: i=1; AL+hErEqeDojMceRqRp7iaaitrlQ3moYAwTBFtb4BxiV2B3rDRkPvDKgZ1m9C8phKNvkjZV7D5U=@vger.kernel.org
X-Received: by 2002:a05:620a:28c8:b0:945:c3b7:e704 with SMTP id af79cd13be357-947aff8dcf0mr206705285a.39.1794376812400;
        Tue, 10 Nov 2026 22:00:12 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:945:c3b7:e704 with SMTP id af79cd13be357-947aff8dcf0mr206700585a.39.1794376811878;
        Tue, 10 Nov 2026 22:00:11 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:07 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 02/12] KVM: x86: Move VMware backdoor support to separate files
Date: Wed, 11 Nov 2026 00:59:51 -0500
Message-ID: <07581ff5998d40092c2f171ffe1fb05ac48f9446.1794374897.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Move the enable_vmware_backdoor module parameter, the VMware backdoor
port and pseudo-PMC definitions, and the VMware pseudo-PMC and opcode
helpers out of x86.c, emulate.c and pmu.{c,h} into new vmware.{c,h}
files, and add a MAINTAINERS entry for the new files.

KVM's VMware emulation is spread across the emulator, the PMU code and
x86.c, and both vendor modules read the module parameter directly.  The
following patches make the VMware interfaces a per-VM setting, add a
userspace exit for VMware hypercalls and allow compiling the emulation
out.  Collect the code in one place first, as KVM already does for
Hyper-V and Xen emulation, so that those changes stay local and the
code movement can be reviewed on its own.

No functional change intended.

Link: https://lore.kernel.org/r/aIEgVpjXDR0BXgHq@google.com
Link: https://lore.kernel.org/r/aIEwOToiAkKfQA-4@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 MAINTAINERS            |  9 +++++
 arch/x86/kvm/Makefile  |  3 +-
 arch/x86/kvm/emulate.c |  4 +--
 arch/x86/kvm/pmu.c     | 35 +-----------------
 arch/x86/kvm/pmu.h     |  5 ---
 arch/x86/kvm/svm/svm.c |  1 +
 arch/x86/kvm/vmware.c  | 81 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmware.h  | 22 ++++++++++++
 arch/x86/kvm/vmx/vmx.c |  1 +
 arch/x86/kvm/x86.c     | 36 +------------------
 arch/x86/kvm/x86.h     |  2 --
 11 files changed, 119 insertions(+), 80 deletions(-)
 create mode 100644 arch/x86/kvm/vmware.c
 create mode 100644 arch/x86/kvm/vmware.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..017053e8f76e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15042,6 +15042,15 @@ F:	arch/x86/kvm/svm/hyperv.*
 F:	arch/x86/kvm/svm/svm_onhyperv.*
 F:	arch/x86/kvm/vmx/hyperv.*
 
+KVM X86 VMWARE (KVM/VMware)
+M:	Zack Rusin <zack.rusin@broadcom.com>
+M:	Doug Covelli <doug.covelli@broadcom.com>
+L:	kvm@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
+F:	arch/x86/kvm/vmware.*
+
 KVM X86 Xen (KVM/Xen)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Paul Durrant <paul@xen.org>
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index c6bf463f5032..0cb47cfc1162 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -6,7 +6,8 @@ ccflags-$(CONFIG_KVM_WERROR) += -Werror
 include $(srctree)/virt/kvm/Makefile.kvm
 
 kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o msrs.o pmu.o regs.o \
-			   mtrr.o debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o
+			   mtrr.o debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o \
+			   vmware.o
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_IOAPIC) += i8259.o i8254.o ioapic.o
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..a7bcde6f0359 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -33,6 +33,7 @@
 #include "tss.h"
 #include "mmu.h"
 #include "pmu.h"
+#include "vmware.h"
 
 /*
  * Operand types
@@ -2523,9 +2524,6 @@ static bool emulator_bad_iopl(struct x86_emulate_ctxt *ctxt)
 	return ctxt->ops->cpl(ctxt) > iopl;
 }
 
-#define VMWARE_PORT_VMPORT	(0x5658)
-#define VMWARE_PORT_VMRPC	(0x5659)
-
 static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
 					    u16 port, u16 len)
 {
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ca6dfb44949f..ae7000c44677 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -23,6 +23,7 @@
 #include "cpuid.h"
 #include "lapic.h"
 #include "pmu.h"
+#include "vmware.h"
 
 /* This is enough to filter the vast majority of currently defined events. */
 #define KVM_PMU_EVENT_FILTER_MAX_EVENTS 300
@@ -716,40 +717,6 @@ int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 	return kvm_pmu_call(check_rdpmc_early)(vcpu, idx);
 }
 
-bool is_vmware_backdoor_pmc(u32 pmc_idx)
-{
-	switch (pmc_idx) {
-	case VMWARE_BACKDOOR_PMC_HOST_TSC:
-	case VMWARE_BACKDOOR_PMC_REAL_TIME:
-	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
-		return true;
-	}
-	return false;
-}
-
-static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
-{
-	u64 ctr_val;
-
-	switch (idx) {
-	case VMWARE_BACKDOOR_PMC_HOST_TSC:
-		ctr_val = rdtsc();
-		break;
-	case VMWARE_BACKDOOR_PMC_REAL_TIME:
-		ctr_val = ktime_get_boottime_ns();
-		break;
-	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
-		ctr_val = ktime_get_boottime_ns() +
-			vcpu->kvm->arch.kvmclock_offset;
-		break;
-	default:
-		return 1;
-	}
-
-	*data = ctr_val;
-	return 0;
-}
-
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..3fc2ce713b6f 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -17,10 +17,6 @@
 #define fixed_ctrl_field(ctrl_reg, idx) \
 	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
 
-#define VMWARE_BACKDOOR_PMC_HOST_TSC		0x10000
-#define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
-#define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
-
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
 
 struct kvm_pmu_ops {
@@ -287,7 +283,6 @@ void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu);
 
-bool is_vmware_backdoor_pmc(u32 pmc_idx);
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu);
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 721dc5e7e13a..980841d153f3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -9,6 +9,7 @@
 #include "smm.h"
 #include "cpuid.h"
 #include "pmu.h"
+#include "vmware.h"
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/kvm/vmware.c b/arch/x86/kvm/vmware.c
new file mode 100644
index 000000000000..772f295f8ff5
--- /dev/null
+++ b/arch/x86/kvm/vmware.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM VMware emulation support
+ *
+ * Copyright (C) 2025-2026 Broadcom. All Rights Reserved. The term
+ * "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#include <linux/moduleparam.h>
+
+#include "kvm_emulate.h"
+#include "vmware.h"
+
+bool __read_mostly enable_vmware_backdoor;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_vmware_backdoor);
+module_param(enable_vmware_backdoor, bool, 0444);
+
+bool is_vmware_backdoor_pmc(u32 pmc_idx)
+{
+	switch (pmc_idx) {
+	case VMWARE_BACKDOOR_PMC_HOST_TSC:
+	case VMWARE_BACKDOOR_PMC_REAL_TIME:
+	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
+		return true;
+	}
+	return false;
+}
+
+int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data)
+{
+	u64 ctr_val;
+
+	switch (idx) {
+	case VMWARE_BACKDOOR_PMC_HOST_TSC:
+		ctr_val = rdtsc();
+		break;
+	case VMWARE_BACKDOOR_PMC_REAL_TIME:
+		ctr_val = ktime_get_boottime_ns();
+		break;
+	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
+		ctr_val = ktime_get_boottime_ns() +
+			vcpu->kvm->arch.kvmclock_offset;
+		break;
+	default:
+		return 1;
+	}
+
+	*data = ctr_val;
+	return 0;
+}
+
+bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt)
+{
+	switch (ctxt->opcode_len) {
+	case 1:
+		switch (ctxt->b) {
+		case 0xe4:	/* IN */
+		case 0xe5:
+		case 0xec:
+		case 0xed:
+		case 0xe6:	/* OUT */
+		case 0xe7:
+		case 0xee:
+		case 0xef:
+		case 0x6c:	/* INS */
+		case 0x6d:
+		case 0x6e:	/* OUTS */
+		case 0x6f:
+			return true;
+		}
+		break;
+	case 2:
+		switch (ctxt->b) {
+		case 0x33:	/* RDPMC */
+			return true;
+		}
+		break;
+	}
+
+	return false;
+}
diff --git a/arch/x86/kvm/vmware.h b/arch/x86/kvm/vmware.h
new file mode 100644
index 000000000000..debabaff9654
--- /dev/null
+++ b/arch/x86/kvm/vmware.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_X86_VMWARE_H
+#define __KVM_X86_VMWARE_H
+
+#include <linux/kvm_host.h>
+
+struct x86_emulate_ctxt;
+
+#define VMWARE_BACKDOOR_PMC_HOST_TSC		0x10000
+#define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
+#define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
+
+#define VMWARE_PORT_VMPORT	(0x5658)
+#define VMWARE_PORT_VMRPC	(0x5659)
+
+extern bool enable_vmware_backdoor;
+
+bool is_vmware_backdoor_pmc(u32 pmc_idx);
+int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data);
+bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt);
+
+#endif /* __KVM_X86_VMWARE_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68fa251dda60..d407eecf1034 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -68,6 +68,7 @@
 #include "trace.h"
 #include "vmcs.h"
 #include "vmcs12.h"
+#include "vmware.h"
 #include "vmx.h"
 #include "x86.h"
 #include "x86_ops.h"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cd9ee316aad..389ae6213c85 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -31,6 +31,7 @@
 #include "pmu.h"
 #include "hyperv.h"
 #include "lapic.h"
+#include "vmware.h"
 #include "xen.h"
 #include "smm.h"
 
@@ -191,10 +192,6 @@ module_param(min_timer_period_us, uint, 0644);
 static u32 __read_mostly tsc_tolerance_ppm = 250;
 module_param(tsc_tolerance_ppm, uint, 0644);
 
-bool __read_mostly enable_vmware_backdoor = false;
-module_param(enable_vmware_backdoor, bool, 0444);
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_vmware_backdoor);
-
 /*
  * Flags to manipulate forced emulation behavior (any non-zero value will
  * enable forced emulation).
@@ -6291,37 +6288,6 @@ static bool kvm_vcpu_check_code_breakpoint(struct kvm_vcpu *vcpu,
 	return false;
 }
 
-static bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt)
-{
-	switch (ctxt->opcode_len) {
-	case 1:
-		switch (ctxt->b) {
-		case 0xe4:	/* IN */
-		case 0xe5:
-		case 0xec:
-		case 0xed:
-		case 0xe6:	/* OUT */
-		case 0xe7:
-		case 0xee:
-		case 0xef:
-		case 0x6c:	/* INS */
-		case 0x6d:
-		case 0x6e:	/* OUTS */
-		case 0x6f:
-			return true;
-		}
-		break;
-	case 2:
-		switch (ctxt->b) {
-		case 0x33:	/* RDPMC */
-			return true;
-		}
-		break;
-	}
-
-	return false;
-}
-
 static bool is_soft_int_instruction(struct x86_emulate_ctxt *ctxt,
 				    int emulation_type)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 43850b524774..4d0a8558d931 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -718,8 +718,6 @@ static inline bool kvm_mpx_supported(void)
 
 extern unsigned int min_timer_period_us;
 
-extern bool enable_vmware_backdoor;
-
 extern int pi_inject_timer;
 
 static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
-- 
2.53.0

