Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71554C224C;
	Fri,  2 Oct 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953165; cv=none; b=h94E+oYkIUs4ZO+OaVdOTZWNDnXjkxHvCkwCkOjWCHfvZERhlXYlzNts0Oh5AQXJt2OS8saRb+RqnRLtQVOfo+iKTPGq7DiZiLL0oniru1NTr6ik6sQw+IQ15eKkLqlhLXzYmZQKMDgUkG2W+pQBKUkm50JeKtuhkJxBj3NeVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953165; c=relaxed/simple;
	bh=uC2WMN65R+WMH7TyW3YPuGDpRjdHe0WL0w7NTxeyvEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3xNcQHZqzpzzhH9tNIm+fJueNky8LjcySgis4v+6PR0ya999uDefDhkJOMMTfloAyrbDfYZCBRvy3Ee9d+QkGd7Ov2WDsi/zFmBSiX1NbULvl5SujS1GiJKIXi5kyURhchkIKVjv0zfyO31tX7YPh7sqrHXRB8viTSnU3SgNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n818Yf6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n818Yf6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3C21F000FF;
	Fri,  2 Oct 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790953162;
	bh=FQgu8PxLp1TQfnPDbRTV1LqOMQgUeYDEJUcWtV+4kFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n818Yf6KgkrIEhYlX0R5K1dDKORE86leRSZFLB71TzF3bwxbPYcrfab2Tqx2BGukz
	 +oOX95ELDW4Atrg/zqeleBuvArpgu+CmQ9LsZ5xE0AMLufEXHS9FBVWGcjbpv8eSBo
	 0XXIEarH1syA7yEUmRqVqtsGpxwI5i597RJOgMgC6kWCqXkoI0DzVtXbOlHkwEkn15
	 NwhmQatr/BHdsdIMjRvuaLz5HhhiP4nhJpMvtanBgMfPu3xg0F4OJr5KpcdH222ozV
	 wbg4fuT0E6+oI4/qwuXSrbFGmUo1IXFgdyuOMX7tdiA6qsXfkZM/z+4D6/7MsnwtmM
	 +tLFl5u30VGWw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 50DE2198003A;
	Fri,  2 Oct 2026 10:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 10:59:20 -0400
X-ME-Sender: <xms:xca_atBbzmtBPaYrH9WkZ7rCOMTZTCogYmRaEmkMirPqE4b41MOEHg>
    <xme:xca_avc-RB_ZZYezn9hybRWER_x1Ta-lG7cnalUx--maFQ0VIgFzlcNMjKL56txal
    O5LPclGrBFa5tMDtM4yBuJokMVt3khfFSZC0_LJK7Ps1vL_L5-NH2E>
X-ME-Received: <xmr:xca_ahH5ESceGU23-UDnyPhKaF5ZSAf_rd3eRZQ39tsODfCRzXey7H3uLJ4>
X-ME-Proxy-Cause: dmFkZTGbWoDYYR3Zk3WswxaEEzG9LkXCRWIhP8uvmVR4O6ICqsmW1+0UV8heiACCQUwyua
    yylCcKg2BVO4Xyocw9MiLLa26H8dbon+aKaaIlvyQes08R2cvnls8HdN5vIXsa3gRLCl6j
    907yeCGyDaxGW1LpnCzdP2RRZT4rbLPcDrj8zkmACugOAk0aCyMMp/svS2UyiLTUmADNQz
    1sAHXgEjheCPii99bNRl+V814ThZ9qj5BmB6k5m+xQO+Yrfsk4bUK9DDjPhqOTgQedqB6Z
    eYxZxgylAAmtih7MoiGlkaCECQ39u+Hy6h2emhK4xf5lzPIehZ07wdo0UQS3r91BbZpjWh
    LwhxtKRXBhNhjXKgN6PX3c2JIl/e+JXuj+WLoeC3gHZnlBqY8l2Z+OPixePeUg/Cmsh4Ga
    eBdxXgBaNf3pWlivJ9rqtGSgRyiD5jM66D+3eXEf18IcN6PiCx8B+15ULOgP0uC+64GICl
    zZQsnkBmo7St5sMhhqidesRXCAVPnb6nqF3/q+34O1yKfopH98zSjMDea1Kwx9ZJfN1Miy
    Wk6APdINHu+TVUiG0W6ZspTD4YHHzPYtzwcpWCFFaaQuL7D7mfTc/0Xk9qOR70o3kWAhg6
    qPsmKpYu98IvudnRjBrU9CEwgahE8XtlB6xM5kZL5aWAA1PEbAcA43+cep1w
