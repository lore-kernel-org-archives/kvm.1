Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6B3B27F3;
	Thu, 28 May 2026 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963283; cv=none; b=BoHi6bQbyVCC8tgwgdA2Kc80zCzyKGzoE95ps0xfVSywgtdl2VX0Y3OTUne3qo/hJth59Sxny47AApzQFW8hJC/o5VKS1oLquDPmYPf1nOaCwtgbSzSqIbsZV2nokJajZeWBa79AoGUbNQgvw0InwrxQPfWoWmps9thQ/vpOekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963283; c=relaxed/simple;
	bh=m4+25JzQNvdWDOFNiQQVdqL5PtFe1RWFkEuW5tg3++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve3iiiU4daqqUthC6df7jZ+JxT+X2EQHDvbD9TFeO1EPTaaPaQPlIq1P0fy0/TJefYZvnvuSpTuLziWzTD3TsgHLD2L0M1KqRLfzpJN3frqjTwkP2NFaT8UdiNvYTdWvrn5Kjwgr8n8JINBN+zeujFKDXYTkoIvvwi9jOv8K/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMYFV6tR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMYFV6tR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C060B1F00A3C;
	Thu, 28 May 2026 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963281;
	bh=YvyaAJcJK/7KvdQ/8ZhakyrZoPX6sZ8C7c/SagKKUDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GMYFV6tRy4LLXNeDraGn7qZgHc2HCaY4ANEkiXfJF5JQ0OQQ3Q38CY2aWdByF4OQS
	 zo2xoV7Or8UR0VoTKgpUds5NF0A6FkF+ct6xCGUqByXAsDKeLOtZcWBovD55lBSP8M
	 xiI4vF/KoFTDooyT3YzfDigGvxr9UrpDxJ1g06QtwTpmgEe4svJG+X7fSfTrdrsMeE
	 qFqKUjCCbxixzJjsarXh5Q+AKjplluVNRDLVD0dOkCLO2Yn/bMhJrHuclbmwEi1snZ
	 ckq9f8jmq+EXdiCg/znxmwdaDIsrlIFVz6u4xMjNdfU2Yclg5nwZzM5YqpzhkiLbYT
	 vcUQT4T63b72A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 23316F40088;
	Thu, 28 May 2026 06:14:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 06:14:40 -0400
X-ME-Sender: <xms:kBUYamHMpMpX-OZMonbUjR1ddtENLoNSBawIu8pHskitTQ6wUn4v9g>
    <xme:kBUYajysxcJy3wghUO-WV06d5I4ByXS4xCx8mvcSi4-lrKBzktBkgQz7ab6ILX1Pl
    mFILnp3HR7GuGi9Uu3hclR32fO19vt3Fnz5we8vW6gJHJP4YtRyy8M>
X-ME-Received: <xmr:kBUYanaIFmGRe-Omh8e5qusDFNesiBCg1_drlnqpfOVbIJHe3V1boIElYJnH5A>
X-ME-Proxy-Cause: dmFkZTE8LHVvE96Rh1rjIrlZ2Ym67N4S/tJlgTasN+DE3s3y074Sn7tPF88Ayo8OjSCuNW
    ZxFSid4U2k/2bcAIa4k7x1vV3KQWzpyawU/ZkFErlgFffhpQSg1tB3e32SvOLTwx1KFqE1
    mbny0J19Da4hP4JSxzPcVTLls+u9ciUwEjrv0B3bXJYn90kbbaO8JwSv9963aC1gdkfsQJ
    HryKvV2ksJMaHxYM7u/3jx+27d42qXUIzVZVEU54YW9sFdlcTgowwm7DK3CHgeWycG9w7J
    G8gk6Pz2Te/zE5J5Y9/F3DlEawW+356E2nGFytclATAKUYC3gmXYUowFlHYt86wnzXFLMn
    iFXqQO05Axe/2zL9mo2aSkBz9WwaLsLq6CfCIkRdmDpFNc50LwTgBRSRGj0aexOgr6HeYK
    Zjk8p14+i1KOGCF+VlZfAmKZO3VgE47fVBzUbkKsxseS07HXWbFTPWluLDE/DdKsFVP+w9
    yQGtjAYLFgEzDQzg2UBN3JNWa9zEDcRhcIyZg2K0IA5eGq/srVsMuDCkh8EnEtH/sK1/zp
    YcjM2MsxipW0hps0vaMs29t9+sf1eVWmC3Fe/9gZS2fwMwDfDUj/B4OeW9ZJkjyqV9PRNE
    2g0D7toblHHJ45PkbKFjbS+WR66DOAXLxJGVOJs1lpAKxqU1kd4cwjdAjx7A
