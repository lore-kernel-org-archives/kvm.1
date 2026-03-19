Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A931F91E3;
	Thu, 19 Mar 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927483; cv=none; b=k4OJcCQNLe80YVfrkhDjCp8D4jqjzHHrM/Z7hhUY4IWa4AWwORgPGaVtqJyFHaotsPYFEcGTATK2V8vq2JuVPS80VuEvMJ7onud9E0ZmKvK6w6Nii2ssjlL1a7pGEpvbxXY6MdbwiNDByqlL0FG91PD30MZTS2pCq1fmCf3Dcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927483; c=relaxed/simple;
	bh=niXaGvUnGfseG2ySGNTUty4GZqJjNLA6/rAiOV6EnMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY2He4xQwSV6CB0f2hcebpLJ9N4DyHBFVooB/Glv16DYzKWjbRyfIqOM2ccb2TKtNuF8AAc75HXRY4A7wmihJBhwrIyTphCGH/FK2H7jQ7mAf8nueZKKuI/8/PjExBrK5HYSd7BPWdU2lXR3zEfwPCjxorPMMsovMNi1xUd81PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPy/XdBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPy/XdBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2FC19424;
	Thu, 19 Mar 2026 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927482;
	bh=niXaGvUnGfseG2ySGNTUty4GZqJjNLA6/rAiOV6EnMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPy/XdBpYcbb6+vONP+KcUBzuXPfX6oiUnCzzC+OPUjFh5ZGLKlvUWqdBM15EHiiP
	 bhneIewSnUAy84US8CM3mzDHcK4sLHdZz090+N7Y1ch7sYoQALrjbhOTULHPFLkthg
	 Yl0Vfl1bbUDLInpWgX2h0CVeNtZZDHeidLmaqMRIqAPVdnd3leO7bfPUCobSf3WjGy
	 3p/0vYMYInM3L0lqteXVFSTiH3ZzASVoAjhLBhC961vYuMqiHmUhN8JGlhY9psOesT
	 PddkRBz26/rDPyVCJXPHGpQXsQ3pe2vgczqZmnWPawHh4RCP/vSSGtj+ev1yWiyGPl
	 4qWLG6I1dFcCA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 35563F40073;
	Thu, 19 Mar 2026 09:38:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 19 Mar 2026 09:38:00 -0400
X-ME-Sender: <xms:OPy7aaNR03VPDUYbFM3yAPvGffzmx2EpXdL9tHpLVXs5IevTTEa1GA>
    <xme:OPy7aZpA3oc4HnjSnZQ5tS8gImh4rOvwuGPVQZ3fzFnGl2Zenr6_peeClYK7v2EIe
    oxWPI9_TMqYuIEdElZi3M3OQJ2bqXVslNXM_NriePsWEW48iVLBJ__T>
X-ME-Received: <xmr:OPy7acVEm9DKW9nZf4pIJVWqrMIFxM7Ka0_nvti-PIZb9rW6wpVmV0A03dhwSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhsse
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:OPy7aasXUvDz6_KvvcIH-TmGRZclWjCbuXK4Hq9zgmvVdHtHijFjTg>
    <xmx:OPy7aVY_LkI2ZeyGaXMfa1j4ZqTJbn6otSecP95Ip2PB93riDNeWPA>
    <xmx:OPy7afdGJbnoPVMg-jSAKq-aq8eBDeZ_uMdu-wjJGX1ZJ3dD6tmHLA>
    <xmx:OPy7aWBFceNmBDCLbQLavUV3akPQiHU2PxnXwi3I3nVGx5sXjdELCQ>
    <xmx:OPy7aXEKV3b_T_8OHQ8CwoU1POueJzXtfSYXrgHLrVGsO6LFTLnaaEZK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:37:58 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:37:55 +0000
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
Subject: Re: [PATCH v5 15/22] x86/virt/tdx: Restore TDX module state
Message-ID: <abv7xvYd-U6p9FCY@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-16-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-16-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:35AM -0700, Chao Gao wrote:
> TDX module state was packed as handoff data during module shutdown. After
> per-CPU initialization, the new module can restore TDX module state from
> handoff data to preserve running TDs.
> 
> Once the restoration is done, the TDX module update is complete, which
> means the new module is ready to handle requests from the host and guests.
> 
> Implement the new TDH.SYS.UPDATE SEAMCALL to restore TDX module state
> and invoke it on one CPU since it only needs to be called once.
> 
> Note that Intel® Trust Domain Extensions (Intel® TDX) Module Base
> Architecture Specification, Revision 348549-007, Chapter 4.5.5 states:
> 
>   If TDH.SYS.UPDATE returns an error, then the host VMM can continue
>   with the non-update sequence (TDH.SYS.CONFIG, 15 TDH.SYS.KEY.CONFIG
>   etc.). In this case all existing TDs are lost. Alternatively, the host
>   VMM can request the P-SEAMLDR to update to another TDX module. If that
>   update is successful, existing TDs are preserved
> 
> Don't implement the two alternatives due to their complexity and unclear
> benefits.

Make it clear which option you've took.

> 
> Also note that the location and the format of handoff data is defined by
> the TDX module. The new module knows where to get handoff data and how
> to parse it. The kernel doesn't need to provide its location, format etc.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
