Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9B2AD3D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137375; cv=none; b=DEgKZzobQf8ryGpMRAN5SgWzP9HRYaPWk+qDUXtZbbu1FAaaP4zeDae8tLJAW5p+Ph1sVGysfWj29T3Hh/ZcSwWGW5NHlj9KrBU5YyxO3PrGyfHqtNb4hyFpOM+72OZIAwj37dkMzxDiyT6dTN4mD5hiaVgQyN5ormtPqemI85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137375; c=relaxed/simple;
	bh=ox7BeE23vHKCeR4iQdb+QppadlKleEuwmEoOXCObhVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVXjStHqVL5W+ke5I0HXBY90YZxPBjK9brwecaBE1P60Ir3gxxzKCDUAIULW9mxMBmzZ3kyh5xq7G2csq8VjjIQ4A1nM/yNvvRcF/mbcXaDuU73WAwv221ddmKi3hwHvowqsYPWKLGJVwa2g4Ad8QOlZD9+SywiaAVWfHH3ZpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=im6Le8Lt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tcoTQ1Lf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="im6Le8Lt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tcoTQ1Lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773137373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OSNodHH8ELupC2ygl2Np+FE81l2qd5e7jwH69v98Gwo=;
	b=im6Le8Lt6dWOOQYileI8+gce7AYK/+DFOMo3urdYAzH9o5zYjJX5P91/d6E++IQMwstg2C
	SpBHShEwu0KCzVVtTpejYLE921HZN7l8JQBv9t+wrgjiTzzOQuv8B4puMJXd8q31/GfA72
	RQ6eAWkexyEaUvu6muePzf9FpqBg4Yg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-yUUlKucCM1SULPkKlLGOwA-1; Tue, 10 Mar 2026 06:09:32 -0400
X-MC-Unique: yUUlKucCM1SULPkKlLGOwA-1
X-Mimecast-MFC-AGG-ID: yUUlKucCM1SULPkKlLGOwA_1773137371
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso6132824f8f.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773137371; x=1773742171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSNodHH8ELupC2ygl2Np+FE81l2qd5e7jwH69v98Gwo=;
        b=tcoTQ1LfZK1a/BRTime1ZCeTG9FqymwyIqhE10tGOxFS4vKHWI+9JAHs4t7dQicD40
         nRncl7rFesbTQ1ql84VjtzUtqUhUmGxUzbdIOzqLNm66z8K4CurNTYUoKPTI+82Fv0wo
         UeWVhYLpOk9FWMQkiMjtA2ECnjM/boiLLfDwsPxTXwp548QY1A406oHzwqOCtiFyicwa
         w3bUPz6BXUsoe2dwQQORITyRr7jTQnMhv3VX6b5KJnlTBKTI49xMmh7Dc7bBn58qYYp2
         +EIyMDLQl25vufEAjZgBthpb1iK7Wl+nlb7/gN6LOM1OGS5zEF1iCzbBq5NR56xViTAJ
         Jg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137371; x=1773742171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSNodHH8ELupC2ygl2Np+FE81l2qd5e7jwH69v98Gwo=;
        b=UROT9/RnimiPN8fZR2P8A0S7wWInwLk7zDBXE0Oaohyj78UB3xldIoCC7V8BOahOQZ
         maHMymHzEHZgD8v4+emhCj0zhS2qc2Bdk2UDK5uJ1WqAknYZ4BpUcKzw0QPapuekEKeq
         qQy8je1JqHNAzchv1tfvdSUO7qgn44ipCf0cvjmoiWdDyIIvOmEozuCstuNULwpcffz/
         ojJJIsrS8JMLrvGE12ermx7Xj8nUgsaNJB+ex6fS/TgBjRowXSQ8E2RjnMJoh7MBB0V+
         kFXEDez6z2yj3CeUxZsjjJKqVZFUU0VywxWj9V51zn20Sore7j14qUYTy2pXnesWJQ/O
         M6xg==
X-Forwarded-Encrypted: i=1; AJvYcCW3i2+SKB9uGZD8pVB5z3YRj6WkiAGQ7YYnekUe14wpwhKp0tK/cmFV6UKhsEiCBWdw6Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWILTU6uM8P/kHB4vCYV06IZNmaLyV8BwYy5N3Flx9YpHp5I/
	eDPIPfyGWdhhl+qJfxayT0MYe4RGjHUcG3qms4G+M9SyxqG6esBL6mvjYo9m7c+K3NY4ernsI55
	g7jvYX3EQHHz17qq4iQIKWh9vdMNlm3o1KvdXhVaqGRn4FYmcnzglew==
