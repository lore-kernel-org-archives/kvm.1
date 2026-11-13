Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571445;
	b=P5Nj3BLmt6CV6EUuq+hj4FrtQ5zEbsiTUApqG5nKyNpxSy16KXnKwmg5uttviyxxVsb8
	 L/u7TRy/q3VPh8xAiIuKz/Dhf1lVv7e8CgJ3d5JgBf33P42S5uidASxgNwV4pcjjZjD39
	 xaeUdlr+FySGioCdfy6cOP2Ab8rTVnQeC2iS9ZNNjwbJpQ1ym2C9MT3Wr8A4CW05Pwd8T
	 wGU+8+63QlRTKqOIr0y/IqYg3UOKe3MM1O6S4ASQ0NfqDDAAWS64ZooqyHvWMBgJmaFDM
	 uLlBpqHb4jxSEXs/XzJkmO6FwMkcTShgnWGLuEZAYlcMteQ0YQTEf130EMLhQE+cQ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571445;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	b=ikqsPuSH2dAfXQ4e3TdQilyT28/FohplX/O3jQbkzE/JBdgI49fMtJ3yKJDF63O+ZBT1
	 p6szu6R8Ni6iFZpYMdziTgUowxF+9i7tCd1/D7k/rs5QGyVmNRo60YW3GUXfXmO0hLuT2
	 aCismO14JdLU2qwrVR9Ajd/gLQl3PzNSZUKzX0Fc14cwUdD5sWRuKV7NWuCKJoGXE1CuI
	 GTfvhXklxCLxxGhQI+VOLGyWGZWiNLrcixtO+4GmzIllOiypi1sPpyc42XDKQnYcgAXaF
	 SGcpMfe59nA7AjYsqqw1MhqSHPGXeB5stwM5NRUtW4RdMq/uEuHi4uejuRzHTs955fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="EO/vU4yk";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE606A8AF
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 12:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490BE606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3WUoynU;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EO/vU4yk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794571444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
	b=b3WUoynU+xYy77iKucujOEClblu6BnVpmDkjnUNrvt0rV/yne/HsVWEw1IwB7AFJj3GY56
	CZrXjSa2iWGgMeHOoT2zPro/PG7zeX9XUjqUefgmbNWHXh7K8WFMpIz87DDC8GTItA2TDl
	yhcri0aqIHWfQE+8KcVlgxOIHzAT6Q4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Has0ngF4N8GsXj2t6ILnTA-1; Fri, 13 Nov 2026 07:04:02 -0500
X-MC-Unique: Has0ngF4N8GsXj2t6ILnTA-1
X-Mimecast-MFC-AGG-ID: Has0ngF4N8GsXj2t6ILnTA_1794571441
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so7289625e9.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 04:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794571441; x=1795176241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
        b=EO/vU4yk+rYV9XedZw1O2u8JQPWBtEibTMA0h0oN4A5gFXD4mF7W2BHnjsoT7Phr7t
         9CACPKQPKq2Fqt6vTOsEzeVq1oHZqqIyPIwJHfpEnNw4X7vPuDWiu7t4aKzhwM2bRWqu
         JGqoF3xi55WZmgn3mPrxHqcElvr27Z9cWJ3NwOO+7cZZAxTTR8pzDKcTIT5/hIjD/OrL
         8Xy54A/H3E2N1ah2oSZmMqN2INc1RJSHOPiqTP2p6zfU3RUFxLBw0ri4wYqv7ZC5ciIg
         xoxu91QukXWaiYSzTfHJ8SS/1DuxzunMnKMkpc47AO+pWmnCQ4l+dk14SPQ00GJOWkKx
         BEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571441; x=1795176241;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgx6q2Uejt/yyraa52WF95rjtybG6YxFla96nvKygLs=;
        b=kORsq22A3w9OH7/W6CvgdzYhprdclFIFj5RjYtyITZU4goa+vv0lCbReucgnOEBPc7
         jZ2dfMxgLKEnh8PSWigHQr9/SuVt0/cmBYNWrdqFl0nj9LTf8YksRBISKuSNxx/9EmQd
         KTcNH/EVzV5xbD9SQP7Jy0Nxy6K/4d3bBJDULy2bIkXCqTprSd3ZWPvTqtDCB0syNibl
         CFNxG4m0Mp0w+2v8tAnwuvSaROx+bFn7iVmKJvWL7sw6OeMDUr0BhuZfqqdLC5DGXWD9
         0DUMs+cJIFSqKEdkv91KzCgDGo3zvmJA4HEh9BDelHShsxayFfoLkPxtPaqM+J8eB5I7
         Hzog==