X-ME-Proxy: <xmx:kBUYamk6T3Mi8XPJ_PTWTHlYpj7C6xqYiSDNwVES1sGZsVKd4tnLqg>
    <xmx:kBUYasmZ5YGCpeWdCft-wvmSkCZUen6tLWUeczKXRf6xM2mjfqQLSw>
    <xmx:kBUYapMHuQBbzd_QR5pxbF286HrCZB6ZR8LWEy9uor15IibZT8jLFw>
    <xmx:kBUYampA_NVdaCgjemTyYYIxE3qsT1mhTk0zLeblH8dxM56Co9PNjQ>
    <xmx:kBUYasQrya0w3f2I9JYGM4AkI1oBvaW28n-wNmx6eiGHPH21tkqToF3P>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 06:14:39 -0400 (EDT)
Date: Thu, 28 May 2026 11:14:38 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Message-ID: <ahgUBLjBRGhxULu3@thinkstation>
References: <20260527120544.2903923-1-kas@kernel.org>
 <20260527120544.2903923-3-kas@kernel.org>
 <5ed6121c-314e-4cf0-9a11-b0661c87c694@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed6121c-314e-4cf0-9a11-b0661c87c694@intel.com>

On Wed, May 27, 2026 at 10:45:28AM -0700, Dave Hansen wrote:
> On 5/27/26 05:05, Kiryl Shutsemau (Meta) wrote:
> ...
> > -	/* Update part of the register affected by the emulated instruction */
> > -	regs->ax &= ~mask;
> > +	/*
> > +	 * IN writes the result into a sub-register of RAX. Only the
> > +	 * 32-bit form zero-extends; the smaller forms leave the upper
> > +	 * bits untouched:
> > +	 *
> > +	 *   insn  dest  size  bits written     bits preserved
> > +	 *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
> > +	 *   inw   AX    2     RAX[15: 0]       RAX[63:16]
> > +	 *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
> > +	 *
> > +	 * 'mask' only covers the low 'size' bytes, which is exactly the
> > +	 * range affected for size 1 and 2. For size 4 the write also
> > +	 * clears RAX[63:32], so widen the clear-mask.
> > +	 */
> > +	if (size == 4)
> > +		regs->ax = 0;
> > +	else
> > +		regs->ax &= ~mask;
> > +
> 
> Is there any way we could do this with fewer comments and more code?
> 
> I mean, there's only three cases. Why have;
> 
> 	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
> 
> When there are only 3 possible cases:
> 
> 	1 => 0xf
> 	2 => 0xff
> 	4 => 0xffff
> 
> and one of those cases needs a special case on top of it.
> 
> Maybe something like this?
> 
> 	/* Clear out part of RAX so part of args.r11 can be OR'd in: */
> 	switch (size) {
> 	case 1:
> 		/* inb consumes lower 8 bits of r11: */
> 		regs->ax &= ~GENMASK_ULL(7, 0);
> 		args.r11 &=  GENMASK_ULL(7, 0);
> 		break;
> 	case 2:
> 		/* inw consumes lower 16 bits of r11: */
> 		regs->ax &= ~GENMASK_ULL(15, 0);
> 		args.r11 &=  GENMASK_ULL(15, 0);
> 		break;
> 	case 4:
> 		/* inl is weird and zeros the whole register: */
> 		regs->ax &= ~GENMASK_ULL(63, 0);
> 		/* But only consumes 32-bits from r11: */
> 		args.r11 &=  GENMASK_ULL(31, 0);
> 		break;
> 	default:
> 		/* Probable TDX module bug. Illegal in[bwl] size: */
> 		WARN_ON_ONCE(1);
> 		success = 0;
> 	}
> 
> 	if (success)
> 		regs->ax |= args.r11;
> 
> It might need a temporary variable for args.r11, but you get the point.
> That's basically the data from the comment but written as code.

I hate how verbose it is. All these GENMASK_ULL() make it hard to
follow.

What about the patch below. Inspired by kvm's assign_register().

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 65119362f9a2..460b9fbabf14 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -693,8 +693,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u32 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -703,10 +703,33 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 */
 	success = !__tdx_hypercall(&args);
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
 	if (success)
-		regs->ax |= args.r11 & mask;
+		val = args.r11;
+	else
+		val = 0;
+
+	/*
+	 * IN writes the result into a sub-register of RAX.
+	 *
+	 * Only the 32-bit form zero-extends; the smaller forms leave
+	 * the upper bits untouched.
+	 */
+	switch (size) {
+	case 1:
+		*(u8 *)&regs->ax = (u8)val;
+		break;
+	case 2:
+		*(u16 *)&regs->ax = (u16)val;
+		break;
+	case 4:
+		/* zero-extended */
+		regs->ax = val;
+		break;
+	default:
+		/* Probable TDX module bug. Illegal in[bwl] size. */
+		WARN_ON_ONCE(1);
+		break;
+	}
 
 	return success;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
