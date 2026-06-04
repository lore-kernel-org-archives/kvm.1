Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A837CD32;
	Thu,  4 Jun 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557624; cv=none; b=UiYW4aCv3bcdfzN2r6NTTjamtoOsuwlGJNYR9ya0uEdLLdb8DNFQk6bNjT2Ou4hFqMEagexHd9zxoBHkcvCXTVLuJdIM35xeO7+j8PGuzRVp8oYRxKRiOaLHZ28zTja5hKlX4P6amhgCa3HJ4sczUzp3C9Wb2RssBpYadqg0O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557624; c=relaxed/simple;
	bh=+uJNHgFWw32KJn+Dd7evwkhd1RVCZfNmZgMtwDgY/EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbRp1OSgrZdduYOIx3vC6psL56hUfMBXKfnazeKdBE5yQ8RDYUq+S03OIS/kkND83AGVzXcxssjYqpG+1EZbHXxnC1WOu2WZbQivXY2yk12UFO1KtQ2jhv5vrgUEnUyhOV5nlXni2wdQUd3xN8Ipd7+gRWOrQ3JNHV7NFRSzLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjMSbKs2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjMSbKs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780557623; x=1812093623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+uJNHgFWw32KJn+Dd7evwkhd1RVCZfNmZgMtwDgY/EY=;
  b=ZjMSbKs2bnqJl/i6FEsdhPgw5Ep3m1J+AdMZfNvq/fcXU0ZzOTFad/Wr
   E57lchreOdjVQ2ABrmPL+Rq4iHr2ROnOFNxgPCf7Ttvjxb40ziXCd2voh
   nKyNIKs6Mqn/qkv4ilvO7mqmbrnKv6P4iVWGWVL3DIpg4UwJo8Um5P4QU
   y48kwjwCrHGsR611XhFxfzGjfGuFoBS+CAWH3tzVc+LcYKDlVUseWusmF
   N4DkSiCCYvdwNrSnlmNvG2uI/cEjUuewRAsuHPcply34j3VNHeJm1e70o
   o+yYiRFq+PM/ik4qpvCVuLORcqZ3WiV96SWGSpRuBH2SKbLU0pv4ckHyy
   Q==;
X-CSE-ConnectionGUID: 5ff5T1H+TWmKDXpCAeIboQ==
X-CSE-MsgGUID: GI1YWSz4SlO5zNTIm0AKyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92751770"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92751770"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:20:22 -0700
X-CSE-ConnectionGUID: D008F64YSh+QNDdzXWub0A==
X-CSE-MsgGUID: 5xcgOHJ6TbS38DYDCFwIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="248410251"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:20:21 -0700
Message-ID: <014f4cee-8865-4767-a460-d991a7a67448@linux.intel.com>
Date: Thu, 4 Jun 2026 15:20:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as
 supported
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, rick.p.edgecombe@intel.com, chao.gao@intel.com,
 kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <20260604023314.3907511-5-binbin.wu@linux.intel.com>
 <883588d1-27a2-4874-b832-5b1b62db3cb9@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <883588d1-27a2-4874-b832-5b1b62db3cb9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/2026 2:53 PM, Xiaoyao Li wrote:
> On 6/4/2026 10:33 AM, Binbin Wu wrote:
>> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to the TDX configurable
>> CPUID allowlist to accommodate legacy TDX module behavior.
>>
>> KVM doesn't support MSR_IA32_CORE_CAPS, however, some older TDX specs
>> define CORE_CAPABILITIES CPUID bit as fixed-1.  As a result, userspace
>> may expect this bit to be enabled in the TDX module for TDs.  When the
>> CPUID bit becomes a directly configurable without reporting to the
>> userspace, it can not be enabled.  To avoid confusing userspace, report
>> CORE_CAPABILITIES to userspace via KVM_TDX_CAPABILITIES.
>>
>> Although KVM could determine the real CPUID setting by reading the
>> metadata via SEAMCALL after KVM_TDX_INIT_VM, doing so is overkill to
>> cover such a corner case.  If CORE_CAPABILITIES is exposed to a TDX
>> guest, and the guest reads it, simply return 0.
> 
> shouldn't this patch be put as patch 02 instead of 04?
> 
> Patch 02 and 03 in this series break the old QEMU and then patch 04 fixes the broken. This is not friendly to the bisect.

Good point.

I will reorder the patch in the later version if the direction of this
patch series is acked by maintainers.
