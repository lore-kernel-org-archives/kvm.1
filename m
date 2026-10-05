Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28F43F4BB;
	Mon,  5 Oct 2026 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240629; cv=none; b=gzTxTfJsRoKOGm8tweTLnkTyt55+WI3xt4jjdfSP7wXa6povGauT2s78qBe/juAFXqWoXwFscs+i1zgjdSHuoukQNT6nLtjt+YyUbMmbXFlFH5iMOwT3MOOocYlVr5gK+pXUplbSOYteCLyFlU8p/orIQfcvQTWn9ruLxUWyX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240629; c=relaxed/simple;
	bh=3hZBFPyundk9tWeTI4sVuy9MK+787aojzii6KnOyxzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyAcLEGUc7Z5HbnXx/xffGZlt5FBRAQjGg/CBmkXIW4U9mNlElsbAbfZNtB4uKUJwQJ9q93BIk9DYVGsCBSF0lHhd9e948MLMKsrleQiA9bciqq/RXi0uW8u4s/5LHAf8JYHozDv3gDPNUJjIGh9i5XyRuoQphYuvux5qA4Fx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqUUedpF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqUUedpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791240627; x=1822776627;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3hZBFPyundk9tWeTI4sVuy9MK+787aojzii6KnOyxzs=;
  b=CqUUedpFm2qziXXYkKjuyI9TDn5uZbSTiNmTVuk1aLsEBjLxvRNMEhuJ
   8wWF5eUOEuP8cLtQ9Ay+Pew5/m5wt4H0m/9WC6k05ltDJR8975/AZ98Zv
   tcOb7OyY8bGpoCzO0rp/i/6rY29+VkMGt/sTy55yxTQ27ESpLyWHlD4E1
   te+FaXkguTfMTqQ+erxChC5MF194/yujSAs5YSAEojVufkx2AoY57kR8o
   YG/kyyI5w47aXbInGVamVeA5+hPwxYKfgZ282IqGjcw/QIcypIYu63+oj
   iylW66WYDdU7oTirjjWAEqpPlhfB74l2TdRP3OUFM9mBYb93H1C6rnMWd
   Q==;
