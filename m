Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DE3C2BB4
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617473; cv=none; b=JQry0cIYZkAuVBCpjQzhc8/6JL3HkzduLQMBTfquaMPqKh2o7R9lhEXc4g/4/iJbUbJ4tU3ZxkRA7G35t/pfUF81djemgG8tg8sLOpcia6fg+58X6S7fo2N0bXw6+4QT6XhUjID1rKiict6VnOVvj5mHlW30Z/DRBfLOejp7Ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617473; c=relaxed/simple;
	bh=ZuC4aqvAth3//T6/XaDMKe8783spN0RRKAEAwn3cyi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rh9i8BHfX/FCOwBCQwLCf254OdSGyxU4nG7MBoDpxpOloItKB8iQ9rAQIjgxDM1cffA8yqRPpor7Jizzl0NK3oubDCyg+5DVWSKwV4yTtxc6Z7p3kOaPEcgbnH5qfb12pAiUTcp8yPdYm7f9OR/Mxd/tsy0sKPK4H+9bn6AI810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwxvmmEW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwxvmmEW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d0d71c61so3582509b3a.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778617471; x=1779222271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rokOSit4LNm5cJdb1Y3jNPDKg842KRY3HU1fgqtDryg=;
        b=gwxvmmEWkpugyAXCAmQfUPBKOmn+VlAfqC18V9PyxMc5SHCWn438VP+Iv9uOAKgaTw
         l2ri6zLHH1uFtqAB//p222/mGQonCFZSr8iIncKz+xO6UjWsRt4VOBjsizAT4TEDq28j
         7bydaWzJ/yaXGmtZiQlPWktMLaydXwaPeWqOSYEcWaBGe32tcEFlXElM5R2hswbdiZZd
         0Y/9ae/39n6adsG+YGmXKV8ODiwARS7X6rcObcUjgNfrrSdVzofuK/+jx+OP/g3Ojiok
         oXKDVp6dnHySwLYJdVkJuxYi1GB9aYdkaJpnDyTTYWtcXntX2rb2xD/wAJwtPXQPo6ij
         b6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617471; x=1779222271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rokOSit4LNm5cJdb1Y3jNPDKg842KRY3HU1fgqtDryg=;
        b=J9OmozCbEBXZIEckKGW80cvArDBiTkrKEpemCaGLv7ECGwXxyJKjT2txuh50fI5ro7
         v+P8GIcrdGxyNFkKgHMtzSQiATDO2Mzqwthy229E8OUGvQyMGIvf741zceF8u/1hRKMR
         zgURV5Nmj12CiPzBSLUcaCvxA2E3PYo02YHj7J91HYS+c9E1CPlRsvK4hlAxzqhn5vB3
         ZTbI9d586sgao3jdTySpFo2BJabuXSbvpZOvrddcahj4B8f6ClrLiYkNvs49J08Qw9xa
         fKQVri/bxKPCT0MobtvucNalaVab1mhz3xR7xunUPcP5nYkQlW0Q2iVy3CumHxLZrOJh
         ZloA==
X-Forwarded-Encrypted: i=1; AFNElJ/HlOR4m7kDJnZdzXbq+QVSXsI3cVU0UDYOlSb7OLyyVdNI5M/DM/iF/fthtNBXsmq0laQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54MXFxipdxBn4c0DOro0FmUrH0Lu2//ZOAzA/xC1zj7huMXy0
	SGuNDAHvy8G0imZ0GDYS84EwHrAodsxCq7MN+RXe170zFS9W2m7fKME2FvjkJfTx3C6GN9yqyqA
	kmX/Bmg==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e1a:b0:82a:7893:e14b
 with SMTP id d2e1a72fcca58-83f042bf9c8mr170703b3a.38.1778617471299; Tue, 12
 May 2026 13:24:31 -0700 (PDT)
Date: Tue, 12 May 2026 13:24:30 -0700
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Message-ID: <agOMfpW2Xxpzk-D5@google.com>
Subject: Re: [PATCH RFC 0/4] selftests: harness: Provide global metadata
 pointer to allow clean teardown from selftest libraries
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, thomas.weissschuh@linutronix.de, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Ackerley Tng wrote:
> Sean suggested using setjmp and longjmp [1] to back to the top level
> TEST_F(). I looked at [1] and found myself wishing to use TEST_F() the from
> kselftest harness directly.

Can you elaborate?  If you have a need for direct TEST_F() in KVM selftests, odds
are good someone/something else will have a similar need, sooner or later.

> Also, setjmp/longjmp felt like it was introducing state that could be messed
> up easily.

Meh, same goes for the kselftests_harness.h.  I can point you at a half dozen
bugs where enhancements to the core framework wreaked havoc for unsuspecting
subsystems.  I'm not trying to throw shade at the harness; there's a _lot_ of
goodness in there.  My point is that doing complex things that impact a huge
variety of downstream users is going to have many sharp edges, regardless of
where the complexity resides.

I'm not wedded to setjmp/longjmp by any means, but for me this isn't a compelling
argument against the approach. 

> I also found recent work that removed setjmp/longjmp from kselftest harness
> [2].

KVM selftests don't support building with nolibc.

> The kselftests harness is running tests sequentially anyway, and the
> function pointers in _metadata wouldn't be changing all that often in most
> selftests.
> 
> Would maintainers be open to having the kselftest harness expose a pointer
> to the metadata globally?
>
> Another option would be to expose the current teardown function pointer
> globally instead of the pointer to the entire metadata struct.

I'm strongly opposed to any idea effectively requires special casing KVM selftests
in the common harness.  In my experience, the common harness is already quite
brittle, in large part because there is no singular maintainer(s) that is responsible
for ensuring changes work for all downstream users.  Adding odd bits of code that
is only ever used by a handful of KVM selftests is only going to increase the
probability that that code is broken.
