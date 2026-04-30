Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6F44CAD7
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576121; cv=pass; b=Q9DyatLrgPYwtE8U/d9efIBDw1PDLjNb0HI4PxdyprqQ63HkfEECZl04WGv5G7bupiRkIICDY+0lhA3yThidXZPVVnAkRYaQj2eU/fhdG1VTZh8dKP9jBAxG9NLCnb9H2Av29ftpoJ8MxNMU8tCkr711V4D0NkJ50Dh7FwePFjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576121; c=relaxed/simple;
	bh=X4b436mJSc2e5zCmqm/XVcNlU4gkcHTe2W6C3nsY/bs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXXjmbgX8SCszXa/8LoPUZRdXNltbnwgTBSCrl7F34nUkA1qF+d8Ndl/geqsaDRJwFwIWbYlf1Ep8yA/NVOJu1DshUYrOfuXBLbbyvXWqoaWxI/hrCXxpaNgMpfCZ5YW8VvqCwcnFcVVxIQxRmh3irYPgF/wilAvam9uYCC4KTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMuEgC1d; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMuEgC1d"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-61399bdd395so449051137.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576119; cv=none;
        d=google.com; s=arc-20240605;
        b=ThJ6zBNrkvIxy0MGy4AnjCnkIVVWW7lrZFHuYxlcUic6mLPQi7GAKhcvE3WGP/aq6w
         /OBN+ywoz6ryrnVYI5tzUQbaLyAeUe4rz9Oh99MjBs1R+wiejWiZ2qPWPDElOL+OkGBk
         k72USQX+zr672xhQshsk3Xc3uc3TlTVj9q6OxLMHWgA3DNA7kbY9VV8cHrdBAxiEBOgn
         kDrQj6R1rpTJgR4TGl6ie4uFQbH1Ps4rL3hoPe5aj5bTQXIt7wJYmuq5qo8RvC04uwUU
         zim13BHmk6xXn5ED+kIsq+0sfrkCLr48cMq0HuRW4rYDr8CS/M5FvdEKLS7tjU68HyIP
         Yn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MS1gYH0EEQHk/k7ogIDcV5mXUN+JyX5QDT4VHKpy/LI=;
        fh=M8c8dEgvPY2dtjfB17AaN+jDmYcrv53oqp65IgI7iQg=;
        b=HMUlFBJFTk39xI+Z4dfTMCzYnAr206OnO9yDLMpTq4kVl2bBKpd5cKFmrwoqw0LIsa
         vquUjIE6K/A2txEu+pDnLViya2SizsueptPqnxGYvscg50YcZM7eJDQkYsUjuLSbBNQU
         VbD1wuqwEUS2y4KVY7iVaQwokEL0ymImSgmeWqsnJZd0EYw/2joH4mq7sy1/ICntbDup
         PIcA6px9smLbDLY/TG0Ihin5q6OEEbquViiRo4bcFPL8nYz4ceXmusNT6XrSHDZR5Lm0
         aUO3Yn3EadHNe9FJC8y7+TC9y7hCdC+KaoIjSENZZkL5M0Qr7mcWz04GwL6FP2OIKXHk
         ioBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576119; x=1778180919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MS1gYH0EEQHk/k7ogIDcV5mXUN+JyX5QDT4VHKpy/LI=;
        b=AMuEgC1dnXwCxdD1vR8Y5C5/mJT5bcpFifdTa/sz7GdicH6q9sKLmKj/nzzqlmC2Hz
         iz/6xcEfrtaxC/5/gUHEh2mGD6f5QVu8x6yGRzvqGYw80AwbxehvBeeWwYd5AXO+x/3a
         6axWYfRK0ldXBaxXjt2YQKmNmvQ3vjfAHnYl8eqLjk7kyVNFzX05DC+2GF+7Bn9/5xuT
         K0Q5dElyJR1PuupZs3lMhCB+m00WpDD4yR/FiMMOXT3nY5xsjh6CvLft0na+q5kiRiuh
         wgtvTwXm/gOqnMC+/8v9ZtXK04efvdsUnqmD93wsNwjIqraiDvtt6USTdbA7g0jm/uVR
         lHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576119; x=1778180919;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MS1gYH0EEQHk/k7ogIDcV5mXUN+JyX5QDT4VHKpy/LI=;
        b=qrvpSZ5h4gAx60aLUZHPACy/ZzbftkRTjChhUxG5S6Lvc5J5OtUPBT4hpq0G9Ni7if
         YTmwIGjrezl1oqrMvLQFP1+tE+qlvdLYAc7nIVX5krmhjtHHLvyGBO/XOG4vWTYTWo+h
         7C3h345Zzm4a19jvJyKOAVze85JXZHcoAUFao8wStfHGd84L1GJ7ehjrKogkWnVwHKJd
         rUDCsSQLPbDiacEV4yOZynbai8hkxX3UB6Xop0tC5vtMp4C/VPnwH5is/0DhguQ7QAEX
         rs2/sXlspJXgMI90D5xKoH1tx5LhLm39/hiwCo8jBqDWbPIvvsxAOGHGxHLzE6Fp3lk8
         CfqQ==
