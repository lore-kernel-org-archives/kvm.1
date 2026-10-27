Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071058;
	b=F2b+x9m9WzmR7zcd7GpFJb257w8LARX32SRX3K/uIEjFPPdNNrqgOHev+404Tx35725w
	 YD4z+GEIwubJ7WhIMn2H1HClTkY/phBtLEQ5vPA9935/EJf15jq3tKbp3DQoUo1qaVbq8
	 PdlXQj5ltDKS4Z6XLlexhP3zSLxH0CQ+kw7HFTk1euKsbtl+4fz+vLaS3fcvrQCVfcKCq
	 MmP0+3vnlYtLI6qhP1WQ44gjPTu1MevHbEMQY4NuDr3iPvb2Vtm1/6vkFp5YsSJ3EwUOY
	 yqc6hDcxKubFpKOOL9W7uDDkqZ/BktiRzNsptirqLjzyMRdyxSxru4JqfOpq21jiacA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071058;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wCiFxCAynyXnSTTLGPT7jyMrXA4PVBEFb+6sztVLjwU=;
	b=5BdgZ6YiCnD70XoEkfUWQHONUMcAGi9cowX4jw0/0gUB5AWwt9mg3+2R9+EVkVzHf+1O
	 pkAv2+hdbx6JfqSMvl7BPif2CRpSbvKw9tkFRKQmz8wFC2Fl7jQGn2APhJ1+aQtSH8R6t
	 2HkoysmKRO+mww2MlAglee1dTP+/bFGqnb6LQ3P4UrV0BWgrtICl6OxdYNzgrQk6/JrnH
	 +vBXV/wcNkMLxkvYr8aNTgqL4A9I/pYwQIPW6iGn7GVz6ck9cexz7oCjuDNEr3TAHe+n1
	 O70GEZVYuMOovNXEI8qGtjKCsNfmgEdzBbvoe3tz+YDgAlAxu9c4v88b8XTdBgfj/Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJVqsuXS;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A001606A31B;
	Tue, 27 Oct 2026 03:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A001606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJVqsuXS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793071057; x=1824607057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H0mHch+7v56HsTbVAWQ3ahM8VZpeCCFPBT7Gdamg36o=;
  b=KJVqsuXSzh8hvhBr8Fqy/9B43Voz0UB7wZzNk2RwNTcVScznFql0x5Nl
   5T8zpo9Vua9/bkCWbB9GiKOuj75K43KSx4WglT4vdLplu8YDDfl3R8aWC
   XAMDNvVfPPY5jd8XVxVLlrXFtQI7fRV3KnZzHQ9TcelSdwJbVOYM/ydZd
   lPo3JvpSHHpK8lXUXVV38nsjji71LtUlXQxO3SyVRX6nvKMKf20Ie4z+c
   81Oc+TVfQSdEdBmVk3tmP4sMX1MwK61aVfdp1v1Kv2chArS0uFoPul/Ue
   3PS/amNK+w8+XbHu7APgOyy98FpNmBMwJIp3ZOito/GOysmEgnjZNmbyK
   Q==;
