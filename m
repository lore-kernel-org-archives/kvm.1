Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483D3290D5;
	Fri,  8 May 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280730; cv=none; b=eELegzSTYQfFMeue8hA3pZUMmpMhOqOE19l1a9FT5uHVZMFT3oG0Vl9AXrK4UVYfwNiGa8kE7R40xz2jcVn+leeAFyJ0M7DnOsRlHeiRm38ASm7b8hvqGwx+zFsEUIZSKJm8eYQ21YZiGtHwKBzyftYtu6USoM2cilOs5ZnrOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280730; c=relaxed/simple;
	bh=bhmi7LG89LdMljx+DWl1+hk1ycj+/3RF95+Uws7lk/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBKRl9Sq3wSVzQTyaec7AF/F9UMyKo+11I8/cYMNz/cJD9w1GtCyIMPNkf8YeEBreLxgWs0kdhH11npnZQxUHtUELamrmXTTj+sX1YBJ6YKFhmmCvvk86t0RWre+QiJBgupwbYEZLRtEPpBtxF61i0JuyFw0aTDw39ZBMX/49uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5LQT650; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5LQT650"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8531EC2BCB4;
	Fri,  8 May 2026 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280730;
	bh=bhmi7LG89LdMljx+DWl1+hk1ycj+/3RF95+Uws7lk/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5LQT650c3/TATmfZkB+MB0khbLH77bxYjqydxLoHCkxNIXGqT48/Ru+Qtjk1fBfT
	 V2QEScr2dBBtvN71laRNUiSTt4MDDJ1G1UXKNQcVM1qCLwFb06zhiSbtV/Q1nJJL6r
	 bAFmPk31oOibpKp4QHRjHWXQb+lM8F+i98AKXPwxPwW/VGGqkBr/vRSX6CQPhsggfC
	 07zkuGn3zkEEJc6B8qj3i66op8kD0yiRXOVyRW2uamC2iFkcLeOA4E+CkXAXptNiLv
	 sH2B3mYymKYi10xmtdir+5skIUzvJnlRFQjlNuMOseloXYuuz76a9cCTtr6oIrz3mJ
	 VfSJal9PtPWOQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC78DF40088;
	Fri,  8 May 2026 18:52:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 18:52:08 -0400
X-ME-Sender: <xms:GGn-afmdbuStsZ7fzkp8V3lpVP7nsqvY0aixwGT4AyN5mL9roqHZow>
    <xme:GGn-aTkCBnauEyHxZEJTqw3M2cVnYn_oOm961V0D_QY1d9QlDAmGQc1kOyjF1u8G2
    M5mN-S5kTSj-En_Vq88P6nWW5Q_hFx76rgynp6M9JQin_2YMsN2BCg>
X-ME-Received: <xmr:GGn-aehX305_Hx15uTetnpLe_urT874hphqnU5CAyWeiZPDXmnx1uTEQHA6txQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhope
    igkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhm
    pdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehl
    ihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnth
    gvlhdrtghomh
X-ME-Proxy: <xmx:GGn-afdzkb2aopPKiN_5sneQzyq_61Qw9O0gOXpg_yBzNMw2x5n5RQ>
    <xmx:GGn-ac-MpFn-mTPZB6jOLXytSOvIWqlN3DJL7ZLP9zkXlRXdACBv0A>
    <xmx:GGn-adhdeal6iqmtCOCuXaytwCDWmr35PnzgeKcJgFRSsNTvWKIwsg>
    <xmx:GGn-aY-_8QfSdHchfSdPO66NLNzNA7AeWlRQK4OlZ_xiFQw_ivdyAg>
    <xmx:GGn-aWA_UPg78nmREEaBrrfFEPshNd-JeN9_Qsze7omac1mj3SO5accw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 18:52:07 -0400 (EDT)
Date: Fri, 8 May 2026 23:52:00 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/tdx: Port I/O emulation fixes
Message-ID: <af5orHTGMRfD5TxP@thinkstation>
References: <20260428125632.129770-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428125632.129770-1-kas@kernel.org>

On Tue, Apr 28, 2026 at 01:56:30PM +0100, Kiryl Shutsemau (Meta) wrote:
> Kiryl Shutsemau (Meta) (2):
>   x86/tdx: Fix off-by-one in port I/O handling
>   x86/tdx: Fix zero-extension for 32-bit port I/O

Dave, could get them applied?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
