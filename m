Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F18403EA1;
	Tue, 30 Jun 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818055; cv=none; b=j2hpbQZIBqu8RnU24OxTM74O2qXHU2Z/ikUV03IiYBPBs9JUXyKETU6Bua84KrPTbxijepPIfu2/RT0L5qQKerzTtGZS/WFdeGnXiVdVt3YWzljHl/gtSpsQhz/wMOR7WoKQu0EHdmErh/kxYjn9s/98GhQFr/GhKL+63iXXfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818055; c=relaxed/simple;
	bh=COaylY4YMXPqPiF/Z1Y4CNbAUJC1rgmCAMhMr94KsfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEkh6xv3H4ht1ww3ORs15l170yXuC90tPZdgFCHUscY2+T/ZGBv1PCcsIU9B9aEGz7jethzxGf3aVhdagguq++65h/ASYsI0Pke5abMKikS+O46EE9v4Uiah7TGmDl7z73/ScmTeExOFHJrUGvMgEgAYHxXD3g/6ar29wWznl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYcT5BzO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYcT5BzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782818054; x=1814354054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COaylY4YMXPqPiF/Z1Y4CNbAUJC1rgmCAMhMr94KsfY=;
  b=QYcT5BzO7bx+wmHebvIqP57FslCHIEgbyX5GH+KQ5AOsSciLMV/A9edP
   DcJMvx9KBdCW19LHnQFlDznC49LQ4hvTqNowEN8SgpvWRt3SVM1QlQug/
   BT5YN2we3Zhltr/P8RNd1670kv2ocjq7rukeiebz8UmCIHWYzlSLxhsH4
   IsQhp/Vv7bEF58QKPrLVQZfmtX2DiNw6ILYvoUfOBpiUnls0FO6IpWrpo
   T5nMcf2MzKCNICEWZl7z23C127MFWtqBggC8GtMuxkIJrEDA0vJYglNn1
   Mwjly9sSWBvh/WiwAIvSLv/cz3G+XAkzIp1FqSAET6aCPBJJIO5SzTv4W
   Q==;
X-CSE-ConnectionGUID: P/M4+yciRUGfyfo7U4onSw==
X-CSE-MsgGUID: iVYqW4IJTiqExvKAR7YRCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83304007"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83304007"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:14:14 -0700
X-CSE-ConnectionGUID: 4Tw0u97iQ+C7PabPgthyZQ==
X-CSE-MsgGUID: Lokz1p+XRya/11GtTpdnXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="245885562"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:14:10 -0700
Date: Tue, 30 Jun 2026 19:14:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <akOlAGE9Wz1fF8mr@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
 <akIo+E5hfQL7C30E@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akIo+E5hfQL7C30E@intel.com>

On Mon, Jun 29, 2026 at 04:12:40PM +0800, Chao Gao wrote:
> >+/*
> >+ * Mostly the same flow as init_tdx_module_extensions(), but rejects adding
> >+ * more memory.
> >+ */
> >+static int update_tdx_module_extensions(void)
> >+{
> >+	struct tdx_sys_info_ext sysinfo_ext;
> >+	int ret;
> >+
> >+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> >+		return 0;
> >+
> >+	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> >+	if (ret)
> >+		return ret;
> >+
> >+	if (!sysinfo_ext.ext_required)
> >+		return 0;
> >+
> >+	if (sysinfo_ext.memory_pool_required_pages)
> >+		return -EFAULT;
> 
> Will tdx_ext_init() return an error if more memory is needed?

Yes.

> 
> If yes, we can leave this check to the module.

Yes, we can. Although we can't remove ext_required check, we can remove
memory_pool_required_pages check, making the function simpler.
