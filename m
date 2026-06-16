Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8F47B420
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634604; cv=none; b=iJIJ/IvyXtMpenSfOMaBdw2kmWR2BAgT3LQgVtStlU9bmadz7eq5YE3EcUbeH3MRb7eYJgoOZVDW0KxewoYAT0O2IKHWqFsETb9bbE9BGNTDreLCoXWZSZmIchJSgmLloCQalrzpcAtRoKFZOHMCxwXUajzvt2LPor/0UuPeQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634604; c=relaxed/simple;
	bh=WcM56KEMBI/eo4oA+VeNcao2vPW2ZNhU0wR6yYCjGxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQlCpHZOrmfI49VxiRq3LCJedsQezHP0Gky+qUIWuEsdCUdSR5iVG+7gmv/rlhmedXzppW9meN1YzqYP1Iqny9JS2QQd0UA2l0OxNjo7umeM3TXaF1dn9rITdKy0j8q5/YCPHrGNCg96juw1SjDvFeKRw+naPOSIAsixylMrD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1d6Jqud; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1d6Jqud"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2d865383so8365ad.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781634602; x=1782239402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX4ssr4Y9/OOfcYZ2FcReQvMLH2Gq4SbTEa5005JITE=;
        b=S1d6JqudcpXzC24uVzxdH/F6Vj9Zec3Ltpum5nyxSqTBtN6c1Haw8md7MKKAWoFkuD
         Zv+4H0H96rgHIAyOj8PIaDxqPc58BN8bT4PfnHEVzoMOsRC4urleZYF/E/F4JUngmYj/
         Az//LL6gznL7FGaiD7mSu6P5GDNzRrVvHQhpzISJb6REbdFpladGswGIboOb0ZkXlElj
         0+lJy59O8QOCvfOuAUS6+20nrHc/vGymKI8OdSF1DOAQWAmrXuF5SB5DeoMpw+IU8hLl
         ip0Ot8eBYSItNRcVG4HBaxrf0jOI0HfCynBnkAkyJtKX3z9byS6sp9GCf1JNDSTdJyOP
         akow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634602; x=1782239402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX4ssr4Y9/OOfcYZ2FcReQvMLH2Gq4SbTEa5005JITE=;
        b=rBJFFAKQPd5jpyZgzMfLYrHa7Yg6U1UIJyXlf8awkMRnvGWiEoIQ3WlvTBfnSW52jB
         s0pSJBYoeK4hkGUt+2BZ4bvbRsEgxq5lL7VChj3YDstL6SErHxXI1So0KL6nLv+yBbRc
         c+GanhARf/ffzvwr9V6gQ+ZRaiuagMaCG54Xr6NbPnNPqsobwvCR06Aqx8nYwIEiugYC
         Hd7Yeb7vWzzJadivbwnea5ZjivBZg88FQGBdRadGhADGWKMzwBYfvWS7zRSKpnR0HTCF
         /rNoMKqCnYLDR5z88rVjZifuscY/+KkAQUuX04vTIgCszDDg9yVtwqN5o32gDsUAPXIG
         QWiA==
X-Forwarded-Encrypted: i=1; AFNElJ+WOo02c8sk3mjjiM68PsjOMJ/m+Rv2HcM98lj7JBobuUAlqAvam0d0qnAgeCH8Rtj0O/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+UVfIqVa/I7CL7I0p8nnYjtCuJTr2jg8yXlLN5rCLRQ73dg6
	mPzv+TheFLDxHm905Kgb852dAf+8X31SrKLW6eFT0GxNrpvw4qxMHGuflVfyWlZQIQ==
X-Gm-Gg: AfdE7cnsOEZu8lM/i2uffH3s8lyJc1B0bSB3waeRZsZqKBjN5SMX+ETKTnwAfkKUvwM
	5Y18ukl5yrn8Svuq/PM4HQpJ3+7i1gP+CDs3bfa2aZi7XfnJfyd6OJQM/ArCIJidh45U8QeYzPq
	v0FsplYY1K3XScmEAo6DPi+QvZeM5M5GwityCSPqww6bwAzQplf355QnKInjLVYGXB7yCEnWK8a
	1vsit1k/Vp6iVGvrQrrC4co+RQlA8eDJqI6hY62KeMlYZKWzF13e7MViC8KJuRkfCF+aTJjg3JI
	sK/grLrdGZuxt1oKHSwvp271XtQqzisyfo0QxAznTzs2mFiIXKaik42pw+nKeNF/yOL0ER+Wsro
	y7NEUQhQemgggk0YbDY2D/INluOH7B6/9WAjRXxSBzLMYj0bSAoz+TRaU1tG3wnWF89+I+Jl1m3
	U0ax1au1L7egv2REOBer6FfY6Z2fmESLo4Pwepe1BbbIHnM4WX7uHWH/Ek4g==
