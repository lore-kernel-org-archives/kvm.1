Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F63B7759;
	Fri, 20 Mar 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011563; cv=none; b=Lyajbxw+SVRafVfJiZsqbpGKzp6Iyv8ZhbZuFAfbnX0+5c/QZkzWoich+NfLx223nAQUrunqXfg+HiDzQul37I7FYc6Vlim3oOkLa4hwknNW42oWc+O7LOA6Gz6GuyoB9sPWInP9ePZc19CfWPUdnGqjnpdaV7153ggJ/cdGe1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011563; c=relaxed/simple;
	bh=Ifcj9jaEqVroZUOH2OHhEPTQrj/3Zia0NHS+urux5Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iij3SScEclda69u3S6w3lfqjRP49bCUlTnJ8Epmt1WXoH7cC444ZhWjPOVoIc5dQH+6RWUcLOMw8vqtBQOZcD2J3ad0L8nDmdt8p9dXFTlSZIuYF1gcKtClv+rSE0N9oyOwbZ/+S8dEvEc5n35e0YgON+W19AYyERwn8tNi2gNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj+7qA2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj+7qA2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A935EC4AF0B;
	Fri, 20 Mar 2026 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774011563;
	bh=Ifcj9jaEqVroZUOH2OHhEPTQrj/3Zia0NHS+urux5Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj+7qA2QGJntFLsyXWnxp7meuxGy7FYUYJmWPcYsJtmSTUvFtsRECTBwTFBcXrWSF
	 gc/MtKXOBWsLBGp0QuIYyv51RqaK8aVazi75z4YTqJspSArrCdYfVr7cXhjjfRjTmn
	 wtFjWUb6n7nxGcp2JkuyE3mgnqA1f4f2LDHRmZ+pSiYmw6p1wTlXxh7vhvj1VH3NaC
	 T+tkuUuhpNHmJyDJXaty8RFefgOv1x6dE7NImhVw2+iPnb+iq9ya4KlEM5o/hbCkn1
	 3mj5weNIrDBZ1HdZtS+h6+LqrlVp2AXhaPTG7TG/DP41kRbFr5xlllIP7GwTtVuO/R
	 wJH1vVlYpEUHA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id AEE65F4007D;
	Fri, 20 Mar 2026 08:59:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 08:59:21 -0400
X-ME-Sender: <xms:qUS9aSIgZj0oapzJBUmDIQlRMv8rR7uD8281n8HaZiZmOaj1sfaRZw>
    <xme:qUS9aV2ItZUUqOoWJ6gX6hSQXOGa6vsw8F-7fCcMSpPOn2Ue0-X3yyXi62Hyl9hXv
    MTpbggY9ga_6il2kgSLqaNsexFV3ZaE70IwCm4mvcQ7iNqAmVbrHP8>
X-ME-Received: <xmr:qUS9aWU7xuy4dnR3rFH2eNGCrJYEO75-HCtRAgr88tf8TlsSf9Z6AgJ8Xx1Utg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtth
    hopeihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehkvhhmsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnthgv
    lhdrtghomhdprhgtphhtthhopeigihgrohihrghordhlihesihhnthgvlhdrtghomhdprh
    gtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghinhgsihhnrdifuheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:qUS9aXrW4S1F7wUP48A0SEicaczeQ8nvYzGXjG5TIAwwswWHMpMTeQ>
    <xmx:qUS9aXYzeN8RYXriUxk_1Pe2Vb89G4zPpJX5sgZZl9qlypFDmeJqbw>
    <xmx:qUS9abCOYF6veN4teRhkIw6_YpVYmOHgMWtY89XuwWtCGpwPTQa22A>
    <xmx:qUS9aSF4H9U-cKkzSYVXbqHHYpKNJV1rzS24N8J_L-g2wjL7toaVcg>
    <xmx:qUS9aXzanLTelkp_V6BPO15TyE0pSOZJqDjaak2mBmdgdgf00QCq5vcd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:59:19 -0400 (EDT)
Date: Fri, 20 Mar 2026 12:59:14 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"sagis@google.com" <sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <ab1EcZ3G_Nc-929X@thinkstation>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <abvR2A19S4ZtpAli@thinkstation>
 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
 <abvxiuJfK2eM_1UX@thinkstation>
 <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>

On Thu, Mar 19, 2026 at 05:27:48PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2026-03-19 at 12:57 +0000, Kiryl Shutsemau wrote:
> > > Though tdh_mem_page_aug() is an API, it is currently only exported to KVM
> > > and
> > > uses type kvm_pfn_t. So, is it still acceptable to assume flush size to be
> > > PAGE_SIZE? Honoring level will soon be introduced by huge page patches.
> > 
> > It caught my eye because previously size to flush was passed down to
> > tdx_clflush_page() in the struct page (although never used there).
> > With switching to pfn, we give up this information and it has to be
> > passed separately. It would be easy to miss that in huge page patches,
> > if we don't pass down level here.
> > 
> > > 
> > > If you think it needs to be fixed before huge page series, what about fixing
> > > it
> > > in a separate cleanup patch? IMO, it would be better placed after Sean's
> > > cleanup
> > > patch [1], so we can use page_level_size() instead of inventing the wheel.
> > 
> > I am okay with a separate patch.
> 
> I feel like we argued about this before. But it would be more correct to just
> drop level and make it 4k only until huge pages? Otherwise we are tweaking dead
> behavior.

I guess. But you add one more thing on the list to remember when adding
huge page support. This kind of stuff is easy to miss.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
