Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04D32A3FF;
	Wed, 14 Oct 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960855; cv=none; b=OJqaXbedaMfA9kiVoRtFe9h8l1jPMt/JnR8naB5nyf/dk+NlNXRjinp2btl8yCLmDfQQJaK5pzfTfS2knWJgFmj0OYL0xcVLATkqrH+2M0prajhoODmHH4uZQoYW91DThEc7yWbHND4jPkp1GdU73etR7bQP0JNij0RlKhyPzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960855; c=relaxed/simple;
	bh=fNngd8KePR1FTyyCY6KCV4rPdszc7+Y50zawYC2sR7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDaV8zxgCOzA2S6oqbTyO0vRxn24KYnLh3RvEMBLSW7IphLHcf3fjbf/Q5dSpVsrsQ3KwJ56hVOsFbDXVRi3iReq/59zCabFCXUBmUrGo3S0AI0MWlYgrqgnubkOTK7yW06cJgqBEZzYiSRN2kKbE+UvCZj23uZJWfyRbAYc7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXe+VZ4t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXe+VZ4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791960852; x=1823496852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNngd8KePR1FTyyCY6KCV4rPdszc7+Y50zawYC2sR7g=;
  b=PXe+VZ4tQHXiHheHYjhFLxzNlERyJGtBvN1LnsnDOlqbUXnUL0u1JZvh
   /F5cDo9yIhoJ/2XFZkYYjygdXcQcOp7gVE0pItGzFPE5le8ZRrBye8ccd
   7tFwWeUPHVS8MA8PAjSkQgYEY7Ygye7d2ypNKtG2uyk7vYWns3C+1Fa6q
   YQ5Lr9mCLIUw5WUZdd3JS0TlhLKPNKHVeN5nEsE7PELgoswUBtqFoJjeA
   Dl7lnINg040ccQVz+p7FfAOwCsir6wPwjciqa/mZpcfsJkSvBpLrBnTkW
   M0V6RzH1ETkBF6BY+Gba4bbqSy8S8/NG0+Z23Ysf/y40bGP2m9swP0N1+
   A==;
X-CSE-ConnectionGUID: RzH7UW/GS0axv6TAqP/WWg==
X-CSE-MsgGUID: p4HXhXm2TjyqJbPSdEpSBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="707765"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="707765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 23:54:03 -0700
X-CSE-ConnectionGUID: N7lmUT8FQ8OHMbicy4QgZw==
X-CSE-MsgGUID: qwEYQ/XZQ9uiB+08YKL5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1428713"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 13 Oct 2026 23:53:56 -0700
Date: Wed, 14 Oct 2026 14:49:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <as8mFF14lnvnLhyO@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-3-chao.gao@intel.com>
 <f7e1e51c-e353-49ad-8ad5-9a5689f46f79@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e1e51c-e353-49ad-8ad5-9a5689f46f79@linux.intel.com>

On Tue, Oct 13, 2026 at 04:22:37PM +0800, Binbin Wu wrote:
> On 10/12/2026 5:47 PM, Chao Gao wrote:
> > With the helper to read a table of metadata fields in place, the
> > existing metadata readers can be standardized on it.
> > 
> > Convert the version metadata reader: add a table that pairs each field ID
> > with the 'struct tdx_sys_info_version' member that holds its value, and
> > read all version fields by walking that table.
> > 
> > Name the field IDs for readability, so the table entries don't carry raw
> > hex literals.
> > 
> > AI was used under supervision to review code and workshop logs.
> > 
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> One nit below.
> 
> [...]
> 
> > @@ -437,6 +437,12 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
> >  #define FIELD_MAP(_field, _type, _member)	\
> >  	__FIELD_MAP(_field, struct tdx_sys_info_##_type, _member)
> >  
> > +static const struct field_mapping version_mappings[] = {
> > +	FIELD_MAP(TDX_FIELD_MINOR_VERSION,	version, minor_version),
> > +	FIELD_MAP(TDX_FIELD_MAJOR_VERSION,	version, major_version),
> > +	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	version, update_version),
> > +};
> 
> Nit:
> I personally prefer the version provided in
> https://lore.kernel.org/kvm/ar-e8WzRS7IUKWgH@intel.com
> The full types keep the code greppable and __FIELD_MAP() could be dropped.
> 
> Also, it is a bit weird that FIELD_MAP() use _type as the name for the second
> input, but the shortened one is not really a type.

I think if we see the mapping array as a mirror of the table in
global_metadata.pdf, then this short pattern is easier to review. In
this case is it clearer we rename FIELD_MAP()'s args to use the same
terms in the SPEC? like the following:

	FIELD_MAP(_id, _class, _field)


BTW: I still think "without field id macro" makes the pattern even
clearer:

	FIELD_MAP(0x0800000100000003ULL, version, minor_version)

Direct and easier to map to global_metadata.pdf. Only leave 2 special
cases - CPUID_CONFIG_LEAVES/VALUES - but they are special enough anyway.

I'm still OK with the current patch. With or without macro is trivial.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> 
> 
