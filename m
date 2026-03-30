Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749583CA481
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875132; cv=none; b=goJ9rsZ0AUb7BWo894bgnZCpmi/jyn4jkeVfb9QfbQtTVaQcpwADguyn6o/qbhj5wN0hml9IY4LuIpTLton2o16gdL9QawGulhfm6UesDtUJujm0sVtTqy2CVEj6IHAfmILWOM4Gcd4nMxzqQeq+iRzex3bnbonr9uR5weZFjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875132; c=relaxed/simple;
	bh=9JudKNmHyCn/6TcFI/SCSPRL9JonW0YzgZWeWDww0MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoxbNyDwfrJ/d1Z9E/QGJ5KHxvlgS8iEUP5hYKtaAj3NlyFs4GBYvtG6rm2tzTbpGZCoPQD8MjouZkgK7NTh1Vp6qjS9Zd9v7D9k4ugrSL/4RukTlDTJ7OMj87VFRwtIg/rmYfDWUL77vddRKVtKAY09iujI/qp/z6kHiSQzZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxxoNTEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxxoNTEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A5C2BCB0;
	Mon, 30 Mar 2026 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875132;
	bh=9JudKNmHyCn/6TcFI/SCSPRL9JonW0YzgZWeWDww0MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxxoNTEiTuSZvljd4NGDd1oYJ6CkJK+RCFXkIl9pqCz/LkK7ItQEuVXCrtaATugBT
	 bkWTVRLX9EnxU0XnohIHtEphj/JVgzSPU0PhaOIKf08WqBDcqg/shVHv09aIH4IQHA
	 NPgd6IEirlGpG4crWVmsPJmWjvNAHAQRoTkNBqt6DAU6NnU4PlRSNov/xvT34a38mD
	 i+wFTqUqZ1+SqecJnLLvpwK8iweXlgEAYNl6glQgAaFgWw3vma8ba1chhzdTMVpEV/
	 0zDN9w3XQESFzgYLU771ebUESjqZ5ZBhAA8Ty9avu9U2QmnoiNt+n8+XMJhzQ8nnnw
	 0sJVtpTi6US8A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD7BEF4006E;
	Mon, 30 Mar 2026 08:52:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 08:52:10 -0400
X-ME-Sender: <xms:-nHKacvOiLiy5ZPpc5EnHxkvZAEmOq7MVFYDL4cCSdVGZqB9thOuLA>
    <xme:-nHKaQ0vG3c8oUcCQFD-4tq5cZArOErIK6aYr3wWqAZUwlJhhTYtkjocDPDwplFje
    POvdT2Tws3U10vJhOdDBGICoP7ZKDe-dF-oTLUCtZPgtg-jJvubrWk>
X-ME-Received: <xmr:-nHKaSHexO-y1FKcWrxkE6TynR6WjnDtyTiw6cpYW3uwUaeFZ74jJGWfUnv6xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:-nHKaVN3PHj4Bt4iEStu30LqHJ25WXWpvF9NthBneH3Capn5GcK95w>
    <xmx:-nHKaQv39F0QThTV1HgL_L24EMyK2IB8Fy0MVoxb6-j3kjaExZB5lg>
    <xmx:-nHKaZsSsM58p5KrKXGsq79pKPXY2DQfSAodVnkXgKrZzgL5GQ5JcA>
    <xmx:-nHKaVa2e97hMT3MAVUdRmz9JlpjvjFpMdYUgupjAdd1m7KTnqSzow>
    <xmx:-nHKaTgY5f5K7bNFvJmhN4zBa6hOkFvvtuNabrH4PXokn70D9PmQTsUv>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:52:09 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:52:09 +0000
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
Subject: Re: [PATCH v6 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <acpx5UNVERdsvCBZ@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-11-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-11-chao.gao@intel.com>

On Thu, Mar 26, 2026 at 01:44:01AM -0700, Chao Gao wrote:
> The TDX module update process has multiple steps, each of which may
> encounter failures.
> 
> The current state machine of updates proceeds to the next step regardless
> of errors. But continuing updates when errors occur midway is pointless.
> 
> Abort the update by setting a flag to indicate that a CPU has encountered
> an error, forcing all CPUs to exit the execution loop. Note that failing
> CPUs do not acknowledge the current step. This keeps all other CPUs waiting
> in the current step (since advancing to the next step requires all CPUs to
> acknowledge the current step) until they detect the fault flag and exit the
> loop.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
