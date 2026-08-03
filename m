Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F42E88BD
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777492; cv=none; b=Z/5qrHsvAAOYG8jg0lo0TJLnfrs9YVZDn8RRbfnnvmvU6HnAbKRURQY+4Vf61i/ElJtHQHHcDBL2WMDj5fYKrZH2P9fhkP8vmW2mAc41nj65P37msmOw6dEYz7jy7Y6dX3SRTUqxLgj5ebDkmPVqf23J3G13eFiltCJXs1VkRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777492; c=relaxed/simple;
	bh=E3wbYr7wB5062gs9YHvjVLZV2ZTr+bS5qnhZjXo1ycc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B5FXSllrpSA7CU1D3H4+xl/otiewJXfp48OdVYY5Jg8vyzJJS3RAssQCBtYK3+LX3j3M2J1/z8NrST0vbl/cD8zw/QKuprX9iRghQlg/7Qo/ftmKUdcxfezLDHRtnt8j7AbGi3Lr7015k103ILubCRKv81r535l5kX3cd390hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHKSe0MX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHKSe0MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785777488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t98reXFp1iYMCbj5MpIhmLF1EcLMrLHWx3BymUh+4p0=;
	b=JHKSe0MXC4cu5ZYUf/f26ym7kqo9U0D5WWBpTk6SWkfcxgdFjj7VmfdAyHwbRYFBgjnrsj
	hMx/LI/Ove+bGR7ff8hVD5Dcqb4qmJ/Bq385mnO2PIISYOsFNYTWoI6tBoml5i2NpDQ6+C
	usb6YAQQfwAiZp/bFyLcftpZ1ygY+yk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-FqSdfQLbP6S7r0NUfB34Ow-1; Mon,
 03 Aug 2026 13:18:06 -0400
X-MC-Unique: FqSdfQLbP6S7r0NUfB34Ow-1
X-Mimecast-MFC-AGG-ID: FqSdfQLbP6S7r0NUfB34Ow_1785777485
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 639781956054;
	Mon,  3 Aug 2026 17:18:05 +0000 (UTC)
Received: from [10.44.48.18] (unknown [10.44.48.18])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5ED1B423;
	Mon,  3 Aug 2026 17:18:01 +0000 (UTC)
Message-ID: <46663836-fd97-4328-8c7d-5efeeb222ce6@redhat.com>
Date: Mon, 3 Aug 2026 19:17:58 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260731175834.1121005-1-pbonzini@redhat.com>
 <amztmWhHXUR4zBv1@google.com>
 <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
 <anCZoc65i2xXNQgO@google.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <anCZoc65i2xXNQgO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 8/3/26 15:40, Sean Christopherson wrote:
> On Mon, Aug 03, 2026, Paolo Bonzini wrote:
>> On Fri, Jul 31, 2026 at 8:46 PM Sean Christopherson <seanjc@google.com> wrote:
>>>> * if the PTE is present, follow_pfnmap_start() sets args.writable to
>>>>    false and KVM_PFN_ERR_RO_FAULT is returned;
>>>>
>>>> * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
>>>>    -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
>>>>    up returning KVM_PFN_ERR_FAULT.
>>>>
>>>> With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.
>>>
>>> IMO, returning KVM_PFN_ERR_RO_FAULT on a read-only VMA is wrong.  AFAICT, that
>>> behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM: do not assume
>>> PTE is writable after follow_pfn").  Given that that's the only case where KVM
>>> returns KVM_PFN_ERR_RO_FAULT, I would much prefer to fix that wart and cross our
>>> fingers nothing has come to rely on the behavior in the last ~5 years.
>>
>> We can try, but I'd rather not do that in stable releases (while this
>> patch would be applied there, as a first step towards fixing the DRM
>> issue that Sergio reported
> 
> I don't see how this would help with fixup_user_fault() not actually fixing a
> fault.  Neither returning -EFAULT nor emulating is correct KVM behavior.
> 
>> - it avoids the sashiko issue reported for
>> https://lore.kernel.org/r/20260731160514.1101989-1-pbonzini%40redhat.com/).
> 
> But the issue Sashiko reported is just saying that KVM sometimes does what I'm
> saying KVM should do all the time: return -EFAULT.  Or did I misunderstand that
> one too? :-)

Yes, that's correct.  My point is I'd rather not introduce other changes 
to the !VM_WRITE case in stable releases.

So, the follow_pfnmap_start() patch I posted last Friday is part of the 
fix for Sergio's report; but it introduces one such change---which 
indeed we agree is desirable behavior, but which I'd rather not sneak in 
as part of an unrelated fix for a regression.

So, *this* patch removes a bunch of cases in which hva_to_pfn_remapped() 
is inconsistent, but it leaves RO_FAULT in place for now.  Then 
separately we can, uniformly, do the change from RO_FAULT to -EFAULT.

Paolo

>>>          /*
>>>           * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
>>>           * or the page might be absent.
>>>           */
>>>          if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ)) ||
>>>              ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE)))) {
>>>                  pfn = KVM_PFN_ERR_FAULT;
>>>          } else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
>>>                  r = hva_to_pfn_remapped(vma, kfp, &pfn);
>>>                  if (r == -EAGAIN)
>>>                          goto retry;
>>>                  if (r < 0)
>>>                          pfn = KVM_PFN_ERR_FAULT;
>>>          } else {
>>>                  pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
>>>                                                   KVM_PFN_ERR_FAULT;
>>>          }
>>
>> Yes, but I'd do that only in 7.3.
> 


