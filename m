Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723A12CDBE;
	Thu, 19 Mar 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882895; cv=none; b=oU5UH05ULFDFhqlkMQ9Aq263Zdn4uS7pW9sJC7g7hr7rq4rUNCVSjuejB13Tgk71jE3ww1dhuZfEzpW6Gfy8FvydNZNLxoLqNgZKYN0QsOJQoO9Pbt2T+i5M1Rj0sQagiDfaBWqb03KWHuV71kUfHpb+sAV+CeqrVObFvMViQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882895; c=relaxed/simple;
	bh=zOdYHBeWCMAIDgoUSHr1MvT4bfeCmY8f5H0QH5wzXY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBgcwHm6dWU+pzXSw6SO8AAthm9aRPwEYGLPkVFgvyJBT0QtBlBpy9r3SRUYeKUYoFajT1o/pI4co1SkEJOcmptmwIJik92E+KrNNWSzuDZ5No0ubFSzkwRw+xelkSvlyuuPEyXkdIKxTcBmjBJytJC44W8JIOqw+TM4xKO+Leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkSGwJ8N; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkSGwJ8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773882894; x=1805418894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zOdYHBeWCMAIDgoUSHr1MvT4bfeCmY8f5H0QH5wzXY4=;
  b=jkSGwJ8N45hZN+HoQozhS930o/x4H9/0ZKG2tD+lWpk7E1G91UJxyTUQ
   JFYlDALiKmptrSQPVEO4LkFyP7uULRTZ4i3bZiFPtPjZ1oHQk1u4UuBw5
   osgnu/McxfnDtS7/NuWdLF0Wx7wbh0dcFT4XnegjVe85EonKZ3vLqoKO3
   xHvQl3GEz1ZNr7GtapdTkvMl5KfTdbwIRXHQCRyjlkbBp05MPx5CpV0jn
   WqrzMq/tAl2wj6r1rczLBvskqbCn50XOJUheuToi+DcTzDwuGR5Ga1DxG
   jHwOkHecyWl2/zixDB5DgWN4TecSDwP8zpei4pwq5w+FTxBeM9CyN1X8F
   Q==;
X-CSE-ConnectionGUID: Y7tYPohLTQW1dcp99SKAXA==
X-CSE-MsgGUID: saAK6Bq5RMqBEqs51Optmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74647244"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74647244"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:14:53 -0700
X-CSE-ConnectionGUID: 2RlpzaldS0SAnKNiaZCZhQ==
X-CSE-MsgGUID: BLP0ee8aS4imVk867dC4Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="226944021"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:14:49 -0700
Message-ID: <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
Date: Thu, 19 Mar 2026 09:14:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
To: Dave Hansen <dave.hansen@intel.com>, Dmytro Maluka
 <dmaluka@chromium.org>, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/2026 3:42 AM, Dave Hansen wrote:
> On 3/18/26 12:01, Dmytro Maluka wrote:
>> +		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR) + APIC_ISR_NR - 1:
>> +		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR) + APIC_ISR_NR - 1:
>> +		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR) + APIC_ISR_NR - 1:
> 
> Thanks for the patch, Dmytro.
> 
> <sigh>
> 
> So this code never worked (at least for a big chunk of the ranges.
> Isaku, could you please go try to figure out if there are tests for this
> somewhere, and why this never bit us?

The bug doesn't cause problems for TDs because:
- These x2apic MSRs (TASKPRI, PROCPRI, EOI, ISRx, TMRx, IRRx) are virtualized by CPU,
  when a TD accesses these MSRs, it doesn't cause #VE, thus no TDVMCALL from the TD to
  request the emulation of these MSRs.
- The bug make the "false" range of APIC MSRs smaller, so it doesn't impact the result
  for the rest of the APIC MSRs.

The bug could be triggered if a TD issues a TDVMCALL directly to request the
read/write operations for these x2apic MSRs, but a sane TD will not do it. 

Currently, we don't have dedicated KVM selftests code to call TDVMCALL directly to request
the emulation for these x2apic MSRs.

> 
> It might also be handy to have a:
> 
> #define X2APIC_LAST_MSR(r)	(X2APIC_MSR(x)+APIC_ISR_NR-1)
> 
> so that the resulting code is a bit more readable:
> 
> 	case X2APIC_MSR(APIC_IRR) ... X2APIC_LAST_MSR(APIC_IRR):
> 
> Dmytro, if you feel a burning need to respin this, don't let me stop
> you. I can probably just fix this up when it gets applied, or Isaku can
> make those changes and resend it too.
> 

