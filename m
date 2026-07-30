Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A334534A9;
	Thu, 30 Jul 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427273; cv=none; b=jsyxhUds91DFZnAQpSooswzaOTILh5HMjuIkw1LOdaebsAod37gs9zjxPEJTbIy8p1XZDbqizsvOv5xhDArYO0pSnOBVh68MFbxRlbpndGjpRDRQC1sMYKM9Ag90FJlR4PrgKxXaevEitmR3bKIi3M3GgqBUH0BeBR6h3SpjlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427273; c=relaxed/simple;
	bh=/2Vl+Sgp38kta3rBF4lWXFSlPYjg0XJ6Fq04dcb5cpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boWOar6TAItja4lOeljook45+rUoeMrn16YntYHlUv3160SmXov3e8UczcfXR8Ds9g7pdI67pZiinoHTx0CDyztYNKdpnTF58RkvN45r6+5JhX1FQ3vM8ArubrgF4abaB5M4QgkcI4jrx6XriBMua1ayKW3KO0aEIVNz3uXQdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0gnQnPy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0gnQnPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785427270; x=1816963270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2Vl+Sgp38kta3rBF4lWXFSlPYjg0XJ6Fq04dcb5cpk=;
  b=V0gnQnPyZtCVQkIwU7dTs+J41Lr2bYLtSh9Lmg0MFiDkRVQutfr9uAeo
   US9wMz7mR+Ru/iy7bj7I/Mb3KlOhW4WaueCPCzcEpNW46fupvVdLbv+E1
   rc2wMTvGLr6Uqgky0rwicBiMlsACwmA5Paa89b88+kuhgGrENh+/Vmdg3
   nVBuqxO9q9knBirj89mPsXXFE1McEGdN6UCNgDP6EI8w7MbXcf12oh2CF
   jSWmftWhdhJxKZDCZTu/psnXIdY4w2Q85E9Gn/PYnp6r6fNMdHhdyJbJn
   /GVnRkSMsxSj1gYEJ8n47YLmzo2AXO38vV1yUIMtZfXKDPrjBTkH877ug
   g==;
X-CSE-ConnectionGUID: cxOALVA7TeuMMAm5Do/RsA==
X-CSE-MsgGUID: +oEUTyJYT22RgMjei915QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="73586580"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="73586580"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 09:01:09 -0700
X-CSE-ConnectionGUID: beyw7IASSRm87YNZuLfT6A==
X-CSE-MsgGUID: 7mrB/l1zTROozyVWvEDxIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="256994286"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jul 2026 09:01:05 -0700
Date: Fri, 31 Jul 2026 00:01:04 +0800
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
Message-ID: <amt1QNCBQas95XYB@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
 <akIo+E5hfQL7C30E@intel.com>
 <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>
 <amsxCvZUpNwxeDK4@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amsxCvZUpNwxeDK4@yilunxu-OptiPlex-7050>

On Thu, Jul 30, 2026 at 07:10:02PM +0800, Xu Yilun wrote:
> On Mon, Jul 27, 2026 at 06:37:39PM +0000, Edgecombe, Rick P wrote:
> > On Mon, 2026-06-29 at 16:12 +0800, Chao Gao wrote:
> > > Will tdx_ext_init() return an error if more memory is needed?
> > > 
> > > If yes, we can leave this check to the module. And with ext_required
> > > removed (per my earlier comment), this function simplifies to:
> > > 
> > > int update_tdx_module_extensions(void)
> > > {
> > > 	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > > 		return 0;
> > > 
> > > 	return tdx_ext_init();
> > > }
> > 
> > Oh, it can be simplified and not share so much with the init side. Please ignore
> > my other question.
> 
> It can't be simplified like that. If extensions are supported but no
> extension feature is configured at boot up time. tdx_ext_init() would
> fail and the runtime update failed.
> 
> I've found issue in my implementation. If extensions are required at
> boot up time but somehow not required after update, the code just skip
> tdx_ext_init() and the update succeed, but after that the extension
> features will break.
> 
> IOW, we should not update the metadata, we should follow the boot up
> time metadata to ensure no feature changes.

Sorry, I changed my mind. I remember TDX module architector said "the
host should not assume any feature/SEAMCALL must be associated with any
extension, it is hidden from the host. Today a SEAMCALL is backed by an
extension, tomorrow it may not".

So in this case, ext_required may flip across updates and we should
honor the runtime metadata.

I made another effort to combine common routines for ext init and
update, but don't like how it turns out. If no one wants it that much,
I'd rather stay unchanged:

----8<----

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cec266f76dc0..448d0ab76d05 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1302,15 +1302,22 @@ static int tdx_ext_init(void)
        return 0;
 }

+static int get_tdx_sys_info_extensions(struct tdx_sys_info_ext *sysinfo_ext)
+{
+       if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT)) {
+               memset(sysinfo_ext, 0, sizeof(*sysinfo_ext));
+               return 0;
+       }
+
+       return get_tdx_sys_info_ext(sysinfo_ext);
+}
+
 static __init int init_tdx_module_extensions(void)
 {
        struct tdx_sys_info_ext sysinfo_ext;
        int ret;

-       if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
-               return 0;
-
-       ret = get_tdx_sys_info_ext(&sysinfo_ext);
+       ret = get_tdx_sys_info_extensions(&sysinfo_ext);
        if (ret)
                return ret;

@@ -1339,10 +1346,7 @@ static int update_tdx_module_extensions(void)
        struct tdx_sys_info_ext sysinfo_ext;
        int ret;

-       if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
-               return 0;
-
-       ret = get_tdx_sys_info_ext(&sysinfo_ext);
+       ret = get_tdx_sys_info_extensions(&sysinfo_ext);
        if (ret)
                return ret;

