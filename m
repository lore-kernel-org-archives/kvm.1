Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31F3A8734
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959776; cv=none; b=IPzdmVM70IoyoxBs+yf65DAZ0Eb5F451n8BrNdMYCI8jpJrbMHRe6hJ7G5sxK19frNag6GXLX1AFZ3q0BTjz8f2tnLBPGWGDCtEftSiH9xkK2pOBhTWOAAAvZ+4aFRu0GV9ou7cunhMUgVOsJ1sqflWPkCNHtnBjrB+0X1hZr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959776; c=relaxed/simple;
	bh=EjT+z1lHSGZLNpaBNN0UDxAhCeLWzJMy5CnLSkm6xFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg2VstMyQf83LxoaG6hEkEJu8L+Ulcr99KaMz6o1tB2PGNW0i7S/1iG0961MZiD4VYqfXvw1TSVzgfgKQieUqvnojR7OjITlVQ158MMHLzcU+xtQ33Ts0A8rewC3SNxYrMKOnzQc3LalbuVgQ9HI0Tm6mIIF70J/8wSwFcCJ5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGmDiOa0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGmDiOa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1068DC19423;
	Tue, 31 Mar 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959775;
	bh=EjT+z1lHSGZLNpaBNN0UDxAhCeLWzJMy5CnLSkm6xFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGmDiOa0z5BTtBNYD5834sqa/AXE2HDkfPwr3d497eLJN8SSlrjTEuoS41cnOF+Es
	 BERjSk8l9qyViEz3WU7S0jIg9bKZ5udT1qLPi3LQjZXudkcHFoo0dyoXAlAWOJXYrI
	 1++LJFG5w2o9Kz5+FZ9/t+3fwIQKm1//e6BlLtlc7OSf8t/QZKMBYXq/zki+D6Azed
	 R3iIvp1e639ZJa+nTmga4raNrSpkzaqMbfOcO7evVcFZdokitY79XYmPWYfE6piHL6
	 aHBSHZIDqE3f+ydr/Da3CGXxqAZAMANc1yZGQeZeDmrXmxlx06/9fYkXMFHxnu6gDj
	 mFyYw8OHwO1cg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37776F4006C;
	Tue, 31 Mar 2026 08:22:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 08:22:54 -0400
X-ME-Sender: <xms:nrzLaQ2sex44muOrvjP8FZ76AkAFsHnMmelpk9kUIEmqRGEyUY6uZg>
    <xme:nrzLaSewJEcpHE76buRk1YsKt8_Aoc075RPto5biB80KoXm1511rtC6ZCSfm9BWeH
    sexauCE7_O6Tih8DzBrh7NtNZe3pRU9pQKKvF3vHtkSrbcnPUypcoE>
X-ME-Received: <xmr:nrzLaTMyxp1V7yHkuxBZN8HIHMrI5SPu9Lg873XuNhvu7yi2fXrD5lCT5d30qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    euieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdek
    geeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmh
    gvpdhnsggprhgtphhtthhopeehgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtgho
    tghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtg
    hpthhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:nrzLaf1u7dxj--KbMAfXCYPc8T1y9u1tTz-S9CitdvksrDWRWmbL8A>
    <xmx:nrzLaW0mifix43rD-FfEUhZEEqhgmsqh0zHyt_GTAiYP_tNSkG8sBQ>
    <xmx:nrzLaVVLsmw6sKafpTq8TanQ-Nwq31PkOu4P1Ih2jN3OxdyxjZNyGg>
    <xmx:nrzLaYj53LvAWIGnOoRRaw7rBmlS9f3W11Vuirs3duHee9SO-5PWxQ>
    <xmx:nrzLaYKgxfEwmUWoCgcFc8S_JSBXjPzlRcO04SYgYINVsckXDYCd7QRP>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 08:22:52 -0400 (EDT)
Date: Tue, 31 Mar 2026 13:22:48 +0100
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
Subject: Re: [PATCH v6 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Message-ID: <acu8fPCY6K_70Rs8@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-18-chao.gao@intel.com>
 <acp1YAMOCiKpcZaz@thinkstation>
 <acsynOGSc5FBiI0R@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acsynOGSc5FBiI0R@intel.com>

On Tue, Mar 31, 2026 at 10:34:04AM +0800, Chao Gao wrote:
> On Mon, Mar 30, 2026 at 01:07:27PM +0000, Kiryl Shutsemau wrote:
> >On Thu, Mar 26, 2026 at 01:44:08AM -0700, Chao Gao wrote:
> >> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)
> >> +		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
> >
> >I think you need to explain what would happen if the feature is not
> >supported.
> 
> I included this explanation in the changelog:
> 
>   When the "avoid update-sensitive" feature isn't supported by the TDX
>   module, proceed with updates and let userspace update at their own risk.
>   ...
>   
> Do you mean making it more explicit:
> 
>   When the "avoid update-sensitive" feature isn't supported, proceed with
>   updates. If a race occurs between module update and update-sensitive
>   operations, failures happen at a later stage (e.g., incorrect TD
>   measurements in attestation reports for TD build). Effectively, this
>   means "let userspace update at their own risk." ...

I missed that, sorry. But the more explicit version is better.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
