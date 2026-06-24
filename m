Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51603332604
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319497; cv=none; b=ePz/BfJ5rW8GRJYdp46j/+VfIsJEuUa9Ca0LFf7L3NHiqcpkMwbPJeoJrC7rISR9LkXFquudaPPivmc+WUM94A/Ol4gKLx9pP6UDbfaQPM6LjNF23lJR/xhDsFB6XFZ7507wl58cQMnq8Xtve+oBSSjSYa7rJ/CgL2Bmb6wXOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319497; c=relaxed/simple;
	bh=OUu4AlzwIk44skuE58xMZJuQfwug6gLNgzIjPyQdNTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0QNNtkmVnzsCFABQvW6IKlhHF2+wi0hfBrlhl1yErnH36FehrKdZTF5gxzKInxse7jPnzmzeWSFUPBtlb6qwvwrl6eNHTovNuK1PfwU9pPBC5GRUJGceTlsw/WPGhRpzUOjDa5FAmTLZKIAIWDsoNDJiQR4xmjNuqN84bgLjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoqNTlUR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6c21cMX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoqNTlUR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6c21cMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
	b=UoqNTlURHO1edHfR3oDLehLSuBhx+uKgYNhELHj24OgDQBIPLAXZaOcgxpY8V/dfnt+ZKn
	idUIV8EsieTO6n9EnFb7xDdyhmJfr3ggRp9CRAqcD9HyZfRm9ODFm0m8z5qhQt524lIcox
	zLi9ic8U7UvjXIug+HbMc3DR7wG+dAM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lYf2SEblMk-U12WBHHDrbg-1; Wed, 24 Jun 2026 12:44:54 -0400
X-MC-Unique: lYf2SEblMk-U12WBHHDrbg-1
X-Mimecast-MFC-AGG-ID: lYf2SEblMk-U12WBHHDrbg_1782319493
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46c90c8fd42so499564f8f.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782319493; x=1782924293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
        b=a6c21cMXhEK4KtpfNVIHJavBs6lZRSXHx113xVfhsiqAm3zfpRp8IKZTcvtegq65ic
         0pnmRF3kTrYUKDA+uGWguUYGdB+ib3hiy/jXOBSgJdOxQFmVlH5Fy/luJUQR+njiBAuw
         5rGbKR6yZTiG8aZnbelHzHaayupz2ShC7VMmZgMGTSCQo4I163zl4KniZL2f8g+eR8KP
         R1mLZVN8jKo/4khOk4VBpy48RQ3zCsR3Wj7yxt6xzdl8UsZNybiIuiUCR1XYyU2CW+Pi
         WxF2Vi+Eao+hU5R/TbgLddDCVFpBA5jiH9CX6cIwEtjMSGqYyHQ2fVJYWwwv1FImywu1
         9P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319493; x=1782924293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
        b=UeLlWXCOBP92uMTRXPn3zmgvkhjo3Cs5WiQayv/oUrQ4J3mUaIxzZrCfqqZAwTOKBw
         NM0HBTgmt0kuASypwoxxD058mHbz31OYwvABaqiLUmV+uMBPZ363O7H0kIFPvkO9D6uH
         DyhAzOsXfPXD7pCJj4V9pC+7mDngAVnNFL6QMgyCESJGdPIcX+PwlTO78NkYtrCLJKGl
         BaCKKidAtxapQtug8h7Tfy3cOTy10/2v5xPHaKhv/rNpJwgyR9mOEaCFz8RaHqkMCB5t
         YXD2rhTTrq8xi18kyzo+b0Gdw7e7FW9A9jE+h4ZXbIyaZcj2r8vZ4LbTe1sgLJv2a5aq
         h7HA==
X-Forwarded-Encrypted: i=1; AFNElJ+EGz0ImGv/Y413SCg1fIr8/OyHQUH+y4ItGS5u2mEwxn0ra0lH1yoqkkwNtN1EVHSrWWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOh8j5n405jkNSRCbA2dxLJRT2gx2Jpv6ZoSbraHjIV7tG6DS
	BKeMGfjyN6XYUcEkvf3GviOXWRglHoLZ0ZDgJt0+2Dn+2vecT7nitSvdvg6rpvh8clEHYeB/LdG
	aMrPMDgrcw5aZT1XwPcf3OAd8mWYjnOE9MpkpSCB3l87255Pvbo0Axg==
X-Gm-Gg: AfdE7cnTdTMO5XACjhQaN/TVmWa4vXgmP3BpLS5BtrR5sN0kkC4ZrlHOliX8I0fc/vL
	0eykaNYtqjmPfsM5UW66YRvxoE4dtyv99a/Y+9coXe04eVuCoYUneH73dlO1rYVZwyuSV7Lazgh
	ZJj5/QYBN6tDNLPKFpPdGuDc5cgD5QRcNxoaSr9euf/RkGQkPwjHubp3DmGjWo5ElCJKWCc5J4F
	TBwE+thSKRtpANIvDlgJ4WO8dCnXe41x6m0Z+mqnNyiQ5e2U0h2sQRfZACARjW1ebWwAY6c3lfL
	ysXXXvlt6/1Sty4agRsMP+WCVgbvAFUVDeZM4t7j/L4WmVZy8+vzsB/1eli17Wl5tqALQP7J9PT
	VZlEXPhT3QFSBsPVV/GC+TLsdiujaEEpmV3Y6PNuzxVdiIxNsKlBB
X-Received: by 2002:a05:600c:5491:b0:490:b294:c652 with SMTP id 5b1f17b1804b1-492608726b3mr60484235e9.20.1782319492691;
        Wed, 24 Jun 2026 09:44:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5491:b0:490:b294:c652 with SMTP id 5b1f17b1804b1-492608726b3mr60483805e9.20.1782319492216;
        Wed, 24 Jun 2026 09:44:52 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5? ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d46sm7307969f8f.13.2026.06.24.09.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 09:44:51 -0700 (PDT)
Message-ID: <6833bccf-afa8-4633-85b1-f61347034594@redhat.com>
Date: Wed, 24 Jun 2026 18:44:50 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <ccbadb13-888b-495d-b894-826a8e664d3e@redhat.com>
 <ajvkrq3e1103wLH7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ajvkrq3e1103wLH7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/26 16:28, Aditya Gupta wrote:
> On 26/06/24 01:47PM, Cédric Le Goater wrote:
>> On 6/23/26 16:19, Aditya Gupta wrote:
>>> <...snip...>
>>>
>>>        g_test_init(&argc, &argv, NULL);
>>> -    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
>>> -            pnv_chips[3].cpu_model);
>>> -    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
>>> -    g_free(tname);
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
>>> +        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
>>> +        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
>>
>> Can we remove this chip_type field from the tests too ? see 248e4e924e87.
> 
> I went through the usage, and don't see any fix currently, as the
> PnvChip structure these qtests are using is basic, and we need some way
> to identify the chip type, for things like which machine to use, xscom
> addresses, and to skip/do specific things for particular chip type.
> I went through the mentioned commit and its parent, seems it was
> possible with the compat property being handled by respective
> class_init. So currently I don't see a better way, what do you think ?

OK. Thanks for looking.

C.


> 
>>
>>> +            continue;
>>> +        }
>>> +
>>> +        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
>>> +                pnv_chips[i].cpu_model);
>>
>> please consider g_autofree variables.
> 
> Sure cedric, will use it in v2.
> 
> Thanks,
> - Aditya G
> 
>>
>>> +        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
>>> +        g_free(tname);
>>> +    }
>>>        return g_test_run();
>>>    }
>>
> 

