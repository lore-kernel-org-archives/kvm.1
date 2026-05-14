Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1256410D37
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769947; cv=pass; b=V0Oj6v7n+eczz27f6NYzxEXjQuG7zIZBoo5qN3WdovWQB8M/XmtiUW+2WTvlTZ0Jk2UEbqaA0BvJvRWmyT+tzD74ha+HBqicGN7w4JhKTx34UrxkCVnCUQXZSid2DElT1F8x8+nQ34lTAD71jFIJqzB8TKrMMZ3lEEPjmxJTc+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769947; c=relaxed/simple;
	bh=AOuL4P8rcB/w4m3MQYbAMxJmPtiyHVkS+oqVWDnYxGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ2DOgYP3e7cfMartlFLTzNd8QyoAbR+JaBkKrtsKO0zmmqP3C5RSFnW7Ya3RpikthYwpZG3AobXyllRdbI5qLFMCcWT0Q3h9C6IFTzV9zlHDLqG6j1EodtIHhrHwiJ01WMPcXTWSf/uRKmUGL9Xm2+LOtUtph4Gse6T4V6GXjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSvGb2l7; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSvGb2l7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso8473a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 07:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778769942; cv=none;
        d=google.com; s=arc-20240605;
        b=loO41e41PA7YqN4gJByNZrRrJteE8zuDf4BAOZboBTc9bZI5shqHDOcN2mEGHmUlvs
         6Bf9dOw0UbzXDakjRM+SImOePP1Vis4UV4WruW8xTY4+qMd0HzU/Aab5q6F6eS6ky9QS
         fr5YjxpXnZDYR/AhIU7U1/EI0fDjcD6RXbUjb38Jzx7QenqiycGGLcMv51clmMFlXoXD
         n9rMRnJqt+RrGDsSy7P1Wixt6u2BtCIvB1d5gBcvpa156LJSLXKMMIInWKK1Z7guSZUH
         D/nWEeU1G0HOZ/7SEIvc4AKD+jH/2r6wTEg+d6CrQ5MeOjjNTNDWE1WQ/uqTLRcwkL8J
         4BLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mHlWFCWo35g49/Oc5J271s5rFVq6NRF9U1sIaUKt4Qo=;
        fh=GZKWt4aR/gxia6X8fd7N4EswGTFJqdQCA8NHqYwbqek=;
        b=QrjDfeal4M5ICrq35fRKoSxXOapnOWOvbhUaAF38DwNngOGU5V/qp4QC4ohauyFdv4
         56mVvE38b+dMtnTy8cEiP2LrFSxXbR8QPN2Knj2Gmwc2a2h0FcebbPa4ETyoQvjJGCKY
         hlfq5r+H2sDIvIr48JSLUtcpJ2B3Wgl1uAfpRo98vD0bAaZ8zu33yjQ3WEWKIPe05TRc
         BEb7l+IeYTi0eHHKEa1KPzj8hFQ00h2WMec5Y71YojAug8/lvBkooDahahU+f60pBxOJ
         CSlzICgX13FfR9yI5x5RyAvXGBHznG/t2xTiLk2mHJwdmircMlSPDA7nc9Pgx+2X6RBk
         Giog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778769942; x=1779374742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHlWFCWo35g49/Oc5J271s5rFVq6NRF9U1sIaUKt4Qo=;
        b=lSvGb2l7TF43sTuMVzAqrV4mup+TcU+k7NEykRZPR3mJ0Dr9KNoGTMbHrYNvZJ9a+S
         hyiD+m+dxpgD/5Hnh/Nucwd7qdstiGt1bkKCSDi4xTdpAHvXSFdiTKR/1oD6ADTWvPJ7
         CpymscLz3eIwJSxp2AX+AitLyK5hZn/+0u72ow4Ze4r31Uq2RDoSdzI8p6aY76QWNxuC
         Fb3/QyCuHiO0xCOfTZD/FAAP5kUNfhkcwMA289MlK88gifV7AhO+hjKZKqqMxhK7gNuF
         SutjaEQMMX+UBPwee29+GogPVlKSTl0sJv9f4K8SNovn9208Sx+/7wAzzt/5pIz5F/wg
         bh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769942; x=1779374742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHlWFCWo35g49/Oc5J271s5rFVq6NRF9U1sIaUKt4Qo=;
        b=VEYkwQLG6cSFbShYf3d4omQN1weBQMksdIPIGDQFBBmy9O10t6ZjkDnHRup+W/Z3VS
         /M3QkE7LH/pDf2nH5bVkPRsvdQ//2F+kKvHWfZWclEOJ7K2oT2M8V/h47LEvTYuD9IMV
         JYCpeXEuqjlQHZrlv9Ky01bGzSccWD2qbNd4h0mDxnUZybmZH+cgjjmPkWm7abZB7G+n
         A8Vnz1fRQx4TEGMDCB8vSQfrq8tt1yMe+01PlRvRMPHO+RhfpYWK7yM770IoRRgFh3qq
         uvMmLRxlEE2e74VzaaoORKKN7DQK3cCoUGZCTPRcPOjG/kPjGxdqRhTuxA6T5x9FkksO
         45cg==