X-CSE-ConnectionGUID: VGb9JJY6RQ6nOwj8q3yCdw==
X-CSE-MsgGUID: /WCwaojDSgyd2PdDsriv1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94798749"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="94798749"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:24 -0700
X-CSE-ConnectionGUID: GKpV9rDMQqqowMkUjPtYEg==
X-CSE-MsgGUID: BKKM73jTQLyAR0W89EJEpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="277063571"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.108.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:23 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 05 Oct 2026 16:50:07 -0600
Subject: [PATCH v4 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=3hZBFPyundk9tWeTI4sVuy9MK+787aojzii6KnOyxzs=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFlHNFdu2fVRT/W+belffyaT41NXbMkvbXvUOZsl8omiz
 98UxqlTOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRh4UM/wOOLLJ4IHVbtO5V
 ToLAqUX7/Rt3f7HlPDK7K+X/34mimQEMv5gcuC9NjvGL9go5LukTwrI7IerDbaFk5TDHubcmnJC
 I5QQA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

A TDX guest cannot execute port I/O instructions directly, but
earlyprintk's serial console still issues plain inb()/outb() and lets
each one fault into the #VE handler to be emulated as a TDVMCALL.

While that works, it is a roundabout way to get a character out.
early_serial_putc() polls the LSR, and then writes a byte, but since the
TDX guest can't directly do port I/O, a #VE exception is raised. The #VE
handler must call TDG.VP.VEINFO.GET to find out what faulted, and then
it can issue the TDVMCALL that does the actual work.

This makes #VE a functional mechanism for doing I/O, which is not
desirable, is unnecessarily complicated and fragile, and results in
twice the number of calls into the TDX module.

Instead, add an earlyprintk=tdx option, which can issue the TDVMCALLs
directly. Add a pair of tdx_serial_in() and tdx_serial_out() accessors
and set them up in this case.

Note that the output does not appear any earlier - "earlyprintk=" is an
early_param(), so the console is still registered from
parse_early_param(). This only changes how the bytes leave the guest
once it is up.

LLMs were used under supervision to create this patch, to help
understand the scope and mechanisms, create testing instrumentation
(throwaway) to count #VEs in the serial vs tdx earlyprintk setups,
and to drive lab machines to do this testing.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 arch/x86/include/asm/tdx.h                      |  4 ++++
 arch/x86/coco/tdx/tdx.c                         | 29 +++++++++++++++++++++++++
 arch/x86/kernel/early_printk.c                  | 20 +++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..3e43e7c7385c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1546,6 +1546,7 @@ Kernel parameters
 			earlyprintk=serial[,ttySn[,baudrate]]
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
+			earlyprintk=tdx
 			earlyprintk=dbgp[debugController#]
 			earlyprintk=mmio32,membase[,{nocfg|baudrate}]
 			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
@@ -1559,6 +1560,13 @@ Kernel parameters
 			Use "nocfg" to skip UART configuration, assume
 			BIOS/firmware has configured UART correctly.
 
+			On x86, "tdx" is a fixed COM1 console, and takes no
+			options. In a TDX guest the port is driven with
+			TDVMCALLs rather than port I/O instructions, avoiding
+			the #VE exception that would otherwise be taken to
+			emulate every access. Outside a TDX guest it falls back
+			to port I/O, behaving like "earlyprintk=serial".
+
 			Append ",keep" to not disable it when the real console
 			takes over.
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..eac298979498 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -95,6 +95,10 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+/* Only referenced when X86_FEATURE_TDX_GUEST is enabled, no stubs needed */
+__noendbr unsigned int tdx_serial_in(unsigned long addr, int offset);
+__noendbr void tdx_serial_out(unsigned long addr, int offset, int value);
+
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7d1a93ee2534..c5e16ea3844d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,6 +194,35 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/*
+ * early_printk accessors for a TDX guest. Ask the VMM to do the port I/O with
+ * TDG.VP.VMCALL<Instruction.IO> instead of executing IN/OUT and having the
+ * resulting #VE emulate it.
+ */
+__noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
+{
+	struct tdx_module_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		.r12 = 1,
+		.r13 = TDVMCALL_PORT_READ,
+		.r14 = addr + offset,
+	};
+
+	if (__tdx_hypercall(&args))
+		return 0xFF;
+
+	return args.r11;
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_in);
+
+__noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
+{
+	_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), 1,
+		       TDVMCALL_PORT_WRITE, addr + offset, value);
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_out);
+
 static void __noreturn tdx_panic(const char *msg)
 {
 	struct tdx_module_args args = {
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index cba75306e5b6..04dadcd73b85 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -21,6 +21,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
 #include <linux/static_call.h>
+#include <asm/tdx.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -196,6 +197,20 @@ static __init void early_serial_init(char *s)
 	early_serial_hw_init(divisor);
 }
 
+/*
+ * Use early_serial_base (COM1) and same default baud rate as
+ * "earlyprintk=serial"
+ */
+static __init void early_serial_tdx_init(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		static_call_update(serial_in, tdx_serial_in);
+		static_call_update(serial_out, tdx_serial_out);
+	}
+
+	early_serial_hw_init(115200 / DEFAULT_BAUD);
+}
+
 static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
@@ -414,6 +429,11 @@ static int __init setup_early_printk(char *buf)
 			early_serial_init(buf + 4);
 			early_console_register(&early_serial_console, keep);
 		}
+		if (!strncmp(buf, "tdx", 3)) {
+			early_serial_tdx_init();
+			early_console_register(&early_serial_console, keep);
+			break;
+		}
 #ifdef CONFIG_PCI
 		if (!strncmp(buf, "pciserial", 9)) {
 			buf += 9; /* Keep from match the above "pciserial" */

-- 
2.55.0

