Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E644CADF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467984; cv=none; b=kG3CQVHvVC6N3Q3BvgjP4q3kOkLkx78uGbcYPogIRSSFKeT5Pfnec8sc3I/JAjZPaNcPiV/EmTFn3/YpTm6hYryZnFbpC9gDYXQf4LwSmNEOvlP3vIszu0GrwhmMS4u9tO73rZPl0vmNoeQzQH+i/NlIn0zDoJdqNnQv0LrYJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467984; c=relaxed/simple;
	bh=z03yOLfePnutgrdptQvCWmoWp17mpFWdnNjNXys44yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjZ0J3b5KqCHbi4c2A2X7qcJPSQc9Ry60duMrkjLiMwQPEF1DlwyYDe5FCLBZvJGCjpOCldaEZloAVC31MWzfNIP8OhGQL+Bok+rT/n5EgYdN/cypCRJAbFtebponeSzWyQR8rK3LWneWt0mHrnr2NBKtqyI5EwaEs3/DBIouZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5RykhaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5RykhaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F31F00A3E;
	Fri, 22 May 2026 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779467980;
	bh=yHQOjzL79KFwlGy7K6imilcrIfMmMX1LgRmEpNbNmUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N5RykhaWUMNivcRgFFO7Mv0WJNsA2EtHbHAIlcWypQQuJXu0Jc0PrttCyL10MSzsH
	 rnFCUJzWIaKtrGCVbimSLi3QKXacTltcQpxECPUmR8w1294pFEFeVA5xVAWdDkf7m/
	 RBt3d8X2MiICchUbDesY+tDq5UnTl8kM6pLJJUOKN+srlYeai8TDDX7QYnJpdu8jDc
	 OObUQ2KoI2Uf3AJhjOtaL+CqLOrQy8FROyK8wUoLwwpLa89AmgzrtHvDc0aowG7e/n
	 An4RTMLcflF3wIADt/a/zfn/ptHgdGho8nKho1jP/Xe7L6UTZeSF/k+z78+dyFW+Da
	 bEcq/wvAT8jkA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id CE5E7F40078;
	Fri, 22 May 2026 12:39:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 12:39:39 -0400
X-ME-Sender: <xms:y4YQas-Rv8WBKXEmxJ-3ZituSnF-90xQj4yKlJQyjpvnHt_APZrF9g>
    <xme:y4YQagZdaNG9q0mYK9c-KLos75QxvOuJcqCsvovutfdtPamDg6oLWUtHr8AZzoDXY
    1RAmX8vT6eqI4DymZfB_a-oXH6t4XbbfAyNsrQqda99sGIsJaZW_Yo>
X-ME-Received: <xmr:y4YQalqdxpzm3F7Km3_WIT74bfO6GmegJV77oST7Wo4lMH_VyrU7rsyIa7SmqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvg
    drhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphgsohhn
    iihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsvggrnhhjtgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrd
    guvgdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y4YQasup6TlQlPa0RpFlb3ShDBOue9EdzfB-K7GbeWYDBRC9uN_vlA>
    <xmx:y4YQavPyUxP5QcFhQxLothlSb-EjTOoE_s-2TbnBg81gyjqH2D9Izw>
    <xmx:y4YQaulkN87p_KYRBTJeHTVERZTf4MlFH0f001AMflXkn6Cr5fmA3A>
    <xmx:y4YQambkm2J45gsrdcKqdDpOezD8v235x-bCex5hokaPmuMFCHKv7Q>
    <xmx:y4YQat3xeGFw6RfT-3xJkeg1egLNNCQrmOQc4W6RV9B99gUEBbEEHIcZ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:39:39 -0400 (EDT)
Date: Fri, 22 May 2026 17:39:38 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, seanjc@google.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v2 3/4] x86/tdx: Drop exported function
 tdx_quirk_reset_page()
Message-ID: <ahCGtYf2A9C-Qk2k@thinkstation>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430015001.24242-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430015001.24242-1-yan.y.zhao@intel.com>

On Thu, Apr 30, 2026 at 09:50:01AM +0800, Yan Zhao wrote:
> KVM invokes tdx_quirk_reset_page() to reset TDX control pages (including
> S-EPT pages, TDR page, etc.), as all those pages are allocated by KVM TDX
> and thus always have struct page.
> 
> However, it's also reasonable for KVM to reset those TDX control pages via
> tdx_quirk_reset_paddr() directly, eliminating the need to export two
> parallel APIs. Keeping tdx_quirk_reset_page() as a one-line helper in the
> header file is also unnecessary.
> 
> No functional change intended.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Acked-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
