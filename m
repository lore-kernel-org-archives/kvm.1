Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CD43DED0;
	Fri, 11 Sep 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123796; cv=none; b=hLURehedxTsnFnh7i8t30Ucdqgy9RKe9FXy0H2kngKS6sw6siLYA7o7/rLjmyRurW+00EhqQpj0W6nZBX4w9LSDIGUC+cknWSgRhLShY8PoS3rc/Gs97xGWka5dXx/Z2Bi1WOU8UYA1sNWoi55VFFoB/OmTc5Ax0KxMdWNLXvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123796; c=relaxed/simple;
	bh=wdOiiLDftrw4TvTW7k6IHdiSAnxVv8KveEnrX532eYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7pPeSJpyB+W5YyTn/RVTpl28Y+NWFLJ353UnUp6riFs0hHQest+72TWLcl9oRMmrbyQK9U3KCv96UkiWIQD+QAU+c+KWaEfeZ9ALJyrBYAeC/t+GeQp3vFCLW1K1v/BtBwSV6n6J7qnUe0f99hjL1wA3Sb46GIOtF3E9QZnXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSw896fM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSw896fM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134731F00893;
	Fri, 11 Sep 2026 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123793;
	bh=PBdHf50yElbEI2XH2BFOw3HXA7rmzyQctSda0/ZC3Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSw896fMZLbH49qZo3C/q05VW4JGGOtU3zVE6/Rq2GRth7mdxYwtJPrGMsIPYd0pt
	 SRPQvetq1t/3IeJ3GC6VezWnSDVetJ6Hj5UeqXpmpCgmV5v42GOpWt8+vPMDhz6/W9
	 Cq2rDXSPr0qTWmTyNp3ET1pPuTTyLZlgOsLfnTySKF4QxGolMRKaxr4C6ivmdF8+Bi
	 YqAJ26oPCyEiR61gx/4XRs8Xf6bp3fIoZE10D23yqGtfL4SxmOGOWkA5oUO8UU04e+
	 bIdAEeYcoaXXtw/VXHqnMCT2p7dCj/18gR2+vXovoR8gLo8JUNoXzkqKdI5lQg6J7k
	 8b8lQR2/OV6sw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 58032198005E;
	Fri, 11 Sep 2026 06:49:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 06:49:51 -0400
X-ME-Sender: <xms:zdyjak8jAS-z_VZAXL-15KnCZib-odxhNNTAsrx6yFh5sTxfzQXZDw>
    <xme:zdyjakTSmm5W-JxTbXc8FCxPJqwocB6K90f-HQii6lY221KzMa7j_dN0zb6eJu0wI
    Szija55ntqM_-Ud1KWD2YJdwH7hWZjhp5u-GRVNLHTiIU4AWudJBLE4DQ>
X-ME-Received: <xmr:zdyjapqpLxouosxyJmPxGUsmCeIBdUwIf4d_mrZUAdO3PYNYHRpjAttFtZ4>
X-ME-Proxy-Cause: dmFkZTGi3P5f7MSXTQ+Rc8qEyK4R3Tlks18kg+mdwwCiCy+sdfagkVUcacLR37tWn4ZlPU
    K55P6qVqHKNfhiy6hbrXL2MtWNVTqDegIPQ3yZP7VASJmXQLVsaZfejqn35yDGzRfB3znR
    rFWkzAt4KbR1LSPSDCUwVsNPHc9uaOStKOHt0bccHp7T1/hd0wl6qj2LbE93pCTWqWW3wv
    tN99Av99mHjV8+HwyagFZxkP8Tg/IX9qatS5mDUj3ZabQp66y0BpOKwO7fEJ6/YJDGjaKk
    7FdTnL8FIKdr66i3oEqAhKE/WoZJQjDhpJZVck5mcKOgoJQwXSP2L4CITmLuVF3+H2o0U0
    mNCNa/ypuMcUFkFwwjP6EqVSsEg9R18MMTMUstyLQx0iCWe5iuQezzPhOZpQlnZdf5rbr0
    6MjVuz52Kq7eyBYbQ3HatXDeUSbs9mE1ZYIc9DJ79Y7t5y7GVh4SRWevEyGJaSAdl6Pxuv
    e7rNrFWmHcVHBNdnWSXBzK6Urn/+/giXFC2yWW2OPw7AJfsITLzZi9pLENobcuIGHA4rmd
    7ZVJKWtAT+1zegqLzNTPp/CYorNjyXWyFBq0hB562wNoDHqnrXy/w9R2pDAv1FAVsZLz2m
    pGVmYUNBHhuTqgGguaz3MqiOATKsukkAvtQF28mn2cadSRQWQZjzb+AQbWkA
