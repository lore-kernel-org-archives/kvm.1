Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523736C9EB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293518; cv=pass; b=pouoWYluJE/NBxQzP2IGjCcw2df3fY+xUSD67c6cESjTnm4hx2kwaqwulyQvjmvBA6fMK1hPQQk7ZhvmoiZSVFGR/jHpw3BYGn0cEE8dWyiPmX1rU8XPSO4y5fbPHL+6UVk5XuUyzS7ERu68+J/dUWdadqufMV03jMf0R5QPhAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293518; c=relaxed/simple;
	bh=7xDJxVjDk42Anpf5nFQLtzEUpQ3ex9C8K+TDkB8oE+w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBkz8hDAX4gwfpCPFtGYjwOnVONgW7F6aZdwuz6/BuLD3aMmRduj+RTGHBMcG5QHWMxXJwx0O+jmCHx2sMkJGB+CefnYzI6SFMkNOTvTU3HW993/mlOnudpLrGdgYNbaIoVDbZWtIC+77/RyJrvdTw7KsCrJ8RUc0lIkENNcMd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=It68nuZu; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="It68nuZu"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13810b63a1aso3017380c88.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781293515; cv=none;
        d=google.com; s=arc-20240605;
        b=cM8Z7/1CeGHrRkQ0UYV6BCQr7FJLXKHs+asfLnZ2iSZ4gcW8z5USlG5tT4VYtOEIyI
         bKFQsAqlKYiEP+fyoWBtlF0f5zxJTZdmx/p1nB6M8Dx27RMnzx7FxkKXSkMBImiLCSTp
         Yl/L0+NaLMYazIaQYhZyPyRAgkzxPhSA0rC0KdXRWKE7gTzC2Aa453FbjphKvX4/NNr8
         QdeNnvIK8Ztik3x/Lt5vFAOHq8RnpeeP9ztVeNZJTnTwLskmD5BlP/o1411LVKaOHCDv
         6POWFRNJXkkzxBWvHmXS2o/zUV7xfZaGwjwFYpImkVixc0MqVebSJrjFwHPTjz7s9Lq3
         MufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aLJTxmN0M9ZPVQW0kpELnacC0gVuFIrIwjygErMroM4=;
        fh=CkJtsqQa+294Jrvi7XYpkOSBz+t81zjRPBNIsOmq+o8=;
        b=DHzOZqoTQk0VZuSEY42UzGkFFNCfCVwfHNexBTuyfp+JlgmIvyuELCC+4MFJeGMbMl
         u9eYvdt9g3i9EObp8kUTB7NrkUEniQFjulIXca9ShOi1sdjt3aCR1zcerqAO8rb7XuNB
         i2Dp+3xqJdrsGUKcQ59ex0YnTk8Texy4Om4wRFsSIZuRjnhN0WV/7PJzOwV0qJvwXS1q
         Su9Ie3SI0DGpPclniRYL9G0wyKKjp/G6hPWwOih7DPAvlImkfD/9E48rstuxMtTlQeHa
         1pNDfIow+PLaDXaRSDx5gNUGiWYK+xNFkNNSAH5qgLfNNE1AJbN/lY/VmiB+MZDRA+Fx
         emPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781293515; x=1781898315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLJTxmN0M9ZPVQW0kpELnacC0gVuFIrIwjygErMroM4=;
        b=It68nuZu60rNtaUrj55G1zC3q4ea6LhhwIcn6NmuR5I4oTTTGvgfjdvAnkUwEFUzeg
         OTGI7bJB+4OJl3KQbJTkNQudXEUNkrej/R4f5OmxqK1OehJxOGRCaE/OQ5cYrJlOJ3Vy
         lcRJKDSh+Mw1cRiBU1KgqugO8C4TDgvGX9SpsAMaZ/8GLxqyViaweGoOVu3po5B5p33t
         A3+MHbTtvBlYI0f/5maL8H9jHupGuoRki4/xC9J9BU9qzNqr9M4ndJ2DBzsSXLhQ/T4K
         fImb/0KwvAxpqEzcVrsXiCaoyIQCfBZF9Xs63mjRGc8z3tH+M5w20Zye5yByLJkybvQs
         qxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293515; x=1781898315;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLJTxmN0M9ZPVQW0kpELnacC0gVuFIrIwjygErMroM4=;
        b=Fm7nkdwHVeyaNVLMAfvzeSIrmP7MDjP2RcpTDhesddBv3yqe3zfR12S32+8CmlJuXo
         wb9ZgQCvJ922O9KkQlbfbQXHpHkIKsQC+kWKwoydd3xuMjJuq3lZGqZyexO0xfHSsRl7
         CJB3zxqk4+owFAYHe3TsqSWY4RNFxzRLLFS0wNvrM+WAKhR9DMnS6wbjb8sDTFH2qKaX
         SeI4e0O8fzlf/hVNVXMvd90lE+cXm2Y3VZ6S+AW8pnhip+HpsIq3QCv54GQ8Ow4MFVA8
         Ku9IinGNYcfpxJkssYtIczSB3LIGn88IOASEYe3eSxqsXrlHLHji5wqLWgo3SnfLoRYC
         yC1w==
