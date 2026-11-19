Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064396;
	b=E07jN119wGyCVD07LqsMtvcIJwXqSkn998ZycFSzdjAV2WiC+buexP/fuPBYWSZjxy+y
	 kEiHdalQ7DSKkex2m9Lzg8yFCRnfWXoz2Hrpvy0n+u2SSeV1nhyXqHc3HH2ZpnAiJUKvp
	 Yh/Z/3z2DGKquIAwJWzl44gkpY6YSS4aaYhTUhMa2DFMxv0dhQA9M4TVrlfwvY4dwxjnF
	 UL1L+Teal5TO9Q3OXcksESQ4XOnPjAsAMKhDElRyqgQHqgBg5zPS923+xqVrHek8n9f3L
	 BApKASYDv/gp28cWmST2Un1Z4yjfkpABpTLu0FDTmgR8hBZgAEBiC5Y6gw1T1rcDn0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064396;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=jMqv+WmHe6KSjsQn12JMd1CH5g0dD1KBpdiRzwl7dys=;
	b=aYlnYJ2Ojz2AYVoAnL9OSWWFkfzrlzhsLwLu9vS+ZinYTy7MlNdL4LJCRloj+9fVgq5b
	 Wygj0DAMjRu6elG1GYZeukpT+L4V/iGjxZWYfG2UZ6ZnoBmDiuAmpy5+BczdAIiJJnkjT
	 IdV6l2WeDfnLPbK6ebijUzddeCgO1BhZZ+AFFyghiBp2TVpBgMyWUeOxLRGdRg1nIXNuj
	 CkCaMOdCGy3bN8Pg5u9aq5ldr7OV/99MhTuqY5xOF7nJI3g32UL5OiN1dl5IimtfUIRn3
	 KrlyOP6N+f4wACaLfx+4QmQFsl1aemMcYtljfM6c0FwI1zHgc0XW4Ch7PQHM3TVX3Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FN+FM2Gx;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4719606A320;
	Thu, 19 Nov 2026 04:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4719606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FN+FM2Gx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795064397; x=1826600397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GOMNghIp9e507wYO2A44QEGbBR8kguUmnyOQTfQHe1I=;
  b=FN+FM2GxmQ6UokW0wO1LrqidKU9RjArGpuZLRPaJVj6SSx1TTuD0gZRt
   8RB9xwraCFe6EbmxzJ/nOTLd7I/9ia/74XtuxHg3SHDT2E6Xshpo047Kc
   9dEm4L41h5IzY9+hrlt6+kz7SwQHqX8dp79BRURrfdtIqRR/Q3GVV/Mpt
   umw7BpI7DDGSlWqWVRt5VrLNlaQSnn+s+RkkvC5jWwE/OgV5a12N73c7o
   TsD2nihsZgKuAoCCnKcFk6bSPKEgXqNlxCx3sqh9nlWatLdQRUasqlf5u
   J2K9mBQDYktdDo/stng0R7LlodIj75GL2S7QaUsm7C449qxrz46hKBSjV
   g==;
X-CSE-ConnectionGUID: biRKWzrjQLqQi2pmbK8kQQ==
X-CSE-MsgGUID: /xtSTww1Q5WSjKLdpS6+IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3799934"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3799934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 20:59:56 -0800
X-CSE-ConnectionGUID: R1Nz+1B7SHaqcqE2TAUOnQ==
X-CSE-MsgGUID: gSyXI9flQWC3SoY9qh4NDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10579170"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 20:59:50 -0800
Date: Thu, 19 Nov 2026 12:50:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <av6AJ4KAPqSco7ma@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
 <f9c89d6da82cd737bcb7d72eb6ca5f5bf121be2b.camel@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9c89d6da82cd737bcb7d72eb6ca5f5bf121be2b.camel@intel.com>

On Wed, Nov 18, 2026 at 10:18:39PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2026-11-11 at 11:48 +0800, Xu Yilun wrote:
> > TDX module extensions need memory for their execution environment to
> > serve SEAMCALL leafs. The TDX architecture implements the extensions
> > in such a way that they use the memory outside of SEAM range, so the
> > kernel should add the memory upfront at initialization time.
> > 
> > Introduce a new memory adding process backed by a new SEAMCALL leaf
> > TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
> > allocates it, adds it to the module, and never gets it back. Note that
> > the process requires Dynamic PAMT backing.
> 
> The process requires it, or the memory does?

I'll change to "the memory requires..."

> 
> >  A subsequent patch adds the
> > support. This doesn't break bisectability cause the extensions can't be
>                                             ^because?
> > enabled yet without a feature that uses them.
> 
> Not clear whether the TDX module needs a new feature or the kernel does.

How about:

    Note that the memory requires Dynamic PAMT backing, which is supported
    via a subsequent patch. This doesn't break bisectability because the
    extensions can't be enabled yet until some subsequent kernel change
    enables a feature that uses them.

[...]

> > +	page = alloc_contig_pages(ext.required_pages, GFP_KERNEL,
> > +				  numa_mem_id(), &node_online_map);
> > +	if (!page) {
> > +		ret = -ENOMEM;
> > +		goto out_free_hpa_list;
> > +	}
> > +
> > +	/* Print the amount so users know the cost. */
> > +	pr_info("%lu KB allocated for TDX module extensions\n",
> > +		ext.required_pages * PAGE_SIZE / 1024);
> 
> I wonder if this line is absolutely required for a minimal set?

Yeah I remember the concern is: we enable extensions automatically
because we think people enabling TDX have big servers and won't miss the
memory. But also we print the amount of memory that we use because we
think they will care. They are a bit at odds.

I don't have strong perference, but slightly lean to keeping the print,
so we can keep monitoring how the memory grows, and decide if it's time
to revisit the above "automatically enable whatever is supported" policy.

This print is originally required by Dave [*]. So Dave could you help on
this?

[*]: https://lore.kernel.org/all/62bec236-4716-4326-8342-1863ad8a3f24@intel.com/
