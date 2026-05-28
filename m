Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2263672A5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010678; cv=none; b=SG5rZUqwlaCn9aq9bAaXKqSF5+xj8CGp6szxPp3bR5zbfIcZPVMiiIAk4GjqceRZDpZmNDIs1gcU5pREasYxnwZn5yue89Lvf37e4XWi8oRBSTscpfFqmJMSDD4TNWEcQxitt2Vj25GVQiDh/8CVusRKurWP5/fwtSEfjXz9qgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010678; c=relaxed/simple;
	bh=TWqZwy/3Jey7/CGM5VfOqYkKRZCqkP+zivV/dXxJyNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZn5NnD13jE9sFpt9UpAKXnlvfAzEKMuIrba38KXYuDc+N6ZJpI3nyTI58eDB56+rM6Ajs8Fu8F8HgVjFcDz3lj+kItr6NL873LH61p88G20Gaq06vFdulYdQJONQb3gogbzZD4bcGvkYqA37A48sG27N6exjlPGp3TMi0nDHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQxej3Jg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQxej3Jg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85759a8f33so45813a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780010677; x=1780615477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0m+heJGDubzLIP1KpTWwY3lrbALj6Yalx0MFIfyuaE=;
        b=cQxej3JgC3oPvoN7OWqVlAh3Kc9OKyKFIzfLg+JVeHZZHjyRaW3MNH0bT99VfIqzfW
         c+gruuuMqJVtHdfrzPuwrVlANWmlJ4akB8mvh9KgWAUaxbqhNfUS66nbeWXJgr1sdKns
         uqfPDgDPRVmppneZh/X/EtfqUphyh293eQHNbuILBqgYjZiocQ/euTbTWWHvoCjI2DWf
         vNIeGVixvqgFNIpqsPxlyHqwrx90wtJorUuehvbIU8FYzJQq2E91oB9oIr1uCdZLIjl4
         l4GyUQFVyIjbNUr6MdUh1UhH9QmiptSFXzOJsLqi+gURM9gQ3Bt//VszktQHUmpFjpH4
         AFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780010677; x=1780615477;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d0m+heJGDubzLIP1KpTWwY3lrbALj6Yalx0MFIfyuaE=;
        b=NXDLkx7LnQHgoU7xZKzZgjP56T/yoVyJOHFIiekxRnHMa9iJ99/UvP156ioFj7ZgyA
         YsRxyccoMYljyciL0hpZqWUS/NKzjSHL63TvUhlyNOojdzcrCCrUTX2NpEUdLlGHm8RS
         8/yS58gfgmzmL0VuET8ZENMeDnE1YnG72nVeGshwtVqLoHNEFESePNKETE/1U5OJj0aY
         UVxwkuCuzOeiVbMxBDly5wIQe47sWs53JsbVU9WwzciddFaqTPLrLjk0jMuQ5FQdHME7
         1SQmiavHhID9qcBjXF/f0koQQCRXpu/ntLJgjMJ7AYqoNR8kTDTbgqZFHFAZdz5YfM02
         R+1g==
X-Forwarded-Encrypted: i=1; AFNElJ+FP+LPQVnUESH8FBrK8TKrUdanB4PeCPhzZoAspWrnvdKK1TkjWVL1mnGdOSXfohmMs/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmyvkP08o0fyIRc+Jz6Xj//iK7uHhrvbj02JInrh1k2faNA67
	a1j3QQAnXDR51RG0K8bOYXg5ruhVffadG7MndzvKdMhH3JdLbahgNIm/SzoorKu8pvYkgsIjZOV
	chDLdIg==
X-Received: from pgcv28.prod.google.com ([2002:a05:6a02:531c:b0:c85:10c0:3c90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9e11:b0:3a3:128f:1c77
 with SMTP id adf61e73a8af0-3b4101adbc2mr402443637.12.1780010676885; Thu, 28
 May 2026 16:24:36 -0700 (PDT)
Date: Thu, 28 May 2026 23:24:36 +0000
In-Reply-To: <CAAdrzjuUEX=p0uX6mavaNv318AkgNG29263JPtXJGqjnmfxrfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-14-jrhilke@google.com>
 <ahZVi0njg6j38Q2f@google.com> <CAAdrzjuUEX=p0uX6mavaNv318AkgNG29263JPtXJGqjnmfxrfg@mail.gmail.com>
Message-ID: <ahjOtF4c16hVkN36@google.com>
Subject: Re: [PATCH v3 13/16] KVM: selftests: Verify vCPU migration during IRQ delivery
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Josh Hilke wrote:
> On Tue, May 26, 2026 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 21, 2026, Josh Hilke wrote:
> > > +static inline int gettid(void)
> >
> > gettid() already exists in at least some of my environments:
>=20
> Should we just use syscall(__NR_gettid) to avoid any compatibility
> issues? It's only used once in the test.

Hmm, maybe open code it in kvm_gettid()?  And use it straightaway in
tools/testing/selftests/kvm/demand_paging_test.c.

I'm a-ok open coding the syscall() somewhere, but I don't want to end up in=
 a
state where we're open coding it "everywhere".

Oh, nice, "This call is always successful.".  All the more reason to open c=
ode
it as kvm_gettid(), as the kvm_ prefix communicates that the function guara=
ntees
success (or fails the test), it just so happens that we don't need to do an=
ything
to guarantee success.  E.g.

static inline pid_t kvm_gettid(void)
{
	/* Per kernel documentation, gettid "is always successful". */
	return syscall(__NR_gettid);
}
