Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D513C9C4
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226431; cv=none; b=fprQRaKNgVWpA4Asl/n6c3zhshnSojiDE/n06ihItN9Hqqq0EL22iV6bD/qKaaWng11HAZBh5vTriFHXHIS/MrQJbttx7mxmWpJISc4RLrR9iLDRDcchtsKgwJYzY7v/Eqg3UgZ/6yd1SWNDPdoOyPiX4AebHrlAXTwsU1ibopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226431; c=relaxed/simple;
	bh=EIdxZ9tCemDGSxRT7l/259cIzPqZovEd7qIl+4+bbZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbmvW6wwUQ6IbYXz76wkv338MUZ343mIAmwZ3Gt9/PetbURgdYLEtdhuouyv6GvirWmnmWBl8v+UIBm2BWaq69Gjw9eBR3y0zVPfTCpZ6+XSc8xSpOLjn4c4P8udq0TddS8LYQMJbIa57vHv8MqrwIQaRALn8GmqpcQRVD7HQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIq0Bucs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIq0Bucs"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8428384f31fso352712b3a.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781226430; x=1781831230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltYTnUEFnoWpppzAgPG27GJdcRnPuw2iznLkjvKvVEY=;
        b=lIq0BucseDSd5E5idgpTPKrfPq50hT6HGrGwy4dgAo3lt2ADJc+9UmiVOTcbjCOPQJ
         IN83ttdv/EtYWof/qLZOa/suV9PE1JIk7H38fu59xl/iuI/JZnTtPrUYbkkRbOEP8Rcz
         m+pDi0CunE+j9x2EAiMDYYMh3IDQmib/7TW0yRDKytTX5Jy93EIet0+yXAcp7oeI7mFT
         nBe/BwsPFfgXnicQUn1yTypFFB4NAEfysKU9vkvBS9pzlCQsZHnDWhGyfhdjQ4dvCpoc
         HZbN5nzIS2cgJVsnoUY6jYkEOmMmZ+PnlW0ld2VjvXZp3qtevtTpykLBOUhfAbZHc9xL
         ZyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226430; x=1781831230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltYTnUEFnoWpppzAgPG27GJdcRnPuw2iznLkjvKvVEY=;
        b=cVdXmjQsjlMcYjfJj6lFczZ2y4/FhDhRuGzl3asCxIsppU3Tvk22J2T0v1hQkuaqGS
         KumylPDUmrpQyIAhH8lvHAGUREsv313b2TGovUrqMtiNL92T9t8XDEk+VkZ78J0zBaN7
         YSDlNZOKL+3VBM3580IV5okBi7BGMHYCe2jQ/MDcjqb9dmHoxuwx31E9aXoQT/vcfzNH
         DwX7M3Ys1aJYQSvMRPOV6qEq1Fjv/LG6hqSh+AI0qpaX1s/afeRoNB0ejTG20SMuxLGe
         x1RJADlGF2ygk08ECyG9HbL9ND4kCzKs9FOykfMYDRPryM8Jb3XmrWjKw+vneHl5o6zB
         DfRg==
X-Forwarded-Encrypted: i=1; AFNElJ9kzm5zDcUALJ6OYsOW2J+NtUMbI/xEO8qIXx1GUCZacCNWirVwORkf+NocnbiMRkxydTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvlJ+5ZnrhjcBkKJqQzTJ9iuEfpoaTTN4w64hdwAvpIxrp1jf
	DD5sz/J2YOibeNeMYiC4HHkpRnnd5sDUkddbgNmPuLHACvziLzTFtzquIlwBKrZ4BNwdJ4tk+Vl
	CuUIQlQ==
X-Received: from pgam22.prod.google.com ([2002:a05:6a02:2b56:b0:c82:7761:9941])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8f:b0:3b4:6cae:4a51
 with SMTP id adf61e73a8af0-3b783b5ffdcmr817576637.11.1781226429893; Thu, 11
 Jun 2026 18:07:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:07:09 -0700
In-Reply-To: <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
 <aisHySKe0PwM5DSg@google.com> <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
Message-ID: <aitbveI2Sdx4s4BP@google.com>
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

On Thu, Jun 11, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jun 10, 2026, Ackerley Tng wrote:
> >> Vipin Sharma <vipinsh@google.com> writes:
> >> My (future) use case is that with hugepages, I want to run something
> >> like
> >>
> >>   ./guest_memfd_test --order=0
> >>   ./guest_memfd_test --order=9
> >>   ./guest_memfd_test --order=18
> >>
> >> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
> >> tested. I'd like to iterate over supported HugeTLB orders at runner
> >> runtime instead of at build time.
> >
> > No.  The right way to handle this is to define testcases for the "interesting"
> > sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
> > is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
> 
> That should work too. So at build time I'd make it define all the
> possible HugeTLB sizes on every arch, and then skip as necessary.

Not necessarily at "build time", the testcases can also come from your local
environment.

> Why though, why not find the supported sizes at runtime?

You can find the supported sizes at runtime, just not in the test runner.  I want
the runner itself to be largely oblivious to what's its running.  Disallowing
more or less _any_ test specific configuration/setup in the runner is the only
way I see of keeping the runner strictly focused on running tests/testcases.

