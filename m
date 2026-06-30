Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4493CB8F1
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818018; cv=none; b=PqgY6ME4OWQKbVcETziIsfrCrEFoNeGGVD+3Ujo6CHIhbqfg2bDsG65kN9aaFBvoz28DY2xFAl55I2NFuqhKMbNWmhT34Kk9nVagHhaJN6plCBMUqbKEI8FoHzhi3cPmreOEwYEVEn6OBg1QzJEey+tRloBuoPRuiJE+AlxocNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818018; c=relaxed/simple;
	bh=Nx/5w6TudJfJguAv3rQnOEBV9HRO+eOhHCmz1PfhHCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqIVVVmjqRwn2DUJNHSpNGm8MzGJQ42OHwPQS/WNylHkQ24G4K7x+GvhZuoL7P5bwEZTEygTZU9n3ZYkzIHZA1y4KliDW7rsNU8mdOf7yn/30FPUnm4fAz+oN3zEWDapWcwCNskPqIh6BA8jxRxqy6L65pwdfrWBxYLoV/zVUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d72jtBxj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ppKUUU7d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d72jtBxj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ppKUUU7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782818015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TvZNdWrFNeL0P+tCrhQtOwz2zOdGFPTOyf6fP5xrjeE=;
	b=d72jtBxjpOGCqg2NhlrNvxf12gWBPClRQd8HxwKns0BcH+Jbi9gAoZBT7O+JvJW0vXCYpf
	iuCuuGi2LSn0p2r+yKxXGiMl7uF720eMBoVJ9Tw3KRUBohK4QCeiyjV9PMwLOggt6k54nA
	+eKx9A+rWMVn6WYSKVGwulDelSqJBPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-A4WgvyPMPLyvv_YhKJYH-Q-1; Tue, 30 Jun 2026 07:13:33 -0400
X-MC-Unique: A4WgvyPMPLyvv_YhKJYH-Q-1
X-Mimecast-MFC-AGG-ID: A4WgvyPMPLyvv_YhKJYH-Q_1782818012
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493ba771d1bso7660745e9.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782818012; x=1783422812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvZNdWrFNeL0P+tCrhQtOwz2zOdGFPTOyf6fP5xrjeE=;
        b=ppKUUU7dse/uNjB+LHTi3XBciYS2JHe9JK2O/CUNKlK+gI9NvJAxME32ePAkYGIMn1
         FiUkSugaGg5dBs8kahmNo8MKVC9G7/xORdN2QJwb9O7Ztxu9g761x5jLvMWujO3FLTX6
         Eg1Piu4edTQ0GoMKBwaoe4WLYn3vx4qBXlMbQpCOESm08zMSbOLT6BmRVe5HmrU+JRVQ
         fDPWVhtmf9LwGUhIXu/Ohi29B7udP/DzJodToaX3yxpz9EEmHiYngacS8Hbo6qiIPTmd
         LXErLz3WrRipvnkPcwI6aJHjmUrqTrztElK9ewD3aTYCKNo26zX6LfJ6BTiablM+07iV
         hsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818012; x=1783422812;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TvZNdWrFNeL0P+tCrhQtOwz2zOdGFPTOyf6fP5xrjeE=;
        b=kpjyiWb1YK13ND0T4qMWk16mmfxvqx1EpY1HlrEdZZsubMQqcT2CawCUeFMuj/K6EN
         Iwlec93Oy9TDltN+0KeXvGeFJIdeO65dqMV3t1jMHnVe94z8vN1LBCXWVvjlMRq3ENXs
         6WGXFt92GolcNylDgqfWky8K6g0th9qi9WBBbJfmY9mCitrHi2kzZe9hua3I17Uz4/lz
         MmfDxZPPqsAeR2ndYCtTnrESLM3O2BvOmnIAC7ti5ci2LDi0KmKYInt7uQl0qdDC++Yj
         oYB+GO9LixXaaGetofgF73jA1FoZdlnFV4jtWfyZfqcN3F5kaNXzC/FW/yzEcPOVu6m1
         ozgw==
