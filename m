Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068364457D3;
	Tue, 13 Oct 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885446; cv=none; b=XNOvenUnpI8hYqIveHmTXlUaBs8Bt+bWCn8bqQCvnkmCK9Yfgs0R5OGiWiRqVM7aWHsBl8KA5GAVA3PU7aPjS/x6raMWU/P5iDzEA7ztaCOUv0aTFaqOGj3yEbKluDIJUrn5O7/vVSEPUZNEB8fvfoqdZbdznrbbh3X3si977E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885446; c=relaxed/simple;
	bh=wAyQuMPhgE7rIEwhefUVJK9Gj7Sb6CQB4NMZXZ/y73U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS+Er1X1QWAlefnRzdYyyr0nvlY3JC0x3MY7X+kI8HNX3OEij1xVk+qywJfHAaknPipAjMULatp2YX9ewuCh7zEYb5TE1/l9xibBpxBCcKCT2nW7OrIIZijw/3JNdq8daN4e3iQCDnsE4uit6pwSIGCnv8fyrFoZVmkdgmYl+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i41BwXJl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i41BwXJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791885444; x=1823421444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAyQuMPhgE7rIEwhefUVJK9Gj7Sb6CQB4NMZXZ/y73U=;
  b=i41BwXJlW7jISi1dW+SOi8/3CnUzmoSmFIo9tTF1Ct+rmLumfED1Hrwc
   RZtz9Grbaaa00qgOnbKQk1ztlt4BLje+G+aOlBCfhfxK/WJzvwwS1le/6
   tnbLUhn1/rla/3+EJlDi+krg3c3+GN/EiW2/cbfTXXadKnjCRAbncD9I8
   dazQ+xiN3abkUSqzF89CB2IINlIWaqJrIFDPcUuYuMEcQkc5VDSNJmtVl
   KyIHJZhAorRWhLmrCyEnpG0J+SEgweogUolRNvscAtuSGCopFUH829778
   mWwaABW170osG/K6MsPSLQHkZLSoOYfgxMogvxxyfqWKmrarzyAMULRnD
   g==;
X-CSE-ConnectionGUID: D+j/ek1mS0SFIhy3NbNrdw==
X-CSE-MsgGUID: yIaivFhzScGGRLsIujGOTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="503914"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="503914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:57:23 -0700
X-CSE-ConnectionGUID: 6mFUfCpoRmmKhwwO3Js6pA==
X-CSE-MsgGUID: nJkODKsoTUuyfwXkvOtNng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1055004"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:57:21 -0700
Message-ID: <4c41933d-b43f-4ae7-8b80-fa97ef4d4623@linux.intel.com>
Date: Tue, 13 Oct 2026 17:57:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-8-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-8-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> The "TD Configurability" class holds several scalar fields plus two CPUID
> arrays. The arrays have a fixed capacity, but the number of entries to
> read is variable and reported by the num_cpuid_config scalar field.
> 
> Add a table that pairs each scalar field ID with the 'struct
> tdx_sys_info_td_conf' member that holds its value, and read those fields
> by walking that table.
> 
> Annotate the table as __initconst as it is referenced only during init.
> 
> Leave the two arrays open coded. 'struct field_mapping' pairs one field ID
> with one structure member, so describing an array would require a field ID
> per field plus an entry count that is unknown until num_cpuid_config has
> been read. That is not worth building for the only two arrays the kernel
> reads.
> 
> Read both arrays in a single loop, as both have num_cpuid_config
> entries. Store each value directly into its array member instead of
> into a temporary u64 first. The members are u64 already, so the extra
> copies serve no purpose.
> 
> The inner dimension of cpuid_config_values[] is fixed at 2. Read the
> two values with two calls instead of an inner loop. This saves a level
> of indentation and is simpler to read.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> +static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
> +{
> +	int ret, i;
> +
> +	ret = read_sys_metadata_table(td_conf_mappings, td_conf);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The number of CPUID config entries must not exceed the array
> +	 * sizes.
> +	 */

Nit:
The comment seems to be redundant since the code itself tells it.

> +	if (td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_leaves) ||
> +	    td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_values))
> +		return -EINVAL;
> +

[...]

