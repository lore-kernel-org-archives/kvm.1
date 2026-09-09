Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AB52FE41;
	Wed,  9 Sep 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951569; cv=none; b=a23eIAhlhLfEY8IXMIhg9tfI0aZngebDq6d3xeHp2Tt8z/WiCcdGhayHnKkzVfzmXEAh/CIGz4McDKeAniPUw9AJ+t9NhlO7Jm8ZtUk/Nl+wGWBE8aCZreBW8KoWwGOaOV5eysUyVVHTmwBQy54qyNxnMxw3CJ7lr8tfhFfokm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951569; c=relaxed/simple;
	bh=+Tu/O72827ZSBH3csRuI89G55OIjDCt8XGGxw+E2AAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBwoEyuSN0bX5PDYv1iTe/3dPwfr7uMJulbI4qlpPdVifUIFXudXkCCqQtXAaXk0ngM9gCsnq0nWbFyetwCEYYW07tLg3P1soxVQ/3Eqbyk6ReiFmvBHwJoDbutRVCToLVyIT+/yaLR5nDjvUrtMsHSnV5FtfnyAanur/uyO1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0PDd/CS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0PDd/CS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788951567; x=1820487567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Tu/O72827ZSBH3csRuI89G55OIjDCt8XGGxw+E2AAU=;
  b=T0PDd/CS9Esf0xBYMQS5kPsYPPKV7joPQDBKr5Ns0ZSGlx5lv+QLO0wh
   U5my+1YwoteVVelDv6b3fzEiDV9kVxnskkMlL6Pqs1I5aJJMETxA3KAWY
   Ep7WPrp3eQO31NuWhF37JuRb+/1orf9E0NV52Oggx4JbctvgtZw9zxywd
   RGhIszm0rsr2u1n7EnfuR78xekJGcefdzgEOOHaSG05W8F/AaB6uWvw1Q
   Fp8NeUwfzkZsKUG2K51gklUUTlfodkBNdcVFkBnXaiGHsSFJhVVP2UFeS
   GvSQxOoHJJGHtr5pcxN+UeVSGw6Wj/LFaN0EWLz+v0uYlWxa3LUr5eH5o
   g==;
X-CSE-ConnectionGUID: YSC4YB7DSFWLCrIBTY9ISQ==
X-CSE-MsgGUID: xwe42HPQThOXodOrVtUfAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89298546"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89298546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:59:23 -0700
X-CSE-ConnectionGUID: 9Byf6zvYR8OU4EXO2+AkNQ==
X-CSE-MsgGUID: QRSdUOmUTxuJX9zEK3/LHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267001320"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:59:17 -0700
Message-ID: <f16e1c13-b959-4085-bf4a-9e583d149e93@intel.com>
Date: Wed, 9 Sep 2026 18:59:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
To: Sean Christopherson <seanjc@google.com>, Peter Fang <peter.fang@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
 <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
 <20260828020612.GF33657@pedri>
 <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
 <20260828042044.GG33657@pedri> <apGYxwdCSuC-X732@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <apGYxwdCSuC-X732@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2026 10:18 PM, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, Peter Fang wrote:
>> On Fri, Aug 28, 2026 at 10:31:14AM +0800, Xiaoyao Li wrote:
>>>>
>>>> Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
>>>> with the same architectural approach. GPAW is available through
>>>> TDG.VP.INFO or the initial RBX value. This does require a bit more
>>>> plumbing though.
>>>
>>> I'm afraid not. Because below is host code, and vm->arch.s_bit is not used
>>> in guest code.
>>>
>>> Or are suggesting something like dropping the
>>>
>>> 	if (is_tdx_vm(vm)) {
>>> 		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
>>> 		sync_global_to_guest(vm, ucall_mmio_gpa);
>>> 	}
>>>
>>> entirely and use below hardcoded value instead in guest code?
>>>
>>> 	UCALL_MMIO_GPA | 1 << (GPAW - 1)
>>
>> Yeah this is what I meant. Just drop sync_global_to_guest() entirely and
>> do things like a normal TDX guest would.
> 
> Blech.  Every time I come back to this series we're still discussing ucall crud,
> and "doing thing like a normal TDX guest".  Selftests aren't normal guests.
> 
> I know I suggested using the HPET base, but I only did so very begrudgingly as I
> couldn't come up with a better alternative to emulated MMIO, and the end result
> is quite gross.  Not only does the code ignore @mmio_gpa but still obviously use
> emulated MMIO, it requires synchronizing data to the guest because KVM disallows
> "private" MMIO.
> 
>   void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>   {
>          vm_type = vm->type;
>          sync_global_to_guest(vm, vm_type);
> 
>          if (is_tdx_vm(vm)) {
>                  ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
>                  sync_global_to_guest(vm, ucall_mmio_gpa);
>          }
>    }
> 
> Retrieving GPA via TDG.VP.INFO isn't any better, it's still an absurd amount of
> "work" for something that should be trivial.
> 
> Can't we just abuse TDVMCALL_REPORT_FATAL_ERROR?  AFAICT, there's no restriction
> on the data payload, and there's enough space to all but guarantee we'll never get
> a false positive.
> 
> Pulling in Xiaoyao's idea about using CPUID...
> 
>>> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>>> +{
>>> +     vm_type = vm->type;
>>> +     sync_global_to_guest(vm, vm_type);
>>
>> It works and it looks simple. But we have the architectural approach to
>> test if a guest is TD guest, by checking the CPUID 0x21.
>>
>> Since checking CPUID 0x21 is not complex, and as a bonus it can help
>> test if TDX module behaves correctly for CPUID leaf 0x21, I think we
>> should switch to use CPUID 0x21 to check if it is TDX VM in guest code?
> 
> Absolutely not.  It will require at least one an extra VM-Exit for TDX and non-TDX
> guests alike, and thanks to Intel's wonderful CPUID behavior of having unsupported
> leaves return the last supported leaf, the guest would have to check CPUID.0x0 and
> then CPUID.0x21 on modern hardware, i.e. would incur two extra VM-Exits.  I don't
> care about the performance, but from a debug perspective that's going to be awful,
> as what should be a super simple operation will be polluted with unwanted data.

As you said, "Selftests aren't normal guests". So the guest code doesn't
need to check CPUID.0x0 to get maximum supported leaf before CPUID.0x21.

And for TDX, the CPUID doesn't cause VM-Exit to KVM, it only exits to TDX
module, which is transparent to KVM.

Anyway, if we go with the TDVMCALL_REPORT_FATAL_ERROR as you proposed, we
don't need the logic to check if it is a TDX VM in the guest.

> Stop trying to reinvent the wheel and just use a virtual function table.
> 
> I've verified the attached patches don't break non-TDX selftests, someone just
> needs to test the TDX changes.

I test it and it works.
