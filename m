Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D92E4263;
	Thu, 19 Mar 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929111; cv=none; b=aRLtAKSMZub697qo6yK0MJGm4JFLyqbB3QKWWCtrTMxqm0PFZERZt4hEPhWPauf7M5z4ApMmer/iVyb57AFSPgjnGuQdoq3nYm/CjdpSAYk6zVTnIF/JgtPCSZsmHLHDDCIv94+754HPwF/AVupVqmjD1Zn6uFDZKuK1xoVu3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929111; c=relaxed/simple;
	bh=aJiMS9/m/5QrbTz6/hRQ22SxhDnp5pTIBUtshUdDZrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXmywtHRpkFf1l784Lp3I+3lOGUcBnU8XIvjfMOnBTLm3kHbptAO+tgdPlhkiI6eUEHDR+rKO7yOkvHlE4XB7Zf72a4rik9vq9ohevZNdiwo/QjCCkIOmFAdzHLBWGIAPFI3pJtLWUu/p661vby3bKVvmLdfDh2M8gJB3soil8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqpDbXMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqpDbXMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F36C19424;
	Thu, 19 Mar 2026 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929111;
	bh=aJiMS9/m/5QrbTz6/hRQ22SxhDnp5pTIBUtshUdDZrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqpDbXMztJciZDFNchotr24mCOvIrk05wL7mMXMqoBjvDBCpS8lAfuUraXMNU6+hK
	 rH2HkKUd0zdV+AxVi32bnH7jxDeC6xfrwDW8gBLoZwckU/eo8Iiw7Fi4oyVICuszg0
	 dCZVM0J49g3R90FMNyvPX+VFl+ODIlQV/r81ZDXBD6w/B2T97QsmS9/bYqxRGWYO7W
	 QIaOkLXmyaubZZIETdHJRG/EseE3sy9ZCQGQtrEiZ3LP0IeoxMm9yi2SJMCs02GszB
	 hUGVbMOPSNcDlKhLKts71td38sWIWe2MILuq1ZfTLZJq41s8t7FJsI7GxdK//Q/p5x
	 uPrjNM2iAH3Yw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D938F40068;
	Thu, 19 Mar 2026 10:05:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 10:05:09 -0400
X-ME-Sender: <xms:lQK8aQZkXUp_TXGQ0eR4Vm6zZbx9OvQMVIqxebSvKXDC3CbDDBBNHQ>
    <xme:lQK8aY-Pru5NAmDvtDURIXr8UaPfJO-on5GhG9tI8u3oVaCoWB4VEr760UXoklZH4
    eip7xuczWS8KVbILDuZQ78qEn9Iq9lnl4tNCyTLgK1IgVzqvIgQHm8A>
X-ME-Received: <xmr:lQK8aT-Sg5zg5-H8d1h6Plz6E45Jis52NBo8PG57iLVLBsTAwYTMvT3GHrn_gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtg
    hotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhht
    vghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:lQK8aVi7oNG0ivIh_CFyNXMlbxeIroecDPOuUVB8zqSWZ9OG4Fjpxw>
    <xmx:lQK8aWHn9bC_mcTV-Dc9idgYSBPE8pHm8A6uGB6CTIsR7HHalCN2Xg>
    <xmx:lQK8aeewnd82MewGJRJyHwDi3LiH6P7KW16MVGO7UoOdAkKmkij2YA>
    <xmx:lQK8aSeznw1fMX0NLlsQ4pY2s4xlF_hfmcX_49F-6ym9ATIvNhHI2A>
    <xmx:lQK8aY30KdvbPkkPLB1kBvnrZzg8AJawPCj8r1pn7OO0TsOl7cX_iQ6G>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:05:08 -0400 (EDT)
Date: Thu, 19 Mar 2026 14:05:06 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, binbin.wu@linux.intel.com, 
	dan.j.williams@intel.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	kai.huang@intel.com, nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com, 
	reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 21/22] x86/virt/tdx: Document TDX module update
Message-ID: <abwChGQHe7BUur7a@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-22-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-22-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:41AM -0700, Chao Gao wrote:
> Document TDX module update as a subsection of "TDX Host Kernel Support" to
> provide background information and cover key points that developers and
> users may need to know, for example:
> 
>  - update is done in stop_machine() context
>  - update instructions and results
>  - update policy and tooling
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
