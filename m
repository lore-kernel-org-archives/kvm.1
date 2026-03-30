Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E783C73F7
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870938; cv=none; b=I8Ji27VC1eA4+xTIaYwJZPHW9wwoS4Tn7xIlXXXfU6u/L2duhiDs9tucTbWfYsyDfuAyj1J7l/JU7e8hziF7BjyEmMizP596qWp+xvAZ1LELueVtpK2l+sD0+8/MkYUVVd958LYKimTHJnAjf4/Glc/kxmqD2YAWXOPgZlusl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870938; c=relaxed/simple;
	bh=vB4s3YFWgv8MKgglsnUDvrSHERw1GbGb9mSfgsGzfhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNNeNwUnipcR4lRv2Uhke28lRcHECtCjF+yWwV6+vl9opWZTil6Yw5KKU8zvinh6BRMByzEmQS99px7TymvFwby2wmXo9zhdJx70qZs0wjugk6CmDTnizijqEPttzU/MebvBTcyy6iumopCtTEz3VkSZaLn5vQRUI1dRkt+Me2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZOucjKX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZOucjKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A062EC2BCB0;
	Mon, 30 Mar 2026 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774870938;
	bh=vB4s3YFWgv8MKgglsnUDvrSHERw1GbGb9mSfgsGzfhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZOucjKXzaErglbP2eZt+0/slK5YVkc2COskjLrIlb8brOy57nP/d1yCnEZAfjW2c
	 it8u69oJXRPckTdoCMNEFPvQVg97p2XhB5x4VoCfqf/MWj3cwcZhs8kbWeuqKRZ7sM
	 x86Rf7Q35XsaM9n7EOJIapaRDNwL+eDWREIEBQPIHyzPJ7YrapZ4KXq27SWyPPjl1N
	 jHjyr/I+3b5npyNwAet80fEybc5GXAmvZojyEZKp070pc5UR1dVFzMpov9ID8ms3Aw
	 0Z7T5kqTm1XoHZrOzLllwJhwcf1RzbFO2bLKV0fj4l4vLObOhHfYiboW7qTcC41GWi
	 Abf1tTjyjXliA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DF58F40072;
	Mon, 30 Mar 2026 07:42:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 30 Mar 2026 07:42:16 -0400
X-ME-Sender: <xms:mGHKacZCRfRsjAsrZtkA8g7q1WWOaRoC96kmQGLk_j6TfbocamK7hw>
    <xme:mGHKaXgyC-ywCZoTwV3n6w8QWMk7uu1mbaQliNsirfSljvOx3OEeL57UVTfgWa_Sc
    5E2nzvAfF8Hyr-g7IAG2BAdoE9AfO59zJmMCWpQQ_-nWPrHr0egL8U>
X-ME-Received: <xmr:mGHKaUyrkiETXjNYDwJv2A_cnjx4as-71YEubw5U1ksnzwUAMV86feWASeE4tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthhope
    htghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtg
    hpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghp
    thhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:mGHKaa52XndDMwTwUGU8ItmBBOlsvl5n0LfJGHvecS_PcVV9WkR26w>
    <xmx:mGHKaV2KWli69DSeL4E8RnpqsdsElrI_4lHceAoZoJaPvg04c2cClw>
    <xmx:mGHKaT1rHto1OMufc2BIw7bhwRk3SVcg_XjjHunDv_Zt4J-8ezHG3g>
    <xmx:mGHKaUed-ti7oE2O--J_5ae6KMVdFLagjl3YUgThNSSLpNXGmSNnEw>
    <xmx:mGHKadLCCRWMTNynkPV4WjHro_4VGw93kqoEHP1YFKj_Bs5qGVhcUSW0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 07:42:14 -0400 (EDT)
Date: Mon, 30 Mar 2026 11:42:09 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Message-ID: <acphYSbBAfm3HkCV@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>

On Mon, Mar 23, 2026 at 02:59:05PM -0600, Vishal Verma wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> KVM tries to take care of some required cache flushing earlier in the
> kexec path in order to be kind to some long standing races that can occur
> later in the operation. Until recently, VMXOFF was handled within KVM.
> Since VMX being enabled is required to make a SEAMCALL, it had the best
> per-cpu scoped operation to plug the flushing into. So it is kicked off
> from there.
> 
> This early kexec cache flushing in KVM happens via a syscore shutdown
> callback. Now that VMX enablement control has moved to arch/x86, which has
> grown its own syscore shutdown callback, it no longer make sense for it to
> live in KVM. It fits better with the TDX enablement managing code.
> 
> In addition, future changes will add a SEAMCALL that happens immediately
> before VMXOFF, which means the cache flush in KVM will be too late to
> flush the cache before the last SEAMCALL. So move it to the newly added TDX
> arch/x86 syscore shutdown handler.
> 
> Since tdx_cpu_flush_cache_for_kexec() is no longer needed by KVM, make it
> static and remove the export. Since it is also not part of an operation
> spread across disparate components, remove the redundant comments and
> verbose naming.
> 
> In the existing KVM based code, CPU offline also funnels through
> tdx_cpu_flush_cache_for_kexec(). So the centralization to the arch/x86
> syscore shutdown callback elides this CPU offline time behavior. However,
> WBINVD is already generally done at CPU offline as matter of course. So
> don't bother adding TDX specific logic for this, and rely on the normal
> WBINVD to handle it.
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
