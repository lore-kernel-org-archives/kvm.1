Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3236896F;
	Mon,  9 Mar 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044987; cv=none; b=rGzhYIPG8+5NNIdnaCsSMRLHs6m1pJJp8yBto4mC6cu4tDn7loEmxcV2zxt1f2C8gpyaOzldZcd3ZVDHguM0DMZGWSyBwF5YoPg+9jg9tqA3sC8yuNBVqcOsGeYf/grVHOKkjc1vZuFbK6jlNXA82uJxm1DVy1XnwEGbvgJlTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044987; c=relaxed/simple;
	bh=AZPCb4hwGDNqLSR2i7+uN9HsZJIqQIYxLEyMLeornxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOQVxS4GwJv8KsA4cx3ES7rEDkcQfVcuWpI/naXGqM+94UuQbrUZf+whz14wI1ftVB6fSXQ4Pu6nAx8iq5xIkqMNb0V6vVgFYfEdHYpWoEx8NNv3N0j5V79/eckhEw6ZK5LCbcNh9y7guskuZNtfYnAMUm26ojL10R5jvJcLpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC3691570;
	Mon,  9 Mar 2026 01:29:37 -0700 (PDT)
Received: from [10.164.18.47] (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92EE23F7BD;
	Mon,  9 Mar 2026 01:29:42 -0700 (PDT)
Message-ID: <32bdf8bf-f363-4a3f-95a3-26ac552a1592@arm.com>
Date: Mon, 9 Mar 2026 13:59:40 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Change [g|h]va_t as u64
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
 "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>
References: <20260306041125.45643-1-anshuman.khandual@arm.com>
 <aasZ5NNo7q9MRgzD@google.com> <abc4ed51-2129-4bed-a156-e0e9ec4e81c4@arm.com>
 <CABgObfbK1AdWLLCmTpD56BFCM0j_ckUTta_DpaPYe3mmOf88wg@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CABgObfbK1AdWLLCmTpD56BFCM0j_ckUTta_DpaPYe3mmOf88wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/03/26 1:50 PM, Paolo Bonzini wrote:
> Il dom 8 mar 2026, 13:58 Anshuman Khandual <anshuman.khandual@arm.com>
> ha scritto:
>>
>> On 06/03/26 11:46 PM, Sean Christopherson wrote:
>>> On Fri, Mar 06, 2026, Anshuman Khandual wrote:
>>>> Change both [g|h]va_t as u64 to be consistent with other address types.
>>>
>>> That's hilariously, blatantly wrong.
>>
>> Sorry did not understand how this is wrong. Both guest and host
>> virtual address types should be be contained in u64 rather than
>> 'unsigned long'. Did I miss something else here.
> 
> Virtual addresses are pointers and the pointer-sized integer type in
> Linux is long.

Agreed but would not u64 work as well ? OR will it be over provisioning
causing memory wastage for all those unused higher 32 bits on platforms
where long is just 32 bits.

> > You also didn't try compiling it on any architecture where this patch
> would have made a difference.

Right, had missed those. But have fixed all the reported places on x86
and powerpc platforms now.
