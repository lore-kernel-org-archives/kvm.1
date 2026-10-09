Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2549B454;
	Fri,  9 Oct 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538000; cv=none; b=Jc3nOm+eUbK8nJngLkf52P+FveiBJoLHY0FPIHdFOkjAad6dSmBasVbJUw+0vMsjBqmcj5trRH+nUBERFxPcSdK4xNDjKSMNpkqnsMKvwLntspyrj/MfXRVjp/BZ85qPtyBdmUA0zFKf7JKNXJNozqSO8p5bTCqHsm2XX/i5d54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538000; c=relaxed/simple;
	bh=SzD40tpPB0O7va9u5M0rcTVlcocr7Ewc5wrILH5y8CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJLh7ExfiTpUUSM5rSMlzDajgLQJHHj+KFdjH1bMVcpETRSCfyLSKyeerzwUFExZJ6oz7TUdYxWy7UXyBJusurs5ePmuYqCpcpEPIbbfI3Wz6jvyaWe5UhVGiVw1X9LbiCIBnkn12UG3OCjVbH6QL+sDB350jmNmUgHOBDUK/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k018vT9i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k018vT9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791537999; x=1823073999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SzD40tpPB0O7va9u5M0rcTVlcocr7Ewc5wrILH5y8CE=;
  b=k018vT9iU9k2JfwIjjfq7NY7aZHLWTdbOAqcIQ32TZaVyAeO9R+GU0u0
   3g29SLB7Qx03i+0PauwpMZOON2ol7Vjh3Yf6+zWEDuU3vTDbl2Ub3iXWE
   Wd3yssLLBisvHFlAhf0u6bDJSo7g4EXDwP4V5jjlP3d5dXuLpWSE0kql7
   386no6Qnpl/qsHxTPryACD3C2ZpT4UQSIXWJsN+PPjIDCOrEfpBddLpqU
   ISlJGxpcn43TPtEFcMXWm6NhujsLgEK1oqWeA5ZnXIyKTVgd/gsd/5HEn
   XqQNeKHbYfdyGCbIx+M2rlJKu93BwMG7NkqPJWvQuCT32y3z2VcDGVH3Y
   w==;
X-CSE-ConnectionGUID: CpX88h5aTPedCIk2gxH1UA==
X-CSE-MsgGUID: mh0phpKpT4K3171ZjhlbvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="220874"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="220874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:26:39 -0700
X-CSE-ConnectionGUID: MFogRm3QQ+KQ68QV3Y5yHg==
X-CSE-MsgGUID: h4ImxuC5QRiy4xaZRJaRAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="375228"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:26:35 -0700
Message-ID: <f6bfb1f1-18ae-467c-86f6-8e15567281b4@linux.intel.com>
Date: Fri, 9 Oct 2026 17:26:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-4-binbin.wu@linux.intel.com>
 <d6bf5183b74b6c6f595001ee753405ea94a6042d.camel@intel.com>
 <4c553712-d2b3-44d5-9c09-ba51a5f3729e@linux.intel.com>
 <e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/2026 8:34 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 08:28 +0800, Binbin Wu wrote:
>> Xiaoyao mentioned it in v3 too.
>>
>> Sean suggested in v2 that "Realistically, CPUID.0x1.E{A,B}X are never going to be
>> repurposed to hold feature bits, and so generating a mask of allowed bits adds
>> unnecessary cognitive load and maintenance.  Ditto for CPUID 0x4, 0x18, and 0x1F."
>> https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/
>>
>> If we really have concerns, I can change it to exclude reserved bits in the next
>> version.
> 
> Could we check the x86 arch folks real quick?

Still waiting on confirmation.

But per the Intel SDM and AMD APM definitions, the following leaves/registers
are defined for specific metadata/parameters and should not be repurposed for
feature flags::
- CPUID.0x1.EAX is defined for Version Information
- CPUID.0x4 is defined for Deterministic Cache Parameters.
- CPUID.0x18 is defined for Deterministic Address Translation Parameters.
- CPUID.0x1f is defined for V2 Extended Topology.
- CPUID.0x80000008.EAX is defined for Long Mode Size Identifiers.

Additionally, CPUID.0x1.EBX has no reserved bit.

> If Sean is ok betting on this
> though, I'm ok too.