X-Forwarded-Encrypted: i=1; AL+hErEv5HBqDfz8cEGMGdeXeNru80R+lC+NQpgBVW7R6hv+1IPCT5G0qMokM2jJCwxbG93x8Bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zIN0N6ijedGRtt2fGZ45tml/Tu6wSiQ8XPTA7oLT9KeWCXde2
	inrs0P9G6MiBrpjPtvQPRQqT7yMQZpM6NaYVMyxxvZjMuY1+W8HuySwzqZBVoxFHdveXn0XevYO
	u2WHIVBcrOkpOU6Wx7bSyO85WPHAQefhP85qgUg32i7WLWZ4lFFvRjA==
X-Gm-Gg: AYBFou14gcjzMaPrgOgG8UAN7jF1pCMy/VcwdjJHZnYNCN7lTI8ktjmljX3KUcgGnZX
	/BAEek08eQiwovefVymwbhTFSjqOTPO0A14sH7Y+xWj4jdZT3BL76sqAJi5KqSHw3wMA0NcClnH
	XLSUk7XYVaam7dsWeDgTD3nqY9Yd4NnAlc74F1DIo52l1DNQsb2T2h/K24djqI2m4tYUcE5bLgl
	htFAGPRGv8joag+Y1cZzDBLg1K2qnnwZqO4TiXKxIo2CemzR1s3NzYkiLXEcrRildPwimYjXfrv
	ZdBqKqFJfj6XpLBY8duhePNNTH/d+6cp11JdX9M9FgNmAmucqs4Ao/YiveN3hMHOZXdWibyT4jQ
	ix1lQvyPqHjdADOo++mnx0nzPbUWw3g==
X-Received: by 2002:a05:600c:1c03:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb55a42fe4mr50493015e9.5.1794571441018;
        Fri, 13 Nov 2026 04:04:01 -0800 (PST)
X-Received: by 2002:a05:600c:1c03:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb55a42fe4mr50492575e9.5.1794571440636;
        Fri, 13 Nov 2026 04:04:00 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae4414sm60149395e9.9.2026.11.13.04.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:03:59 -0800 (PST)
Message-ID: <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
Date: Fri, 13 Nov 2026 13:03:58 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
 <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.11.26 um 11:18 schrieb Amit Machhiwal:
> Hi Thomas,
> 
> On 2026/11/11 08:54 AM, Thomas Huth wrote:
>> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
>>> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
>>> test binaries:
>>>
>>>     /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>   Hi!
>>
>> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
>> 44) ... which compiler and distro are you using?
> 
> Thanks for checking!
> 
> I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more details
> are below).  Are you cross compiling on an x86 host by any chance where you are
> not seeing this problem?

Yes, I was cross-compiling, so that's likely the reason why I did not see 
the issue.

Anyway, could you please check the following patch to see whether it fixes 
the issue for you, too:

   https://lore.kernel.org/kvm/20261113120101.145183-1-thuth@redhat.com/

... that compiles the powerpc code with "-fpie" in the CFLAGS, so I think it 
should cure the issue, too, and it's likely the better way instead of 
suppressing the warnings with "-z notext".

  Thomas