X-Forwarded-Encrypted: i=1; AFNElJ9s1eXK8PkBVcguMdJqs+w9PZQPUbI2Ax0RlKJzARox0FdTQtBZj+SOIKiv2hGyGabGAs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB2+Psi6cfu3Kk8ZC9r2D9dZVxRsmLlRkU+GdkJ64YZa34G/3
	/IM+mxsh+8nNYWKHg/nhzmTpZu97YjPYOfD6h55+8yKI3Vx7lD4HyBnZiIrZkTtsiaUclCUfNc0
	O+r0xN9zqa7qTdic8ZspWtyZuUd+UjUAx/KCRLa1n
X-Gm-Gg: Acq92OFvjQFKi1EjCONGGzsJHRRJU3yL4yCtcfi6VXt/8HU29+SQaKBicCGpMkOYCpt
	KpDJgV+JkGItb8Z+HgnHg73OZrJjA1rdKr5pzbI7TjQ3n/rXOBSkTNc3mVc1ZJ1HeoEJr0njHIE
	5+4DqANDe+xHXHSCMIa4Ik5ujSBG3S7XLcRB7ETPAuq5SpSAwbvhTVwGNbz4cdiYKX/crEkTmMl
	DinqrhyT2v9dUTzI5L9sZX7QdZVqbz+KnmRwSJlpjJD9MmjkWl5ljhZNnMqjMQdQLwcZ7EH8l18
	wTTgvbqaxzClL2WVHzmGF1CfmTG08CcwWNiCwQCynOHyt2EGCEvKuUvJsT4RAOEWs6ZucQ==
X-Received: by 2002:a05:7022:621:b0:138:4fb:f284 with SMTP id
 a92af1059eb24-1384bb38d6fmr1989806c88.15.1781293514036; Fri, 12 Jun 2026
 12:45:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 12:45:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 12:45:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aitbveI2Sdx4s4BP@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
 <aisHySKe0PwM5DSg@google.com> <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
 <aitbveI2Sdx4s4BP@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 12:45:13 -0700
X-Gm-Features: AVVi8Cca4ehyVmpS233WMcTKmiImcVUcWDNZomRwvPGwAtUbK8L6EJTEUMvzdMg
Message-ID: <CAEvNRgFLnGkqvvks3joAwPjqLz=ATmqiS0UWk71g+YEsxNsfsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
To: Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jun 11, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Wed, Jun 10, 2026, Ackerley Tng wrote:
>> >> Vipin Sharma <vipinsh@google.com> writes:
>> >> My (future) use case is that with hugepages, I want to run something
>> >> like
>> >>
>> >>   ./guest_memfd_test --order=0
>> >>   ./guest_memfd_test --order=9
>> >>   ./guest_memfd_test --order=18
>> >>
>> >> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
>> >> tested. I'd like to iterate over supported HugeTLB orders at runner
>> >> runtime instead of at build time.
>> >
>> > No.  The right way to handle this is to define testcases for the "interesting"
>> > sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
>> > is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
>>
>> That should work too. So at build time I'd make it define all the
>> possible HugeTLB sizes on every arch, and then skip as necessary.
>
> Not necessarily at "build time", the testcases can also come from your local
> environment.
>
>> Why though, why not find the supported sizes at runtime?
>
> You can find the supported sizes at runtime, just not in the test runner.  I want
> the runner itself to be largely oblivious to what's its running.  Disallowing
> more or less _any_ test specific configuration/setup in the runner is the only
> way I see of keeping the runner strictly focused on running tests/testcases.

The runner should 100% focus on running tests, I think it's hard for the
runner to avoid the process of test discovery though.

The current test discovery process is to go down the tree of directories
and find files, 1 file == 1 testcase. Each file should (statically)
contain a single command.

Since you're not opposed to runtime discovery of test cases, how about
something like:

    if the test case file has executable permissions
        execute it and get back a list of test cases to be run.
    else
        read it as a single test case.

I'd then use the executable version, check HugeTLB setup on the machine
under test and return bunch of separate commands to be run (each with a
different HugeTLB size).

The runner still doesn't need to deal test-specific config, that's part
of the executable that tells the runner what to run.