X-Forwarded-Encrypted: i=1; AFNElJ9K7QUy2GyW/1Cbht0/Gu5XIZsdnKrOISLC3noKe7/W2r8340Vq+m4dSayI+YiMPl3bgqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y6GDUFJnUeGjRQ+LXoX9+ElfF0VgRa8GowQVDRVeynvlsu5u
	eXn9xcIeRoHO9ZfffFLURwwx47NzAnYYH09ZthfcZg4p1L09iMpVdYGVHNNhpegAT5oYGLpogaT
	9qsBgw1epoZ3mHLwOOV2cDtJnPffXfq4Zf759GvkMufnR5vbx3qKAVg==
X-Gm-Gg: AfdE7ck1VbFsC/RF1u6N0o15d7SFe/NkBR8DjPQkh5FTzMTZQjJyfLEqdkn6MOmDPYx
	W12dGtPCwxvgdOY48sMA3672QaOkI6/ejmz+ZCuBzrJLZWQ+V+yMCWpjNrZHvc0Y8A/ZHmZHbTH
	rEsWG9gOytemBTubtvWvkFJ/dQmj7iemBEX2AtHX8es4/eGcbCNH0AHlyhoM1qBiZCVWFQkrUNv
	KtaK9Fx0rmAbwW09CpusIcTrmIxvq9bE8fdsf/D5jAcblh8HtZbPtJw4ePWU754otXDV4T5hGRF
	aOoGSVNTXonr+NVTGQ15y8BB+AM/m7Tzuhps0yC55/mPniWtgi6oi4HQ3lKTwMzr+V3WtxMK8eO
	VsIXxrEUd6rgMJCnlqqTp4TujttSIkra3dNV65U3frsjeWxJfLw==
X-Received: by 2002:a05:600c:c4b7:b0:493:bab4:183a with SMTP id 5b1f17b1804b1-493bab418b0mr29449235e9.5.1782818012457;
        Tue, 30 Jun 2026 04:13:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b7:b0:493:bab4:183a with SMTP id 5b1f17b1804b1-493bab418b0mr29448685e9.5.1782818011973;
        Tue, 30 Jun 2026 04:13:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf65sm7402611f8f.21.2026.06.30.04.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:13:31 -0700 (PDT)
Message-ID: <dcffa5bb-c092-422c-8685-6f247ffed004@redhat.com>
Date: Tue, 30 Jun 2026 13:13:30 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
 <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
 <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/26 13:04, Aditya Gupta wrote:
> 
> On 29/06/26 20:13, Cédric Le Goater wrote:
>> On 6/29/26 13:39, Aditya Gupta wrote:
>>> On 26/06/29 01:20PM, Cédric Le Goater wrote:
>>>> On 6/29/26 13:04, Aditya Gupta wrote:
>>>>> In the past there have been hard to recreate issues where XIVE changes
>>>>> cause qemu crashes due to multi-socket interrupts such as in [1].
>>>>>
>>>>> Add a functional test explicitly to test whether remote interrupts work.
>>>>>
>>>>> The test can also work as additional boot test for multi-socket boot,
>>>>> initrd boot test, as well as a check for e1000e to be working in powernv,
>>>>
>>>> you should consider moving to a more modern nic model: igb, which
>>>> has sr-iov support too.
>>>
>>> yes, can do. with igb i see multiple irqs, so test will have to take sum
>>> of all rx irqs, and compare:
>>>
>>>     2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
>>>     2026-06-29 17:00:46,391: 135:          0          0 0 PNV-PCI-MSI 2416443392 Edge      eth0
>>>     2026-06-29 17:00:46,393: 136:          0          6 0 PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
>>>     2026-06-29 17:00:46,394: 137:          0         14 0 PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
>>>     2026-06-29 17:00:46,395: 138:          0          4 0 PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
>>>     2026-06-29 17:00:46,397: 139:          0          4 0 PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
>>>     2026-06-29 17:00:46,398: 140:          0         16 0 PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
>>>     2026-06-29 17:00:46,399: 141:          0          6 0 PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
>>>     2026-06-29 17:00:46,399: 142:          0          6 0 PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
>>>     2026-06-29 17:00:46,400: 143:          0          4 0 PNV-PCI-MSI 2416443400 Edge      eth0-tx-3
>>>
>>> I feel e1000e suffices for this test, should i stay with e1000e or use
>>> igb here ?
>>
>> or use a single cpu per socket config. Which seems better for the test.
> 
> 
> The test uses single cpu per socket, since i have `-smp 4,sockets=4,threads=1`. Was this what you meant ?

yes. or cores=1, as you wish.

Thanks,

C.

