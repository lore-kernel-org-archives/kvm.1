Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E472D7393
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611366; cv=none; b=LPO6uNmzQzO1rsBdGiCNv7OEu6Wyzhi0yv9xgxlKngG8KefR+Rhi0Nqm+0mNI+YGRUiY5OApfV203qGWsHeDkaZQbzS3WYT1qL8Mnqs+dkKqRjh1okq155hLga+8XegPNNA29rJckKJnMYc3tXI9YDqIHgWu8WdzGKaSgxhUlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611366; c=relaxed/simple;
	bh=lIBFZalrvHEtV3PAEEQ02dJPGwYTfTVA6Xw58U9DdxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IaNyZw2h7XE+b8fSO2Scnk5+40aq8gHYGnXgtNRnToa7v1PEONa3c77gf9kgh08meAlBimRYVRqsI7IdOcWRWN/M+ih0tKpsLoTUhdxF3XTp8J242wHj2hBb22/8X9CE3MZnTxJs34rem5RO0WX4ZGPEWEQC0JTJhfq/Xt8/Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbuQwS8n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc+44u5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbuQwS8n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc+44u5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784611364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/RCnihBnKFdbSoMpJgsxPegdopzZfOK2UlCIEXz2Jrc=;
	b=HbuQwS8n0amVgxuaKVtzsW/sdHHl45AptfFnXEJgvy4M1VGB6VGz2bckAr556c0rZ7EhGm
	+Os0Gxy6N5bPx0GCISgrGdCkno1Ewu0NiJQzYaVIl1VPiACK2S859u/Ij7MEPazyz5JDQ3
	c1ULNRutNWoE6LnnljlYEdu4xlHOSCk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-BetBEYIJNBuxbC5nH7bDAQ-1; Tue, 21 Jul 2026 01:22:42 -0400
X-MC-Unique: BetBEYIJNBuxbC5nH7bDAQ-1
X-Mimecast-MFC-AGG-ID: BetBEYIJNBuxbC5nH7bDAQ_1784611361
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955d314945so11470805e9.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784611361; x=1785216161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RCnihBnKFdbSoMpJgsxPegdopzZfOK2UlCIEXz2Jrc=;
        b=Hc+44u5vhoPWoNq0TZeflbDm4L7s9v/r+WwhUCqTr/NAFeuAaGMP+gC6QXx4bZPcdR
         5OF//LAzNgvvGFRiVTdDyOezeCTnfdsor/Yo/irOlXzyBlXEFkKO6BGQHQx9ikloozKu
         e7oSOeoKpyASdIqzwUb+ymW+2sAPt4c7KWLTlVFy8BfuZ1HaS9A6M2rTT7uLdu1mYnw6
         1qKXDCvk/6GC3JG4fGEKVFRlglj96fA7OwEk9KrHDBbZeuXf5TEFlVex/mfws4ZH26nw
         DvqxIXNrG1mBwDdpL+GiTYOKmZaS8ZSkMotnCqooOk7xcTu56Klaq7pdzCiJRaoKSjZA
         nvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784611361; x=1785216161;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RCnihBnKFdbSoMpJgsxPegdopzZfOK2UlCIEXz2Jrc=;
        b=HXVDO2/z0mjNdq2sRhGdtcEZH/05CIeQ3r4qJxIbAiqz92V6coH9w4cjLztQLrfUzP
         GLxtlWK7vNT6itR8qX7Yyutqj98Z8wOF+unCPALJj/DCA4sEXFMJd3iMU9EFyb26e8hI
         vhM87vLGATHNW8VcBc32Y6vlhDuUZ99OJTavpnGTB19ZeGfKmVIkExyqYydDy5NBgNZS
         ux2lQ+hWAEKpmHZrLdPf3hEZghLpos+Oli8OdqJdo1Rev1Sn0OK9JQfNWty842zDIn19
         D9W8sPLh+/JWzsFtxppOgFd42YtkCHcJN7TEHy96XhacFhekch/xbyX8Q+5ZiJi0US78
         z38Q==
X-Forwarded-Encrypted: i=1; AHgh+RpqAwZ9HxkJ186TKNvyjYOVjEPH8JlLTgr8cAfPeBn448apmZKI9bxk2/KpI9VIE6mzKpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXo+BTkKSUXM7FZF4J9Zmud6Jelzc152011yfcZqqFsHqaevE
	ASDXb2wcJ7lmUX7O6hvGwMyArQ+EOYDvYB/4M2DDSgIzRRjO50sDQ8/xL1bQ9Qftk97AZ/Noybz
	fhUxxFMBLrmhpaL0YZDbcesXruthhO34bf/Gz0fguTRTaZlWjCtMw3Q==
X-Gm-Gg: AfdE7cnWgG14tmIWz69kgtBGKtp++LKR/gauW3EfYgqj9nIaRJ6T329aJvvVBhMAfSU
	EguGkiLEtEBRXZulS1VQW15RRCHlII5FccKiEUmNu7zi0Dw08JwTJC+OwwUu0HH2NjMhoDAdhuG
	xW+tSPvhdptvgfBIhK4BXssmRg5lo3epU7J3I0bucKBTMGXbzSUeaAa7lO49WVEs6obOmBn4HsA
	XHhqUP3ozyrY+UUNGUGYmSI34bIbV5kaifbuSXNdS8uoiWdVyb8A2G5+UJxaYn2rBX3sD7eLupw
	zkndv0zT5nKMg5gQ4EMdYuMNU21Q/IoP1UInLt1lgZx5b/Cx0pAngTnfXaCjC8/KynT4hepPMA=
	=
X-Received: by 2002:a05:600c:4f12:b0:493:f0f5:f2d2 with SMTP id 5b1f17b1804b1-4954a3d0ceemr201220715e9.1.1784611361441;
        Mon, 20 Jul 2026 22:22:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f12:b0:493:f0f5:f2d2 with SMTP id 5b1f17b1804b1-4954a3d0ceemr201220475e9.1.1784611361081;
        Mon, 20 Jul 2026 22:22:41 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653698bcsm36469925e9.2.2026.07.20.22.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 22:22:40 -0700 (PDT)
Message-ID: <52ddfff0-f2e4-4302-94d5-aa4f2c5ba3fe@redhat.com>
Date: Tue, 21 Jul 2026 07:22:38 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and
 subtest selection
To: Jim Mattson <jmattson@google.com>, pbonzini@redhat.com,
 kvm@vger.kernel.org
References: <20260619152006.3684428-1-jmattson@google.com>
 <CALMp9eRRMga2zMrAK8-bbxcjWwyW-W+F1KE5bJqXLQN6eR8bog@mail.gmail.com>
 <CALMp9eSjp6r6WwfOt4PPzVZ+QZmfbSHZzn-m0kRYToy8kK9MjA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: Sean Christopherson <seanjc@google.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CALMp9eSjp6r6WwfOt4PPzVZ+QZmfbSHZzn-m0kRYToy8kK9MjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/07/2026 01.07, Jim Mattson wrote:
> On Mon, Jul 6, 2026 at 2:54 PM Jim Mattson <jmattson@google.com> wrote:
>>
>> On Fri, Jun 19, 2026 at 8:20 AM Jim Mattson <jmattson@google.com> wrote:
>>>
>>> This series improves the robustness of the APIC test suite, introduces
>>> generic subtest selection, and adds a new test case for a PV IPI boundary
>>> condition.
>>
>> Ping.
> 
> Adding Thomas Huth.
> 

x86 is handled by Paolo, so I hope he will finally respond.

  Thomas

