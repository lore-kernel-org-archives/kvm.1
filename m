Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F441D5CFB
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924061; cv=none; b=JbNMipiUW1qCtTDQgBRBogEUx2VQtap+kx8IPDuZAt11G0O4hReHmvcT4pOO/fxDElaeJwBxxFJBYFqMmF+hb3slnsGD2liMY4aWIJVzSnVxCqnKhHZs/ghEULTgGHYm0CyFe7/BMZyvVVJMaK01GAx/cyqrqes4PQUzvm/sSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924061; c=relaxed/simple;
	bh=ON/ktfq+xdxNcM6NtVPaPUz2CESndUlor5dk64xJHN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsTSn9VftoWRM+tatsGrnHZpTF7Xk6SuRWFfe34FZt6HWOa26F45Wv5QSgBABgL7jaQDrk3TKk65/JVrHBKBPgCmem/ZiXAG5UsNp9Br33ras2T1sWboJU29e+dvGDCcuoY4JhVTy3F7jC5NOfItMcxabjOAZGv2prQK8JPT7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbXE42vR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbXE42vR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5F41F0155B
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924060;
	bh=OxDq5plT/7gDyBrJksKsNmaEaj2C+75liDclHv2XFfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IbXE42vRL57mvQVMaLbiBEzk9Kt+bdkeCt27exHR+34Y1QNthCji6bjnlH+woInka
	 UazOJTVf08c6n3Rk+V8Iz7x5nj0vcKFntUxOqf3uN2EaWNQfZFxxuu9drMkI77/TNM
	 1Rpj2zdqgT5BJAvKc5l5k6+ZE3rsOGWekHrV4ZLKVu8i5vbOsotg/UPXRhW6zA1AxV
	 4czyvWvn4q2liCYD9tFt0aHIYWHSO28s6Pn+YAhVDU3Lu2AdbuibZOgXoHK5h7SPpd
	 LluDQN2y8l6EcE0yNS7+JlyI8qgCzL4FvuNN/ubOaTg88Bv8xC9j6PrKtcHgzWKf6H
	 d5LCahLkNm/4g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcda7765d64so2329970466b.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:21:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ908vXz8ew05gKQ79jNwP7puJuwWEisxIU0G/JKaW9/ba1bi+OJmXT0rv2Ppczc8FvKF/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4xX1OF99HUWtjl/BSQiabfbVQ/k4o+276FlZWsvXkzovwAwA
	WUTL4I8TqDWSIORPl4i+2eJiX3zsAkzaxG1o0Hb5Qym5p9iDgsVMSm4brlH3jkT6dUdopOk5KN/
	EmOVgxgDeMIyMX79HzMKi9Goc5vi5vFU=
X-Received: by 2002:a17:907:271a:b0:bd5:1605:e1c3 with SMTP id
 a640c23a62f3a-bdd47dedf1bmr973874166b.1.1779924059476; Wed, 27 May 2026
 16:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-9-yosry@kernel.org>
 <ahYtNSL2LDhZx_kG@google.com>
In-Reply-To: <ahYtNSL2LDhZx_kG@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 27 May 2026 16:20:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zONa6oHM1+Y5V0hMMo--8rjfLX7ArATGxzDOGi8BYysyA@mail.gmail.com>
X-Gm-Features: AVHnY4K56E7ZTm9h538TCnfoKdRaX2yCaDJCMVDEFAMXKkjQ2jnX_y3kHDLz8lg
Message-ID: <CAO9r8zONa6oHM1+Y5V0hMMo--8rjfLX7ArATGxzDOGi8BYysyA@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > index d5452b3433b7d..03ed2c917bb56 100644
> > --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > @@ -1,6 +1,7 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #if !defined(KVM_X86_PMU_OP) || \
> > -    !defined(KVM_X86_PMU_OP_OPTIONAL)
> > +     !defined(KVM_X86_PMU_OP_OPTIONAL) || \
> > +     !defined(KVM_X86_PMU_OP_OPTIONAL_RET0)
>
> Align indentation.

When I did that checkpatch complained about spaces at the beginning of
the line. I will just ignore it.
