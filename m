Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD13AB28F
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253740; cv=none; b=IqiNvSSHc0cbPUJZrF5LeMvPMgy/tSdAxP37jt/kwjN2qOX1KWO0qA3x/iYeLBbpwhJbYrrUiy8v/M/Q5fnTIFF/okzYpuXDykChGNFqJ2NrV/qJzLWi45byGsJcqGrCwzc0ligKzpRz/dPPjdN58aQowVLg+FuJPrtGg/iT6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253740; c=relaxed/simple;
	bh=xsiCU7v0IpCkf9af4J1aKRS8XvbhsoJbkluse8uHEs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/VJz4Zkq4+GaCMfrX3W5w3FHABpPkqt1Kn0XjS74Dox1IqGrfHc8Ub0tsMOzZLsY7mb4Ja6bBZNjl4QEM7DAetHgREwl8PjRkqy6NJnWb69Rg507+ex3XQ1N55iwf9kbZzSISq1NhTzE42ZeGEw1gpJ0KPaaaQBPUSYl1jJUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNiRSiPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNiRSiPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F52C19425
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253740;
	bh=xsiCU7v0IpCkf9af4J1aKRS8XvbhsoJbkluse8uHEs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nNiRSiPSdWOC0NhvxMi4uQI8F53okQFPRvatrhilDH/JF6J8JXKpvM/Pp3aLe9QAe
	 BgBu+kcHvqQqVLVq8fuiyiKV1cJtGH5r+YpGkulfdcUmPauZvBXz84KZ0P3z6Sg9lF
	 5NpY+iHFUViXiFXSjKrxKRb7FRQJ+0V1EVpKOJtnwRXlawnqv6uj/Kd59r6ZssgwKf
	 XhTzkRmCry26hbUdS9hE3B7iL+CkwWJQPiMrAxfXhMPPKcrm2FmGHU/Qgzog8qz5TA
	 IagQGllrbm/7Bmh9QfA/LMoPH03z8w1wrQX+RkoL3C8+IWkh4jtFztRwPfs0mMlY2X
	 PSEO4W1EQNpSA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b955351e0a6so19322466b.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 11:29:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq+q/c8DCimlA9nk0qBOX87+w+TzZEKgG07RhFGbVhtl+eQ1OZtIM3REXGgFcu/yYxWTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4woGYu6s4Vt7zD7kGRPwipgTZbJH5aFyniiRXHo4RZuK7jNdC
	oXuE7yb6mpiGL/8mfC8VezNXKQz1Sl25R8s3AK/xFArMun9dzTr0nJIg5s6O6nC1T490l6HJ1Au
	2BF+x4xzs7/mU7AJTy8ZTpqEmWG5OdBM=
X-Received: by 2002:a17:907:3dab:b0:b97:1db4:e5a2 with SMTP id
 a640c23a62f3a-b972e4e9055mr245196066b.39.1773253739172; Wed, 11 Mar 2026
 11:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <20260311003346.2626238-5-seanjc@google.com>
 <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com> <abFulxXuRziXj039@google.com>
In-Reply-To: <abFulxXuRziXj039@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 11:28:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNUCk+e-EMTtvPs7D4xzbbx8u=B1e8dyiU3aprQeW9yAw@mail.gmail.com>
X-Gm-Features: AaiRm51sqA-5WcloaZQ3zuxEhTxKq8DIjSIeYXs866YOdWlqxl9eFYy3--LVY-Q
Message-ID: <CAO9r8zNUCk+e-EMTtvPs7D4xzbbx8u=B1e8dyiU3aprQeW9yAw@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: x86: Add wrapper APIs to reset dirty/available
 register masks
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:31=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > On Tue, Mar 10, 2026 at 5:34=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Add wrappers for setting regs_{avail,dirty} in anticipation of turnin=
g the
> > > fields into proper bitmaps, at which point direct writes won't work s=
o
> > > well.
> > >
> > > Deliberately leave the initialization in kvm_arch_vcpu_create() as-is=
,
> > > because the regs_avail logic in particular is special in that it's th=
e one
> > > and only place where KVM marks eagerly synchronized registers as avai=
lable.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/kvm_cache_regs.h | 19 +++++++++++++++++++
> > >  arch/x86/kvm/svm/svm.c        |  4 ++--
> > >  arch/x86/kvm/vmx/nested.c     |  4 ++--
> > >  arch/x86/kvm/vmx/tdx.c        |  2 +-
> > >  arch/x86/kvm/vmx/vmx.c        |  4 ++--
> > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_r=
egs.h
> > > index ac1f9867a234..94e31cf38cb8 100644
> > > --- a/arch/x86/kvm/kvm_cache_regs.h
> > > +++ b/arch/x86/kvm/kvm_cache_regs.h
> > > @@ -105,6 +105,25 @@ static __always_inline bool kvm_register_test_an=
d_mark_available(struct kvm_vcpu
> > >         return arch___test_and_set_bit(reg, (unsigned long *)&vcpu->a=
rch.regs_avail);
> > >  }
> > >
> > > +static __always_inline void kvm_reset_available_registers(struct kvm=
_vcpu *vcpu,
> > > +                                                         u32 availab=
le_mask)
> >
> > Not closely following this series and don't know this code well, but
> > this API is very confusing for me tbh. Especially in comparison with
> > kvm_reset_dirty_registers().
> >
> > Maybe rename this to kvm_clear_available_registers(), and pass in a
> > "clear_mask", then reverse the polarity:
> >
> > vcpu->arch.regs_avail &=3D ~clear_mask;
>
> Oh, yeah, I can do something like that.  I originally misread the TDX cod=
e and
> thought it was explicitly setting regs_avail, and so came up with a round=
about
> name.  I didn't revisit the naming or the polarity of the param once I re=
alized
> all callers could use the same scheme.
>
> No small part of me is tempted to turn it into a straigh "set" though, un=
less I'm
> missing something, the whole &=3D business is an implementation quirk.

Not sure what you mean here, this (for example)?

vcpu->arch.regs_avail =3D ~SVM_REGS_LAZY_LOAD_SET;

Does this mean all other bits in regs_avail should already be set for
all users so the &=3D is unnecessary? Or it doesn't matter if they're
set or not?
