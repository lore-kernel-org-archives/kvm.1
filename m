Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035994;
	b=CPcixQ1+KJe2YnMkaszw71Wp7GLl2PXzeZslrvBR2zgPfTk6/PA1NpWtkYTySpm6GJ/E
	 9shz/7lKdTtqBGnBvuof5FSr169h3hJ7grKGiTtcWV6emu21/1lueXss8v1LhaacxUFtX
	 j7foREvj7NTvlp4gOo6kf1HQ/gH5+wnJACWZLDxTLXHDi5fE2Pp1ysQARgwU4uuC2XMFX
	 2ynvS/kRCp3CqJJ1a5iDBeFJlz/hU5JkogrbgK+LI7+7Cr97krxVzNbM+EMom3cu33d8q
	 TzoUYKx8koO7AihaxHcqhUnfUgf4bCw7bzFH8mv03zXof6lJaj6Ll/SOsOGq0ORXZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=+/ZMm9aYjbUSd2YiTQuZAI9AV6w5Y2nBgKyqoyIHLWw=;
	b=qoygrnM6SrXjug7CMMqb0tXQnPmqo9PkX0FQrS1zdD9GT19GDC6tnq9s0FOvslYmuUs7
	 XICrPqCglju5YEesDaAm/DRaL9CrSsEzHwZJYn8Rch4cjMq7IP1StbX1loVc2nNVF/00+
	 VCrEAFbzsBF+nhVNqjyyuXEtDWrNbrSCvDq/FDCVVn0m90oRP1FATXuxQindmaF892uLx
	 o6v4QSMnnp50aEyOgnxR9KM6xYSS3a9wpdrb069b/7/YDp3tYR7IonmtTsrWyJjMVBh34
	 mX5L0BYOgEf8+cNULnL2ZI6bfH0mSv61Mkrhh+VHYz4i2F6cdu5FA0+oQ+98Bjvu1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i2YUP51p;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25356606A321
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25356606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i2YUP51p
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so2884612b3a.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793035993; x=1793640793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+/ZMm9aYjbUSd2YiTQuZAI9AV6w5Y2nBgKyqoyIHLWw=;
        b=i2YUP51phoHzvaj/SMz/PnuMcU370Qehx32+bv+4/p3RvLQAgL8y6y/AfUdoc5V/Lt
         5RdjTvnk6dkmPHicypSA0TNhzw8N1Clmi+rlzIvdV/vU5lM7y3kSZrguKyqVWxv5Wlrz
         sZRefvB+OuseyNlhDY5bk4Rcb8tKy/XespEpABkVkOjrC9cV1feXbBmLmT3TFuFmInZY
         8LByrgpevpJwElkHp0oB19GXGfTDG6MAnhRHkfLIrS9KvNgUJj34RpqxDliHJ82TLPul
         NtXtBmNj7iOoxLJh+liFsYW4izSrfBKwo8iXJc0AR0ES4Hz4TaIqGlPkER9QPIvHVXUx
         5Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035993; x=1793640793;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/ZMm9aYjbUSd2YiTQuZAI9AV6w5Y2nBgKyqoyIHLWw=;
        b=A/IF4JGpJg6GlPsZe9VZOXJZjpRq6KIii6wrYCURCbZtTJv5zibhKO8PwHZOpsr/Nw
         enzAwTzHh2Y/FFfn9hPWlccuXTTRhPXssQIgeoytw2f//BZnmqLwfaHr40DpBZytUoYC
         lWQwaMIMyXTX0M3eA6AURJprDhuCtW3cJwUleFDHrGEREpt+sZitrq1cJhOdkRr/5KBA
         dGAZNxzq5mN+9jbO5imPyjNMAjHLo+8QXwf3bQsHctFbL1qx70zzsQvR9bsYVZRDn4Kj
         51TLd31a/JyJyGcxWiVNfSGaIF3cerMfYMPDDrdzccCgOVuh1ydn2kLYbA86FaAqwo+F
         1K+w==
X-Forwarded-Encrypted: i=1; AKwUvByhYV022U/tMG1/xtNUX7OD+stdO0ofXqm77gcjOeTHfM63CtQsEoRERbQz5ljOLCT1uC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtHqTA9+qyU+DvDpiFE0Ra3y/of/XvYKg8woWX9GTIs68K6iHP
	RZlrDvviDVw7g3VBUPcXYbyeqgGgTuNmJ4RUWqFcDYcldfH/rt/mfLfnHZjFfKe/hVJMWZHATBO
	+OlXSAg==
