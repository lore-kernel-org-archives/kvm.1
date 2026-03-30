Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADF3C3BFD
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872242; cv=none; b=ds8HGcDQ8Gcfi+7O/3wnZyDIMw8KqQnwIG1loR0tdl7cPQ2TjMysfZ8LJetZCZNrzRovDrards1g9TTBn9NQjfaPDRO9ZMOqhQXmvsP1mKPFMQV86Q/XFm/8GDxwOCUkqGyWzful+hoQDWk70dM9ycQKVtdL0VJYkTbEPHRbj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872242; c=relaxed/simple;
	bh=NnydyQA4fk2pwHYpMvXqKJw9IpXV/LZVHHm5ZyztWqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkHYaXhmQCNdgBfBj8FWGos72m94h9Z8mvMexD1Lmv10khzGK2U4piNgsWLjJ0wOWb1wW21ps7Rad8NX+/3LGg+LxmYfUeVafGKZwvdae45DQdv4/0wX6CC5qX2KgHdmEzWybj5/86dg9CL+nO3K5dW4YQdb2zpHL/t/LOqJaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HniKMGaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HniKMGaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4216C2BCB0;
	Mon, 30 Mar 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774872242;
	bh=NnydyQA4fk2pwHYpMvXqKJw9IpXV/LZVHHm5ZyztWqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HniKMGazjMWOjxJOstobs3U5r2Cbcw33aiyZurMr6am15TbB02wb1NETt3M32T6cA
	 LqlzPm5D+5Pc3KSCwzfB3VEtt0YGDX0KvqS/5WeE023VESwsedoxOtUC5NctQtMjyy
	 H80vfUJw9sMDohOjh5IXS5OQG4CnJsnFrD8CHUVRh28Wo1utlb7RqKjdU6Mhowb+IQ
	 wqLVexFObRW0ncilsuZJ6g4Jcyq4wzaoMQ0TM1/+qHxu7CePxWrKbOlh7TahIlt5Ef
	 z0qvGB2fQAbp6kl8JtUEGtxl24M94KFTTxarjEVKihPmOn9UoCpnOzb5ds/L0f3V52
	 ljc9eUQoj9ZEQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E75ECF4006C;
	Mon, 30 Mar 2026 08:04:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 08:04:00 -0400
X-ME-Sender: <xms:sGbKaeB0HMSejDAuDDFnZ29fJPa8abbAWN6T6r6FO7pTlk67ju_LDw>
    <xme:sGbKaaBscFk_kS11UEkGE4-nhryas441MSq_bLUBHan9EJHLIv_oS6f8Crwlcg_n-
    ak_2nBQrZE5rKGPKmFigbGTLjzlkeLosgZejI4pHxa864Z3BM1rXH4>
X-ME-Received: <xmr:sGbKaWJfBT619tJblzQPite6H3yEDl7dFvwSXgL7w1MCZb_rW4XLkv3K1desOw>
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
X-ME-Proxy: <xmx:sGbKacRSRcpXQYhDQSDSpo1GER6AEnCr6tzMsr9dRSiFYSf2VExUag>
    <xmx:sGbKaRSth2TKJ27wWUkrPnAAfq2-lxThswpgxOP4VekD1KO-Clxrlg>
    <xmx:sGbKaf6_WCNt_stPWWxTd5whMwFU3Q9NdSSJxQVleh3k8fMHP_DxZg>
    <xmx:sGbKaeH8IFt9-oFzGIo9Oo4cheyu5wokJjNsBMYrWMotzyT9pIRgbg>
    <xmx:sGbKaQmzV6uumhDTo8Uj-8pLQO9Kr6oJEur_ZKBeisuLOuk96cNPHZ3q>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:04:00 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:03:59 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/tdx: Disable the TDX module during kexec and
 kdump
Message-ID: <acpmkzmE2UvnCEob@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-4-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-4-87a36409e051@intel.com>

On Mon, Mar 23, 2026 at 02:59:07PM -0600, Vishal Verma wrote:
> Use the TDH.SYS.DISABLE SEAMCALL, which disables the TDX module,
> reclaims all memory resources assigned to TDX, and clears any
> partial-write induced poison, to allow kexec and kdump on platforms with
> the partial write errata.
> 
> On TDX-capable platforms with the partial write erratum, kexec has been
> disabled because the new kernel could hit a machine check reading a
> previously poisoned memory location.
> 
> Later TDX modules support TDH.SYS.DISABLE, which disables the module and
> reclaims all TDX memory resources, allowing the new kernel to re-initialize
> TDX from scratch. This operation also clears the old memory, cleaning up
> any poison.
> 
> Add tdx_sys_disable() to tdx_shutdown(), which is called in the
> syscore_shutdown path for kexec. This is done just before tdx_shutdown()
> disables VMX on all CPUs.
> 
> For kdump, call tdx_sys_disable() in the crash path before
> x86_virt_emergency_disable_virtualization_cpu() does VMXOFF.
> 
> Since this clears any poison on TDX-managed memory, remove the
> X86_BUG_TDX_PW_MCE check in machine_kexec() that blocked kexec on
> partial write errata platforms.
> 
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