X-ME-Proxy: <xmx:zdyjahPyVpItAtAAAn-i-72IdAsXgGmVXvrthXDWoLwPa02wSVuHdg>
    <xmx:zdyjavyrVyTH6ICCbkuzDbomX0xYr1DKJRuDszUXgDBYllUVyPOfHw>
    <xmx:zdyjalzgrjEjgm2xy9nTMbcYsI3SrlHgya4Z_ClBFOYYMD6CoT80cA>
    <xmx:zdyjagJL1FeEOyyDEafc7V2cHVIS2lpHEnHbSaZ--JG5jCByzQ4Txw>
    <xmx:zdyjapgHBtSj4Sb_1j-V8rVpyDhMjxaGi4fdV5NTrDXQ6SjCOyKFBOv0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 06:49:49 -0400 (EDT)
Date: Fri, 11 Sep 2026 11:49:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/early_printk: Avoid #VE emulation for TDX guest
 serial output
Message-ID: <aqPcbMxJiSGGMU-U@thinkstation>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
 <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>

On Thu, Sep 10, 2026 at 04:34:09PM -0600, Vishal Verma wrote:
> A TDX guest cannot execute port I/O instructions directly, but
> earlyprintk's serial console still issues plain inb()/outb() and lets
> each one fault into the #VE handler to be emulated as a TDVMCALL.
> 
> While that works, it is a roundabout way to get a character out.
> early_serial_putc() polls the LSR, and then writes a byte, but since the
> TDX guest can't directly do port I/O, a #VE exception is raised. The #VE
> handler must call TDG.VP.VEINFO.GET to find out what faulted, and then
> it can issue the TDVMCALL that does the actual work.
> 
> This makes #VE a functional mechanism for doing I/O, which is not
> desirable, is unnecessarily complicated and fragile, and results in
> twice the number of calls into the TDX module.
> 
> Instead, issue the TDVMCALL directly. In early_printk.c, port access is
> routed through static calls so the MMIO console can substitute its own
> accessors. Add a TDX pair and swap them in the same way.
> 
> Note that the output does not appear any earlier - "earlyprintk=" is an
> early_param(), so the console is still registered from
> parse_early_param(). This only changes how the bytes leave the guest
> once it is up.
> 
> LLMs were used under supervision to create this patch, to help
> understand the scope and mechanisms, create testing instrumentation
> (throwaway) to count #VEs before/after the change, and to drive lab
> machines to do this testing.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  arch/x86/kernel/early_printk.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index cba75306e5b6..4a70799cd80a 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -21,6 +21,8 @@
>  #include <linux/usb/xhci-dbgp.h>
>  #include <asm/pci_x86.h>
>  #include <linux/static_call.h>
> +#include <asm/shared/tdx.h>
> +#include <asm/vmx.h>
>  
>  /* Simple VGA output */
>  #define VGABASE		(__ISA_IO_base + 0xb8000)
> @@ -111,6 +113,48 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
>  DEFINE_STATIC_CALL(serial_in, io_serial_in);
>  DEFINE_STATIC_CALL(serial_out, io_serial_out);
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +/*
> + * A TDX guest cannot execute port I/O instructions, so ask the VMM to do it.
> + */
> +static __noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
> +{
> +	struct tdx_module_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
> +		.r12 = 1,			/* One byte */
> +		.r13 = TDVMCALL_PORT_READ,
> +		.r14 = addr + offset,
> +	};
> +
> +	if (__tdx_hypercall(&args))
> +		return UINT_MAX;
> +
> +	return args.r11;
> +}
> +ANNOTATE_NOENDBR_SYM(tdx_serial_in);
> +
> +static __noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
> +{
> +	/* One byte */
> +	_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), 1,
> +		       TDVMCALL_PORT_WRITE, addr + offset, value);
> +}
> +ANNOTATE_NOENDBR_SYM(tdx_serial_out);
> +
> +/* Substitute the hypercall accessors, but only in an actual TDX guest */
> +static __init void early_serial_tdx_init(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return;
> +
> +	static_call_update(serial_in, tdx_serial_in);
> +	static_call_update(serial_out, tdx_serial_out);
> +}
> +#else
> +static inline void early_serial_tdx_init(void) { }
> +#endif /* CONFIG_INTEL_TDX_GUEST */
> +

I don't particularly like this being in early_printk.c

Maybe coco/tdx/tdx.c should provide tdx_inb() and tdx_outb() helpers
that we just hook up here?



-- 
  Kiryl Shutsemau / Kirill A. Shutemov
