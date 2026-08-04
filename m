Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51943CECD;
	Tue,  4 Aug 2026 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887551; cv=none; b=KocrhkW6WGIqqNzTPu2221Kq8qNZI1Anj6c5W4eD8iKsBtAHxYlgVGER3xtGgLz66NRSOJXkr7KnTZBP+CwLcghcAbcKmG2hrXRud+lGviyAM8q4GMUwu3/HSuIJDN9I1W8mjfPxnd3hdBIuHcl1RdwLpx/YPv0otvpDpGAsHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887551; c=relaxed/simple;
	bh=gBCQYuhZpbYN+w/FR6gAmqPmV2XpftJjUeBmB+rIDU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScM/2KtREOsAOSkupasiFzUjJUQOHmLN8C93NqtgaQaZhnj4JPsRpOKDCz6spoEBAcgydyL02/wNqdaQP87yCDzCwXh06S7by+lXKZFHHPp4n/xqrLQdhRARRX21SA9TwGCiBG3XHwrSBt3sX9BUdu/MFVu2r3WhX7vUCr+Z+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQlPYsV2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQlPYsV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887549; x=1817423549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gBCQYuhZpbYN+w/FR6gAmqPmV2XpftJjUeBmB+rIDU0=;
  b=NQlPYsV2hBeKGR3keR7C0wEpyktpzXtea+IisJCVyhs/2CO2fmRtMhXJ
   iWrt12YQI9GxHwCg+AAR0Mz1izoUw5aToyFgMbrDXbZlpVg3OAAtglaam
   1Pc2PVKS/MIwZBVeAuevWIxeKL51tzn6y0mxVBRkeOOrCaAqMNjIJ96gj
   NUlslAAQhg46kONRWMpOV/PimaQnd0P1/nyiaYD61Nu5DAH4kbkKi8p8I
   jI4TjykERMuqo2xuBWclWEGJtqS6u+Kli6KDeUd1PJPdC66KiA8xmWK6z
   BEuOUQRZ+SCG5cLn3kLQZyA3rmdyL0eNHR21S8+CQgwYtLkCliWYOFkPa
   A==;
X-CSE-ConnectionGUID: MRGVD7ajTpiZvEoPZ3QQQw==
X-CSE-MsgGUID: qZOC97qRR5ystIY7195omA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86482469"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86482469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:52:28 -0700
X-CSE-ConnectionGUID: Z2B8i/oKR1an4l+HwdwzOw==
X-CSE-MsgGUID: 1ke4eZpMS2aDAJii3ZPlGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="260380773"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.19]) ([10.125.109.19])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:52:28 -0700
Message-ID: <7ecd59df-1bae-487d-a7e4-bf7bc0c45615@intel.com>
Date: Tue, 4 Aug 2026 16:52:26 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata
 field IDs
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com, kas@kernel.org, dave.hansen@linux.intel.com
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-3-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260804112941.19894-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 04:29, Chao Gao wrote:
> From: Dave Hansen <dave@sr71.net>
> 
> tdx_global_metadata.c currently identifies each field by a bare 64-bit hex
> literal, extracted from the JSON file by an out-of-tree script:
> 
> 	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
> 		sysinfo_tdmr->max_tdmrs = val;
> 
> That is unreviewable on its own. Verifying any one line requires the
> reviewer to cross-reference the JSON file.

I'm looking at "global_metadata.pdf" from this[1]. I see a line with
"MAX_TDMRS" and "0x9100000100000008". That matches the lines above. That
seems *FAR* from unreviewable. There's also no JSON in sight.

What am I missing?

Listen, I don't like how this turned out. I'm asking for it to be
changed. But let's not justify it with things that just aren't true.

> The hex literals in tdx_global_metadata.c are left alone because that file
> will be replaced by a table-driven reader in the following patches.

This part of the changelog is good.

> No functional change intended.

This is a bit much. :)

> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index bdfd0e1e337a..5f567cb6c07a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -58,6 +58,57 @@
>   */
>  #define TDX_VERSION_SHIFT		16
>  
> +/*
> + * Global Scope Metadata field IDs.
> + *
> + * See "Global-Scope (TDX Module) Metadata" in the Intel TDX Module ABI
> + * spec.
> + *
> + * A field ID is a 64-bit value that encodes the metadata "Class"
> + * (which Linux mirrors in 'struct tdx_sys_info' sub-structures),
> + * the element size, and a per-class field index. Each ID below
> + * is paired with the C member that holds its value.
> + */

This is a bit verbose for my taste.

> +/* Class "TDX Module Version" */
> +#define MD_FIELD_ID_MINOR_VERSION		0x0800000100000003ULL
> +#define MD_FIELD_ID_MAJOR_VERSION		0x0800000100000004ULL
> +#define MD_FIELD_ID_UPDATE_VERSION		0x0800000100000005ULL
> +
> +/* Class "TDX Features" */
> +#define MD_FIELD_ID_TDX_FEATURES0		0x0A00000300000008ULL
> +
> +/* Class "TDMR Info" */
> +#define MD_FIELD_ID_MAX_TDMRS			0x9100000100000008ULL
> +#define MD_FIELD_ID_MAX_RESERVED_PER_TDMR	0x9100000100000009ULL
> +#define MD_FIELD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
> +#define MD_FIELD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
> +#define MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
> +
> +/* Class "TD Control Structures" */
> +#define MD_FIELD_ID_TDR_BASE_SIZE		0x9800000100000000ULL
> +#define MD_FIELD_ID_TDCS_BASE_SIZE		0x9800000100000100ULL
> +#define MD_FIELD_ID_TDVPS_BASE_SIZE		0x9800000100000200ULL
> +
> +/* Class "TD Configuration" */
> +#define MD_FIELD_ID_ATTRIBUTES_FIXED0		0x1900000300000000ULL
> +#define MD_FIELD_ID_ATTRIBUTES_FIXED1		0x1900000300000001ULL
> +#define MD_FIELD_ID_XFAM_FIXED0			0x1900000300000002ULL
> +#define MD_FIELD_ID_XFAM_FIXED1			0x1900000300000003ULL
> +#define MD_FIELD_ID_NUM_CPUID_CONFIG		0x9900000100000004ULL
> +#define MD_FIELD_ID_MAX_VCPUS_PER_TD		0x9900000100000008ULL
> +
> +/* Class "TDX Module Handoff" */
> +#define MD_FIELD_ID_MODULE_HV			0x8900000100000000ULL

These are fine on their own.

> +/*
> + * Base IDs for the configurable-CPUID arrays.  The field ID of leaf
> + * index @i is BASE + i; for the values array, sub-entry @j of index
> + * @i is BASE + i*2 + j.
> + */
> +#define MD_FIELD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400ULL
> +#define MD_FIELD_ID_CPUID_CONFIG_VALUES		0x9900000300000500ULL

This is complete jibberish without more context.

1,
https://www.intel.com/content/www/us/en/content-details/865803/abi-definitions-for-intel-tdx.html
