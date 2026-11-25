Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592225;
	b=j1wY8rDo4iHmKNsfqPV4ka9ptmjXHyqG9y5n2xyvqxjCqGW5fzSEzaR/G5uH18G6wPT4
	 sTDCdcCIFqBKBDUv+sjz1LcUvlIgZMXM7WyE1X1KxKj1fY0e5ApMLz+PHhJ7NI3VTzzIO
	 xRy81bleDsYORlak3fPdwRJ4dyFOShk0ZgAC0NrFURFSHFfGZQwKxWK/CZ0PSgBeuT1lr
	 V2n5/sCaY8Fx7UwhSucvSOG2ckDwFvV+t7CnSCv+6yz8fLzs16rKNlAaJHXKPnjWpOXMb
	 34Qjfib8DIZ6Ls8UGg+/oKChhP9NKv5Xk41zRXwogXeZwYpNGOhl0iFtuKSnsxhbirw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8eRVApJ+L+4/3rfdnuY4xvhBuCOH0eKWoFliwmNzr38=;
	b=mvb/Tl+j8PQQTEaG04e1X1r2Jzut215JKF18FNlrdW1/U4kLqzU5MvbS4RsdcumDQoga
	 GbAVBCnlS0fjp3ChOeEGT3hwk+WcvRJvl6eEVdH8zzMckIj/biNdbygDzo7a5jFUsEudg
	 ZWcJxxr9cL8nRAFQianzaebA1MywK3UPj/Nv6rZp4yJBxIRpiYbWyzW4IUVN9EcLEsivR
	 ihK+yZdgmzqiPQXFLw4Cpu+CiCobODp3nO02K60EYLtugRWVrEw01306xQbEGYaITKndw
	 qE7tk9MP5aU+gp0nDsgkFFfZ/hqqWLnvMWJW/d9nDzziTHFpm7HCw9+KIE8YioS7whg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hEvwRbbZ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF3606A681;
	Wed, 25 Nov 2026 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CF3606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hEvwRbbZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795592224; x=1827128224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wY2iVTEG6wd27k6XZWlgDe4gkeLUQ9O+twmzFh+uS00=;
  b=hEvwRbbZui8SSYLvGQs7taADMZmogQkKQFWtYJ9R1+Iv2Zj2Pp4jEBI2
   U0gzQbxb4st7lArrcpG0anajB6HbquMduZtRC+6xlCk4ox8fZLK51eoq9
   9bifCqBM+qGcQHWAMDnoSiGMghCvwGnfxIEKDtnQQAxqkHeRRZDXhnjMh
   9kIg0rd7seljVzAd43BOSzMT4+IGBQ5W4KiL78j2gi5WzWWbNZdy6Ei5T
   umaIrceck9w6+J+4M4B6U8HoVyG5qj2wIOFkmy0vdhrMDDhKsqcWW9j7A
   uaH6shDGpDIJSjNbSHmTdCn37nYikTD+La9aX3WrEVObwe/UCJN2XTxJ0
   g==;
X-CSE-ConnectionGUID: Z9k8VcvZR/Gr4K65oTNOrw==
X-CSE-MsgGUID: C+FD4P4eQfyV3/airmWIVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4382073"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4382073"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 23:36:20 -0800
X-CSE-ConnectionGUID: BrYDC8I4QDKWdxCnBs+FxA==
X-CSE-MsgGUID: 0XDuAw81R3eLc/q/3+0ieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11781260"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa004.fm.intel.com with ESMTP; 24 Nov 2026 23:36:15 -0800
Date: Wed, 25 Nov 2026 15:26:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v5 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <awaNm24u6mY/BeXB@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
 <CO1PR11MB4835398A9726ACBA73621C218C442@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4835398A9726ACBA73621C218C442@CO1PR11MB4835.namprd11.prod.outlook.com>

On Tue, Nov 24, 2026 at 08:01:39AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, November 11, 2026 11:49 AM
> > 
> [...]
> >  static __init int init_tdx_module_extensions(void)
> >  {
> > +	int ret;
> > +
> >  	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> >  		return 0;
> > 
> > -	return tdx_ext_mem_setup();
> > +	ret = tdx_ext_mem_setup();
> > +	if (ret)
> > +		return ret;
> > +
> > +	return tdx_ext_init();
> >  }
> > 
> 
> Above means that tdx_ext_init() will be called even when ext.required_pages
> is 0, e.g. when TDX_KERNEL_SUPPORTED_ADDON_FEATURES0 is null as this
> series stands or on a platform which reports TDX_FEATURES0_EXT but no
> any add-on features (would it happen?). 
> 
> Just want to confirm that doing so won't hit an error.

It's fine. TDH.EXT.INIT should return success if no extensions are
required. This is discussed in v2 and v3 cover-letter states that:

  Rick pointed out that if TDH.EXT.INIT could always return a reasonable
  return code, we don't have to query ext_required metadata. A fix for the
  ABI is: TDH.EXT.INIT should return success if no extensions are
  required. We reached agreement with TDX module team and removed
  ext_required.

Oh, there is still ambiguity here, we don't ask TDX module to delete
ext_required. We removed kernel code that reads and checks ext_required.
