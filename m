Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFD34D90C
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375571; cv=none; b=uovESK3Aq7Pomaw15Ns3lFTEfRs7AdXlgFyA+YWi0mhFvOKaIwdx6u3KJRNIdsgd9K8ydS2th2VJ7J0ybP8M7eZEoMaT8piP4Fmz3dfUSATr7fnu5wSkZx6g92NCT6y2a6Fl/8GzNehGWFqLrpaQIIAWHWamQGRGz/uyS18DuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375571; c=relaxed/simple;
	bh=9tp1JAaZ17N4lrG6FZtvBZ11PSu16AhL4tgqXidmpmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZawpjpZlnS+b6LHPQH+obJEdKguRoFl+FEskErfjS78KfYMdnhybtXq3a8ZMyW2WqZ5MCmd4LbfmGVR3n6eFxhJZwilledLWFwIrv4kJLJui1IW2Ct+6sWRramn01ROy85Hf/4SFwcyoD9BAZDza36X2UTSlt8mSs/6EhMfws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhS9ULMz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhS9ULMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777375568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T42Uv4JwpHgv22kVmMNEdoVMx1ilaD57HiCAB65MWXY=;
	b=dhS9ULMz6fVouhTRyzDG8VTk5PqWsKceIQzTdjx7J7OeoKVoTrIFngfpp8/aAwSnW/KzRG
	tQ0l6FOCdc0QYbgTzmzpGW+GHCRMJ451NT12Jz3rpCmRAyY73rz5G3mmGA7fSL1yaRQRSB
	iOkhlW6UHLbGQlNo4kZ9nwKl0sQkhkk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-OZR1Tw-QODSPj3g211Eb5A-1; Tue,
 28 Apr 2026 07:26:05 -0400
X-MC-Unique: OZR1Tw-QODSPj3g211Eb5A-1
X-Mimecast-MFC-AGG-ID: OZR1Tw-QODSPj3g211Eb5A_1777375563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BADF195609F;
	Tue, 28 Apr 2026 11:26:03 +0000 (UTC)
Received: from [10.32.181.22] (unknown [10.32.181.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31A80180047F;
	Tue, 28 Apr 2026 11:25:59 +0000 (UTC)
Message-ID: <1aaf6b2d-85da-400e-b8ad-d611fdaa015f@redhat.com>
Date: Tue, 28 Apr 2026 13:25:58 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86
 core
To: Binbin Wu <binbin.wu@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <e47f29d5-17f1-47ce-b80e-bfa543f9a712@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e47f29d5-17f1-47ce-b80e-bfa543f9a712@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 4/28/26 11:43, Binbin Wu wrote:
> 
> 
> On 4/23/2026 11:56 PM, Peter Zijlstra wrote:
>> Move the VMX interrupt dispatch magic into the x86 core code. This
>> isolates KVM from the FRED/IDT decisions and reduces the amount of
>> EXPORT_SYMBOL_FOR_KVM().
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
>> ---
>>   arch/x86/entry/Makefile             |    2 -
>>   arch/x86/entry/common.c             |   48 ++++++++++++++++++++++++++++++++++++
>>   arch/x86/entry/entry.S              |   46 ++++++++++++++++++++++++++++++++++
>>   arch/x86/entry/entry_64_fred.S      |    1
>>   arch/x86/include/asm/desc.h         |    4 +++
>>   arch/x86/include/asm/desc_defs.h    |    2 -
>>   arch/x86/include/asm/entry-common.h |    2 +
>>   arch/x86/include/asm/fred.h         |    1
>>   arch/x86/include/asm/idtentry.h     |   11 --------
>>   arch/x86/kernel/idt.c               |   13 +++++++++
>>   arch/x86/kernel/nmi.c               |    8 ------
>>   arch/x86/kvm/vmx/vmenter.S          |   46 ----------------------------------
>>   arch/x86/kvm/vmx/vmx.c              |   20 ++-------------
>>   13 files changed, 118 insertions(+), 86 deletions(-)
>>
>> --- a/arch/x86/entry/Makefile
>> +++ b/arch/x86/entry/Makefile
>> @@ -13,7 +13,7 @@ CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_
>>   CFLAGS_syscall_32.o		+= -fno-stack-protector
>>   CFLAGS_syscall_64.o		+= -fno-stack-protector
>>   
>> -obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
>> +obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o common.o
>>   
>>   obj-y				+= vdso/
>>   obj-y				+= vsyscall/
>> --- /dev/null
>> +++ b/arch/x86/entry/common.c
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <linux/entry-common.h>
>> +#include <linux/kvm_types.h>
>> +#include <asm/fred.h>
>> +#include <asm/desc.h>
>> +
>> +#if IS_ENABLED(CONFIG_KVM_INTEL)
>> +/*
>> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
> 
> s/acknowledge/acknowledged
>   
>> + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
>> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
>> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
>> + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
>> + * the VM-Exit is held pending until it's unblocked in the host.
>> + */
> 
> [...]
> 
>> -
>> -#if IS_ENABLED(CONFIG_KVM_INTEL)
>> -/*
>> - * Special entry point for VMX which invokes this on the kernel stack, even for
>> - * 64-bit, i.e. without using an IST.  asm_exc_nmi() requires an IST to work
> 
> Although it's being removed, I guess what it says is still true?
> 
> It says asm_exc_nmi() requires an IST to work correctly, and the new path for
> handling NMI when FRED is disabled.
> 
> idt_entry_from_kvm
>      idt_do_nmi_irqoff
>          IDT_DO_EVENT_IRQOFF call asm_exc_nmi
>              ...
>              call asm_exc_nmi
> 
> It seems the stack before calling asm_exc_nmi is not an IST?
> Does it matter?

I think it does, the IST is needed because of all the stuff to detect 
recursive NMIs.  So asm_exc_nmi_kvm_vmx needs to remain.

By the way, here:

> +	/*
> +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> +	 * The FRED NMI context is significantly different and will not work
> +	 * right (speficially FRED fixed the NMI recursion issue).
> +	 */

It's even more important to note that NMIs need an IRET in order to 
unblock further NMIs.  This is even more important than the recursion 
issue, which does not affect KVM's non-IST entry into the NMI handler, 
and is the real reason to use IDT_DO_EVENT_IRQOFF to build the interrupt 
stack frame for NMIs.

Paolo

