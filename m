Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485083CEBBB
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080492; cv=none; b=RpuBKljOojufuzWGGCdzoNheUNzg7oOBnZ9v5kn8beOjnFZ+wuPYAkflUwSJIRv9wzlYvh6k/N+Y+eqtFMV67y6jfhl+x3vuAraAB/lildpsEV7TFTu0LwlLet8WWE0djWV/dOxOdfzmOYez6nUCkqQyB9OdmOrPb9jBZZV/1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080492; c=relaxed/simple;
	bh=FjxRkcJue2xcxNqyyNIsfUg9aGd+Teqdzz0oBkQ8P5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDrwYI9qiP9/8VToSlv19vx3T8tnrSC8PLH8WOMtFNiJIlaMNx0+6XZW1l0hyryVoZzTm+WHG2iTYkao6Ph39TLkkcF7S7r3ujICVLnqZvQ81S7WUQ5UeoTxftfdAlLgAYkB2F+MzoQVvzVgNmvuxftHZSnReYpqBr2OqcgY8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOsUr6D9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsOpazKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOsUr6D9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsOpazKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783080490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
	b=GOsUr6D9PDfF3rB2REmSTBVFyoHGMLo4hGSjtLtZ+9IL/WYC0GBPD3HtXFkOPDvz16zdV1
	/6dlB2JsZm8ynDLKtJOySIzp2ewEs+E0BMyWspUlmh3JtqYfN/q7qRGuYVZYhSRVWduH/X
	4ZhdIluvcdkVDOx2vJSPVkFM/2kXPwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-g4LC4VoqNyWgubNCXEkjxg-1; Fri, 03 Jul 2026 08:08:09 -0400
X-MC-Unique: g4LC4VoqNyWgubNCXEkjxg-1
X-Mimecast-MFC-AGG-ID: g4LC4VoqNyWgubNCXEkjxg_1783080488
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so4541865e9.3
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783080488; x=1783685288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
        b=dsOpazKd9DbpdyyTD3/IbfQfsteL6Ns3jzngcQpwWdN0W2+n8Vn8LvOYE5gSaEV23q
         609iRDhx29xU+817JRS6BCRo+QGGy/YVY1RW8XA4Xgo/P91bLyRhInGDfwKU7IAamdTx
         7OXUlskhk7n57veFzpcBs8NZKokKbz+DOZ8HRCtL9OISXbyeJNh7C1r8WuBvql4TZlqE
         Iv594Gl80Ut4nyH5ouX09iwYogazPTTzf8p5hSZaWvVhMqBsxQDxM1z3DidUxkLdtB4E
         6JshUJrQoqcizBlaCHB69A6RHHtM2E0R0AnxmG+cTdRqeeD6WjrvxNCfjj6dYuegF8em
         7gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080488; x=1783685288;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmrfsvzbIDRaI6xa2GV6XP0StcNn3klH0jg0iaT217o=;
        b=sbO7nqkOf7Pz8l1XcZdKLC+ytauJIBUa1HrfKsAuRq1HMay4+oeUEEGOpFtGE6IyjJ
         vFSP6r4/r7ehBFiuHkQe2ON+rhKiZtK3SEH0W0rkzpVsYabf/QpXzy54JM66xiBTwMdW
         suMu0Uiu2R/29VDJdpqQx9H/2OJVEeCmDiqa6UgRtCjZSHzrDb6MOdWefMdEQJ2EdRG8
         KzRYSsvGRefNzEZa+5R4e4g2QMhGRjiUaqp8rWYghawGQf0Z44JvXYXM1ZU6vMrH+xlo
         IONwHrHJ/zLMSrHoJFvnro+WfN4rOE4NZUOFncjkqMHshYb4NnhrjsGUG6h0HHVtNhfm
         kMFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8VWWbkja9pJwI77v9XZowYR27rsD18vEsMw5rUDn5p8U8KNZoR121G72c5DwTXOXt/OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNqaA7FxUOMtgkSIKu6IV/vmQafns7I2dNPWnjUukkI4O1riO
	6Xa6ODUyGMq3FI1x7aGpujr69i48lzrO6gD+LrZxeCrFmT7/ljxQZdqCJpHTdyMVVe5DF9zDSTT
	Xbn6HhISIiHlFSj60Ufs52O2TkyVj1Bu+1M27o6KaqMn9ZOPt8XnJTw==
