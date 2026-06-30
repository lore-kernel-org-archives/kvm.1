Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D531813A;
	Tue, 30 Jun 2026 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785436; cv=none; b=GufeB+nVm5KdSlRCXbWczdBIJtXlgRxMCISuCxvw78zWtICyR+HAsMs8yPOtqOuo4PeMyBNtFYkJtg7SdxoWR1/27gi6GGbJ+9myXfL6Wq/0XAzSUoEIv+yok5PZwUZaF1Hu+M6AjaFJpM3dU1BsmkuoxtmRmXoTp9NYmGXAEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785436; c=relaxed/simple;
	bh=o5efQtV235L3o32nlkum+UJzJVvAbxafZRZseJv6NT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv4ZXFlzN6yF04W3MFKXKStQkabGk1wqtyg8ZdvaasxYS2Tq4ucLvOb4HgaiwdLOQP0A172UquaWRwO7FuMDlDeh/7Bxp3Exbc8yR03Luwdr8isllShykHj27tZDRdO4VHuKsJTnYXVF5BZWYi4uah7oSq43mY9wrNt81fxP8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jh2hzXQf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jh2hzXQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782785436; x=1814321436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o5efQtV235L3o32nlkum+UJzJVvAbxafZRZseJv6NT0=;
  b=Jh2hzXQfwCmVHsQvPt3xg0d85gU0lzgs73Ui5GxorDXrDt9AlUdrx8I4
   G2NHKcg5vCODWcZRI0AzE5xc7ijz5/hKxL5pjed7+Xd59Rxk+/os8UlUb
   5fSDGW3sNkv3uJzf51Olpzb4dIG73GqLVD+yEVIChZNXVQvMl0IBMYLQU
   ebByELBKh7Ijj4VIDuqKBy0RWhhYXjP91fS2k7Uoa32drICCeZVpPWFBk
   k6PaRKiKUBfQijU13BkiZfbsB+Xh6Q/L17Q35esPFR5NtAGm7cpzgLdHl
   Mryj5pzUasS26UX1Mim4lfwlcArMQ9o7i7B+SLJMWBHnlsKcUx6HtBiHD
   Q==;
X-CSE-ConnectionGUID: OxoCapZ3RGK0SWkz2rF7xA==
X-CSE-MsgGUID: XB1CT6/+TxqyZtLIZ4cE2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93847460"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="93847460"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:10:36 -0700
X-CSE-ConnectionGUID: KgvW21VHRXmdMx1njIDsWQ==
X-CSE-MsgGUID: yhHe7SdQS46Gb1vOMPeHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251071691"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:10:33 -0700
Message-ID: <632907b4-fc19-49d3-b2e7-8bb97d64df2c@linux.intel.com>
Date: Tue, 30 Jun 2026 10:10:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <20260604023314.3907511-2-binbin.wu@linux.intel.com>
 <aj1fi_0SBxMK5WOB@google.com>
 <e6515066-3768-459d-8ae4-82c0243556a1@linux.intel.com>
 <akMPwaQ9nFDnGbYg@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <akMPwaQ9nFDnGbYg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/2026 8:37 AM, Sean Christopherson wrote:
> On Mon, Jun 29, 2026, Binbin Wu wrote:
>> On 6/26/2026 1:04 AM, Sean Christopherson wrote:
>>> On Thu, Jun 04, 2026, Binbin Wu wrote:
>>> CPUID.0x1E is a bit different because it's kinda sorta a feature?  That one is
>>> probably worth restricting, but again that's easy to do in a case-statement.
>>
>> Only CPUID.0x1E.EAX has TDX directly configurable bits currently, no special
>> handling needed for the rest of CPUID.0x1E.
> 
> But isn't the whole point to guard against TDX Modules gaining support for features
> KVM doesn't know about?  What happens if hardware extends into CPUID.0x1E.ECX,
> and the TDX Module follows suit?

I meant for CPUID.0x1E, KVM only allows the known TDX configurable CPUID bits, i.e. 
AMX_FP8, AMX_TF32, AMX_AVX512, and AMX_MOVRS in CPUID.0x1E.EAX, which will be
initialized in kvm_tdx_cpu_caps[]. 
For others, it's not allowed via KVM_TDX_INIT_VM. If there is a unknown feature
bit, it will be rejected.
 > 
> I guess that applies to all the feature leaves?

I think the rules could be:
1) if a leaf/sub-leaf/register we are sure that it will never be extended for feature
   bits, as you mentioned, e.g. CPUID.0x1.E{A,B}X, CPUID 0x4, 0x18, and 0x1F, we handle
   them in case-statement runtime.

2) If a leaf/sub-leaf/register that could be extended for feature bits or already
   is used for feature bits, the kvm_tdx_cpu_caps[] holds the supported direct
   configurable bits. The userspace CPUID configuration input in KVM_TDX_INIT_VM is
   validated against kvm_tdx_cpu_caps[]. Any unknown feature bit is not allowed.
