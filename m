Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CA3D3306
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874468; cv=none; b=NAu+xKlv1TIPYAT/bszAeFl+ZBWEOwE0ZYus91+hDyoXerH5zVOqGdNvDG2YU7R7nvopNhIwk1D4tdQqvdjgEG9LoJyShxRf0HSD68xDyCIUj3xZNx88y4U37CgXWoAb8yfG0/vUQ8fzVExBTai+53qNAPf23vwEAsQklOvERsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874468; c=relaxed/simple;
	bh=lD711G7tK6+3VEwXAQ4wli+CHdlzJ0/AiDHveLlpVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIFnL3kWSJ9mkd2M0ZfovG8KnVxhZQ45cJCSgeeMRqa0YXqmxIhx9b0mGPAwqynu7iAKtKUw+zAkV4BG2xD+3OJmxrvyEHjXyNCBSgRKrbN5up31ZUrlh54Vbf4xI73hptdEXL97shqF3yWQoO1QBvqPXwAzfo+QTgnAxVmO7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B43ufd9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B43ufd9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC739C4AF0B;
	Mon, 30 Mar 2026 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874468;
	bh=lD711G7tK6+3VEwXAQ4wli+CHdlzJ0/AiDHveLlpVJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B43ufd9eQbE3yKUNUcGndeUCfrGDV7N2/cuyQsGpVw18gZJgjpzk61aBjRWgAWAR6
	 AvE3qvkig1bBSF8XclXchS3/gylvCZLrcRDu2mH+7xYj51zapOiSM8BEwt76YzZ7oj
	 2TGL9whtkUcgCuHRPubhBxJlJeOYTLDDqxMwu2Hs/Cv6p9gE1TXcr9EdX/WOiObf6a
	 /6ehw3epg4PKGFMXepRI0jquA/KMnzlEnP+BOS+Flql7nXUV2SUVuo09E8rOfiREsJ
	 i9pHpuCJQ8Zku0EgvY9IEpfrTp5AMj8ndIUfvBrxSAQvirzAf0ZCs5ASFcVj/FbE2T
	 Z8mGBEwQtl/ZA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id D7DE9F4007C;
	Mon, 30 Mar 2026 08:41:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Mar 2026 08:41:06 -0400
X-ME-Sender: <xms:Ym_KadFYrSHmIb9s-CwF2ZmdthX0XlC-kBDIpBsMO1u0ucqYwTRxnw>
    <xme:Ym_KaZtXM4HmRR74SrVzz02BwOQ5Je-vAqX9wTSYtQEvXe0qzhKeFarSvZfRRc1Pm
    NhBeILmVra2gfTzyPA0wy0ewpwnBOElaY40xfREG8IYdSx-YUEvK0U>
X-ME-Received: <xmr:Ym_KaZe2ZXcbbDiyzntrpgtRE_Z27JuclSBdP0kt58sFPckk1MLYIp4qpasbDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdduucetufdoteggodetrf
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
    gtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Ym_KaZGl-poi5xx4GlssKdxhYC6wqcKzL0x-nyWYnFVUVtjiwEv_2A>
    <xmx:Ym_KaXFbomtiNRZIYj-a0oO0TJsFKo1EpA-k2j4eZtSs3BNHzKYzmA>
    <xmx:Ym_KaQl2v2tYwh8DWjSbANZ9bM_quDW38eJTLrXBVmw3GeYXJwuGlQ>
    <xmx:Ym_KaSzgxZ4eztuVa-vF_CsafFMedgrbZIDrta3YruYaKumaegnnWA>
    <xmx:Ym_KaVYsV6VVC2cnJvrWVuEjPb5jsngEteKwGdPTGYUuTSlttcZhBL7q>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:41:06 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:41:05 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <acpu3WNnIG7H5jyf@thinkstation>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-7-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-7-chao.gao@intel.com>

On Thu, Mar 26, 2026 at 01:43:57AM -0700, Chao Gao wrote:
> TDX module updates require userspace to select the appropriate module
> to load. Expose necessary information to facilitate this decision. Two
> values are needed:
> 
> - P-SEAMLDR version: for compatibility checks between TDX module and
> 		     P-SEAMLDR
> - num_remaining_updates: indicates how many updates can be performed
> 
> Expose them as tdx-host device attributes. Make seamldr attributes
> visible only when the update feature is supported, as that's their sole
> purpose. Unconditional exposure is also problematic because reading them
> triggers P-SEAMLDR calls that break KVM on CPUs with a specific erratum
> (to be enumerated and handled in a later patch).
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

One nit is below.

> @@ -46,7 +47,80 @@ static struct attribute *tdx_host_attrs[] = {
>  	&dev_attr_version.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(tdx_host);
> +
> +static const struct attribute_group tdx_host_group = {
> +	.attrs = tdx_host_attrs,
> +};
> +
> +static ssize_t seamldr_version_show(struct device *dev, struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct seamldr_info info;
> +	int ret;
> +
> +	ret = seamldr_get_info(&info);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, TDX_VERSION_FMT"\n", info.major_version,

Space after _FMT, please.

> +						    info.minor_version,
> +						    info.update_version);
> +}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
