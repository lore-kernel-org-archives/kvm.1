Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C101EB9F2
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492298; cv=none; b=qEfzMn52Dr5vsnZqI0b6pOf7ArjKFr3i0yRWbhyYmDz7nNHHQnsFnKF46Y8M7hV25uZen3FLecG+6dpmiQzF+vLyQOOsWp35x5xSiOzk3o3leJTWKmmPJX3Eg3ow6v7F6oZXU+OSJcF86/IWSklWwMYtTM20Aj4YmVR3tQfMciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492298; c=relaxed/simple;
	bh=mH4d2eoSadEuiL1gTC5RFpNx3B7ySeZ+LFS6BF6ibq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZlDeTp8wwW6qgoAY1NRDY5cj/w7HHzrMjuiMzASn3rb8FU1aE/ckWRObau2Hr69JbZ+fAPMRZDDIak+XAi1siCh7mMe7t3TlrojM7nUh9sxfsaaEzX5XRyVDui/K9NB9OJSY46kX2Xy0H8bQ/7Sw0jjsPRw3t+rGPesENZyKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYYmWNPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYYmWNPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD03C4AF0B;
	Mon, 11 May 2026 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778492298;
	bh=mH4d2eoSadEuiL1gTC5RFpNx3B7ySeZ+LFS6BF6ibq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYYmWNPwwjgPVHzfsTjwP08sk2zVRlFUoqy8bXCI42ebtND3n2ue3RbO1veM4R1OC
	 aM+FYi9ZJJnnoA2GjYonwJH45dp9hqkmVNAqyqbrlFCTYCDi11U/WOd0quQEjxqgtf
	 0R8Th001rW++GdsTeDYA5DLyKqRNrvEuZ1a9oWmB+p/rKpt6CKyLyFjxtQJANHz33S
	 P5ax5rrOVIA8aYRRiKFxJveEbXqzFzeEI1s2LvSPbFnFRQ2lB6lYp9HKuxqR38pYdD
	 zwrZQbpLv+rACnIzz0oqXa+Tc7KbvX/IMLBz2AZslWWPge1JhnuiRVYBLCuRGyRW/v
	 uVNJ/3/8BSI7Q==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 398BEF4006C;
	Mon, 11 May 2026 05:38:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 05:38:17 -0400
X-ME-Sender: <xms:iaMBaggjuREIPTRBZrGV31lDKJjlVL0qsl20KHcjw-eNuGIFvNjVEg>
    <xme:iaMBaqohdjI4QNT7butRQkO08zXchmpECvMU1kEu3k-rcBN9LzI18FIx3koXAWeD2
    nzKs7VJaJn03ur-rhO7wGNGW_eJW7IT00FJyO6OT1Clzz_aqCyrRJQ>
X-ME-Received: <xmr:iaMBasL2BHqyPoWrC8pFv44cVeBVKpz4CQgLCgNiWdvngMhXoVD09Csx6NMp7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhitghkrdhprdgv
    ughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrd
    hvvghrmhgrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:iaMBansDueZpSay4vPRAQM57xAD6ArWkavWtbDtRO9qRu41ed1QVNA>
    <xmx:iaMBasuZRSMpe4qr5qu49bQvBHFURn74wSZWqXCSqeIcQYpi0hj_vw>
    <xmx:iaMBauXQQ2DVKEXP4PO90sO6eF89fKONrWIEPiiVSQXxQnToDemNZw>
    <xmx:iaMBalXA1Wt5hNxwtgAGQmZKdpGTQN8lo4vtZFQPLOjuTvp2_-sRXQ>
    <xmx:iaMBahQSzgWKnYeMA1JCGr3q4uM0DZO4f1mFBO-Mkw-xBYXFrAxy-x6o>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 05:38:15 -0400 (EDT)
Date: Mon, 11 May 2026 10:38:09 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Message-ID: <agGjX8Wl31n_xmom@thinkstation>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430020953.1405535-1-binbin.wu@linux.intel.com>

On Thu, Apr 30, 2026 at 10:09:53AM +0800, Binbin Wu wrote:
> The kernel now reads MSR_IA32_PLATFORM_ID during CPU init.  When
> running as a guest, if the underlying hypervisor does not emulate the
> MSR, the RDMSR from MSR_IA32_PLATFORM_ID can trigger an unchecked MSR
> access during early boot.  This MSR is not emulated in the case for KVM
> TDX, where the following is observed in the TD guest:
> 
>     unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
>     Call Trace:
>      <TASK>
>      ? early_init_intel+0x28/0x2c0
>      ? early_cpu_init+0x9b/0x930
>      ? setup_arch+0xbf/0xbb0
>      ? _printk+0x6b/0x90
>      ? start_kernel+0x7f/0xaa0
>      ? x86_64_start_reservations+0x24/0x30
>      ? x86_64_start_kernel+0xda/0xe0
>      ? common_startup_64+0x13e/0x141
>      </TASK>
> 
> The platform ID is used for one thing and one thing only: microcode
> updates.  Those updates are solely the domain of the bare-metal OS.  The
> guest kernel code should not even try to touch the MSR.  Skip reading
> the MSR when the kernel is running in a virtualized environment.  0 is a
> valid platform ID, however, microcode related logic is skipped in a
> virtualized environment.
> 
> Since intel_get_platform_id() could be called early before cpuinfo_x86
> is fully initialized in the case of CONFIG_MICROCODE_DBG, check whether
> the kernel is running in a virtualized environment from CPUID.  Use
> cpuid_ecx() instead of native_cpuid_ecx() so that Xen PV guest will see
> the virtualized bit.
> 
> Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
