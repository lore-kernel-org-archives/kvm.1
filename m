Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87323E0758
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975366; cv=pass; b=LIk4O6/Ngd2BTyjsygWnVWD5TQANavuCDSZ449wPXeoTuhI47F8f3210PdiEU3b6RxlEWWQSnViJwrZtn45A8D5ib6WSPnwn4CM4gqXrKX81wRSFN7AMyfkAXvlGPg6wh4QKpWMvatDUykm21y07/lwKPsBgW2KadYes8kBHrtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975366; c=relaxed/simple;
	bh=P3IrmMXLL4fCFKTzkSjp/aO/dyw4SFgXHah2BzkaNuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrDBFnqltEkOy5shNgOtMEwAG2eOWnBdiWQa5Waeww8isNuxerP4WOtVtpknxWqV2wVd/ggt/nwXoG2/HooNar5EUtDbZL8Em1v7VQsY03I/0XcAt+7TdkSpMHaJtzr0SO0cDf7ZK+Sswi9ZCcEQHouZyFHDWG4pK/piIougTXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpPV3Lu3; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpPV3Lu3"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5751770a178so4237560e0c.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975364; cv=none;
        d=google.com; s=arc-20240605;
        b=GXxrLSE7/wzz5gsTrNASRLagA1YkEqRNkEoD3Jrgq0jvz0EzO0MfrC7B8FityHG7PE
         dGNSyYMXPgHxvAs1xuHjt6F7Q6TK+kMoQ08jusZydIz+Dj5h1NEfUghRhQDj0uUHVO0S
         IuqbOaLmqoKfGHUCVI5CWSvB1xonmoUhbICtqN+aGvfYgVeEhFExM5m/C3fKRJEeQNYC
         wDOC6fToWxFY4Y272+64X6hNLx7yk/MJ8fI5C73khFR7wlVJEEGb7Uc+XGBv7J3l098s
         LlqQSZMg6YXm1HpluiKB5SBBNCppEsMkoUiQwmqD7W7a6qKqSFwKdws77Sghy1kNi7Ld
         vCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPeJHskhd3lDys7i6trkIEfX9tWtfy1Nmsn6Xgo+Gyk=;
        fh=qsdwhE9bSPJsmIaaYaNycx83pC1gKHmlQz9cI0QLAb4=;
        b=MpiOuDN5/NeY5A5YYytgNfA2vcPVSp6oFUEQcpZxxO6F2zZ9Gu2PJZ8lBLWvAFb3g2
         FwX4w4yHzPorzWoopLjQXkJmLyJDeNn78eblS4zKAFNGIA+d8LapC/H/Qgv9JfT9RSiw
         bqxbe8WhoTTXBf2wmSgp9wnvZ9fEXYpHOc0Gm20zHSZeoKczX8vAT0E39JKcTnlsOjVK
         Yd0rrqDiKoLGWWzVLvcuEjxqYj1CmL2i19491+IJfYM3hVhxZRFaFqKHU6JL/r46Alv1
         POVjuCNbZ6Rhb+zvp0O0lDc8nt2CiKezVSoUnPpi6PB/jMqswLjsoMw00cFwihZDHiSW
         /3kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975364; x=1780580164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPeJHskhd3lDys7i6trkIEfX9tWtfy1Nmsn6Xgo+Gyk=;
        b=cpPV3Lu3QsQvkemNpeFgOUZsB/ZquJVRAwXZ1Xf7Omc5k9oIoRD0kaAy1iWcL13oAZ
         RbU5szSeFDcGblVCCqPZRJ/kycqfWeM/UKWAg7t7Tvku4taccR3Anta3amB09uw5y3ji
         1hhc6KrWRZLsVDqglQe5PzehO9X8VUbjLEx/65tJwkgczVErCu/TNS7adMq33/rbPRcw
         wrCxnQ61Q02iK0/B7uwgVQ/W71WKz35InWNQIRbtfrP/2xNjcYJfTuBsyLGO5aZH8KiV
         12cD1ZX8jBl6rRy3lBO1hPH94Rz7BGepVP2DfaG3e/2x0DD242lyHGG37HwpVdhTHtLJ
         wzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975364; x=1780580164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPeJHskhd3lDys7i6trkIEfX9tWtfy1Nmsn6Xgo+Gyk=;
        b=EOP945ytU100BlLl/jlg6EJSosGO/KI7PTEcqQhpo4LYtSynDgy04RuOTckLsVWoFb
         /pAxICrZjcnvCizGSqlDNZzjjS4F5lO4R8E7Cp0wvmf0Nfm+iXIxAHlo2Xh61Kv71wV9
         2WY88DJyn2FgskNJcvH1QGNVnDUzxPg7iLx7VWH72My1fBHs9WAfmUzpNnLHDOzwlNAy
         PRjQ8MB+JH9zb1rCMLqAh2gPUV5gG+5yfN+zMZOQErjFfbHyjtil4WwWuaiyX3QZ1OOr
         c4bgAhmtTs9HBg649Q7n3LRcU1fZHhsQHTsNIZfJ0POzjcEYWT1vdQBttbCkgsbipZ75
         342g==