X-Forwarded-Encrypted: i=1; AFNElJ++fDlyKAFHwQteEQB/ThFzUCbXOUek5Pu34zD1i1m8sVko6Oo6DWxyCr28+O0Di34rAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR6MK5smJCslVSxy5qR5WiFWhOjjzZZOI5VCob+v4rCflsM17
	e/XIDgpkuwbJSVfifzuUHGwkP99vXcl1Ek1sxTQrC30VHH7f7yMUYrwxuKgJ7uzs7gJuACoZ8T0
	bOvr+VQEwYZ4we0Y+hgPLG1TtwQdFDS188VtzBrE+
X-Gm-Gg: Acq92OFQ/pp4Qb7WdZfN2hngKvUjgCFabz9hJyctG2wfW/gMek8N8/wxA5CMw0IxLSA
	phJpKimsczNi3h4e5EsPZ0ARL8TBoMblN6/QxoeNcWDqxfaQlfW0TWFiES4Oj5HbQm3JTqa5DkC
	rYwC1EOfuGDaTG/jjWKiYlhXheNOT3IT5lK6o52gt15HRVGVgEDUOLWnGQsaSxiahjLkmTvClFc
	5OmK8+lm6fL4QMIHRzGwdquJ3XuRtNkXbKt09lTwo8DAdLl16SRuC1MmUUiwikNEzw2m1olVCWB
	tqzh3C8X9ufUicH7wg==
X-Received: by 2002:a05:6402:10cf:b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-683271a79d3mr59165a12.11.1778769941669; Thu, 14 May 2026
 07:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com> <agXcKDjnJc9DPcyr@google.com>
In-Reply-To: <agXcKDjnJc9DPcyr@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 14 May 2026 07:45:29 -0700
X-Gm-Features: AVHnY4JYNiOdZV1RRg0bwZU9VVOOCRJGJfNWSac97RU4N7K2DxmR7r5ouTnF8Qk
Message-ID: <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:28=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 14, 2026, Jim Mattson wrote:
> > > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > > index 95d09ccbf951..fc96ba86c644 100644
> > > --- a/arch/x86/kvm/cpuid.h
> > > +++ b/arch/x86/kvm/cpuid.h
> > > @@ -185,8 +185,9 @@ static inline int guest_cpuid_stepping(struct kvm=
_vcpu *vcpu)
> > >
> > >  static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
> > >  {
> > > -       return vcpu->arch.msr_misc_features_enables &
> > > -                 MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> > > +       return (vcpu->arch.msr_misc_features_enables &
> > > +               MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
> > > +               (vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
> > >  }
> >
> > Sashiko raises a good point here about a pre-existing issue that
>
> Calling this pre-existing is a bit of a stretch.  I'm guessing VMX doesn'=
t check
> the #GP before the VM-Exit (checking #GP before a VM-Exit is so stupid).

Per the SDM, volume 3, section 27.1.1: Relative Priority of Faults and VM E=
xits

> Certain exceptions have priority over VM exits. These include invalid-opc=
ode exceptions, faults based on
privilege level,1 and general-protection exceptions that are based on
checking I/O permission bits in the task-
state segment (TSS). For example, execution of RDMSR with CPL =3D 3
generates a general-protection exception
and not a VM exit.2

> Yes, KVM technically emulates MSR_MISC_FEATURES_ENABLES_CPUID_FAULT for A=
MD, but
> we're firmly in "making shit up" territory when reasoning about the inter=
actions
> between SVM and a feature that doesn't exist on real AMD CPUs.

True.

> > probably warrants a fix before propagating it further:
> >
> > > Does this emulation of CPUID faulting respect architectural fault
> > > priorities in a nested virtualization scenario?
> > >
> > > According to the AMD APM, if CPUID faulting is enabled, a #GP fault t=
akes
> > > precedence over a CPUID VM-exit intercept.
>
> Where in the APM?  I can't find anything in the description of CPUID or C=
puidUserDis
> that specifies the priority, and "Table 15-7. Instruction Intercepts" is =
flat out
> wrong because it just says:
>
>    CPUID  CPUID  No exceptions to check.

APM volume 2, section 15.7: Intercept Operation

> Generally, instruction intercepts are checked after simple exceptions
(such as #GP=E2=80=94when CPL is incorrect=E2=80=94or #UD) have been checke=
d, but
before exceptions related to
memory accesses (such as page faults) and exceptions based on specific
operand values.
