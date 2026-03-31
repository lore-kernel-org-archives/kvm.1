Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F93F54CB;
	Tue, 31 Mar 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969090; cv=none; b=iEWfakv122jpgV9azL61VCLIMVRE56jNgNudirz3yu2csJNkamyJzJREcPq55OzRetZ5c7b0PNMLOoX0pa/KYDy4ZvgAXA+K5SUS0A33Otj2gi7WHX4xRGdtnJJ46wty3Y0Zo9ZUlHcbehJFNFECLBJboAUVg+CtlqtzGiUUqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969090; c=relaxed/simple;
	bh=sHgfIFGCrS1CuYalHpv8GUnSomSOgoC1zvzwLIckvRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiCkgmXJkfEIyDEqDAdw8PDrTKg+RvBkDHkob/uUYlxs6ydizh+jTNoys/BczkQ7BLyeqWR6Llq+C/kFz1pMVS/UwWFqqMS409Kf1BAkkk6Hzn9a6ZoZlAA6KDhvOhG+xfH34ULl+XU3Jb7YqH3PM3SUaeaaMfvTtxRuIi6hx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4z7z5ul; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4z7z5ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969089; x=1806505089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sHgfIFGCrS1CuYalHpv8GUnSomSOgoC1zvzwLIckvRY=;
  b=T4z7z5ulXBgbzkVKNpmcDxnlH5v2hhW7neuVS4kBzUv1vIz8QNproJ0Q
   N77v14LHvLshYJP4gM1UNGlR3HBm/AACgl5xiy8IhJY5QtyQB70Xwd+bo
   3QOSLNSYC4VzoFF1xL3UySkxInwF2F/IcpgSgRGbCJbcUmtV4+1jH0b3g
   +yVenzjS459HjEMvA6a4OAAJLqndppFrcco9HpihaLxJZKHfwwajnjJ8T
   mkmVn+dLnmUDLRDgu4acBMe9ms/il7vBv/RKDk/pW4Y3Cpgj3GvsYt6zP
   IO6G4OjBpRRt91iLixfNKuX/21nNuIOCm0Qth9VoX88NM4ttV23oszCJH
   Q==;
X-CSE-ConnectionGUID: HTrzxnFcSFWSyRx2d/LCDQ==
X-CSE-MsgGUID: aHuS6tFvTeqY/2TdnuH8lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87376917"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87376917"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:58:08 -0700
X-CSE-ConnectionGUID: h6FJNCpxQlSNa60ItNigZg==
X-CSE-MsgGUID: XRVTNJXDSMCOHxts269/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="256885549"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.50]) ([10.125.111.50])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:58:08 -0700
Message-ID: <95126568-3031-4d0a-85c8-d3934b6fec3e@intel.com>
Date: Tue, 31 Mar 2026 07:58:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
To: Chao Gao <chao.gao@intel.com>, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-7-chao.gao@intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260331124214.117808-7-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 05:41, Chao Gao wrote:
> +/*
> + * Open-code DEVICE_ATTR_ADMIN_RO to specify a different 'show' function
> + * for P-SEAMLDR version as version_show() is used for TDX module version.
> + *
> + * Admin-only readable as reading these attributes calls into P-SEAMLDR,
> + * which may have potential performance and system impact.
> + */
> +static struct device_attribute dev_attr_seamldr_version =
> +	__ATTR(version, 0400, seamldr_version_show, NULL);
> +static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);

I don't like that these are really *exactly* the same, except for the
name but are defined so differently. I see three alternatives that are
better:

1. Open code *both* so they look the same
2. Define a macro that both can use that has a seamldr_## prefix
3. Move the code to a new file to avoid symbol conflicts.

I'd honestly be fine with any of those.

The other option is to just put the module information at the top
directory so the sysfs name differentiates things.

For real, how many things are going to be in the seamldr directory? If
it's just two, is it worth having a directory?
