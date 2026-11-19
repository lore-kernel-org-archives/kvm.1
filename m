Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111825;
	b=m13IbcZEO1Jmmi7M81SNEFRYie9efH06nCZuwXL8Nmufyd3r6KZuqU5gpEG+JatcSyRA
	 5hc507+jGZJU2xC7M2zJlgMihWUSokgpbvDbB7pSzyDRbTcapIRpVbL6azO/PN4suvKO6
	 kdBCVy5/InePXw1MloQuonkwSaOOjsxBjXnjKy490WrOIp1TBd+T/0xok6InUw9mTZre7
	 NhpWbhkjkWH+T0mI7USy77ziwK0i/rAmYCtlOefTIBD4dN4hF2M2Cp2f/+D/66zt/Twyy
	 ZLamIgC6KU6GSUkENQR/YUQ0sYHpZDZ3molgqt0mJNtrJomgOw0nh51mrAbWwcjpQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111825;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AJP2Rdfb/1/jgZJgZybKKFbo5ZXlPiUcwYvzFJMOVPQ=;
	b=t8eauOSAcA0Ujs920iKRu8fn73XL6z0V9scOUJfPVOMCgupRoAxWaLPMqvGNS2Pt7Znn
	 Dhqtpcnx0qrnQYrgh6ZnUAGe+hK9J5GxPDZ70h6UNBskExELHTCf+WbnnIOH0T0GoOzdQ
	 53mlejtXPZZ/x5usexa3J1fUb0jiSQmSQWyH0FtHGsetw7+vG2tBW0CBfxACT2K8S+aN3
	 CZEvwGAmtncL553yGmepzIj3baWBohqgB4sK9wZS0AbuuCSAksOI7lsjExLVQ13lZRU4K
	 xQvfGf1zcblaXRWI3rOBY3NRvd4H9zRrUSQ6VNISikJBAN4yesmWVyhaVjk21JtocNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LuLhOGzU;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66370606A324;
	Thu, 19 Nov 2026 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66370606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LuLhOGzU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795111826; x=1826647826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/K+h0XAbvgnld2iWah2eSuvOqFYOUxj/pEOeu3WiHmg=;
  b=LuLhOGzUsxWnNof6Qy81/h4B/VY0mUZwG29x4q+O1FcGEIDkfXV8uTMG
   Z6rbY3w7gmNyne75jZ4T+z1nsCs8/bi++MavLVlMj5R/zuk9rqnh6Uxs+
   ICsyp5jDpYZoZyXs8FpqF4SC2MUjiGpFPrtX/BuQyGitxKWqBQXLVTEc7
   EtBxIJ1QpPfofwq/DRysDuKWur1/NfMSz2jphHu0TcG6geMz6kAvOU0dn
   H6Bbe5GREMc57gqpI+79vr4JAZxpXI6VlmjN8u5+DgZYoE39gwt+FKpLL
   Kj+CrhLjQdkVQ70d2cpwKfuEp+Pvpj8+8oK/mVJAw5tLyOnLPNgNhhOj3
   g==;
X-CSE-ConnectionGUID: fmtKimZ8TBK2Sv9D9Fvgug==
X-CSE-MsgGUID: XKQGuMZBSPevl0LGzsymzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3968061"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3968061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:10:24 -0800
X-CSE-ConnectionGUID: soM2pdXMTxaiS4gLC01Xyw==
X-CSE-MsgGUID: DuWx02lzRSGVyWOEwwWUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10525331"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.68]) ([10.125.109.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:10:23 -0800
Message-ID: <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
Date: Thu, 19 Nov 2026 10:10:19 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: yilun.xu@intel.com, arjan.van.de.ven@intel.com,
 binbin.wu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
 <20261119074925.3933804-2-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261119074925.3933804-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 23:49, Chao Gao wrote:
> TDX module binaries are limited to just under 2MB. The binary is handed
> to P-SEAMLDR as a list of page physical addresses in
> 'struct seamldr_params', and the list must fit in a single 4KB page
> along with a few other fields.
> 
> TDX modules are gaining features and are about to outgrow that limit.
> 
> The P-SEAMLDR ABI was extended to let the list continue onto more 4KB
> pages. The last u64 of each page holds the physical address of the next
> page, chaining the pages together.
> 
> Grow module_pages_pa_list[] so that 'struct seamldr_params' spans 16
> pages, and chain the pages together in populate_pa_list().
> 
> Each page uses its last entry for chaining, so the maximum module page
> count is the array size minus one entry per page. The user-supplied
> image is checked against this count.
> 
> The 16-page size is somewhat arbitrary. It fits modules of up to about
> 32MB, far above the roughly 2MB of current modules. It wastes 60KB for
> today's modules, which is fine because the memory is freed right after
> the update.
> 
> Do not query P-SEAMLDR for chaining support. Userspace selects the
> update image and is responsible for ensuring the module is compatible
> with P-SEAMLDR.
> 
> A 496-page module (the old maximum) used to fit in a single page. Now
> the last entry of that page is used for chaining, so the final address
> moves to a second page and the module requires chaining support. Do not
> special-case this size to make it work with a P-SEAMLDR without
> chaining support. No released module has exactly 496 pages, so nothing
> breaks. Leave it to userspace to ensure any future 496-page module is
> paired with a P-SEAMLDR that supports chaining, as with larger modules.

This seems to be getting worse, not better.

Maybe I'm being dense, but I *still* don't have a clear picture in my
head of what the before and after data structures look like.

> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128) / sizeof(u64))

The "128" is a hard-coded struct offset. To me, that's a big
anti-pattern. Use the structs themselves.

I'd suggest a way to do it if I had a clear picture of the data
structures in my head, which I don't at this point.
