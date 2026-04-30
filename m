Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04181ACA;
	Thu, 30 Apr 2026 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509952; cv=none; b=l+K2rYll67IMfKgIEOySWMEDV3pLfCcVL6Ee+lTT0yeZ2Jh1Gc0qDJkDonOhPuAaQH8pfSNVtdZ52t7eedmFzc/e74Q854e+NiES43MxTilv5angC1kb02T5lBrUcr7iNMnLlVliliZj5QC50rKC9J7eZzjxWrcXq9yBEp63ukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509952; c=relaxed/simple;
	bh=Zil/maMdk+8ongptR/3xql5omXPBATANWuzpMrLKRhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpgwHYZiP5QX6+E5mhGaq7VOuG5A7l9MvWbVLkXwnbFvEiBRpiGAorTJQ7iXuiEftKDdObK2vlPk0EFJuMlFz1DrcLWS7CPHrgee91kuppx10af+0J5H+FQ9qiDEoG9iQgZ+VG9YTH9luihsR1hi1UnQFDVteQTpQ2oHm2qYB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUUWe/4U; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUUWe/4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509949; x=1809045949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zil/maMdk+8ongptR/3xql5omXPBATANWuzpMrLKRhc=;
  b=bUUWe/4U0mEaJYr17eGm+1H03d1KRNZ10X/OO5JGARD+lKS2KkzV3kNA
   VLNV7Kx1u+7ahFU9Om8/MRW57rt55NekrIotM7BYvVb7UUuPXwneNU+1+
   MVtk7NBSv22lOG4uWbor1ucW+lYPAkAbi4F9xX98IoHWG7Z4EDdU3/wLw
   3oMN1vEVpxSMpv2AoBQR+0QfEc7xTDVpSL/jBnWiJxbpXsSwEXVRy8yEO
   n1/LnOq8gxN4sX5OsVv1zgxg+vyxkQYTHBGuCnfzN/PHrGZUic1AJKjp6
   gUH6m6Sys+xhlSap2BGWaOX5Y0jKwpO5e0xwyf117SQBPJWUaB30r72uK
   g==;
X-CSE-ConnectionGUID: t90pUdJJTXSn8HOphNV2JA==
X-CSE-MsgGUID: ailBTuc1T6ucw2qYuTNjQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78163575"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78163575"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:45:48 -0700
X-CSE-ConnectionGUID: /X1glbTDTyu6q7mWerwn2A==
X-CSE-MsgGUID: HS/g1wNhScGxlR9N4Fy+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="233377861"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.40]) ([10.125.109.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:45:48 -0700
Message-ID: <a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com>
Date: Wed, 29 Apr 2026 17:45:47 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/21] x86/virt/seamldr: Allocate and populate a module
 update request
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-9-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260427152854.101171-9-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 08:28, Chao Gao wrote:
> P-SEAMLDR uses the SEAMLDR_PARAMS structure to describe TDX module
> update requests. This structure contains physical addresses pointing to
> the module binary and its signature file (or sigstruct), along with an
> update scenario field.
> 
> TDX modules are distributed in the tdx_blob format defined in
> blob_structure.txt from the "Intel TDX module Binaries Repository". A
> tdx_blob contains a header, sigstruct, and module binary. This is also the
> format supplied by the userspace to the kernel.
> 
> Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure. The
> header is consumed solely by the kernel to extract the sigstruct and
> module, so validate it before processing to protect the kernel ABI. The
> sigstruct and module are passed to and validated by P-SEAMLDR, so don't
> duplicate any validation in the kernel.
> 
> Note: the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
> a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
> Specification" will be published separately.

These changelogs have all the right info, but I find them really hard to
parse. For instance, if you're going to have a 'struct seamldr_params',
then just stick with that name. Don't use the "SEAMLDR_PARAMS" name too.

Start with the data structures:

There are two important ABIs here:

'struct tdx_blob'       - the on-disk and in-memory format for a TDX
 		          module update image.
'struct seamldr_params' - The in-memory ABI passed to the TDX module
			  loader. Points to a single 'struct tdx_blob'

> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 650c0f097aac..f70be8e2a07b 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)	"seamldr: " fmt
>  
>  #include <linux/mm.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
>  #include <asm/seamldr.h>
> @@ -16,6 +17,33 @@
>  /* P-SEAMLDR SEAMCALL leaf function */
>  #define P_SEAMLDR_INFO			0x8000000000000000
>  
> +#define SEAMLDR_MAX_NR_MODULE_PAGES	496
> +#define SEAMLDR_MAX_NR_SIG_PAGES	4

Gah. All this complexity for the variable-length sigstruct to save a
maximum of 4 pages. Wow.

