Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8F466AF7
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813659; cv=none; b=q4Vm1Q/+bZkCYRcWFPd/L7yuBVfCUPZ1kUFNczoxmn+/PRYAhVpkttzKhCL6Booxo6czio1HvwHi7gRuV4+ka8oSZ6Gv6DyJptkaN+dfXLMTmdOiSpAI2Y+qh+Ss1YKF0ZAhLKL7fPOQ4AjB0p8fBlaP5wWJ9XVlbzG+SG38Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813659; c=relaxed/simple;
	bh=++YBs9wp6CI7gyM/wrBl8SMkwdnQIkxPBDPZiQgE/g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jLpI6pN5rpTGQWDfhL/elSTNTqSOvLFxUblZiSCO6r6ruKTdBmO5m9tSxIo98Of09iNov110U0N6kI77IWdSv2DiQoMXcg+iT9gGOOkCCXlwYKVzwfY4Vfe5JKoLthQzZuJADoXxxy1fEs1hTi93QjPk99cSKvd+4K7AqzIGwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sP2eOTDh; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sP2eOTDh"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab041eced3so1098316a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784813657; x=1785418457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P9w3oZFu/DbnCQZ5YZF6ebjs1fSL024dBaof78/i83o=;
        b=sP2eOTDh8Is8Pkj8QU4wS7RjoGAOK8jUtV6sF47caskenceIXdaIoc0pPiKGpguunQ
         2CtPkK8d5eyrmzCzfKCHrbA7/v87fPss5kJEw8x6xzkPKseXVkefBGwoMznVf5lpjMZZ
         DEq9+3ji3sKzaA3+hs6z2HIZHSeu1NWMA7D9MKsizt9EwQNfZxEBy6odamomQxfASkFX
         /P+LUmV2WRpKRv8pIyGKuSozMcNttZ4dSEACsaNl5nf1td7B4oyYi73VfvkQHVH+PXPd
         FKYevBI0w4kZaoFeb6EkP8vDxB6acgM2KfSCc8khoTf6DeEDaZa9Qgo/8sI+hMW6Wnp/
         6fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813657; x=1785418457;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9w3oZFu/DbnCQZ5YZF6ebjs1fSL024dBaof78/i83o=;
        b=rDjeolv6RwykwD1vYCg+PS4PKq/agt5PMdbo6V39IMsxOAAKZceJBvPULnyrPHqBV+
         1sj7UX3IO5fJmeLy+/ec54qcUjBXUWiO/hD5tnZ3rQThGERUmqek5BU8m0edLbwjpLaH
         KndcX/2X4AklTSbuG+Inm8nipGrQM2MAcmScZX3AXFpsinDD1StxSP++TiMpwoGF34PQ
         9czw4kaVdV2o+VlNAyqQw3Dh3G9gTJ6HP/zA/5Iv4+vmuiQaZLCa42xKhFJdWx5tSD59
         6j1PW7sKSK5kfX6d5tLaapKDDfud6EsiQa/NTcnnGAiBQAdjjgh0hUk66EbpV2s3VBaX
         rD0A==
X-Forwarded-Encrypted: i=1; AHgh+RrXOwI6BvShXzXz3cyrWYf/x4CEg0fiYywJrXTFXJwtjQYKyLCCC2R+XdBdJ8uVLD5Jwxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cQ9KAPJPrqlVURgSl4JXL0ho4e8vIsUkTXR52J/pFFMwwnnz
	bBCQxWQJNC4ZW2P7QlKf1Q468Simb7YWEPgAMmrR1f3BsoC/NOPN25DEG9AzHmsbwF8biEVthp1
	1b1F4mg==
