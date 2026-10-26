Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036161;
	b=LbhmdwPTiGMO+R0LQ3niOLhOGZYAi6659ilGlFWrHyVk6TgW7LuMBLFPX8+MkUyKgqNV
	 BUoCMe3Laqd2sI6f0g50HXvZgckCGgYduI0e0AhlGcCdHIbqND6+VEICTy7pI1cCr/ADy
	 ssL2omFRPwvcVQDQK0OrOxK+bNYWPakAJw3ySHa31sllGnzUVnexDChEtyuo5xviIW3K9
	 MuJqMoDFVID5ZUdJraV9rDGcS9niC2aecgISfm/1AjfOx7HmjTagemVP7z+zHs3L8/N6q
	 sdYK9qrM9phqmPcGt8uqyqLDSWpyql40jI8D5wAH6gjYkrKB3dKv+ytB2vkp7GQBaOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=axrVcD0p5PvEtJBCkRASdU2YtEOHDgVXbwmKjNoGb30=;
	b=Z90XJafRyO8LwrQvrqJssnXE0k37vyzLrNDmMBHrjv0hlgxc86UscDLlKdPHEANZMoz3
	 4GgMr0mwGZPPenrTb+7Rn7Dt2lJ5pADxTyI/ufeODFzhGPGKjG6RsO84n88JuxRkEg/2v
	 8DavBWSenCYUU07JbMw3NAoGuXl8EUX1SuZWzGesY1jIANi3T8gh7WhDXQBOzYOE1hyjm
	 bhF9y6XOJus+f9BB9kz9915A6+H7Owrqk9M2zw6vGIwZpLek/aRsc3nXwr/V4P6V+dIL1
	 CvcpRKgCXWbx2hRJ2izaYN49qPtiD+F89cF0N6HEHzT0by/ZxxqJv800jBaUD/MPRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eGncRXIq;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6460606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6460606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eGncRXIq
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a079256596so2458356b3a.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793036160; x=1793640960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=axrVcD0p5PvEtJBCkRASdU2YtEOHDgVXbwmKjNoGb30=;
        b=eGncRXIqVGHNQGs4hfSwjOtKaTJd4KaN0r9pHolyrwa+OmicTDLvbFll4VIj/WztRu
         apDgOypywlVYFZ0PGCNTXsd53runcxOM9cYkc+WF6h3uvP7BRUtjWXNglSjisCd6ydAZ
         1yO5qExA/QuDaRvfsP10XifQI7DQDL7MFQsxaSV/XiXHeMZNwsKNdi5nK0mywrOu/aBX
         gRqDawHWUKybklxjNxlMJ8NCieN7AH+by/m0fhisjqPGnUyThKPhSOM4CI0N6l+ZSdNQ
         rsV7n4TcTsZxRH01sHci2k7hXYDSht4JdeP7wQPnuUrMNeWOgGL/Z957x+k4vGV12dO2
         vnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036160; x=1793640960;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axrVcD0p5PvEtJBCkRASdU2YtEOHDgVXbwmKjNoGb30=;
        b=wlWKdxQ7tTMJDrYAcGI/s+fsdlRa6j4lAYHrE3AmY9nRq/bnOVR6z4JNjkipQLiDoS
         OK+XpFWHmslxR12VRRmlxohtNYYrxz6eyh8qEuPdir7nMJFn6Hu+88GppTTvnF+lm/7x
         h2k7rs1BMVSoEehgd+o1XI1Q3ofR28qrPgKh8bF7ubnb5IDPL+kGz1AB5v7omn2ymH5E
         oGeJjmIX0bbGo4dMYpfqpPPcj6CiW286w8LA/j6C+8+v9KU5SyQjfHy5hoT2K9PDq2U1
         SOn8QRvne8kFvaxNhENFNdAvP3QKkkodH0AEul3PHcd33xtU/nzeXRkqHk8w78BqPy/u
         0qFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMcYpQbLSaMLP/aeqIYH4jo7zWeYs+M3pHxEPBnjLkhJq/dO8+UBmKpA+U3kwsoAcDQ44=@vger.kernel.org
X-Gm-Message-State: AFq9FYICzItfylxdVRHXGpA2zix2BbhcrVtDyiIb8/GSDFmzTzC6dOFw
	zbtPQic1R3pI+BA0aTOrmnFCktYNuS0nHyGiIe4ZtCATa9zAyX1q2fGOjAPqVjPVNka9WtPtAMQ
	rhd91rg==
X-Received: from pfbfh38.prod.google.com ([2002:a05:6a00:3926:b0:88a:f8c3:9c75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12c1:b0:893:4980:630e
 with SMTP id d2e1a72fcca58-8a3689aa54bmr6009770b3a.31.1793036159953; Mon, 26
 Oct 2026 10:35:59 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:35:58 -0700
In-Reply-To: <CAO9r8zPFEwUVYSTePWN-FurHLzGN6cY8bd-BOj3sjRmjj4xQbA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022215541.631694-1-seanjc@google.com> <CAO9r8zPFEwUVYSTePWN-FurHLzGN6cY8bd-BOj3sjRmjj4xQbA@mail.gmail.com>
Message-ID: <at-Pfgjt__PJl55M@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Convert all runtime WARNs to ONCE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, Yosry Ahmed wrote:
> On Thu, Oct 22, 2026 at 2:55=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that ar=
en't
> > strictly scoped to module init/exit, or similar, to ONCE() variants for=
 what
> > should be fairly obvious reasons at this point.
>=20
> Do you wanna CC stable?

Not really?  Maybe?  I worry that this will generate an absurd number of co=
nflicts
and also have "misses" in older kernels, to the point where it oculd do mor=
e harm
than good.

I could be convinced this should be tagged for stable@, though honestly it =
might
be better to omit the automatic backport trigger and just rely on someone t=
o
"manually" provide equivalent patches.
