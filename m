Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11E1A268
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393733; cv=none; b=tAnFUZu9igE+8rnQCk8XIK9Df8n29rmNhJTw6UyTM53H9l8MehEj3y+QHjUh4n3ZQ1nL3stSURSIopgbdpmcjmj24eM10ojB9xgo+zYkFPfC2TiHw1b4L6xJRT+jPSeS96F8EFbU8ctNBUNRqJtZcxQM1St5FWi73lYuS831kF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393733; c=relaxed/simple;
	bh=Qwq4xH4RXX38/yUw7ob05IofPIA+zT0HtjEJqKAVLK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYe+M+tnPWZ/mKgpz/0IJ/lcz/yAp+hsoCQoMVBSMuR2LNAc0FFmsoLGYSAxUHAShmTEix+p5eqoTu7FSK70fMucw6bIS01m2Yp2PWMxM5U/7AN6Rdkqi4XJYpQ7dr29spKfzkm0FzvWp6+G46h8t1yMcfA08jhYw11M1QhP1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKx6/C4e; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKx6/C4e"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso2079617b3a.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788393732; x=1788998532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kGme/u2oCJe3dBqVl8KpUZIhrW/oGCvo4aO0aEkxBgU=;
        b=oKx6/C4eFmhydm6odAcqVE+acO3y9nhPGEV+554d13vc735nFj9L+KV8XMruX9Hmzm
         iha1thBx8Xe1ZymvotFi27ix+N6gumbz0VDM/w5zKjQnQKjp4D8QrVf50cj/Pb4FH1Rs
         Kdo8EAKfd4uJ5cyT7zkQDvjTcJOYEftn8ZHAbeCGZF/wMuAebMp+1wxo23D639FUyPMr
         m5MhrfphT62Ua/3+iaFRKidfmF3Xo1yp2wbWN1M1Jw/6XPXX4J1M3kxYYdFOSOTofQW8
         NfHAQPJW8R2ZYj3luKNfdxCyqaSKTgQb9vn52pqKoQgc9dz1/IHylVCnyT71hrC5s2n4
         up2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393732; x=1788998532;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGme/u2oCJe3dBqVl8KpUZIhrW/oGCvo4aO0aEkxBgU=;
        b=hkhbbi91IgEs6yWVhKODeSjCk/38ww812eut0YXJHvJNByjpRCV1y0HrEtDksewqKk
         xLoe3KVeV9X1zU+lLfbXn5QAP2FLWlNrj3Vyn5Py9PDhkFCEMcjgBszN2gLStMQF9QSM
         aXFlH+VBPsPNrLcfMt+NwalzSdLHLzc7QGlYhjro5FYpvOKaoIAeg8dowZicvSVZlWfu
         qayc7/1zYDAusbyHtaH5ARww7ye5UrJt0WmSjfBYSqprnBoWse9XOj+FjxeuGECvP/H9
         44L+KG8Cvnrz5nfycUAidhj8x76u2VFZ/k7eobf7m5grTbhtxfuFZJqabscZqSW7agjL
         olnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKBfJeAvn/auaKdoWxvOia03LRzyZjKTekBYFZdW7YKBogq2jYLWhNNpMK9+roFIEllrU=@vger.kernel.org
X-Gm-Message-State: AFuF++laxN1Qv1M15HYTE0mI+RDOgKF+7wA543MgL+etuB0O6zDMQA3F
	Q2gsxmwwsvHEv3wHAqGhD0Inbxeo5agUBCR/bicHnOcNCfYLtZbTNeA1elQBT3RGXsZ8E4GJFJE
	82yotPQ==
X-Received: from pfbbd36.prod.google.com ([2002:a05:6a00:27a4:b0:847:80b6:4862])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c11:b0:848:2e7e:353a
 with SMTP id d2e1a72fcca58-85ece92cce9mr12682343b3a.0.1788393731269; Wed, 02
 Sep 2026 17:02:11 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:02:10 -0700
In-Reply-To: <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com> <20260902232028.2767071-3-seanjc@google.com>
 <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com>
Message-ID: <api5AjDG2dByAnXi@google.com>
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026, Yosry Ahmed wrote:
> On Wed, Sep 2, 2026 at 4:20=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Force EFER.LMA=3D0 if EFER.LME=3D0 when preparing L2 state for VMRUN, i=
.e.
> > mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=3D0.  V=
MRUN
> > unfortunately allows the nonsensical combination, i.e. doesn't fail, bu=
t
> > KVM itself has an invariant EFER.LMA can be set et if and only if EFER.=
LME
> > is set.   Breaking that invariant can lead to a variety of issue,
> > particularly in MMU code that keys off EFER.LMA when determining whethe=
r to
> > emulate/virtualization 4/5-level paging versus PAE paging.
> >
> > Cc: stable@vger.kernel.org
> > Cc: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 49fb10ad1f9f..23d29597d6bf 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu=
_svm *svm)
> >
> >         kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
> >
> > +       /* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMR=
UN). */
> > +       if (!(svm->nested.save.efer & EFER_LME))
> > +               svm->nested.save.efer &=3D ~EFER_LMA;
>=20
> We sanitize control fields in __nested_copy_vmcb_control_to_cache().
> Should we similarly sanitize this in __nested_copy_vmcb_save_to_cache()?

Ideally, yes?  In practice, it doesn't work because svm_set_nested_state() =
loads
state from "save", not from "save_cached".  And even if we fixed that, it w=
ould
then allow userspace to pass in garbage (that is then ignored), i.e. would =
undo
patch 1, and I don't want to do that.
