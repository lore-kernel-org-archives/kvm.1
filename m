Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD46318B96
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995259; cv=none; b=IVbneJeUa+Gw2vhnRCXVRgh/T4/D+xrr8GSFJtiGklegtZvsD5zgybwh3qmRMopMeFMQEM8z269J0oBD9roo3TsgO672YAxWMk/Ng8fhR26BxTLgC2vgbzdr0qFNX3RbmxyYKywzcwACPYalgX/X7QFhJ7Efza3sWdE4G0mFr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995259; c=relaxed/simple;
	bh=1C8RNbWe+I5s+4e0OScE+9yJSnz5fyJaHxSntm/ci8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIFxssBfQ65leoRGDr/ateB16KP4aWk2yVl77OQhoEHBFth8YOdtaYS9zTfcljT/8RApMeZAhoLcbPWf6HddN8KW5FlSn5UFk3++UmMoOooBxTkvnVoUBbZWwx5DRPfAxs03HlNrVzhM7Lhp+42qMyTV8Bdj+zyA8tnF9N073E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsC6dDWO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsC6dDWO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so141341315ad.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779995257; x=1780600057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/fhdZbYznTMt+/KJqRWnVUaF6bgdZdwsTbunIaY2J4=;
        b=fsC6dDWOOXUWs0zv4FjmZCh1cijTnEvGTCV815ILDc4N9R+l41zaAyWEuJQCtuswp0
         xumMQybX7dHO5HXJZHFSeKdHU+SYshP+gsrY/XlbB/HsfBOFDheydxV8dR7CQ0MRG5al
         hf8QcZWG8QckQu6K1mTi9BfvwcPz08hHw08cIzt/7zXd5q7d2kBxTPItQoaGkYmuU9Rq
         YVUva6SbOkZh42vBFQ3vTY98FOvahG3FgvR2gvy4DAUKrVTK+DU5FAJwWxM64R570Fxl
         Fujt35fm68I83Q8oAMTzCzNyEEEbJnRvYDguNA2QTES2SDdnGamzIVUwo5tZtheXUwYb
         /QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995257; x=1780600057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/fhdZbYznTMt+/KJqRWnVUaF6bgdZdwsTbunIaY2J4=;
        b=TQMloLo0RA2fAa+LHJkZhioS6yZmhVlUOtYT84mpwsvRvKLRFUmWjbccdXE8nCw1k2
         Hla/KyL6adEG9nsm0D8UbQM/UT7IWbTMUAa/5OyYoh1ZUMMyBM3I0af8kfJVramFmk65
         4/BvKewJbaeSDuFSE2PDLQUn0iM3Gw0NLres2cXjF6wc0VHYj2eJNKqcbReZuqr7c5YZ
         fZTeTfyiABYWw8lr5AfIL4w9HdnQS6MAv70G2mOtOpGTuOfvVno8rxQbe3e5Z4L3Jfjs
         sqdxKj3+SPP/2qETy81e/CVfJgmi0e+q/1Xw19sF8R4VG1DS4nxoAQXSW/bu6R8atWT7
         a/LQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CZcB2sJsEKUJy4MDH+69bfGNlP0KvtpAu0K5k0PTsY6Jq9hIBi4pzYBh1oLrPy06dulQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXv6Lp6Q4WupvCq1chGdBp9OSZxxgIh4YUgvHFRhv4cr2gwsH
	BE0E4+5i3FxUwsaTwvcbrxWCFelpegJYOKkWuNQltLj3xUQqQhIDmNEstOIdzO5e8FyrY6rigF6
	U1uLR9A==