X-Received: from pgax6.prod.google.com ([2002:a05:6a02:2e46:b0:c9e:2db2:a2d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d38f:b0:3c3:64cc:311a
 with SMTP id adf61e73a8af0-3c44aff9b7cmr3490887637.22.1784813657250; Thu, 23
 Jul 2026 06:34:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:34:16 -0700
In-Reply-To: <amGg6WjP7P-xjpLQ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-18-yosry@kernel.org> <20260616012056.669B91F000E9@smtp.kernel.org>
 <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
 <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
 <amFkZwsaoPvuNWDA@google.com> <amGg6WjP7P-xjpLQ@google.com>
Message-ID: <amIYWOgQw9z3zedA@google.com>
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> On Wed, Jul 22, 2026 at 05:46:31PM -0700, Sean Christopherson wrote:
> > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > On Tue, Jun 16, 2026 at 11:06=E2=80=AFAM Yosry Ahmed <yosry@kernel.or=
g> wrote:
> > > > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/neste=
d.c
> > > > > > index 234724d8b4c54..7b19191e0e43f 100644
> > > > > > --- a/arch/x86/kvm/svm/nested.c
> > > > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > > > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_sv=
m *svm, struct kvm_vmcb_info *target_v
> > > > > >  {
> > > > > >       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> > > > > >
> > > > > > +     /*
> > > > > > +      * TLB flushes are applied to the VMCB, so apply any pend=
ing TLB flushes
> > > > > > +      * on the current VMCB before switching to a new one..
> > > > > > +      */
> > > > > > +     kvm_service_local_tlb_flush_requests(vcpu);
> > > > >
> > > > > [Severity: High]
> > > > > Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH=
_GUEST)
> > > > > while applying them only to the outgoing VMCB?
> > > > >
> > > > > If a host-initiated flush occurs (e.g., from page reclaim), the r=
equest
> > > > > bit will be consumed and applied to the outgoing VMCB, leaving th=
e incoming
> > > > > VMCB to miss the flush and run with a stale TLB.
> > > >
> > > > Yeah it is intentional to apply the flushes to the
> > > > current/old/outgoing context. If there are flushes needed in the ne=
w
> > > > context, they are queued by nested_svm_{entry/exit}_tlb_flush().
> > > > That's similar to what VMX does.
> > > >
> > > > >
> > > > > Also, is there a context mismatch here during nested VM-Exit?
> > > > >
> > > > > In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> > > > > svm_switch_vmcb(svm, &svm->vmcb01).
> > > > >
> > > > > Because of this, kvm_service_local_tlb_flush_requests() will see
> > > > > is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> > > > > kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO w=
hile the
> > > > > hardware flushes are actually being applied to L2's vmcb02.
> > > >
> > > > Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
> > > > needs to be called on both the current/old/outgoing VMCB *and* gues=
t
> > > > mode. So we'll need to open-code the call in a bunch of places befo=
re
> > > > svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
> > > > putting it in svm_switch_vmcb() together with
> > > > nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing lo=
gic
> > > > for nested transitions live in one place and the ordering needs to =
be
> > > > handled in one place.
> > >=20
> > > Maybe we can just re-order the code to always call svm_switch_vmcb()
> > > before {enter/leave}_guest_mode(). We already do that on the entry
> > > side, and seems to be straightforward on the exit side.
> >=20
> > As stated earlier, I'd prefer to explicitly do flushing stuff where it =
fits from
> > an architectural perspective.
>=20
> I did it this way because (as you also stated) it's more robust, and it
> also documents the ordering requirements:
> - We need to service local flushes before switching to the new VMCB.

No, that's not the requirement.  The requirement is that KVM faithlyfully e=
mulates
the SVM architecture.  For KVM's implementation, that _mostly_ aligns with
switching between vmcb01 and vmcb02, but that's not a hard guarantee.  Unli=
ke VMX,
SVM doesn't force KVM doesn't need to switch the active VMCB in order to ma=
ke
changes to a VMCB, so nSVM may never end up with as many switches as nVMX t=
hat
don't need to trigger a TLB flush, but conceptually it's still inaccurate.

And regarding robustness, the flaw Sashiko pointed out regarding servicing =
pending
flushes after leave_guest_mode(vcpu) highlights that burying architectural =
behaviors
in what are effectively utility functions can be dangerous.  The counter-ar=
gument is
that we ended up with a similar bug in nVMX where KVM straight up forgot to=
 service
the flushes, but my point is that handling this in svm_switch_vmcb() isn't =
a silver
bullet.  And I really don't like adding an arbitrary constraint that the "n=
ew" VMCB
needs to "match" the current L1 vs. L2 mode.

> - We need to queue new flushes after servicing local flushes.
>=20
> I like that it's all in one place. All that being said, I did go
> back-and-forth on this so I am not opposed to open-coding it. Let me know=
 if
> the above argument swayed you or if you still prefer open-coding.

I still prefer open-coding the calls to perform/request/serivce flushes.
