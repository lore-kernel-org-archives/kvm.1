Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A13033E8
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303919; cv=pass; b=M+5qqfcbw0lxYtDECMFZRwshQJil9HjEnIkL8RViHIoME5kyvPhcVwLtIGsxsBUGmMfc0qfXphU+cqtLlr5M+Pdv9iwnJ50BKfjKHwu15sDUyk23x9rIEUyp2Z+jouGelt/sZd/CogfTeJxOHDJHbbSaWIje5h6D/OZGPbXBNDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303919; c=relaxed/simple;
	bh=t+gXNDFOzwiaElJbDXmY+gH2gXxUKA66N6Eu3TqE8OA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYIKZCTxmtzDC/R05pumr2LrmHDsqwoHqL5F835yQXi2on9R8lj/d8azKROSwYmwdeQMr36B+7vYTi9jwOqBmiRA8Gtm3qN1wpOxuXHLlLpEQRvJqs4CoPkRshH+HXw8Oz5G3kiAYn7alNd/NBb6qF+/1lNqw0o5Gmm8Jf/Iv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJz5glIM; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJz5glIM"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a857578a8so2032609e0c.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 12:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779303917; cv=none;
        d=google.com; s=arc-20240605;
        b=Gh66NUw+/YDMt/198Fb+OjgYZRGScU3+W0JPo0IDkhz9DP0DcZpdkuQlpGHLClDrG3
         iBOZbmQ459X1YvLw56Yh+CYWNpSCHWWehH3tFsLwJA6bp+rkPXO4dmA+zeA4q8vhxJSh
         epiv/4pNS561t4xmSNcimj6vcEf/Ux//z2OHInoX57ctDZv8WRWnyOVnYq9JkNPfWFax
         C0m6tuWVxkOGFDiqNuFgPdnSvVlCWGIDLexwkAJgAgiqqQkch6tx2MvdKH6qUNSC0Q7D
         RKLNmjqkKEYd/BBfMHxinkGa8aIzVaU6BT1vEPLzzQobu9c6LZRnEeZRjcKeyBv0M1zP
         wmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3e9o2gG3pCPt49dwVje/mGfLrm4pMM5X5wFjDw9oP4Q=;
        fh=ZovfqoDZ8N0R8nk9qTL6OsZlRSu2MCzCzejgB/Dqn+Q=;
        b=OQszqtnFz+oopJzkyIZpGeVU+Q7+zJ6Ca9DUTzXfrVWLymHXOHiHy0JP0EKbYzgO+0
         hWgmlUa/CO5k0S8dbolIpN2FK0OQHXa6Wzy9HZS6i2hd2fmi8og5UXesH/HhE5Nz7a7R
         58FIkv4LTSVMJ4w6vjVDU1lu4oHGd98Pg7cBLABtMbxR375udUy9+tRTjFm1rokuV8Ls
         FdSP3zcYvUhWhFhKOAQHH+PDGB8HUn2w0oLutaZ5lb9e5LT/0YXrYFPfD/t2JHcw8NWn
         pGk7MjD0eSoD/9Gi/p0BoJVTpF3iEJMnB7RAonAT5h/B2nz4tNLkLu7OA9Vr9egLJfBm
         /BwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303917; x=1779908717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3e9o2gG3pCPt49dwVje/mGfLrm4pMM5X5wFjDw9oP4Q=;
        b=HJz5glIMoWnASrYs94/Ol2FGK47FfqdsH5qUUfFpoV2UINTbSuCfUTNOvVgEP2lZGt
         JeTVDcBNHbWZXKK8538kl3Y8T14O8ld9d0IVuDu1Cp9mwq7N3Lqa++VNxwTLp9bsQG21
         NflWqF1LfmyfbHb+PyfBUkewquGa/5jYyhM67BX54abhIHYnIjOGOJLyqahlFAnJMNCp
         CL4W8jIyiwIT/GNGMTwGP/gtgrvCLr91jynIg7ol8M2JP4x/ypi9w3Nj9GZOKhvoKbat
         k25r7D7GQld0qIg4oto0JxlK41gHqppoUBqKV3ere+J8VJtUDgJqfSIviISEM+gY15u+
         SPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303917; x=1779908717;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3e9o2gG3pCPt49dwVje/mGfLrm4pMM5X5wFjDw9oP4Q=;
        b=XR1cYZhiDk7p1fG3wOOlXVZUjtMg/ZfOMpXGeNTX2yk+QpIWdkTi3UnV4gvzBeeRcF
         BDfCPFtah11l4aq+J9HqEl9pY6NI6HxbVeBIa86oISd5Oy/Y4g1eS5T4b0wTCjS+bpAS
         WtmBHXCVB8dTxoae5Fhp1TiGuJRXOf+mF7tUNOvZy6RZXj6IbRG6y2a70GUaZOJEQ2M8
         LzzLTnuIuv1pGi8BqAGj+6xtu518XXGDNLV54yB/BDr0uS48S0LY7TC4rd/KpAd0SkQh
         SdRo3lx/aGNu0vaz6s7Qv89PCjpUQDDMw7Dtsdlk6VdKOWFAbU+/Vlk2ZB5vIdUeEA8z
         WiEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aYn2i8Q/o25E7MT8kH7jTE4XdFCljsoHu/Odri3WrnI48ote8dTZvFlq1DAvr0JUIBfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUA2GKr+GzpTtcHHj6wXV4TfssH72D5R/IJGW2sNbHlpKbyN9
	yy8e5zFAAnLMd1wpsIq2zRqcfJ7TsqvxTfrtxHznAKdGmQHvYiDxxyxa4nJF3dh2pztnLgND+oz
	M0OKBpO9X116AYV0S0cxK9Zazf6nE21cAn1WljKLc
