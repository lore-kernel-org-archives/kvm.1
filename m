Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43318BC3B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483285; cv=none; b=b0YqWi2XnjtOX3rpR0T2s9en9tCHGaCaiQodaUGSV4PYhzrP6BuH4tNUKx8LzUEyGhIKIZWjB+Yn5HSgZCFIiTIViP1aDi7jQeueadPbb/M/8nhUqsGohaxcVPFWcy7vcCRLUieCfLHAF7f7d3rLxEyPHiQCrvbKGMJzM2i8FKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483285; c=relaxed/simple;
	bh=IkRcJkUVS3S/nYokkPEqFp2L2o+giKgO5ZoROUE5wMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WnIDXAUICGvSRPtlFs47dGvNY7QHRhaq2oWEmWlfz7dLFLe9TibOUI0EL56A8jgsPrBvF38KqQH+m8NIx7JRhwj4SNPPJsW8iiLBOiJxnj26UWdkISJdfYdR6lGBs+g0KcE2Yg8dVVSyqhO4odKAY6HL45zZFB7dwP81zBiA+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFtzq1f1; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFtzq1f1"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d94a158dc8so7855015ad.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483284; x=1789088084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zNs7dTgAiCxJPiOhAGbP3H0vOe86pU6Y6qcqudQdAkk=;
        b=PFtzq1f19Ajv45YbDA/EEMbmMgfs22PWL8tK35s9MFjH/7so47e6TtETFkABoSmWym
         glk99SKkLmeHGrZjG87FDv87bilYp5JQD2kETjrNBIfm91qu4C3AGl1E40eRN69svyoQ
         g4m9OaWDwq39Xh0SLBFufYfmRUwP+YkjKsy9cDdRtZUn/ig1pmSqIUnqnNcf08mlYo9P
         nVgtq08RkMuMjtEInGCoPCYRbHik0SnDl4b3VV1wpHDDjXuTbJWMMqQT+H7CiNMYMBCD
         rtG+2Ra/NWu9Yu7IUDoPsVELYezVBB5oY30hzCFwbLO7m6jrdoU+DlVl7VJgGdVedVWj
         Bx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483284; x=1789088084;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNs7dTgAiCxJPiOhAGbP3H0vOe86pU6Y6qcqudQdAkk=;
        b=E6zSVtTjqWZOqfWwJLyxQD9qqFeuJFrbU6aOyoeP4M2Y1sphGjPp8jR2GEuaYVrZro
         4IdLhIgif13fOtMHe4JDQBb8PsTv0aH7d9EwqxdWnSiRU7b6u2PCDGSBFoMmIdtVxcPj
         uPPOQuuc6Zkk33fYizO+aMafR4ZmnGkwmwCNwF0G7hl1mkjjroM414RQf+M1NvH2wmjR
         lVddTXXrJUtvkq2tAMWrK0Rhjf0RPeUWSfk6Ng7kFaS18sarF7npkFaVnY6S5TYz3lpp
         DXFHq8CDRYG6lLjgHCiYHFZd+YZuHOMRueVTAavIy0Y0xg5icmcbO0SrXSDcAP68fMHB
         /OgQ==
X-Forwarded-Encrypted: i=1; AKwUvBycD2O3dwKuWcK8tfwJSIEvI/yiQIg0vEaP1GbugubiWD57rXPB7Udm64wjNj4VoVdYtpE=@vger.kernel.org
X-Gm-Message-State: AFuF++n9+f4IQK0DmrTIlsBWkc7AsuUFNUJln5FWjcqel0Lubt9NWmLa
	LhawKf5ZSqUXT4dtQJz0N473JhD08ZVNSOlu1oIUcfHxfS5GW5YziOzLH4BHv4m9UVsdSpJcUZY
	tzMhAhg==
X-Received: from pjqo10.prod.google.com ([2002:a17:90a:ac0a:b0:396:1f9d:c3c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:398:e46e:ade3
 with SMTP id 98e67ed59e1d1-39b2628fc1amr4074759a91.23.1788483283664; Thu, 03
 Sep 2026 17:54:43 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:54:42 -0700
In-Reply-To: <CAO9r8zMWdNLDot27LxM=j4ijXSYariMHtkFYwtd6eObp5LFa8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com> <20260902232028.2767071-3-seanjc@google.com>
 <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com>
 <api5AjDG2dByAnXi@google.com> <CAO9r8zMWdNLDot27LxM=j4ijXSYariMHtkFYwtd6eObp5LFa8g@mail.gmail.com>
Message-ID: <apoW0nWjWQVSSeY_@google.com>
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026, Yosry Ahmed wrote:
> On Wed, Sep 2, 2026 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, Sep 02, 2026, Yosry Ahmed wrote:
> > > On Wed, Sep 2, 2026 at 4:20=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > >
> > > > Force EFER.LMA=3D0 if EFER.LME=3D0 when preparing L2 state for VMRU=
N, i.e.
> > > > mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=3D0=
.  VMRUN
> > > > unfortunately allows the nonsensical combination, i.e. doesn't fail=
, but
> > > > KVM itself has an invariant EFER.LMA can be set et if and only if E=
FER.LME
> > > > is set.   Breaking that invariant can lead to a variety of issue,
> > > > particularly in MMU code that keys off EFER.LMA when determining wh=
ether to
> > > > emulate/virtualization 4/5-level paging versus PAE paging.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Yosry Ahmed <yosry@kernel.org>
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  arch/x86/kvm/svm/nested.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > index 49fb10ad1f9f..23d29597d6bf 100644
> > > > --- a/arch/x86/kvm/svm/nested.c
> > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct =
vcpu_svm *svm)
> > > >
> > > >         kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
> > > >
> > > > +       /* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing=
 VMRUN). */
> > > > +       if (!(svm->nested.save.efer & EFER_LME))
> > > > +               svm->nested.save.efer &=3D ~EFER_LMA;
> > >
> > > We sanitize control fields in __nested_copy_vmcb_control_to_cache().
> > > Should we similarly sanitize this in __nested_copy_vmcb_save_to_cache=
()?
> >
> > Ideally, yes?  In practice, it doesn't work because svm_set_nested_stat=
e() loads
> > state from "save", not from "save_cached".
>=20
> I was gonna say let's just pass save_cached to svm_copy_vmrun_state()
> instead of "save", but then I realized the SMM Code also uses it. We
> can make it work for both (macro time!), but maybe that's not worth
> doing. Sigh.

IMO, not worth doing.  At least, not for an immediate fix.

> > And even if we fixed that, it would
> > then allow userspace to pass in garbage (that is then ignored), i.e. wo=
uld undo
> > patch 1, and I don't want to do that.
>=20
> I don't think so, patch 1 specifically performs the check on "save".

True, I was thinking that we'd want to omit the massaged/sanitized state, b=
ut
that's obviously not a requirement.
