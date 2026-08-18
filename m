Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0522083;
	Tue, 18 Aug 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043492; cv=none; b=uZxBrYld+H7wm44qJ5Tam95vNfGUlvXYPfyjfQvLllCqVsXooJ3MH/O4ZA9JDgoPAkCK1rCEjVi5hFIEP1//uBvhSOUSnR31eMec4J9iq1dRuSg4vgZewQcoNyZmKVDL3kNqf9DKmZn2a1FUUEp321JeOlNtn7rjzthJrJ6b7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043492; c=relaxed/simple;
	bh=s8QPoZeTdHsCFYNh+MTt41Wtc0CpOEG8FMJtXi4o9yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgOan5uStVBGUlZeMY7thymhhnzludDLgEftfPJ6kO7pExp/cax9NRrTNtdaJsBS80cUyeK9Zi5xLCKv8mhptMJ8GUILjxKFrJygP5lmRlmKMm8ROYbcoYlCk3JZs6LcSEN/0j27j/hfPLld84yPu3q0AzUNju4Gl7LqO0vjBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXU3dhhL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXU3dhhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787043491; x=1818579491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s8QPoZeTdHsCFYNh+MTt41Wtc0CpOEG8FMJtXi4o9yI=;
  b=PXU3dhhLB4jYQCq44Im/81jH50z6xMJODbCsW1YztpLxoO0kySQWt76S
   vM52kwxc52XJtRTLMIGhPJevHo4J4utG3csIqXQNMgHgCiiUbigza8iKr
   dSuczd/AQ/PqFR5q08vX/1cJrZ2NtckKxkqBwzHVmjnFTwLkWocCJV1pV
   RYj+0ww/I3hAfekS12sCRtgQe9O6DXXApWnu75ufoJFY92TMOEA9ERCpB
   qZS7h9/sC8RVGCGnVSHK+zAPEYdTF39F3Bl/caAmv7ZSukPbaZWD2/f6u
   0ZiesKewrAkFzHeHyHNgfN6l4ALnpp5fujl2jIuxTQQIPeayps8b3c9Kf
   Q==;
X-CSE-ConnectionGUID: 8eGyKQBHRPqdiiQ+UpTXUA==
X-CSE-MsgGUID: 8eF+rMYlRo27C6ZZQqj/lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86647299"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="86647299"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:58:10 -0700
X-CSE-ConnectionGUID: 3R+oDGB9StubpCD+rzFXzA==
X-CSE-MsgGUID: KfLQpcxRTAWhGoyuvhMgtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265201590"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:58:05 -0700
Message-ID: <8bd8bb3d-2038-4704-9d39-486093391af9@linux.intel.com>
Date: Tue, 18 Aug 2026 16:58:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-15-15ad654a50db@google.com>
 <31ddbd64-eeb4-4008-87fb-ff57de93635d@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <31ddbd64-eeb4-4008-87fb-ff57de93635d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/2026 4:32 PM, Xiaoyao Li wrote:

[...]
>>   +static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>> +{
>> +    struct kvm_cpuid2 *cpuid;
>> +
>> +    cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
>> +    tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
> 
> If I remember correctly, though KVM_TDX_GET_CPUID is a vcpu ioctl, the data returned by KVM is retrived from TDX module and TDX module only maintains the TD scope CPUID.

KVM_TDX_GET_CPUID does return TD-scoped CPUID metadata only.

> So the CPUID returned here is TD scope, for per-vcpu CPUIDs, e.g., x2apicid, we need to update them accordingly.
> 
> This seems not a functional gap. I'm OK to leave it to the future, but please leave a TODO comment for it.
> 

The handling for legacy VMs is similar, i.e. kvm_get_supported_cpuid()also has
no per-vcpu CPUID info like APIC ID. It seems that KVM selftests doesn't test
CPUID topology enumeration.

A comment could be helpful, although it may not be a TODO comment.

