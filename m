Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB3C873E;
	Mon, 30 Mar 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874670; cv=none; b=dPV2X/1mIhNqYdlZtXmjFYfuTy1a1pR7ks7fHBnA8P/BABahT9hH/GDmPioN15U3N5N753ll8I+yKy2rsgvoYEw0mfh+BV4FJuH6F8DbTh0BqDmg36wmbbIiToBaTbpryswqURE+PKEdpI4Y7mNPhMorsbqyKBYH34AMYbdrZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874670; c=relaxed/simple;
	bh=9HVTseeoFiIFa1Fuc9Y15PQ06JUGNKZbZi8P95OXuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB6a6JLuIcS8RGj94ySezirX1UwtyySqcNkoiqf9VZA6hW/LyIPLS6TX6sRKz6TYLa1bZYR6UTAUID0j79k4+024JrkIMf4QTuLY3XwRmEGFjy+tIwi7mSZPspSuSl2bVBiWFnJABHW6iZkSGlfMToEwZHr+n5qWkwmkCsde2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdUEB20z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdUEB20z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C8AC4CEF7;
	Mon, 30 Mar 2026 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874670;
	bh=9HVTseeoFiIFa1Fuc9Y15PQ06JUGNKZbZi8P95OXuDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdUEB20z+Lwu6rTtqj0w4fa8LjzZCYX/5qW3Fx5bOky8C6ZDx4TAJy00b2esFRITv
	 Y80TghZR+LB1YtLDbmfH17zGUW1fqGQMbOcOYsAj9MaTtT3SG6uqRsT+ZcaWlpKokZ
	 06WgLSCdbaopzqiO1j+djGt8FuMrZveQMs+2wnyCbDLqRlP4Z8i8gyhcIWxvUjCfvT
	 VN9z8doWTrc+NsXGfAvXc/JkMYQlFP7hobmVjJmgTKVrsO51s2DeYVbhR0VZOR0y/1
	 FH6rVwUht82fWcI4T32Ttv7I0vXEVzaSVBxmVPFXV4qWxTMqZH+I4xLDaa8FdDqNSE
	 WthusplwyrF9A==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 723C4F40086;
	Mon, 30 Mar 2026 08:44:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 30 Mar 2026 08:44:28 -0400
X-ME-Sender: <xms:LHDKaRfv8FXvKBQFHoPUmLPprtB7cEW_CcdC0oCTyXJgkfTZAtsIHQ>
    <xme:LHDKaRG0BIcPoL0y1Z4IzJE-If8lPdaP9y87E7pxU4rcLRyjj0YYdOb8byx9Y2QsV
    0KYlr-FJvj2rqsmxj00ULpXu1NbrmQrNlwrzKGUQOtgXCB9_6UAQoI>
X-ME-Received: <xmr:LHDKafGH8VITfF1kzX9dfd-U-hi0h-U2_9Fp6C5KbbFUhltHg91dBdBCXoW1bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:LHDKaYlocBCyuf6flcFG-zO8Ft_hyXML0dmCgCG76djiBxdjqrf_jQ>
    <xmx:LHDKaawg_EW56LzzG5rBqsqafnHnGkHnClpy_-UGibyT1N7mcNI9tw>
    <xmx:LHDKadaiYwvAdarWx0mZ28GJCFNCUnYxjKPLR2K8AnQekqh3Af54nQ>
    <xmx:LHDKaesV2_6ilyetHDTbW1N1jaYtNOqUACNuH2vA9fYS8JM8IUviiQ>
    <xmx:LHDKaaNh_RRdQ7goQBfRsfSOlWFp9Qvn4wppwxdYEdmdas7csKIDbv4d>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:44:26 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:44:22 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <acpvmL2CjWxv9DsU@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-9-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-9-chao.gao@intel.com>

On Thu, Mar 26, 2026 at 01:43:59AM -0700, Chao Gao wrote:
> P-SEAMLDR uses the SEAMLDR_PARAMS structure to describe TDX module
> update requests. This structure contains physical addresses pointing to
> the module binary and its signature file (or sigstruct), along with an
> update scenario field.
> 
> TDX modules are distributed in the tdx_blob format defined in
> blob_structure.txt from the "Intel TDX module Binaries Repository". A
> tdx_blob contains a header, sigstruct, and module binary. This is also the
> format supplied by the userspace to the kernel.
> 
> Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure
> accordingly. This structure will be passed to P-SEAMLDR to initiate the
> update.
> 
> Note that the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
> a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
> Specification" will be published separately. P-SEAMLDR compatibility
> validation (such as 4KB vs 16KB sigstruct support) is left to userspace,
> which must verify the P-SEAMLDR version meets the TDX module's minimum
> requirements.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

See nit below.

> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
> +{
> +	const struct tdx_blob *blob = (const void *)data;
> +	int module_size, sig_size;
> +	const void *sig, *module;
> +
> +	/* Ensure the size is valid otherwise reading any field from the blob may overflow. */

Comment is too long for single line. Make it multi line.

> +	if (size <= sizeof(struct tdx_blob) || size <= blob->offset_of_module)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (blob->version != TDX_BLOB_VERSION_1) {
> +		pr_err("unsupported blob version: %x\n", blob->version);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* Split the blob into a sigstruct and a module. */
> +	sig		= blob->data;
> +	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
> +	module		= data + blob->offset_of_module;
> +	module_size	= size - blob->offset_of_module;
> +
> +	if (sig_size <= 0 || module_size <= 0 || blob->length != size)
> +		return ERR_PTR(-EINVAL);
> +
> +	return alloc_seamldr_params(module, module_size, sig, sig_size);
> +}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
