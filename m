Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5B370D61;
	Tue, 15 Sep 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458566; cv=none; b=hpzufyiIdigwvJ5pQxDqdbukTlcNb+kdxo3xSP3G3nYG6GINv7QzUnqKikg/EoET3lOSMDnilpSd7pqLSK5krr7i/YI3s/Nx9lgc8pDNGCfr0C1ZDwxxkG4ZRuL4QNbjR2vAp43eALNj0bG6aWeCx2d/lnGC6Q98vXaYQtklj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458566; c=relaxed/simple;
	bh=8pvbPSyUBoXoiNRSZd/AgneInHnjQJD4W+ps0lyWU/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BvVvUYR/LYMrH1qBhzd38j6nN5l5aqdlDuONDKwOCaH+lPdlgAjkysq2qyPnnc0vwzNaXcTofOejB4iIT4sQn4zWzBKcweDzZa1Bw8uXVFhMDgR+ScFvUjD1rjoloo4JUg501NBRqi1Dt+j/xC6OoT8Jjci4exHRJPaav42rTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EogKDIsJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EogKDIsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458565; x=1820994565;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8pvbPSyUBoXoiNRSZd/AgneInHnjQJD4W+ps0lyWU/4=;
  b=EogKDIsJlfaUY40AEPaunv3EJt5aAeYb8Jmb8dgbNNWwQrv8osZDeXIB
   CoSgLxJnSy8zefib4uM3Hdq4I+DlBECljForQ+rmG2vIAlCzN9RuGQs5o
   oJ7jsruyh9o4ZjLeuIMjPsgLh+wYpOakXuodVzhRAETm+LwTGoGdS/fRC
   9blaj8vUyM1YhQ+oS9KhTHyhe4croam7TRKD826fBhc0SRkhVbmeH4hUw
   7LGOpU2QjoiQ5QBprKtIpV64ekb88KJ09usRwBLQvUIVtebJVWzCKwPdP
   cBqWjSkt0jeZ5PCkvL5A3272er65JtCRL1rUqPkUFsbvK5dX2hwgEXcmc
   A==;
X-CSE-ConnectionGUID: ic8YrX2xSaO2j5tHy765GQ==
X-CSE-MsgGUID: FoTOmTOTQ7aKdMev2hJymQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89685533"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89685533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:49:24 -0700
X-CSE-ConnectionGUID: d21aHF9ATyu/oCW7FyCLlw==
X-CSE-MsgGUID: BIxnNc2CSwyPGCzolTatQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302770261"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:49:21 -0700
Message-ID: <8181bb5d-6081-4051-a083-24624d3bfdf3@linux.intel.com>
Date: Tue, 15 Sep 2026 15:49:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
From: Binbin Wu <binbin.wu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kas@kernel.org" <kas@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>, "Gao, Chao"
 <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <249dcccf2353181f595547d19a07232fded71023.camel@intel.com>
 <a018a58f-76af-43a7-930b-943a9a5c0a9d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a018a58f-76af-43a7-930b-943a9a5c0a9d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 12:25 AM, Binbin Wu wrote:
> On 9/3/2026 12:22 AM, Edgecombe, Rick P wrote:
>> On Thu, 2026-09-03 at 00:19 +0800, Binbin Wu wrote:
>>>> I see. You added patch 2 because without it QEMU breaks. While for
>>>> EST/TM2/SDBG/XTPR/DCA, QEMU doesn't break after they are turned to
>>>> non-configurable. QEMU cannot represent all the userspace VMM. It still has
>>>> the potential to breaks other userspace VMMs.
>>>
>>> I think the risk is pretty low.
>>> I am not sure if Sean could provide some insight about this in google's
>>> userspace VMM.
>>
>> Can't we fix the issue if we are wrong?
> 
> I think it could be fixed to add the missing bits (if any) as bug fix.

Directly configurable feature bits that KVM doesn't support for non-TDX VMs
fall into five categories:

1) Features that are forced to 0 when #VE is reduced, or they lack KVM's
   support for associated MSRs:
   EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A, RDT_M, TME, PCONFIG.

2) Features tied to MSR_IA32_MISC_ENABLE, whose corresponding
   IA32_MISC_ENABLE bit can't be set from a TD's point of view when
   TDCS.TD_CTLS.REDUCE_VE is set:
   CID, PBE.

3) Host state clobbering features that KVM doesn't support for TDX:
   HLE, RTM, WAITPKG, FRED.

Features in categories 1-3 should not be added to the allow list.

4) Features that are simply unsupported and thus don't need to be in the
   allow list:
   PREFETCHWT1 (Xeon Phi only), PSN (not implemented by TDX-capable
   CPUs), AMX-TRANSPOSE (never implemented on any Intel platform), and
   RAO_INT (defined only for "future processors").

5) Features that are added to the allow list via TDX_CFG_EXTRA_F():
   MWAIT, XTPR, HT, CORE_CAPABILITIES.

   XTPR can be exposed to a TD, but it never takes effect in the
   underlying hardware when the guest changes IA32_MISC_ENABLE[23].

   CORE_CAPABILITIES really belongs to category 1, but it's special
   because older specs defined it as a fixed-1 bit, so userspace VMMs
   may try to enable it based on stale knowledge.  Add it to the allow
   list to accommodate the legacy TDX module definition.  Reporting
   CORE_CAPABILITIES as directly configurable also lets userspace infer
   that the bit is no longer fixed-1, and correct its stale knowledge.
   Keep MSR_IA32_CORE_CAPS unsupported for TDX guests because existing
   TDX users have no guest access to MSR_IA32_CORE_CAPS.

With the features in category 5 in the allow list, it shouldn't break
userspace.

If no objection, the next version will still limit the allow list to the
capabilities KVM supported for non-TDX VMs, with a few exceptions listed
in category 5.

