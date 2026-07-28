Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB53DA5B8
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253253; cv=none; b=Xba7O3njI+e6NeS9cvoMCKQgC+UFqoTBKsVasl2y25iwrwnMYqrZnwB6wBHH8r6RaYfrExZW4TPiEp1f9Gc08wTDOgCzhGqGewDXN28K6IIucfgXx01nx+gHBDEKnVD5OYa3iVyiLoF3XPJ+5dp8VaTuLdCKc7rdNIOqlCRaW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253253; c=relaxed/simple;
	bh=B0rZ9AFAxavZhVZrNOr4f+fPM5z6zvWCjh1uZl87yS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XZfO8Y+Xbf/eGcKqtaTCUAfUfuKTbVz5zD/5wVHJYDNlihQWDta6ffdfCUX77i94MgjCVzfMTRm3oCFk9IMNBsHoXHQfRlkZl0lPXwAloy/pTbuw/vLlOHuqwx7DmZPFI31IJDPg+YEOIiPJ2YxoE3yWE6OXPx8TeheKwXuh6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t77j3kTc; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t77j3kTc"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so4958630b3a.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785253251; x=1785858051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JRxXLMRq5vGMFyVh/dQxTSTYunSb4ZvQ41njtpatjAs=;
        b=t77j3kTcYO+87KBGManMQP1tO6gDGlOhsOOA1JivRZIxaSXTyoALHZyaEJtSrgQsMF
         sSGBSzaTYSmuTZ/Bz4DNgrjaokIbLZBXQrZyb1RpRyoICyPgqVud2i+QzgBzHX3yNMRk
         7RdtoqWXAFeR0J3dqwUuPlfcLhL4GHSKsSkaNX7LMjrYz5sg7KzZrNC+pArWv2RRo+4D
         RLrR6fViNqZgEY8QpTeiQKKeOw6O8dW/ds0zA/wLXHVfDZ5rD3b6pQCbvM0tixP5jTkd
         vMyMAe5iZ25CVjbHoJActaFt0S8d8p+CDzhXS8TueaFaXkFZrZjPNtcu9cJYSDc6OutS
         ua/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253251; x=1785858051;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRxXLMRq5vGMFyVh/dQxTSTYunSb4ZvQ41njtpatjAs=;
        b=e9ZeXdKdi1dmTPmxVHve2lzEP6sPe4l5yDu0XHtDvhKL9LZYjUn/J3lsMYJOVuFihh
         ko05p608s3elrF9bDxbZBXtBQ2kE+aqk3sBWcIln9c8zf2Y/m/nH3SaEolrq/tYZPNaw
         RsKfCLnWzRbeW2zzvlOoK1nqvBWCecabukelIvfMEzIR41xHO7h9qYg2beej3SIcJYpN
         vQJNkivaiZq2Z8CqwtzelA0HTNCRvZLLAcgYPTVqSVPsq8/NTM0CE+Kn8LHL/uPZQ4fi
         IP2Y9q4QAIiW6MmY7ln2v65kR+TcZV5SSSSjjKyhNvod537q8yOfWasMFQDYpj5e2Owo
         nmuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZnmapBDCDNB0kBWJoA/KkIMshZj3D4iHTLyjS6lNiQ2aOWV8hxV7kARJ3UdSfAhq8dfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2W+mdN1H628Z1wmqehD53GMHWiUQiq+3NJpeTUHUNF1CkjpF
	CyEwUO6cnYaJSMV94JpNgF/MIUDT516rgHtTKH49M822quG2s/tlpbpOcVR2+Ts4kZ9KhBAT2MN
	aGl5Omg==
X-Received: from pfbcm6.prod.google.com ([2002:a05:6a00:3386:b0:847:9472:cf8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84e:b0:848:2f84:f427
 with SMTP id d2e1a72fcca58-84e93338b86mr3228796b3a.64.1785253250626; Tue, 28
 Jul 2026 08:40:50 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:40:50 -0700
In-Reply-To: <CALMp9eRFinq-wUPJ27OvvB5pUsAC+Mxvw9W0uordbx8jSbFdCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724234914.987987-1-jmattson@google.com> <20260724234914.987987-3-jmattson@google.com>
 <amjEw9QcQN7owHKF@google.com> <CALMp9eRFinq-wUPJ27OvvB5pUsAC+Mxvw9W0uordbx8jSbFdCw@mail.gmail.com>
Message-ID: <amjNgqFq5ZmYplzP@google.com>
Subject: Re: [PATCH v5 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, chao.gao@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026, Jim Mattson wrote:
> On Tue, Jul 28, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > +
> > > +     cpuid(0x15, &eax, &ebx, &ecx, &edx);
> > > +     if (!eax || !ebx)
> > > +             return 1ULL << 32;
> > > +
> > > +     return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
> >
> > While I appreciate Sashiko's paranoia about "((u64)ebx << 25) / eax)" y=
ielding
> > zero, I think we should treat that as a WARNable offence.  And to avoid=
 a false
> > positive due to running as a VM of a misconfigured hypervisor, I think =
we should
> > only apply the erratum workaround on bare metal, i.e. use the maximum v=
alue if
> > KVM detects X86_FEATURE_HYPERVISOR.
>=20
> That's fair. We always emulate the VMCS12 VMX preemption timer with an
> hr_timer,  right?

Yep.  And even if KVM (or any hypervisor) as L0 used the hardware VMX timer=
 to
emulate vmcs12's timer, it would be L0's responsibility to deal with the er=
ratum.

Checking CPUID when running as a VM isn't obviously flawed right now, becau=
se
there's nothing that enumerates the erratum or its fix, but I'm guessing we=
'll
end up with FMS-based detection of the bug, at which point we'll run into t=
he
typical issues with trying to do FMS matching when running as a VM.
