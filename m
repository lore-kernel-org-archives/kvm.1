Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50936D4E1;
	Wed, 30 Sep 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737487; cv=none; b=qhmmsKjxQuZ+LRDgmUEqpzy/9qmPcb1BToSXB2nNsPibEUzM5MACrUGy1Zh4XwfmLrp7HB+4H21XIES0WIl9CLKrvfEeiuxrmiu5R4Gnw4sO9xwtNaCJt5brD7NENul16ltLx4DUPiF/HW6TSMcUhuij+2CC6oEcXj7gvFHWACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737487; c=relaxed/simple;
	bh=dwY1fMdBgTzWGxkIJqK8Q0Qy6aNCStygTwhl5UzcdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjrpicq2MWFAyNSsT2lKOqJNEbapAyjsMBvp9U0HylIEHlxpYpyzrLJQoWQHZkNU1BS771MqRraUXUfMJx/uJn4m1gY3mmZspXSMosYXdOx4zMwSxP++NOH9FlY0WBROCgNCC3nS+X9aMkHApRn0Uf2uOkcFhzijRvzykrcTRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd3hEZgs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd3hEZgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790737486; x=1822273486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dwY1fMdBgTzWGxkIJqK8Q0Qy6aNCStygTwhl5UzcdDI=;
  b=Nd3hEZgs1N6re0f29ewGSzEzcq29eD5/JBtZfXQpTLgYUp6CjJBq7EBx
   omAOpZeosWPD+G0WCg4vQY9ut9TEUHKCoe3lyy+tiQVG+tUagc7cP0pvS
   J5i4ttMfT12udvqcz8FjDCiT4Or9bd28cCbDS6fUXw1qmwritxomWOHpz
   5uFksRt8aNrwUlU/rHT90/n/mjMevcCYJ6QbewTo6XLPkAXnygXpFdf1x
   CJa+BjsxJaglBqKY+6x6ZgRR7JO85Q7/eWnIJgehNYkAM2DqPlooERkBj
   lGyKxGHsXJ7RT2YxZDET7h2zfV7KcLosQxEpw4KAQhEpwbzmady/2pRe8
   g==;
X-CSE-ConnectionGUID: iCYYvyExReCLROeojpx0ZA==
X-CSE-MsgGUID: o9fAELolQMGG1rsV91/wXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91486527"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91486527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 20:04:45 -0700
X-CSE-ConnectionGUID: JP2o2JWwQm+YNLf1JhrW6w==
X-CSE-MsgGUID: 4FfYxuLOQ9C/iY++Fgn5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275124963"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 29 Sep 2026 20:04:41 -0700
Date: Wed, 30 Sep 2026 11:02:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <arx7zz7qFiwYTF+z@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-4-yilun.xu@linux.intel.com>
 <b88401eb-ebd8-41dd-8260-af3890886ca3@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88401eb-ebd8-41dd-8260-af3890886ca3@suse.com>

