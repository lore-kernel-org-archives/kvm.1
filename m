Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA8381B16;
	Mon, 16 Mar 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665342; cv=none; b=JavhiT1+lp4tlrBxVsUnUu+24BI87IuFEYAu5d4s8msVKuD2hMes6lRrF2RHLgefXh4LROmN0MSe53cMU5hkWgLO6/3yaaMH4xHGkCVG4W3ciVdinrhU9aDQZlnCI8R4Nrzl1ZiCTqPx3BjKplSIAACSB8oMmHrLzTHvlLiAIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665342; c=relaxed/simple;
	bh=l4pswjmvDz7c0Ngy2DygR/lttVgW8y/M3DtTHJcCaZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOMpbOrGvzBzQoT5VQaIFaudR1pyQh2ahEVvD53HM5W8vELFF5PFcAm50Etv2qTVb4U+3mbMEdcbhd023Wj/sMDxmuLN5jzsq0m2YfxL9pbgB7Vv3zafIvnUVW4GqtWwvcQxTzxcjr0apzUTpjvIa3SVjGR23HTTVoWZlD7cPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDEJYEBc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDEJYEBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A6EC19421;
	Mon, 16 Mar 2026 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773665342;
	bh=l4pswjmvDz7c0Ngy2DygR/lttVgW8y/M3DtTHJcCaZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDEJYEBcEhrhjGwuLnl/lEjFeArx+Ck53Jp1LRR9F3ay4DEcN3Sv2YaeJI+VVSMRR
	 Rd88Wtw+X6a0St2PeWb5Nn4+rGkxm0dgjS6xWYEHEPfrQAzbC4/PWqqaggBoV84oGf
	 xbsVSKCstUmRvlzLoKIq5jNVS6haOHHdsh8/6QysAiiis6jLgyhnWJGv7GdEKGnZs5
	 eS4cazpU3+A4cP+3lpX2+f4EhwzehZkJ4KzJYd2HucDWbwiRadEPHAuTgFB2+SnlTD
	 f3RQufgjFru/P3eOzEYLUjcuZhV5/tabtmp84rVaCCI81skwDnZms10NUdTo9jMpk/
	 wqrc5Idk14uHw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 96151F40080;
	Mon, 16 Mar 2026 08:49:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 08:49:00 -0400
X-ME-Sender: <xms:PPy3aSxCiNE5-m_xSHnsc4lQqIODlh2ouHkw6pRWdrDxpAnBkFHSvA>
    <xme:PPy3aczenFjbNspx7lFSqDIL9rSlB_ZTr4gBbnFnzl1UZG503Z6y8tqmeBGdRgh9x
    zd__fJT9O7z0lD6XxFlKqdSsln-g7BgIsTGm3Iqgx6BRXGJwFayDfE>
X-ME-Received: <xmr:PPy3afJLdvp1bd3r8Uv-2h90TriD-v2ODQ2W4KBQFjVNFlxSCHWzUWJx7-c5-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghordhgrghosehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghn
    ghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:PPy3aetNKLFbswWVADN6f_LaBvnpVA0-1olARnFWXMr8qdbxmzrN9w>
    <xmx:PPy3afhXE26yk40AEI729AfaLjaM1yg_Ucn5VR8ukYIJo_zklbVStg>
    <xmx:PPy3afv-g_6p8Jpm4-T_cl9tDjc0K2rQGalfP7PNzarCOH2gGE4JKw>
    <xmx:PPy3aaIg_6TdmHdfJ37CDF64jx37XTRoDKkKz4K_yyJ9ESonbfZbOg>
    <xmx:PPy3aZtQw8Q6aEwxGezq_mLcOEq88yC13PQ3jutuz0u0X0zvGRNafvnO>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 08:48:57 -0400 (EDT)
Date: Mon, 16 Mar 2026 12:48:53 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 02/22] coco/tdx-host: Introduce a "tdx_host" device
Message-ID: <abf8KDc6It4-APeu@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-3-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-3-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:22AM -0700, Chao Gao wrote:
> TDX depends on a platform firmware module that is invoked via instructions
> similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> manage private memory and private device mechanisms). It is a software
> construct that depends on the CPU vmxon state to enable invocation of
> TDX module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> implementations that employ a firmware module running on a PCI device with
> an MMIO mailbox for communication, TDX has no hardware device to point to
> as the TEE Secure Manager (TSM).
> 
> Create a virtual device not only to align with other implementations but
> also to make it easier to
> 
>  - expose metadata (e.g., TDX module version, seamldr version etc) to
>    the userspace as device attributes
> 
>  - implement firmware uploader APIs which are tied to a device. This is
>    needed to support TDX module runtime updates
> 
>  - enable TDX Connect which will share a common infrastructure with other
>    platform implementations. In the TDX Connect context, every
>    architecture has a TSM, represented by a PCIe or virtual device. The
>    new "tdx_host" device will serve the TSM role.
> 
> A faux device is used for TDX because the TDX module is singular within
> the system and lacks associated platform resources. Using a faux device
> eliminates the need to create a stub bus.
> 
> The call to tdx_get_sysinfo() ensures that the TDX module is ready to
> provide services.
> 
> Note that AMD has a PCI device for the PSP for SEV and ARM CCA will
> likely have a faux device [1].
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
