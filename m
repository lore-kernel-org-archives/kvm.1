Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B81347FD7
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776958420; cv=pass; b=RkMVPU2Gh5p/HnufZ9+7zhpNIagGSKFrHHspcYNT4U31ZOJ7CxmqmGuWZ5Vjghn+N6ZzOVlS54VvDtf8FNt7BpmeAs/2TbynviQ4wqcH0lk97B7zWdxe7nEzvIlCl05mksC/BO3PCmh76o6gTzyPRT82j8gWzxFSA07gazIOaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776958420; c=relaxed/simple;
	bh=T1pnK3/dcF4X/41Z3x54tQM5m4bmMwR39FcTWzI8hyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szaO2i1NkQQ+7bCnUkbFqlJEIOcLfTH+/+KVah4I9CMw1qhKtxV1EVBAk3VyrSwS2EWUHd5d4w4rqtuoqrQnq1kkVLVB5Jn+QHkQrxzVjN3eRV5qzk3emJtqyxaVLx1kV2KaohROkwdM/IHf0JxL5f2V74GlClNIN9PKBsrBs0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2YqI+iE; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2YqI+iE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso54267a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 08:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776958417; cv=none;
        d=google.com; s=arc-20240605;
        b=TFHkdFkc6t244uBlf/DxDM6+4U9In7SjkEy5JD3HqHcNpJF3EYRFHRmXerAoWkaGpr
         WjqGNhc9WFIz9Gu3uK+xqWohPaXz4xc07hUZISlviQi/Gk4JgbIKlRyZSH4rIadr9apm
         ffvfcEMbT5Cj0Si0vQzOGVRf9Om1QjaPya0IzJVuZzml2z0oxXskvmxP+ZCq6fjDOgB7
         l6FOi65FjEmBA1xU9nI9Hhy7sTH5AWFSmFC9Cii1j3utZ8MmV0kCKcsUZ4c3vDu0F3Mk
         ibyfvrPomivW/SxQTD/YXNmPErrfgwzGI+kE3RX3d8tA6cs7GXlSuK6VSXRUkBBYiHQ2
         l3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        fh=PvOQA234PUuXVdgttOpcUqcDxPT86A3502FCgPbaVUU=;
        b=aZWJC7xWoreN9YYUzL49NPy8Xaa1kaGy2Eq0IgDEj9wx7hq9bpc5N/N/923ueOjPRQ
         ucw+cuGcyzr0AehWKX99XfSQOsxff9looWXDs2CTJMMh7BuVo2V/83xQ9prh1PkINEvh
         784h/PFFMZS2EXYHAEksk+yqA0S6G2hfLCuL9yBILPFOJ0bz6e2kQ7TOCGN6aNt+k7Gg
         jpyzLEEm9PqiPT3Due1fJhCg5RKWNBoFvI9HCDSjsGPpxNr7GAxVDTVi0L8Th1o9ZYx3
         rcnhRP+E3/EQxOHl6le+L48ujC3dPMP6GuLG6rTEmx/tMtE+h94hvLTsKzKL/lOK4YoE
         3YiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776958417; x=1777563217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        b=C2YqI+iE/9eCZWxVvfn2gqQDKT69c8kRNj0qjlG2xzRFkm1Hw6F5xyjHi0TQ7/oYEF
         iznx12vSxS8TokclsXa4zctANFC+5PGpm1xVpfERqRP2EvxyKuTB3IK5s2ZUw1ETLaef
         xxcUhyI/e1wEWTnkJB8RlN/Zug4ypm/8W6+2XDhQtIVMK7ilYxNQnxw3DdngZTy6S6SZ
         ZfcgGm9uY2e8RwNLHA/+k0Pvs5pVQDcp3MXaaoIbe1LLJVd+IJHYVnrJWACAYRqtv449
         iF22un5Jb9Ln+Nq9NWE0jhkJfcVvFaLAwgJoR92nUuUAN6mx/2dvWZL8nU0IZevDnXvN
         dJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776958417; x=1777563217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        b=e5kl6gg1PD5mA7+jNEMLVSWsKCgigIIuvkOjvuP5qCToyCAkGMb2dPRKOU0FAkcYmr
         HPsigv2mUuPH0/RDFfmtKsQPkQo7XXC73uga5+0kEXRZBaUxwe9TwgaelO9g7PBqjqbq
         d/NrZmAP2TP28qBzXfhBU4284ttFOPncVawLti5Tz6hUHr8DodQLHtLfL7qme8TcR5mX
         rDQO+Hf1owY9cd1UFpK/HRAaTQ9+tFXMYhZwOzQ+ErldgNLPN2qa5bCCMj8xkTGUNSPd
         7Y1I3CawbVIAlPqx51d+jAy8IFcBb0RIRbpx2y+NmIpgS7+25CJubz4lOxU5VxCETUmX
         OziQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mABXllxXdKAbgeKcgSIXCMMB7pL6B19/wWRRt+OvsUxNUyV5g8XfMWEemuCsBmjgej1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+VZfs3j28KSCpuSHFYIykrD4nUTtUidWPhZK+bvJN6Fsz7KG
	jILM/EwQi70ysIdu03CirWKEmjMLDSsOr1gpqCd2l5H8UOZH0GpGn7lpy6lvM8SAKucTG4yjVgx
	mA9ekHAn0UDoGbZL+M1Vfd6PJ6vtEVlYH/gwX/TTd
X-Gm-Gg: AeBDiesitvUYFnQEc/5yDfkBesWhOFyANlDDTGaonSpu+IpwNwSJrNRyS4yQVNigK02
	yfzwS3C2TibgYK0xQpB88i99IJbDD70zAL1GXLnH4eghclnKfr9TSlzE2MwHbzGGc7ApmInu4ID
	EdSzatLUeuiMZ7rzoR0DdF+Ks9Z/C4DJmfpGreg5OWDrKhautHPTHgvnEggTZTjOzl+LvkfV4Rh
	r122ldb8CihYj6iLP6DUhOa/O0CWZlsLBQZTbyX0VtdWbAzpKIBuN5+hAZH/Fp5uXkqKbBV9oNN
	bh2zJc9Nlio+zsyM8QZMu2qiOpwu
X-Received: by 2002:a05:6402:a508:20b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-674404eed43mr13659a12.4.1776958417009; Thu, 23 Apr 2026
 08:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Apr 2026 08:33:24 -0700
X-Gm-Features: AQROBzBBAoDsVusSh2h9V7H_f9OZ2OCtaBU8k1DNE-tepDqCsp5oI6tFTHWCYBg
Message-ID: <CALMp9eQW+Y5i4D71HCAmnPywQs+hFhaB_9wR=BbZ5bg=XCNkFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> ...
>  - Dropping PEBS_ENABLED from the lists save three MSR writes, not two, a=
s
>    KVM performs an explicit WRMSR prior to VM-Entry to guarantee PEBS is
>    quiesced.

Is the wrmsrq(MSR_IA32_PEBS_ENABLED, 0) in add_atomic_switch_msr()
necessary when the CPU has PEBS isolation?