This whole thing could have been:

struct tdx_image {
	u16	version; // This ABI is always 0x100
	u16	checksum;
	u8	signature[8];
	u32	length;
	u8	reserved[4076];
	u8	sigstruct[SIGSTRUCT_SIZE];
	u8	module[];
}

One variable array. No module offset calculations or munging.

Why do we do this to ourselves for 3 measly pages? ;)

> +/*
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
> + */
> +struct seamldr_params {
> +	u32	version;
> +	u32	scenario;
> +	u64	sigstruct_pa[SEAMLDR_MAX_NR_SIG_PAGES];
> +	u8	reserved[80];
> +	u64	num_module_pages;
> +	u64	mod_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
> +} __packed;
> +
> +static_assert(sizeof(struct seamldr_params) == 4096);
> +
>  /*
>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>   * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
> @@ -43,6 +71,128 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>  
> +/*
> + * Intel TDX module blob. Its format is defined at:
> + * https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt

Heh, so URLs are not OK in changelogs because they go stale, but they're
fine in the code?

> + * Note this structure differs from the reference above: the two variable-length
> + * fields "@sigstruct" and "@module" are represented as a single "@data" field
> + * here and split programmatically using the offset_of_module value.

This is good info. But, it's copied and pasted between the changelog and
here. I'd choose one, honestly.

> + * Note @offset_of_module is relative to the start of struct tdx_blob, not
> + * @data, and @length is the total length of the blob, not the length of
> + * @data.
> + */

Out of line comments aren't great. Do these in the data structure if at
all possible. Or, in the code. For instance:

> +struct tdx_blob {
> +	u16	version; // This ABI is always 0x100
> +	u16	checksum;
> +	u32	offset_of_module; // from start of tdx_blob
> +	u8	signature[8];
> +	u32	length;
> +	u32	reserved0;
> +	u64	reserved1[509];
> +	u8	data[]; // contains sigstruct[] and module[]
> +} __packed;

That's probably _better_ than the two duplicated comments that are there
now.

Also, why bother having two reserved arrays instead of:

	u8 reserved[4076];

?

> +/* Supported versions of the tdx_blob */
> +#define TDX_BLOB_VERSION_1	0x100

The comment here doesn't help much.

> +/*
> + * Blob fields are processed by the kernel and the payloads
> + * are passed to the TDX module. Do normal user input type
> + * check for any fields that don't get passed to the TDX module.
> + */

I made it this far, but I rather despise the 'blob' terminology. It's
just bad naming. We should really just call it 'tdx_update_image' or
'tdx_image' everywhere and stop saying 'blob'. Blob is one of those
names that people throw at things when they give up on naming.

