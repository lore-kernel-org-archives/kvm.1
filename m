Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0A286419
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665655; cv=none; b=YoxtVkP/CIHnNpv839hUBUMKzrRcMUVa8NYdyOfZej6VC27gBlEdB/GdW3dAqOLMwHeuROUU7AX0oAhhm1Kp+89xSuYi1XsWx1cYeCyz7nEG9ZMFj4oyd6lQ4UVOAmW13eMnVriu4b7cMPkKVQmvUBelyToVrr5e3aUHtfvHSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665655; c=relaxed/simple;
	bh=aEz6nDUHUvdTqHUE/gSiSeYGwSbsg8rYjmJCqbw9g54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr1bMH8Pcufw5NSVxws/+BkxGFJXVeL+vtVQZRDo8FCMNr6WOqVVvVWG31H5wP6iF+TqHtViuNo21oscf67WGc0QOOWmElc1HjNO6gdTAMTrjW/votEEpt58bAf0Cyo9fs1Gcw5hjJIFu0b5+9sFWYI+t45UosjdlXVj9yf4j1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgwE/70f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgwE/70f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCCC4AF09;
	Mon, 16 Mar 2026 12:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773665655;
	bh=aEz6nDUHUvdTqHUE/gSiSeYGwSbsg8rYjmJCqbw9g54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgwE/70fcwoPdVyHPmOezDmFGi4eyDiyUh38kiW0ymdIumFd6M2O8e8WjygTraXc5
	 MBtdFCKT3b8JmjCfHFoD4gIfMXNpcDS/PHldej9Zcxr6AB9YV55F8CEQGqa5wDZJ2q
	 pxCJ735Drdjp04TxO/mHgwppxaFGX+8LWgKmW4aNGlSd/3lSq0EiS1KCkOSFoaL1f3
	 kEVU9wAeG7IjhGaj9sV++Yl3XfoOD47Ia+3KNwvTnhEPLrv1SrvCyMGfEOZq1mDZ+i
	 nY/YUxmm/Y09GYS43z07H1APAXu9qIyfyOWeozfHpWvLfvmrrd3lkMo3BUzbsOGglL
	 h3AtpuuLYAzjw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF4E6F40080;
	Mon, 16 Mar 2026 08:54:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Mar 2026 08:54:13 -0400
X-ME-Sender: <xms:df23aTiRjXLopp2TKPHScGqiQh4JVGnmktPMr1c6z3UfAQ1_LkULCw>
    <xme:df23aeoYD9fIXQFntkD1npFhzFO8XroQ_e_QVTAoL9MVjkOxZ4xOqG-DylaKF_d3C
    H0tW1JSG7ywvJTWvH49HlgWM2czu8ErKoi6apA31ObJ5nOafY2hrDk>
X-ME-Received: <xmr:df23aStnQkpuu2mLY4yga9C-hl3rZRx2do6ERcznLS8Jh6jEjv-lLG-Mj1-7Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghordhgrghosehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfi
    husehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhl
    ihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslh
    hinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhht
    vghlrdgtohhm
X-ME-Proxy: <xmx:df23aWfwIy2IsJe7dN_mMrpOMXXDOZgeKpsXzGL3dWACffQFR60o2A>
    <xmx:df23aWB95KLQnb0kReQEySGTFHxGJhFIw8jk2u3PyLGF9nJErZBtfg>
    <xmx:df23aZm3353S2RdDJWwfZX32Em7krNa6n_SwTiC2ssVclvw8XNwStQ>
    <xmx:df23aci44RiGmUIBL8_xXVQsn-kLmdVfSCs2nGfsNA1y8LBWe4xYoA>
    <xmx:df23aR1tLY9NXvI_iNy3qfJaHX82MBFcjJYsUSvLKAZu6vRzNRGOfnG8>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 08:54:12 -0400 (EDT)
Date: Mon, 16 Mar 2026 12:54:05 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com
Subject: Re: [PATCH v5 03/22] coco/tdx-host: Expose TDX module version
Message-ID: <abf9P2Btc3MQ8IBe@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-4-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-4-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:23AM -0700, Chao Gao wrote:
> For TDX module updates, userspace needs to select compatible update
> versions based on the current module version. This design delegates
> module selection complexity to userspace because TDX module update
> policies are complex and version series are platform-specific.
> 
> For example, the 1.5.x series is for certain platform generations, while
> the 2.0.x series is intended for others. And TDX module 1.5.x may be
> updated to 1.5.y but not to 1.5.y+1.
> 
> Expose the TDX module version to userspace via sysfs to aid module
> selection. Since the TDX faux device will drive module updates, expose
> the version as its attribute.
> 
> One bonus of exposing TDX module version via sysfs is: TDX module
> version information remains available even after dmesg logs are cleared.
> 
> == Background ==
> 
> The "faux device + device attribute" approach compares to other update
> mechanisms as follows:
> 
> 1. AMD SEV leverages an existing PCI device for the PSP to expose
>    metadata. TDX uses a faux device as it doesn't have PCI device
>    in its architecture.
> 
> 2. Microcode uses per-CPU virtual devices to report microcode revisions
>    because CPUs can have different revisions. But, there is only a
>    single TDX module, so exposing the TDX module version through a global
>    TDX faux device is appropriate
> 
> 3. ARM's CCA implementation isn't in-tree yet, but will likely follow a
>    similar faux device approach, though it's unclear whether they need
>    to expose firmware version information
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