X-Forwarded-Encrypted: i=1; AFNElJ9hP7xDaINnQa0Su6B3TpJYwG6iNU3ZCGUftTFHuEzU++qBYr0QNfiKdGYBf8N+FEw/fVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKjB4DZ4V7t3OPVZjTb+oXDO5oDkSQe4nE6W/OQ8xiAph/iuM
	n3WYkSmZQMNYNhAAFx3O86uJlKCyjd+Vqw7x3X5tqVMQMS86IyVgYw/H7LExh9XmNcwMHaVatRj
	NnKbEA8V/vpMzWU9JUbt0hBRRvIRvVyo=
X-Gm-Gg: Acq92OHNNUeSQgnl+B2vK8FhqVHm5qUtZPn01mb+LQouiR3w8+GXN7DxWhj9en4zShU
	PLZqO3EF4iYubd7NflJ7iFrDwm2Fv3/2uVnAUyOeeUrKkIfHrCzY4I0FqvE2RK4uvLbW73hlbc1
	ZcRB92/YIPBOaBsMdn4wyrYi6tf2KNgML4i29yd3oZmHiO/wnC18FfUKaRi1EzG3hE+wbBJV/r5
	oS+4x2b1UUk4ciojuxgC/wdtEZ2TZ+Pi2zGMGMLEo/KLaSpPKhYko99XYigAdzX8Ty/5sz4hepw
	/kyplYhAEqDg6Fw6QETHx1L62ovwtlNIrwjDlBAde4FzMzcKSknloD4mFOA=
X-Received: by 2002:a05:6122:488b:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-5866357db32mr16295687e0c.13.1779975363787; Thu, 28 May 2026
 06:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528032234.1322565-2-ewandevelop@gmail.com>
 <20260528034244.DC8041F000E9@smtp.kernel.org> <CAG2uPc4E4mW9Rvxb7PdzRByd9teW0KcJaKHB=ZBHQWLa_6iiJw@mail.gmail.com>
 <ahg53BN4d0czbjDV@google.com>
In-Reply-To: <ahg53BN4d0czbjDV@google.com>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 28 May 2026 21:35:52 +0800
X-Gm-Features: AVHnY4LJsniyqGtalKkBuOM_W9C5cFOO2ChbZ2YbxUmgshSdSRhpK_snLHS2uBU
Message-ID: <CAG2uPc42aof-csbd7ZEyof79UG0A_8vvTtMhJx0cdmmGq+YDRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 28, 2026, Ewan Hai wrote:
> > On Thu, May 28, 2026 at 11:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote=
:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Low] The patch modifies `arch/x86/include/asm/cpufeatures.h` witho=
ut syncing the changes to the tooling copy at `tools/arch/x86/include/asm/c=
pufeatures.h`.
> > > --
> > >
> > > commit 17e8fbfd326bc812ee6f132253d520b0c7201874
> > > Author: Ewan Hai <ewandevelop@gmail.com>
> > >
> > > KVM: x86: Expose Zhaoxin SM2 CPUID feature
> > >
> > > This commit advertises the Zhaoxin SM2 algorithm and SM2_EN features =
to KVM
> > > guests via CPUID 0xC0000001 EDX bits 0 and 1. It updates the CPU feat=
ures
> > > header and the KVM CPU caps initialization.
> > >
> > > > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/=
asm/cpufeatures.h
> > > > index 1d506e5d6f46a..20b33413189c2 100644
> > > > --- a/arch/x86/include/asm/cpufeatures.h
> > > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > > @@ -136,6 +136,8 @@
> > > >  #define X86_FEATURE_HYPERVISOR               ( 4*32+31) /* "hyperv=
isor" Running on a hypervisor */
> > > >
> > > >  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001,=
 word 5 */
> > > > +#define X86_FEATURE_SM2                      ( 5*32+ 0) /* "sm2" S=
M2 algorithm */
> > > > +#define X86_FEATURE_SM2_EN           ( 5*32+ 1) /* "sm2_en" SM2 en=
abled */
> > >
> > > [Severity: Low]
> > > Since arch/x86/include/asm/cpufeatures.h is modified here, should thi=
s patch
> > > also update the tooling copy at tools/arch/x86/include/asm/cpufeature=
s.h?
> > >
> > > Without syncing the tooling header, tools/perf/check-headers.sh will =
emit a
> > > warning during the perf tools build process indicating that the kerne=
l ABI
> > > header differs from the tooling version.
> >
> > good catch, I'll fold that into v3.
>
> No, ignore Sashiko.  The perf tooling folks keep the tools/ headers synch=
ronized,
> they are very deliberately not used by KVM selftests.
>

Got it!

> P.S. Please don't top-post.
>

Apologies, won't top-post again.

> https://people.kernel.org/tglx/notes-about-netiquette
