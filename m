Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743084;
	b=wxnKsfCwxV0JF69R+H4KcYuyxa1bPtAL21YY7RI8dJnrEkZT2+5w2ztCkEGX5FqzCEXU
	 SZzpJSAHv/DFt7ekEi4LdQgpx3qnsFzZoNxqdK163nx9hELCoBmy34XiH1guIUUQc23v8
	 kDVOHynQzllL5Pr1Vt0TqB3f9cRU9BkisgopoYhcwEOQIIeH+BrDTQaRpt+67YByIOU6x
	 F0kf0zQPWZj4KxWddAiQltw0MNvFEJpDQ8xQ65U6Wx6UI5qeyqTfHiK0FXyeQzdh3KLTV
	 lOkQJXkQs4AFqqSS9uz0HT0ypebkpLR1gTOCwIeLlQpnHYzraGIeZzXtlw/2D8uiM8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743084;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dksq6JzYz/7e2KyIjNlZAHkwElyy14O+kTiWQeWvxMk=;
	b=wSVCRtQKv3stcF8JKxSyzFulXOXAg5M4CZYTqAJw/WWlX+XHrr48Q7SIstj6Nur9MEZs
	 zGfgtJ7F3SQGA6661Uby+v+18kifBMNMd1D8OStNK9udXlBDpjS9uOfjDWxGASyf9GnJc
	 /8tSvW28ZXkB4Vdz8OppLYKr+sAi904CSKEqIWD8tvkuY5p+7fBsD/E6iJ1DvDoTNf/W3
	 Sn67S3YfS1XAmk6A1/enHYeyPeMSQJVC/I1S9Sw6CDCxUEI9oEpJDA/EV1IbPvG7gWDw0
	 uM+WcasrRy0gnH4RZv/WSvXmBSogbWCjzo2StIy8yMD/vq98//i2bHUItqENYa9nqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="l/xJPrtU";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE9606A31A;
	Fri, 23 Oct 2026 08:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADE9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l/xJPrtU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792743082; x=1824279082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d56qZiErZsAL2brFzhSqUiWxNRHHzU79TQ7RquVyumY=;
  b=l/xJPrtUNzvk/IQJvxYvUg7Zcdwpt7BKgfEA34wgTzEzrQDt93MT+J4m
   DXFWENL53db/qgoMcBwk3L4nDMhXFUaCL0TxTrh+1Ezs6uI4H6jEhhZ1p
   53Wf3EhreTBdNG4ke4wF/NJMaesBWfBye3p6ULf6xOP+8a6upTqCbIeZn
   D9q0uy3VhBGUjFhDHNesOBxX/Ow/n69Eiy422+KSfX/so2cdTL7pUYO4V
   Hl6Ohql8LEa6QA1oVoGrTA0qSHXTEuG09jx2qz4lIuR75eEDDQddo2sQy
   apBYJwfBRukKsZo/gZCQJArJSzkYDOi9G9fhDZKuklgaZA4AejzgoCNVJ
   Q==;
X-CSE-ConnectionGUID: bq8Tsfn1TqORWNhI8SlqaQ==
X-CSE-MsgGUID: Ls54KNkKSjSL39F9GV2ylA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1504131"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1504131"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:11:22 -0700
X-CSE-ConnectionGUID: fPfiCPHqRzKnAvtn6QOc2A==
X-CSE-MsgGUID: EhMZgs2jTWmxsv8U5x2Lgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="5338267"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:11:17 -0700
Message-ID: <740e0e88-6353-4174-af86-c30b0957c056@intel.com>
Date: Fri, 23 Oct 2026 16:11:15 +0800
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
Subject: Re: [PATCH v2 3/3] KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID
 functions don't match
To: Binbin Wu <binbin.wu@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Changyuan Lyu <changyuanl@google.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261022210134.612848-1-seanjc@google.com>
 <20261022210134.612848-4-seanjc@google.com>
 <88de514b-8f83-4b04-82c8-caa6bd5ac976@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <88de514b-8f83-4b04-82c8-caa6bd5ac976@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2026 11:05 AM, Binbin Wu wrote:
> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
>> Reject KVM_TDX_INIT_VM if userspace doesn't configure the canonical CPUID
>> entries correctly with respect to KVM_CPUID_FLAG_SIGNIFCANT_INDEX to fix a
>> bug where userspace could bypass the TSX and WAITPKG checks by simply not
>> marking a CPUID.0x7 entry as being indexed.  This also sets the stage for
>> more in-depth validation of the incoming CPUID configuration.
>>
>> This is obviously an ABI change and diverges from KVM's general approach of
>> "let userspace do what it wants".  In practice, no "real" VMM that supports
>> TDX misconfigures a TD's CPUID entries in this way, i.e. the probability of
>> actually breaking userspace is basically nil.  And unlike normal VMs, where
>> KVM has full control and thus can deal with bizarre CPUID input without too
>> much fuss, TDX VMs require extra care due to the TDX Module also reacting
>> to the CPUID configuration, i.e. KVM_TDX_INIT_VM needs to be more strict
>> than KVM_SET_CPUID{,2} to avoid creating potentially dangerous-to-the-host
>> setups.
>>
>> Opportunistically rename the helper to make it more obvious that it's
>> checking if the passed in @entry is unsupported, as opposed to returning a
>> set of unsupported entries or something.
>>
>> Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/kvm/vmx/tdx.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 37d088f6f7a8..6abf92ffec24 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
>>  		clear_waitpkg(entry);
>>  }
>>  
>> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>> +static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
>>  {
>> +	if (cpuid_function_is_indexed(entry->function) !=
>> +	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
>> +		return true;
> 
> Similar to patch 2, if cpuid_function_is_indexed(entry->function) misses some function,
> the value of cpuid_function_is_indexed(entry->function) is not accurate.
> 
> For current code, it's OK, since all unsupported bits are in leaf 7.
> In the future, with the TDX CPUID validation patch set
> https://lore.kernel.org/all/20261016091422.3182216-6-binbin.wu@linux.intel.com/
> It still allow userspace to by pass some check in theory.
some idea.

If we decide to honor TDX module's report over KVM's cpuid_function_is_indexed()
in patch2, then how about something below:

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6abf92ffec24..1456f4c5c6b3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -151,10 +151,10 @@ static void tdx_clear_unsupported_cpuid(struct
kvm_cpuid_entry2 *entry)
                clear_waitpkg(entry);
 }

-static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
+static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry,
+                                          bool significant_index)
 {
-       if (cpuid_function_is_indexed(entry->function) !=
-           !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
+       if (significant_index && !(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
                return true;

        return has_tsx(entry) || has_waitpkg(entry);
@@ -2397,7 +2397,8 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
                if (!entry)
                        continue;

-               if (tdx_is_unsupported_cpuid_entry(entry))
+               if (tdx_is_unsupported_cpuid_entry(entry,
+                       tmp->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
                        return -EINVAL;

                copy_cnt++;
