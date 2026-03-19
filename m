Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D8286430;
	Thu, 19 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928812; cv=none; b=j4qdZ0glbnxIn5KjyRhmwNs4faE7y4ljHlGQu/uLFzlCxzYiBhmOH17pHkwtwxnjb4vbk3aLHGm/5WnM9Gdvo13KXMThHRVydwPF8Nvrl29DjGMm5diPe9oJegXMW6Btgd9lRJc6yUVtcTgxRm1+rcn3AkrQguX5zYda3d/51KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928812; c=relaxed/simple;
	bh=ptqasTbvLk6qAg4r3+mXURAX+L7sHXZC7KS9ks6RaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no7gnTJoQPhy0e0ZhEVqL9C4TJiEsAVlMbPj7eKPsblA80l6uZ0r3Fyawh+oKn39LPyKr2z1Na4Gohhijw54jLUKmCEq93OXXhwsjWQE4aoUxoZK8D+gt31eQ/J5TZ//JzS/V+AeQToS+jm8XdnISDRNuxkocjeI577KUHqqsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLPVcKu+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLPVcKu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D118C4AF09;
	Thu, 19 Mar 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928812;
	bh=ptqasTbvLk6qAg4r3+mXURAX+L7sHXZC7KS9ks6RaOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLPVcKu+QBzn9tsaBjk4dWBc79mzCBrA9w0zpn5X5BRE/8vTOD9Z9fyrEmpKeE8CQ
	 wPBzK9PnQY5SDcUtKUr8L9r5u7ENAkofmV3YH4esJGt4bAbLm+izHJZYPm/1pfDg8h
	 3Je9u0iGnEZwjh7fzSAJqRWYJY25uRxivXh5BkyDs1HMpYj9GW4gRaDtx8YYpsbMjm
	 /0WoufNsl6t8NieUA0HyxqqBF1QONigVsjMVEgxJ5tSOVeUShaJ8xqh0FBiBWSb8i5
	 PwYiP2S2VEVlKXw5/9qX3jSkcBLwxN+nhJwzLdJvqfjucZFUi2kxxlzNMvVC01b70e
	 z4oNIBfGDFOKA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F1E6F40076;
	Thu, 19 Mar 2026 10:00:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 10:00:10 -0400
X-ME-Sender: <xms:aQG8afSLcv9LH1-7DCsaukaeRvnKU5FhaOH4jco1oydKVbenXwwmAQ>
    <xme:aQG8aRfbui8KE1tM6hH8dVPZYBCrD1TyyCn5OcYTzWinDQsgwaGPBbHxKomBQVWMQ
    ZJ4wsvtuz7tACqTMjx-AF80SJ0EPBW5IR26YTHKngm2DEVk9o0p2mM>
X-ME-Received: <xmr:aQG8af5ZkU2Il8H_4xYgCalyuq7PGLVXwIjU18Z_RPdyr7XEDrDd_2fD92x01A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghordhgrghosehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghn
    ghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:aQG8afBWtjofsC4CntPMobFwuAuqv6tJDv8SsK7a2K0ftiI4aOAM2A>
    <xmx:aQG8abctUSmQrcbfCOLM2dWVE_G9tSlc4F-pJcIfvhtTss0b3nILTQ>
    <xmx:aQG8aUTsm2SywBI4-a-H5RAEFgsofOqJdwJma1xBoc-ywoKb9ui6Yw>
    <xmx:aQG8aSnVdKbYCVRg8yS_Fxy5rfA4m_mUY8OjrOup2_8WSRNPZcxP-g>
    <xmx:aQG8aQbZVY3Z2Trc7kVzCy1ubo9iQNJb4j37D_w7id75gxZCjAgCYSrk>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:00:06 -0400 (EDT)
Date: Thu, 19 Mar 2026 14:00:00 +0000
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
Subject: Re: [PATCH v5 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Message-ID: <abwAmw_JfpWScKGO@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-18-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-18-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:37AM -0700, Chao Gao wrote:
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index b3a7301e77c6..4c4f7acd4044 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -26,11 +26,18 @@
>  #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
>  #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
>  
> +#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
> +
>  /*
>   * TDX module SEAMCALL leaf function error codes
>   */
> -#define TDX_SUCCESS		0ULL
> -#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
> +#define TDX_SUCCESS			0ULL
> +#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
> +#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL

This competes with other patchset[1].

[1] https://lore.kernel.org/all/20260307010358.819645-1-rick.p.edgecombe@intel.com

> @@ -1189,9 +1192,21 @@ int tdx_module_shutdown(void)
>  	 * modules as new modules likely have higher handoff version.
>  	 */
>  	args.rcx = tdx_sysinfo.handoff.module_hv;
> -	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
> -	if (ret)
> -		return ret;
> +
> +	if (tdx_supports_update_compatibility(&tdx_sysinfo))
> +		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;

Hm. So what happens if the module doesn't support it? We just ignore
problem?

Maybe we should just block updates on such modules?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
