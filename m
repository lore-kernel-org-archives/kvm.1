Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48E3B42EB;
	Mon, 12 Oct 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800148; cv=none; b=utXChnyMcmBE1L914/9WIYUYjGj4HHVzsRaZipcC7nCHv+aQSvSIasUWHYTyAplUjZwJYRjquVKJq1tnC+pK/OjtAOK0h4Bfi1CaRvZ5OUd/AwRCabKAdn9GpvUM6nctqRkwej5TdEzFF4U+ez1v7pYrWMIC4fBjcPjk8avTRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800148; c=relaxed/simple;
	bh=c2+opAs7689Xtm7az6pn1Q3umq8nZMHupOBrT/9OA1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O33ic9RZn1YWxghKkGvKqXRSbQGGlvKwA4udbsNyKseT3Ouo7gPO9UXDvcnG5+gemjdYoPby+18jvMLg/SvvFb/aSay60TU9dtnR5z8U0sxAcF4lBgSZ0cJE6YsFaF696H5nOBpRNFmeoEM8ksX9eR3SjNKIFCLw3FQ+BAhu/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMAn2EW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMAn2EW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C2A1F0089B;
	Mon, 12 Oct 2026 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800138;
	bh=wXbaD+hQMnQX0eRYI2JyeZvdwCRWWe83EhQFaLQYbmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EMAn2EW7w+8NKOsXHFUr61YoUrTd+uc6qArrUsRty2myyjXVQvnPR70IMpgLwWVn4
	 +FAMLSMpe9+5kiqF5cyHXdpyq8dzlO/XjBu4g3ol/8FL2B6E2EzPgNlhGYHWFdvpTm
	 Pel0R+7UJeil2q1yKlt7r8fxllnsFrUu6enU+TTR7tMfn4BCdbupGCrbmW8Q6qp8Aa
	 dS4OARo0M4NIuxIs6XtnTEf2f+23d5YCf2zekQyPzxB5aqZKy0Nf485HFVOCAmv/ZC
	 Gf6B+dHQZPrS8B31mSjZK+zNdnTWh7h/EsSvzwTi2W5l/T1ASYAL4u0sZ2yzRRMBQT
	 BuDtFx+ZjVYZQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7F8B2198003A;
	Mon, 12 Oct 2026 06:15:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 Oct 2026 06:15:35 -0400
X-ME-Sender: <xms:Q7PMakamMHPY94WudpNYO3M0iZZB_q9VtkMW1v8enMosCFlm2EshVg>
    <xme:Q7PMarlbRqCCz9RBt4NVyAuxbSDspzotNeF28EKJwTiUPTOIcbNAIRPhPSYNdO1m6
    Ng1X03vnq794TmDver30gatuZlqd0FS_PhrWMOMVLftcuHP3KKdEIIb>
X-ME-Received: <xmr:Q7PMamGquXW72XXK-8OCYjTt0YR2dSwiA1Z_lLbsPwFsBHlpcqIS24Dk1sw>
X-ME-Proxy-Cause: dmFkZTFJUuTgkVW20IYinJ69Kh1eak227WB3MS+CRH0dVNTMUQmd305n5KufqVIrrUYxpF
    TabuSs1h6on93mgtG/nOyKmZlDFwvtLSLnfh0rl7Ja6zaGON2aEATDiKI03rPAOG506JL4
    efZKMf5w98MqQ32AZ6kmVMGYhbtMAbl7zhXLEv1JmHTYg9gAJllSHIXopuf5MKVCr1WSMV
    8dRZ7vOrd1vfTeREzff5ToxCenkqsJKuKHOT82v5bDCRxBvwWa9vAUVIYWkRr49wUJH91O
    RmVvOORx5/dqj0xH3pgHelgtL6GgiNyiN32Bym5/9jaxy7q9SaYnx97z640p3HVfC1XodZ
    XyjHygbMvr7rg5UZS5u2k3ZNrHpqvMM5kocn5zyJfBndpqDSYIM+/0l6bfUe78d3UbAH6J
    g7BHxOvXbU50HmsXUNbTFvdOWbdWDkqOlK/vY2ncvR9AcHzw+tVaw0C8Ih0mATguBF0EFp
    7FBj6J6UtXBfDwP/VhjBrKx6GTWY5/mFpc8whuers2yGcTyqHC0kc+zL4+x2DYqLWcQ2Pb
    QY9t7VQyrnQNc8sepcH5MUk3bPEu295fjA891IMwYMJbjOi93d+MHEwvXh7Qa7ELEqyky6
    uH0jJQTE80PXJmIbrH9U5ifx6EATUHp5X4UEgm1XfyHxxkCjD8Tyu/8TAzaw
