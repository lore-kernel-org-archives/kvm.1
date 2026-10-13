Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851D3AFAF4;
	Tue, 13 Oct 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879765; cv=none; b=CV2F2M/RFe4CoBlN8HbmnOvSjBLho4pdCChQbWKuOVt4XUggxknTm1WBiisPFBMEETK7pWJ83IYjB+OYPGF5sMsFhh034Y3saf7ku2ZP/oSdAWxBBaZ8izGwnPAwy5kBJwzmV2tg/yaNE1Qcv+evvvXiGN07ufbWh1tUKaujuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879765; c=relaxed/simple;
	bh=EcllwwrgWX5qQbtycXy8ggAxO0r07QpA+QAmAJhH8cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8+63CROI4mtnCnFAoS9wUttTewPEaBpdPtYY+iyPHf6O/liFcwigai29AkD4Bu9aEMQV0BaVMqb75UavCA/pxqngGfwrTMOhXyAqmfV0nBMMb9E5mY4XM0eYGGq1fcjLbltAG2w89L7b3jBAIx3nBUtaf5WllPuExvJSOfzpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSs7qeIv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSs7qeIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791879764; x=1823415764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EcllwwrgWX5qQbtycXy8ggAxO0r07QpA+QAmAJhH8cM=;
  b=jSs7qeIveTyHvhNuBDrVRMHxNlGsXAEUH7hTiGI8gtmVfCbpop+jKwUv
   fUCHrzj5nW+Nk01ilOH8gzR83SBWedFqjjFFfDyivHmD5P0Noy0VtYrSo
   i8yvp46+pdopmG8mngmHtqe7UKxgGE0Vhszi7UN8eoHwcZcER2EPRyDAv
   Pwn3E0EtmUViIhgLlRNbDQFmL1sgc5lOwOxDTPuV/BRW3Y6vjEtML3L1e
   QcoSvOwCW74GtilqkL76o6i9kFMTdovr2owkb0coJivqy2QYj+AjuTGX1
   hoEnKUiFc8gSHp7Lt84XTWBsDCCI3CanYIbq/1rxzcjJjHn7oGxj5WcJH
   w==;
X-CSE-ConnectionGUID: 8/mm4nRoRIO3ZJzvC19Opw==
X-CSE-MsgGUID: CKWTw0AUSaOA46Z+d1+gig==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="476758"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="476758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:22:43 -0700
X-CSE-ConnectionGUID: +A8xw8nST0WqGmTW8cLykQ==
X-CSE-MsgGUID: CmoL8L7XScmpWxOv/a4e8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1286873"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:22:39 -0700
Message-ID: <f7e1e51c-e353-49ad-8ad5-9a5689f46f79@linux.intel.com>
Date: Tue, 13 Oct 2026 16:22:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] x86/virt/tdx: Convert the version metadata
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
 <20261012094754.27702-3-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
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
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

> @@ -437,6 +437,12 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
>  #define FIELD_MAP(_field, _type, _member)	\
>  	__FIELD_MAP(_field, struct tdx_sys_info_##_type, _member)
>  
> +static const struct field_mapping version_mappings[] = {
> +	FIELD_MAP(TDX_FIELD_MINOR_VERSION,	version, minor_version),
> +	FIELD_MAP(TDX_FIELD_MAJOR_VERSION,	version, major_version),
> +	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	version, update_version),
> +};

Nit:
I personally prefer the version provided in
https://lore.kernel.org/kvm/ar-e8WzRS7IUKWgH@intel.com
The full types keep the code greppable and __FIELD_MAP() could be dropped.

Also, it is a bit weird that FIELD_MAP() use _type as the name for the second
input, but the shortened one is not really a type.


