Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09132863D;
	Tue, 17 Mar 2026 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741659; cv=none; b=oJSoQ0uaQOEt30VoADURc14lD5d63XG1tSSb85ow0n+5uEU9RYFYU5EqEmq8pRdiJbOnxqcsaOTO2cPW7XsZP/rsRHOBZoi59fXuO5vO8xpkABsVMfb2uIxYZY1kwmmeJ2Nat0tEp5lxweTIZSopFd5223LhRfKpxXBX4+sbOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741659; c=relaxed/simple;
	bh=wfJDeOBNqSIBVdroE1ACBaT6MMTCWr4FCBOztOPinnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avBrYHQIvud9Wxk20x+HY/mV7Egm1Nc0Ew+MpwCX8czaIlr3s7PrzhVMGSzt2oXBcsXcfTWKF/cfhrgYQTKlLDCccLAmJ53+bRlp0C4QzMGcD5/zOXYddFas2jx7xQXwsWJhr4KGnzkJ25f55/9/Z7gMABHIRWaV03xKB29oriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot4XZnNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot4XZnNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3828C4AF0B;
	Tue, 17 Mar 2026 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741658;
	bh=wfJDeOBNqSIBVdroE1ACBaT6MMTCWr4FCBOztOPinnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot4XZnNwQA2b7wxwLmpDNluPhRsdiGVTw38q+yuV9KfdPqK/Yo/yriMzqfyKFWnrC
	 KeCcXWtDFo4W5bbRu0tc50uaAvn5o4GupI/0wZlbpKUuTs9V5uDyUjjqRIwafFD7qF
	 AnReFhaYyySwxqyx+AamWZFmL1eAiXIJ/MzPT5F/8kzfvgceSO/IRMRr1zLWD5Bgic
	 Tf+BnzWhH2fzJ18L2paP62S05VwJUTSYvQN8f736P2vao48+NqHOFInf1hPN1iziVV
	 oOOdRZu4SFd056En8PMUAkCoN46PIqFSMSFD4Bw9GsR5+jOHDD6xPJcy+6hJX8qD0x
	 nL8dROsVSfAVg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D9222F40069;
	Tue, 17 Mar 2026 06:00:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 06:00:56 -0400
X-ME-Sender: <xms:WCa5aZo7fpleX6ll2NXFuGYcKIYDPVuZIr4dBIeXcAdkUCxHrrBzuw>
    <xme:WCa5aaLm2M9V2byka0ra_1_2nEUyAI-FXrURpoqYZ9fgnzb0X9ESQJlNJjm6GOdHP
    1JNhs1lm0cC45tYWvqU27Fuq6XCFBDaAWdMgi5L6w_CaHGGj87_2v_X>
X-ME-Received: <xmr:WCa5aRDmV3vTssteeQ396Ao4bz2xGfuucESQsHNl6iw6Hj7D8aOfpMjmzvZqQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WCa5abHgVVnhHX2E4Ewxx0kL1zgkIesskWgjlWmE38bcxuKFZLI34Q>
    <xmx:WCa5aUa64P36p7_kPoREEPfX928F78654En1ZOlYP6u6fProchPc7w>
    <xmx:WCa5aTHuMAPcP-A0VLe7UH8uZVc8gtDMWaY02zYm9P6q1bjehnS4Ug>
    <xmx:WCa5aaB-U1utjyTqi2PEzeVrKm9RLSlcBz0dhBhBsAbpwzOBQNtpWw>
    <xmx:WCa5acGJSR1KwtG8YCb34SeSFeFhM4G3QfjCNExXdL4ztR7YpA03gjsg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 06:00:54 -0400 (EDT)
Date: Tue, 17 Mar 2026 10:00:49 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Farrah Chen <farrah.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
Message-ID: <abkmNs188y0HHuj5@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-6-chao.gao@intel.com>
 <abgBFmEhlsdmxa1k@thinkstation>
 <abio7iAJhGdeEEcE@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abio7iAJhGdeEEcE@intel.com>

On Tue, Mar 17, 2026 at 09:05:50AM +0800, Chao Gao wrote:
> >> +
> >> +int seamldr_get_info(struct seamldr_info *seamldr_info)
> >> +{
> >> +	/*
> >> +	 * Use slow_virt_to_phys() since @seamldr_info may be allocated on
> >> +	 * the stack.
> >> +	 */
> >> +	struct tdx_module_args args = { .rcx = slow_virt_to_phys(seamldr_info) };
> >> +
> >> +	return seamldr_call(P_SEAMLDR_INFO, &args);
> >
> >On what condition this information can change?
> 
> After each update, the num_remaining_updates field will change.
> 
> >
> >I see the next patch calls this on every _show operation. Would we
> >benefit from caching the response?
> 
> Yes, caching would save a few cycles, but adds complexity. we'd need to keep
> the cache synchronized and invalidate it when values change, likely requiring
> additional state tracking.
> 
> Dave recommended allocating the structure on the stack [*] when I raised the
> caching idea.
> 
> This isn't a hot path, so I prefer keeping it "simple and stupid".

Fair enough.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
