Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5502F0C48
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391747; cv=none; b=k4CGcumM4ihMsvo0omYPdmKu+9dk6riAt90su+zAgcM/rYdqpFMb0clpklacu/hO0Xwa1aLRFCJRg2V/7Eqp2px1E7bUn0J2o8TPQmkViKHBZoq9clZ7udaKCm60pNXEF/WN+tBjRzWcsFVRIwLjH1S8fyLMmyHF/MGUwOZd88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391747; c=relaxed/simple;
	bh=KGMWeyRIjFM5o2c3vXCM0PApC/yFWPm46vHbiJqcXnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK6kPxNfkVwObIFzXrMg9ziqdRDc7EmqkKJqopq6UU/HgTTuVCg6aqbox0P8adDPrLOFT4g/KCjAQr86dbLUorgEvEjBlzqTDs4yuvkaE12dLnABtLglNUcCbzFrXlmasdoBoudicGlryG8WEgS/EkdD6VdupcNWG7tYbKBVYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEJWB0gV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D64LKK5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEJWB0gV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D64LKK5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785391743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yQTI73ivUEZuX6HNEWKmrBdj1qeSbZfkMYzYDeZp5E=;
	b=jEJWB0gV63rdZ/psYCkNeiKlbacGPI0R+RHHPKPOOggpMXomIi7Y7eg90ceY5UcrPFyGOq
	P1IUSb8tV4gc8/NAwLwirZd0QUQwcT1/563q2idWoJ6S3i2swqhTGd5OrLJ1MD3hCfzc1q
	229olx82tLNc/xUGaao0V53Glu/Dpy8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-dHvlkckSOSWOzUFO6rW2qw-1; Thu, 30 Jul 2026 02:09:01 -0400
X-MC-Unique: dHvlkckSOSWOzUFO6rW2qw-1
X-Mimecast-MFC-AGG-ID: dHvlkckSOSWOzUFO6rW2qw_1785391741
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so3048833b3a.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785391741; x=1785996541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yQTI73ivUEZuX6HNEWKmrBdj1qeSbZfkMYzYDeZp5E=;
        b=D64LKK5Ule77Z84/PlOpFOzqBdWuQVzbspc22mTZAPi1otLVmCV1tGwPe493dNVty7
         gIC73bGiPO5M6kT4gHdAPFSnOsCY/tqfX/6xSEQT5Q2591CDjdsXI9rtHewayTexj9I4
         HBvEl7aPjiD3872G39HycTOM82lPBjVLQnQrmtZSkxgL0aQ3eGxcfUdaFuiC0boEpLTp
         /9OahdiClLplObIcHIw7P/cfPWFDyeWEvFoRi224qqsZhO5spwqWPy4aQPAuGMR8Utz9
         xyurDIA4jFmjEQeWFiwpLIHS9xOwcJLHFuzmsNwZJ4fsiev/P77KcOvJxzKYLJ3my7Wq
         /XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391741; x=1785996541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yQTI73ivUEZuX6HNEWKmrBdj1qeSbZfkMYzYDeZp5E=;
        b=D6CRYBUAU+xH3xM0N45/6Y/3OX29EpRyVBOqmk03c4SlXm338VOz4pXNnxamL/WhnV
         XPwxVjpLElnJZIuBQ3s4d1s8yghKA/0e6G+8rVq7q4qamaQnNhxxEQNyMr5Gp+YaDG2R
         lUqV091uEUiWWYDTLTvaBVFkBFLra9TFN6yR52NhqGp6z8IFLaF6rL3X7J4WSF7XytcY
         a2Nfq1TN7FOGrZrJC+ejQmzpgpn0uyImYFZ/7LBC1z+zNZJtRirs0FF4F8Vf2kV3K+HK
         K8of1MkCuRs0DHpChNgY5eGMzS01YsR1ULk4JPuEPg4rEwVneZb48N0n4OBvNoRYEx4V
         xYpA==
X-Forwarded-Encrypted: i=1; AHgh+RqK3G7nEpl6WVlfjIZn3WeIEx+enFANe9E5AIMoN2cetCM+OZjexkIcYYlHkzsGNbFHm1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqn/qsXmnetP+NxXxnhU5ZaE1lW54YiZSRXKKtK5VnNbKpNqQG
	ZHRWnCvHMFekLetcobmiY9W3izn/re5o/TP6cWPEhDxCR9aMRnOBVmPED9ntU4c4iz3m3sT3xzk
	YWONqL8Ogp6CIyHLnBTjEQtU3hExKu2s7qYClL3BER3QocJ2c2HbTSQ==
