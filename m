Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D625B08B
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687496; cv=none; b=UGSLjWk/KS33iPlyJU/T/rIdOzIgsidFUTQpfR3Be77Wt5LSYdSWGSPcjC2m+YoJIZKY9XPC1WlsM+4Pjp0kGONLWNIZY8ooH5FXuSht9pF1f/W0u14FwsjOp+4YcSlUU5qrCZ2Io/mcmmCBxh+QF/AKo6j1jCjEm4cUxStU3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687496; c=relaxed/simple;
	bh=u4LJSTge9BtN0MRwqGIgzOsYg/AXOWRcy5rX2gK2/7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNcbO5DSvoKlLORAj1yzvAG92ej7HFaoONWllZsk57Zx5zQJ1DZYqx8NBDP/riJLtnkqQ/ny9hh8HUg9M0/RiOf7DpCM1tY7F2Rkpq14QJI+i/kS3V/P/vjQwR/BF1f2b+UEiEnw3vLdgl3rsA/5MFClLFICtWfrjoqf5dieGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAgXxeFF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAgXxeFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778687494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=amYNztQFl5KKp3yB5hrg3TWVSfBABiA8PwL/G8RqcPg=;
	b=eAgXxeFF6nYBZ/H0n3qbcpX2h4gOUC6+hLEZoXR8D78ds4wIjw5jYhQ2Z+zf5wEvQezHQz
	9ER7V82IkT/wftDxFjlGq2xcnH4gfLt21Vy8YAw5mJeMD8Iu/trpAlGiq7DEoyzd8vcm6A
	z8nFwtSzDmYi7Tl/pmS6l+n0d0cdWeo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-n3xU9EYmPtu9hcHD57-Bgw-1; Wed,
 13 May 2026 11:51:32 -0400
X-MC-Unique: n3xU9EYmPtu9hcHD57-Bgw-1
X-Mimecast-MFC-AGG-ID: n3xU9EYmPtu9hcHD57-Bgw_1778687491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ED5C18002C8;
	Wed, 13 May 2026 15:51:31 +0000 (UTC)
Received: from [10.44.50.86] (unknown [10.44.50.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E44C180058F;
	Wed, 13 May 2026 15:51:29 +0000 (UTC)
Message-ID: <d09750e3-c555-405c-9d8e-3a2d377b076d@redhat.com>
Date: Wed, 13 May 2026 17:51:28 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: introduce module parameter to disable CET
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Riley <d.riley@proxmox.com>
References: <20260512150016.2979228-1-pbonzini@redhat.com>
 <agO91crdKElYuh1M@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <agO91crdKElYuh1M@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 5/13/26 01:55, Sean Christopherson wrote:
> On Tue, May 12, 2026, Paolo Bonzini wrote:
>> There have been reports of host hangs caused by CET virtualization.
>> Until these are analyzed further, introduce a module parameter that
>> makes it possible to easily disable it.
>>
>> Link: https://lore.kernel.org/all/85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com/
>> Cc: David Riley <d.riley@proxmox.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/vmx/capabilities.h |  1 +
>>   arch/x86/kvm/vmx/vmcs12.c       |  2 +-
>>   arch/x86/kvm/vmx/vmx.c          | 17 +++++++++++++++--
>>   3 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
>> index 56cacc06225e..31568274d8bb 100644
>> --- a/arch/x86/kvm/vmx/capabilities.h
>> +++ b/arch/x86/kvm/vmx/capabilities.h
>> @@ -14,6 +14,7 @@ extern bool __read_mostly flexpriority_enabled;
>>   extern bool __read_mostly enable_ept;
>>   extern bool __read_mostly enable_unrestricted_guest;
>>   extern bool __read_mostly enable_ept_ad_bits;
>> +extern bool __read_mostly enable_cet;
>>   extern bool __read_mostly enable_pml;
>>   extern int __read_mostly pt_mode;
>>   
>> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
>> index 1ebe67c384ad..9f96e21dc1b9 100644
>> --- a/arch/x86/kvm/vmx/vmcs12.c
>> +++ b/arch/x86/kvm/vmx/vmcs12.c
>> @@ -202,7 +202,7 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
>>   	case HOST_S_CET:
>>   	case HOST_SSP:
>>   	case HOST_INTR_SSP_TABLE:
>> -		return cpu_has_load_cet_ctrl();
>> +		return enable_cet;
> 
> As implemented, cpu_has_vmcs12_field() checks raw CPU support, not what KVM is
> using.  E.g. EPT_POINTER checks cpu_has_vmx_ept(), not enable_ept.  Whether or
> not that's ideal/desirable, dunno.  But I think we should at least be consistent.
> 
> An alternative approach would be to squash the controls themselves.  Though again,
> I'd probably only want to do that if we plan on taking that approach for all such
> module params.

Yes, that was my first idea but it's not great to do it inconsistently. 
I'll remove the cpu_has_vmcs12_field() hunk though.

Paolo

