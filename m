Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F52E7F2C
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221933; cv=pass; b=nwYVWrnqDGcDkomkxyMaKkfAbhR5lLD1bxd2JYJBbyy9K55Mc3okO2S8NW5YZp/u17YuJGyNsPc6ZSqHTJV+EozeIlEEEyVHItpePsh3WMhn541r1ssyzNFxKNSF4TVxdGLHAzmIQ5CNBVE9hB+ALD9mCT6nZpniZqYwSPWBwEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221933; c=relaxed/simple;
	bh=qIwGtbbIYOUjCYL0DiEfUhZ2+eW3Zw2GTvfO7SWH0AY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXCuGUJG+obvNT4MuIyb+Rn4ZX948cWDzAVggqDcwWIBWhzLfbMw1ddbTRd1ee7pd25viWV6mByJMgP1nYm+8ecvwZF3/BiW30YbIXXEGpr8vZ7uhcyE/QeGGlO1IwbeShniljkIBjmV+jJke1YE/Jo9/i0RGiUtRPtNG9NA+Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIQXhuUL; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIQXhuUL"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57516e08474so3180098e0c.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221931; cv=none;
        d=google.com; s=arc-20240605;
        b=bDOkeIyJ0FjyB5lDXVAvTbDdX9SNvGRyzzH9G+2k38CWDli4V3HzdAHeInSuDTmX+1
         c5QaKSKEjzAeZf1QQDl594Rym0sb1wcHLuhDnso3gYc45ZYoW5E5+xx0E7iIPwdqOVcz
         FGQVHqX9/Ju8cPH0CVBAkOyVy3SjStUcW6nSxRImyeTUN/KTHTSX+oGtVs1JgCWn+x4W
         XWYu4QJpH6hv+NX0gawtw1O3ddU+tzR03O4ZRl3/+Zr0J7DL7OWqYAkspc5493yjICfC
         XWqhhen7H577ml07jSaBZEN1ov3Rua645He22GO6XzkK7agcCg0FkSPJwTKnoW7/U62X
         jusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aR0ZMyUG0ozy7DkHe3z0/p/wjZOWH9x6XEkI9PUqxBQ=;
        fh=m5NwbnW6ENv26W9wtUeeYkJ7a5JWtBSQ/Qb/Bce96q0=;
        b=Mk3Rm+dEsmik5+gRk2k+vwdGLl1znyHvnMzR0/p0X4Cbc6mTSKjI4JkppQusCCvswR
         uLD1YMxQIETHvMhjDIMpHd0exCqudbre3nOd5uBqdbSvSa5KBcuRbIp8ZINqCr6CfuBL
         BD6ZNK0xgqoiV3ZPprbq7eTjh0oB20jm7/ZncHbQEQzJhExh7WmfLOAJGAHN83sj2bsJ
         Ocxtt/EuJ1YXCs1Ts+Cv4loCTUcSTEnHmkXRJABfOx6AhAyZ28Aq9zv+Xu4YMoj023wi
         A+RL7gsNKlE/ZdJLGbjXRmLZhGIZwo6l8VDIyiFoHTSIJMc/uAjuWwHKBy0wRxtOppCd
         lo3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779221931; x=1779826731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR0ZMyUG0ozy7DkHe3z0/p/wjZOWH9x6XEkI9PUqxBQ=;
        b=BIQXhuULMNWYjAVkHUVU6ySKL7TXZ96TBcXdDbXCb8dJ1c87V4oPyigq50MrGLqXBM
         HpPF++ne5ZQl9LWNnuooZvI14vcBX2U4+5qwf7/HX3m2c4eXe9l1unwWFebjubNYd7Z+
         u/l4uY6Z8ddLmpkrMd4i3xBaNElHMLhc6Enhk1uE69pg7Y8Pm4q7stOyYUgsMpfTAytK
         33v0nPjSc+UvJN7Itgip/3jEc5GDPNBULvIJ1GP9aND8PJDK7kr9ZVdo775W9DSLWfx9
         LHgdV4COxxbRaJhgyt7sU6y2Y1ImwYSkDV8Mb8B7b2jWB8/iLm7Ww54JJo058phJit8J
         BbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221931; x=1779826731;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR0ZMyUG0ozy7DkHe3z0/p/wjZOWH9x6XEkI9PUqxBQ=;
        b=qx+IaDpzkA6DdpP0K/Ere+pnKPyaQ7zfwLgXLfjf6bKR5I8/o+MFDuyhDCwVMyN9uF
         j+EJvLXsYFGatM46ataUgHKinP5Ny6nrMAMteIe7eiywHYySZwOCtDpuQboi0HVootPo
         UG+sqGKWCR+BzEZk17mEeIDMVOKTq2hgNNGjm4uINoCVFi8jOwyKDXSFe8lnCVMCMtqN
         /bBb5D48Jfavmrbys2Zpm3goGlztvb/xddOSq0/W/eVrwOXYK8G9NVUPjp9DJjR0dJQb
         c03TefqWnRAucCOYGFzdu1J06XtKTbqntnIxLTnMdzoE2YPNu+yw2xh6ke00IWPh9cwx
         LRng==