X-Gm-Gg: AfdE7ck5aBaNUOOpHoA61B/235ZJrapk04rZmjDQfYZTAa17xWeF0q1XfEia+AWXTaw
	q+UROdpY+FnKUXZmilabmhIVgld86ORfe3/gTXmUcJbbiH4mDuUW2X3qk3mOunEqWL7qtUUqQXA
	7dRCgOqGai1pnVT6hg9x1rQmHWOsGmGrs8oSYWzg+jp5Pxv0JthG7chfPuiyYKa9bgUCIsuAiIu
	khUTbCWSXkCqOiIKrCPCBhVGOTMPdD2UdPgZZc/+mt2v2DcsDxpTKnbZ6bgDzw4VTQei0BssRKx
	wbF4I6GLwhagqVPnGJTXgPiEHAwcp7m4Hw2WqMLP0pcWLzF0aJ0RY7yh5T7Wx8uXB9ebn607wDl
	Mur2sLqbQe4uvaHFk1tJhYpXP/G8iQ+1IHe0GVy5QayYTPVo1gQ==
X-Received: by 2002:a05:600c:1550:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493c389d4c0mr129164415e9.15.1783080487612;
        Fri, 03 Jul 2026 05:08:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1550:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493c389d4c0mr129163985e9.15.1783080487126;
        Fri, 03 Jul 2026 05:08:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm221287235e9.0.2026.07.03.05.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 05:08:06 -0700 (PDT)
Message-ID: <6622b05c-115b-4047-8865-c18cc99db959@redhat.com>
Date: Fri, 3 Jul 2026 14:08:05 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 1/8] tests/functional: Add remote interrupts
 test for PowerNV
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
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-2-adityag@linux.ibm.com>
 <b1d16c72-3485-4cad-ae51-5db4a78e3a48@redhat.com>
 <akeMqNUv2UlN80cV@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <akeMqNUv2UlN80cV@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/26 12:21, Aditya Gupta wrote:
> Hello Cédric,
> 
> On 26/07/03 11:17AM, Cédric Le Goater wrote:
>> On 7/3/26 10:59, Aditya Gupta wrote:
>>> <...snip...>
>>> +    def test_linux_remote_interrupts(self):
>>> +        self.require_accelerator("tcg")
>>> +        self.set_machine('powernv')
>>> +
>>> +        # Have below setup in this test:
>>> +        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
>>> +        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
>>> +        # 2. CPU on 2nd socket (chip 1) disabled
>>> +        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
>>> +        #
>>> +        # Then ping is done, to generate interrupts from e1000e which should go
>>> +        # to IRQ server on the remote sockets
>>> +        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
>>> +        self.vm.add_args('-netdev', 'user,id=net0')
>>> +        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
>>
>>
>> 2 sockets are enough.
>>
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12          0  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62          0  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0         67  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:          0         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:          0         20  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0          4  PNV-PCI-MSI 2416443394 Edge      eth0
>>      # echo 0 > /sys/devices/system/cpu/cpu1/online
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:         10  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:          0  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
>>
>> A non-zero count on eth0-rx is good enough.
>>
>>      # ping -W2 -c5 10.0.2.2
>>      PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>      64 bytes from 10.0.2.2: seq=0 ttl=255 time=7.339 ms
>>      64 bytes from 10.0.2.2: seq=1 ttl=255 time=0.673 ms
>>      64 bytes from 10.0.2.2: seq=2 ttl=255 time=0.405 ms
>>      64 bytes from 10.0.2.2: seq=3 ttl=255 time=0.369 ms
>>      64 bytes from 10.0.2.2: seq=4 ttl=255 time=0.516 ms
>>      --- 10.0.2.2 ping statistics ---
>>      5 packets transmitted, 5 packets received, 0% packet loss
>>      # grep -E  "eth0|nvme" /proc/interrupts
>>       76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>>       77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>>       78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>>       79:         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>>       80:         10  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>>       81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
>> That's even better I agree.
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks for the review and the suggestion.
> 
> About using 4 sockets, I used it so the receive and transmit interrupts both go
> to different sockets, so more sockets are involved, which I assumed may help
> catch some rare cases ? Also, with 4 sockets, affinity setting also gets tested,
> which won't happen in 2 sockets as we don't need to set affinity in that case.
> 
> I will send a v5 with 2 sockets if you still think otherwise. What do you say ?
No need. that's fine.

Thanks,

C.



