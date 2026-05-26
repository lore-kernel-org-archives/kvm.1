Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6453AEF3D;
	Tue, 26 May 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811835; cv=none; b=lcjHSRkkMttMAWftwuyFWWpbElH+Eas9HaeqqDsFmDXB7H7S/Ksz6ATG07wmJ8dlcksaS+LtmnVZIKHLPHBOB+Q5OJvVScmPQ1gKrCBq7DIRpde8wNMRd/THiMFn7vuiqGz4GXMKr4q70gGOxmU4OBBjiNKSJLIH0eMK0nl5Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811835; c=relaxed/simple;
	bh=xG1/qXhfx/h5p+pX/53atrkrUXeXCwWDpc3FSQ8GLWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNrW8h11eJX8afBUK3vupPYVs+J+gW9IH+1Q5hqJGuQx/yUf2IvzthlLW8C7238LtOWrTmnAMhTovDzDn3rchNgGVV9uqquaEzuZEOYSBOSzfFnQRNe0RvP7t1AZqL6CHnqVNSLfQQ9FdjPVfnya8cTADAQptx2PnROeClnHADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3VPQUh6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3VPQUh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779811834; x=1811347834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xG1/qXhfx/h5p+pX/53atrkrUXeXCwWDpc3FSQ8GLWo=;
  b=X3VPQUh6yIIOdBj0+bqwEAH2r3nBUsPpAtj4gYP8ypyd8MnPC8wCCY06
   ATBMpKHsJ0/TxZ/ZSQ97wJUKkRpg5xnNrJUB64PfXywSD3UO9ZeNxJRfV
   Ajbq8w3FZDvKXvklNzBKxwBJa0lrlHctVChAPJ8CprEkcBR1VB8EGQafU
   sYlTrVW1rBHJu3tUo8mq6Db5/EL3+fgrbsiVevd8TO1nKMxZDwOcCNwRP
   8tG8md1KgQxeQ3tQTNFRaEspshjZUuFSc4MgwG284UZdyKCnd0htBWkKC
   Ktzyp6BA864G9YDdR2XrdIB1aHSD+jieSXt0A0UvJolpGN4bRQ/3JfQ8B
   g==;
X-CSE-ConnectionGUID: R8bh7IQ7Q4C9jzQ6O94sUQ==
X-CSE-MsgGUID: 9LKH8VPRRp2DilAhLvdxLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106088297"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="106088297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:09:48 -0700
X-CSE-ConnectionGUID: xKWflDhFQyKZw496TR6iDw==
X-CSE-MsgGUID: ttWZp8WgSRahGfW/CxtO8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="237793850"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 26 May 2026 09:09:45 -0700
Date: Tue, 26 May 2026 23:45:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, kas@kernel.org,
	djbw@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
	peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Message-ID: <ahXAL41ZmIDHmgfu@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
 <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>

On Mon, May 25, 2026 at 06:51:27PM +0800, Xiaoyao Li wrote:
> On 5/25/2026 1:17 PM, Tony Lindgren wrote:
> > On Fri, May 22, 2026 at 11:41:28AM +0800, Xu Yilun wrote:
> > > From: Peter Fang <peter.fang@intel.com>
> > > 
> > > TDX Module updates global metadata when add-on features are enabled.
> > > Host should update the cached tdx_sysinfo to reflect these changes.
> > 
> > This should be made clearer IMO. How about mention that get_tdx_sys_info()
> > needs to get called again to reload the TDX module global metadata?
> 
> Ah ha! This patch answers my comment to patch 1:
> https://lore.kernel.org/all/956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com/
> 
> sysinfo_ext->memory_pool_required_pages and sysinfo_ext->ext_required will
> be updated after extensions are enabled by TDH.SYS.CONFIG.
> 
> Patch 06 in this series already reads the tdx_sys_info_quote out of
> get_tdx_sys_info(), which mean get_tdx_sys_info() doesn't ensure all the
> global metadata will be update again.
> 
> So how about move the read of memory_pool_required_pages and ext_required
> out of get_tdx_sys_info() and put them after TDH.SYS.CONFIG, so that we
> don't need call get_tdx_sys_info() again?

Yes, I'm good to it. I hesitated to move them out in case we need some
central control on global data. But now I see there is already a
precedent:

https://lore.kernel.org/kvm/20260520133909.409394-22-chao.gao@intel.com/

Once we've agreed on moving add-on data reading out of get_tdx_sys_info(),
we don't have to read them after TDH.SYS.CONFIG, read them when really
needed. How about the following, that makes the Extension part in this
series self-contained.

----8<----

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 86e5b7ad19b3..b729c1f5ab9e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1536,6 +1536,10 @@ static __init int init_tdx_ext(void)
        if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
                return 0;

+       ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
+       if (ret)
+               return ret;
+
        /* No feature requires TDX Module Extensions. */
        if (!tdx_sysinfo.ext.ext_required)
                return 0;
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index f9cc2dd02caf..e7d9e0c4b604 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -140,8 +140,5 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
        ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
        ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);

-       if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
-               ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
-
        return ret;
 }