On Tue, Sep 29, 2026 at 08:26:43PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.09.26 г. 13:26 ч., Xu Yilun wrote:
> > Some add-on features require TDX module extensions. The TDX module
> > provides a metadata field "ext_required" to indicate this requirement.
> > 
> > Add the first step of TDX module extensions initialization by detecting
> > if the extensions are required:
> > 
> >    1. Check if the extensions are supported via TDX_FEATURES0_EXT. If
> >       not, ext_required is not readable.
> >    2. Check if any TDX feature needs the extensions via ext_required.
> > 
> > Skip the extensions initialization when it is not required.
> > 
> > Currently all metadata fields are read at the very beginning of TDX
> > module initialization. However, ext_required is only valid after the
> > add-on feature configuration, so it cannot use the existing metadata
> > reading method.
> > 
> > Add a dedicated metadata reading interface for the extensions, call it
> > after add-on feature configuration.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> > ---
> > v1:
> >   - Include struct tdx_sys_info_ext in struct tdx_sys_info.
> > ---
> >   arch/x86/include/asm/tdx.h                  |  1 +
> >   arch/x86/include/asm/tdx_global_metadata.h  |  5 ++++
> >   arch/x86/virt/vmx/tdx/tdx.c                 | 28 +++++++++++++++++++++
> >   arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 +++++++++++
> >   4 files changed, 48 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > index 89e97d5761d8..6657f2db0330 100644
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -36,6 +36,7 @@
> >   /* Bit definitions of TDX_FEATURES0 metadata field */
> >   #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
> >   #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> > +#define TDX_FEATURES0_EXT		BIT_ULL(39)
> >   #ifndef __ASSEMBLER__
> > diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> > index 41150d546589..fe3fe91de71f 100644
> > --- a/arch/x86/include/asm/tdx_global_metadata.h
> > +++ b/arch/x86/include/asm/tdx_global_metadata.h
> > @@ -44,12 +44,17 @@ struct tdx_sys_info_handoff {
> >   	u16 module_hv;
> >   };
> > +struct tdx_sys_info_ext {
> > +	bool ext_required;
> > +};
> > +
> >   struct tdx_sys_info {
> >   	struct tdx_sys_info_version version;
> >   	struct tdx_sys_info_features features;
> >   	struct tdx_sys_info_tdmr tdmr;
> >   	struct tdx_sys_info_td_ctrl td_ctrl;
> >   	struct tdx_sys_info_td_conf td_conf;
> > +	struct tdx_sys_info_ext ext;
> >   };
> >   #endif
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 763c2d1b25d0..916a8906da10 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1181,6 +1181,30 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
> >   	return 0;
> >   }
> > +static __init int init_tdx_module_extensions(void)
> > +{
> > +	int ret;
> > +
> > +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > +		return 0;
> > +
> > +	ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * ext_required indicates if any add-on features requiring TDX module
> > +	 * extensions are configured via TDH.SYS.CONFIG. If none, skip the
> > +	 * initialization.
> > +	 */
> > +	if (!tdx_sysinfo.ext.ext_required)
> > +		return 0;
> 
> I'm slightly confused by the parlance introduced here. TDX_FEATURES0_EXT
> indicates whether this tdx module supports extensions.

> And ext_required aka
> 0x3100000000000001 is, as per td_scope_metadata.json: "Extended Features
> Available Mask:  indicates the extended user and system features which are
> available for  the TD." So aren't by definition all add-on features
> extensions.

I checked the latest json files [1]. I think there is misreading somehow.

ext_required - 0x3100000000000001 is in global_metadata.json: "Return true if
the TDH.EXT.INIT is required to be called".

And what you've read is:
XFAM - 0x1110000300000001 - td_scope_metadata.json: "Extended Features
Available Mask:  indicates the extended user and system features which are
available for the TD."

[1] https://cdrdv2.intel.com/v1/dl/getContent/795381

> How do you distinguish add-on which are extensions and those
> which aren't?

In general TDX initialization phase, the host doesn't have to tell. The
TDX module knows which features are backed by extensions then decide
whether the extensions initialization is needed according to which
features host wants to enable.

According to TDX module ABI spec, now there are 5 add-on feature bits:
TDX_CONNECT, QUOTE, MIG_SETUP which need the extensions;
NON_BLOCKING_EXPORT, TDID_VMID_REPORTING which not need.

So for example:

  TDH.SYS.CONFIG(QUOTE | TDX_CONNECT | NON_BLOCKING_EXPORT) => ext_required == 1

  TDH.SYS.CONFIG(NON_BLOCKING_EXPORT | TDID_VMID_REPORTING) => ext_required == 0

Note that tdx module updates the ext_required after TDH.SYS.CONFIG, so
it is about what is required.


BTW: we've discussed that ext_required reading is not necessary [2],
just make TDH.EXT.INIT return SUCCESS if extensions are not required.

[2] https://lore.kernel.org/all/8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com/

> I think it's best if ext_required is referred to as "ext_mask"
> or some such and not ext_required. That value is not about what is required
> but rather what is available, no ?
> 
> <snip>
> 
