Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956D367B71
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208992; cv=pass; b=TcFF9XqVzDx3I8K4A9/3A5RCt5x5UpkPa4nXDXh/fs0AxnkOHPc2b0qYZZeqx/uQkx4dlpeAStlFDdT4a52gAiotH3SpeCeQarRgrOTNWq7RRBenK8B5VsEYpthZDqedjlkhAKUVeHm34O3s7wkKOUMv3GXFJL8PFM313YzJ1fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208992; c=relaxed/simple;
	bh=hJba3+vHUhRZcQprsnZOYpmT859TwISmDOQQW+AUK/A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq4zBHXifgYR7pQlpj7fifHkD43KwIffCDPHZssAgIm0pVevd0/smcDYjUbnMirY9K10SdHwGshf4UBLF6T/gu/4jL0lfa0iEsRWy3TYXoxpb0b/Lced6VtIk2BgNarg1sXnYGB7lrBXCI8IYkC826wai6sqg08BHHNsQneuovI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3oGGg0/; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3oGGg0/"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13809223fd4so276750c88.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781208990; cv=none;
        d=google.com; s=arc-20240605;
        b=iZo2GwDg5NM85nXlm7go5fQuuHWGmIZe/imt+R1t/OzWU/mSHIWjSfmRo0u0xDG8KR
         CnWSxogus1KeuaAeYsBi4lf213rJvnDq4GCKnbDfLUMOHS5HKDgRS9VthrKQjwS4o9/3
         Y8+l9bpHiQDBkDqdLkvB/rt5UjeOqYt/M6gakolpr0DlZfTIT4nHFP/xiPYwxntSZZtw
         0QCNnT08XtjHAnjHAsbK2RkaWHQvh8emLEMru3gSGYWmz4yCwWeFteI5k9MEi0vtGQHj
         y4B8SGgtqiWLdZLbAp/d4Hqbgug0NT1R5b3Z/NAzqvG2GFkwI8sHq9o8sy0tMZiy0CeP
         s2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=c6w4o8cPFnkNvj1bY6N4ohMTXqYLTs78fDk/pXJtYGc=;
        fh=dAAoiL6RiU75H5WvirX/gIQ5AvifpwC0i8gLUyGu2RM=;
        b=dIeUO5A+fRGI6jwtYyHmfjslFqAKqeWyCah6lToZFQmBcw3mXtN7quEO0Q61fb5JOe
         W7kHpfNGKv5S/hRznQ3yKP+5CAueO1+f63i7IzTmpWvftN4pA2Tl/uv7oasGVjL3wpxo
         5pqyOzeOBMOX81oeRvw1yB5t3wd8XmNNTtp15qt2hvlcZwbQQ2Jnq8a/t2y0tB+v77G9
         uEPVCC1ttQyAALYIOuIO1F2APYkR3bvWt+vAYkrf0ACv/n7CWbnm61JRlRZk1z5zdmjJ
         ca631dk9195mNfsnz5uvp0Zq3Rp/0JCRSDXKJB9LJAz9MJPzRtrrck42n/j0wBKTVnYw
         1eWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781208990; x=1781813790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6w4o8cPFnkNvj1bY6N4ohMTXqYLTs78fDk/pXJtYGc=;
        b=f3oGGg0/7rZPWaCJBnzE5By98SJvMx6oqquL+2qn2D4FB1BKxhPwb3nsMH5Xertko6
         qHW6sA4XUa2Q5JHPU1jUFt1De5aiDkwFTa6RYLj6HwP+z8Dqqx43Pki/TKxTgMi1dS2k
         Vx9lTymVsWYWEvVbFwQTfx0y62pvHaLuqpbe9b8zAqfmBKq01c874d1iq/LANEjAFP+t
         4brXavxu1qySjGywMdRIkW4zKl7iyvaMSUoKEbNR2BB95EQT/oQ6VNwWk8ZTtm6iVfGU
         q/UAgsJScGLYfg35lbW/PEBaRol7QsHHlQVl4Ol/Ozj7WFnsPzDSbq9kuvipu8n1P9WQ
         RYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208990; x=1781813790;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6w4o8cPFnkNvj1bY6N4ohMTXqYLTs78fDk/pXJtYGc=;
        b=SKK7U2lmVtdEVKgFSxgLt9EfC0q+l/P2Ex1RzpFw4RCqLCLnxhD7SnzsDXKjDlaSQA
         KzvbTDw3tqEwYXB7C+FGlNxumvmEtORpXft9gi2t0/BU2W5hIY+K0tCWPbH15IooJs4Y
         m8UB2EiMHLshu3Cs4rr3PnKTpQuhOsv5vMMFdSHnnAfdHr/sOTkjpXvmT3FHVjIPVyU/
         X58UUMgAcLkU8DVE0KaqVwS0WA5U9PykV310F0yvkXZl6p1sFOxpVvi9Vm+f2SrRBqqi
         T/7vj54CuodkExk2AY4qGd5c2alMdi9a1O+FO0U8DKa6IsHDayoJFucfVHucxZyZTFbr
         RkYg==
