Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388F30C143;
	Fri, 15 May 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869471; cv=none; b=XosC9usINQsGGsQ9SI0YTDJDSIPqoxzks0NaT8/aQlLAivsde0y9rZwUGDuL4cTYaC+9CULtgfQ1zJz0fNDN9U6txOMC3stSCHMXC2d2HzCGrCEqbhfezWPvzlZBk1LxWDHxWX0CBpx0upqDUCOBM1PnriNO5V9ccimoWBY75L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869471; c=relaxed/simple;
	bh=prQUBjYy/BhAWzN3VOtKmppkEn375RB3hvwEao2A92g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/U+PalG+YgIZCg4ZgjXlOYm68XbFXvOBpk6KlF2G5VcNgapgxnvLhOtvKBZ/78V64GrED05n03YQhIOvbG1vh50391wXb6PIYyVW6Hc9pq3sDZ4W9WGX5OZo5JIRT3fe8cSVadqy7bLNdyQ29k9YCW9c/s0OP7agHTwW6IW8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkJHAu0m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkJHAu0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869470; x=1810405470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=prQUBjYy/BhAWzN3VOtKmppkEn375RB3hvwEao2A92g=;
  b=mkJHAu0mrAqW0DxchhU9534JZPeWKRrA5IbnLnKQRbXNK3g600I0IInZ
   6gyZwM1b1PuGs8Hq8b0hc6Md/RTSAMydNtxOOTWncXVsoc0lLjsP9TP39
   +s4RNH6r0b31LTpD4YSGmWQ6o/ennTm4lzHbE4evVwA9g0fOiZSwSwlX1
   Kn+dbtUxJBPkgaAJc6/BPy/qSz99l4rH71HuWb9bDvm+OhkVP/vP+T1nR
   TV0iRwJ7RK9DkMaU5Z/I3IUk6ogkKmqP53I0LFJqwc+f/rjhstVo3l84M
   CQa84pXVZ8C/PRlhHBowvUc1yUqJ0qRgX+w+ekZJ7cszB44GU9V2fqsrb
   g==;
X-CSE-ConnectionGUID: QAbu0M98SLqqGzVZ1qqn8Q==
X-CSE-MsgGUID: UhPCKX0qQWmWz+gapBq/Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="97258647"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97258647"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:30 -0700
X-CSE-ConnectionGUID: mqTE1wwnROOw6v1ugVygsQ==
X-CSE-MsgGUID: pZGdrSamTL+caX9DARv0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="236118573"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:28 -0700
Message-ID: <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com>
Date: Fri, 15 May 2026 11:24:28 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a module
 update request
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-12-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260513151045.1420990-12-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 08:09, Chao Gao wrote:
> There are two important ABIs here:
> 
> 'struct tdx_image'	- The on-disk and in-memory format for a TDX
> 			  module update image.
> 'struct seamldr_params'	- The in-memory ABI passed to the TDX module
> 			  loader. Points to a single 'struct tdx_image'

	... broken up into 4k pages

> Userspace supplies the update image in struct tdx_image format. The image
> consists of a header followed by a sigstruct and the module binary.
> 
> P-SEAMLDR, however, consumes struct seamldr_params rather than the image
> directly. Parse the struct tdx_image provided by userspace and populate a
> matching struct seamldr_params.

This is doing it again. It's taking the key imperative and burying it.
It should be:

=>
Userspace supplies the update image in struct tdx_image format. The
image consists of a header followed by a sigstruct and the module
binary. P-SEAMLDR, however, consumes struct seamldr_params rather than
the image directly.

Parse the struct tdx_image provided by userspace and populate a matching
struct seamldr_params.
<=

> Validate the struct tdx_image header before using it, because the header is
> consumed solely by the kernel to locate the sigstruct and module within
> the image. Do not validate the payload itself. The sigstruct and module
> pages are passed through to P-SEAMLDR, which validates them as part of the
> update flow.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> sigstruct_pages_pa_list currently has only one entry, but it will grow to
> four pages in the future. Keep it as an array for symmetry with
> module_pages_pa_list and for extensibility.

That's a good note. It can go above the ---.

