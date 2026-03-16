Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AE3947AB
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664890; cv=none; b=lbtzVfd7KcZffnwWH2mJtP9HA8PV1G9pMM7oMsRA8gGi3HrY/v8ySzY8BrT/9jLsQ2tAowmax5WLdzGCBQKBXdfA9ef01a9drTRsO4wHlcy67lVPlxnFsna0LdmIJNS+LSY/Nt3fqmUTV0pHQ3c0rkDz3M9gL+p2IB61zCgfTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664890; c=relaxed/simple;
	bh=1A1LJv2tbG5zmgXcZGfUYUBEqNpLPViz753UcojOzbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXVAkCETd+K7c7GjfN6ONsaxpliykvtA0N3usATkfgmdlgUo6BqpIZQVWa04GTxgkOiFoAgrLrfCuRXVyH28joTInm50nKnHTCWWHpiMzMceVgUHuMd9IfPyTQoUXRB88F4WPQbEVQmYH1ueGteAcoPiDmSxoD96AjiM5tPWkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoAhyiWd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoAhyiWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E04CC19424;
	Mon, 16 Mar 2026 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773664890;
	bh=1A1LJv2tbG5zmgXcZGfUYUBEqNpLPViz753UcojOzbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoAhyiWdndlh22lQLdb4GJbl9iU53Ry1ftJxvc2CSk42utIFGPgCifyTlvwrFfQSI
	 23nED51KV/Zqy+CXH+WT3c4p97qNUK2bhWE18pG6xHJXjDKqK1CH8tz2z+jDvQmwxF
	 Yvn5MxKzugXVHsTlxiPB4YMgq2oQj8N6WxwK96GdDRR5f1VovUmQV2+Y+sHcftdX2l
	 tykmt+x0QaZ7GWCIPJrkl4bRoPyPjdSaQ9PB5kaPaoFEgT5XCznl1fAcq/mbym51IP
	 2Dmbu99jhwEOFHKFW4C9kRA9iU7rGwEMz8L3cM5JOOzkazXL7GmySrBHfmapV3Jvfc
	 ZNS4CvJw0r/Xw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8E0DF40075;
	Mon, 16 Mar 2026 08:41:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Mar 2026 08:41:28 -0400
X-ME-Sender: <xms:d_q3aWtO5Ch8t4LsxCgT_yK9gFf9I0ECpLwWhSIPhfAExAl9BEw5kg>
    <xme:d_q3aZ-v4imFux1-tn_B9xkkrvQG5rsY58YM45xknFLVc0vEN1trbIjxJtA7jsPpq
    D9N4Lqik5YLvDp_kFnMsnvMEC4WIUB92D7WEC0Snz8AJMQjl4TCjS8>
X-ME-Received: <xmr:d_q3acnHUUucqg-Y5kgSST76pQ_OBg9snyFt-IZEaDPr1Ggy3g__tQeyU3Zasw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohephedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:d_q3aXYyE-zZCGOY7vOMPqxwcJgRBZdgExetkYs1v9gx4uGy4rIWmQ>
    <xmx:d_q3aSeJj8dgbZgbEiae9OpiWEbyp2K7NgIcLeCxucIDyN_tb2Jxkg>
    <xmx:d_q3af4p6cXAu3XER-usRq47oErLYX0BQpgi1z6f7GTtU9Gv-eYxIA>
    <xmx:d_q3aekie7CwXci073Lit2LqbZUxo3CpBhSW5uU-xvVvfaJKuTP3gg>
    <xmx:d_q3adYSEL5yMCoO2V7SarQ4jY4LEkUS4ddHXy4Ie7H0jmKLc4fxr9Bq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 08:41:25 -0400 (EDT)
Date: Mon, 16 Mar 2026 12:41:20 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 01/22] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
Message-ID: <abf6LKbmrLjVGs8i@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-2-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-2-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:21AM -0700, Chao Gao wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> TDX host core code implements three seamcall*() helpers to make SEAMCALL
> to the TDX module.  Currently, they are implemented in <asm/tdx.h> and
> are exposed to other kernel code which includes <asm/tdx.h>.
> 
> However, other than the TDX host core, seamcall*() are not expected to
> be used by other kernel code directly.  For instance, for all SEAMCALLs
> that are used by KVM, the TDX host core exports a wrapper function for
> each of them.
> 
> Move seamcall*() and related code out of <asm/tdx.h> and make them only
> visible to TDX host core.
> 
> Since TDX host core tdx.c is already very heavy, don't put low level
> seamcall*() code there but to a new dedicated "seamcall_internal.h".  Also,
> currently tdx.c has seamcall_prerr*() helpers which additionally print
> error message when calling seamcall*() fails.  Move them to
> "seamcall_internal.h" as well. In such way all low level SEAMCALL helpers
> are in a dedicated place, which is much more readable.
> 
> Copy the copyright notice from the original files and consolidate the
> date ranges to:
> 
> 	Copyright (C) 2021-2023 Intel Corporation
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
