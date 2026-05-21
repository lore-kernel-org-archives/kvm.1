Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0EE3905F5
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388945; cv=none; b=vCrLSOUA4DfkISZHBdQ5WHB4v7tJcHJoF0UX9EQQr4dRthObWI08dSZHU9lLHWfFdgVVr+6K+KLlnrjA6rZh092acRCRNy2fz0bEePQeYmBoOhxFGg2/msY2nwrIkAFsRtZEykVyMdn2kvZvikLVEFoJe3vrPAChYNz08mpoDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388945; c=relaxed/simple;
	bh=H5kTFXO8HYWZJ9EtsC69gWCFS44YDsRQS0Og9hiXVFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDpgoFFOPjMI2vCac6YHBX+m2dpqXjPzAj43bFmoxDMaB/zIVVAdFFyRt0NE9Z7Axn0Lo1zz+WHz91QlIL5DbTJpoG6hwJPUp9zzC4fGfcuf3D3tQp4o44AxMGTcc1TYqDW6V/auNytOFpwpEDsOH3rJJffM/IS9fnMNGXMkMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKHdyv5Q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKHdyv5Q"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso10054865a12.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779388943; x=1779993743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uytZg2IyX0mr+LxoX6v+Kf2d2mR226egtScmZe38spQ=;
        b=cKHdyv5Qft8m9wBIP52lctRE60BsxvfzwDhBxZw+dnxX81RFIUvtzq5JgpbAImjzVB
         jR1RrENzpfZZMD6KBwm55TdpE86dbVMr/uIPQVFwOeEyf9XfdQLpreTIVFn5F9SAHLAX
         ZD+Ph5q72dh3C8bqLWel+VW3cL3M/xfXDl21ogeZmXXTD3y0C9cfZMHyt8UuAaFZxCeC
         bn/PvkmGNmWWA6rpl/vkvv+48fTmN8dFBnu74shbaAuHESU/HwitY8HbfDdwosc7DC0k
         bOiXu4Vp4VcyZXsxE9cjXciMAFr0SgXM2AwUYLFEqWvu+8QJcpAxr0ezE5CbhMn1v2sk
         xmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779388943; x=1779993743;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uytZg2IyX0mr+LxoX6v+Kf2d2mR226egtScmZe38spQ=;
        b=XwYaLUi6pPVgOIm36mqTOu6J61qmoZmRpslkeaqT9RSv3qFU7JI6BzNMX66dmqmun3
         FZkE6iqxmB0stUojZJ0lDHKzpcEnkBzTYGiiK76iq0SpOjZ+6NakO5unoiXlKMDyNv52
         EhWSeTRlJBDLVaM91Q1fuqIorpn/nCInLX/918fEtmxwDED7E3V+gee5JuB4SxQhPVFV
         98NXyIWa0dA3burwsgKqJLolM8x+dNbOLXc9lGxSJlx+lZgg8TfSBJPVG9ZODxT0RcoB
         bv5O7CcdE/x3sMCXKzxkyFp1WSY2lvofXY0LTy4CV/MXgxJrOFzRPdb9IMTO5lk4i5by
         C9qw==
X-Forwarded-Encrypted: i=1; AFNElJ9yZYAcodVjISwQX1sMWM873sXTQYFEOJNSFEnurUazzobOWkiQG5uLTsSWLyCAMpkz0RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1GkFRFBODFmdDkH6Y2lXmKmyYaSthLMQGcyNOjF8dsBJMfFB
	43rYnTX4cmvIUh+bMa2grr7CxHIM8WS/Kt7OoYMjECIvODLt+DUPYEE1k2wLZJq5KpZxGJ+5T1V
	ViSdyxw==
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:c82:7df9:8c21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f89:b0:3b2:b1ed:d1df
 with SMTP id adf61e73a8af0-3b328eb677emr172133637.29.1779388943316; Thu, 21
 May 2026 11:42:23 -0700 (PDT)
Date: Thu, 21 May 2026 11:42:22 -0700
In-Reply-To: <CAO9r8zNW+dwWykUsALO-BKTg_dX8rT8cFBCR+Y9z2NjXoGJGtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <20260514210500.1626871-4-seanjc@google.com>
 <CAO9r8zNW+dwWykUsALO-BKTg_dX8rT8cFBCR+Y9z2NjXoGJGtA@mail.gmail.com>
Message-ID: <ag9SDjTdeXEszAsk@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 03/20] x86/svm: Sort (and swap) GPRs by
 their index, not alphabetically
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, Yosry Ahmed wrote:
> On Thu, May 14, 2026 at 2:05=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Sort all GPRs in the nested SVM infrastructure by their index, not
> > alphabetically.  This will allow sharing code between SVM and VMX for
> > context switching GPRs between guest and host.
>=20
> Potentially a naive question, why do we sort them by index if the xchg
> instructions just use the offset for each register anyway?

So that the offset into the "array", ignoring that this particular implemen=
tation
doesn't use an array, can be computed from the architectural index of the r=
egister.

Does it matter _here_?  Probably not, because there's not actually an array=
 (yet?).
But my goodness is it confusing to look at KVM's vcpu->arch.regs[] and then=
 switch
to selftests or KUT and stare at a set of GPRs that don't align with their =
index.

And code mechanics aside, sorting RAX, RBX, RCX, and RDX alphabetically mak=
es me
foam at the mouth :-)

> I ask because I have a patch [*] undoing this for selftests (and
> removing the 'rsp' spot), so I think I am missing something.
>=20
> [*] https://lore.kernel.org/kvm/20260518202514.2037078-2-yosry@kernel.org=
/
>=20
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  x86/svm.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/x86/svm.h b/x86/svm.h
> > index 385c1289..d9f7c731 100644
> > --- a/x86/svm.h
> > +++ b/x86/svm.h
> > @@ -392,9 +392,9 @@ struct svm_test {
> >
> >  struct regs {
> >         u64 rax;
> > -       u64 rbx;
> >         u64 rcx;
> >         u64 rdx;
> > +       u64 rbx;
> >         u64 cr2;
> >         u64 rbp;
> >         u64 rsi;
> > @@ -457,9 +457,9 @@ static inline void clgi(void)
> >
> >
> >  #define SAVE_GPR_C                              \
> > -        "xchg %%rbx, regs+0x8\n\t"              \
> > -        "xchg %%rcx, regs+0x10\n\t"             \
> > -        "xchg %%rdx, regs+0x18\n\t"             \
> > +        "xchg %%rcx, regs+0x8\n\t"              \
> > +        "xchg %%rdx, regs+0x10\n\t"             \
> > +        "xchg %%rbx, regs+0x18\n\t"             \
> >          "xchg %%rbp, regs+0x28\n\t"             \
> >          "xchg %%rsi, regs+0x30\n\t"             \
> >          "xchg %%rdi, regs+0x38\n\t"             \
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
> >