X-Received: from pgm4.prod.google.com ([2002:a05:6a02:6084:b0:cd8:c65f:79da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d81a:b0:3e2:a07b:f383
 with SMTP id adf61e73a8af0-3e7cd5a6198mr5636818637.70.1793035993143; Mon, 26
 Oct 2026 10:33:13 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:33:12 -0700
In-Reply-To: <CAO9r8zMdu+YyPb3RhdTDzYteRAE9dBqxTQZKSajm4eYZCp9Y9Q@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atK3Y5XxL-zmAvY-@google.com> <CALMp9eRcWZ8fh8_m35RDw-VNrqz4kapVodGoLr=B_iAZaPOA=Q@mail.gmail.com>
 <CAO9r8zMdu+YyPb3RhdTDzYteRAE9dBqxTQZKSajm4eYZCp9Y9Q@mail.gmail.com>
Message-ID: <at-O2HiN-y5M4R_D@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026, Yosry Ahmed wrote:
> On Mon, Oct 19, 2026 at 11:50=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Fri, Oct 16, 2026 at 5:25=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Fri, Oct 16, 2026 at 02:17:30PM -0700, Jim Mattson wrote:
> > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > > > >
> > [ ... ]
> > > > Per the APM, volume 2, Section 15.16.1, "TLB Flush":
> > > >
> > > > > All TLB entries belonging to all ASIDs are flushed by SMI, RSM, M=
TRR modifications, IORR modifications, and access to other system MSRs that=
 affect address translation.
> > > >
> > > > With two separate ASIDs and the unconditional flush removed, do we
> > > > flush both ASIDs in the above instances?
> > >
> > > SMI and RSM, yeah I think so. kvm_smm_changed() ->
> > > kvm_mmu_reset_context() deletes all roots, and kvm_mmu_load() will fl=
ush

s/deletes/unloads, because the roots themselves are almost always still rea=
chable
through the hashed list of shadow pages.

> > > the current ASID when a new root is loaded.
> >
> > Okay. Is this mechanism obvious to those who are versed in the ways of
> > the KVM MMU?
>=20
> I don't consider myself versed in the ways of the KVM MMU, it took me
> a few minutes to track this done, so I think it's okay.

No, it's not ok, though it's also not something that needs to be addressed =
in
this series.  Historically, KVM relied on kvm_mmu_reset_context() to perfor=
m TLB
flushes basically everywhere, e.g. on CR0 and CR4 writes.  It was a nightma=
re
on multiple fronts, e.g. it was suboptimal when toggling bits that needed a=
 TLB
flush but not a full MMU rebuild, and understanding whether KVM was deliber=
ately
doing TLB flushes or not was difficult, which in turn made trying to optimi=
ze
any of that code very painful because it meant disentangling years of KVM c=
ode
*and* pouring over the SDM and APM to make sure we got the TLB flushes righ=
t.

In short, the fact that kvm_mmu_reset_context() happens to guarantee a TLB =
flush
of the new/current root is a side effect and an implementation detail.  If =
a TLB
flush (for the guest) is architecturally required, then KVM should emulate =
that
exact requirement, even if it means queueing up what will be redundant flus=
hes.
That makes it easier for newcomers to follow the code, and gives us more fr=
eedom
to tweak and optimize MMU context changes/resets.

Concretely:

  Author:     Paolo Bonzini <pbonzini@redhat.com>
  AuthorDate: Mon Feb 14 11:50:36 2022 -0500
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Tue Mar 1 08:50:42 2022 -0500

    KVM: x86: flush TLB separately from MMU reset
   =20
    For both CR0 and CR4, disassociate the TLB flush logic from the
    MMU role logic.  Instead  of relying on kvm_mmu_reset_context() being
    a superset of various TLB flushes (which is not necessarily going to
    be the case in the future), always call it if the role changes
    but also set the various TLB flush requests according to what is
    in the manual.

For SVM, the redundant flushes are a complete non-issue.  It's basically an=
 extra
memory write.

For VMX, the INVVPID isn't free, but for emulated SMM I can't imagine it's =
a
meaningful performance issue.  And FWIW, the only reason not doing
KVM_REQ_TLB_FLUSH_GUEST isn't a bug is because hardware isn't allowed to ca=
che
linear mappings when EPT is in used (and INVEPT invalidates both guest-phys=
ical
and combined mappings).
