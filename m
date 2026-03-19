Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D033C3C1A
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917299; cv=none; b=p9oRsM3LOxmrPCAn5zKFItg9cTw09qwM0iji1yfp34Iw6LrieHWbfbU2FqBaVLc8zZvjN/bNQSROdSOnTsMzAUXMZlOGOcdU7997fbxkwiY0AzrqBtHjPdj0qszFSb+9Am5wr9Ki9tAxivFfoiIaUDmhSx8d1MRbmvPgse2PtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917299; c=relaxed/simple;
	bh=3T7ngCyy4wCxxBz5I9U8xAC3Y2tmHvn48suxEKq2kzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCpRKIjtcYUQKCM2pPcA/FrGaKjDecVmY/RFXZwvqaP0GTrh8HV7+Muq9nx9dCoZy1OsAdEpvegaqyWGKHSTZLL5mmAIuxzssGhZ5+KhjNme+HLS45LitC70jhq3bZ3Vmm9A1V5qtwC13mCJPw0xDLJxgk3sJWjc/0BFHsvbSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMSscrnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMSscrnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9373C2BCAF;
	Thu, 19 Mar 2026 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773917298;
	bh=3T7ngCyy4wCxxBz5I9U8xAC3Y2tmHvn48suxEKq2kzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMSscrntBBFWIVK/Gtkep7GS1UrNBoIG/0T9C0o1HE/frMnlErTu64YKdeftCmL2G
	 eex7iLoh58GfGiyG9NwOEw+rh8B0aPwSuxeWUXdqNmiIyQqlRCWUS/QnA1O1UYon54
	 JLJADQJqdzV+O4qDtWNptp0uk/Mippu58POlK8WIZQkWw8zEp5n8Qc3M3qElZWfx3A
	 5rODoKfrUlK4eX8sMxwIN8GXz8c8xu6OmFcZj8svsRrwSCzsHs/ARwOQA6vspv8g7L
	 WPMpczk4fPu18tBO52yqrbaRcXpdSfGvf16ZUxc2oQXaQJy6qpfie55Y6QSfYtAZa/
	 DrsPplXNkgcgg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id AA72CF4006B;
	Thu, 19 Mar 2026 06:48:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 19 Mar 2026 06:48:16 -0400
X-ME-Sender: <xms:cNS7acvd16ZuYp-apANAFglPKZkdRnSTWJ5EGJXyHKfXkYjTcp69Pw>
    <xme:cNS7aTtvjTbjPfAnyTkeeb5bYnUSuGPN4EyJmnzVh326vpW-zsD8-OX03BtXVyk2-
    HDR60Dr74l3i0Gr-rAYSaDbr0SXPCbL4f4_Qr0Dak22vlG12nsJwN8>
X-ME-Received: <xmr:cNS7aZgsje2DXlRDJm7jg1PItCjgXg8Xn50Ay_QiTozNDKMOclwW7V7sz6un2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeikeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cNS7aTzSctL5RGzFD0EWPLQnAphqAoEYcGtR29GsFsR_SiKMHSxbUw>
    <xmx:cNS7af4MRBDL_3DLZ_HVVhxN7LqnU_AIZmsSPrpcDVl7RFZoBIAUnQ>
    <xmx:cNS7aVdTXgqRjzW2yZKHVo3o4nYNsGnJpy2OVLwhN7LrMHZN-prqbg>
    <xmx:cNS7aXq0GsNTg0Vydu7u4iiICmyIbJWWyVsXMMsIRSz7Xo1ljFpFrg>
    <xmx:cNS7aZ2INRnJbG_sgtSD8yak5d-j8pzJB3wa26Y6bmpXW2qzmimUG_6V>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 06:48:15 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:48:08 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <abvTJq0Ks22WnLSA@thinkstation>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319005808.9013-1-yan.y.zhao@intel.com>

On Thu, Mar 19, 2026 at 08:58:08AM +0800, Yan Zhao wrote:
> @@ -1817,11 +1817,11 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
>  	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
>  		return;
>  
> -	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
> +	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
>  	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
>  		return;
>  
> -	tdx_quirk_reset_page(page);
> +	tdx_quirk_reset_page(pfn);
>  }
>  
>  void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,

The same problem. @level is ignored.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