X-ME-Proxy: <xmx:Q7PMaqMTGA20vq0SCuvJSpCAnZhGbC_4f8Q9O0-_6vnNWtOiKaIjcA>
    <xmx:RLPMag9unIqr3nhERYormH0Wpd7ltwem3RSD6OCusZ9ixI4ryOdMmA>
    <xmx:RLPMah4sDTkiPvFezMtWy_mm-eCt0MBJJmI-7U_YQ0Gs6jooTaDrYQ>
    <xmx:RLPMaqTv02zoxaOiIBHe7CkCbYMHDoKcQhCxq7phyIXnEKF-DWWfDA>
    <xmx:RLPMamNjIvK35lz-rVVjZCiDrJqlDXgKDTK9XAvYPr0V-8p7HLyQ5q6->
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 06:15:31 -0400 (EDT)
Date: Mon, 12 Oct 2026 11:15:29 +0100
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
Message-ID: <asyy0Y4ZWqHvgQ4u@thinkstation>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <asR64ovVXEmTVgg6@tlindgre-MOBL1>
 <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>
 <asjrTLfebkjDzB9F@thinkstation>
 <asmzGnpjrDKmFLLP@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asmzGnpjrDKmFLLP@yilunxu-OptiPlex-7050>

On Sat, Oct 10, 2026 at 11:38:02AM +0800, Xu Yilun wrote:
> On Fri, Oct 09, 2026 at 02:28:34PM +0100, Kiryl Shutsemau wrote:
> > On Thu, Oct 08, 2026 at 12:39:20PM +0800, Xu Yilun wrote:
> > > On Tue, Oct 06, 2026 at 07:36:50AM +0300, Tony Lindgren wrote:
> > > > On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> > > > > The TDX module uses Physical Address Metadata Table (PAMT) to track some
> > > > > state for each page of physical memory that it might use. 3 levels of
> > > > > PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> > > > > Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> > > > > dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> > > > > initialization. The kernel has helpers to install 4K DPAMT.
> > > > > 
> > > > > Although the memory for the extensions is tens of megabytes and the host
> > > > > allocates it in a large chunk, the TDX module accepts it at 4K
> > > > > granularity. Thus the host has to install 4K DPAMT for each page of it.
> > > > > 
> > > > > Call tdx_pamt_get() for each page before adding it to TDX module.
> > > > > Normally, these operations should not fail, and if they do,
> > > > > intentionally keep the error handling as simple as before - leak all
> > > > > pages, including the installed 4K DPAMT metadata.
> > > > > 
> > > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > > ---
> > > > > v3:
> > > > >  - New patch
> > > > > ---
> > > > >  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > > > index 5d5f9da1ab02..27a7039ee443 100644
> > > > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > > > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> > > > >  		struct page *chunk = page + added_pages;
> > > > >  		unsigned int i;
> > > > >  
> > > > > -		for (i = 0; i < chunk_pages; i++)
> > > > > +		for (i = 0; i < chunk_pages; i++) {
> > > > > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> > > > > +			if (ret) {
> > > > > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > > > > +				goto out_free_hpa_list;
> > > > > +			}
> > > > > +
> > > > >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > > > > +		}
> > > > >  
> > > > >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > > > >  		if (ret) {
> > > > > 
> > > > 
> > > > How about just fold this change in into patch 3/6?
> > > 
> > > I think patch 3/6 is already quite heavy. Is it good that I put this
> > > patch right after patch 3/6?
> > 
> > But that breaks bisectability, no? Even placed right after 3/6, that
> > commit fails TDX module init on a machine with DPAMT and extensions
> > whenever the module asks for a non-zero pool.
> 
> It will not. Any patch for extension-backed features should be applied
> after this series. So the pool will always be zero until something like:
> 
>  /* List all kernel-supported add-on features0 bits here */
> -#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0   (0)
> +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0   (TDX_FEATURES0_QUOTE)

Okay, fair enough. Feel free to use my

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

on 3/6 and 6/6.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
