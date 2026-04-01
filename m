Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0193D5656
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035602; cv=none; b=e9/9l9igH8vFdu4XH3pJFGJjFZwQTbaecGlDGCQlpZpW/4fJvgDrF16Y+DhcHXX43uNvsuksXhRmBbDEx0IAIOOeQbaFJyMWjT7TSKyRh/8RhCsEYsrE+UUtgkicJYzRteionU1IKOOTB+0WYZPtqYY83oo9CQMP+7bC5o0uRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035602; c=relaxed/simple;
	bh=vQoKBDVUQCrnlg4i6bDknEFEH566QDHvDtOP+1cfVMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh7gks41aY7mhE8PibkSwA4i/EFeGLrcY1QTKGMFyFn/CaaqO5iysIvRfjbfUrTo7eai0oejhtp+hAtvjgpnI8MPJQQLvBtUmD4RVjAwEz3Uj106NP1JZIepwfzlkgfsqH0OdaIB0Qe2z2cx8ttL55skkQIbSiGueJRqkSNZZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR45Cdzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR45Cdzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61597C2BCB2;
	Wed,  1 Apr 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775035602;
	bh=vQoKBDVUQCrnlg4i6bDknEFEH566QDHvDtOP+1cfVMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eR45CdzxqaI3lDQ63QkFzdtfXBmqNY89rHXpPWgx6IYd/FTqsAuqjVnYRkaYg354w
	 mpKCbUWq8EBPaC7VG8xNk2kyqeSv+mLRoDfl+uaJlB0CKXQBYL4eIwUPPzeJ3WHI2p
	 pPtUbf07viuu//7hVap18gAn5YuR6DwjNadGJjN1xaZuNKT5HBPVcVq9KnWdIwwEZC
	 Z2XV9Ldz14b4vGzUWjf1JSxl7z4cMaFIRMup4/J8n+2w9YFUfBIBH3p2TSWdApDFof
	 gDuqRIiO2oFy+n6HVFQab5JcL/veF62B/ujE17R7AtnjdQOReC2uM0Hkgvwy8eUMap
	 0gH1R1E9XO8LQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56C89F40079;
	Wed,  1 Apr 2026 05:26:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 05:26:41 -0400
X-ME-Sender: <xms:0eTMaelKbwcCtXUwAu07n1msc4QbNChZJ8vYe4zsFEsUTAXC0FL7CA>
    <xme:0eTMafJs2jUfany_sOYLJ-awKE76c-mBtrWXxYqKTRDVO0RKtuejk-7DBF5SlgOS3
    cJlj-bUtjrNiOTYsrHzsJ-Wj9KQbfppD1avsnRjUSmjCgbRW4miiA>
X-ME-Received: <xmr:0eTMaUo4y8Ddo8yzyxNHJsz81u6-Z7pl7U37SJ9i98crLCJmEOrTDT_XVzUDYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffggfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgv
    rghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseii
    hihtohhrrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:0eTMacTSYP_YVEONvX605NoRdNRWtXTZi5xqDsX2eUVIBeitSVr6zw>
    <xmx:0eTMaX5_N6J7fj_fbmsDjGh3Ct4zW_DbyMFNffX35n7Wzdzk_58LEQ>
    <xmx:0eTMaUbUS3K8H88pqiTcjhZSg9PlLsFva86lOY0iRVpLVTJT-tVjzw>
    <xmx:0eTMaUhcLLlcoE2_-GVXbJIJMt0QqI43SXbBUz4uVSEpV2N62ZZkSQ>
    <xmx:0eTMaWME3YTbFrQQZco3tjiYmV76tkcDWs8sjsE5PKIu6wCfprM4rtNK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 05:26:40 -0400 (EDT)
Date: Wed, 1 Apr 2026 10:26:39 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <aczZPrNFYxYi0d51@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
 <acpiGUKS-WRmLoxp@thinkstation>
 <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
 <acu4raBTjdFcfVlS@thinkstation>
 <b9aa84d76c131132b5268712a44200e804c31aeb.camel@intel.com>
 <944b3fe5fa8955319030a7dfc0ea164bb0266e68.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <944b3fe5fa8955319030a7dfc0ea164bb0266e68.camel@intel.com>

On Tue, Mar 31, 2026 at 09:36:03PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-03-31 at 18:22 +0000, Verma, Vishal L wrote:
> > > 
> > > I guess the actual behaviour is dependant on the return code. It is
> > > obviously going to be the case for TDX_SUCCESS. And from the discussion,
> > > I guess that's true for TDX_SYS_BUSY and TDX_INTERRUPTED_RESUMABLE.
> > > 
> > > What about other cases? The spec draft also lists TDX_SYS_NOT_READY and
> > > TDX_SYS_SHUTDOWN.
> > 
> > I think these are safe too - TDX_SYS_SHUTDOWN means the module has
> > already been shutdown, which this seamcall would've done, so things
> > should be in the same state either way.
> > 
> > TDX_SYS_NOT_READY means the module hasn't been initialized yet. This
> > seamcall should just exit, and the module is already blocking any
> > seamcall that need the module to be initialized. The seamcalls to
> > initialize the module will be allowed, as they are after a sys_disable
> > call anyway.
> 
> Should the seamcall return success in the case where it would return
> TDX_SYS_NOT_READY? It is in basically a reset state right? The errors we care
> about are actual errors (TDX_SW_ERROR), so it makes no difference to the code in
> the patch. But it might be a nicer API for the seamcall?

I am not sure. TDX_SYS_NOT_READY can be useful as might indicate
mismatch of system state understanding between kernel and TDX module.

> > > I wounder if it can affect the kernel. Consider the case when kexec
> > > (crash kernel start) happens due to crash on TDX module.
> > > 
> > > Will we be able to shutdown TDX module cleanly and make kexec safe?
> > 
> > Hm  -are the semantics for what happens if there is a crash in the
> > module defined?

I meant kernel crash around/before TDX module initialization. Sorry for
confusion.

> > I think Linux should expect that sys_disable should
> > either start doing its shutdown work, or exit with one of the other
> > defined exit statuses. Anything else would be considered a module bug.
> 
> We often have the question come up about how much we should to guard against
> bugs in the TDX module. I tend to also think we should not do defensive
> programming, same as we do for the kernel. If it's easy to handle something or
> emit a warning it's nice, but otherwise the solution for such cases should be to
> fix the TDX module bug.
> 
> But for the kdump case, we don't actually need sys disable to succeed. The kdump
> kernel will not load the TDX module.

AFAIK, it is possible to start a normal kernel after kdump is done with
kexec (requires memmap= tricks). And the normal kernel might want to use
TDX again.

Not sure if it is done in practice. I would rather go full reboot path
after crash.

> And as for the errata, this already needs a
> special situation to be a problem. But even if it happens, I'd think better to
> try to the kdump. Not sure what the fix would be for that scenario, even if we
> allowed for a large complexity budget. So best effort seems good.
> 
> Does it seem reasonable?

I am probably too picky here. We want to start from make basic kexec
functionality to work for start.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
