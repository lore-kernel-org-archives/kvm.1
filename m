Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4446D2DD
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651248; cv=none; b=W96zWYUaVEnEszEkSwv2yR3Nvp6MGUxXp4UEM0ZdZd9VQTje1zqP3INP8LBMLEuL3XuW94JPGrQs9IzvQvVhHhLU3o5Oa+hglqP3V0HMBgrxn768Oo1ztzjZkBz3Bm73L2YCf5diB3mK+bl+cPQBpLtLHBkUX/joHDFViHpmq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651248; c=relaxed/simple;
	bh=OriPdBhOp4I8NSaUQ1ilqiW02cNYD+mMRedsfTxi01Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EMpHBIHGNGgnXEbhClZo57HZRUSqbBau7brsXxWXmVC1qzVAg34wIJC9f1KxZbTmC5/eYmnBzd6sWsF2WLGLetk4S1C2l1SPj0BhP/jRGFJ7L5ZnSQzfz5cVW0xGyeGQotGoZWaMNyXVFU/Ap5yqXHPwqGrxdIsFlfWGWR/OrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGw+Th1m; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGw+Th1m"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so12494241a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651246; x=1785256046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rOtJSmkWSx9WAA3VgSUe2HFHil8cbgDYatSRRMP5Rgw=;
        b=YGw+Th1mYEL9gHcFT3NKbMoLVjNKu3rpabOwWt8vnad2eeLFH5vSQWI5PEtjjwvJdO
         CopsMwYJ3kc4LvCO6KfEoYzYSltLkJ38Vwplp6QvfbEKoRjHxhMVj93OKOQFswEVgUmS
         boGv9KcmjwOjLEqSR8Tw6eeRVny5T4LyBbpIUlR9OYNdfxYjV17ICUWKVk7YCV5/8ZTJ
         +7fz8QupxEj9upYdK2LMNEbbKY/EVrDT6vTSBDXBZw2BEXIhQqQ7yoFLCTs7u32NqPlM
         rb0Kuz4fZN68hz19bePJeHWcdiy+4OEwdR4dH3ETTAFKzjrxs+pTZR1ln47hD4CaA8jT
         ioHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651246; x=1785256046;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOtJSmkWSx9WAA3VgSUe2HFHil8cbgDYatSRRMP5Rgw=;
        b=OdYpsMtnef6uHh/GjNOjlFFxaQDjy8T3mqxKtHqZhvh/U0HXaBNn93tlROz6/jBWDO
         abAy1NDEzmSWeWZlioYSHFxDGw3cFEoBwuN6hblt87j8EFXfiwWKqWqymq/tg8h4FkeT
         /K929dSKtF/fwor7ZXUn2jxReOBDQdDc7XanG+UwVKdDEUyPQPNzPIqjMHHiXdtHX+uX
         u59S6W7PRVW6VLkHcmfiZanMbzbNLHlLEg/EbmfGqUuKGOrPcTL4ywG6RLFYOkNXhIAa
         0MRH7XBV4+jYW2UcrH/i7gvDKgsYeWx3WFFvQrEJBcZJ59BgWysk/otCkhtlDfV+0Zlt
         Krvw==
X-Forwarded-Encrypted: i=1; AHgh+Rq00k74PMzgwt0edG+Y8fJL5Oee7FmDhjea3JJXOJT2I5tz8Bye4sQ6CUEClWJtIEkNQcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAepYLWMc1if1aXU/YZGbNKHneoOQuqD1WjII4kPvYEz61M9B
	ZkB6A9z0U3G0DsC8d7vO2+d7O9tbY8kptjsn4fenJ9zGjKxyHgoZQaSJybbQKSsidLjhbq/8sT3
	xQi6h4w==
X-Received: from pgmu30.prod.google.com ([2002:a63:235e:0:b0:c99:a30a:7619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:391:b0:3c3:890f:6d7e
 with SMTP id adf61e73a8af0-3c3ad8ecd35mr23113643637.47.1784651246131; Tue, 21
 Jul 2026 09:27:26 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:27:25 -0700
In-Reply-To: <CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721102827.313208-1-pbonzini@redhat.com> <20260721104819.B5A101F00A3E@smtp.kernel.org>
 <al-PSX0sOPdYdvIg@google.com> <CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com>
Message-ID: <al-d7WPocYgEtgFU@google.com>
Subject: Re: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026, Paolo Bonzini wrote:
> On Tue, Jul 21, 2026 at 5:25=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > FWIW, I had a pretty strong preference for Paolo's off-list suggestion =
of
> > explicitly disabling preemption, even before seeing Sashiko's response.=
  Every
> > other path the VMCLEARs the shadow VMCS runs with preemption disabled, =
IMO it's
> > more intuitive to follow suit here.  And even with the comment, it took=
 a good
> > 5-10 minutes of staring to understand what exactly is going wrong, thou=
gh that's
> > probably a me problem.
>=20
> Well, it would be at least an us problem---but I thought I was in the
> minority... The only (IMO bad) reason to leave preemption enabled is
> to obscure the change, but that's a lost battle anyway these days so
> why bother.
>=20
> That said, I am surprised that VMCLEAR/VMREAD/VMWRITE/VMPTRLD do not
> have a memory clobber, since they access internal processor registers
> and the compiler may reorder them without the clobber. Fixing that
> would also work around Sashiko's complaint, so I guess we should do it
> anyway?=20

Ya, good point.  We should probably hardcode that into vmx_asm1() and vmx_a=
sm2()?
INVVPID and INVEPT also need the "memory" clobber, no?

> And disabling preemption can be done separately on top of this change, wh=
ich
> is already on its way to Linus.

+1
