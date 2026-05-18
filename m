Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1023E7BB1;
	Mon, 18 May 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097416; cv=none; b=Y9FMqeMrizjuN3XQ+Fv/Fr6elU+aPGnyhX1Y+BcLbaAeKZdqy3vUvMIbrRdb002hAB5Z7JIgZndwRx0V2+g+GG67AiyaD+ZJlp7Gd9VRYllL7YXwqSULfK9T9iz50MiecwW+LTw/USelvG4CjQgQZ3w5ChQO8Gh9nqSO96wmMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097416; c=relaxed/simple;
	bh=wWKDQsaZaZoeO80TaqAbFyqHo+myamz3q0c0rs3LJuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rjy1j5xLaGWnQC2f9TKzH/ONaGo2pJn7TSTOFdPx7CwfsLokdhNsy24oGP3ssqmFECIyFM7ENImkj1XNUecWU482lvrPv49KaU7OYsd5oL81U1az0k+BQHtufqY/SoKPoBbw/xzfNCgrUkBASx1K3hJ/MNhVKaGQNQBZm2iMpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpy7Viho; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpy7Viho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779097414; x=1810633414;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wWKDQsaZaZoeO80TaqAbFyqHo+myamz3q0c0rs3LJuA=;
  b=lpy7VihopCODvXs7uHb9ftcsP5EADrMQMEpDCQsjAli05YqmiIESNQnl
   vQCOE426f6wM4lAGiUXqExrdwg19x4lqVuUDixZly2drbyQcrTA60DBlH
   4fCVikuFzlbEjrAT3CN5tLtAHoEpg5K/8O6oKO/J2Y0TkK+e8iMlF8js/
   FyY4n2btsGOKTsobxS43CW+7/ZFRiEtWdjXmnrV/hNl+RgDQG08s1RUcR
   7Hoh26xCYktnOvN8G17ni6WQg8HV7BT+LX8rQoXf5Q9pIOCRcP1J2MaGN
   8Rx3EKt6EzWzZpCukSItSmNK17Vptie/0F4BGfJkJYVxP12UkWqAK5Zdh
   Q==;
X-CSE-ConnectionGUID: h5eV6kAkRgKhuugDd4oy5g==
X-CSE-MsgGUID: pLPscTMNTxKmQ1UdUz/Sdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="83798843"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="83798843"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:43:33 -0700
X-CSE-ConnectionGUID: clUQcTh5T1KSCvKA53oTsw==
X-CSE-MsgGUID: vl9ei/u4STuJaZRjkx8zAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239249609"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:43:30 -0700
Message-ID: <868898e6-1c57-498d-848d-1df9cbeac23c@linux.intel.com>
Date: Mon, 18 May 2026 17:43:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Paul Durrant <paul@xen.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-4-seanjc@google.com>
 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
 <agcXr2FP4C3I_jbQ@google.com>
 <52fdc61a-60e8-4547-8ff7-f249b4d667b9@linux.intel.com>
 <ad4934f4a663c448924aeabe6418e68ae3ef9813.camel@infradead.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ad4934f4a663c448924aeabe6418e68ae3ef9813.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/18/2026 3:15 PM, David Woodhouse wrote:
> On Mon, 2026-05-18 at 10:19 +0800, Binbin Wu wrote:
>>  
>>>>>   	longmode = is_64_bit_hypercall(vcpu);
>>>>
>>>> Is the variable name misleading?
>>>
>>> It most definitely is.  However, @longmode is passed around quite a few locations
>>> in xen.c, and so I don't want to opportunistically fix this one variable.  Though
>>> I'm definitely not opposed to a separate patch to rename them all to is_64bit or
>>> something.
>>
>> OK, I can do it.
> 
> This one (as shown above) is clearly indicating whether this particular
> vCPU is in 64-bit mode for this particular hypercall. Changing that to
> is_64bit makes sense.
> 
> However, there is a separate overall mode for the VM, which is stored
> in 'kvm->arch.xen.long_mode' and accessed by userspace using the
> KVM_XEN_ATTR_TYPE_LONG_MODE attribute. It affects the datatypes used by
> shared memory data structures, and is also latched by the kernel when
> the guest writes the MSR for the hypercall page. That one should
> probably keep its name.

For this one, I think the current KVM code is consistent.
The format is determined by EFER.LMA, whether the guest is running in 64 bit or
compatible mode doesn't change the ABI.

struct compat_shared_info is used only when the guest is running natively in a
32-bit build.

> 
> 

