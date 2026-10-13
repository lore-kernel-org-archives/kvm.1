Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96B4D17B3;
	Tue, 13 Oct 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889844; cv=none; b=tW1G5HtooSPPMiZxUBVptCLDCxn9fID42q/riSyDbEOhu4iCvLe7N2F5PeUTlN4zVK6DRh/xWIvmA0kq6zi68L+JM/cu4xJCX5kgn/ubFUHvpCevaRPgHxiCe89UPafUc7bP4c1vqisJP+ia8ATErfRVUX/DCe7jS3ujXvZLZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889844; c=relaxed/simple;
	bh=hAz9P8ZFLCz2wZjxPDxhsbn9sAAtthpWjPZtM6f+q1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WguS5j+yNjfkVciKvXS8t3yFDc8evWEIeojVDPpKJWXBIiv/ypFd2clnt+igHs4bS9LpONby1c68ZOW6+ZWDo8v2YXzCAIieH6V9WCg/gk1ibjtapyf1/iQx9nK7VzXPvd/pog01jQIVopQNKXuUG1i7w4UULWp1vNibvCZ/Sf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGCxcYgA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGCxcYgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791889843; x=1823425843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hAz9P8ZFLCz2wZjxPDxhsbn9sAAtthpWjPZtM6f+q1w=;
  b=NGCxcYgAUzvA8ze8Ch2Z4b20BoxStu9X20ktBpgMNujMploy2NTqGxf1
   aih9iOeEwZRu/c6WAevgniBLTX7Y6ILpQUA09rjxH4gZEXiqiwDJTCCbB
   vcYP82Jk6/VXI/koFkwjpiaTAhGBpuHgJ+LNrJrZkeySvcbUprIia0M6K
   1cQi6AokdDypclPiH44fbWd3JG0IRhLLBNgWh8koeo9PoBpeNj2BkaeDC
   rkNi53cDnolXBG9QDECDD4QYfF1KrpqoNWJbA7g8SOffYC8X4gvobPqcE
   2YTI+/cWA3uJr592RXehCKs26gzka7gts2KLGpRedTR0aFvqfM8rP4KSq
   g==;
X-CSE-ConnectionGUID: abIrf1GCTC6w05yHdxK5tA==
X-CSE-MsgGUID: SOOsHy4sSh6CrS5pi7dBww==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="618135"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="618135"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 04:10:42 -0700
X-CSE-ConnectionGUID: 3TznrqCeQJya91LY1E6G2w==
X-CSE-MsgGUID: KWZSP4yoSumYmWPzo2y0Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1110377"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 04:10:40 -0700
Message-ID: <94be5e5e-808d-469e-bf72-e1d9b7c7c879@linux.intel.com>
Date: Tue, 13 Oct 2026 19:10:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-11-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-11-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> The TDX module reports its capabilities and limits as a set of metadata
> fields, each identified by a field ID, and TDH.SYS.RD reads one field by
> its ID. TDH.SYS.RD returns the value as a u64, but metadata fields are not
> all 64 bits wide. A field ID therefore encodes the field's size into
> bits 33:32.
> 
> The kernel mirrors these fields in C structures, and each member's size
> must match the size encoded in the field ID. FIELD_MAP() stores the member
> size and uses it to decide how many bytes to copy from the value returned
> by TDH.SYS.RD. The size in the field ID is never consulted, so any mismatch
> goes unnoticed. Declaring a u32 member for a 64-bit field, for example,
> would silently store only its low 4 bytes.
> 
> Add a build-time check that the size encoded in each field ID matches the
> size of the corresponding C structure member. A wrongly typed member then
> fails the build with no runtime cost.
> 
> BUILD_BUG_ON() cannot be used in a structure initializer, so use
> BUILD_BUG_ON_ZERO() and add its zero result to the .size initializer. This
> performs the build-time check without changing the stored size.
> 
> An alternative would be to leave the size bits out of the field ID
> definitions and construct the IDs from the member sizes, which makes a
> mismatch impossible. But the TDX module ABI definitions list the full field
> IDs, and definitions with the size bits stripped would match nothing in the
> docs, making them harder to verify. Keep the IDs exactly as documented and
> check the size they encode against the C type instead.
> 
> AI was used under supervision to review code and workshop logs. It
> suggested moving the size check into its own macro to keep the .size line
> short. Rick also used AI to write TDX_FIELD_SIZE_CODE(), which converts a
> member size to the size encoding in the field ID.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

>  
> +/*
> + * The size encoded in the field ID and the size of the destination C
> + * member must agree.
> + */
> +#define TDX_FIELD_SIZE_CHECK(_field, _type, _member)		\
> +	BUILD_BUG_ON_ZERO(((_field) & TDX_FIELD_SIZE_MASK) !=	\
> +		TDX_FIELD_SIZE_CODE(sizeof_field(_type, _member)))
> +
>  #define __FIELD_MAP(_field, _type, _member)			\
>  {								\
>  	.field_id	= _field,				\
>  	.offset		= offsetof(_type, _member),		\
> -	.size		= sizeof_field(_type, _member),		\
> +	.size		= sizeof_field(_type, _member) +	\
> +			  TDX_FIELD_SIZE_CHECK(			\
> +				_field, _type, _member),	\
>  }
>  

Nit:

This doesn't cover the TDX_FIELD_CPUID_CONFIG_LEAVES and
TDX_FIELD_CPUID_CONFIG_VALUES.

Not sure it's worth to add static_assert() in get_tdx_sys_info_td_conf(). But if
not, maybe it can be mentioned it in the changelog.
