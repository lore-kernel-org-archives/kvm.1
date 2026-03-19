Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EC3D47A9
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927797; cv=none; b=tHdzwQtJkkDMj+45vZiKQ+tdPTglQSzaz9I7jeCVgDQ6GLKWbAEkGKFUtfuXMr7ZMX87TS8I0d9DBaj/C0JRRdHbtObc24d0ais9rRGMTWxxBagJnzlrQB1uXBoA2sChEmpZuDk5XLg5KsEsxaSRZHnJxhUuZIgN6AaAcjb5JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927797; c=relaxed/simple;
	bh=yP3RZToQo4cbnbFuGrCYtRZiwEUU1IeskM85/sIfISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSoG1WN44geR8fG34Yx/s8gc/gT4YLKr4IKR3hwfLfpipL6q/kfBmHxKCf7HnQtexnEX7VJN7tGz/aNgTZsOzkKuBgC6QoWAAJ5kfMc4rYECbCfd6KlJiI2Pe1a1z44n7U979adHf9dr2P8vuP4dQwKzNofVzrLtit7tnJz111M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU18eSqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU18eSqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F00C4AF0B;
	Thu, 19 Mar 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927796;
	bh=yP3RZToQo4cbnbFuGrCYtRZiwEUU1IeskM85/sIfISw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU18eSqgSvwhnfI7YjU8jPz2wisQpjSLUgHZ3EBr5aRqilr3QTd+MgT60y+v8T4Ac
	 iw+U9qPnjIQAKYkchSBGS5tCwmSIUWhYIzUtjtnonUMFb+FdLRXiaKb1Z2BKJtQuPj
	 eRPXVbOKQfTcnSNFhOtBgUF7bPu0oy5e4LtXwKnCriXdIBVmME+QWu2du/PGV3hMU9
	 PWg0V3tNiYQo3BYxLTIU/TJsrC9Kagq7Mojd62Ou5e4pajZ2HG+Jy+jATbEFRNihll
	 HY0iFV5sSZYV6MpddEMq4OC0TQHmljRaNKGmehsUqTA6L/ATmhFfQmDvZZAhZiw76v
	 2TcHt6hGYpBnw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 498C6F4006B;
	Thu, 19 Mar 2026 09:43:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 09:43:14 -0400
X-ME-Sender: <xms:cv27aZr87o1Cv3uR1cHFFNxTCaKNUwS2kDJIiekoo1qh2bEvrXxJbg>
    <xme:cv27acX183RxdA0aFhE0ZV5SdhDUb4QiJRHsy8H4L7Ua2Pv6DlJUfKVAGNbGre-lC
    7jC3Kae4JMMhEYTaQ6Srg3cEILkAWh7s0Nhw0XG2Y3d7GhOv_Yl3_E>
X-ME-Received: <xmr:cv27aRQKQpFnIxXb8LR_pzKZv4yb9wR7_mXnbDTxTe5zRNcqk_4HBWxkkkjT6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:cv27aU4UbTPsaa2072waZ7C6bQH-h7h4ZQmAR6GxmOnWZad3Msr0jg>
    <xmx:cv27ab1C6lN4wu8GUCHFjyLb9qIgpmqo_7qeK6t-RDPa2wq5Lk270Q>
    <xmx:cv27adJDNaYUu3jWvoydN6ca0_4AtYwu8Zj-KTCvmLXGNpUBsJuOyQ>
    <xmx:cv27aZ-wUDSNYwYdyXOh9gP_ghoN5MJI04C_cYw9h402mMcrhJTPGg>
    <xmx:cv27aURO5h-Xv1z-eWaOt66pH4yt1WuQ3wOjr2HqMUnKRxN-saB4mcxu>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:43:11 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:43:07 +0000
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
Subject: Re: [PATCH v5 16/22] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Message-ID: <abv9V8XE957bNGbi@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-17-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-17-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:36AM -0700, Chao Gao wrote:
> tdx_sysinfo contains all metadata of the active TDX module, including
> versions, supported features, and TDMR/TDCS/TDVPS information etc. These
> values may change over updates. Blindly refreshing the entire tdx_sysinfo
> could disrupt running software, as it may subtly rely on the previous state
> unless proven otherwise.
> 
> Adopt a conservative approach, like microcode updates, by only refreshing
> version information that does not affect functionality, while ignoring
> all other changes. This is acceptable as new modules are required to
> maintain backward compatibility.
> 
> Any updates to metadata beyond versions should be justified and reviewed on
> a case-by-case basis.
> 
> Note that preallocating a tdx_sys_info buffer before updates is to avoid
> having to handle -ENOMEM when updating tdx_sysinfo after a successful
> update.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
