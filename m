Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41862258EC1
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876055; cv=none; b=gV9kinuLsEoZQI0Y28bJSWnhcR7Kh+4jZKS5w9or/LZPwfBvN5ZAZmeUucEDzZLRNsWQxst/jY0EfQUeWVEBzAd2izZUmODWpJ+yD9PPjOAPQ/WyTm1fyDIB84MoNWlPMHLAD/7rUXwGhhTMebgkhdpvje/Uv+rGTbT9UI5eWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876055; c=relaxed/simple;
	bh=HBsUbCbUCmapLutDlqMPyNFzTJGNey32KkW/5X5/nKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1TpunF8ZyvAQsFyvDE3s7cXWQtaEQ+QlC4ii3z+SvbIDhRsBmr/z+MFrjKSZOrNbi3NB+rXDpdVkoqyS/mTBqrbNA6a0vV1s5hxV0f54BF+3atrcezqWHcc0svphoa/3ckWItwVIEfKwjxn+yCHoYq4CZEJSv78FyFoo2JKeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoZUWCMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoZUWCMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5B3C4CEF7;
	Mon, 30 Mar 2026 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774876055;
	bh=HBsUbCbUCmapLutDlqMPyNFzTJGNey32KkW/5X5/nKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoZUWCMMqxwpR8hUJqrucYQELiFvh+Me9IUFzpqOLaqaNewM3lqjpnnAgbRpdw/zh
	 w2KN1ZJZZglgVs7e1BXcLkz0empNOzNliwlOggJ+kVA6QE2knkfmAyobZMPCcLx0+v
	 J1VYHLIbJo8348ma0+u4oCegaKWI830kaUn2m4YFY8j5cQ1nQPl7artQGI6HTbd09D
	 a15ccWLkgDVnia7Fkdn0u/dcWtpo/C2kMi7gzHz/IwgzjaX/DpVjlDOhwtxPMEcmmp
	 CEU90izu1mytbWUivgkxei9O3drBhjV0aRy0JCVCQKb+us6Mtzax/zkrX+mG7eteko
	 XB4WjXpu7Zalw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81566F40076;
	Mon, 30 Mar 2026 09:07:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 09:07:33 -0400
X-ME-Sender: <xms:lXXKaSJ90RvdFqbDiOf4s8jfDK4C1k4l7PUbcqnE6QRy1Az5G3VzNQ>
    <xme:lXXKaRiU4zOPf1og7hWZAppAkmrMVUDtUAaxNF2KTms4IMw12A9hOLrsEfSxFWZGD
    nfRhpfaJNUc0A9HZfHt0RhcQ0ToT1bM2Gd6Eao3MMgnxGjMBxN09WA>
X-ME-Received: <xmr:lXXKadDFAwwF_9D1mB4GsLahpTE78SXxsfvtPfQoH38XW-EAJwbXtY_M91HmBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:lXXKadZWgFquRYElq7s-v70ObF-Qs4En4JQdRuVlRfecEhYEjx6ISg>
    <xmx:lXXKadLTblbSv-Fex4pBfsrXxPxT9So63_vmL2KnIrplnyqJdr6CHA>
    <xmx:lXXKaVbdYTDz4fPvfS9gQFo88KF1Sd4u1-6o9fa8WKox5Ujv6VbXXg>
    <xmx:lXXKafUJt0HRMU1rqgpBi1llTI2bdFcBaCxVkBCzSsms8_27Sru0ew>
    <xmx:lXXKaeuM3IRgfFoz2jKeT4VWyd1IAFJSUVPP1-E4pFqB_59vLKjs7YTs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 09:07:31 -0400 (EDT)
Date: Mon, 30 Mar 2026 13:07:27 +0000
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
Message-ID: <acp1YAMOCiKpcZaz@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-18-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-18-chao.gao@intel.com>

On Thu, Mar 26, 2026 at 01:44:08AM -0700, Chao Gao wrote:
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)
> +		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;

I think you need to explain what would happen if the feature is not
supported.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
