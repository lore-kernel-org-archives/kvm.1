Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA74A093D
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999230; cv=none; b=vD+Jj/c5d8FWmbnGMlhuloq7d84KnEZuGHTQq37TG5zOLq1TfPlRaVqVsX1QeGAhEjsNbji4WdOm880cpwuLeQlFc6FYyoTYHfinlIsx+Jk5QLm2xa7vqYAf2cylronEgficNBSCi4t3l9mM4wSYq5dTCwyQ0wzUVvbygYpb1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999230; c=relaxed/simple;
	bh=Y9K/A2rysPS73ZVguMllk0HJbV1REEwCXWLmLjckNoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HI5wbHtQjngyKraJDPbEvNhRV/IlD86KsctQxD2Bh3CyJctVjR20YEGJtIE/gf2z3ZqfWIAIqK5JFblAYfnGNT39KkcqWsQnIdTkvxGcZCVhBiAFoCAkXxSsXC3O3GU3uLRm0G1V+egfVq4xwbidqYQ6RcxIm04uCfp88fb4bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwEbWgLz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwEbWgLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789999227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Xy9D3cMzmtvMI6QdqX1VMUscrgyZ9okvtda7MIeoJ4=;
	b=ZwEbWgLzMWxv/S84rthhG0kZ6AE75Qd+I6apcOj35UVgKVH4PO91sg9EcbNHeB15Q/Dgtg
	fOvR/Lck+hbrZ3fnLUthYbp6yIqxvUERGgi2/ijL19qkeu2pH4suwuSW1tkrSJDHtpcdzW
	Z58vdMEbqfO2ev6e2FlhM+4ixW7NJp0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-JTlX0O3nN5Kgt0HcrTRYIA-1; Mon,
 21 Sep 2026 10:00:20 -0400
X-MC-Unique: JTlX0O3nN5Kgt0HcrTRYIA-1
X-Mimecast-MFC-AGG-ID: JTlX0O3nN5Kgt0HcrTRYIA_1789999217
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A9D1954227;
	Mon, 21 Sep 2026 14:00:16 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9F1341B;
	Mon, 21 Sep 2026 14:00:13 +0000 (UTC)
Message-ID: <7efe2260-5c11-4e8c-812e-dd1e215ac3e4@redhat.com>
Date: Mon, 21 Sep 2026 16:00:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Christophe Guillain <jean-christophe@guillain.net>,
 =?UTF-8?Q?Pawe=C5=82_S?= <spawel523@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260914181223.289061-1-seanjc@google.com>
 <c645070e-9829-4f98-bafc-b5d44ff2db45@leemhuis.info>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c645070e-9829-4f98-bafc-b5d44ff2db45@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 9/21/26 15:57, Thorsten Leemhuis wrote:
> On 9/14/26 20:12, Sean Christopherson wrote:
>> Serialize vCPU creation by holding kvm->lock for the entirety of
>> kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
>> by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
>> possible").  I botched the math when justifying the vcpu_ids tracking; it's not
>> an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
>> "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
>> something we want to do in general.
> 
> Hi Sean! Thx for handling this and sorry for pestering you, but I have
> to ask, as this fixes a regression that was already reported two times
> and introduced this cycle:
> 
> What's the plan to merge this? Is this aimed for the current or the next
> merge window? Ciao, Thorsten

For this one, but after fixing the PPC and s390 cases.  Sean, if you're 
busy I can send the v2 myself.

Paolo

>> The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
>> does parallel vCPU creation.  As with so many things, KVM's current behavior is
>> the result of decades-old cruft, not intentional, deliberate design.
>>
>> Patch 1 is a tangentially related bug fix; I included it here because holding
>> kvm->lock for all of vCPU creation allows WARNing if KVM attempts to lock all
>> vCPUs if vCPU creation is in-progress (the caller is must hold kvm->lock).
>>
>> Sean Christopherson (5):
>>    KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
>>    KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
>>    KVM: Move check for existing vCPU ID to the top of vCPU creation
>>    Revert "KVM: Check for duplicate vcpu_id as early as possible"
>>    KVM: WARN if vCPU creation is in-progress when locking all vCPUs
>>
>>   arch/x86/kvm/svm/sev.c   | 10 ----------
>>   arch/x86/kvm/vmx/tdx.c   |  5 -----
>>   include/linux/kvm_host.h |  1 -
>>   virt/kvm/kvm_main.c      | 35 +++++++++++------------------------
>>   4 files changed, 11 insertions(+), 40 deletions(-)
>>
>>
>> base-commit: d599822bdb66aeec5ec76297b0fc6efaaeefe07c
> 
> 

