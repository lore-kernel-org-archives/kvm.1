Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDD45562C;
	Fri,  9 Oct 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552523; cv=none; b=VEL9I/7MxCEfMGma2M9wqdOVUTFTzAKIu47d9ihaxLO9wUB5zmYzWvT5m8KIOWbN2h7vCbebeCixJMXW55JOP2FIGHjX83k3H18shttNlEEHeH58zD6zPnNfBp6CynICzWVhNkouameVEWvpoIgMKUkHtMZBhODzZ2A7xlK8XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552523; c=relaxed/simple;
	bh=nFagq8SAxhFeVPQ+a/Dken7XtSH6HdcAIuPGy04wX48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR7Odtg9dBKc8M4yX1XSskqaaA5f8B4BO6C/evPlIEHyQVwcmza130zkLqXJzBPSZt6iiNEhgAzWsjxZxbUSlMVsrd+X8N37wnz10up7bE4oibln3pIjOgnctdCk/gZ2/1pDhGXGiC7xVPs6eMi7A90MilvE7e8+qQ9h//icKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8UOYTJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8UOYTJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA111F000FF;
	Fri,  9 Oct 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552522;
	bh=2Awqpq3nza0mPpSxtv3YawYPpCCA42MMuB6ycshbWXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n8UOYTJhuOBnv/NoHk4ARnzxdHahhI9YMzsumKj8ob61ZauEGAc/8jAI2UxGPF83y
	 I3d2vRvPv7+UwAccUBX8+5KXxzKtUVqNnsp1bw0NLH3VL2eGFNevIETsA2NbmIdvLq
	 rIee6R1bZKNMGoxPHLtLceObA2sph1PAP80917uqsvH3G/cAY9hknW+1E0cnVNvklT
	 06JNCz5QEPQZkc+AbeyPgAyrTmx3tktmbDScpV8RTNn+AKITURO3wj8rlIEelSeGll
	 qvjJNPi07jBeBY3WJtLBuMzryGSUMeaL/EEIst/g1l/eKBMDCu2n7SrhgraPUos8Se
	 2n0sUeSndLNxg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4362F198003A;
	Fri,  9 Oct 2026 09:28:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 09:28:39 -0400
X-ME-Sender: <xms:A-zIaloAquqgaEV9DGSPMC28JlRsvPqpF5xevfO9ThnzIwjyOJAIQg>
    <xme:A-zIau5oewqj3dRFSuZXbGk5y6HTs_raF86as2_lWdyEMEqWHG6XY03m2aUOKqFl_
    e8coNWBfQ8LHjKhsXmcK7dJBRG5dT7GfSvah4btRgXWg_tKYOJAUdk>
X-ME-Received: <xmr:A-zIaqzjxGTK4iov-TyMNUIhndOG9Zc1DATHxdGQzgz79HD2HiYRQywFa3s>
X-ME-Proxy-Cause: dmFkZTEuUvj6Inoo5pi09jIgvyYC5EbCo50r5PIZpUkjioFQDK56vzDnmK4uRNTTU7rkX7
    QzUPN2k5FTEhNcRhrPNZsLKykfud2CBCliL9dR7y9ZHv1HFx1pjYnV3vbiIL5GFy0v0xSR
    7ZSijw8UrcTarWqKRR6DzmT/mjMn8xFMkJsAs+0+3OWXDKMZARkFNAzI4grtVvvS1orAjr
    PRQSSzenvfPcRvrtO9nJO6uJRoedwogCQHxGEELv3O9MrP6HxgxjbqSBzHNUmPtnjeycGe
    i539Uv7cO9MXR65ajga+gDX3k/BZ4sURi3MIPMAxAHwWNxGHm83ud6TmR4laYNu+xAvdTk
    HwSzOg1M5jNvSdwIhibJ4PPFC1H2cS48WG54vWxsdZyQQuZFKfqShEsvHf+BJmOmqBacQl
    KZd5r8sQ/gSFHVefkpL/OWpMJTa0m7kor4UVDs4Z4a5WB5aurXhb8BCkOMUUdarIInv8rL
    fJdVzsxBHO5RgbgfYf2kgMdqRDgaHGqYBjjFZTZ6Y9k8+umd170YhF2HkZayN1+dUQDdu8
    DQW2jW8p4RHFT9Ql0K5OB3S/cd/JPoAmIqbazRJAc4MqYqSEXNO5P7p4inF958COK0ac5G
    AJ5eQaVZLCiH32LAm4Vo/YTZzB9f4QHIiR/rrfIoexv28xx06+O6tXcKgWvQ
X-ME-Proxy: <xmx:A-zIauQXZbgW0UI19H_S4ArbDF28CwzN5zfWQ3QXycjevrF0VE4xPg>
    <xmx:A-zIas_ZbkZugJ2ZIM7g8v2VRsiy9woApzLhm4pjlPNh8CGo2z4zbg>
    <xmx:A-zIagHqo35ptK-aY8IREaIFJh2fePp_Odqbcy4fmwwBha2x_yxhaA>
    <xmx:A-zIavyKW9b0_98map0g0PKiK_G0wCp-rYxBPDpYrRvWwcrC2gEpeA>
    <xmx:A-zIai_MV_pJjBtydHIH_8L1iQ76JhTRIiPGlr-_P8-ezJICGu4l_bCQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 09:28:35 -0400 (EDT)
Date: Fri, 9 Oct 2026 14:28:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com, 
	adrian.hunter@intel.com, kishen.maloor@intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Message-ID: <asjrTLfebkjDzB9F@thinkstation>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <asR64ovVXEmTVgg6@tlindgre-MOBL1>
 <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>

On Thu, Oct 08, 2026 at 12:39:20PM +0800, Xu Yilun wrote:
> On Tue, Oct 06, 2026 at 07:36:50AM +0300, Tony Lindgren wrote:
> > On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> > > The TDX module uses Physical Address Metadata Table (PAMT) to track some
> > > state for each page of physical memory that it might use. 3 levels of
> > > PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> > > Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> > > dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> > > initialization. The kernel has helpers to install 4K DPAMT.
> > > 
> > > Although the memory for the extensions is tens of megabytes and the host
> > > allocates it in a large chunk, the TDX module accepts it at 4K
> > > granularity. Thus the host has to install 4K DPAMT for each page of it.
> > > 
> > > Call tdx_pamt_get() for each page before adding it to TDX module.
> > > Normally, these operations should not fail, and if they do,
> > > intentionally keep the error handling as simple as before - leak all
> > > pages, including the installed 4K DPAMT metadata.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > ---
> > > v3:
> > >  - New patch
> > > ---
> > >  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > index 5d5f9da1ab02..27a7039ee443 100644
> > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> > >  		struct page *chunk = page + added_pages;
> > >  		unsigned int i;
> > >  
> > > -		for (i = 0; i < chunk_pages; i++)
> > > +		for (i = 0; i < chunk_pages; i++) {
> > > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> > > +			if (ret) {
> > > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > > +				goto out_free_hpa_list;
> > > +			}
> > > +
> > >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > > +		}
> > >  
> > >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > >  		if (ret) {
> > > 
> > 
> > How about just fold this change in into patch 3/6?
> 
> I think patch 3/6 is already quite heavy. Is it good that I put this
> patch right after patch 3/6?

But that breaks bisectability, no? Even placed right after 3/6, that
commit fails TDX module init on a machine with DPAMT and extensions
whenever the module asks for a non-zero pool.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
