Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3343B4A8
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819861; cv=none; b=eK3mkTQHiZ4LCOMaS609d0ODJp+qPcf7GzK8kMFmpjkjb3e62sGB78Q2RPBKzEdGAbJXuRU2zP3ffrUclJvTQTpvZ1lg3bXJvXzfyX4X7+ZUDkFO7rFAB8YymZinM5z8RziFOIf9SSURkUrLSAjintRKxvrD0ZgWPgXJ0U/ZSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819861; c=relaxed/simple;
	bh=Sap5YlLe7VhJslKUNzsDhZzZYkT2XJhgM2NFbTswsQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb1CXg52c67cze0lfSizwQy+BBU0koiadq82N8vUEcT70Bc/LvvjjnCuCcNtJsQQiEj4MNuI2XjAaS3xxSFNWxlLjce8U/O9zvjQ7Lr1ojGYKQB1GgscXzDtGU19K6595f+w+WOcmLeo1bsQEKNkzWipj3d3M4Izq05CGT5nkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzZIQWY+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzZIQWY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784819855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MtgWSbxcbMZ6W0gpsiVES/aPBE/+B5BD0oTs0Yc7e1c=;
	b=VzZIQWY+A8cZRgjwpkG7G1TMwvV1Qbd/AnOVi35chM0Ytb1xuw37LWYgLGbEqgYSbxKlwU
	yE6B0xUIzZdeMhAHUt6TZCREBF2A99M4ppte+7gEk+IWMV/Zcjau2Breu/RigG8DPBAvvA
	K/fWm2RdYuET4Y4KyNFCBHY/yzGQDXU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-GMn24JbfPuq6yW4mai2qwQ-1; Thu,
 23 Jul 2026 11:17:31 -0400
X-MC-Unique: GMn24JbfPuq6yW4mai2qwQ-1
X-Mimecast-MFC-AGG-ID: GMn24JbfPuq6yW4mai2qwQ_1784819850
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA72A1830352;
	Thu, 23 Jul 2026 15:17:30 +0000 (UTC)
Received: from [10.44.50.182] (unknown [10.44.50.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9CEE18005B8;
	Thu, 23 Jul 2026 15:17:28 +0000 (UTC)
Message-ID: <2b4d5faf-1568-4080-92b3-1e525a11b194@redhat.com>
Date: Thu, 23 Jul 2026 17:17:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
To: Sean Christopherson <seanjc@google.com>,
 Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260501203537.2120074-1-seanjc@google.com>
 <20260501203537.2120074-3-seanjc@google.com> <ajNQ_Ix5e0p6FuFT@google.com>
 <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com>
 <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com> <ajxLCMgLQe-JiRfq@google.com>
 <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
 <ajx1Y93iX2oV-DLa@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ajx1Y93iX2oV-DLa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 6/25/26 02:25, Sean Christopherson wrote:
> On Wed, Jun 24, 2026, Michael Roth wrote:
>> So maybe the bounce buffer approach would work for DBG_DECRYPT at
>> least,
> 
> Yeah, DECRYPT worked fine, it's all the others that break.
> 
>>> pread() doesn't work, because the source or destination needs to be a userspace
>>> address, and so any RMP #PFs will get eaten.  But copy_file_range() makes the
>>> world go kablooie.
> 
> And the risk isn't limited to copy_file_range(), that just happens to be the first
> syscall I found that did what I want.  E.g. any memory that is kernel allocated
> and mapped into userspace would be problematic, because that memory could be fed
> back into KVM.
>
> So I don't think we can fix this by playing games in KVM.  Which is pretty much
> why we ended up with guest_memfd: the only way to lock down memory to the point
> where we're 100% certain it's safe to "poison" the pages is if KVM sequesters
> them away in a dedicated file system.

Yes, I agree that it's basically the same issue that led to using 
guest_memfd for SNP.  Another one would be io_submit().

>>> I'm fairly certain the issue is that the encryption is salted with the physical
>>> address, and so encrypting at X instead of Y will yield different ciphertext.
>>> I.e. any command that encrypts the contents in the destination (or in theory,
>>> decrypts, though AFAICT none of the commands do so) *can't* be bounce buffered.

Yep. :/

>>> I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
>>> CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
>>> support to require guest_memfd for operations that require putting pages into
>>> Firmware state.
>>
>> Yah, short of maybe the above approach, I don't see any way around it atm :(
>> If you think it's worth pursuing though I can give that a shot on my
>> end.

The unavoidable ones include, if I understand correctly, not just 
DBG_ENCRYPT but also LAUNCH_UPDATE_DATA?

For encrypt the destination is the guest memory, so how would adding 
guest_memfd support for SEV/SEV-ES work?  The guest doesn't have a 
page-state-change call and neither does it have RMP nested page faults, 
so how would you communicate the private<->shared switch to userspace?

> I say we wait for Paolo to get back from holiday (in a few weeks) before doing
> anything drastic.  I'll send a patch to fix the existing selftest though, no
> reason to leave that hole open.

Well, everything is drastic.  "Fortunately" AMD helped us with the 
firmware update that already hides SEV-ES on SNP machines 
(CVE-2025-48514), so at least there's a precedent.

Could we say CAP_SYS_BOOT is only be required to create the VM, after 
which it's up to userspace to not screw up?  Probably not, because 
userspace can then drop privileges and operate on the file descriptor; 
which is the actual dangerous part.

The only not-horrible alternative would be a default-disabled module 
parameter that allows SEV/SEV-ES on SNP systems but adds TAINT_USER when 
you create one.  And downstreams that don't like the idea can just rip 
out the taint.

Paolo

