Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FF3B38B4;
	Mon, 21 Sep 2026 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020385; cv=none; b=O0HemlAy4tFlp/38MD2zYfpY89oT6ZMqO3Tn30WSuaoFzD6HIWBWpyhjU531n5Zia7aIdJBsq1j7s2DHLPH8OCXGad5gQ8aceP1JcYYENw9JGTfVqv1Ylpsg0n0yyvMzaGBKBSOiAXryzFCuqSaP6iyCsvlxg6Q3F5w7XtWFQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020385; c=relaxed/simple;
	bh=W498o8WnVx17/urOz4pvsvYQLkUTwiQaaBOsNKX2Gt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBHpZ4+7DIpf+HIbgrw6dXhfa8BGI1deKk0/qMYiptP2Y154EzfSl+tv+XJod507p64epj0dGlIqHXU2L2KiOfgxAI16G4HN08puCZCAiKO8aarb4GUnkXzpkx58fOpeRzrHNr+Q89n5cIXSW5gCQakB0K8xaaOColJzwnQQpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjT0KJl4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjT0KJl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790020382; x=1821556382;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=W498o8WnVx17/urOz4pvsvYQLkUTwiQaaBOsNKX2Gt8=;
  b=mjT0KJl4QASpQ0tP+SUXHRWDJ+d2diKtvANQJFjhEOMPQXYfAyKxkrM3
   AT6/vSBchQ6dWBAM2ElGKbLM0xP6pHynXa0hlToLPJOlQecwue+DCvkSl
   IO4RphWg6fMZjOsZed5zu6iFwaT2lkMd48SBpeQVNFEAlgf6oX+9pc7Q0
   CrSfjnne7iZb0BGJ/ZzCdRea29p/7xTp0dJSyoZad9jXwY/Ol/ifRdcUu
   l61fgW7x+o4VHgqVbigWCbxosVB+mdaCnIZh7zknfxCnQ4plZagtCPwJZ
   Py7TuysSmriGwzbLtJArY1sn0I0A2DpxnUHvrEy9lnoU8BiI1RWBKDAQZ
   w==;
X-CSE-ConnectionGUID: 7UFw56sjRKS6Rhgdlk6vaA==
X-CSE-MsgGUID: NVVnCYvxQ4KLPLZdL3+IOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90435115"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90435115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:53:02 -0700
X-CSE-ConnectionGUID: Lg7RJ1CDTKmANU0f8YVZ3g==
X-CSE-MsgGUID: cOjnP5h2TEqkL5DKzrOExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299041231"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.109.250])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:53:01 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 21 Sep 2026 13:52:38 -0600
Subject: [PATCH v2 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-tdx_earlyprintk_tdcalls-v2-2-ad1fde3f25fd@intel.com>
References: <20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com>
In-Reply-To: <20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=6861;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=W498o8WnVx17/urOz4pvsvYQLkUTwiQaaBOsNKX2Gt8=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFkbu6V7HXeo/Y83ixEXXitcxJP0VfV9n0rHbs4a6Qm2L
 NM5jH07SlkYxLgYZMUUWf7u+ch4TG57Pk9ggiPMHFYmkCEMXJwCMBHpQ4wM1/ra2+YkrJ9ZmHTh
 wMnd34svNW/7bHG/pTAp6tKVC4c3hzAyTN/0iHf+nz1PMyO3hh4vESq7zPt6acy8RM6WR091Ug5
 /YgAA
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
 arch/x86/coco/tdx/tdx.c                         | 39 +++++++++++++++++++++++++
 arch/x86/kernel/early_printk.c                  | 37 +++++++++++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..263a806afd2a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1543,6 +1543,7 @@ Kernel parameters
 			earlyprintk=serial[,ttySn[,baudrate]]
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
+			earlyprintk=tdx[,ttySn[,baudrate]]
 			earlyprintk=dbgp[debugController#]
 			earlyprintk=mmio32,membase[,{nocfg|baudrate}]
 			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
@@ -1556,6 +1557,14 @@ Kernel parameters
 			Use "nocfg" to skip UART configuration, assume
 			BIOS/firmware has configured UART correctly.
 
+			On x86, "tdx" is equivalent to "serial", except that
+			in a TDX guest the serial port is driven with
+			TDVMCALLs rather than port I/O instructions, avoiding
+			the #VE exception that would otherwise be taken to
+			emulate every access. Outside a TDX guest it falls
+			back to port I/O and behaves exactly like "serial".
+			If CONFIG_INTEL_TDX_GUEST is not set, it is ignored.
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
index 7d1a93ee2534..4377fcca2c99 100644
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
+ * Return: the byte read, or 0xff if the hypercall failed.
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
+		return 0xff;
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
index cba75306e5b6..2721e48783cd 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -21,6 +21,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
 #include <linux/static_call.h>
+#include <asm/tdx.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -111,6 +112,32 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
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
+
+static __init void early_serial_tdx_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return;
+
+	static_call_update(serial_in, tdx_serial_in);
+	static_call_update(serial_out, tdx_serial_out);
+}
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
@@ -414,6 +441,16 @@ static int __init setup_early_printk(char *buf)
 			early_serial_init(buf + 4);
 			early_console_register(&early_serial_console, keep);
 		}
+#ifdef CONFIG_INTEL_TDX_GUEST
+		if (!strncmp(buf, "tdx", 3)) {
+			buf += 3;
+			early_serial_tdx_init();
+			early_serial_init(buf);
+			early_console_register(&early_serial_console, keep);
+			if (!strncmp(buf, ",ttyS", 5))
+				buf += 5;
+		}
+#endif
 #ifdef CONFIG_PCI
 		if (!strncmp(buf, "pciserial", 9)) {
 			buf += 9; /* Keep from match the above "pciserial" */

-- 
2.55.0

