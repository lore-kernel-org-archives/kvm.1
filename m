Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B552123C;
	Tue,  8 Sep 2026 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911669; cv=none; b=dsgJjUuAmDMBfAdAaxWBDby3EMRWRw4ydbZz+ka+CGBwSElDah4hbbJT7290Rgz78OcK+0cbix2Ob/8Sl1mQJvifzeKL03Wjdhq/8/kDjalFWNVUS4hrUHqeJRD2JJ4lJaCdMRRyoC/pHoLzoREP9cIIbyjHQq24rq8ahtKt+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911669; c=relaxed/simple;
	bh=3/7Q48b7XM0K3SPjK3OEC+OMjCBr7NtxS/ZSUE3iCvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyMhnTTjxDpVjS4HhZ4A+P4iJeke/QFR4XRsG0WBjnv3Z35dYCbwLlSZPHflYS5Hk5VeH4BpdO7JSdXn/l9adWmdeWu5ecF1Oc9YykMjPxfMH4jAy2wqDYTeYw7jRMuqUoL6uisl8NUoVt7pqE6IwdI9PZ5eGlVOb0ertNMKSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWjbz0MU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWjbz0MU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788911666; x=1820447666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3/7Q48b7XM0K3SPjK3OEC+OMjCBr7NtxS/ZSUE3iCvw=;
  b=PWjbz0MU6lLG+LzBDIqh0R0ycQnlNpjZbEwhWKAAy+eZLEqFepp6DLBg
   orBUJ6ZDCt5HKdHu/6PZGZAnEZJ20Ij4qFKkItPoQoJPrgTxlK61yoZIj
   7b6XSrVAWwk6JxIpmCN1JQoSAXHw9Jmf3A47PYjACugsssEfKS4hkWUoa
   LwMojfhLqrp9D6klgeyUyN8xnhRD4ayIGTihujRIupyiVqcYNpaInumL0
   hF/Fb17OvCj1CGPczOwuqZO3jIWmlMZJLwXeTyzNsaLPHrsgS87ro5o1H
   Dv6BSOV6JhMa7Re85bmYc4YQvIjx7Fx0YBDvswo+/g1kM8W3wnmHWEv21
   Q==;
X-CSE-ConnectionGUID: vf01wYO6Rw2lg6vi1ZzPpg==
X-CSE-MsgGUID: ocVVOqUCRICf9ZHFFa8otw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114869547"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="114869547"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:54:25 -0700
X-CSE-ConnectionGUID: a/Mg13ZUQAKdzSqaoMSArw==
X-CSE-MsgGUID: ItOs77eNTuq5qdhxwkY8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="276369758"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:54:21 -0700
Message-ID: <59626371-b9f2-4a8c-9c3f-ad7104b21dc0@linux.intel.com>
Date: Wed, 9 Sep 2026 07:54:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/2026 4:30 AM, Artem Bityutskiy wrote:
> **Disclaimer**: I am new to KVM and TDX, still learning, let me know if
> some of my comments are off.
> 
> It took me several days digging through docs and code to understand what is
> going on here,

Thanks!

[...]

> 
> CPUID_CONFIG is different: it lets userspace set CPUID leaf values
> directly (but not for any CPUID, only for pieces of it the TDX module
> allows, and KVM enumerates them via the KVM_TDX_CAPABILITIES ioctl).
> 
> That is the problematic part. KVM does not check its contents, beyond a
> denylist that only filters out TSX and WAITPKG features. Everything
> else is allowed.
> 
> So your patch-set basically kicks out the current denylist mechanism
> and replaces it with an allowlist of directly configurable CPUID leaves
> and bits.
> 

[...]

> 
> Did I understand your work correctly?

Yes, you understand it correctly.

> 
>> Expected host state clobbering behavior for TDX
>> ===============================================
>> We also want to call for discussions about the expected host state
>> clobbering behavior for TDX here for future features.
>>
>> For a normal VMX guest, VM entry/exit behavior for a given piece of CPU
>> state is architecturally defined: state is either switched by hardware via
>> VMCS host/guest fields, or left as the guest value on VM exit and managed
>> by KVM in software.
>>
>> For TDs, the host/guest transition goes through TDH.VP.ENTER, and what the
>> TDX module does with a given piece of host state is defined by the TDX
>> module ABI rather than by the x86 architecture.
> 
> I think I found this contract: the TDH.VP.ENTER definition in the ABI
> spec, section "CPU State Preservation Following a Successful TD Entry
> and a TD Exit". It refers to a table that lists the MSRs whose value
> may not be preserved across TD entry and exit, with the condition for
> each, e.g.
> 
>   IA32_PL0_SSP         Init(XFAM[11] | XFAM[12])
>   IA32_UMWAIT_CONTROL  Init(virt. CPUID(7,0).ECX[5])
> 
> This is from an older version of the TDX ABI specification. I could not
> find 'msr_preservation.pdf' published. But I assume it is published.

You can find these tables from the "Intel TDX Module ABI Definitions" part on
https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html
 
[...]

> So maybe the way to go is to just follow 'msr_preservation.pdf' and
> adjust the allowlist? I find this approach safe and acceptable.
> 

Rick explained the long history:
https://lore.kernel.org/all/58c185c82658819454a9950f37c6424226a098bb.camel@intel.com/

The Denylist based solution is not a clean solution:
- It couples the feature enabling for normal VMs with TDX tightly.
- Each time a new feature is added in the denylist, it needs to be backported to old KVM versions


> Artem.

