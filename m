Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB61459F6;
	Thu, 19 Mar 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927138; cv=none; b=hInPi29yYRUrJMJZBW9V8Fmg8tXYd2CwQL82Ix9Rv2msoLaY5ME8ub7x92gXh2ekBjMhd2laGj4asPuVrhvCdwe5PQEaB8sw29YKufSuNT7J+oGU3izeFb1kh6718LrdVlLOmpV/GEwbKf7NGkkpi6m49Hz0/uP5iNw+9RNTLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927138; c=relaxed/simple;
	bh=hCUnHTvLQhUl9VDY/Q3LkvEctvUy4OYxO2p8fhP61O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhzJ+p++Pv/XD7pvtXlXT9M5GC8dyhczjh1uXys/naAfn1I7ZACnzwNGbIuOpQp7JvMRE3YlY2dyOL2+igmDuGCaOM89CLq6rBX4TDjrL5nF9t55FCVHKT7Knwxs78oMFy2tXiqlGqyYIPeLSbaDQtPJwlmE8WstF0P/9VYx5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAxuZEIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAxuZEIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E0C2BC9E;
	Thu, 19 Mar 2026 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927137;
	bh=hCUnHTvLQhUl9VDY/Q3LkvEctvUy4OYxO2p8fhP61O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAxuZEIvqDMm6oP03u+tf+w9oRB8eSSkAiAKVwu+Hm+T64/4I/6zQG97P4Ou2sO9o
	 0LwClsjc1BZMfN3WA4AtTNLQ6XcyV0BFJbTTUqLzXXwjeIYuKfTDXqQ7KFOL8lX1LY
	 wsl6Tf8c/Kd6qHJtOCTgoOK2gjTgZpCQC8cgv4OclbiuBpFXQUXhiKmMph2SW5zF3T
	 0yzDG0Su5WnVdtj2cVrCyoNEnybV4BXC17YfJDC51eJhO9wJ4h1lrBS5s5Z9QrYaBW
	 no1YXTmhbIOGde98CmktVBjpR7lD7cHvAa1Do+2VlxYQPukjxgm9GnnVX/VYQ8I+cp
	 AOHNoPSKAuCBQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 32819F4007C;
	Thu, 19 Mar 2026 09:32:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 09:32:15 -0400
X-ME-Sender: <xms:3_q7aWzP6PqK_hcAktPQhWs_achwXrX8yRPy3ewXYD6RyFEtm6d5Ag>
    <xme:3_q7aS9lU8SQ-VEE2fv6BKJwN7rvlMn-OMpt4IVufjit1jp9M5cSqDFCdfFQoUXot
    ik8YzHRJ3RTzb0sfVPTda_ehBa0oJzDLeeVnfFzCGQAwHhCKAdMDQ>
X-ME-Received: <xmr:3_q7aTa2tbz94c0K1MkpaFNsxQCrzgZTbD3X-sxEieF6h7sAnIW4Ny2TNGpuOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
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
X-ME-Proxy: <xmx:3_q7acjqq8uTrxXaIFEQ_uXLbssgoVTJiX1VIUyyaxhJ8P69kzy5ow>
    <xmx:3_q7aa8w1R9KFjfv4xWYQr-q09Z4x1va2fUpEEvvBYYXY3b0STEHPA>
    <xmx:3_q7adz_G8L658FdWcXCpRRPeDP-V4FQTt8bHi45eVMd6y-mlHo4uA>
    <xmx:3_q7aeG8t2fyAIGPg-64ptpTqM7E7vkpKCzCK8Y00tN2tjE0rZZhTw>
    <xmx:3_q7aV7SoSCnsKK-KfVt0UMmASVG1hsq5vNg6_yAOMffiHJqsQbQKnSG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:32:12 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:32:07 +0000
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
Subject: Re: [PATCH v5 13/22] x86/virt/seamldr: Install a new TDX module
Message-ID: <abv6fT8Rvk01DGah@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-14-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-14-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:33AM -0700, Chao Gao wrote:
> @@ -225,6 +227,7 @@ static void ack_state(void)
>  static int do_seamldr_install_module(void *seamldr_params)
>  {
>  	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
> +	struct tdx_module_args args = {};
>  	int cpu = smp_processor_id();
>  	bool primary;
>  	int ret = 0;
> @@ -243,6 +246,10 @@ static int do_seamldr_install_module(void *seamldr_params)
>  				if (primary)
>  					ret = tdx_module_shutdown();
>  				break;
> +			case MODULE_UPDATE_CPU_INSTALL:
> +				args.rcx = __pa(seamldr_params);
> +				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);

I think it should be in a helper alongside with the tdx_module_args.

> +				break;
>  			default:
>  				break;
>  			}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