X-ME-Proxy: <xmx:xca_ahVj9JOWy5VMxjHh7G8Oc97rD1QNRavdjWBAwmuMyFuuqzmiBg>
    <xmx:xca_apxgN-y9bmKEbyg4B0YnHHrQ-8DyBz7s-l1gSTgQ9d_R64HJxQ>
    <xmx:xca_aktceatZN_GXAqNj7cGvDLuC4mIQ7KGCD0wxWqWytwKwqBrtuw>
    <xmx:xca_aiDUrHpYSdm_lHBFbPuEOPXsKH20tPNJalYnLmSIQF_fHCDlUw>
    <xmx:xca_aopATSg_O_klyBzafug8UuvJJJ1AuTpdkL3TxqPUIjKXdmE0XTbI>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 10:59:17 -0400 (EDT)
Date: Fri, 2 Oct 2026 15:59:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "rdunlap@infradead.org" <rdunlap@infradead.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Message-ID: <ar_GLgzxdWUdXn0Z@thinkstation>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
 <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
 <arZbBqArD9NqWPry@thinkstation>
 <c41ffc542bd677b71bcecbe4e2c2e2a3b605ffcf.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41ffc542bd677b71bcecbe4e2c2e2a3b605ffcf.camel@intel.com>

On Mon, Sep 28, 2026 at 11:07:52PM +0000, Verma, Vishal L wrote:
> On Fri, 2026-09-25 at 12:30 +0100, Kiryl Shutsemau wrote:
> 
> > 
> > All these #ifdefs in early_printk.c can go. X86_FEATURE_TDX_GUEST is a
> > disabled feature without CONFIG_INTEL_TDX_GUEST, so
> > cpu_feature_enabled() folds to zero and the compiler drops the
> > static_call_update() calls and the wrappers with them.
> > 
> > Add stubs for tdx_inb() and tdx_outb() to the #else branch in
> > <asm/tdx.h> and make the "tdx" case unconditional.
> 
> Tried this - it causes an objtool error:
> 
>      CC      arch/x86/kernel/early_printk.o
>    arch/x86/kernel/early_printk.o: error: objtool: bad .discard.annotate_insn entry: 4 of type 1
>    make: *** [Makefile:248: __sub-make] Error 2
> 
> It can be fixed by adding a __used annotation to the wrappers, but is that
> ok?
> 

ANNOTATE_NOENDBR_SYM() is a top-level asm() that references the symbol.
Once the compiler drops the wrapper, the annotation points at an
undefined symbol and objtool flags it.

__used makes it go away by keeping the dead wrappers in every non-TDX
kernel, which is the opposite of what dropping the #ifdefs was for.

Drop the wrappers instead.

Let tdx.c provide the accessors with the serial_in/serial_out signature,
__noendbr and annotated there, and declare them outside the #ifdef. No
stubs are needed: the only reference is under cpu_feature_enabled(),
which folds to zero without CONFIG_INTEL_TDX_GUEST.

