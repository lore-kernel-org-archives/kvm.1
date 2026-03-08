Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E217A2F6;
	Sun,  8 Mar 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772976969; cv=none; b=oVxH8sqqDj9CsdY5ekNb4DHq5ElcLlrFNIytPVHj1RxNnm772jGXXm29iJqWnEXdfE9fwLn01Kx1ZByxFRWqguCeaikLEKQJE7u6WYvPOaD0nMNAwbJRCtPMTzvSj9yUE/TyYKESgFTPQYrQteIReK0Iaw/yesBcqJF6hKX9g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772976969; c=relaxed/simple;
	bh=3lFOlLrQgsrVvPDaRIq9XVA9VRdlnEhw7AtlBfqzLSQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ap0nyIr+SgmRb87SSvffi+eXqi2MxTep6UIK0lnKY9J7o03i0KayhA1Nachz4posUdITH4gWvkt+xeivYi6R0TdbOV5jOSMHshwhmQ4CWE8JB0gTLShJHz4tDxRis0lxkp1mTqEgluB1L7dKgv2cc5UmUsL9WyWUkYi7y6PBkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02A51570;
	Sun,  8 Mar 2026 06:35:59 -0700 (PDT)
Received: from [10.163.174.99] (unknown [10.163.174.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8393F7BE;
	Sun,  8 Mar 2026 06:36:03 -0700 (PDT)
Message-ID: <ebbb0ebd-9556-4c8f-b557-6990902ccbc5@arm.com>
Date: Sun, 8 Mar 2026 19:05:59 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Change [g|h]va_t as u64
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20260306041125.45643-1-anshuman.khandual@arm.com>
 <aasZ5NNo7q9MRgzD@google.com> <abc4ed51-2129-4bed-a156-e0e9ec4e81c4@arm.com>
Content-Language: en-US
In-Reply-To: <abc4ed51-2129-4bed-a156-e0e9ec4e81c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/03/26 6:28 PM, Anshuman Khandual wrote:
> On 06/03/26 11:46 PM, Sean Christopherson wrote:
>> On Fri, Mar 06, 2026, Anshuman Khandual wrote:
>>> Change both [g|h]va_t as u64 to be consistent with other address types.
>>
>> That's hilariously, blatantly wrong.
> 
> Sorry did not understand how this is wrong. Both guest and host
> virtual address types should be be contained in u64 rather than
> 'unsigned long'. Did I miss something else here.

Is this about 32 bit systems where unsigned long would have matched
a 32 bit pointer size where as u64 will not ? But would not the u64
still contain 32 bit pointer without any issues.

