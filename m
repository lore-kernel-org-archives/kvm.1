Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372540DFDA;
	Thu, 19 Mar 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928968; cv=none; b=UYzyVuFPPSbhAqfMUB1bb5lMg0KJaFQegcTKi6+MH6qzRjr682LN6A8l3e/nogotj6kRNHRto0yLkAJSjHgcNd9tcMtBKJXwfRMUzyZ8tW0QLKauAOw13+5cm845XMn4i8vl9JOxxkQKp4VUpQB5tsbHTtXmXqTh1Et/x6noBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928968; c=relaxed/simple;
	bh=1nOUDLzIsI+ypmwm9nIFux0dhfHp7MoCI7fJyobFvzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ0DW9QpSJ0v+6LMxl0fuZT+YO7BCrwhgetcyihG1CMgr8v+NBjA23XTrr5DyAwa8f2PX+yYM3Ktf3srTW96bdyLxmLYdO883hAUksI9KZOudepqT4UUagrLu3wpbC5EiW3m2NhbXy2V575HI5vC+8BTXTUOyS7tBOicG/F6ANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu2577oe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu2577oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD3C4AF09;
	Thu, 19 Mar 2026 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928968;
	bh=1nOUDLzIsI+ypmwm9nIFux0dhfHp7MoCI7fJyobFvzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu2577oeLtZrP16lr5bPOvGqElrQsxAhcuk0OP68tTT19ZfEg4rNlIi9S61+naw4/
	 HAYj2kKHQSoU7HqKco9O6mQxCei4fWq8P6Po2Cg9g0EBIoFUUarc1jOwf/ny0coFwh
	 4FWgsVikQ78wycZx1oPvX+JipI7IV4YDdWVceeasoaftmf41qQE+YSur7nvkSDCAiV
	 IQq7a/RgBW5b6TKRn3sm1yHyg9G6dHgL02RPbZahz1oHuKK0sIV7n3gNJvXfXYKNGq
	 KjD4zwHagu8R+rOdw41ebQT2oVedaNi3k6itG/hDl7Os2edffJ/j5rnyMxF4iI0XPW
	 G/X9X2cfVfcxA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0467AF4007F;
	Thu, 19 Mar 2026 10:02:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 10:02:46 -0400
X-ME-Sender: <xms:BQK8acCY3u93uJNEfhFG5YuybDr-WxBWYIebCNWj8tZ8JYgsXAnSEQ>
    <xme:BQK8afOVS1Uig9v7qryC0Gz8AmsV7icm2tpfSoyDWwUFk_GdpJVBe9h5xci7LKwb1
    czhpQ6E8Z9Hb1tTc0kbDXUQZDygxwZ3aT2LfHOK90_i6wh3Dke3_d0>
X-ME-Received: <xmr:BQK8aaqR4l6fYvmC4LjQ0-Ihr1SMNSI8vN8WePqvY6Lx8uRcBz8N5yl17vHX-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetudduffeludehlefhuefftdfhudehgefhleehveehhefhudfghfetuddvtdfh
    leenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppe
    hkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohep
    hedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrohdrghgrohesihhnth
    gvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtohepsghinhgsihhnrdifuheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthho
    pegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    epihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehkrghirdhhuhgr
    nhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:BQK8aSyT3wxNoaUXV60x9Duq2EG_XJxrZKAbBYNY7mcMkQtUtmuUog>
    <xmx:BQK8aUO7TUAqMoj-uyv3JDifoLWmoFCkmlLv29O0ji--mqTY6Qk0BQ>
    <xmx:BQK8aeD4X_rPapXTCWrSFsK64qYH5ZU0v8i-yqjxd-jEk6xiQzpx4g>
    <xmx:BQK8aZVbEnb4VZ6rEhjQO4RYvKoyG9eYJILFe3kp4uefZwl8Z1zSLA>
    <xmx:BgK8aQIdvQ1HU7KtQCBBDisMENbIcbZBqGCTE4K_OK6cbPb0qO0V_cWf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:02:43 -0400 (EDT)
Date: Thu, 19 Mar 2026 14:02:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 18/22] coco/tdx-host: Don't expose P-SEAMLDR features
 on CPUs with erratum
Message-ID: <abwB8wtFVFOONJGl@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-19-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-19-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:38AM -0700, Chao Gao wrote:
> Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
> Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:
> 
>   SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
>   to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
>   SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
>   instruction.
> 
> Clearing the current VMCS behind KVM's back will break KVM.
> 
> This erratum is not present when IA32_VMX_BASIC[60] is set. Add a CPU
> bug bit for this erratum and refuse to expose P-SEAMLDR features (e.g.,
> TDX module updates) on affected CPUs.
> 
> == Alternatives ==
> Two workarounds were considered but both were rejected:
> 
> 1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ugly
>    assembly code [1] and doesn't play well with #MCE or #NMI if they
>    need to use the current VMCS.
> 
> 2. Move KVM's VMCS tracking logic to the TDX core code, which would break
>    the boundary between KVM and the TDX core code [2].
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@intel.com/ # [1]
> Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