Builds with TDX on and off.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d8887a2a524b..c5e16ea3844d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,23 +194,19 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
-/**
- * tdx_inb() - Read a byte from an I/O port without a #VE
- * @port: I/O port to read from
- *
- * Ask the VMM to perform the read with TDG.VP.VMCALL<Instruction.IO>, rather
- * than executing an IN instruction and having the resulting #VE emulate it.
- *
- * Return: the byte read, or 0xFF if the hypercall failed.
+/*
+ * early_printk accessors for a TDX guest. Ask the VMM to do the port I/O with
+ * TDG.VP.VMCALL<Instruction.IO> instead of executing IN/OUT and having the
+ * resulting #VE emulate it.
  */
-u8 tdx_inb(u16 port)
+__noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
 {
 	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = 1,
 		.r13 = TDVMCALL_PORT_READ,
-		.r14 = port,
+		.r14 = addr + offset,
 	};
 
 	if (__tdx_hypercall(&args))
@@ -218,20 +214,14 @@ u8 tdx_inb(u16 port)
 
 	return args.r11;
 }
+ANNOTATE_NOENDBR_SYM(tdx_serial_in);
 
-/**
- * tdx_outb() - Write a byte to an I/O port without a #VE
- * @value: byte to write
- * @port: I/O port to write to
- *
- * Ask the VMM to perform the write with TDG.VP.VMCALL<Instruction.IO>, rather
- * than executing an OUT instruction and having the resulting #VE emulate it.
- */
-void tdx_outb(u8 value, u16 port)
+__noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
 {
 	_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), 1,
-		       TDVMCALL_PORT_WRITE, port, value);
+		       TDVMCALL_PORT_WRITE, addr + offset, value);
 }
+ANNOTATE_NOENDBR_SYM(tdx_serial_out);
 
 static void __noreturn tdx_panic(const char *msg)
 {
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 325dd7c5929f..0bbabcf0791e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -83,9 +83,6 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
-u8 tdx_inb(u16 port);
-void tdx_outb(u8 value, u16 port);
-
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
@@ -98,6 +95,10 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+/* Only referenced when X86_FEATURE_TDX_GUEST is enabled, no stubs needed */
+unsigned int tdx_serial_in(unsigned long addr, int offset);
+void tdx_serial_out(unsigned long addr, int offset, int value);
+
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4);
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 194737a3e9a0..04dadcd73b85 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -112,23 +112,6 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
 DEFINE_STATIC_CALL(serial_in, io_serial_in);
 DEFINE_STATIC_CALL(serial_out, io_serial_out);
 
-#ifdef CONFIG_INTEL_TDX_GUEST
-/*
- * A TDX guest cannot execute port I/O instructions, so ask the VMM to do it.
- */
-static __noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
-{
-	return tdx_inb(addr + offset);
-}
-ANNOTATE_NOENDBR_SYM(tdx_serial_in);
-
-static __noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
-{
-	tdx_outb(value, addr + offset);
-}
-ANNOTATE_NOENDBR_SYM(tdx_serial_out);
-#endif /* CONFIG_INTEL_TDX_GUEST */
-
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
@@ -214,7 +197,6 @@ static __init void early_serial_init(char *s)
 	early_serial_hw_init(divisor);
 }
 
-#ifdef CONFIG_INTEL_TDX_GUEST
 /*
  * Use early_serial_base (COM1) and same default baud rate as
  * "earlyprintk=serial"
@@ -228,7 +210,6 @@ static __init void early_serial_tdx_init(void)
 
 	early_serial_hw_init(115200 / DEFAULT_BAUD);
 }
-#endif /* CONFIG_INTEL_TDX_GUEST */
 
 static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
@@ -448,13 +429,11 @@ static int __init setup_early_printk(char *buf)
 			early_serial_init(buf + 4);
 			early_console_register(&early_serial_console, keep);
 		}
-#ifdef CONFIG_INTEL_TDX_GUEST
 		if (!strncmp(buf, "tdx", 3)) {
 			early_serial_tdx_init();
 			early_console_register(&early_serial_console, keep);
 			break;
 		}
-#endif
 #ifdef CONFIG_PCI
 		if (!strncmp(buf, "pciserial", 9)) {
 			buf += 9; /* Keep from match the above "pciserial" */
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