X-Gm-Gg: Acq92OGqCF/NdLI8czO8bUNGumNophyKD8vmuGHKYtCts52Z1lxBhC2m0GSqZz+NgwX
	NnEBl6QC/pg9YNbmaxMR8bbCLv8JD+xrWBlggG1ARyFYjd1sG4pbwTbJHe5rcFyDPpUnJXLXGR5
	jKexYVQClSigMZoo8EulKLOtzgZZMdxB8gzvwrkPZNukhpRp3kMwwKwisyQ3yRf8EXiy8qLWxOy
	oDzKF13iIEA+PSUSXen/F8Due7VXuuNZuTTf70reAoWke66gdpura5t5CctUKsAw24j/+YrCkqf
	9DK+ezTrX9xQ3kw4Cfb/KXQqzxSU8+R0fEp5Rfkwf/F9GJeeXlKXfDQNo8tPqDeDBPNSuVTxZPa
	Jy2RK
X-Received: by 2002:a05:6122:2407:b0:575:637e:9509 with SMTP id
 71dfb90a1353d-5760c0940d7mr14510275e0c.13.1779303915928; Wed, 20 May 2026
 12:05:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 12:05:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 12:05:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag3LYxmbqD3EWfrJ@google.com>
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
 <agOMfpW2Xxpzk-D5@google.com> <CAEvNRgEpy+d=KTSVcO9svAS9asHCDcwctGo=9PAaFVMUCd-Wrw@mail.gmail.com>
 <ag3LYxmbqD3EWfrJ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 12:05:15 -0700
