Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE093B2FCA;
	Wed,  1 Apr 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032494; cv=none; b=b3b0JuV86p79qi/R0TYJ2FtRVr92Nvhic5/UH3cbxbj4BuJwwMZhGu4Wntg9d4+0+4xVIuluT66u4KJcI5xWtpMA/W4cveDpr9PTgKcKUnmCFb6RjjaFV0McXfDuD2SYMDwVSWY7cdv4nCOQNfgE89cU8k5hjItZf8NILhA20ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032494; c=relaxed/simple;
	bh=8LWqVYVupsHf2WpfKI7Tx2LrsjGmOFFgtNiUEes0yjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx+UXHayX2SuYsxbxy22lXR8pbuKuBhmyrj4fXNyIuTrgfUxMHj6c8Sv+wOarrisxEea0VxO/0hhXtSIjvGLy7qfEcEHoVR6Gez6y0i575LsyuDdWxJITKRVVMWY57rVDVFsS8UFO/ILSuuFD/0E0U3kH8gTiyB/bqcQNbqNKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnpcxEqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnpcxEqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E190C2BC9E;
	Wed,  1 Apr 2026 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775032494;
	bh=8LWqVYVupsHf2WpfKI7Tx2LrsjGmOFFgtNiUEes0yjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnpcxEqtNSrREXdRGUltJRsBgRljQFjyTyG070aV5TJ6OGoQDS4wYTBg5tYIXEUjG
	 1axkaBU7lvMrW/bdAnfYC5INBzRofBlmLiu2YKdkboikJGIGxOYX6gCAVJ+IOD3Pqt
	 MzPibK3zsvZnPlMTS7gsnucz/CNcYnwNutmXzHoGVhv3W0K118/vIYgzNqSgKfbQ8p
	 gDo+zM2ZiOB8YEMk1+tM83mlbt759oeeQHEg8ohRoTRswAwljlefN5VF9YAMmg2IyT
	 vQk+gWEH2B1r25aytzzJZKdeLQc7jxQwXGMzeXO2dCGJxz7ivKqlRCLsIxvraB5Vp5
	 5Z2ZCkSXZvl2w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id ADA3DF4006B;
	Wed,  1 Apr 2026 04:34:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 01 Apr 2026 04:34:52 -0400
X-ME-Sender: <xms:rNjMafuhn_FAUVDkXz3K70LYyVp6bUmqLflbZKgWHtFSwzPXg1f9TQ>
    <xme:rNjMaRrNBod4OHBZaHuiisaWZteqrom0D41m5p6HCdnmsLpzwvvZi19Hx0ck3QKhR
    CW9PXvQE_DRm9Tq4xbvaKzCpJYqeErhPCssJNX_0cttoNdXYy4dQBhG>
X-ME-Received: <xmr:rNjMaTOa3R6sEKH-YwyI8JxxQrZR7cBc_eloNciMIFONFq1yINqzrjT3-Uum5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrh
    hnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedviedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnh
    drkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    thhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrth
    drtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghv
    vgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgt
    phhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtph
    htthhopehtshihrhhulhhnihhkohhvrdgsohhrhihssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rNjMaXn9MxrG_QpJ4zKSGey5QZafb9MNh3t5kGzKeMi3q4ta6Ov2DA>
    <xmx:rNjMaVsKz6Pnd9UvI5j6bBhbbgD-OjoIsIyx2_fB2lK-KtmvNMGijA>
    <xmx:rNjMaekKYaYGnmeLXjn02NY-a1tgjHugyI1H1vZxI1B0kx-rFO2Wow>
    <xmx:rNjMaWlZwR5oDMJeaYdhlkgPeTFIZaBuBNWhC8O5OG75XNNxirV10w>
    <xmx:rNjMaQenaN36Yt2L1gw_L2eT8FuTzYrugYLPb6qy_t5V_6FKeHyedLzC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 04:34:52 -0400 (EDT)
Date: Wed, 1 Apr 2026 09:34:50 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
Message-ID: <aczYg5hk8yoIi05W@thinkstation>
References: <20260331112430.71425-1-kas@kernel.org>
 <20260331112430.71425-2-kas@kernel.org>
 <ee096f1e-b994-4d56-a78c-cb0e867ea047@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee096f1e-b994-4d56-a78c-cb0e867ea047@linux.intel.com>

On Tue, Mar 31, 2026 at 02:57:32PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Kirill,
> 
> On 3/31/2026 4:24 AM, Kiryl Shutsemau (Meta) wrote:
> > handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:
> > 
> >     u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> > 
> > GENMASK(h, l) includes bit h. For size=1 (INB), this produces
> > GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
> > bits). The mask is one bit too wide for all I/O sizes.
> > 
> > Fix the mask calculation.
> > 
> > Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> > Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> 
> LGTM. Can you include a link to the bug report or related discussion in 
> the commit log? It will help understand the impact of this issue.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/

It is relevant for both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
