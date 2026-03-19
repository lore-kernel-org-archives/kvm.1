Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50713C2780;
	Thu, 19 Mar 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916765; cv=none; b=ZB50fp+w5Y5QkF5QZ/MnXVSYQq7aETWFHQIiw4xuOlkcbDDqRPakvYJNzsRenG9WdUmuO2loyZEuNIzwDCXJzqM3+vaxzVHmBNCchAmCyD9FzigdZusEvFiY2xndWg537cvuZvaqFRql+Nik1Lh23DmxV0ErlV3EJsSWp66LkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916765; c=relaxed/simple;
	bh=EXlhCA8ORn+TPIkI96YytnyyM0OnEJc7yVdSlOGO7sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnEw3yH87fQN9FI1dsAI7FXwh9vzpCIw7NDdA65F7eVyOEgrkxIzMEE3hrWzKiuOA23O7CsOZDFn2g95U9FZHa251g/GxrzVrVC5R6gxbaAay37u4bRM0Hx/ZTlLE+B/ZEarsfBMr+mJDIXgxqagCCzOAYTDx/mbFuAGQeYRHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uufV8lk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uufV8lk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68667C2BC87;
	Thu, 19 Mar 2026 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773916765;
	bh=EXlhCA8ORn+TPIkI96YytnyyM0OnEJc7yVdSlOGO7sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uufV8lk5RZ0SIUTMjji2v6Q7tJIMTkwzPhStfc5gvJ71wxzE8TCDVnT9NhumARaOX
	 7WuXYAE+eck7gI931UubnLT2DP+iOCDdbvMyzGIuelIIGSK1cviNUME5bKgOqSNQox
	 HhV0C3HWaIvYivTwyVxyENpFtAoqJXKsXUV3cBKRcnhbDWFgi6KNV3jCziDG1tscWD
	 Aik6I+RKBf73MBj+CqphHySxxCdsEqpbwHvjLdZK0Ezl3iSJFfjOEv0jEeRyjkn4so
	 q+mSSajKz0SLUDSJAKNMcpIzMwOfWxDt2/2+qlt0q5fUP6//DBKu0Y7raSNxaYLYNI
	 snrVCtpLrEMBA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 07971F4006C;
	Thu, 19 Mar 2026 06:39:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 06:39:23 -0400
X-ME-Sender: <xms:WtK7aRTxFoDfcTvTtFefjUK85WmImSsEDMp-Su-IySezt5iFfrHAKQ>
    <xme:WtK7aWfrz1FtrzPQMCk501gryRHCGCCNcIcPwXwEnkmcCgErrucO2_tYweHrfQpmb
    kYMxhPyj8RnXAIfdpIizgUWcivN_5pFxNIM6_F_NoVXg_vjRh5KLwk>
X-ME-Received: <xmr:WtK7aadiNbL5f4Tqqphz2YQRcSRyF2_DBCxnyOQXg6yqq38YMPcGYa4ouDg-qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WtK7aZTZUoi3-eX4G4spzKN2f4Ozb8ymVOax80d78t1FfG-GsTXfJQ>
    <xmx:WtK7aYjhV1LEQRxmYmapGjxwt_YpQa-a9Fwd60Hv9KgkHgiyMq8_xw>
    <xmx:WtK7aVrYmVI80VdDtMF-OmccSqUAe6nthbWEeVVHWbyTQbczISzNrQ>
    <xmx:WtK7aYORap6jM2QDIn0HYAm2wzTLKj1piHFTsIWtFOZqGZ7O1Yc2Dw>
    <xmx:WtK7aTa1vERZfZ7FWR9ShF5RZWbjpgXaS_i0p62kAORFTUv1PpeT0De3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 06:39:20 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:39:14 +0000
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
Message-ID: <abvR2A19S4ZtpAli@thinkstation>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319005703.8983-1-yan.y.zhao@intel.com>

On Thu, Mar 19, 2026 at 08:57:03AM +0800, Yan Zhao wrote:
> @@ -1639,16 +1644,17 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
>  
> -u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
> +u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn,
> +		     u64 *ext_err1, u64 *ext_err2)
>  {
>  	struct tdx_module_args args = {
>  		.rcx = gpa | level,
>  		.rdx = tdx_tdr_pa(td),
> -		.r8 = page_to_phys(page),
> +		.r8 = PFN_PHYS(pfn),
>  	};
>  	u64 ret;
>  
> -	tdx_clflush_page(page);
> +	tdx_clflush_pfn(pfn);

This is pre-existing problem, but shouldn't we respect @level here?
Flush size need to take page size into account.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