X-Gm-Gg: AR+sD12L3pPsQtgM4ddf7Wad0wqvuDCIpU3iKtxxFVdPR8Y2DpLHh0ocP5wWhC/1Hec
	GKo7fKX0lC6UBYB75o5OPM56YGJfzEl7cTei+RY9MDX9QnBqNaY9m8zy9ORPNCQQnSsiWCBSE75
	d981gPx+mzUmBV1lGLqLikFC64vnJ6EjKGGFRUXER0uEOsnOFuH+iJ7UKGa7tnhWx5mbievG/1N
	LJTsAtSdM7BvEEwThb2k0kqZwp/pw4TBsOuFqz4OiJ9J2TbhlbgbtqQPfDpRc4z20D41v7iHSlX
	O40Lps8bZlxj8gORD0ZHaEFAO+fP363X+kqEcX+nCykfgV+uzN4PO17sWeNrmAzZDMpxjCBOpk0
	Bd1fhGU4Q4H8vzGuR354Q43ZDjXysYEzFBWIiDyZpDX0=
X-Received: by 2002:a05:6a21:1f85:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c9008d2508mr1222728637.35.1785391740798;
        Wed, 29 Jul 2026 23:09:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f85:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c9008d2508mr1222699637.35.1785391740341;
        Wed, 29 Jul 2026 23:09:00 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb8250daesm1800701a12.9.2026.07.29.23.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:08:59 -0700 (PDT)
Message-ID: <30967c8c-be29-49bb-b8fc-f4a3b870fed1@redhat.com>
Date: Thu, 30 Jul 2026 16:08:50 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/24] linux-headers: Add RME related definitions
To: Kohei Enju <enju.kohei@fujitsu.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <20260728192630.240375-2-mathieu.poirier@linaro.org>
 <amrhioS_O_0ztjb_@FCCLS0092175.localdomain>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <amrhioS_O_0ztjb_@FCCLS0092175.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 3:41 PM, Kohei Enju wrote:
> On 07/28 13:26, Mathieu Poirier wrote:
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> This is a temporary patch intended for testing purposes only. It provides
>> definitions related to supporting Realms by the QEMU-VMM.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   linux-headers/asm-arm64/kvm.h |  9 +++++++++
>>   linux-headers/linux/kvm.h     | 10 +++++++++-
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
>> index 6aefe7973814..4c08631ec7d2 100644
>> --- a/linux-headers/asm-arm64/kvm.h
>> +++ b/linux-headers/asm-arm64/kvm.h
>> @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
>>   	__u64 reserved;
>>   };
>>   
>> +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
>> +struct kvm_arm_rmi_populate {
>> +	__u64 base;
>> +	__u64 size;
>> +	__u64 source_uaddr;
>> +	__u32 flags;
>> +	__u32 reserved;
>> +};
>> +
>>   #define KVM_ARM_TAGS_TO_GUEST		0
>>   #define KVM_ARM_TAGS_FROM_GUEST		1
>>   
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index dd52e2a65bfd..cdd5ad11f85a 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -689,14 +689,19 @@ struct kvm_enable_cap {
>>    * address size for the VM. Bits[7-0] are reserved for the guest
>>    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>>    * value 0 implies the default IPA size, 40bits.
>> + *
>> + * Bits[30-31] are reserved for the VM type
>>    */
>>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>>   
>> +#define KVM_VM_TYPE_ARM_NORMAL		0
>> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>>   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>>   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
>> -					 KVM_VM_TYPE_ARM_PROTECTED)
>> +					 KVM_VM_TYPE_ARM_PROTECTED | \
>> +					 KVM_VM_TYPE_ARM_REALM)
>>   
>>   /*
>>    * ioctls for /dev/kvm fds:
>> @@ -719,6 +724,8 @@ struct kvm_enable_cap {
>>   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>>   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>>   
>> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
>> +
>>   /*
>>    * Extension capability list.
>>    */
>> @@ -986,6 +993,7 @@ struct kvm_enable_cap {
>>   #define KVM_CAP_S390_KEYOP 247
>>   #define KVM_CAP_S390_VSIE_ESAMODE 248
>>   #define KVM_CAP_S390_HPAGE_2G 249
>> +#define KVM_CAP_ARM_RMI 250
> 
> Not a big deal, but a note for anyone testing this series:
> 
> Use Linaro's Linux kernel tree, as mentioned in the cover letter:
> https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads
> 

It seems the capability values get an extra leap on KVM_CAP_ARM_AMI in
"upstream-v2" host kernel.

   include/uapi/linux/kvm.h

   #define KVM_CAP_S390_KEYOP 247
   #define KVM_CAP_S390_VSIE_ESAMODE 248
   #define KVM_CAP_ARM_RMI 250

> Alternetively, if you're using Arm's tree or other trees with Steven
> Price's v14 series as I am:
> 
> You'll need to adjust the definition of KVM_CAP_ARM_RMI, since it uses a
> differenct capability number.
> 
>>   
>>   struct kvm_irq_routing_irqchip {
>>   	__u32 irqchip;
>> -- 
>> 2.43.0
>>

Thanks,
Gavin

