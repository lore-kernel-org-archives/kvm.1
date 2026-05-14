Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337D372065
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776514; cv=none; b=Hwf18VV4IMNaheq3kEUoQ6gnbwYMYkZKHdAPS9plNYwmfqLdYn6+fwwP+NxyzBOK21KHIXaWWzyo7eqFgHRdkwqHT7PQTmsLnEB2WVEOFIjBsrnKJVK8/R3zT+9vYk/jR09u9n5pgQYSZGAS4lL/gLBPtv1LuBKW8Ei14xhxHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776514; c=relaxed/simple;
	bh=WhWkPACskd+b1+tJ5z36dWahxqWLD9w7Cyw5tEk9498=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJrr8yjW/SOmlOkZTG2JiccUCqZNfOfDNuenJH7YB6GFRstdFdpjPSC39ssjxlr+3oAE0Qdk2bOpuix8UXCf9sl2zxEjsq4KflpNc5AuvuEVHZ4EX/PZhxH6NCYakqu7nzK/ss4we81RLeHggOFTsonmRGNK2EINpdCJ6LoE+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jg65vM3I; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jg65vM3I"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso3999744b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776512; x=1779381312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uu8I43SPbPwHLlt9r0FdPHw/6cgthMY9Ti4JFAvZSSM=;
        b=jg65vM3II9800zOzHnuXxM/H5Vx9QYKs1MQEBMEqLEJW3fxGvXq3Rts4UsuvSctkHN
         4TQoeyh4wzDhassidSo8FCN8eYQEIxYa7SaIyM6skNxqhvOf7Ra1pKKpAzpE4EXJ6bf4
         AY4J45uFoK/7O4s0+292s0pA4vLv4b2L0h9iUnKPQboYYwmHXdQ7Fz4GVkZj7a7l+CD/
         RrrqdRUdS1rofxdjybwe9bWQ3NRFbIWKCUJm2DCtM+wWJQfg4MY6AVvqxsNk1WwUIDl9
         8nLOHNm0T9UTbsTJxtuzFi2scyORRoCwHAAFSqASaxQu8A+wpIhNibvRED80qFmeXi7/
         UOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776512; x=1779381312;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uu8I43SPbPwHLlt9r0FdPHw/6cgthMY9Ti4JFAvZSSM=;
        b=SBQx3SJbQLnF5XLFaPrxAyN2kAtgH5cZlTvQ3mpt83/mUk1D0nkBAVYUUJyJSknrzL
         N/iI+D8Etm0Y2nWw4kRHmYgflQWFMQtyvwiNOkFAkZLM7G05eQBGDkIdWaO7c/Tta/Lx
         lVhIWVb0+rGIJdgETfkEkpteTKYqEjzEpRBx9kuGeH59gI9d/0Sw/nU5jef9WmBTG2Pv
         O1IvyXxvtVyzbTZwTMKSGJ70m/VjrPPEzPk9dvgIpUlfrgfSDx83pTt74dXqmmGvQ0r8
         3yTqrq9CXJH4AJEB4nuqldNtucIx2uCQfB4D/fVS3EpeoGutXLvk8px0vwF2gh1OP1hw
         Lw3g==
X-Forwarded-Encrypted: i=1; AFNElJ8yZZdiUZ2Ku1GAEbarfU0XfZy/6Hp4XX2T3hMZdVmF7+xlvkqF2F4pB3q5gJY7wO3a+Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKdKowm/XwsGGI3KonQt7WO3WmTl1NAWF+YfDPMG0s2eElorI
	EI4mpw3MiPsxJ+d+yWnjfmO/InZaf8BqgLxOpyFtD7NkUBjIDpIFA34yARtIdzCf6E4fwXJ3dNS
	PM1ncvg==
X-Received: from pffk15.prod.google.com ([2002:aa7:88cf:0:b0:83f:1941:b9bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4397:b0:82c:6bcc:f3fa
 with SMTP id d2e1a72fcca58-83f33d97b1cmr252436b3a.35.1778776512174; Thu, 14
 May 2026 09:35:12 -0700 (PDT)
Date: Thu, 14 May 2026 09:35:11 -0700
In-Reply-To: <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com> <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com> <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
Message-ID: <agX5v1utAfyMadPm@google.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026, Jim Mattson wrote:
> On Thu, May 14, 2026 at 9:20=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Oooh, this is based on the generic CPL rules.  I didn't think about it =
from that
> > perspective.  So yeah, addressing that does make sense.  What a pain.
>=20
> When I fix this in version 4, what's the correct footer for Sashiko attri=
bution:
>=20
> Assisted-by: Sashiko:gemini/gemini-3.1-pro-preview
>=20
> or
>=20
> Reported-by: Sashiko:gemini/gemini-3.1-pro-preview

This, or even just:

  Reported-by: Sashiko

is good enough for me.  I don't expect random developers to know or care wh=
at
model was used, at least not when it comes to reporting bugs.  If you use A=
I to
help write the code, then maybe I'd care?