X-Forwarded-Encrypted: i=1; AFNElJ8DqJXziHVtUcISdDlg/UFITixlVqrmrWiQJA87ySUS+GNn6miyLOCZOCWiaHzZg9ZsO3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9M3OXMa1x6//TtRHs2M/5O4kSifbC6kR58nav1JKUFjz4Byn
	jvuPAYxLItADPR/BscqBG33WMwg4JFBslq/MjVDJtg5bqLwmsoMzhihuDKKNE/qaJOygPVey3h2
	SwXqsOdgzisRKFKeM5MWtx2VZuyMDIKxbfKN+8RRI
X-Gm-Gg: Acq92OFzDJJQRLQvDrHjncLMq2xNj3NKBc4Pls2qFpLrCyLRIRbeC0Y/mI4GrzATe+x
	iHsri1J3fldIjiQHZFOj5u84J0sPbmysWEBLVzsPbbj4NmThx+SO0+dK899JoxH8TswtUjTl/pp
	4i7ZXSM+qP/oL7heb6GzuUh6MC7Eg1P6Fczr80d1d0b1MNX55aE2v9MOV5aXTpZT1X1a8UPeBIO
	KzyHt+92igLQlZKDUM3tli5M6hK+5+DniQCXJfVN5K+21b9PUsv5qRdoOg+IlLYoSSR7wyTIR8g
	YF1fKrUkczqSupP4VVw0GMlnni/GELSIheQ3RVun180d2c/Rp6qUqQ1CoJHOr+1pe43NNm59iCN
	S490a
X-Received: by 2002:a05:6122:3b87:b0:56d:9f2a:d6b1 with SMTP id
 71dfb90a1353d-5760c094366mr12403209e0c.12.1779221930921; Tue, 19 May 2026
 13:18:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 13:18:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 13:18:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <agOMfpW2Xxpzk-D5@google.com>
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com> <agOMfpW2Xxpzk-D5@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 13:18:50 -0700
X-Gm-Features: AVHnY4IUGrkVyn5ZtSAcdF_mZPpnt14rYBEsp_-8E5dO-1OBvH16aNRh83QJgZ0
Message-ID: <CAEvNRgEpy+d=KTSVcO9svAS9asHCDcwctGo=9PAaFVMUCd-Wrw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] selftests: harness: Provide global metadata
 pointer to allow clean teardown from selftest libraries
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, thomas.weissschuh@linutronix.de, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Apr 14, 2026, Ackerley Tng wrote:
>> Sean suggested using setjmp and longjmp [1] to back to the top level
>> TEST_F(). I looked at [1] and found myself wishing to use TEST_F() the from
>> kselftest harness directly.
>
> Can you elaborate?  If you have a need for direct TEST_F() in KVM selftests, odds
> are good someone/something else will have a similar need, sooner or later.
>

I guess I like the consistency of working with TEST_F(), there's also
TEST_F_TIMEOUT() and friends and all the usefulness of the rest of the
kselftest_harness as you described, all of which will probably need
re-wrapping if we proceed with the approach of wrapping.

>> Also, setjmp/longjmp felt like it was introducing state that could be messed
>> up easily.
>
> Meh, same goes for the kselftests_harness.h.  I can point you at a half dozen
> bugs where enhancements to the core framework wreaked havoc for unsuspecting
> subsystems.  I'm not trying to throw shade at the harness; there's a _lot_ of
> goodness in there.  My point is that doing complex things that impact a huge
> variety of downstream users is going to have many sharp edges, regardless of
> where the complexity resides.
>
> I'm not wedded to setjmp/longjmp by any means, but for me this isn't a compelling
> argument against the approach.
>
>> I also found recent work that removed setjmp/longjmp from kselftest harness
>> [2].
>
> KVM selftests don't support building with nolibc.
>

Not particularly against setting it up with setjmp/longjmp either, I
think the discussion here is mostly between

1. Wrap kselftest_harness for KVM
2. Improving kselftest_harness so KVM can benefit from it

setjmp/longjmp has already been removed from kselftest_harness so that
option doesn't make sense if we go with (2).

If we go with (1), I could (a) store the _metadata pointer in a global
variable within KVM or (b) go with setjmp/longjmp (c) some other
suggestion.

>> The kselftests harness is running tests sequentially anyway, and the
>> function pointers in _metadata wouldn't be changing all that often in most
>> selftests.
>>
>> Would maintainers be open to having the kselftest harness expose a pointer
>> to the metadata globally?
>>
>> Another option would be to expose the current teardown function pointer
>> globally instead of the pointer to the entire metadata struct.
>
> I'm strongly opposed to any idea effectively requires special casing KVM selftests
> in the common harness.  In my experience, the common harness is already quite
> brittle, in large part because there is no singular maintainer(s) that is responsible
> for ensuring changes work for all downstream users.  Adding odd bits of code that
> is only ever used by a handful of KVM selftests is only going to increase the
> probability that that code is broken.

If Kees likes the idea of exposing a pointer to the metadata globally,
does that make KVM selftests less "special"?

If the community likes the global metadata pointer, I could update the
harness to adopt the global metadata pointer and then KVM wouldn't be
special at all.
