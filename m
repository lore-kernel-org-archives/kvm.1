Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713C38655D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351494; cv=none; b=RUTO0C6vuYBcFJpqlh/KKv/7498S404YEwaBAaOZGYPzpSkIJ2giPtV8+ZnpXtZ756io95NiA8kby1J9HPlCh7bmxMbl1wrHLmFZ3NjrDMqdc0+ATkmuBGLyL4ihsQ4tdH/yoofSDUOHFe3GJHgyRaTfv/X4z/CTDeHvV7zqwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351494; c=relaxed/simple;
	bh=cbri72P/HmxK8pIM3DHI1U95v+yw50ZdwFitju2IVk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkOkVx7WtLqIxT2mF6GKoe1eDG6d7SJ/pXE0xeu/qqpVlbesU0mecZtqRwBox0vh8SGhrt/OolyW6LAV0mr50E6a6ubDn7Xn32bIt39iOLdn+4CM2Z75q5g3p77sFfv87Tl3Sc8M0DeD2eJDArY0Ks2/6+4DWnS2Jp48OTi+spU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecQA6oaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecQA6oaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774351492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kyP1AhHdPhqFWbRFbHnITzTp9YlvtyOorLB8Z5S+tfc=;
	b=ecQA6oaF7xPTJhADS870Wo4ZmiIjcGUGbFgSnP4lKMgBcWi0dn1fuUtnM1o1UbNgW/Prg2
	cwbOhwzPMWm5bL7yMtGFVvJQ1V3cQ1l+SEek1EE8h3afS6McOwFxNcSouqtZhQM3V9TXNp
	N0A4Xu1XufSNAcQepOdc70u8EU6HdXI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-puGsboTZOeybqqcBv7G5cw-1; Tue,
 24 Mar 2026 07:24:51 -0400
X-MC-Unique: puGsboTZOeybqqcBv7G5cw-1
X-Mimecast-MFC-AGG-ID: puGsboTZOeybqqcBv7G5cw_1774351489
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B8CC195608A;
	Tue, 24 Mar 2026 11:24:49 +0000 (UTC)
Received: from [10.44.33.111] (unknown [10.44.33.111])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19D761800351;
	Tue, 24 Mar 2026 11:24:46 +0000 (UTC)
Message-ID: <fb159f31-4cf2-4d6e-aee3-97ad68200824@redhat.com>
Date: Tue, 24 Mar 2026 12:24:44 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
To: "Huang, Kai" <kai.huang@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>, "nikunj@amd.com"
 <nikunj@amd.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-11-pbonzini@redhat.com>
 <dd1fd2a2d5cb83d92d4064b44958e8315a86b68d.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <dd1fd2a2d5cb83d92d4064b44958e8315a86b68d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 3/24/26 11:45, Huang, Kai wrote:
> On Sat, 2026-03-21 at 01:09 +0100, Paolo Bonzini wrote:
>> When EPT is in use, replace ACC_USER_MASK with ACC_USER_EXEC_MASK,
>> so that supervisor and user-mode execution can be controlled
>> independently (ACC_USER_MASK would not allow a setting similar to
>> XU=0 XS=1 W=1 R=1).
>>
>> Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow
>> setting XS and XU bits separately in EPT entries.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/include/asm/vmx.h     |  1 +
>>   arch/x86/kvm/mmu/mmu.c         | 15 ++++++++---
>>   arch/x86/kvm/mmu/mmutrace.h    |  6 ++---
>>   arch/x86/kvm/mmu/paging_tmpl.h |  4 +++
>>   arch/x86/kvm/mmu/spte.c        | 47 ++++++++++++++++++++++------------
>>   arch/x86/kvm/mmu/spte.h        |  8 +++---
>>   6 files changed, 55 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>> index 4a0804cc7c82..0041f8a77447 100644
>> --- a/arch/x86/include/asm/vmx.h
>> +++ b/arch/x86/include/asm/vmx.h
>> @@ -538,6 +538,7 @@ enum vmcs_field {
>>   #define VMX_EPT_IPAT_BIT    			(1ull << 6)
>>   #define VMX_EPT_ACCESS_BIT			(1ull << 8)
>>   #define VMX_EPT_DIRTY_BIT			(1ull << 9)
>> +#define VMX_EPT_USER_EXECUTABLE_MASK		(1ull << 10)
>>   #define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
>>   #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
>>   						 VMX_EPT_WRITABLE_MASK |       \
> 
> Should we include VMX_EPT_USER_EXECUTABLE_MASK to VMX_EPT_RWX_MASK?

No, because it is used for many cases to refer to bits 0-2, for example:

  #define EPT_VIOLATION_RWX_TO_PROT(__epte)
     (((__epte) & VMX_EPT_RWX_MASK) << 3)

Bit 10 is handled separately because it's not contiguous and has a 
different mapping to the exit qualification (to bit 6 instead of bit 13).

(However, there is a bug later in the series where shadow_acc_track_mask 
needs to have VMX_EPT_USER_EXECUTABLE_MASK in it).

> 
> [...]
> 
>> @@ -496,7 +507,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
>>   	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
>>   	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
>>   	shadow_nx_mask		= 0ull;
>> -	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
>> +	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
>> +	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
> 
> Shouldn't 'shadow_xu_mask' be VMX_EPT_USER_EXECUTABLE_MASK?

Not yet, because shadow_xu_mask is used to set executable permissions as 
well.  I suppose you could make it 0 when MBEC is disabled instead of 
VMX_EPT_EXECUTABLE_MASK, but it can only be VMX_EPT_USER_EXECUTABLE_MASK 
when MBEC is enabled.

> 
> 
> Btw, with MBEC it's a bit weird to me that we continue to just use
> 110 (R=0,W=1,X=1) to trigger EPT misconfig for MMIO caching:
> 
>      /*
>       * EPT Misconfigurations are generated if the value of bits 2:0
>       * of an EPT paging-structure entry is 110b (write/execute).
>       */
>      kvm_mmu_set_mmio_spte_mask(VMX_EPT_MISCONFIG_WX_VALUE,
>                                 VMX_EPT_RWX_MASK | VMX_EPT_SUPPRESS_VE_BIT,
> 			       0);
> 
> Per SDM, R=0 and W=1 is always guaranteed to trigger EPT misconfig (see
>   30.3.3.1 EPT Misconfigurations).  Maybe we can just use that for MMIO
> caching?
> 
> We can then remove both X and XU bit from mmio_mask too.

Maybe but is it worth it?  (Based on this we could keep bit 10 in 
MMIO_SPTE_GEN_LOW_END, after all, because W=1 R=0 would give a 
misconfiguration independent of the value of XU; but again I'm not sure 
it's worth it).

Paolo

