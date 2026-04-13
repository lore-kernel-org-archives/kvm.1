Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71E30EF6C
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116863; cv=none; b=nZb3VozB8HphNg1IOSc7q4usWqK1N+/at1UCVjL7L6c4OrMNdODEb05KCeRJdh9exaVP4ZoeNy8Hy0shAqLrMO4nO1cIXgb73QvsIJo62AiY1IPmVUmaTrQ5coj2HXe+vNpc/rVCbvYzJKHyGl08DLnU6Zj8ABtp7dCsCX4WnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116863; c=relaxed/simple;
	bh=QFBLipJBD1mCwyarRQQuYJO5ydTQZvjQGJfGD3jwHMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9miukKrFdIHhPdSTwORzaL215sGXpG2Hs0J6Jh32KIiKU9t/Ou0qUykC6uZXoPcgizUrcCCiw8BQSYDXywJfcd/KD0YaJmF7rNhrSlQA6iD7p3CDHJIBp3kZu5HX1xMT4CQ/PSnPU/hjmlyKMlbARwUkeJu3NvdtMNqO9LCOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=We5Jalmh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="We5Jalmh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so2589619a12.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776116862; x=1776721662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOJ5PcXaosBjkJlC5TNA2PBM0qQ/G9MenxmSa61uIao=;
        b=We5JalmhxitEIhdqz3VleBjCnJ6JNVxPKBDmikfmuPeiz5boTrYbA3VeDXAAShscbP
         u67ApwCm/NQ4dCLVUE9hgylltISeEIB7OO93R4ry40JB66PyD9XRt3L7OWdfa+eAemjO
         BFvHiUKpaNGH17eSdFK4cGJSLQGolvJB8wrfEbZElCcSvpaMmPJBV5Qf7jNdAFsyemkG
         sDAcy9VbhB+HFtkD6GPG6aa0EMTWD5o41PhGGsxqnKxfupn34VwrmJCsWK5zL0c3kDj9
         KkFcJ2uYaqb7JCc5HBot7LSQSrnbz+TVyAPCf0U+JyjT4Q8rjEm/49Q6V5dWHPS/necs
         shpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116862; x=1776721662;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mOJ5PcXaosBjkJlC5TNA2PBM0qQ/G9MenxmSa61uIao=;
        b=Suj4OeK3lLyY5DMjlbZjTVZfVnVRvn7dNeLbW1s5KIpDsOaDEzYYwvBRCxOSYHzueQ
         mqldw3XLAwEclIROHA9NRdvI8aNFe7Ndcvy1ugfcq+w9mDkQdgyoh7vDe2ygQZorcH49
         8YVEhVR8JL6N8fglu5ITOMb48VbVX11CSzXGT+pJd+oCY1ImJAMN5euJVeddBPrcpOb7
         RzMbMW65sFX76qqFi0fPJd7iMuCKZ2zOzS9faqpL/arq+k9mWjv3K06LXuLMEwUfN3er
         sWcfaCIDd2/aKo9hj+DbjaDcjRbCMobRG6D0WA8gcyLyjE67E9xQIzQZWqXFAduOB4hr
         f+Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/fXGL2i9fubQ2ZHici5Savo/mPUO/BHf6uvG/AQfYKsy4e+PexJEMpcyZC2+KVqxjpseM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC9XlBYkKI3saL7hApsTcED8M6wQW9fX0VTWm3/ezZvGjpBSD
	ceyGSsU6v6bHmjBlbTC9QYkU+6fNrcGDJsi6Vjpgb9dliVe0Zw3OsTv9CWmGnxQdQKjHPtoYB4i
	qetd7bw==
X-Received: from pfbhg18.prod.google.com ([2002:a05:6a00:8612:b0:82a:5f0d:ae9d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1913:b0:82c:6f07:299f
 with SMTP id d2e1a72fcca58-82f0c272fb0mr15080160b3a.14.1776116861529; Mon, 13
 Apr 2026 14:47:41 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:47:39 -0700
In-Reply-To: <20260408184332.187482-1-ohyunwoods663@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202604081633.sean.christopherson@intel.com> <20260408184332.187482-1-ohyunwoods663@gmail.com>
Message-ID: <ad1ke3Yh0g0ko2u8@google.com>
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under
 memory pressure
From: Sean Christopherson <seanjc@google.com>
To: punixcorn <ohyunwoods663@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026, punixcorn wrote:
> To be honest, it could be days. The original crash happened only once=20
> in a month of heavy use,=20

Oof.  Can you provide the full splat from the original crash?  I want to lo=
ok
at the register state to see if there are any clues.

> though my system has been hitting 100% RAM usage frequently.=20
>=20
> I suspect a specific transition-like a guest memory zap during high=20
> host contention-is the trigger.=20

It's counter-intuitive, but that's actually not very likely to manifest as =
this
type of failure.  When zapping SPTEs in response to reclaim, KVM only zaps =
leaf
SPTEs.  This specifically requires zapping and freeing a non-leaf, upper-le=
vel
SPTE.  Reclaim could still definitely be contributing to whatever is going =
wrong,
but I don't think it would directly trigger this type of failure.

> I am currently trying to reproduce this by scripting a loop that reloads =
the
> guest project (Android emulator) while the host is under heavy memory loa=
d,
> as that was the environment when the crash occurred.
>=20
> I=E2=80=99ll keep the current debug patch running. If I can't catch it wi=
thin=20
> the next 48 hours, I=E2=80=99d be very interested in that more elaborate=
=20
> debug patch you mentioned to help track the SPTE lifecycle more=20
> closely.

Honestly, until you're able to reproduce the failure, I wouldn't bother try=
ing
to concoct and run a debug patch.  Given how much this particular code gets
exercised, if you only ever see the one crash, something like a single bit =
flip,
e.g. due to radiation, is probably just as likely as a kernel bug.