> +static const struct tdx_blob *get_and_check_blob(const u8 *data, u32 size)
> +{
> +	const struct tdx_blob *blob = (const void *)data;
> +
> +	/*
> +	 * Ensure the size is valid otherwise reading any field from the
> +	 * blob may overflow.
> +	 */
> +	if (size <= sizeof(struct tdx_blob))
> +		return ERR_PTR(-EINVAL);

Couple of things here:

First, using sizeof() on a type with a variable-length array is a big
warning sign. It needs commenting. It's especially subtle because this
will go on and parse patently invalid 'data' images that don't even have
room for sigstruct[] or module[].

This is *specifically* about the pre-data[] fields that are going to be
read below.

> +	/*
> +	 * Don't care about user passing the wrong file, but protect
> +	 * kernel ABI by preventing accepting garbage.
> +	 */
> +	if (memcmp(blob->signature, "TDX-BLOB", 8))
> +		return ERR_PTR(-EINVAL);

Is there really no helper in the kernel anywhere that can safely do the
8-byte compare against two known-to-the-compiler 8-byte-wide fields
without hard-coding the 8?

> +	/*
> +	 * Ensure the offset of the module is within valid bounds and
> +	 * page-aligned.
> +	 */
> +	if (blob->offset_of_module >= size || blob->offset_of_module <= sizeof(struct tdx_blob))
> +		return ERR_PTR(-EINVAL);

Again, the sizeof(struct tdx_blob) is wonky. Why does this disallow
pointing blob->offset_of_module at reserved1[508] but not sigstruct[]?

> +	if (!IS_ALIGNED(blob->offset_of_module, PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);

Wait a sec. Unless blob->offset_of_module==0, how could this check pass
and "blob->offset_of_module <= sizeof(struct tdx_blob)" fail?

> +	if (blob->version != TDX_BLOB_VERSION_1)
> +		return ERR_PTR(-EINVAL);

This should be the first check, IMNHO. If this doesn't pass then the
rest of the fields are invalid. No?

> +	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
> +		return ERR_PTR(-EINVAL);

There should not be two reserved, must-be-0 fields. There should be 1.
There must be 1.

Also I don't like the proposed data structure. It would make a lot more
sense to me if it were:

struct tdx_image_header {
	u16	version; // This ABI is always 0x100
	u16	checksum;
	u32	offset_of_module; // from start of the header
	u8	signature[8];
	u32	length;
	u8	reserved[4076];
}

struct p {
	u8[PAGE_SIZE];
};

struct tdx_image {
	struct tdx_image_header h;
	struct p pages[];
};

Then you can do things like check if sizeof(struct tdx_image_header) ==
PAGE_SIZE. Or whether offset_of_module points past the header.

That stuff only makes sense if you separate out the header structure
from the payloads which are the page-aligned sigstruct and module image
itself.

But exposing the double-variable-length arrays seems really wonky to me.

> +	return blob;
> +}
> +
> +static struct seamldr_params *alloc_seamldr_params(const struct tdx_blob *blob, unsigned int blob_size)
> +{

This does far more than "alloc" something.

> +	struct seamldr_params *params;
> +	int module_pg_cnt, sig_pg_cnt;
> +	const u8 *sig, *module;
> +	int i;
> +
> +	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!params)
> +		return ERR_PTR(-ENOMEM);

kzmalloc(PAGE_SIZE, GFP_KERNEL) will save you a cast.

> +	/*
> +	 * Split the blob into a sigstruct and a module. Assume all
> +	 * size/offsets are within bounds of blob_size due to prior checks.
> +	 */
> +	sig		= blob->data;
> +	sig_pg_cnt	= (blob->offset_of_module - sizeof(struct tdx_blob)) >> PAGE_SHIFT;

Of course, the size of the first thing is defined by the offset of the
second thing.

This really should just be called ->end_of_sig.

> +	module		= (const u8 *)blob + blob->offset_of_module;
> +	module_pg_cnt	= (blob_size - blob->offset_of_module) >> PAGE_SHIFT;

This looks halfway sane:

	 /* adjust for size of the header: */
	sig_size    = blob->end_of_sig - PAGE_SIZE;
	module_size = module_image_size - blob->end_of_sig;

Then, page-adjust it later. One bit of magic at a time, please.

> +	/*
> +	 * Only use version 1 when required (sigstruct > 4KB) for backward
> +	 * compatibility with P-SEAMLDR that lacks version 1 support.
> +	 */
> +	params->version = sig_pg_cnt > 1;

Ewwww.

But what do we do if we're on an old P-SEAMLDR but get a big sigstruct?
It'll just fail?

How many old P-SEAMLDRs are there in the wild? Do we even care about this?

> +	params->scenario = SEAMLDR_SCENARIO_UPDATE;
> +
> +	for (i = 0; i < MIN(sig_pg_cnt, SEAMLDR_MAX_NR_SIG_PAGES); i++) {

Same for the MIN(). Do all the calculations separate from the loop.

> +		params->sigstruct_pa[i] = vmalloc_to_pfn(sig) << PAGE_SHIFT;
> +		sig += PAGE_SIZE;
> +	}
> +
> +	params->num_module_pages = MIN(module_pg_cnt, SEAMLDR_MAX_NR_MODULE_PAGES);
> +	for (i = 0; i < params->num_module_pages; i++) {
> +		params->mod_pages_pa_list[i] = vmalloc_to_pfn(module) << PAGE_SHIFT;
> +		module += PAGE_SIZE;
> +	}

Really what you want here is a helper. Have it take the module or
sigstruct pointer, a pointer to the pa_list[] and a maximum size.

Then call the helper twice.

> +	return params;
> +}
> +
> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
> +{
> +	const struct tdx_blob *blob;
> +
> +	blob = get_and_check_blob(data, size);
> +	if (IS_ERR(blob))
> +		return ERR_CAST(blob);
> +
> +	return alloc_seamldr_params(blob, size);
> +}
> +
> +DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
> +	    if (!IS_ERR_OR_NULL(_T)) free_page((unsigned long)_T))

Is this really worth it?

>  /**
>   * seamldr_install_module - Install a new TDX module.
>   * @data: Pointer to the TDX module update blob.
> @@ -52,6 +202,11 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>   */
>  int seamldr_install_module(const u8 *data, u32 size)
>  {
> +	struct seamldr_params *params __free(free_seamldr_params) =
> +						init_seamldr_params(data, size);
> +	if (IS_ERR(params))
> +		return PTR_ERR(params);
> +
>  	/* TODO: Update TDX module here */
>  	return 0;
>  }

IMNHO, this patch has way too much going on. It took well over an hour
to go through it. That's problematic.
