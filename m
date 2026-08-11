Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB3449B09
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458822; cv=none; b=hYmiyDoS5hbJurIlVApbfg8It+z8koIQ+wLGCElNbjC/Qh/mn/G7+9exWl/TA//oNoBvSO/3sa7RtqY3iljDTc9Jfcl/aJ8tTa/iu2RreWvn4CFFUuF++MhNsHmqqJ19qDQ3jESaxOA7wilS1BCifCJhl+5SfPLjAwyHo45kSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458822; c=relaxed/simple;
	bh=souBD1zXcD3502IpHWBQS+Z7c2GdHUFCg0StFugdYWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sX+B71tOxetXz6FlVL71jZ60QKuMpg80s8i3kwpyoVtYFTafzLVIIuUc4QW2onQARYwlttJTh9+mqa+/yGaFP8nR62LZFxJ0RKBlH4eYyBf7r0nYK31SdUfQt5mzQjVNckt//XXEVH2R/bwtU3DVk0wRgGnnC+eZVni54yhK+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OT3EtFaj; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT3EtFaj"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedf6e8a42so239915a12.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786458820; x=1787063620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wHiT8wO1O96VMhGw9PY7w1Kf2WhC1UcbMKtaZdcKQc8=;
        b=OT3EtFajZv5pw+LfUNeiZgnB+EO8Uh0tkYhSTPOfDCbIHQXQjsejJR5XtPxTquM1S4
         wHYcGzxXGhSQvVVS+5tIwwBpvN3zXqurZWBUe9jihCrnJwRYiApAv64LW/zpLlUn0xsm
         hkpqABC/1zx0Apfpb6Bdqh8y/QY+DP0kd0CoLyd8HWPwz2AdLCoIxlyjFiD3VQAZrdYJ
         KumgTUGJTHdaas15SdVjcNmu+qUvYibqSntOCpF95z3sPAFuPS/3sKEg8JGbK3XxjOke
         bpSlgCvfZl8s0BxGNezTKIhkZBBNG1X0HV3y9qfQhFFj6MXGNUVSvCPgsZl6+vSpEm5a
         kfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458820; x=1787063620;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHiT8wO1O96VMhGw9PY7w1Kf2WhC1UcbMKtaZdcKQc8=;
        b=pivSQV9YqNIxnDj8cZ9I4P4kCRuNmsjBodVAOo+rV3+DW18a5fI3WHqhWZzfK4opSg
         q46GjS+cU8hfYDS+EUBafLbQxxFTA7bdS75mLBRaFyHuCshdt/6CvMuzaHdYutVA3YBW
         XzAjfHzIgXSM9UGZgUkYyMdPRsJzL3+/PPSRZZbt+ih24BiFqYjffEHBRrPHw/Mdr4Nc
         Rq6rdJR7mISqdJzPQVPpioD87V1ameNA9tNg9dGYXO58BoThrH/dpyY75Jet34gjHjHx
         Uw9OvQwS5dCfCzdmHt5o64vhcW01R92O9CLFufhxhI4A2/E/jbDApsVFZowxDWIgFhOj
         bOXA==
X-Forwarded-Encrypted: i=1; AHgh+RpJ6hK/7n84MUtY69UWaWl8k5m6w1zNomzp1QP42fi93Rt246fJKSDJwG4qQiJZAFGRr50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsan/zb57sWODlwUvPKk3QKLPQFR7LTlnzMG2erDwe+5DIgW4d
	ltkPd+XnJlXQMkV+Bv7Hah4wyuIKhizfSbV3SRJKKRpGnJbSete+VksNgauAtqc34+ST45Uv6Po
	IVraDhw==
X-Received: from pgmo14.prod.google.com ([2002:a63:5d4e:0:b0:cbe:7df7:35b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9f10:b0:3bf:77d7:667d
 with SMTP id adf61e73a8af0-3cc2babdf84mr4904619637.28.1786458819619; Tue, 11
 Aug 2026 07:33:39 -0700 (PDT)
Date: Tue, 11 Aug 2026 07:33:39 -0700
In-Reply-To: <ansuqrD2KwFuLWbV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-18-dwmw2@infradead.org>
 <anoOz2rZ02KFk1l-@google.com> <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
 <ano6-gIZtqMfipiD@google.com> <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
 <ansuqrD2KwFuLWbV@google.com>
Message-ID: <ansywxh0VX5rtfWc@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, David Woodhouse wrote:
> > On Mon, 2026-08-10 at 13:56 -0700, Sean Christopherson wrote:
> > > =C2=A0
> > > > > To allow different offsets, KVM would need to track a per-vCPU of=
fset to the
> > > > > master clock and apply that in kvm_guest_time_update() (and maybe=
 other places?).
> > > > > Which is doable, but it's not clear to me why we'd want to suppor=
t that (though
> > > > > I haven't fully processed the back half ot his series, so it's ve=
ry possible I'm
> > > > > missing something obvious).
> > > >=20
> > > > Because I want to reduce the number of cases where we have to fall =
back
> > > > to non-masterclock mode. Especially the ones which are driven by
> > > > *guests* rather than weird choices on the VMM's part.
> > >=20
> > > But why though?=C2=A0 What is the harm to the host or guest?=C2=A0 E.=
g. does it make it more
> > > difficult to accurately migrate the VM?=C2=A0 I'm not opposed to allo=
wing master-clock
> > > mode with diverging offsets, just trying to understand why it matters=
.
> >=20
> > Accurate migration without masterclock is hard, yes. The
> > KVM_SET_CLOCK_GUEST thing relies on it (because the principle is that
> > you get the *TSC* right, then the KVM clock is just a fixed
> > mathematical function of that).
> >=20
> > That *shouldn't* be difficult with offsets between vCPUs. Just use the
> > TSC of vCPU0 as the reference for KVM_SET_CLOCK_GUEST and let the
> > others just have their offset from that.
>=20
> Yeah, my only (quite mild) concern is that we would introduce fragility b=
y adding
> yet another variable that needs to be accounted for, but AFAICT it's lite=
rally
> just the tsc_timestamp in the shared data structure that consumes the per=
-vCPU
> offset.

Actually, why are KVM_{G,S}ET_CLOCK_GUEST vCPU-scoped?  Per the documentati=
on,
the API "Sets the KVM clock (for the whole VM) in terms of the vCPU TSC".  =
If
the APIs are VM-scoped instead of vCPU-scoped, then KVM can simply save/res=
tore
what's in the per-VM masterclock state, no?

That would also help address my concerns about sanity checking the TSC freq=
uency
against the kvmclock frequency, as the APIs are much more blatantly about s=
aving
and restoring masterclock state.  For whatever reason, it feels more natura=
l for
me to say that KVM_SET_CLOCK_GUEST will fail if the target frequency doesn'=
t
(fuzzily?) match the frequency at which the masterclock is already configur=
ed.
Probably because use_master_clock directly gates that information?  Whereas=
 the
vCPU's frequency is independently configured but obviously influences maste=
rclock
mode.
