Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB2375F7D
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926655; cv=none; b=uYRK41WwS9Yz8u0HEMzdW81XcrevkmeiK1kJFFIASgPIHmiCXr2DbRQQKrpn6Bad8wpRanwj7S2qRKJvCppZ9xYbiY4E0oPQnzSwXzeAvzvnB2H7qFx+mFxbUIZOxS9Z6ycUyBS+JYZiDK+5N0sZAR3lVaUIg7zVjw+mhzD9afE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926655; c=relaxed/simple;
	bh=cbOf0Ns12p/0gJph6pAN50FxRbZWKaf7EOghzAgoMkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZkgl/LxAEVYMskOjksyIEgaJqHeOOcY71B2O7bqTCT+lBZ8xiBNUbK5r5UHwxLs6Dt+Zg4HLBDwJsEldiMsj6m+TKMOHLUnFG0EGb7rt/2JuUEBOm7jnlDFwhrELRK1x/vCuluop4d6dYbdN2JyDob+o8GlW48a3cAhaq+mij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtLhAldY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtLhAldY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902E4C4AF0B;
	Thu, 19 Mar 2026 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926655;
	bh=cbOf0Ns12p/0gJph6pAN50FxRbZWKaf7EOghzAgoMkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtLhAldYL1NGVzvZFiP6LE8A5J5a5zpBR2usoBWjAK3zu2Dap5L81KQM6a4gdj7M5
	 ZpjXGcpdYFc8sxDPi/vvdHHv99rv6Tw6jF+B0w6KTUSWagZCbb5Z7HfcUPsgNGya4Q
	 AjosRDPwtfkzLVBKaEx3nkv0NaAcngapHq4ItAX6rZ6WPHCm61u06wMcBfJaxp5qQa
	 Gf1p1ijnjriNxPTzmixFU1FRrSZImLhPNOvSpouijKVzLptbKfwABWxT/7YmC6jFLh
	 ZYb4JGjR+Da3bdNh20+cT4pqZ1neygTcc4p9nt3OxIpnyQ+4ImvNhQXrtih2mzMjX9
	 IxQLjrIcDDwSg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 48094F40069;
	Thu, 19 Mar 2026 09:24:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 09:24:13 -0400
X-ME-Sender: <xms:_fi7aQfdjZb8R9SdSBs61DhuL1SqNl3zyBmMUUqQbB5B5jOkqohfJg>
    <xme:_fi7aS7NZpK7TB5Y9lLYvDNEZRsUWCg1LjWyX14EALhRKcuzhwtExb2YWuEa_jsM3
    FPqyChnA6Nlf5xK6uKP5MSrJKtFloGoa_Sfx62w4Yj0ANDSmhbJeA>
X-ME-Received: <xmr:_fi7aWCCVR9OhzUNTwkbjp2CT68bzTLNs1ElfVnGaOsnUh81MkB50xKkFb59Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhsse
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:_fi7aWdMXa3DaEFSPq2vAxQ2lmLLONjPJ_Vlq7iQh1zh4yZyGjq0VQ>
    <xmx:_fi7aTQdl2utfqn_YhEIwAHEgFPytIIDyKlsTgSK20Qgh6E_nY1sjg>
    <xmx:_fi7aVlLoIplPq0rimhHoFJPZ4Ts9BrqnslPV3ZHx0ARV2T9E8gJTg>
    <xmx:_fi7aXZLRlRbY76qFTm1VWx9CepWzpkXQdg680O3U-neQ3koaMqWFw>
    <xmx:_fi7aY1RC2DyskfyOuD7p172-M02_btrlGOYfImWLXqRDbA9hplGO8QJ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:24:10 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:24:06 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <abv4OWfqDOOLR9XT@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-12-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-12-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:31AM -0700, Chao Gao wrote:
> The first step of TDX module updates is shutting down the current TDX
> Module. This step also packs state information that needs to be
> preserved across updates as handoff data, which will be consumed by the
> updated module. The handoff data is stored internally in the SEAM range
> and is hidden from the kernel.
> 
> To ensure a successful update, the new module must be able to consume
> the handoff data generated by the old module. Since handoff data layout
> may change between modules, the handoff data is versioned. Each module
> has a native handoff version and provides backward support for several
> older versions.
> 
> The complete handoff versioning protocol is complex as it supports both
> module upgrades and downgrades. See details in Intel® Trust Domain
> Extensions (Intel® TDX) Module Base Architecture Specification, Revision
> 348549-007, Chapter 4.5.3 "Handoff Versioning".
> 
> Ideally, the kernel needs to retrieve the handoff versions supported by
> the current module and the new module and select a version supported by
> both. But, since this implementation chooses to only support module
> upgrades, simply request the current module to generate handoff data
> using its highest supported version, expecting that the new module will
> likely support it.
> 
> Note that only one CPU needs to call the TDX module's shutdown API.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Nit is below.

> @@ -100,6 +100,17 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
>  	return ret;
>  }
>  
> +static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
> +{
> +	int ret = 0;
> +	u64 val;
> +
> +	if (!ret && !(ret = read_sys_metadata_field(0x8900000100000000, &val)))

!ret check is redundant as well as the ret initialization above.

> +		sysinfo_handoff->module_hv = val;
> +
> +	return ret;
> +}
> +
>  static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  {
>  	int ret = 0;
> @@ -116,5 +127,12 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
