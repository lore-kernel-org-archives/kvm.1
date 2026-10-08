Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C1382F2F;
	Thu,  8 Oct 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478250; cv=none; b=avIB3ZMTGk0kupzQtMZubdTKVtmqrtI4w8fiwBvWZsHMoG3+M4W3/5Te4FZNC+Sotlm9Jj2TXZLHX2rPykvEllDr2YGnA6MYC8N1dMh0K9YZMG4VklDmQkqaDPMozmsiV2ksmAKEmQRiFsxwbkeMgTpWy4VjU1f6KcuuiCAVk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478250; c=relaxed/simple;
	bh=8q9Lx8jEokcE9Tka4Tj1rvBm8FgOjJOE7YVCS3CPYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS5ibrX82wrv0h7qwuERIcBf15cEqIBhRoRAZsXjM+4O6zmFCwXtfmWuBKvtej6ppO+gOJy5hFzQ9Zf8Yv/vwi5xVnWHt2911atMnR0btWNoiOXl8jEyAOm9rLq9o7OqOMJuaMZ0tXCmWL4T3g2oJNldRznfFc1drpv/gYFscYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvozxI7O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvozxI7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791478247; x=1823014247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8q9Lx8jEokcE9Tka4Tj1rvBm8FgOjJOE7YVCS3CPYjQ=;
  b=OvozxI7OGk3+PukxNkPbeUESPmWGpebMZqbylzE9uIiGtnLJnmtUsPOZ
   I/h4GSCTqIXt6ZffTySt71huwjmqRCfAZVYcxOxbXonXAVXLEOjrT6mSe
   Rw+VNwS7WAQQ0SXo2eD+gIOWVnNlr9KHILcKn13RBSl1oDjrhcxkSdKze
   xzPcEHdMUsfqDNuTgMAj16kCUTl10MBTRWX7T8ed4Fvl4LWAArhGWlkND
   WYk+Zhhkk4PwKhhYzDGlAzc/ctq9SfILaIoeL5GDf3sOMX4cHpxsWaC47
   JQaTaj6gMsIGt7q2+4yi30aoggVq0cijVIUYIj9akYVdsBm2QLFZRicZm
   Q==;
X-CSE-ConnectionGUID: 6xTGidZJTPOefyoThTzGdg==
X-CSE-MsgGUID: lMRQ0TxlQqKRLDSExCTN0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="270550"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="270550"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:50:47 -0700
X-CSE-ConnectionGUID: tZsq7rC5S2CeemAL/lN9XA==
X-CSE-MsgGUID: 7sTpA15ETKWdu73E3rQ28Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="47478"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 08 Oct 2026 09:50:44 -0700
Date: Fri, 9 Oct 2026 00:47:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <asfJI+15tQivvy95@yilunxu-OptiPlex-7050>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-3-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930053901.22528-3-chao.gao@intel.com>

On Tue, Sep 29, 2026 at 10:38:36PM -0700, Chao Gao wrote:
> With the helper to read a table of metadata fields in place, the
> existing metadata readers can be standardized on it.
> 
> Convert the version metadata reader: add a table that pairs each field ID
> with the 'struct tdx_sys_info_version' member that holds its value, and
> read all version fields by walking that table.
> 
> Name the field IDs for readability, so the table entries don't carry raw
> hex literals.
>

[...]

> +#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
> +	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)
> +
> +static const struct field_mapping version_mappings[] = {
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
> +};

[...]

I think something like the following is quite clear to me:

  static const struct field_mapping version_mappings[] = {
	FIELD_MAP(0x0800000100000003ULL, struct tdx_sys_info_version, minor_version),
	...
  }

  or even:

	FIELD_MAP(0x0800000100000003ULL, version, minor_version),

It clearly tells the mapping for the class, the field, and the field_id.

So I'm not sure what's the downside of a literal hex here. To me, a
TDX_FIELD_XX MACRO only creates duplicated names in one line and
unnecessary touch points when we add a new field.


> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index db209541d3cd..10cbc2d77a5a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -52,6 +52,16 @@
>  #define TDH_PHYMEM_PAMT_REMOVE		59
>  #define TDH_SYS_DISABLE			69
>  
> +/*
> + * TDX global metadata field IDs.
> + *
> + * See "global_metadata.pdf" in Intel TDX Module ABI Definitions.
> + */
> +/* Class "TDX Module Version" */
> +#define TDX_FIELD_MINOR_VERSION			0x0800000100000003ULL
> +#define TDX_FIELD_MAJOR_VERSION			0x0800000100000004ULL
> +#define TDX_FIELD_UPDATE_VERSION		0x0800000100000005ULL

I think these are unnecessary touch points, metadata readers never use
these MACROs.
