Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA04AB1A3;
	Tue, 22 Sep 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108468; cv=none; b=AraIQr++KbDtvhxtFfCGh6f1/h7E3sC3GZyKWSaRr8OqiRK/mzdDpqeCxXktg3a5MB4SaGX3Yju9t4IdgvnrgQ0IOt06TRC6Krn57H4dlvfJGgCfaWumCUFjOGWgpaKIgTRrFdjt5BNL8IgF3xXosSJhgDA9fLqa6yJiav7FCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108468; c=relaxed/simple;
	bh=LfqTiuToe7fF43mv5efr3OznHeOkkyK34UuQKPN6huo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhzsObTI2h5+Afr4jlzKmSuHo+fe5TUEjp3tcKIc7eZ3VIL+ylZuqLho8v0PtL9h4VCRaRGcnGPYjoaCygNuurWZeIuXvEcjVOf9rtE+WL8pNmJpjyKEVyofBpaMcrG2c5fXY9kOY14MpgkW0ZJLQMrx7LR2xY4e8T7Qw9Oq5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4rLk54d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4rLk54d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790108453; x=1821644453;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LfqTiuToe7fF43mv5efr3OznHeOkkyK34UuQKPN6huo=;
  b=T4rLk54dJVrvtyRmCNmjd/jX0mlhj+dSHFNcsSyRjOTTztoMjAFi5Qi/
   NK0MWFQVg+E+cCJY0O41v6MJ4W2AzD9vPxZcKqAAe+BcS0LyqKk7HmFvZ
   /GP/fotYJUtjyk1CY8PTlgO4Ww9r4LxIYvCbPZ4618oFpR4qxvGwnXegW
   CyMPHpE6xFhB0c2OpJgyn1Nn107Nc74ileJRuCLKO4YsDMVmzBtsjpx9D
   nJgCoGKZJH4/S2Ooi900TPoZy59mPYlX0dRda81PovM9rAugfQ9ti8Dxv
   hPTpvEnUTXGerauvOeNvYrhihNC/4XAISsusJei/e9D/TAAl0Vyzrfu5n
   w==;
X-CSE-ConnectionGUID: bYyW6nAeTTWJCh3lBBgvgA==
X-CSE-MsgGUID: WmB9i6bGQCG0u+EvmhXqwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101340438"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101340438"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:20:30 -0700
X-CSE-ConnectionGUID: VbC8ywc4RiGj0HieDxm3ag==
X-CSE-MsgGUID: Ev1uNTSKTW2KB+Xdpd4QXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="269799195"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.110.60])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:20:30 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 22 Sep 2026 14:20:07 -0600
Subject: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
In-Reply-To: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=7218;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=LfqTiuToe7fF43mv5efr3OznHeOkkyK34UuQKPN6huo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFmbHvPsTQyODz5Z/4DfxKDOY6ZK1MuCYPdJBY7/9cMCd
 E+9ML3WUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgImUaDMyXJKaFpgYtae5allX
 /Y2bZmunb3p+28LktPpzsUX/O5yE+RgZFvB7vM7WKHq9Sl26uv/yvyksh+8fNWYOO3X8RGuu1po
 p3AA=
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
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++++
 arch/x86/include/asm/tdx.h                      |  3 ++
 arch/x86/coco/tdx/tdx.c                         | 39 +++++++++++++++++++++++
 arch/x86/kernel/early_printk.c                  | 41 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..f8dac4a58327 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1543,6 +1543,7 @@ Kernel parameters
 			earlyprintk=serial[,ttySn[,baudrate]]
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
+			earlyprintk=tdx
 			earlyprintk=dbgp[debugController#]
 			earlyprintk=mmio32,membase[,{nocfg|baudrate}]
 			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
@@ -1556,6 +1557,14 @@ Kernel parameters
 			Use "nocfg" to skip UART configuration, assume
 			BIOS/firmware has configured UART correctly.
 
+			On x86, "tdx" is a fixed COM1 console, and takes no
+			options. In a TDX guest the port is driven with
+			TDVMCALLs rather than port I/O instructions, avoiding
+			the #VE exception that would otherwise be taken to
+			emulate every access. Outside a TDX guest it falls back
+			to port I/O, behaving like "earlyprintk=serial". If
+			CONFIG_INTEL_TDX_GUEST is not set, it is ignored.
+
 			Append ",keep" to not disable it when the real console
 			takes over.
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..325dd7c5929f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -83,6 +83,9 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+u8 tdx_inb(u16 port);
+void tdx_outb(u8 value, u16 port);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7d1a93ee2534..d8887a2a524b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,6 +194,45 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/**
+ * tdx_inb() - Read a byte from an I/O port without a #VE
+ * @port: I/O port to read from
+ *
+ * Ask the VMM to perform the read with TDG.VP.VMCALL<Instruction.IO>, rather
+ * than executing an IN instruction and having the resulting #VE emulate it.
+ *
+ * Return: the byte read, or 0xFF if the hypercall failed.
+ */
+u8 tdx_inb(u16 port)
+{
+	struct tdx_module_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		.r12 = 1,
+		.r13 = TDVMCALL_PORT_READ,
+		.r14 = port,
+	};
+
+	if (__tdx_hypercall(&args))
+		return 0xFF;
+
+	return args.r11;
+}
+
+/**
+ * tdx_outb() - Write a byte to an I/O port without a #VE
+ * @value: byte to write
+ * @port: I/O port to write to
+ *
+ * Ask the VMM to perform the write with TDG.VP.VMCALL<Instruction.IO>, rather
+ * than executing an OUT instruction and having the resulting #VE emulate it.
+ */
+void tdx_outb(u8 value, u16 port)
+{
+	_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), 1,
+		       TDVMCALL_PORT_WRITE, port, value);
+}
+
 static void __noreturn tdx_panic(const char *msg)
 {
 	struct tdx_module_args args = {
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index cba75306e5b6..194737a3e9a0 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -21,6 +21,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
 #include <linux/static_call.h>
+#include <asm/tdx.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -111,6 +112,23 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
 DEFINE_STATIC_CALL(serial_in, io_serial_in);
 DEFINE_STATIC_CALL(serial_out, io_serial_out);
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+/*
+ * A TDX guest cannot execute port I/O instructions, so ask the VMM to do it.
+ */
+static __noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
+{
+	return tdx_inb(addr + offset);
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_in);
+
+static __noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
+{
+	tdx_outb(value, addr + offset);
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_out);
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
@@ -196,6 +214,22 @@ static __init void early_serial_init(char *s)
 	early_serial_hw_init(divisor);
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
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
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
 static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
@@ -414,6 +448,13 @@ static int __init setup_early_printk(char *buf)
 			early_serial_init(buf + 4);
 			early_console_register(&early_serial_console, keep);
 		}
+#ifdef CONFIG_INTEL_TDX_GUEST
+		if (!strncmp(buf, "tdx", 3)) {
+			early_serial_tdx_init();
+			early_console_register(&early_serial_console, keep);
+			break;
+		}
+#endif
 #ifdef CONFIG_PCI
 		if (!strncmp(buf, "pciserial", 9)) {
 			buf += 9; /* Keep from match the above "pciserial" */

-- 
2.55.0

