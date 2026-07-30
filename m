Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA9407CF6;
	Thu, 30 Jul 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409812; cv=none; b=GHb5nMs0Cmt3V2fCZrlscuY8zY+xNiuqZouZaq7O6P7Zup8scU1COBE2nxOevnG/WjRgJBuhPgMQqHOfJcgkic4vHLZdbv0RvcSEdhzcK2iTath+V6hDZpuEoc2v1peIG76qPnFuNATa0t49apbPVoBGz9bt2Ou/Dma/bPlLwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409812; c=relaxed/simple;
	bh=rSQfczpk7571d66YukA7pjed8IEGnSzL5OcKxI/lCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYgC3vyhkctJBc4iJsqm+MEIYbGVrwDmP7Yvtysjd0wcGuV6+b4z95shEC1ypa1M7YqKfmU5Wr25vGDXQiKgmkfYi3gUxLEHO3hijtC+GnqUrzaBHsAsidczR+Mzlbhqpn9JAvrGvg5eW/ah8Cu/BTm21IHkzXymumsWMt+tsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O00faL3J; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O00faL3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785409809; x=1816945809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSQfczpk7571d66YukA7pjed8IEGnSzL5OcKxI/lCio=;
  b=O00faL3JT/vRYTbXK/8v2PQd2Sy1gvAGDFmX/L+QnEdY1OLu2XGKPylQ
   1RmRxjmkgtGA8rgzzv+GkckOP3RCeoaG1tfh5vyDXSRJUM2f3VPTdJ0w1
   G3gmOIE/awOM4uIrp/dBvgxFaazS/zzeJmuxNCybRuernM8l8hYogL7of
   WmPbYo9wyWQmThWQf79iGlkaxoZ+4/Qxuy1q0N1xOGxE/pH8Hri62+V3S
   FvaaALu2X7UyMdS3u/0YJ14dMHt2Gx1Sw5t/Yd5YMwLg0T82kLQvDD7V2
   VGzxIUbazPmV9R1fd/yBWo4yqx6RT+WYf/FWGG1Wt30DBAPI3U7aK9r8e
   A==;
X-CSE-ConnectionGUID: dgrpoMq8SMKdU0j4Q5Jbrw==
X-CSE-MsgGUID: 5+9aoDnVRx2f6mtRsgK2iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103431773"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103431773"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:10:07 -0700
X-CSE-ConnectionGUID: Iwkg0lAlSVONkDIv8VobVQ==
X-CSE-MsgGUID: 4r2RmdWwQAm4ncITUcJKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="257596193"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2026 04:10:03 -0700
Date: Thu, 30 Jul 2026 19:10:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <amsxCvZUpNwxeDK4@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
 <akIo+E5hfQL7C30E@intel.com>
 <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>

On Mon, Jul 27, 2026 at 06:37:39PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-06-29 at 16:12 +0800, Chao Gao wrote:
> > Will tdx_ext_init() return an error if more memory is needed?
> > 
> > If yes, we can leave this check to the module. And with ext_required
> > removed (per my earlier comment), this function simplifies to:
> > 
> > int update_tdx_module_extensions(void)
> > {
> > 	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > 		return 0;
> > 
> > 	return tdx_ext_init();
> > }
> 
> Oh, it can be simplified and not share so much with the init side. Please ignore
> my other question.

It can't be simplified like that. If extensions are supported but no
extension feature is configured at boot up time. tdx_ext_init() would
fail and the runtime update failed.

I've found issue in my implementation. If extensions are required at
boot up time but somehow not required after update, the code just skip
tdx_ext_init() and the update succeed, but after that the extension
features will break.

IOW, we should not update the metadata, we should follow the boot up
time metadata to ensure no feature changes. We should store the
extension metadata in global tdx_sysinfo, and that eliminate the
duplicate code.

----8<----

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index b3442b7c88bb..43b8761c0854 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -44,17 +44,18 @@ struct tdx_sys_info_handoff {
        u16 module_hv;
 };

+struct tdx_sys_info_ext {
+       u32 memory_pool_required_pages;
+       bool ext_required;
+};
+
 struct tdx_sys_info {
        struct tdx_sys_info_version version;
        struct tdx_sys_info_features features;
        struct tdx_sys_info_tdmr tdmr;
        struct tdx_sys_info_td_ctrl td_ctrl;
        struct tdx_sys_info_td_conf td_conf;
-};
-
-struct tdx_sys_info_ext {
-       u32 memory_pool_required_pages;
-       bool ext_required;
+       struct tdx_sys_info_ext ext;
 };

 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f03141f51840..90fbd22acb5e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1304,13 +1304,13 @@ static int tdx_ext_init(void)

 static __init int init_tdx_module_extensions(void)
 {
-       struct tdx_sys_info_ext sysinfo_ext;
+       struct tdx_sys_info_ext *sysinfo_ext = &tdx_sysinfo.ext;
        int ret;

        if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
                return 0;

-       ret = get_tdx_sys_info_ext(&sysinfo_ext);
+       ret = get_tdx_sys_info_ext(sysinfo_ext);
        if (ret)
                return ret;

@@ -1319,10 +1319,10 @@ static __init int init_tdx_module_extensions(void)
         * extensions are configured via TDH.SYS.CONFIG. If none, skip the
         * initialization.
         */
-       if (!sysinfo_ext.ext_required)
+       if (!sysinfo_ext->ext_required)
                return 0;

-       ret = tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);
+       ret = tdx_ext_mem_setup(sysinfo_ext->memory_pool_required_pages);
        if (ret)
                return ret;

@@ -1330,23 +1330,14 @@ static __init int init_tdx_module_extensions(void)
 }

 /*
- * Mostly the same flow as init_tdx_module_extensions(), but won't check and
- * add more memory. Let the extensions re-initialization fail when more memory
- * is actually needed.
+ * Don't update the extensions metadata, just follow the requirement originated
+ * on TDX module initialization. Let the extensions re-initialization fail when
+ * more memory is needed, or when the ext_required is accidentally flipped after
+ * update.
  */
 static int update_tdx_module_extensions(void)
 {
-       struct tdx_sys_info_ext sysinfo_ext;
-       int ret;
-
-       if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
-               return 0;
-
-       ret = get_tdx_sys_info_ext(&sysinfo_ext);
-       if (ret)
-               return ret;
-
-       if (!sysinfo_ext.ext_required)
+       if (!tdx_sysinfo.ext.ext_required)
                return 0;

        return tdx_ext_init();