X-CSE-ConnectionGUID: T5nxEb80SmarntBfwdGTQg==
X-CSE-MsgGUID: KLVSbj/3SrmsVS3Ff4+vxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1790350"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1790350"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:17:37 -0700
X-CSE-ConnectionGUID: R3kyZcwAQVqMRDm7Z1p+RQ==
X-CSE-MsgGUID: KrkGFevJQY6Q6syOFcp6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4774504"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:17:33 -0700
Message-ID: <c2fbd673-6f2a-446e-b5d3-04a97bb86930@linux.intel.com>
Date: Tue, 27 Oct 2026 11:17:30 +0800
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
Subject: Re: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID
 bits
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <fe3eaf31-acc3-4132-b768-9451c00aa746@suse.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <fe3eaf31-acc3-4132-b768-9451c00aa746@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/2026 1:43 AM, Nikolay Borisov wrote:
> 
> 
> On 16.10.26 г. 12:14 ч., Binbin Wu wrote:
>> The TDX module reports a set of CPUID bits that the VMM can directly
>> configure for a TD, but KVM cannot blindly expose all module-supported
>> bits to userspace.  Certain features imply additional architectural state
>> (such as one or more MSRs) that KVM must explicitly manage across
>> host/guest transitions to prevent host state corruption.
>>
>> Today, KVM hardcodes a denylist to filter out host state clobbering
>> features that KVM doesn't support.  However, a denylist doesn't scale as
>> the TDX module evolves, i.e. host state clobbering features added by a
>> future TDX module are not covered by the denylist, and userspace could
>> enable a feature that KVM doesn't support.
>>
>> This series builds an allowlist for directly configurable CPUID bits, and
>> filters and validates userspace input against it, so that newly introduced
>> TDX directly configurable CPUID feature bits can only be enabled by
>> userspace after KVM explicitly opts in.  Except for a few fixed-1 bits
>> required for basic TDX support, host state clobbering features are either
>> directly configurable or gated by TD ATTRIBUTES/XFAM.  KVM already
>> validates ATTRIBUTES/XFAM, so the allowlist only needs to cover directly
>> configurable bits.
>>
>> Patch 1 is a standalone fix for the existing denylist check, which uses
>> the index of the matched userspace entry instead of the subleaf reported
>> by the TDX module, i.e. userspace can bypass the HLE/RTM/WAITPKG check.
>> It is tagged for stable so that it can be backported independently of
>> the rest of the series.
>>
>> Patches 2-5 build the allowlist, add CORE_CAPABILITIES to it, filter
>> KVM_TDX_CAPABILITIES, and validate the CPUID input of KVM_TDX_INIT_VM.
>> The last two patches are user-visible changes, which are now called out
>> in their changelogs, along with why existing userspace and guests are not
>> expected to be affected.
>>
>> For this version, I'm hoping to continue to collect some RBs and Acks.
>> The key discussions from v3/v4 [1] are summarized below.  Note, FRED KVM
>> support is in progress upstream [2], and no TDX module with FRED support
>> exists yet, so there is no immediate issue.  But it would be nice to get
>> this series merged sooner rather than later.
>>
>> Discussions from v3/v4:
>> - Rick asked whether the assumption that the reserved bits in
>>    CPUID.0x1.EAX, CPUID.{0x4,0x18,0x1F} and CPUID.0x80000008.EAX won't be
>>    used to enumerate features can be confirmed by the x86 architects [3].
>>    Confirmation is still pending.  Per the SDM/APM, these leaves/registers
>>    are defined for specific information (version, cache/TLB parameters,
>>    topology, and address sizes), so the reserved bits are expected to be
>>    used to extend the existing information rather than to enumerate
>>    features.  Allowing these registers in full is a best guess, but it's
>>    still far better than the existing denylist-based check.
>>
>> - Whether to restrict the TDX feature bits to kvm_cpu_caps[].
>>    The conclusion from the discussions is to construct the allowlist based
>>    on kvm_cpu_caps[], plus a few bits that KVM can support for TDs
>>    independently of kvm_cpu_caps[].  If TDX feature enabling turns out to
>>    be consistently blocked by non-TDX VM enabling, a solution can be worked
>>    out then.
>>
>> - New opt-in interface vs. backporting.
>>    There are two options for old KVM versions that don't do the filtering
>>    and validation:
>>    1) Add a new opt-in interface to expose features newly introduced by the
>>       TDX module.
>>    2) Backport this series to LTS/stable branches.
>>
>>    The opt-in design vs. backport decision is deferred, since this series
>>    is correct and an improvement either way.
>>
>> - Potential backward compatibility issue when an effective fixed-1 bit
>>    becomes directly configurable due to x86 feature deprecation.
>>    This is left for the future, i.e. it can be addressed if and when such a
>>    deprecation actually happens, e.g. by adding an opt-in interface to let
>>    users/admins choose between migration flexibility and backwards
>>    compatibility on old platforms.
>>
>> Changes since v4 [1]:
>> - Split the CPUID entry index check out into a standalone fix, which
>>    allows it to be backported to stable independently of the rest of the
>>    series.
>> - Exclude XTPR from the allowlist, as neither TDX nor KVM actually
>>    virtualizes the feature and guests don't need it. (Xiaoyao, Rick)
>> - Rename TDX_CFG_EXTRA_F() to TDX_CFG_INDEPENDENT_F(). (Xiaoyao)
>> - Fix AMX_COMPLEX to be added for CPUID_7_1_EDX instead of CPUID_1E_1_EAX.
>> - Drop the descriptions in the TDX documentation and the uapi header, as
>>    the ioctl interfaces for KVM_TDX_CAPABILITIES and KVM_TDX_INIT_VM are
>>    unchanged by this patch series.
>> - Improve changelogs and comments. (Xiaoyao, Rick)
>>
>> The series follows the CSV version of the CPUID virtualization document
>> from "Intel TDX Module ABI Definitions" [4], updated in June 2026.
>>
>> AI tools were used to:
>> - Polish the cover letter and commit messages.
>> - Do code review.
>>
>> [1] v4: https://lore.kernel.org/all/20260917072548.2314491-1-binbin.wu@linux.intel.com
>>      v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
>>      v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
>>      v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
>> [2] https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com
>> [3] https://lore.kernel.org/all/e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com
>> [4] https://cdrdv2.intel.com/v1/dl/getContent/795381
>>
>> Binbin Wu (5):
>>    KVM: TDX: Check unsupported CPUID bits against the TDX module's
>>      subleaf
>>    KVM: TDX: Track configurable CPUID bits allowed by KVM
>>    KVM: TDX: Add CORE_CAPABILITIES to the allowlist
>>    KVM: TDX: Report only KVM-allowed CPUIDs in KVM_TDX_CAPABILITIES
>>    KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
>>
>>   arch/x86/kvm/vmx/tdx.c | 258 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 231 insertions(+), 27 deletions(-)
>>
>>
>> base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
> 
> 
> For the series:
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Hi Nikolay,

Thanks for your reviews!

I noticed you later gave separate RBs for patches 2 and 3. Is that because
patches 4-5 conflict with Sean's series [1] during rebase?

For now, I'll carry your RB only on patches 2 and 3 in the next version.

[1] https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com/

