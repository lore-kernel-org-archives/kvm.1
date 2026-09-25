Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE73DDDCD
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335852; cv=none; b=M9+3ql446+dTYJ0jQhrclTDmxfGXW3BjjfYXnC/P1RAFbFZKoyRmi6ftCzkiob06JnwIsrcgGCB3+rfNmZpc44T1NUzQZMGVFmu5B79cXwtxnd5mfY6qymEJHOIDOcRmPP61oMg7qqK7KcaaRWuI7h0Tpr1KoMl9S5y6anm9cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335852; c=relaxed/simple;
	bh=U5jzh/wrq5mofA952aJ0mIvvu9S4cjBPBZinv7n9nmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHZnjmDeiE3dRzuuuMPjCgPcJykGjO5KcNxh+vYCUsnV4q2JMM53W+MfRB8KQDXOfVypljVLe9CQ6smnAFTgUL4z3AutaSSPoWIQvNlDdKP+hAS1jDJ7dalXHsNTkFSklozdhRnfL3wjTflQBrRgiPr0IZ9EMP9mEdxzh0H7oXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+DieUdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+DieUdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7A81F00898;
	Fri, 25 Sep 2026 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790335851;
	bh=PfKUWWPdibuZbpDvMSuWg21M+osPtSxvRUv3Zz8XAbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+DieUdDJaQJ3vhMc/+aNjb2JCyKLh3KSGijRAQptqKjnoVZrI7MT66wEVvlrqR6m
	 vOgZjec0TFiJQSTBkC0rhQBT7Yayy701HgSnPLCjTiZmZ8L1++Sik0eYEgFuzGi4gG
	 WwWuW0y5ckhXEdhIRshUeCzog47TAOHgA1zJk+PrkmO+/C+DRDS6tpMsW3rQdypDkZ
	 UiRoJLU759uHMqJACeaGDjFbUtSpRXfBly9R46krrvDhNzne10c9HcE6jzjjf8GQRm
	 mZu7dXKx1gKzd43QQRRQBI75rUzEr26V1z3hMfC8ED7wRox3ypBXxISukzL7Nq2p9p
	 ECyKMIdG4rn8w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 933EF198005A;
	Fri, 25 Sep 2026 07:30:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 07:30:49 -0400
X-ME-Sender: <xms:Z1u2apWjZllxcj6kK4bVg0P5jl8VllepPzWD9fm2nyl_exwNWa32zQ>
    <xme:Z1u2atjLMRlQXRdwVw6X6V9pHfwUGE6j9HVEkT-nw9AmXTjDek7I2YvfSLpAtUoCH
    NjGVGNmQOKWapgM9IqE8Spimx15R8KAMkGGP3eRmt_8bFn7LFYfbb9Gnw>
X-ME-Received: <xmr:Z1u2at4aNfujvh_mA6DpP4jN_jCKqCLeleZbPWrEsn2gdc6KdwMvVFlelnI>
X-ME-Proxy-Cause: dmFkZTE8J5BbVZeb+640mllbYW7069CIPU8sTayV1dW0ccjnVUHaZmhv7bVQePrG7CDBvl
    JGmq9rRiegi1EaWX2c5A6tgH3GTS3+iAEsrO6HT2SvGPAxpy+8GZCbAHjYUrtaEOUgTWgR
    ShEdiElsRKBIlvFVQhElHtBq3poKvlNgT65xtg+qsDapXeostnjxPG0YW7uyKEADovgRt1
    gWj9lT9SeM949b+99O6Q1rTHGHhhbFQP6gRsd289+Qng067FXCWRyzXqYTu0VWJw+q8ikJ
    eoQhQgcP9ssyGGYoBdOn3J5nA2iym/ys5UPhkv+KYq4LkbEGy6ZghHZcqTLL+DNSCFAUq9
    beIykgW/Yg/RG5At6oq2aXHFQQ7D9g7FiD/0upGjbC8SDxo1aLWvmTQtI7NrjTwnAega4+
    GLph1/wDjudg3rVkegKME9VBwI6/4EZW7iJ10eQqyC0E/HUyAzWsMnKJD4AZsLyjQHJaLO
    ixu/oMQTJ2GcOd7DRHM+o7PIxACA6d0IseizbBuXP6rNLpAGjxJHqS3YyYkMUpZ7eSwxZN
    voHz42S6mDzt4tNC4O/dr1cV8mZkaSi6K2M/mC5si2oRAMYoHRU3RSvP9HaUZdrnV/IiZ4
    NJZzfOJTKkqs/w0qqfFiXjQnuHO/Fev22aZ2dkR91mO9BVYjdaE6w0m/Jc3w
