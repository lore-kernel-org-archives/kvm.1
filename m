Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F846D549;
	Tue, 21 Jul 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661469; cv=none; b=A4MJB//wAPC+1LQLejFfloY4hPNE7lsPoLvGPI0qxZPaAaTNUh3vsvTJPh8eqD31ah9hi+twNo64z87uVyJU4XbJH6NKAjsC5yQ3/V8P5xH+SPurFLVf42T07adjp7UMhIseTuoAozqEQ2ERLCYKYESs5E29A/vSmb2Pf57M+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661469; c=relaxed/simple;
	bh=o6NrqLq7PoomPolv0kARA4TXXjyHAmiShaureHTdrzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGjike1DxW5g/ZGmCuCJC7GYbTkcFErfsaUlp+JyAUvtMC/i7PGicYqNge2RQlJqH5rQPKZi3TlunU564JIjjnk1XM0qVreAm9ON9egmDE2abbnA/TDu2nYgGIcZKnS+KGPp36lwuGjKgs2QEXYrnCf3QgN2MqMf0lPS//UpEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L38n6ipE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L38n6ipE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784661468; x=1816197468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o6NrqLq7PoomPolv0kARA4TXXjyHAmiShaureHTdrzg=;
  b=L38n6ipEoIRmnKiWt1QtN8kOjvaeWNvTGMfTD9dA8zEzGg1VAHPePO2L
   m1RpgsdCmjSU81WErhUgP3dEftMg8kLeZpdFCjfsA2PYYxeeHh34sqri1
   J0KzKPhEe1FK91Qp+rxIKNJ+Cv2SskQPqm6BO2tDSvWkoXFWIvOctuNdx
   Rjmq1wK3fpaIKEZlVg4BLJvPsspu1BhYNb0EH5jR1kgz126CJoHfnGHMh
   6tbAs9DpiqCjJdyXhE4tUS+F8GbTOkKCD60RJu5fBz6gp7p1WaOEYpc3I
   RZ0GLqxtKTD4SyWdiFcAZD5PSNJfsQZtBa2P3EFzy26NIM0wb352eD/80
   g==;
X-CSE-ConnectionGUID: RQjsVcOfT5O1Q/Jsii6XTQ==
X-CSE-MsgGUID: 8xaKOyGlRze76wVXR0OcxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96791946"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96791946"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 12:17:47 -0700
X-CSE-ConnectionGUID: iXQRnmF5RpOWlpnzSRiR1A==
X-CSE-MsgGUID: mLseEXcVTR2/f0t0FVa5Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="253946587"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 12:17:46 -0700
Message-ID: <7fc29642-fba2-4752-9095-10c89cacb8d2@intel.com>
Date: Tue, 21 Jul 2026 14:17:45 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: Jim Mattson <jmattson@google.com>, "Mi, Dapeng"
 <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
 <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
 <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
 <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com>
 <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
 <dc8adc2b-ca9f-4ac6-9f15-e9e954e90b15@linux.intel.com>
 <CALMp9eR0yXVPqOUZzoBSmGTpONojSALS7X-Rrq8QkaivnNgt8w@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eR0yXVPqOUZzoBSmGTpONojSALS7X-Rrq8QkaivnNgt8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/14/2026 12:06 PM, Jim Mattson wrote:
> On Mon, Jul 13, 2026 at 10:28 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>>
>> On 7/14/2026 1:11 PM, Jim Mattson wrote:
>>> On Mon, Jul 13, 2026 at 12:12 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>
>>>> rdpmc is the preferable way to read PMU counters since the better
>>>> performance than rdmsr, and most of current code regardless of kernel or
>>>> user-space already use rdpmc to read PMC counters. If we set the rdpmc to
>>>> interception by default, then it may cause extra performance hit.
>>>>
>>>> Currently I didn't hear there is any plan to extend the rdpmc to support
>>>> more types for Intel platforms ...
>>> Is Intel willing to commit to that?
>>
>> I'm afraid not. :(
> 
> Then, KVM must always intercept RDPMC.
> 
>> rdpmc is still possible to be extended to support more types in the future,
>> but recently we don't see such requirements.
> 
> That's no comfort.
> 
> An alternative would be for Intel to provide a way for KVM to query
> which types of PMC are supported in ECX[31:16], before or concurrently
> with any microarchitecture that supports more types than CPUs support
> today.

While I can't speak for future Intel architectures, we're not aware of
any plans to extend RDPMC with additional resource types in the
foreseeable future.

Regarding the proposed enumeration mechanism, I'm not sure it changes
the fundamental situation. Even if a future architecture provides an
enumeration mechanism for new RDPMC resource types, RDPMC passthrough on
an older KVM could still exist until KVM gains support for the new
resource types.

Given that, I'm not sure the possibility of a future RDPMC extension by
itself is sufficient justification for intercepting RDPMC
unconditionally today. RDPMC is the standard low-overhead interface for
reading PMU data, and forcing every RDPMC through a VM-Exit would impose
a significant performance penalty.

