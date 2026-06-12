Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98E8248B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308574; cv=none; b=P328CWwSrS66MrXG8+9guMbMorvqTkcYSnfcsj1HDEWYbCwNvk0ubiuqHJaoRkgYelt+eSFEppLQF6CeO4yKwfcI8zxlAtNmUbtowwzx1v+fMaPyTgfVCrdumo2abZyHQmNKr2eElCo2V0IKBAwjgxALVvGGq+kRZ5HmLSUPFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308574; c=relaxed/simple;
	bh=mYOUo1JgBri6LcYw0WgRBiZHTdpiHq1E+F5crKsqsto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FsAffXtOJ2rdkOtRsbMhtzrccFlxDvJIq0H/mneA4AM7WCjyIHfGTcHYyQmqjWG7Z0JPWUk3LrYzFt7RWcjWPwNzwABt2fyGHklHtdwKg6ZzV2v9PSe+Zesx9U+QP/EGGwbB5XijCXBoxMDjuTExcDcS3k4d4pmYvnBY2wQoDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jl73gw4L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jl73gw4L"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84233efcaadso1059124b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781308572; x=1781913372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7F1CL07F07wvyE5qrB0/UKvrGwjihO70EZ1fPlSezlQ=;
        b=Jl73gw4Lw/Po9G5qSRZdNSRQ1/IbIJdyP6YUrY9KOeQjHtkJRk/Fs2aPunyLbD1JrD
         vDcrSl/mJPkj+5M/8xDi9TM+PqLx6j7KRpFvpIxgqJxMg/R5wtTDg3hoTg/KpZh5Re3+
         DFS6HYa7aWwQ06etLaTLRj7ME+QPwkobXRkYTYRjjENwtz5n2RSIGDTKDHjSzxU810+B
         YdQNdRUvlQEkvi2nEYSxNcwewz0dY33+iO/TX+plE9AatvaGogWAWLkeF/HWXEv6JBtd
         Ax/BnltO2Flipdqnr+TtTLYuAr68qlla6+dlvG+bSf6bxrYD7Q1wo+fp+cGWOGxxOgKz
         hbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781308572; x=1781913372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F1CL07F07wvyE5qrB0/UKvrGwjihO70EZ1fPlSezlQ=;
        b=A5j5VWYMe/Q6buXsBxJyC86M8GVoertXKx95AgE0j6UQyM9eaPRT7DeUsm+MG0tnzm
         211AAlMMyfjSyPNnDbwXOZdYZJQKUSmDvNKhRwxFErm7U4ywyT56B6quqWeEaLB3lL67
         XBVUbaBXZrJNs5bdl463gpBe4mKVawxITi3Qo9LMLlbuecdQgY1uTr7aHpkPWQe5FnP+
         n3tH449On7xbRD9hIgY5XJ0mVb0nh+wxPMEGF315uy92x0/je2GUB3C+ZTyd8LMurBVU
         7mEv2vL7dOyAVrFFPENfbi6HhzIlcH1MjGb4ipwrkKVKPVLG0DNDKWYA3I2GJVM/kbWH
         yCXA==
X-Forwarded-Encrypted: i=1; AFNElJ9m0It54KrORin7PDSR5r3HDmQPHN0RNnr+zxGMMylqTdlquLfLUg3l6FcQ2IFGh6rTS6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNn049OHkPYi9Hr/MsuXKA2VUmgM/+Mke3QJ0MbpQy8q93sSc
	7eecDFcETEZmVTzV2BE51b1aCPml1UoeHS6psA1Xj9TOgByvLnJ+14TGZH4V8ZEyRh1j3JsDeOH
	S5qm87A==
X-Received: from pfux29.prod.google.com ([2002:a05:6a00:bdd:b0:83e:e8a8:71ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa8b:b0:834:e5a2:d089
 with SMTP id d2e1a72fcca58-8434ce8c0d4mr5319281b3a.33.1781308572362; Fri, 12
 Jun 2026 16:56:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:56:11 -0700
In-Reply-To: <CAEvNRgFLnGkqvvks3joAwPjqLz=ATmqiS0UWk71g+YEsxNsfsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
 <aisHySKe0PwM5DSg@google.com> <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
 <aitbveI2Sdx4s4BP@google.com> <CAEvNRgFLnGkqvvks3joAwPjqLz=ATmqiS0UWk71g+YEsxNsfsg@mail.gmail.com>
Message-ID: <aiycmwMbhWuYghJh@google.com>
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Jun 11, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >>
> >> > On Wed, Jun 10, 2026, Ackerley Tng wrote:
> >> >> Vipin Sharma <vipinsh@google.com> writes:
> >> >> My (future) use case is that with hugepages, I want to run something
> >> >> like
> >> >>
> >> >>   ./guest_memfd_test --order=0
> >> >>   ./guest_memfd_test --order=9
> >> >>   ./guest_memfd_test --order=18
> >> >>
> >> >> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
> >> >> tested. I'd like to iterate over supported HugeTLB orders at runner
> >> >> runtime instead of at build time.
> >> >
> >> > No.  The right way to handle this is to define testcases for the "interesting"
> >> > sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
> >> > is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
> >>
> >> That should work too. So at build time I'd make it define all the
> >> possible HugeTLB sizes on every arch, and then skip as necessary.
> >
> > Not necessarily at "build time", the testcases can also come from your local
> > environment.
> >
> >> Why though, why not find the supported sizes at runtime?
> >
> > You can find the supported sizes at runtime, just not in the test runner.  I want
> > the runner itself to be largely oblivious to what's its running.  Disallowing
> > more or less _any_ test specific configuration/setup in the runner is the only
> > way I see of keeping the runner strictly focused on running tests/testcases.
> 
> The runner should 100% focus on running tests, I think it's hard for the
> runner to avoid the process of test discovery though.
>
> The current test discovery process is to go down the tree of directories
> and find files, 1 file == 1 testcase. Each file should (statically)
> contain a single command.
> 
> Since you're not opposed to runtime discovery of test cases, how about
> something like:
> 
>     if the test case file has executable permissions
>         execute it and get back a list of test cases to be run.

I don't hate it, but I still dislike the idea.  I am all in favor of runtime
*discovery* of testcases, but I am staunchly opposed to runtime *definition* of
testcases.

If I define guest_memfd testcases for 4KiB, 2MiB, and 1GiB pages, but the
underlying system only support 4KiB and 2MiB, then I want to see a SKIP for the
1GiB testcase.  If the definition is dynamic, then the 1GiB testcase simply won't
exist.

>     else
>         read it as a single test case.
> 
> I'd then use the executable version, check HugeTLB setup on the machine
> under test and return bunch of separate commands to be run (each with a
> different HugeTLB size).
> 
> The runner still doesn't need to deal test-specific config, that's part
> of the executable that tells the runner what to run.
