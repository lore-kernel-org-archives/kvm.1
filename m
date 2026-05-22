Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8CB40963B
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468104; cv=none; b=a+2Wczp6Vj23iHeHx6/19liKZCnQj9Hm/jzOrpUB4UPc3VafH3nwuTsj8DRaVwBGU9QeZGyHvsPZuxLZ07ZIeyM3v77z9saIb2j4f+VYMZQovs2vIJc6PejVb8hCeLSQV1bf5cgdjy6wx+pg3vDn8qo5DJDDqIRVUF5f8Uj5qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468104; c=relaxed/simple;
	bh=5Qx5R2828QQpcoZrx927YAFGHwreDjR3V1uKrQhgJDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbEk50E3Ou6QjJApDE+n/L+MWtRKFjQugEmzMlMzZ9S/w2Fu7CHbirmtMf5mKkrM7ykbc8cbVA51Ub4xD4nKymI1Cc7NEHyK4AzJ1sq+JOCBltdSHxBIpzLXDLeQZBWhlzsMOJ345/wE7Pal5J7PjyOt5DTnSOmdKARc2aJb5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX6mxe5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX6mxe5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3386A1F000E9;
	Fri, 22 May 2026 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468102;
	bh=5p8uo09cI1YbZI7k+tUsQXvuX5KExvcud7/SDZHDEjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XX6mxe5JXRiw6sZaZXru2I4bx1zHJ8F8Ylot0abm8gpas5lUaMEcQf+mrVsmvLULG
	 QbuAFVzYyA44ead9skKAbsf/Hdc5Fz8ceodtuS2ArG+JrUczAgmhg9xSGullD1ZQCK
	 aLai3imvTMlIWvJex5ZtAkW3ahNVPn5kfMjUdAQxVr04X44Zxk4VdUKJpAXAuY/nwX
	 3YgExhAUrTKEotnIO4WRLIvWbPtKT8AEjn10+o7/TzZ8zLcE6wc/7bgoeni1OKG5db
	 5Tk9mKqMmm3+Amg+VWl2AKK7GKpvGtUiS03ZLAHIFt0NWFlM7SZS2GwjXUJBqAlG2q
	 Y/TLbp8GNT4eg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 895E3F40078;
	Fri, 22 May 2026 12:41:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 12:41:41 -0400
X-ME-Sender: <xms:RYcQapHrbGJrxd1ghLSPwOJQPbUVO1Jf7r_9tuOq8lz55PDRtnxu1A>
    <xme:RYcQaqDgs0D3LKSVGtaPQnbzKAo3nkCNsSnlndeIWipQ7DT5BZYTcY4sUHm1yein2
    zcjpQNw116ZivCx2hURH5dTkS7601ewvojqzbsVBKQe_OWX4TEit9w>
X-ME-Received: <xmr:RYcQauwBIrY-0zvDsoO9s_FiexNyHsyz2XyG82jBU2NV9TFO2NiAYfEIqHIp5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvg
    drhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphgsohhn
    iihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsvggrnhhjtgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrd
    guvgdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RYcQavWnxnToUc3IOO130btJFJKKKiDZSpuMmKCYsJ1tcSQFMUn3Ow>
    <xmx:RYcQatXmfWoU52IM4iyjD7AiSe3aSDsinfeA89WVd0NwCZHTMFb08Q>
    <xmx:RYcQaiNIiWzY8eKpNfbFyBCoHqesxPqXtvbAOF51dnq1YyFjMXLJnw>
    <xmx:RYcQahjAFyNTnhzRsBTmXlEgl-dKZAGvjmjRY7hFlH6-gXnMSUFOFQ>
    <xmx:RYcQaqdor4HsVVCE8f1Nu9tsPA31WEoBAGulIbNw-QzAX35UFZOchNXL>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:41:39 -0400 (EDT)
Date: Fri, 22 May 2026 17:41:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, seanjc@google.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v2 4/4] x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due
 to no external users
Message-ID: <ahCG0AW7ygSiBIYP@thinkstation>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430015014.24261-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430015014.24261-1-yan.y.zhao@intel.com>

On Thu, Apr 30, 2026 at 09:50:14AM +0800, Yan Zhao wrote:
> Move mk_keyed_paddr() from tdx.h to tdx.c to avoid unnecessary header
> inclusion and improve encapsulation since there are no users outside of
> tdx.c.
> 
> No functional change intended.

Add a new line before SoB.

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Otherwise:

Acked-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
