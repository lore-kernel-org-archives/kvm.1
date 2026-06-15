Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411A406837
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544392; cv=none; b=SHyzwlC5JiRVTZO0mAQsiJsuAcNderPVrlCoRnJbIZUY+g0TdATVhCc9S+Nam5Zf1PNiZB2FTYn8sJvkLPoHRQGcCUxXUKhPXxiLZlx6WJrNgywpnREB6pXYz5vP2E20Ww/42SC7IsUrvo1g/aNdSTCJhg5EVgucDTWfqy6YYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544392; c=relaxed/simple;
	bh=n7j2xuSEoLWXT4WWaLtAQaJv1XDcEbEbTdrNUD+gpXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8aV9mtuHZ0Gps/ehlWg3025rK+X00RcNScwYCw+Y0DJ3JI8vCMHv2hbC5IZ4OdmAWBGYEeY/6FcYCWW14ToHvHZ/1WOshBFwQ8R08hfQcl3mc+QAw3BrDfcmbFPTLnbhKkvDH7KdTXPqufXWz678usRBH6GhO/pSnYSxnjb66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fAgpimPv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAgpimPv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2befec3fd8fso24968125ad.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781544390; x=1782149190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1YFLp6Nv/x/zFzqR11/t+OBKepAibObBP++vs6jo78=;
        b=fAgpimPvKW5ZSsE741mxtnDJeRj6HVhF44Z8641O1lmWpHCcTyZbOQpPhRlc0rwjJy
         4tgcNDueXd0+ZhD69oyh32LIlgkwPVxaClUMS42/k1AYfqPi4/UA6xBMyT3iJzKHLt/F
         ed8iJf0K7LfESMqSK4mtELaWC6AnV1gtjUWKmdzniIpU4uDDugb/d3sxtpIk/eMO/U2R
         oGvUjeBHnvn+DFzWcv69saDXLNxffy3oxn/pKVl01wjGrAfm+272CSxdTMd4KdQLpggk
         1YKqDiPqNW5EQg15r13oX67XNf1rctW/XVP1F9i5eKbfKNGZ+XFGotGyXdoidi887XmT
         Nc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544390; x=1782149190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1YFLp6Nv/x/zFzqR11/t+OBKepAibObBP++vs6jo78=;
        b=hgCVlP0fSTSOVw9ieP+fzP1A/cFDcA1I+oONrX56Ek3tDk43CLEpv4Ah+h2s6Eo/qi
         yKLRq5Lml6a8zf7YL6mWD2BDF0MvQVRtnOQyNGDK5OzQd3C9xF625PTMrxpmt3cuwKxj
         GCu+PAXBYwUpegZBBfn/dShob98jtv7M6NBfhNhvtxq9aJUc/rvXZhAm626XJOVSDyY0
         cAsxltacOltbLaFZN7FgEHxVkCaOKO3t+O8tTy6ItjGRvwdCgBDqPHgIQMXrNlXHZrpp
         aQq7dz6rIEkOWu5AdbJSK7haSOJWZLW2rNph3/EfivLUQZEoh6WTZscrsqIahGlStO25
         CArw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZczJSdeau0LiYwDPjYNlCfPDADfSMID3NzOWRAk+5elZqtjInOf26cv9+1pl2HcTqF3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsdbLw6tckR7BtLYXfdIwU7+Yhhd/Btb5FVvGZXsTK6HsyQxzn
	c5NcQaDb+1Uyi1mS+d3VwE9RLxTm5PFSwtyNjVKJnE/Zcgxqns8kLUzc/NPljk5Jvh+EnZAhpmU
	KdCC6og==
X-Received: from plbv4.prod.google.com ([2002:a17:903:44c4:b0:2bd:9574:2958])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:2c2:cf20:213
 with SMTP id d9443c01a7336-2c69a1b55d7mr1652265ad.29.1781544390381; Mon, 15
 Jun 2026 10:26:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:26:29 -0700
In-Reply-To: <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
Message-ID: <ajA1xaafH-IkuugD@google.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> On Fri, Jun 12, 2026 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > When querying whether or not interrupts (IRQs) are allowed, check for a
> > pending nested run _after_ checking whether or not interrupts are block=
ed.
> > If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs ca=
n
> > be blocked while running L2, and interrupts will indeed be blocked once=
 the
> > nested VM-Enter to L2 is completed, then KVM should treat interrupts as=
 not
> > being allowed.
> >
> > For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
> > immediately request an IRQ window, instead of forcing an exit and _then=
_
> > requesting an IRQ window (because after the forced exit, KVM will see t=
hat
> > interrupts are blocked).
> >
> > For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() =
is
> > affected in practice.  kvm_vcpu_has_events() is unreachable when a nest=
ed
> > run is pending, as KVM clears nested_run_pending prior to calling
> > kvm_emulate_halt_noskip() when putting L2 into HLT via GUEST_ACTIVITY_H=
LT,
> > and SVM has no equivalent to GUEST_ACTIVITY_STATE.  I.e. the vCPU will
> > always be runnable if a nested run is pending, and thus
> > kvm_arch_vcpu_runnable() =3D> kvm_vcpu_has_events() is effectively dead=
 code,
> > as is __kvm_emulate_halt() =3D> kvm_vcpu_has_events().  Oh, and TDX doe=
sn't
> > support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
> > KVM shouldn't be faulting in memory with a pending nested VM-Enter.
> >
> > As for kvm_vcpu_ready_for_interrupt_injection(), incorrectly treating
> > interrupts as being allowed could result in KVM prematurely exiting to
> > userspace to accept an ExtINT.
>=20
> "incorrectly treating interrupts as being allowed" is the status quo,
> that this patch fixes, not sth this patch introduces -- right?

Right.

> The changelog reads like for the non-injection case this change might
> not be the right thing to do, but I don't think this is the case? I
> assume returning false from
> kvm_vcpu_ready_for_interrupt_injection() and kvm_vcpu_has_events() if
> L1's interrupts are blocked while L2 is running is the right thing to
> do?

Yes.

> The code makes sense to me but I am trying to make sense of the changelog=
.

What part (parts?) is confusing?  Honest question.  I'm trying to reword th=
e
changelog to make it "better", but I'm failing miserable because I don't kn=
ow
what's wrong :-)
