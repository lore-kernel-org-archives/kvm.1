Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202A190664;
	Fri, 23 Jan 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208393; cv=none; b=PvyaSqugfnz5+9EgunYTm7kE188/XT/AFmCytMqkTf83HlfFXAXtdewo4hbKig3SswClifYSRWKH+ep/fEFPPGEqakYAYOIPafIt2V564XI7YxnnYD3sOruwCrmVHvZOokCy2bGj/5Gwx8hGTBMaDRflccAF94lXvD+tUAxSMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208393; c=relaxed/simple;
	bh=fyNOIml0uwf4cqGl7TAjzi/z4yElhqkwW+9XzD4DARs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp1s7ALzDeCDiqW50YO06HQRfOorQGP3yqKTd7NbZlz+lLzAE0HGoGhDaZfjEDvKoudqkG1tLcCp6dy8N1rtbt+fXKnRDJLimrPfkkA5naxNnMF6I82eMv5RUrq/Ul6lSw1rnR7afsN4tRPragxjTdvARmwAlcdpxtKii6Y1+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.16.10] (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 7A04A2339E;
	Sat, 24 Jan 2026 01:46:29 +0300 (MSK)
Message-ID: <8d23522a-efbb-4d4c-7ecb-f9de87b44677@basealt.ru>
Date: Sat, 24 Jan 2026 01:46:28 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] KVM: x86: Add SRCU protection for KVM_GET_SREGS2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260116151523.291892-1-kovalev@altlinux.org>
 <aXOuwWI3WcvT6Ccb@google.com>
Content-Language: en-US
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <aXOuwWI3WcvT6Ccb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/26 20:24, Sean Christopherson wrote:
> On Fri, Jan 16, 2026, Vasiliy Kovalev wrote:
>> ---
>> Note 1: commit 85e5ba83c016 ("KVM: x86: Do all post-set CPUID processing
>> during vCPU creation") in v6.14+ reduces the likelihood of hitting this
>> path by ensuring proper MMU initialization, but does not eliminate the
>> requirement for SRCU protection when accessing guest memory.
>>
>> Note 2: KVM_SET_SREGS2 is not modified because __set_sregs_common()
>> already acquires SRCU when update_pdptrs=true, which covers the case
>> when PDPTRs must be loaded from guest memory.
> 
> On the topic of the update_pdptrs behavior, what if we scope the fix to precisely
> reading the PDPTRs?  Not for performance reasons, but for documentation purposes,
> e.g. so that future readers don't look at __get_sregs() and wonder why that call
> isn't wrapped with SRCU protection.

Agreed, moving the lock inside __get_sregs2() makes the requirements
clearer. I've verified it fixes the issue and sent v2:
https://lore.kernel.org/all/20260123222801.646123-1-kovalev@altlinux.org/

-- 
Thanks,
Vasiliy
