Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69241B354
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744195; cv=none; b=KtNNCrhDkGwQDOitajFqJ9LzO/j66eOtQzxkRj0C1ETP1aTedtOeD49fh1ZlJsKWHORL3dcDzSQUDSbpsu5mYM6vLtDUSMP3TwGQBQIDmgN4OlcH08672c15vVc9W74yPFGBDDKFin3bfRpkR2o4Yb6PdaIFGcOFHTC/8K7hIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744195; c=relaxed/simple;
	bh=AWi8TIYnBq1iw+l4kEn1xWYlAXGI2IMzOVkcKmcJjoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le2oOgTqDfOoZAO0nTnGvnimHmwUs3rCS/0t2DXu6pnlBv5QY5QxQIgFB7O6PHtp00LaAO1JO81geba9VRAcvztnJLevsgsMIlRB2E3WkeP/9PzjhYV+LW9xvjp1pJLL8GdU5CSOW+T+rubXsawnb1P77p+QxK6ExH0J9+Q6n6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddl9Ag5g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpv9dimi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddl9Ag5g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpv9dimi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782744193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
	b=ddl9Ag5gqeUIINpv2HxTKNLYpX3bbeJmcFPM6mDTURea0s0d7qSFPi/slfRxnIrbx72siq
	MBO3kkUrOHt7Yo4sigoznJQ6LOuwozAWKI5dFK5lpmmssUCnNwerGOweGbsSfd+AXHSNiK
	2UKEJStQBRX/V5/jJddfdqFKwx3KnQ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-dqpUUPfrN42aSdAon9WozA-1; Mon, 29 Jun 2026 10:43:09 -0400
X-MC-Unique: dqpUUPfrN42aSdAon9WozA-1
X-Mimecast-MFC-AGG-ID: dqpUUPfrN42aSdAon9WozA_1782744188
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924207e640so29301215e9.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782744188; x=1783348988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
        b=Gpv9dimiDOTDVB7JtRGZrI8hDzGeJpPEtj7raY0gAkAdCVOqm5a+27Wr02UHnhrQl6
         gmFgAqFdi2Y/Bm3VGIkHPmnBbt1E9OxPa3D12pobQzfcJgNs3AVVvtvO8FnU67rhhZeD
         T6DtjfWNXkyrFgs5lFmZr3FXy/wQJfIRNhILgsD2jjyk1vDjJRwYpsjvrxKzLNmy64YX
         JEmP2ffehJ45vNUqrQVKIhHI5AKUIN4fJql6/DOUFP7DO4SitWEdhbDiz++g1M2Hs6VC
         KAOIawc8kpGGW4UJFIdXRxOurvPY4s5pictVExFpZCm4epCWyQn5Kskqv4p/2fTWrtYV
         inwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744188; x=1783348988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
        b=qsNLKchbAfDqU0vFUfg6cs/WaqnjPEX6MenCfDmMqQ20NheKCiETrhXtwjcij36X3P
         qxWg2j9z1fR/0RtamfXo7+okfUzpkI2/D7VFfDq7kZ1pEAOHxfvv2A2apixqiKBnJWF6
         jCiEk+dqZOvm09QJNXg5HZ5/QQYMBJUv6N3uuxSWZe6Yd6jl22zUjUpxKwR+69f0dpEq
         kxQnqZTu+DzkKZWyiSTHwROv9M5ZxafN1EBRfQyBuiGNGwojxVuNtKBuCcDif5p4lyZG
         yILnMCM4ZKYKrNkGy1x9qtngcDEgyNiEyLRcJsFxNVQqsNJb1dl0LpYpn6So6seop5NA
         2dIw==
X-Forwarded-Encrypted: i=1; AFNElJ8KgCuhkJYcgRL/f3gVLxyjoSDFxmDPKlYygPjD60VAmtNKfPa0yPXmDucaoDUoxyXGvuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9q8HIY7j5QLten1owboDeZoRe7HI4hgvHC5ej6TMfdtsuM2YE
	TcodG5PkOeLeTcHIodGxPPWs2utuT67W4ApsTZAfWS3y0lPIQiwOXYeQMakOCnJYrcO397iHF1Y
	EgZptToixcM7Son7gg8s/Ec3f005ZbsFzT5Q0E+togSYtA4UxBTlZkg==
X-Gm-Gg: AfdE7ckNO7CBqWF9ya57D4ZflDN0FafmMhEb8MbdyTjNMFAQbq7RHoBk0AJ5sbi3UO8
	fE4BzfxsYb6gncoqC8ORsVhSRy4qxVH60sULUqBshD5lI3RTEMK0akHSOIWQrlTlIPPm1nDTLT+
	9imii8qsa9JBNe7MVT69wRPkk2niMhXc5BJ2C7XTcHOFuU77DpHEtcALVBvIpxx0ln+SeE4EUUV
	2NmUl+Qq+iaqKue0X8t9NZDEJFG5kujDN28PRRtT32APyksnRyu2ImHoHYtVVMn0/u5Y4F86AEz
	jBz8AXhl4lv+h/Cc3BMZZsDkXi+EKL/xrbZwU8Zdapb60jP41J/YYb1tttOOLS4P6AxR3uQGjZe
	9cwH43zVUAJAHUkzIa2A63V/aGNHc2ffKf8gRbj8SYl+yarG+nQ==
X-Received: by 2002:a7b:c7c5:0:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-4926fca4ce5mr138791105e9.35.1782744188325;
        Mon, 29 Jun 2026 07:43:08 -0700 (PDT)
X-Received: by 2002:a7b:c7c5:0:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-4926fca4ce5mr138790685e9.35.1782744187831;
        Mon, 29 Jun 2026 07:43:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493a7fd1b0fsm123655815e9.1.2026.06.29.07.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:43:07 -0700 (PDT)
Message-ID: <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
Date: Mon, 29 Jun 2026 16:43:05 +0200
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/26 13:39, Aditya Gupta wrote:
> On 26/06/29 01:20PM, Cédric Le Goater wrote:
>> On 6/29/26 13:04, Aditya Gupta wrote:
>>> In the past there have been hard to recreate issues where XIVE changes
>>> cause qemu crashes due to multi-socket interrupts such as in [1].
>>>
>>> Add a functional test explicitly to test whether remote interrupts work.
>>>
>>> The test can also work as additional boot test for multi-socket boot,
>>> initrd boot test, as well as a check for e1000e to be working in powernv,
>>
>> you should consider moving to a more modern nic model: igb, which
>> has sr-iov support too.
> 
> yes, can do. with igb i see multiple irqs, so test will have to take sum
> of all rx irqs, and compare:
> 
> 	2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
> 	2026-06-29 17:00:46,391: 135:          0          0          0  PNV-PCI-MSI 2416443392 Edge      eth0
> 	2026-06-29 17:00:46,393: 136:          0          6          0  PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
> 	2026-06-29 17:00:46,394: 137:          0         14          0  PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
> 	2026-06-29 17:00:46,395: 138:          0          4          0  PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
> 	2026-06-29 17:00:46,397: 139:          0          4          0  PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
> 	2026-06-29 17:00:46,398: 140:          0         16          0  PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
> 	2026-06-29 17:00:46,399: 141:          0          6          0  PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
> 	2026-06-29 17:00:46,399: 142:          0          6          0  PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
> 	2026-06-29 17:00:46,400: 143:          0          4          0  PNV-PCI-MSI 2416443400 Edge      eth0-tx-3
> 
> I feel e1000e suffices for this test, should i stay with e1000e or use
> igb here ?

or use a single cpu per socket config. Which seems better for the test.

Thanks,

C.


