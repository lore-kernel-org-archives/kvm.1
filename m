Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B813B3C08
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356832; cv=none; b=mClLZJcwHWs/6TpAcFbYqH3jD0ts7RHbHC2Xcg05hEnlMBnKhmUt1jnJdV8yy2rXk62629Zk5N9Bet1/bC5lwdMHnZVSM3n2YUtMrHzxOpkG2psAUyFlUimsjUSQy/8wnNCT+aAQCYytk8p1Eshn+TFg4hFtnoLSfXKmzbmHxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356832; c=relaxed/simple;
	bh=MeXfYhzXMPHdPIsGXHtVw7BYqOJa1dL6Rn+GgOZlz7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R17RWkw53UZhhV1cfsLcS+4OzUtXLuwah51fjWpK2pcGtoYSEbuM4/r96VuJxuibpLdMP65aLX30ccAd8bR9GRWSAlor8Mto3RA9xBKJ5mN+R01Qv1s9qjW5T7ZowKPiVzyL0owQ1Z/aT1m3hseu5EBSpuPXQUIsUS1yG2ZgEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRdvf8K+; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRdvf8K+"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso1440759a12.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786356829; x=1786961629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9UaDyUPuckC37zrOmaQcbngoaGVbYZA3xXl4q/mPgY=;
        b=FRdvf8K+I7qclGg5uIq0LHNyluPEADM+3bxHl1bwMqN0RXcePrpuoD4E9tk+/MURYY
         vyTl4YsKC01qB5eWB+tGQ8mCND7Xb5rlpVYqkSYf8pKEvn4GF2hSEu/VjPwaODB6CTBq
         wOGfCIWBKKEweoNniwqGsbVry25k+KPcwYvoDqQrbikQ2yNNgdPR2j9oL76Cd5y/fRwl
         SqlgM4E+AmvT8ybvpaor64/JaNiFlpZZrA5XCBdbKMTTQlLuPR1iQsq31MjG9JLwHy0Z
         ybs7hx6Ct7+dxYZjfDzFOe1k9UVSuIIKjrJ+PIq+Zue/kdtVoJULncnDCNzRcZk6YsG9
         nhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356829; x=1786961629;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9UaDyUPuckC37zrOmaQcbngoaGVbYZA3xXl4q/mPgY=;
        b=UKyZpKMMB7Vz6duKWAtqTjSVnLVfflVCwCaZImqdH/j7nrVgTJnMCrnTwjANnBt0IV
         1xSJ5KCbTpkIijAHU4RqPkODG8m/d4kXH8FS9FZp8a1aSmZQVEZvVJDZxIMVY2AD1x+Z
         K2M1JpTpUQMUtIvZ5th2uQcwejFL2wo+AdoTPZ9g3wHAIvF44CcMPG7FgW1R8I/G/i4/
         YEsBbj6f60Z45tjtAcG2M4jkYmGJb9uyJWlALlfLZWWxKf9/f5gSnlr+7uefhnhTSfqV
         gEjxAQNq2Kc+I0n7PpD4Lzc3B43euknTyexzQ09Veu0+VfmQvLlmIl9dJmEA+I/yC4S8
         En0Q==
X-Gm-Message-State: AOJu0YwTpT00xXGpQfeBThu9xUXuwxsVHxK3fuEMMlKkIxlTykkSXpnl
	jMNouYD/QllPjabNVidvYcJjWSz+H+ElMKRSPRSbHkD0vOX3pwPQ6hg601Ls66KoPHqrXQza0F9
	pY2MPFLV5hi21QAoV1Q==
X-Received: from edyc9.prod.google.com ([2002:aa7:df09:0:b0:697:8356:d9d4])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:24db:b0:6a1:feb6:6d78 with SMTP id 4fb4d7f45d1cf-6a1feb6806amr5150242a12.18.1786356829111;
 Mon, 10 Aug 2026 03:13:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:13:47 +0000
In-Reply-To: <CAEvNRgGHuiXG1KZ24+kX-ZgTS_rqGPFqJMjoJhqf6GpZh4xN3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-2-tarunsahu@google.com> <20260728122245.AA83D1F000E9@smtp.kernel.org>
 <CAEvNRgGHuiXG1KZ24+kX-ZgTS_rqGPFqJMjoJhqf6GpZh4xN3g@mail.gmail.com>
Message-ID: <9huzjypy8eqs.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Thanks for reviewing it.

Ackerley Tng <ackerleytng@google.com> writes:

> sashiko-bot@kernel.org writes:
>
>>>
>>> +config LIVEUPDATE_GUEST_MEMFD
>>> +	bool "Live update support for guest_memfd"
>>> +	depends on LIVEUPDATE
>>> +	depends on KVM_GUEST_MEMFD
>>> +	default LIVEUPDATE
>>
>> [Severity: Medium]
>> Is the implementation for this feature missing from this patch?
>>
>> The commit message notes that this patch enables live update support for=
 KVM
>> guest_memfd files, but the newly added LIVEUPDATE_GUEST_MEMFD symbol app=
ears
>> to be unreferenced in the tree. Since there are no Makefiles, C files, o=
r
>> preprocessor checks that use it, this currently acts as dead code.
>>
>> Could the implementation be missing, or was this intended to be introduc=
ed as
>> part of a larger series where the symbol is used in a subsequent patch?
>>
>
> Sashiko is right here, I think this patch should be squashed with the
> first usage.

Sure, will update it.

>
>>> +	help
>>> +	  Enable live update support for KVM guest_memfd files. This allows
>>> +	  preserving VM Memory backed by guest_memfd file across kernel live
>>> +	  updates.
>>> +
>>> +	  This can only be used for the guest_memfd that are fully-shared
>>> +	  and pre-faulted.
>>> +
>>> +	  If unsure, say N.
>>> +
>>>  endmenu
>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728121138.1=
103610-1-tarunsahu@google.com?part=3D1
