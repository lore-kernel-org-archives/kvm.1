Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708B2DC332
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929003; cv=none; b=SKoWSGC/QcVcHVOfZxOrY0Gwj8GYLDM4PD+DYEHutYQwpQ/GYFn5IPiUq4rNTuQGId61z01RsCiNuCgFQMvOgVOdiOFZcE3TRlLNUG9B3rmUneibb8C3i4PraSPWs8ZWqEt4QWtP5bjxjun23Ns1wwG40r3pcg5jfXcdCU2Fvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929003; c=relaxed/simple;
	bh=KDp1JwUAdMfggZRYxzkjdwIabdheyk5rCMPliJPqelU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8F5rzWJhuBkk19cSbKjIB4w0LLnhc9QO1OoVvqnF51uyerl2qziH/bLhuQTj/GdGK2TlHb32jWAlef0NSd6YfHFo/gLqSXikGE3PD5gj41wFsL8RuFY6evctnMZFwix1Ap7s+yrp1Pb7s/zMQEBAuJLg56bVZFYOp7MjvnnmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbZzONGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbZzONGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0055C4AF09;
	Thu, 19 Mar 2026 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929002;
	bh=KDp1JwUAdMfggZRYxzkjdwIabdheyk5rCMPliJPqelU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbZzONGLwRieKeCAlNrRW0CXAgVRiYI9oO72/tPNengTImy3hQhdJz05uoTTcElL1
	 BuwrAuzXoWH0a8ztrnPBErVJLm2+94zH0ICDvvAyqS+7XvO+P0X+cvP0UK5Rx37NhL
	 2E3wpqHs8qzuN59hJva3VRUkIY35C7yzmabxVxgUiCCbff//HhY4L4gO4oiUqtTqth
	 ZQ8/QRWHQkynCcgIlY8KlU6ZsnjP521csBgcV1okI/CnBstEHv8GwrF1nVuQ7WmKd2
	 Rc6eTGYkcfvJa+fBRdds1mBYexJl/SApg9Gce3IMh8g16IsXmpWJ4asQ5w1a2KEqCS
	 jG6ygZTXiptFw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 696E0F40068;
	Thu, 19 Mar 2026 10:03:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 10:03:20 -0400
X-ME-Sender: <xms:KAK8aSx7yq7YvVWREnfBOadQ8ea180Qow08NePDMQ_B-vNKavgW-Tw>
    <xme:KAK8ae9gZzrscweCklcvnecr7GTGO7U6vGe5AuT7Ygn9whz4mKLpWC0C5armR8OSA
    NBLfaWZ9QI2qmyC6h99gtZKqc6yc1WfWGlCWR8ZJt71DMOirSVCVFM>
X-ME-Received: <xmr:KAK8aY3RP8DCq7aAkryvtiqgs7YmOpgekYgr9K6N-eX4XtBlJHZgGvwooJ_ceA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnheptdetfeelteefteekfefggfffteelvedulefgveduvdeljeejjedtfeegfedvkeeg
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
X-ME-Proxy: <xmx:KAK8aZBwv7dy8XBzva5d9dwNbfGen44WRXKYXcOCbq7rzr5WANyt6Q>
    <xmx:KAK8aalYqed7arPrTgjj_Vr1TBcGGB2j2liNMfME158dvbCj0CIrgg>
    <xmx:KAK8aSq6qgWWyE3mbXw4VH2wSnSCH8PcH0SclIFrU9Ncc9ur_4M9Cg>
    <xmx:KAK8aXNA833yq2VfF1TXOUZdB9pat2vA-Y6ygxKUlO4gXL4lgqkJAA>
    <xmx:KAK8aUbvBsL1YHyF70H1TA59jUnPS_1mWgy7vb22iJr1uhXeD4sgKjBo>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:03:19 -0400 (EDT)
Date: Thu, 19 Mar 2026 14:03:18 +0000
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
Subject: Re: [PATCH v5 19/22] x86/virt/tdx: Enable TDX module runtime updates
Message-ID: <abwCEXfVMYLNmAGz@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-20-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-20-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:39AM -0700, Chao Gao wrote:
> All pieces of TDX module runtime updates are in place. Enable it if it
> is supported.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
