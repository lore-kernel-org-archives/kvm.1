Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A364E4318
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558256; cv=none; b=RaKY7cT8NIPt9GCd2nB9v096bwsIlHwYG/M3iR499XtIGG97VvXbcYbMTpcyWnCrdB+GBIATDNcovwIahfZQqk2cdEIvxCesedSoKrILP7HEZItfWlTJzsZ5KGjSxDK9yP1+OrR5LCTqObNQLyVXTf5jCPZtXxwTICWxcnU5lCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558256; c=relaxed/simple;
	bh=CWDf+4/5YxHaAt9cHoijFqJXNuN0eb5DdzWTqJTxlNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCEZ2m06pfZnuFBJDMWtDXFYVr28W/ye4iupewwiC3mZNVeFXHmVBsFzrBgztumRHkv5dGKKZ37Z3eNDFz59KDrtfyy8/yk8RBjLQE4de1Tquuq69tnWXtYOQQ1MuPuZIrvFyzR66sklwKDY5rbw3ye2Y25Ai4IE6oUrggLB7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAd4pUCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAd4pUCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B111F000FF;
	Fri,  9 Oct 2026 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558255;
	bh=S5dCcc6sEnDParSMcBNX+g8x/2XGsg88AsvK7InyEuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aAd4pUCCnjo+FaIjpip+1t2CJ6iCbVAgDkW4OqMFBLBgAQ62bDJuzIIUCSrO3jJmg
	 Gb31c6DQC1rRC9nJzjtGtCcd8jAnK53n7MXfq/pD+vpW32pgyD5W/BG4jm5kvxjfw2
	 9RSHY7cvOi+9E2Y0IesHVR1VPVoymzDLPVsM2xwFtKZnZLY+iN9bkx4feJrX30RWDA
	 3ISr6qjM7OJKVopHjPfu4k8PvXOOrxu5uK9HqGuBxY/W/PMygF5Gn2AEhfUkfwsZSv
	 tSHyCs7CvzwblrgMJ33BqSmFF3ZTKfG/lUI9gYj22VXBUnZC3P6K6AhnLu+n71IoHm
	 jr9nxsP3U26jw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id BE992198003A;
	Fri,  9 Oct 2026 11:04:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 11:04:13 -0400
X-ME-Sender: <xms:awLJanXsM2I1sGZYMZ8zV8EEZXb5oEUwg8HTGRJY-9rndphFvAN2HQ>
    <xme:awLJajgTk7aahNxNQlvISKrlE8AIwk80egDwcjhfN0ltVQLlpm1HSHn2TF-DPG71X
    hBwghO7RNpXu-78A0b8hRhvc6-ZEL7DRp3GhDuh9KCI_uFPpu6G81A>
X-ME-Received: <xmr:awLJar6-QHAf0vkpyCrvrdz7uFwvhRRrMVn6b-FoIlOrxFWnYMFqTpcDHYk>
X-ME-Proxy-Cause: dmFkZTGJ/XhBGpPi97MqhD44hU74yMhsQKwQwC/aPUyQ4MaG5oZsznyJvNE4EXcwdzzEyF
    87tbKrDAR0JtsUQRErGMu+n7kX+YErfUeqecd8yDc4Sx369XclRlObM+DUSB2SyFrJ7hYa
    gxAsijn36xI/Tr0CoGEx17adMC65DyT4MPcGQUEWxNEqcw4ihMq6UtaAkWxspz2eWmvpo+
    v4GHKLGyLNkdXcT03bQxlHN2RlesiSH+HycRKl2FswXNTX87OEheEfJTv09IdmzkHpvLcc
    NB45yZVEGfeUeUPJIzQGFuCh5IUX/oNYngnlv0gJPdZvCbRyhqDH22107TUszX6cFXSfpK
    q3XbfGfWDdQ56g1Jn/JG1rRk1wvkJwMoUaHyPeGgJWteP9+AgpoRmqi22oEI4p36ZQ+nYb
    24Q8VA6W601FQsgJPgn9Ar2Ajay/kWCqM5bJ7XR8ldZhsyubcQbZIo3479SckVl8YXfZQm
    LPLY4z1WVlTttFCeHY/4DCkx+hghBT2alBz3ArIZEWA+3w+/cESqvcppYyeQbH+flhBlk6
    bZQlMouvgh0BkpFeZmpeN50bF79Xuuvp/pKNU1DY74WZmqHAfdzamhdgesfTWftEnY+jc1
    SnOy168OU/dmS7QCZdoaCjth9vp+ADs7Ww8xl3iUeSyGQADyXDVWmnztMi3g
X-ME-Proxy: <xmx:awLJar778wOrEkl1jgfwbaz-4QeMMVVc5RaSA2Seu5yTxJG-FXh6iw>
    <xmx:awLJapE2_4iwH9Zoa2yMDOMAzvVY_Q4oBfAoqja04cSxi64O-S25iw>
    <xmx:awLJapyTparEaJgs6lLI_2zPbLVjP2VLkE41sE--LCXn6FUDQ95y1w>
    <xmx:awLJap0n3xboDZachFfyifzXYHqbv3i_mOxSGT5vwNaSXEtd7LHJqQ>
    <xmx:awLJasMa-T1M3CZVKEMUN6B3YHNQUESr44WcLS2oZiBut3feTNNaOAIV>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 11:04:10 -0400 (EDT)
Date: Fri, 9 Oct 2026 16:04:09 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Message-ID: <askBV7fBxg9Wfdqz@thinkstation>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
 <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>

On Mon, Oct 05, 2026 at 04:50:07PM -0600, Vishal Verma wrote:
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
> Instead, add an earlyprintk=tdx option, which can issue the TDVMCALLs
> directly. Add a pair of tdx_serial_in() and tdx_serial_out() accessors
> and set them up in this case.
> 
> Note that the output does not appear any earlier - "earlyprintk=" is an
> early_param(), so the console is still registered from
> parse_early_param(). This only changes how the bytes leave the guest
> once it is up.
> 
> LLMs were used under supervision to create this patch, to help
> understand the scope and mechanisms, create testing instrumentation
> (throwaway) to count #VEs in the serial vs tdx earlyprintk setups,
> and to drive lab machines to do this testing.

Sounds like you are missing "Assisted-by: LLM" tag.

> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
