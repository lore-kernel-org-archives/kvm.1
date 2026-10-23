Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741722;
	b=C54VyTXKW41se9Q3wCASflepLimTcrpf9Rkb1ZJhaG2SF/YDKqscH0j76kgLSWE8ef1G
	 o5RUaxhLO6GPeGyAXM8NX6dCGNJRRrRICdDMTI649U+zUwPjjZl/x0k5WgzGdrlNaOmS0
	 d1atQFyWquc77gmYa7AKo6p4cjOqCimcAJXccw3yMG1KsMuIMJlpacyomMrrUJTXwYmdI
	 ss62LGtNyDuYUBEi87YDHjub8hxi+5MxLfhhpkS+GQWZAzx4nkvc0gLiSW65JwCTS/lRU
	 yKZBTCgLAff0C1vtfPCsegQDnYo24H+ZeV1ERkDsCY+yj9CrESWLZgWIJVDg1+LQBsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kCXh2oDjH/A1io1ORY6LGi5YogsdQ2XuNDg1UcV9zcw=;
	b=lFfc/D5MR0mfClfy7I4VDCZr8XQsX1GKBhtx4EjbWayIO1g7Hwf4h608QA5mBawxpIF+
	 S8wZp6WvdkjFq4C+IrfJDrpUbQMiJ4RAYkxNhU6kApdK20CYMbCnu4i9PM0TcrtkFrB1C
	 x8fuXaDpHOZ3m3SN57ZeGtQyY+NI1GczxCQzxk4uEko222n5fYaIZc8bqyAFZgPfuKxvj
	 pJWKGn13tnX3KXQUKyuNNVXkWaI61ZkrDYkHgEkPmdztQ3tHU6dAs/oxzqsTfi2VbZQMf
	 Qr2y/F0ZXaI+FhjsOjgw/Zghv5NnwvUpa9zbx/7ubjWgtoJY4ma99SqPwOaHrhRs1Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mq6AkRAf;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDD606A323;
	Fri, 23 Oct 2026 07:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFDD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mq6AkRAf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792741721; x=1824277721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RtHqdgs7UC+ZyhjISUOhpErEV8soAVYG+qBVpUJqxrU=;
  b=Mq6AkRAfk0aDyyPwWJpSrODK4s+1/wnesrkM1SKz1rNLk/SGvQExwFr+
   CvryssFY07Y8QPoO12yPxHmJZscrfhOrnq7WzrFuNdxLvvp5T5X3pwwOk
   3eAoAjXvPlid0torvmq9MpB2Xxn1Q+QEASZBW3xvShTBuWIepWpqrjv6/
   SdQ+nhD9I0eYZqok59vDofUYeyLSvyZ0VvIjXb8mgaJbGxWB4ypjeHq/s
   42r2yDgcV+UDkGfVoL/5NuTgT7ET5Q7hbWdUmUpLdqRB/iyog4KFqdVLt
   ogi5tAMrgTxLMCC+9+rnRyVOwPgV3mG2E+iJKkmRYvm0mK3hkJ7dQwsK4
   w==;
X-CSE-ConnectionGUID: 4vXwI3nQQoCkdaGWlouh2w==
X-CSE-MsgGUID: n+4wUPdITueRp/Djfq2PUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1375153"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1375153"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:48:41 -0700
X-CSE-ConnectionGUID: OMABvHiKTyOKnZK+FBZ+eA==
X-CSE-MsgGUID: EPT3PLknR+Wcfh0zVLJsew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="4059051"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:48:38 -0700
Message-ID: <f5832f98-5aa5-4e97-841f-44ae6accf397@linux.intel.com>
Date: Fri, 23 Oct 2026 15:48:35 +0800
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
Subject: Re: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
To: Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com,
 tony.lindgren@linux.intel.com, kishen.maloor@intel.com, dedekind1@gmail.com,
 adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-6-binbin.wu@linux.intel.com>
 <32413bfd-a448-483b-b2b5-7f4ff6cbc56a@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <32413bfd-a448-483b-b2b5-7f4ff6cbc56a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2026 3:46 PM, Xiaoyao Li wrote:
> On 10/16/2026 5:14 PM, Binbin Wu wrote:
>> Validate the CPUID configuration provided by userspace through
>> KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
>> denylist-based check.
>>
>> The TDX module lets the VMM directly configure certain CPUID bits for a TD
>> at initialization time, but KVM must strictly govern which of those bits
>> userspace can set, otherwise a feature that clobbers host state could be
>> enabled behind KVM's back.  The existing denylist rejects only TSX and
>> WAITPKG, and thus would accept any bit that a future TDX module makes
>> configurable, even if KVM knows nothing about the associated feature.
>>
>> Add tdx_has_unsupported_cpuid_cfg_bit() and reject KVM_TDX_INIT_VM if
>> userspace sets any bit outside of the mask returned by
>> tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
>> KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
>> the bits that the TDX module reports as directly configurable, as the TDX
>> module itself rejects any bit outside that set.
>>
>> As with the existing check, use the subleaf reported by the TDX module to
>> look up the allowed mask.  For leaves without subleaves, the TDX module's
>> "no subleaf" index is normalized to 0, which matches how such leaves are
>> tracked in reverse_cpuid[].
>>
>> Note, the change is user-visible, as KVM_TDX_INIT_VM now rejects some
>> input that was previously accepted.  The ABI itself is unchanged: KVM
>> already rejected unsupported CPUID bits, albeit via a denylist, and
>> userspace has always been required to consult KVM_TDX_CAPABILITIES and set
>> only the bits reported as configurable.
>>
>> The change isn't expected to break userspace or guests:
>>  - The newly rejected bits are no longer reported as configurable by
>>    KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
>>    won't set them.
>>  - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>>    still allowed.
>>  - The dropped features are either obsolete or unsupported by KVM, and in
>>    the latter case, a guest relying on them would already have run into
>>    problems.
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> 
> The patch generally looks good to me. However, since it depends on Patch 1,
> which, I assume, is going to be replaced by Sean's series[1]. If that's case,
> the patch will need a rebase and adjust on top.

Yes, it will be rebased.

> 
> Free feel to add
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

> 
> if there is no big design change in the end.
> 
> [1] https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com/

