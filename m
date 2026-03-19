Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363673D3D06;
	Thu, 19 Mar 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925068; cv=none; b=GSVzBlBsxiUa88FdU6D0a5KqdnVAbBdfD/kgwNUPJAQcVKrwz+l6JcYU+J1s49/IEpZcILtdAxxJqzFQ+739Cya5289KcepPhV8XLAqsrLll7EhcFU+D+OkhLeP3VPOMbYdtPKKQ8oRIvvDBo7VfzXIWc7bfTKWBOPcu6fz3sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925068; c=relaxed/simple;
	bh=ldchc2FnFvHLtvboAyf9/W17QzoxvcXkN8cFDPcz+Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzFk3IWHSZiR0cKGtxhch5Gz6qER5VOBqetV/oixMsirEMtGajRAmpqpYR5CqGlSyn8cuhLiLhhRIaAoIOvigKOfQubsgnaYz0ftzS73+af/hqOSA4JG+y+DzLf52B1HwaPDdqdcBzeQen8RGnxg9nuwFOj2TMxmrRaDYUMk4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMYFhaD7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMYFhaD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FD2C4AF09;
	Thu, 19 Mar 2026 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925068;
	bh=ldchc2FnFvHLtvboAyf9/W17QzoxvcXkN8cFDPcz+Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMYFhaD7hJ2xOaWTIVIk1vRR1XRaV3L8Oe69GOAKOQC4eiP61ICmrjps21xe1QpGQ
	 NLT/Mx43pp51c4n0+q4m1ywkrKc2sZLl7QBhoHfhHbIsMC+2n77IuuNLhE0H9tzuFJ
	 Ls01QSDOTeWY6tP7mLc76Glbu6dSnkz+z0lNEpcoHBrPgUv7/tylUkzhLV8vGZ3NZr
	 JPW5MqJXi0G0VWUxg/cqXxUXLV0UKyivpo3gNFSWk+242f+Idx7iaKwVQHNDQuArVj
	 RjTL6WfgG7g1APEqIJg0vBr1HVjkqX3kM68TqEYJ8I2uQOnaglxDsKWHTO0eP79T8M
	 fWpydFHtjRkLg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9247F4007E;
	Thu, 19 Mar 2026 08:57:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 19 Mar 2026 08:57:45 -0400
X-ME-Sender: <xms:yfK7aYWgy85Q573PPgjdSi3FU1Risxg3S-BCCCZ2mCz1fS6dxjfw2w>
    <xme:yfK7aYQkiuRtJNiOUAgIqRQs30pf6eYRfi7nohsyJpOiAuRgSFvvXPsm81L1p2F74
    jBfe5JX4sYixOFWJu8ZuUOUL2fT04Al3DTz0ymF0TT9o5MnfT0YDRSW>
X-ME-Received: <xmr:yfK7aQDCi0evu0FGdWFhz7-atIeTY-YkMOb2D0Aot3pAKDgAOYtJH9lAwtMDEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehsvggrnh
    hjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgr
    thdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrd
    guvgdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yfK7aXloz8tYOocSbdvEvcnEiLon3pIMzxk_0JjXZq_QRoSO143VCg>
    <xmx:yfK7aQl33kfvr75UfamvQdMWsu6yEXRyt44IJeiwIkjOtRViGydciw>
    <xmx:yfK7aUdmJXjl-ZLI8y0KtqCuOpyPbgD-1oFlxr_lxApbMgVKvKeiSQ>
    <xmx:yfK7aWzt1FhuFaCBcEJ2EE5qMqkR8rbN_gP_-YmDU-h5FYgmHZQE8g>
    <xmx:yfK7aWstZfuEax4J6w58LKkDuHXTnYR98ddrgQ3LFI5pJzkrUoSDCfLq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 08:57:45 -0400 (EDT)
Date: Thu, 19 Mar 2026 12:57:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <abvxiuJfK2eM_1UX@thinkstation>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <abvR2A19S4ZtpAli@thinkstation>
 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>

On Thu, Mar 19, 2026 at 07:59:53PM +0800, Yan Zhao wrote:
> On Thu, Mar 19, 2026 at 10:39:14AM +0000, Kiryl Shutsemau wrote:
> > On Thu, Mar 19, 2026 at 08:57:03AM +0800, Yan Zhao wrote:
> > > @@ -1639,16 +1644,17 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
> > >  }
> > >  EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
> > >  
> > > -u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
> > > +u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn,
> > > +		     u64 *ext_err1, u64 *ext_err2)
> > >  {
> > >  	struct tdx_module_args args = {
> > >  		.rcx = gpa | level,
> > >  		.rdx = tdx_tdr_pa(td),
> > > -		.r8 = page_to_phys(page),
> > > +		.r8 = PFN_PHYS(pfn),
> > >  	};
> > >  	u64 ret;
> > >  
> > > -	tdx_clflush_page(page);
> > > +	tdx_clflush_pfn(pfn);
> > 
> > This is pre-existing problem, but shouldn't we respect @level here?
> > Flush size need to take page size into account.
> Hmm, flush size is fixed to PAGE_SIZE, because this series is based on the
> upstream code where huge page is not supported, so there's 
> "if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))" in KVM.
> 
> Though tdh_mem_page_aug() is an API, it is currently only exported to KVM and
> uses type kvm_pfn_t. So, is it still acceptable to assume flush size to be
> PAGE_SIZE? Honoring level will soon be introduced by huge page patches.

It caught my eye because previously size to flush was passed down to
tdx_clflush_page() in the struct page (although never used there).
With switching to pfn, we give up this information and it has to be
passed separately. It would be easy to miss that in huge page patches,
if we don't pass down level here.

> 
> If you think it needs to be fixed before huge page series, what about fixing it
> in a separate cleanup patch? IMO, it would be better placed after Sean's cleanup
> patch [1], so we can use page_level_size() instead of inventing the wheel.

I am okay with a separate patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