> + * The seamldr_params "scenario" field specifies the operation mode:
> + * 0: Install TDX module from scratch (not used by kernel)
> + * 1: Update existing TDX module to a compatible version
> + */
> +#define SEAMLDR_SCENARIO_UPDATE		1
> +
> +/*
> + * This is called the "SEAMLDR_PARAMS" data structure and is defined
> + * in "SEAM Loader (SEAMLDR) Interface Specification".
> + *
> + * It describes the TDX module that will be installed.

Yeah, but that's not super useful.

	This is the in-memory ABI that the kernel passes to the P-
	SEAMLDR to update the TDX module. It breaks the TDX module image
	up in page-size pieces.

Better?

> + */
> +struct seamldr_params {
> +	u32	version;
> +	u32	scenario;
> +	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
> +	u8	reserved[104];
> +	u64	module_nr_pages;
> +	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
> +} __packed;
> +
> +static_assert(sizeof(struct seamldr_params) == 4096);
> +
>  /*
>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>   * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
> @@ -43,6 +71,89 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>  
> +#define TDX_IMAGE_VERSION_2		0x200
> +
> +struct tdx_image_header {
> +	u16	version; // This ABI is always 0x200

That comment reads strangely in here. Did I ask you to write that?

> +	u16	checksum;
> +	u8	signature[8];
> +	u32	sigstruct_nr_pages;
> +	u32	module_nr_pages;
> +	u8	reserved[4076];
> +} __packed;
> +
> +#define HEADER_SIZE sizeof(struct tdx_image_header)
> +static_assert(HEADER_SIZE == 4096);
> +
> +/* Intel TDX module update ABI structure. aka. "TDX module blob". */
> +struct tdx_image {
> +	struct tdx_image_header header;
> +	u8 payload[]; // Contains sigstruct pages followed by module pages
> +};
> +
> +static void populate_pa_list(u64 *pa_list, u32 max_entries, const u8 *start, u32 nr_pages)

The naming in there is painful. How about:

populate_pa_list(u64 *pa_list, u32 pa_list_len,
		 const u8 *vmalloc_addr, u32 vmalloc_len_pages)

> +{
> +	int i;
> +
> +	nr_pages = MIN(nr_pages, max_entries);

This seems wonky. Should it really be silently suppressing things if
either the allocation or source is too small? I get not wanting to
overflow, but this seems strange.

> +	for (i = 0; i < nr_pages; i++) {
> +		pa_list[i] = vmalloc_to_pfn(start) << PAGE_SHIFT;
> +		start += PAGE_SIZE;
> +	}

At the point that you modify 'start', it's not 'start' any more. Use
another variable. This would do, for instance:

	for (i = 0; i < nr_pages; i++) {
		unsigned long offset = i * PAGE_SIZE;

		pa_list[i] = vmalloc_to_pfn(&start[offset]);
	}


> +static void populate_seamldr_params(struct seamldr_params *params,
> +				    const u8 *sig, u32 sig_nr_pages,
> +				    const u8 *mod, u32 mod_nr_pages)
> +{
> +	params->version			= 0;
> +	params->scenario		= SEAMLDR_SCENARIO_UPDATE;
> +	params->module_nr_pages		= mod_nr_pages;
> +
> +	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_MAX_NR_SIG_PAGES,
> +			 sig, sig_nr_pages);
> +	populate_pa_list(params->module_pages_pa_list, SEAMLDR_MAX_NR_MODULE_PAGES,
> +			 mod, mod_nr_pages);
> +}

Yes, this is starting to look OK. Nit: vertically align the "*_PAGES" args:


	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_...,
			 sig, sig_nr_pages);
	populate_pa_list(params->module_pages_pa_list,    SEAMLDR_...,
			 mod, mod_nr_pages);


> +static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
> +{
> +	const struct tdx_image *image		= (const void *)data;
> +	const struct tdx_image_header *header	= &image->header;
> +
> +	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
> +	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
> +
> +	u8 *header_start	= (u8 *)header;
> +	u8 *header_end		= header_start + HEADER_SIZE;
> +
> +	u8 *sigstruct_start	= header_end;
> +	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
> +
> +	u8 *module_start	= sigstruct_end;
> +
> +	/* Check the calculated payload size against the data size. */
> +	if (HEADER_SIZE + sigstruct_len + module_len != size)
> +		return -EINVAL;
> +
> +	/*
> +	 * Don't care about user passing the wrong file, but protect
> +	 * kernel ABI by preventing accepting garbage.
> +	 */

How does this "protect kernel ABI"?

> +	if (header->version != TDX_IMAGE_VERSION_2)
> +		return -EINVAL;
> +
> +	if (memcmp(header->signature, "TDX-BLOB", sizeof(header->signature)))
> +		return -EINVAL;
> +
> +	if (memchr_inv(header->reserved, 0, sizeof(header->reserved)))
> +		return -EINVAL;
> +
> +	populate_seamldr_params(params, sigstruct_start, header->sigstruct_nr_pages,
> +				module_start, header->module_nr_pages);

Please work on the vertical alignment if there's a pattern. For
instance, it makes things pop if the two "header->"'s are vertically
aligned.