X-Gm-Gg: ATEYQzx1Ez5jy5JggANkp1n8xJl4IFiR57ZWCReL37DVUzrEZsBu/dsC8P5oVs4gzeL
	T6LHpoyFalMAiOS6QJLuv2BVofpYlFbdK1EchaOm5EE66uU4npRlHDSUyWqDYD5n3bJLeqaOUWg
	05Xxdl/xrN/ENW+dsSP4CFhA433kKdokiq2pdZBuZbkfgeJGC6R3SypNol7F1u6PVdG1dLWuNAG
	OCFpMjdDovBWWoVqRSXXGet8hE64sCUIUjNCUq8gtHg0PAnV49YhZgvWj65riSROBUg+fJNO/yq
	HpxtAN32IQWfs+/Uz+UGAJo+VsnJD2EkAAEVpj6SecmMSoDPJw43vy+WfRK78QEhM/v6dhZ4RwB
	De+hfO30LpfJkHTrsHdvA4T5Ece6SFiXTyMafxMQS9yzquL5yL0kFIg45SMx4
X-Received: by 2002:a05:6000:3113:b0:439:905e:1236 with SMTP id ffacd0b85a97d-439da55584amr25597537f8f.2.1773137370549;
        Tue, 10 Mar 2026 03:09:30 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:439:905e:1236 with SMTP id ffacd0b85a97d-439da55584amr25597465f8f.2.1773137370065;
        Tue, 10 Mar 2026 03:09:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c? ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae49177sm33617229f8f.35.2026.03.10.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:09:29 -0700 (PDT)
Message-ID: <97e3c514-a434-4cef-8d94-2f3bfd97068b@redhat.com>
Date: Tue, 10 Mar 2026 11:09:28 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfio 0/6] Add support for PRE_COPY initial bytes
 re-initialization
To: Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
Cc: jgg@nvidia.com, kvm@vger.kernel.org, kevin.tian@intel.com,
 joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com,
 avihaih@nvidia.com, liulongfang@huawei.com, giovanni.cabiddu@intel.com,
 kwankhede@nvidia.com
References: <20260224082019.25772-1-yishaih@nvidia.com>
 <20260227132327.3e627601@shazbot.org>
 <f74867bd-02b0-40d8-98be-c22a4129320a@redhat.com>
 <b16fc66f-bea8-4b42-ae68-8e37a6d09bda@nvidia.com>
 <4da90bae-c087-4191-9e96-1bd815468a6a@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4da90bae-c087-4191-9e96-1bd815468a6a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/26 10:46, Yishai Hadas wrote:
> On 01/03/2026 14:43, Yishai Hadas wrote:
>> On 28/02/2026 8:27, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 2/27/26 21:23, Alex Williamson wrote:
>>>>
>>>> +Cédric, +Peter, please see what you think of this approach relative to
>>>> QEMU.  The broken uAPI for flags on the PRECOPY_INFO ioctl is
>>>> unfortunate, but we need an opt-in for the driver to enable REINIT
>>>> reporting anyway.  Thanks,
>>>>
>>>> Alex
>>>
>>>
>>> I took a quick look. The series would be a little cleaner if
>>> vfio_check_precopy_ioctl() came first
>>
>> The motivation to introduce that core helper and adapt all the drivers to use it, was to centralize the common code and ensures that output flags are cleared on entry.
>>
>> This can be done only after that we have the previous opt-in patch as we would like to keep the V1 behavior for compatibility reasons.
>>
>>> and some parts are little ugly
>>> (precopy_info_flags_fix). Will take a closer look when back from PTO.
>>>
>>
>> I'm open for any better name, any specific suggestion ?
> 
> How about renaming it to precopy_info_v2, which is closer to the feature name ?

I found the prefix '_fix'  confusing and saw no connection with
the names of the new flag (VFIO_PRECOPY_INFO_REINIT) or ioctl
VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.


Based on how 'precopy_info_flags_fix' is used in mlx5vf_precopy_ioctl() :

   +	/*
   +	 * opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 serves
   +	 * as opt-in for VFIO_PRECOPY_INFO_REINIT as well
   +	 */
   +	reinit_state = mvdev->core_device.vdev.precopy_info_flags_fix &&
   +			migration_state == MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_INIT;


a name like 'precopy_reinit_allow' seems appropriate to me.
'precopy_info_v2' could work just as well but that would tie the
precopy reinit/reset to an ioctl which might me a bit limiting.
As you wish.


>>> Is there a QEMU implementation ?
>>
>> Yes, please see here [1] the candidate QEMU patches that the kernel series was tested with.
>>
>> [1] https://github.com/avihai1122/qemu/commits/vfio_precopy_info_reinit/
>>
> 
> Cedric,
> Did you have the chance to look at the matching QEMU patches ?

I will this week. I just got back and work has piled up on many fronts.

> For now, only minor notes remain open, and I would like to send a V1 soon to make progress.

you should send the QEMU series. Naming is not a blocker and it will
help assess kernel support and compatibility.

Thanks,

C.