X-Forwarded-Encrypted: i=1; AFNElJ/r0Cwsp2GNJUqvrMKAPD48WwgUDdBz41jpjBgBUg7BWewutfCGwVIsHjB2iPO6yzWvxIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4mxjb9366ilSwLlstK9vuojpvr6mVZ/y9ZUl7uTLn97vF/X4
	hNuJe+fGkyChbCx0teGGPD5XhVdnZBGYEaieQ0NnBWF1uURBtZ5e/rC4emvCLonqDHk55h2XEPy
	shUi4bb2kFscNR52ydh3HWd9EG9RPshCKU/AzJZ3H
X-Gm-Gg: Acq92OGKQPn+Ne/ZCqx4lSmpjrQ7n5L2BIvzA1/y5Vh3xShlCifK7YcMogHr5TrwYJy
	G+n1ajlAB4HqzokkF3eVKkUsUev8e2fY/aqMw1X5fr34+bEacmzNl/45x9NPqe6TE8rvgpuop32
	emN1jj7Z7NL0zaf9ZIfMd0BAofFgtacGugzOq05+t+ndSEr/G/vvw3wsObgnPQYPVfus0ECuXNo
	dwLr1RIOjIv1oI+vcqBBORancLH4M55rVbGgdcc5IQti11k/yS7RiZ/sV8WEgiMKk+1V9VkPkfI
	/zAikL+/AQqJNNhzk87PQmxFWUBPpHVyS8hUVIxEIGpJjlbpJ8phaXVVgmcVP0eSptyn4g==
X-Received: by 2002:a05:7022:fd04:b0:137:fb6c:5355 with SMTP id
 a92af1059eb24-1384211e6fcmr2478309c88.3.1781208989421; Thu, 11 Jun 2026
 13:16:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 13:16:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 13:16:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aisHySKe0PwM5DSg@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com> <aisHySKe0PwM5DSg@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2026 13:16:28 -0700
X-Gm-Features: AVVi8CeGqWOzdSyzWUUivrRwH0AG_QWu1g0DCt9ZOfKtFkCXDKefnGkWsFu90NU
Message-ID: <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
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

> On Wed, Jun 10, 2026, Ackerley Tng wrote:
>> Vipin Sharma <vipinsh@google.com> writes:
>> My (future) use case is that with hugepages, I want to run something
>> like
>>
>>   ./guest_memfd_test --order=0
>>   ./guest_memfd_test --order=9
>>   ./guest_memfd_test --order=18
>>
>> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
>> tested. I'd like to iterate over supported HugeTLB orders at runner
>> runtime instead of at build time.
>
> No.  The right way to handle this is to define testcases for the "interesting"
> sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
> is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.

That should work too. So at build time I'd make it define all the
possible HugeTLB sizes on every arch, and then skip as necessary.

Why though, why not find the supported sizes at runtime?