X-ME-Proxy: <xmx:Z1u2al71Q2aP0qO8DflnE2s5yDNAHJnsGoVgdP68j73FPgwYBJvTSw>
    <xmx:Z1u2arE_0h4Ou9Po-tlACd4XZxWzZa5adTZPqlPJNuj4sWr2xp6eXw>
    <xmx:Z1u2ajw2MzlTWeBxFJSpxCEzUwK8VWpB7heTMCwTDUMvda_FaK2XoA>
    <xmx:Z1u2ar0lybSr2AgK4Kn2gnTHVJ5jvqCq-sMkyP3a_KgvLBuy6TpEAw>
    <xmx:Z1u2amMOa7qBHTwGtR0adYkOCnpEUz_1u_9CTwMyNHBi2WSvbZ7tChlK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 07:30:46 -0400 (EDT)
Date: Fri, 25 Sep 2026 12:30:45 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Message-ID: <arZbBqArD9NqWPry@thinkstation>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
 <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>

On Tue, Sep 22, 2026 at 02:20:07PM -0600, Vishal Verma wrote:
> @@ -111,6 +112,23 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
>  DEFINE_STATIC_CALL(serial_in, io_serial_in);
>  DEFINE_STATIC_CALL(serial_out, io_serial_out);
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +/*
> + * A TDX guest cannot execute port I/O instructions, so ask the VMM to do it.
> + */
> +static __noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
> +{
> +	return tdx_inb(addr + offset);
> +}
> +ANNOTATE_NOENDBR_SYM(tdx_serial_in);
> +
> +static __noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
> +{
> +	tdx_outb(value, addr + offset);
> +}
> +ANNOTATE_NOENDBR_SYM(tdx_serial_out);
> +#endif /* CONFIG_INTEL_TDX_GUEST */
> +
>  static int early_serial_putc(unsigned char ch)
>  {
>  	unsigned timeout = 0xffff;
> @@ -196,6 +214,22 @@ static __init void early_serial_init(char *s)
>  	early_serial_hw_init(divisor);
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +/*
> + * Use early_serial_base (COM1) and same default baud rate as
> + * "earlyprintk=serial"
> + */
> +static __init void early_serial_tdx_init(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		static_call_update(serial_in, tdx_serial_in);
> +		static_call_update(serial_out, tdx_serial_out);
> +	}
> +
> +	early_serial_hw_init(115200 / DEFAULT_BAUD);
> +}
> +#endif /* CONFIG_INTEL_TDX_GUEST */
> +
>  static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
>  {
>  	u32 __iomem *vaddr = (u32 __iomem *)addr;
> @@ -414,6 +448,13 @@ static int __init setup_early_printk(char *buf)
>  			early_serial_init(buf + 4);
>  			early_console_register(&early_serial_console, keep);
>  		}
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +		if (!strncmp(buf, "tdx", 3)) {
> +			early_serial_tdx_init();
> +			early_console_register(&early_serial_console, keep);
> +			break;
> +		}
> +#endif

All these #ifdefs in early_printk.c can go. X86_FEATURE_TDX_GUEST is a
disabled feature without CONFIG_INTEL_TDX_GUEST, so
cpu_feature_enabled() folds to zero and the compiler drops the
static_call_update() calls and the wrappers with them.

Add stubs for tdx_inb() and tdx_outb() to the #else branch in
<asm/tdx.h> and make the "tdx" case unconditional.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
