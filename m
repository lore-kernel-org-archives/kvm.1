Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45603BC661
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872282; cv=none; b=eN9sG8gexjS0hH35PZtUPPE2NX2eUjQd93eABRdL5lA8n3F4TnvkPFWuiIGCkHbyHq8TX5rfNhJaqn6KM4hEEg+S21qB3bnCvM2WMDizmem1jYQb8gBSj1Mmlg5GXaew+3D2y45RA0ewHwCt//Udv8voKdANfs1apCruKMvSeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872282; c=relaxed/simple;
	bh=VwusoUFktqVLQuiJEMyM2yggrUr0tGQAF8WDu2luP+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ZP81h3Lu6E456N7lt0TXr6JxAbocoVbWQhgKlyxk2wxvvu389MDcdfBkERClMk3XhLIIzynD+bUg6tH3tJgfn6+TJyyj8Hi8lsPd12g0WpG8FFfLgAk5jDMSXrO0r2AY7E4568CagecWttAzsc5fuFIVrExJNY7O2FvC+OGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEkOci7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEkOci7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C08CC4AF0B;
	Mon, 30 Mar 2026 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774872282;
	bh=VwusoUFktqVLQuiJEMyM2yggrUr0tGQAF8WDu2luP+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEkOci7AZ+8PPEb5cOhzy0Fg8xH0Z5ocqSSsH8pIikHU8A0xtuul75/22qJZ+pbxJ
	 FVDVwXyd6kUsIa/xuVOVw2Q/PsR3VfJm3wZdiG4UCvefdvQfGJN8fP2ebpbBbJiFMr
	 Ew12LVRfzKJ2oOCTW3hQE5lXfS5lnseQoNqekVfsHQFozi9pyBAb9dN0oPSAebpVc2
	 cF3lyRFqMeZmZHxarMPEdW5iZ6AkdABLYsud706qj1sgOUy3NCIv1T2MFhe+LQLkeV
	 E3iVjNe407Vzgvl2I/owZyOB2tr7DARlzLHIXDOkM6xN1LtUMtDTZHhIvBSosLcE3G
	 wff4N3fvYtp7Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 55129F4006C;
	Mon, 30 Mar 2026 08:04:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 08:04:41 -0400
X-ME-Sender: <xms:2WbKadNJkMXD5t5X1jr3wsWp4Prx6qdexLz1cvYtAMFd6BohHI28aA>
    <xme:2WbKaZQypbr3ZQJTmAPhUkfTK0m63KYeFOkgLoXp0Rcnv1AcX0eHuHCITfA5qe6AY
    6NieZoVIu4iCCV2n3qR3_Zc28F4TM283UUhoGORVySrMz7ZqxDjsA>
X-ME-Received: <xmr:2WbKaUTqCCZmmu8DcUBRDns_bypXCZ_tzqPDlCkrM5LRjbfMZNNyPeV6rYlrTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthhope
    htghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtg
    hpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghp
    thhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:2WbKaTY2BGfw9nZgl4PCPLOycheVh34fUV9nw1z_veD9sj3XrTGfeg>
    <xmx:2WbKaQhDORc_39t5TP48wFKv_ctGXZf5ctymmPLCBkVlv-5puvs-eA>
    <xmx:2WbKaQgS8sgbGJtxlD0DMuhifJFq16xPtZJH6JtB0dHbZh5lQzIJVg>
    <xmx:2WbKaeLzSCRVTd8wXd0kHubGthg8HorvF5ROAENWEnn6z7M8DArwjg>
    <xmx:2WbKafXsNR5KMGD6rRAXqX4W4ntxESIzVgMutahLTwtZeVN984AZtspL>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:04:40 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:04:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/virt/tdx: Remove kexec docs
Message-ID: <acpmvCCbzn0mYAiB@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-5-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-5-87a36409e051@intel.com>

On Mon, Mar 23, 2026 at 02:59:08PM -0600, Vishal Verma wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> Recent changes have removed the hard limitations for using kexec and
> TDX together. So remove the section in the TDX docs.
> 
> Users on partial write erratums will need an updated TDX module to
> handle the rare edge cases. The docs do not currently provide any
> guidance on recommended TDX module versions, so don't keep a whole
> section around to document this interaction.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