X-Gm-Features: AVHnY4Jb2NXYYYsdCzDpc9JNWTD_Ob2jf_L84rv-RtVDnf4LglR3VtKesLFSPwo
Message-ID: <CAEvNRgE-jDJSyPtXpd=gc2nhTwVjoM3+k_eED1A-rgO-bkw9Lw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] selftests: harness: Provide global metadata
 pointer to allow clean teardown from selftest libraries
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, thomas.weissschuh@linutronix.de, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, May 19, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Tue, Apr 14, 2026, Ackerley Tng wrote:
>> >> Sean suggested using setjmp and longjmp [1] to back to the top level
>> >> TEST_F(). I looked at [1] and found myself wishing to use TEST_F() the from
>> >> kselftest harness directly.
>> >
>> > Can you elaborate?  If you have a need for direct TEST_F() in KVM selftests, odds
>> > are good someone/something else will have a similar need, sooner or later.
>> >
>>
>> I guess I like the consistency of working with TEST_F(), there's also
>> TEST_F_TIMEOUT() and friends and all the usefulness of the rest of the
>> kselftest_harness as you described, all of which will probably need
>> re-wrapping if we proceed with the approach of wrapping.
>
> FWIW, utilizing the TIMEOUT functionality could get tricky.  KVM tests often have
> highly variable runtimes based on the underlying environment.  E.g. as an extreme
> case, see the never ending game of whack-a-mole we've been playing with flavors
> of KVM-Unit-Tests' access test[*].
>
> I can definitely see it being useful, e.g. for tests where we *know* the runtime
> is O(ms), just want to call out that this is yet another case where KVM tests tend
> to have more annoying requirements than other selftests.
>
> [*] https://lore.kernel.org/all/20260317225327.4068448-1-yosry@kernel.org
>

I guess today's KVM selftests are the equivalent of "never timeout", so
that could be a separate enhancement to kselftest_harness.

We could use kselftest_harness where it is useful in KVM selftests, not
as a replacement :)

>> >> Another option would be to expose the current teardown function pointer
>> >> globally instead of the pointer to the entire metadata struct.
>> >
>> > I'm strongly opposed to any idea effectively requires special casing KVM selftests
>> > in the common harness.  In my experience, the common harness is already quite
>> > brittle, in large part because there is no singular maintainer(s) that is responsible
>> > for ensuring changes work for all downstream users.  Adding odd bits of code that
>> > is only ever used by a handful of KVM selftests is only going to increase the
>> > probability that that code is broken.
>>
>> If Kees likes the idea of exposing a pointer to the metadata globally,
>> does that make KVM selftests less "special"?
>
> Yes.  I don't particuarly care about the code, I just don't want to be in a
> situation where KVM is doing something "weird" relative to the rest of the world.
>
>> If the community likes the global metadata pointer, I could update the
>> harness to adopt the global metadata pointer and then KVM wouldn't be
>> special at all.

On the PUCK call today Sean asked if this would help with the
TEST_REQUIRE(requirement) problem [1], where we want to skip this test
if a requirement is not met.

Having a metadata pointer helps specifically for the KVM_ONE_VCPU_TEST()
wrapper. We can't define a generic TEST_REQUIRE(), but SKIP() would
work, since you can define the SKIP() action to be return, which would
return out of the __suite##_##test() function and effectively skip the
test.

The SKIP() action needs to be handled all the way up to the top level
TEST(), so there's no generic TEST_REQUIRE() to be defined.

Defining TEST_REQUIRE() as SKIP(<call teardown>, abort(), "message")
would work but that only helps with teardown and doesn't continue with
the rest of the tests. To continue with the other tests, I can't really
think of a good option other than setjmp/longjmp.


It seems like the problem KVM_ONE_VCPU_TEST() solves is a FIXTURE
configuration problem. The vCPU could be set up in the FIXTURE_SETUP(),
but there's no good way to parametrize the fixture setup code. Did I
understand correctly?

I'll have that issue in the guest_memfd conversion tests too, leading to
lots of kselftest_harness wrappers. e.g. INIT_PRIVATE [2], then
INIT_SHARED [3]. There is FIXTURE_VARIANT_ADD, but the test code isn't
the same for the INIT_PRIVATE and INIT_SHARED tests.


Is the kselftest_harness-native way to parametrize fixture setup to
create different fixtures? Like FIXTURE(gmem_conversions_init_private),
FIXTURE(gmem_conversions_init_shared) and
FIXTURE(gmem_conversions_init_shared_4_pages),
FIXTURE(gmem_conversions_init_shared_8_pages)?

I guess FIXTURE_SETUP() does have access to the fixture name so setup
parameters could also be encoded in the fixture name.

[1] https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com/
[2] https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-28-91ab5a8b19a4@google.com/
[3] https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-29-91ab5a8b19a4@google.com/