X-Gm-Message-State: AOJu0Yw0LFV9QwKx9MrwcOzm80W4+sn94rN5faqdNIIDwOJ4if7HFplt
	XP4QU4SOwTszNlaH/26/dsZEihmWBhLRbeV6hc1ObvPkUzQ2sCMQdXYJOqMOCxGX9AQBMJiLMGQ
	HImE6pTjOkA7rd8XferaYFuzvuahKDNP64p4mJf3w
X-Gm-Gg: AeBDieuwnhMCNe9NpaL1jFMdyDiMnPwASiyObnpJ97M1RDc8WMY4fPFBfwklA0MaE4r
	qodADVe7y+6IM71bPblm5UGgZSA0AB1DyTBAXl0pDD54zLGFdvhhxdF28De27EH76+T6GbX2baF
	Q1B4cdtZJQlrIUWJ4okBwCncjfXe32yoZ8KtO2M+z0tRSYPsBm45kzHxk292FYra6uV+Nub1SDE
	Fi5TTJK6Qw1Kj0Dbguy7MnQIdwRkrwOaUSgV2BUKTQbTna3Zb9QYtjghzh/KHWRmEUsBJh+4WVS
	T6J0y+9yv1KFo0rmqwe6eFHpM951/kJwBEpTXI6XOGwOFhh2Hrk5DJECAURgFoY9MOp0+s4FD57
	ySaDlgE2XlHW9wsE=
X-Received: by 2002:a05:6102:8027:b0:602:aac7:b8bc with SMTP id
 ada2fe7eead31-62add580593mr2693451137.30.1777576118698; Thu, 30 Apr 2026
 12:08:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:08:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:08:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <d6a90fc2-baf8-47a9-bda8-c21e55523677@kernel.org>
References: <20260428171541.1342335-1-seanjc@google.com> <20260428171541.1342335-5-seanjc@google.com>
 <d6a90fc2-baf8-47a9-bda8-c21e55523677@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 12:08:38 -0700
X-Gm-Features: AVHnY4KTCtzN8_85MDAjL6RZzAWzw9IyNgv7fvXAz5F9oXO2B9lsMWKUb-HTs0U
Message-ID: <CAEvNRgFJfxf6Q9PNj7JFscgdH_obAvZiFgn7t3zVzGTo7u+tJw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
To: "David Hildenbrand (Arm)" <david@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 4/28/26 19:15, Sean Christopherson wrote:
>> Officially "reward" David with guest_memfd responsibilities and authority,
>> as he's been instrumental in pushing guest_memfd forward, and his ongoing
>> input and feedback, especially from an mm/ perspective, is and will be
>> critical to keeping us virtualization folks from going too far off the
>> rails.
>
> Thanks for the kind words, Sean!
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>

Thank you David!

>>
>> Cc: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9eceeb6f699d..8dd5cdbef66f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14399,6 +14399,7 @@ F:	drivers/video/backlight/ktz8866.c
>>  KVM GUEST_MEMFD
>>  M:	Sean Christopherson <seanjc@google.com>
>>  M:	Paolo Bonzini <pbonzini@redhat.com>
>> +R:	David Hildenbrand <david@kernel.org>
>>  L:	kvm@vger.kernel.org
>>  S:	Supported
>>  T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
>
>
> --
> Cheers,
>
> David