X-Received: from plpa2.prod.google.com ([2002:a17:902:9002:b0:2bc:aee7:306a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58e:b0:2bf:cb0:2339
 with SMTP id d9443c01a7336-2bf1e83293bmr1592185ad.3.1779995257206; Thu, 28
 May 2026 12:07:37 -0700 (PDT)
Date: Thu, 28 May 2026 12:07:36 -0700
In-Reply-To: <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com> <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
 <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
Message-ID: <ahiSeDZibiaD7pOC@google.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > ----------------------------------------------------------------
> > > Isaku Yamahata (2):
> > >       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to serialize deadline timer
> > >       x86: tscdeadline_latency: Remove unnecessary nop
> > >
> > > Jim Mattson (1):
> > >       x86: nVMX: Add retry loop to advanced RTM debugging subtest
> > >
> > > Kevin Cheng (2):
> > >       x86/svm: Add missing svm intercepts
> > >       x86/svm: Add unsupported instruction intercept test
> >
> > Any reason not to include this series:
> > https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@google.com/?

I ran out of steam (and time), and I don't want to merge like this without a high
level of confidence that it's the least awful option.

+asm(
+	"insn_sidt: sidt idt_descr;ret\n\t"
+	"insn_sgdt: sgdt gdt_descr;ret\n\t"
+	"insn_sldt: sldt %ax;ret\n\t"
+	"insn_str: str %ax;ret\n\t"
+	"insn_ltr: ltr %ax;ret\n\t"
+	"insn_pushf: pushf;ret\n\t"
+	"insn_popf: popf;ret\n\t"
+	"insn_intn: int $0x22; vmmcall; ret\n\t"
+	"insn_int_handler: iretq\n\t"
+	"insn_stgi: stgi;ret\n\t"
+	"insn_clgi: clgi;ret\n\t"
+	"insn_rdtscp: rdtscp;ret\n\t"
+	"insn_wbinvd: wbinvd;ret\n\t"
+	"insn_lidt: lidt idt_descr;ret\n\t"
+	"insn_lgdt: lgdt gdt_descr;ret\n\t"
+	"insn_lldt: xor %eax, %eax; lldt %ax;ret\n\t"
+	"insn_rdpmc: xor %ecx, %ecx; rdpmc;ret\n\t"
+	"insn_cpuid: mov $10, %eax; cpuid;ret\n\t"
+	"insn_invd: invd;ret\n\t"
+	"insn_pause: pause;ret\n\t"
+	"insn_hlt: hlt;ret\n\t"
+	"insn_invlpg: invlpg 0x12345678;ret\n\t"
+	"insn_rdtsc: rdtsc;ret\n\t"
+	"insn_monitor: xor %eax, %eax; xor %ecx, %ecx; xor %edx, %edx; monitor;ret\n\t"
+	"insn_mwait: xor %eax, %eax; xor %ecx, %ecx; mwait;ret\n\t"
+	"insn_skinit: skinit;ret\n\t"
+	"insn_icebp: .byte 0xf1; ret\n\t"
+	"insn_xsetbv: mov $0, %ecx; xor %edx, %edx; xor %eax, %eax; xgetbv; xsetbv;ret\n\t"
+	"insn_rdpru: xor %ecx, %ecx; .byte 0x0f,0x01,0xfd;ret\n\t"
+);
+
+extern void insn_sidt(struct svm_test *test);
+extern void insn_sgdt(struct svm_test *test);
+extern void insn_sldt(struct svm_test *test);
+extern void insn_str(struct svm_test *test);
+extern void insn_ltr(struct svm_test *test);
+extern void insn_pushf(struct svm_test *test);
+extern void insn_popf(struct svm_test *test);
+extern void insn_intn(struct svm_test *test);
+extern void insn_int_handler(struct svm_test *test);
+extern void insn_stgi(struct svm_test *test);
+extern void insn_clgi(struct svm_test *test);
+extern void insn_rdtscp(struct svm_test *test);
+extern void insn_wbinvd(struct svm_test *test);
+extern void insn_lidt(struct svm_test *test);
+extern void insn_lgdt(struct svm_test *test);
+extern void insn_lldt(struct svm_test *test);
+extern void insn_rdpmc(struct svm_test *test);
+extern void insn_cpuid(struct svm_test *test);
+extern void insn_invd(struct svm_test *test);
+extern void insn_pause(struct svm_test *test);
+extern void insn_hlt(struct svm_test *test);
+extern void insn_invlpg(struct svm_test *test);
+extern void insn_rdtsc(struct svm_test *test);
+extern void insn_monitor(struct svm_test *test);
+extern void insn_mwait(struct svm_test *test);
+extern void insn_skinit(struct svm_test *test);
+extern void insn_icebp(struct svm_test *test);
+extern void insn_xsetbv(struct svm_test *test);
+extern void insn_rdpru(struct svm_test *test);

> Also this (but less importantly):
> https://lore.kernel.org/kvm/20260317225327.4068448-1-yosry@kernel.org/.

Because I hate bumping the timeouts.  It's a losing game of whack-a-mole.  For
now, it's easier to bury my head in the sand.
