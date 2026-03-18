Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A53AE709;
	Wed, 18 Mar 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826135; cv=none; b=sTRmfZS3laCce63vv+Re7Dc6IJYxUkbm9FZcBD643tk1BPken0J5CYII2Yrw7thOdz5m6jVGwpmcuzVX4ILLtk4LcYmh/gi1TwYRxcZNZ3q2V9iTngZEx1Y2vXIxjOWAh6pmf4vavnJgugLL9sfCZv1tSRkbtnob7YCIyvHF36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826135; c=relaxed/simple;
	bh=H2J75zryQKZ5oHureFc0ZmBX1CX1bE1w3vXmsKolP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps5sBOzbYBJOk24vQu9Og8TR1nR2aChYyhoG7Xqr8Ku+tn13YNu8Q8NEcXZuo9YF4d1ILLsG2y1Ke6GItXb3r9GE7SVk7Ci0quTTDytpTad0I5ZXpXUfFhxXwUn3izj2deAanbBvaV+D5z2+1jZMplW0CuP5bdio3xLTRGPpL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRmF6qaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRmF6qaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B2FC19421;
	Wed, 18 Mar 2026 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826135;
	bh=H2J75zryQKZ5oHureFc0ZmBX1CX1bE1w3vXmsKolP3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRmF6qaQ/rVgWABg4laKAjaSj6W7pmZORY6DVFh7GlSq9gb3W5nrCmGNrhBBuuv6e
	 goRnwkricUcmcGukjlyfsCSBOGKxuXzPx3AwaHa5qIGIArNrGr7fWxJZAxsSdQ1UUq
	 Gwgx8alAeMI/HBLPwzsYYBBO9tsvI9/+na7XLytKt79rYfxPprHdqcw7vwHRwQ40Cz
	 SMHFMn3LMX9Z0hw3pk6PGPN3nV3SyXJaMkxrhcFsXe9ZN7mv2qtReoqGhpNW1tAvwy
	 yivztMbMmbrSzT3IUYJHr0DxCUEt/7TN37qCBoIL66fEdUMr7RxGP9szHVxxoVjaxY
	 EaeImEmnpJnwQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94F95F4007B;
	Wed, 18 Mar 2026 05:28:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 05:28:53 -0400
X-ME-Sender: <xms:VXC6aSMmLShxTAUAtxaJH8nS23808P78iSOe4kkvlOpCYu9ksKB0fw>
    <xme:VXC6aZ90N4Vws1HvZyzXZMiQWNxChMF4uzq7m_9I-k-2dyFCjQ-wJiBkKJ0473GEc
    Svs792Rz6YvnMcwxNFin-XvghnzJOKI_g3sIkmOh8i7bmsfD1lHYng>
X-ME-Received: <xmr:VXC6aS-V1KYQPH6cULjmHUPjmWddPo2gspcnU58nPgDZBrJGuUUmiL42bxrBzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeeggedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtohepgihirghohi
    grohdrlhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:VXC6aZoOLHTMqGeHk8kEpFdkTaDpuGN7qBfCdXTIZq6oXDLt9AgMPA>
    <xmx:VXC6adKvn89bFVPfPS1eOk4JDVNcMhYZlsXclNzDtxiEQ_1PnHcd0A>
    <xmx:VXC6ae0WpcXkTrQ1Ex9qQZSROD_d6SAFOYmY3F7m9DJbXqQ-D158sQ>
    <xmx:VXC6aW7DuGeALEmYe8s23KwyIXj6pDr-9TEwiF5quz46sLW-oljmnA>
    <xmx:VXC6acNDKP40-ZDfWrNphlFWnTJj5aVNFSxYqfWoCUz_JKu7GPl4b6zL>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 05:28:52 -0400 (EDT)
Date: Wed, 18 Mar 2026 09:28:51 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	binbin.wu@linux.intel.com, dan.j.williams@intel.com, dave.hansen@linux.intel.com, 
	ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, paulmck@kernel.org, 
	pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com, 
	sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com, 
	vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com
Subject: Re: [PATCH v5 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <abpwQwlFB_C28ckJ@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-7-chao.gao@intel.com>
 <abkmceqUtMTnLI0V@thinkstation>
 <abpMHxwhYqbmrX8s@intel.com>
 <3614e6fb-bdad-4e59-9769-5dc9869e03bf@intel.com>
 <abpr/Sg3QXfDd1Q+@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abpr/Sg3QXfDd1Q+@intel.com>

On Wed, Mar 18, 2026 at 05:10:21PM +0800, Chao Gao wrote:
> On Wed, Mar 18, 2026 at 04:20:54PM +0800, Xiaoyao Li wrote:
> >On 3/18/2026 2:54 PM, Chao Gao wrote:
> >> > > +
> >> > > +What:		/sys/devices/faux/tdx_host/seamldr/version
> >> > > +Contact:	linux-coco@lists.linux.dev
> >> > > +Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
> >> > > +		loader version is formatted as x.y.z, where "x" is the major
> >> > > +		version, "y" is the minor version and "z" is the update version.
> >> > > +		Versions are used for bug reporting and compatibility checks.
> >> > > +
> >> > > +What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
> >> > > +Contact:	linux-coco@lists.linux.dev
> >> > > +Description:	(RO) Report the number of remaining updates. TDX maintains a
> >> > > +		log about each TDX module that has been loaded. This log has
> >> > > +		a finite size, which limits the number of TDX module updates
> >> > > +		that can be performed.
> >> > > +
> >> > > +		After each successful update, the number reduces by one. Once it
> >> > > +		reaches zero, further updates will fail until next reboot. The
> >> > > +		number is always zero if the P-SEAMLDR doesn't support updates.
> >> > > +
> >> > > +		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
> >> > > +		Interface Specification, Revision 343755-003, Chapter 3.3
> >> > > +		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
> >> > > +		information.
> >> > 
> >> > Do you think revision and chapter numbers useful here?
> >> 
> >> I think it's nice-to-have. Without specific references, people would need to
> >> read the entire 26-page spec. But I can drop them if they make it too verbose.
> >
> >I have some concerns about the "revision". The good thing is that it can tell
> >what the attribute was built against while the bad thing is that it might not
> >be easy for people to find an old revision years later.
> 
> I'm okay with dropping the revision number.
> 
> The intent is not to require readers to find the exact same revision. If they
> can find that exact revision, great. If not, the chapter numbers may differ
> in newer revisions.
> 
> Kirill, do you mean dropping the numbers but keeping the chapter titles:
> 
> 		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
> 		Interface Specification, Chapter "SEAMLDR_INFO" and Chapter
> 		"SEAMLDR.INSTALL" for more information.
> 
> This keeps a targeted reference so readers do not need to scan the entire spec.

Yeah, looks good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
