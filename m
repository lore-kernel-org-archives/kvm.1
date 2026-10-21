Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548930;
	b=RSHh0T0HEFakbeP737Ip2RcdRifc+qa4AbUqoevFbl5Se2bQdVNlcJr7y+CkzLhXKtCY
	 1ia8W431DdoaOSPVAmrLB42NbPFV/rQr5PBRxnGYqxC/sSoACiVhD9B/P+1f1WgEhB9QO
	 ZXBYezA0oFFwViQV3oRsYIK7GZcs117kQ+iy00PLWwn4D2PupNnW6DhWhrxb2a5sYUa1E
	 eAOahMDO1zK2t1JDRtLBhULmjlUNcVlM0YzZczURtK2ITQSBleCgwyTHXyqKrO+NAVsi0
	 pH/eUvEYzYJZpKbv2nbunso1vQQOcf91Kq6+oTubAxCSqyg/eRE4hMv1Yd6w0Y+eImA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548930;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vWSL3WpLIe7SVQgLo9oXjmDVD1e382DGADu0s5trDfg=;
	b=wFnXZ1W+bOrlaoU6wdeNQwHFaLm9dIkuKY2EQQ6x7fDcUhc3cCDv57eCPSd44TaXkwNG
	 lHIUvI5wmxms1slksoG9LIexaoI/fFagVOuaGPl7DljzmTLHWn21m10+fJY9sKpcM0aLo
	 BOSqGw8uOd9KWsbq1cc5tT/1HZN9wO4hYC9vZIHsb1M4eTCZsciEPDsPQHno+ovPInKvt
	 tX7BQ03TDWMmK1MdUYB4zD9kiagDUOhiDafcBTymBgna0OcIwxUGC7Lw54wA0gBGgixdh
	 27dXqFCxcsHKymp/+dGxwQYNE+9GYKZEQQesF47GjsjF4/ybzvl+p30GB5T5dXVz24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZm+HkhN;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07457606A31B;
	Wed, 21 Oct 2026 02:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07457606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZm+HkhN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792548930; x=1824084930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GwbCk1FYMKkyiRxBfhYZRnHktwNEciHd5WL6sXH36yw=;
  b=dZm+HkhNmQ5nF+yjYNIU32ZmqS+993Oib5M/1Yq8ZZPATDJhB/cBvs8l
   8uhgWQM8iux4ZAmA1oQSQAex7VEegyPNEywwKTJTCSko9bosKWpFjUMOa
   d5mw26BrrPr6ShjIwIhjrA7wix4AEsDoFWp7p512+rb2K8tNL9LY5LjEF
   feBEOg+Fe9YQ/NJM5byfScUpagi9qDeWl3097xtL36kE/U3+26F20Ic0K
   MOBuSMwbWTrpTmrqXdAB/aFfxLcmrDT7xJqhwx5PDdV6ETgjffmj1k79o
   mObdNyPZtzIHvtlGbzhIt7eUIR3z1esnTNtj4gEpdGYgEKubHtg+vSBXJ
   g==;
X-CSE-ConnectionGUID: w5RCwlLXSV2KHOKps0ogMA==
X-CSE-MsgGUID: Hi2QqD14SieDwmo+qAzzcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1280551"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1280551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 19:15:22 -0700
X-CSE-ConnectionGUID: e8hq6FNsRj28ZYynxkE2WA==
X-CSE-MsgGUID: mKBm2n/XTMCx9i+cyUoVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2914317"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 19:15:18 -0700
Message-ID: <2bc913d2-4286-4484-a872-3266326db0a5@linux.intel.com>
Date: Wed, 21 Oct 2026 10:15:16 +0800
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
Subject: Re: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-5-binbin.wu@linux.intel.com>
 <b69f075f475bb8c09c74cff621ae23f76da50795.camel@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b69f075f475bb8c09c74cff621ae23f76da50795.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/21/2026 8:39 AM, Edgecombe, Rick P wrote:
> On Fri, 2026-10-16 at 17:14 +0800, Binbin Wu wrote:
>> Note, the change is user-visible, as some bits that were previously
>> reported as configurable no longer are.  The ABI itself is unchanged: KVM
>> already filtered unsupported CPUID bits out of KVM_TDX_CAPABILITIES, albeit
>> via a denylist, and the set of configurable bits already varies with the
>> TDX module and KVM versions.
> 
> I'm not sure what this is saying, the change is user visible but there is no ABI
> change? Can't be both... so I think there is an ABI change.

My understanding is KVM_TDX_CAPABILITIES reports the capabilities supported by
the TDX module *and* KVM, this is not changed before and after this patch series.
ABI-wise, I think userspace doesn't care how KVM do the filter, denylist-based or
allowlist-based. The ABI requires userspace to consult KVM_TDX_CAPABILITIES, and
what KVM_TDX_CAPABILITIES report can be changed. That's why I described the ABI
itself didn't change.

How about simply noting that this is a user-visible change and dropping the ABI
part to avoid any ambiguity about the scope of the ABI?

> 
>>
>> The change isn't expected to break userspace or guests:
>>  - Userspace that honors KVM_TDX_CAPABILITIES simply stops setting the
>>    dropped bits, and KVM_TDX_INIT_VM still succeeds.
>>  - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>>    still allowed.
>>  - The dropped features are either obsolete or unsupported by KVM, and in
>>    the latter case, a guest relying on them would already have run into
>>    problems.
> 

