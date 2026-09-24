Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC432D0EE;
	Thu, 24 Sep 2026 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230438; cv=none; b=PtWaVcwRj42WqGUsISCIZ/cnuJupnPFhroAUeDxFYuq3bfzs8sO0fEx3buLP0EV0fhc3fVyK2erL/S6etwNfqviMkZyQNBH8d3l9M0LTwNL8+6FbaJL9gv+fpqueiTwvfrpjJ9MMi+m3ZytpkQMhr24JCtn+gWwL9l3xJXeQsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230438; c=relaxed/simple;
	bh=br8lAzeqVyzB+uljBzUroXIIRvT7Z6JZYmbmVLAxM1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leAcVbrgIN6jMfD76GiRc2qvQVNsIG/YIcQbwDqn/hV/9qVUee3UXPoFw+0XWk3F0xu8UWAIaXjAmAGNsr1Yp1VgcXLUxUabbN4KVNEh5yGE446r0ez1/+6UwxjhyPXrfBmmJ4DFkx+dAgQjxwEILEn2NLe126xD8/UwVHXJyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP2IfeUz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP2IfeUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790230437; x=1821766437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=br8lAzeqVyzB+uljBzUroXIIRvT7Z6JZYmbmVLAxM1k=;
  b=KP2IfeUzfMFxIaDVl2hfkvm9qAKuCIqsPD86kMY12jC00GublTxazIAM
   UuG8GW1GLJhSLj0wTjgQChloxD2yBKoRpMZieUfgwucT47D/osp56zpb7
   lgUqPn0xTaHhbkp1gOgo9I7K/aFApOqKm69Kdwmc4tDNIrjlDj+eh8N9I
   Q55KT0jv81KE2aOQkFKYmVL2k2GoXOCC/LA6C9i6nPu83t6nzxGTCgDOU
   RPlfG/8q0BJ3u6RZhbqxEaLMgR/EwPi/Kb+IqF48MVpmZaagVVNg6KLJ+
   604TcXGPhamGS8YVFUt29bZd5MFq1Fsv7TYndon/HVZkMWfYyYyfU0MOp
   A==;
X-CSE-ConnectionGUID: nLZjzL28QbOS1RGdyADRGg==
X-CSE-MsgGUID: 2ytHctbyR5e8dmzgIriYng==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91095658"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91095658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:13:56 -0700
X-CSE-ConnectionGUID: cRyTJIP+S7aDR5zVonHKkg==
X-CSE-MsgGUID: iEBfnuXrSreyJf3fqTtMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274102054"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:13:53 -0700
Message-ID: <7ba1284c-69d9-43fa-8a44-1dbf30f209e1@linux.intel.com>
Date: Thu, 24 Sep 2026 14:13:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/10] x86/virt/tdx: Add a helper to read a table
 of metadata fields
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-2-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260918132946.76533-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2026 9:29 PM, Chao Gao wrote:
>  
> +/*
> + * Map a TDX global metadata field to a structure member.
> + * @field_id: The TDX global metadata field ID.
> + * @size: The size of the structure member.
> + * @offset: The member's offset within its containing structure.
> + */
> +struct field_mapping {
> +	u64 field_id;
> +	size_t size;
> +	int offset;

Nit:
Is it better to align the type of "size" and "offset" with size_t?
Since it's already 24 bytes per entry on x86_64, there is no extra memory cost.

> +};
> +
> +/* Read each metadata field listed in @mappings[] into @data. */
> +static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *mappings,
> +						    int num_mappings, void *data)
> +{
> +	int i, ret;
> +	u64 val;
> +
> +	for (i = 0; i < num_mappings; i++) {
> +		ret = read_sys_metadata_field(mappings[i].field_id, &val);
> +		if (ret)
> +			return ret;
> +		memcpy((char *)data + mappings[i].offset, &val, mappings[i].size);
> +	}
> +
> +	return 0;
> +}
> +
> +#define TDX_SYSINFO_MAP(_field, _type, _member)			\
> +{								\
> +	.field_id	= TDX_MD_FIELD_ID_##_field,		\
> +	.offset		= offsetof(_type, _member),		\
> +	.size		= sizeof_field(_type, _member),		\
> +}
> +
>  #include "tdx_global_metadata.c"
>  
>  static __init int check_features(struct tdx_sys_info *sysinfo)

