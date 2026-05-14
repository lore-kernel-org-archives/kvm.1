Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB03C4168
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793001; cv=none; b=AuXm+d7aBdOags9NEUTs5NowD2x2FRjo5DtG3d2V0HSgg+NV1OaqHD5573vdteqcFCSFm2Xe/JaD/g12T0ux/E21nO6ROMYPLhcBMdeSGAafs+lL3ePOr64wDUwIggi0JNoOW28FCnaRtU2tz7ohU1eqjHIJFsvybV+3VnJapNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793001; c=relaxed/simple;
	bh=QB5wm3xXK5dICUHnaN7pbl8wf8LXXJdLhbRTbVK8gXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSrByBJ8lt3N1cBiECBcyZj94f4SVHJ3YhtY+crV01wXhY05ErD/oF6ciFFMnxY/OssBQgUZVmsDGFoT0KAITVQz59YS2ZfhxIdNevP7htKqNNJzwfi/Z6JsV5higuRZaz4agkC1CAdGehVbshQS/X5kgl+FUrlepIRnQGAHsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyrOgUCw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyrOgUCw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83565161a6eso126007b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792999; x=1779397799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV9v0q+Mx90211JcKlwR5dAkL0GPpC06G6QGntY1+Sc=;
        b=KyrOgUCwUIfMoEfAQ/cMbckMcCc8Ryfr58qn2Pl4pXKLzwoxptRmmKSR/dNrm7WOxO
         s54gHEpUXNmupCKkSc/ULe9zGtsw43Ic9GzVuKmTh7Kcr2HG5K8f2VlXAtr58cL+6Ef4
         dmxmVqd5WtBJDpoJ6IwXEiCvts8sWQpjou8tpLRtuFASA7xeDcaaUTQITecgsCM2OtE3
         bX/Z5z/ekGjQ8JY+GIg+XNsTk04MRpME3sCNXzUg3AuB0/eX2KWPe8Kvu6XS28/5qTrb
         l36HI6XvpBhgzilFTGwuW9NfQPJ9tO3iio76jkC8N7Aj5Ee0UfahE+PlcfcKHzt6Dian
         NZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792999; x=1779397799;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VV9v0q+Mx90211JcKlwR5dAkL0GPpC06G6QGntY1+Sc=;
        b=Y5ao7qqR54HgnEFPBdgynjETY4bNxM+YLUZHek1cYJ/KZWZw5uB7hLXT9dQZ1g5dbk
         EVmla+qDRxLgkqG6S1EV2CzYEis7d4I3eMExUv2KpaoNuqz2jz7kpGWC1w4vB1yOJYxE
         69OTBAjMZBHDu6wK1EI6ACcEiDZoxIqir5ePwGRj8D4QsDgxKvWoufhzOutAW+RM4xO8
         hrrBKzt1BbMND/SbKAuSeAkUVt6cjAAm9ba1wl1g/bAZy30BmfqA9t0HeOD6qlvIHb1h
         UEg8Gj0ZbfbtC174H7RInxId6rGzqd1R0aozsqiecYr8f0UczPkBFDSYgGAyhMaxCmaV
         Dedw==
X-Forwarded-Encrypted: i=1; AFNElJ+iA5oAhlfuIgqZRziNtWdmQEKOKhgeN/mxSAJSaM2QHaV0fMzyKxlai9gMzW1F7pCgqio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywq4PLfIgoccY6Bpt7xALXkuHpz2IOo1SvjG3rRZSM0E3lLn4E
	W2KTYThtZTEaokDrCl+MhJkMw9rN+TXJ1dLVBYEOW0Z66bpaCSo6KkxdqiJesU5X9535uHuMoBH
	8C3RHXA==
X-Received: from pfhh2.prod.google.com ([2002:a05:6a00:2302:b0:82f:7163:35c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:882:b0:82f:4725:f6d0
 with SMTP id d2e1a72fcca58-83f18ec292amr5190059b3a.29.1778792998614; Thu, 14
 May 2026 14:09:58 -0700 (PDT)
Date: Thu, 14 May 2026 14:09:58 -0700
In-Reply-To: <agPUfzbMzTU1ebii@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
Message-ID: <agY6JuEJRhwpwlRL@google.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, isaku.yamahata@intel.com, 
	pbonzini@redhat.com, erdemaktas@google.com, vkuznets@redhat.com, 
	vannapurve@google.com, jmattson@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026, Chao Gao wrote:
> On Fri, Jun 28, 2024 at 05:39:47PM -0700, Sean Christopherson wrote:
> >This test fails on our SKX, CLX, and ICX systems due to what appears to =
be a CPU
> >bug.  It looks like something APICv related is clobbering internal VMX t=
imer state?
> >Or maybe there's a tearing or truncation issue?
> >
> >As mentioned ad nauseum at this point, I'm offline all of next week, so =
hopefully
> >there's enough info here to get a root cause...
> >
> >
> >A spurious VM-Exit will occur after programming a vmcs.PREEMPTION_TIMER_=
VALUE that
> >shouldn't exit.  Every observed failure occurs when bits 27:16 are zero,=
 with a
> >small value in bits 15:0, e.g. VM-Enter with a timer value of 0xe0003bf7=
 or
> >0xa0006db6 will cause a near-immediate VM-Exit.
>=20
> This behavior is documented as a CPU erratum. See
> https://cdrdv2.intel.com/v1/dl/getContent/793902

Ha!

> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large Timer =
Values

I assume the same erratum applies to previous generations as well?

Thanks much for following up on this!

> Problem: When the VMX-preemption timer is programmed with certain large v=
alues,
> the timer may expire earlier than expected. Actual values vary by platfor=
m and Time
> Stamp Counter (TSC) frequency.
>=20
> Implication: Due to this erratum, software that relies on long duration V=
MXpreemption
> timers may observe VM exits significantly earlier than the programmed
> interval. Intel has not observed this erratum with any commercially avail=
able software.
>=20
> Workaround: A mitigation for this erratum is for software to program the =
VMXpreemption
> timer for values below 2^25 =C3=97 CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31=
:0].
