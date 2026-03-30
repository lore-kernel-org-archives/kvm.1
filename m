Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35E3D331E
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875556; cv=none; b=iMN45b5axdDXFZxA+O+5ma4YndEGwVZcaKjtIgLfKFml1VD0ysej+86fsIH1bXVEIGm+Lyp7SYiUGcjmOPrUuu6nilRYHXP2+r1LqIe+z+P1+4ff+h3xXgMm2TmVWxZhnn6N3p5h2slIzvFTbuA48iqUa0TxHoXlYk8NqOUUvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875556; c=relaxed/simple;
	bh=RdW/sC9bhG0jc5TCnFA14YarFCI7N7uq+NhtmH6NtfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLvslix4QGh17G7LSooa7Z0VlTxwFFYMcT+S7BCOC/w+u/UwAdY71nhijLPHRStA8XcqD5TU+gkeSibo2Ai0BhTF+jh4XTUl8iONEZnkceqoMG4DbT45rm6/6D4rGFjkUZZXpD+Dt3laktWJKC2uaRJNnWaZDp1SxMccBtg2kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbrezcoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbrezcoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C0AC2BCB0;
	Mon, 30 Mar 2026 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875556;
	bh=RdW/sC9bhG0jc5TCnFA14YarFCI7N7uq+NhtmH6NtfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbrezcoV4zSijhWfcgb8PGd7E6WnQJ8FZlbZST/tBkB1JJ9sa2UYhnGhsaUbAfTjo
	 uNFnOjIJMJbVLrkEYrW9wh9Goiw3ssmAqjFygfOW8DRB1slkvohjEkHIXYZsB9L/dt
	 PIeiTYBKBkaF/YvOR7MCdCNoKttJQBNoSyfJcPETK2ZkNsBWN7MCF8gIj7tP5hVtvC
	 J+Lb7IWEdneGnFweTypD6W/uT0YM0gc2dX6E1VM7xKt4Pdgey2LRVgJsPbgj6AzXH8
	 bHSyWOoyzhzB+JesObjNmlKdfm04xywYlrNEYOsyTYotJnJgL9oy7cI9GhhfToTdwd
	 m0+GitJQ78Ugw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A9120F4006B;
	Mon, 30 Mar 2026 08:59:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 08:59:14 -0400
X-ME-Sender: <xms:onPKaYUVzjRsRU1dyrJ0juNvntuPz0FO5Lhaz_luqa6FeqZoz3bs4A>
    <xme:onPKaT9onR3bHdZf4r_DNRElSL7ztHKkTAADjxPmTdQYduxq1OtEiWpkaG9UC3oub
    YJPP4yymBNJUswhSdIhNAXwehLTYe-EnA5ibSmUKDFOxXdaFk_W2OQ>
X-ME-Received: <xmr:onPKaWsksurYJI6b7PdbOA1qnCk7QAl-a6lJnbNAej8GOeWW4kJA40VZ-damlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:onPKadXgoXRYyFAsGWRtwp7LyZPZXygaKjAvIKEq_tr3AI4DTXDPfw>
    <xmx:onPKaWWvxfHOV4lu78DUt62kjGUwBb1gajaRJi6-t9MjKRD2SbFUoA>
    <xmx:onPKae1sJ0PeIIPunEfKqDizsQMaDJzaa2xdOu7fhhAZd9ujrpQY2g>
    <xmx:onPKaUDXChAfPKCkkBN28hPch8tvOcbYSJiU42aVdxwNOGTUN3Cugg>
    <xmx:onPKadpXIPR3k1F17Zxes09M2po2vBaAw8C7m0q4IBlJi6w9jAqTLcy7>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:59:12 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:59:07 +0000
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
Subject: Re: [PATCH v6 13/22] x86/virt/seamldr: Install a new TDX module
Message-ID: <acpzg0NK6q0R2j4_@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-14-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-14-chao.gao@intel.com>

On Thu, Mar 26, 2026 at 01:44:04AM -0700, Chao Gao wrote:
> Following the shutdown of the existing TDX module, the update process
> continues with installing the new module. P-SEAMLDR provides the
> SEAMLDR.INSTALL SEAMCALL to perform this installation, which must be
> executed on all CPUs.
> 
> Implement SEAMLDR.INSTALL and execute it on every CPU.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
