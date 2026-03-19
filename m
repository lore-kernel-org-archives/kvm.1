Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E263D34B7;
	Thu, 19 Mar 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926385; cv=none; b=X0JGOImBHb3th6Uq6QlHpYPbt/OlFb5pLBltIUcaZCc0UPKpXnt7xf3yNxpTcDvXv7WlFNse5uNRltqMcttuSNvQGXI/v8aItVzMIzbfeBd7PS/HvZIsVID4zR+zSo6Bpv05XiWrqBoVirgnPF1vrKUt/+OhI+RutEuLzuwmjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926385; c=relaxed/simple;
	bh=DeXwLoG0KNAmGZtR/S/mi7NbXDkgxiJzLT74oODqpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhpOOXdsJ9uXDNdEC2wZ80CCCqct/xyIcTLKDbqXkgIJNLMajI+3wYTVx9Fnn7szZf7YPueaosxqCcil5CPq8HhSrb2qzdm3Z41zyjLjaZ30aEAgKoGrCsgQWMsxAyVZbcy7Sr0wg0bXlnf/tTjWAB76ctGFfM2V8whxzG89pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoG5Vs5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoG5Vs5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1940C2BC9E;
	Thu, 19 Mar 2026 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926385;
	bh=DeXwLoG0KNAmGZtR/S/mi7NbXDkgxiJzLT74oODqpY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoG5Vs5Qg4lX/ufFaA/sNT8DE93OzXyY6jxzY7Lsk7mXwgDZMKp/SmNK3EGWq5p2q
	 PqM+TOpIJXfZ04lY7sQQkk7qBSuc7uBFlbLLZI3OBsiIcBSCmHYM6rAqGeLyTtfEck
	 i0FKclWXyVs0oU/nbbWkF3kvi873SgtzZ9CgEL5I4P4aYt1LYjrRcxOM983oc7m/jz
	 8PdJi1lwRYx7jlvPNG+G7ImgXZzb0+MR7H3GmW3Z5Xr2LVK+Milr6wdWNFHVHZAB1U
	 5NsgWq0r+mT8F+5ny8YwBHhR8LBudxe8aidu1uboIke9MQy6OsOt9WggdT3/8cKzoJ
	 THLpv0g7iivTQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DD40F40070;
	Thu, 19 Mar 2026 09:19:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 09:19:42 -0400
X-ME-Sender: <xms:7ve7afr9xjDsS1hkkw2kAtP1B126XzRFiK_Y8CCVoiUzkfoHaHhvPw>
    <xme:7ve7aaXLqGALAdKeMnXC5f9ecwDyLK2RxE7oLWxlKJG2oud6WHtTJRENO420AoPi7
    yRmmDxkKuudrB5QZ35-F3tXB6H6827RjFyAhLXt3Jsu5qwBcnvtceo>
X-ME-Received: <xmr:7ve7aXRa6M9gC270lYFaWgA7zuYGeZ_6Xfmgdrt3Y8MgxTf_TrjtD4dVswfFbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7ve7aS6N86Q6WN2sy1wALfPTFK8JsHM5Oh1rMhXCsmpZVYeft-IP_w>
    <xmx:7ve7aR36RClfJujCBS7bIHDXecw2sdxFIfApRwj5TisJe08v_JNvhw>
    <xmx:7ve7abKXFUvzRiHABR3ms1SOQojmkZrYw7bNR7cAODtrmCpQfwiEGA>
    <xmx:7ve7af-mr4Ux9IbGOesS0gsUi85CQunsslhfVxkDUFgHKqfZMTKIKw>
    <xmx:7ve7aSR1L3c7NdByKo6GBUBiuEa8lxrOa46uXCEmOaoy1dbURcxxENtq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:19:40 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:19:35 +0000
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
Subject: Re: [PATCH v5 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <abv3Jxn5QPFGjq9g@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-11-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-11-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:30AM -0700, Chao Gao wrote:
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 978fcca92128..e195703398e7 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -190,6 +190,7 @@ enum module_update_state {
>  static struct {
>  	enum module_update_state state;
>  	int thread_ack;
> +	int failed;

bool is enough, right?

>  	/*
>  	 * Protect update_data. Raw spinlock as it will be acquired from
>  	 * interrupt-disabled contexts.
> @@ -237,12 +238,17 @@ static int do_seamldr_install_module(void *seamldr_params)
>  				break;
>  			}
>  
> -			ack_state();
> +			if (ret) {
> +				scoped_guard(raw_spinlock, &update_data.lock)
> +					update_data.failed++;

I don't see a reason in spin lock here. Just WRITE_ONCE() would work
fine.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
