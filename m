Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E86309EF4;
	Tue, 29 Sep 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674242; cv=none; b=vB0pZkRUswptPW6afa3+X7oe9XXkmc/VRcEZ8/ElcXVrjCHrv0u+jf5ll+UyD7R4fAbdVqX44Bu46DuslYLw/KD0OSdC5DqacFS9fhWq99Gif/tihuHs+C2POFmskrZgGGNYWu3WbSu7N396FaXBg5L44GWVtfgwXM3NEsXecBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674242; c=relaxed/simple;
	bh=W8s/m3ygooCr9S8KabVKCTkIucPyR0xcfpexRhfLgHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCSV+rASyZDPnpiykN8GsSQ2VXlEUIVu6ToNcE5qsV/l8R9A9bj5Xdb+ghtItZ+VDUCa4ZozjH9Pk03apUDUDOKwxfrzz9dS6I4z8VFnLbsiXluqOZO/OFiLwOERIk1lkp6HcrtitRY+DlIXMi93A3m4Zs77sdB4ao2KMMDtJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDb81T+V; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDb81T+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790674241; x=1822210241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W8s/m3ygooCr9S8KabVKCTkIucPyR0xcfpexRhfLgHg=;
  b=VDb81T+Vk9SeZ34Mg7WW98bhDVrx5kwH59clkG5QMspIySRYPBH4lOyU
   py7sYbY/y1ILgSTjB4BWHsLLfWd9lAUuUAJMApL1Y+bAlBE5ubD/Y+kB6
   U0+kG2Lb2hE/T1JEA1Y0GywVMj3x5uxD0FC+zNWyV8N39ltaKCTH8kbAF
   h6zRLrC4ZvVTboFMiWtTUzo6Z1u9xa4UHFrEepprT4Ma4HJo5Tt+UleJC
   /WICsKXYmJEQg9CzUmSUovzSDbSXT7JB4mcdR4Qvid9UTXdJP6kToDJi1
   gCgfW/lNFBckSuzHMwEcu4BGVlKetpl5WKtsWAKE+vxWNOWTIEZYz7PbB
   Q==;
X-CSE-ConnectionGUID: lKPmZi6IQS6k+KKqnRRKfw==
X-CSE-MsgGUID: 0mgTS3OdRgCYSh5wdpdqvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91486115"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91486115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:30:40 -0700
X-CSE-ConnectionGUID: QkzcnDOBQdGTV2lVCJIHBA==
X-CSE-MsgGUID: m8PeIb4nTfO+yAAXWhW0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="301601142"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa002.fm.intel.com with ESMTP; 29 Sep 2026 02:30:36 -0700
Date: Tue, 29 Sep 2026 17:28:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aruEyEetjbruotXB@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-4-yilun.xu@linux.intel.com>
 <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
 <13ff769fb55f37a9e7a68bdd40815775ddc4ddb1.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ff769fb55f37a9e7a68bdd40815775ddc4ddb1.camel@intel.com>

On Mon, Sep 28, 2026 at 09:06:15PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 14:14 -0700, Rick Edgecombe wrote:
> > now that we don't need to do this on update
> 
> Per an off-list discussion, we agreed to not have TDH.SYS.UPDATE do the
> TDH.EXT.INIT work internally so  that another VMM can have more flexibility. So
> we now need to go back to something like we had in v1 where it is called after
> update. But given the change in error codes for TDH.EXT.INIT, I think we still
> don't need to save the ext_required metadata field? We can just call it
> unconditionally, right?

right.

> So it should still be a bit simpler than v1.

Another thing is about the addon_features0 argument for TDH.SYS.UPDATE.
In v1 -> v2, in order to meet the goal of "just restore everything that
was configured during boot", this bitmap argument is removed. I think
this argument removal is orthogonal to the TDH.EXT.INIT discussion and
still has merit.

  TDH.SYS.UPDATE(v0): TDX module reconfigures same features as specified by
		      TDH.SYS.CONFIG, Linux would use this SEAMCALL version.

  TDH.SYS.UPDATE(v1, addon_featues0): VMM can configure new features specified
				      by addon_features0 argument. For other VMM.

Then we can just add one patch based on v2 series:

----8<----

    x86/virt/tdx: Re-initialize the extensions on runtime TDX module update

    xxxxx

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c28e65f56532..8d737b86a1d6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1309,7 +1309,7 @@ static __init int tdx_ext_mem_setup(void)
        return ret;
 }

-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
        struct tdx_module_args args = {};
        u64 ret;
@@ -1340,6 +1340,19 @@ static __init int init_tdx_module_extensions(void)
        return tdx_ext_init();
 }

+/*
+ * Don't update the memory requirement or try memory allocation in
+ * stop_machine(). If an incompatible update requires more memory, let the
+ * extensions re-initialization fail.
+ */
+static int reinit_tdx_module_extensions(void)
+{
+       if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+               return 0;
+
+       return tdx_ext_init();
+}
+
 static __init int init_tdx_module(void)
 {
        int ret;
@@ -1517,6 +1530,10 @@ int tdx_module_run_update(void)
        if (ret)
                return ret;

+       ret = reinit_tdx_module_extensions();
+       if (ret)
+               return ret;
+
        ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
        /*
         * Only fails if there is something unexpected


