Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC793B47E2;
	Sat,  3 Oct 2026 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070481; cv=none; b=gCcOCZQ6ZT5EXrECpKtkBAHkjaY6KwJeOGx2FEfXXHW9CAWO/vMGvvyqUE1G9PDVFgFR50FnscGlRQHdE1FlATODOYEbftTwtb4Wl8+pUegzG8eMpVySWeqnydmx02ZRM54LGwXjRz1q5qFtzIZijyk7cHBOx/C7HZDXnOCqNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070481; c=relaxed/simple;
	bh=ChtEv5Gs/odsv1gaJSaXotF2IXOOEMl3n2Kr1I5juAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhzCThDs22izecrU2eXIrcx6h+AjE+I2Uh81K0nvb2wiqMIrKYb1U+RJjSzzct3GGSCYt0GzhYbVKP50YMd1E5RuVpLVp++GK0GnkKevTrm1aNVXiS3oyuSoE6InRLxqEiqYDut777kZqLKjF9C39CzA+fnt/P8nTXKk0bpWaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKYjrD04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKYjrD04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD351F0089E;
	Sat,  3 Oct 2026 23:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791070480;
	bh=McNvrbaXa8pRLURHJC626TEpOy+lAMWBxLS6cgVjDHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKYjrD04ggURlFPKc1Vix6lrnkAR1oOBLG4eEPU4ljnqd1Tz0nmhKLafGe6AnqqxV
	 d6BdpYUI1yV0EuT02SJba4pY3pe3XOwINxr7997soIB7rmH3gybXUJcSIeZH2ifWo4
	 rZvfpw/i4LerKgqZX6tQ63XaA1qgSr8t7Tm435aQuqUJBI7G8RC1QkybgXD5y/c9Cj
	 ATaJdHVWvBEZvBrQTffTB192KOnIwVmpCeazB7HHPv5pLMvDI6Dwm4u8wp33/+xP9v
	 SNllzi3B1DfwKrCBLe2trEaZohwCtIRe8Xl+71x5EAJKH+132rimFkXVJne1j8bIxh
	 EUQlErFdzmFUw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id D8EE5198003A;
	Sat,  3 Oct 2026 19:34:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 03 Oct 2026 19:34:37 -0400
X-ME-Sender: <xms:C5HBasxVVLk6p18CVsx9YwRdV6isHzVuA-PBDRaOpeVEkHXG0Oz8Xg>
    <xme:C5HBakMXOHy3TjE5Nc2HsA16s7JQUGvPpMOLXWnKcxlwoy4k0hIAphMhFFaZdIaF6
    iJDMFV44rxn7dOc36xHAEZrfL1CkECqVCI2Rw8EP0sVf8jQPLcORQBL>
X-ME-Received: <xmr:C5HBam1ZSR0iYNPWX7LoGst8448ULPFH8bfI-HQbe99Ip9a9ZrzlPfAM3YE>
X-ME-Proxy-Cause: dmFkZTEdHe940eMECZiWakIif7cd+T/iqkkgGwdGKD6o5Y3YI6YAy4zxNQlyF890iSqBlD
    WIo7gM+kuyvs6ffFMZzz36iAAXIZRNW9iLFCxtGfOmIxr240HqvHyzHdLljN2T67P8GTuL
    y5jVbyBYWhjAAULmBB6sCstWvmhU2/SywInr9NsjCW4+udjjakE1JnpVSK9M83QfWnY45J
    i0ur14UsVGe9TZf0A15Kt4eX1jocS2GvO+4c5JB1OlidDy3j70GRSQdrcn71jV/015xwFw
    WkA620GdOPCCDHNiGSI1aumLRBXCBZe1e8Zhucc99LyPx2bBckvUO/r6XcuvifqT7SWQBs
    BINBB1OfjPOUG7W8dPY/1ImIqzWnOkVeIFBLHCwoLfGoXGopsLsSAEO6QKOH3ogWWU3epB
    I0h7YztqaCd12PQDpK7+5RFoAPH0y/Y0kGxT0F1NIWbnSRnOs7VDGThfcSXtUlcxTMQGqa
    Pi7FsR24cj7JMPoH1p6jAK4Y7/6OQQNfkrm7a1eWiLJ9GMqnT3LtJscRDQcVVBqbi6GGbT
    dIDGU39MLfxezW3ytMPGcFl72sI6QmgyD22J3sgKJs/dJk1GhpTB2G1FlIn/WrM3/j3xd3
    NgW6B2z1Y9usNjJsprcimxt5T3OINYAgtjI354xSwxVwPVPQ+Qo61TAe1LjA
X-ME-Proxy: <xmx:C5HBakES68ZgUATiGiYmmD62wFwN7X9BgDacj9w5SbAZ56A0v1g1uA>
    <xmx:C5HBalh-MeXoOPEkAUKiukpdz4KbfrWUZdsS9ul1q9h9Eajq9pHgOw>
    <xmx:C5HBalft_tUbkIogweCujQ7VBTgTeQUXfpJnkDQMBLI3Vduqb1PZPg>
    <xmx:C5HBajxe7LRZ5RnvwOxwliFvZwDiQ2mlv1D0H99ly8TFHNW-dPFjTg>
    <xmx:C5HBanY2QKVSLGKKCeI6nybtn61WOiEGmHFBmcx1Pm0JkpqFnjEq7_lY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 19:34:34 -0400 (EDT)
Date: Sun, 4 Oct 2026 00:34:33 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, 
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Message-ID: <asGQ6wkOmLGkeYsL@thinkstation>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
 <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
 <arZbBqArD9NqWPry@thinkstation>
 <c41ffc542bd677b71bcecbe4e2c2e2a3b605ffcf.camel@intel.com>
 <ar_GLgzxdWUdXn0Z@thinkstation>
 <dfe6e3aa7bd37679d2d5e559b9af8e254d88044f.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe6e3aa7bd37679d2d5e559b9af8e254d88044f.camel@intel.com>

On Fri, Oct 02, 2026 at 07:31:00PM +0000, Verma, Vishal L wrote:
> > +/* Only referenced when X86_FEATURE_TDX_GUEST is enabled, no stubs needed */
> > +unsigned int tdx_serial_in(unsigned long addr, int offset);
> > +void tdx_serial_out(unsigned long addr, int offset, int value);
> > +
> > 
> 
> .. Should these also be:
> 
> +__noendbr unsigned int tdx_serial_in(unsigned long addr, int offset);
> +__noendbr void tdx_serial_out(unsigned long addr, int offset, int value);

Yes, my bad.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