X-Received: by 2002:a17:902:ce91:b0:2bd:7bec:f0e6 with SMTP id d9443c01a7336-2c6bbc6030fmr270055ad.1.1781634602099;
        Tue, 16 Jun 2026 11:30:02 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521aa047sm4617808a91.3.2026.06.16.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:30:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:29:56 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, pbonzini@redhat.com, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	anup@brainfault.org, atish.patra@linux.dev, zhaotianrui@loongson.cn, 
	maobibo@loongson.cn, chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
Message-ID: <20260616175210.GA1675268.vipinsh@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com>
 <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
 <aisHySKe0PwM5DSg@google.com>
 <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
 <aitbveI2Sdx4s4BP@google.com>
 <CAEvNRgFLnGkqvvks3joAwPjqLz=ATmqiS0UWk71g+YEsxNsfsg@mail.gmail.com>
 <aiycmwMbhWuYghJh@google.com>
 <CAEvNRgGkjcVN80W7cNd1-tEUXAfnFXEekokh_VbMDb9XdecVVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgGkjcVN80W7cNd1-tEUXAfnFXEekokh_VbMDb9XdecVVQ@mail.gmail.com>

On Tue, Jun 16, 2026 at 09:15:24AM -0700, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Fri, Jun 12, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >>
> >> > On Thu, Jun 11, 2026, Ackerley Tng wrote:
> >> >> Sean Christopherson <seanjc@google.com> writes:
> >> >>
> >> >> > On Wed, Jun 10, 2026, Ackerley Tng wrote:
> >> >> >> Vipin Sharma <vipinsh@google.com> writes:
> >> >> >> My (future) use case is that with hugepages, I want to run something
> >> >> >> like
> >> >> >>
> >> >> >>   ./guest_memfd_test --order=0
> >> >> >>   ./guest_memfd_test --order=9
> >> >> >>   ./guest_memfd_test --order=18
> >> >> >>
> >> >> >> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
> >> >> >> tested. I'd like to iterate over supported HugeTLB orders at runner
> >> >> >> runtime instead of at build time.
> >> >> >
> >> >> > No.  The right way to handle this is to define testcases for the "interesting"
> >> >> > sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
> >> >> > is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
> >> >>
> >> >> That should work too. So at build time I'd make it define all the
> >> >> possible HugeTLB sizes on every arch, and then skip as necessary.
> >> >
> >> > Not necessarily at "build time", the testcases can also come from your local
> >> > environment.
> >> >
> >> >> Why though, why not find the supported sizes at runtime?
> >> >
> >> > You can find the supported sizes at runtime, just not in the test runner.  I want
> >> > the runner itself to be largely oblivious to what's its running.  Disallowing
> >> > more or less _any_ test specific configuration/setup in the runner is the only
> >> > way I see of keeping the runner strictly focused on running tests/testcases.
> >>
> >> The runner should 100% focus on running tests, I think it's hard for the
> >> runner to avoid the process of test discovery though.
> >>
> >> The current test discovery process is to go down the tree of directories
> >> and find files, 1 file == 1 testcase. Each file should (statically)
> >> contain a single command.
> >>
> >> Since you're not opposed to runtime discovery of test cases, how about
> >> something like:
> >>
> >>     if the test case file has executable permissions
> >>         execute it and get back a list of test cases to be run.
> >
> > I don't hate it, but I still dislike the idea.  I am all in favor of runtime
> > *discovery* of testcases, but I am staunchly opposed to runtime *definition* of
> > testcases.

I don't think we should support this kind of usecase. Our goal is to
keep test runner as simple as possible. This will add one extra parsing
logic in the runner and also add more wrapper scripts in kvm selftests
for tests to create their own dynamic variants.

If dynamic variation is needed, then there is one option in this runner.
As testcases are executed by runner in a shell environment. This
basically means the test will run as a shell script and provide variable
expansion or call other terminal commands if present. One can define
interesting configuration which can be dynamic based on the host in a
testcase file. For example if one writes a test command as:

  dirty_log_perf_test -x 1 -v $(nproc) -i $(( (RANDOM % 5) + 2 ))

This will run above dirty_log_perf_test with the number of vCPUs equal
to the host CPU count and some randomly selected iteration count between
2 to 6.

This way one can provide interesting configurations which can test max
of a system in a separate test directory which can be invoked when
needed.

For predefined input values of a test, either one can write multiple
*.test files or use kselftest harness and add kselftest API based test
cases. Both option will still require that test should SKIP if something
needed is not present on the host as mentioned below.

> >
> > If I define guest_memfd testcases for 4KiB, 2MiB, and 1GiB pages, but the
> > underlying system only support 4KiB and 2MiB, then I want to see a SKIP for the
> > 1GiB testcase.  If the definition is dynamic, then the 1GiB testcase simply won't
> > exist.
> >
> 
> Seeing the SKIP is a huge advantage over dynamic definition. Thanks for
> explaining. Makes a lot of sense now to have everything defined statically.
> 

