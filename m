Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFC212564
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766439; cv=none; b=j3B9TVt8cClruBSoWSOCcmAttrsOgPL6wVmSKwm3TAJc2SiNwUt86MlDit5fa18hAi/XyidQTljxWIJ/EHQI7BFy0vTLAKEVs5QC+D/xrXOF5n4SrAOf/Sn+HeaOCYqrP4BdohhVmMrq8TK3nN1qxbV/oWo7wiTKNry9sDVnt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766439; c=relaxed/simple;
	bh=djhdH7hU/KJJVqBSegJu2KyTrM4+AE4YTrzHxx43pYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GQAGv/1dNlxtb0UD6QW/4Xwqnano5cgciq5L/BgPrlZhZcDfX+Am6jHy1N/D6vj9g2KiNw1KNNUa3qxin/n9Wc4F2hY95UpnfcCI7lIXfcJNIAbKwVhaPIrT/dgHQctt7IauRVghs3oeLs0xZ3h5U59yvM+rs+15+un/r4Ib3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtI4fteN; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtI4fteN"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cea6a46766so1950335ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766437; x=1785371237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iOHK68Y3V/Vcay6YYOirrqkgOV3klMSx4s7wodNgHA=;
        b=NtI4fteNh8wcJqYInDXJ29bxmDhUEAhBgm39xDPdOFvAAZnO1ZVTdx9ePKTs5qP9A9
         b9CK7Sn1L/rXRKZv9VFQDMDKeECK9InszD2f5gZGt+kFLLqxu6UCbpWd6TY/6vi8+wxT
         71hhN6nYLLG4ujUW13wjbsMZc3SNb9JJ3cTsRVfTwZcuivzJPRYBnRHL0WRRiNyW8S+N
         TMAl1lvM0BWTmu2AX4ELLUxgox/x3I6pNAN1H0NpJnibNBZU8/CJ5whVciHZBqAZaOCr
         jSY8EpP5G6izxKC8sFNEyTFDX5wTZMgWoRTzQ5DWTgSCwgz/prPPXSIz1Odz8nwhsYab
         YLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766437; x=1785371237;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0iOHK68Y3V/Vcay6YYOirrqkgOV3klMSx4s7wodNgHA=;
        b=BIDA7s2oWnpSSSogfUS3/0sJAPyR3nVZeGvIlOsrF2hGmk2CQAiDlUizdULbbtFwWg
         HJiMyNV7bmwwz6yf6ZbNkQtauhGTCSeCKxJPe5YgYsfS2KT+sxb2SW7qoKGr1nCtbuBi
         nIqn8jNCLILgVUu5VWed8YB0N0Eh53cCHRQh1y9n5Ro74PSw44Js9tAA2fyTEuOzvOi3
         OYiSWoB8OAF2q0M6HZE0b46pBPgSdiK5nbKakdLLfXCypLQPMdmk3M3sZjLiVI/kjXTu
         gjiPRogtx7lHBqnU+N6/12r/1yijElM3ueugm2kcrwvxfyHCtET0VpfSeN3PoYtdW1hf
         39fA==
X-Forwarded-Encrypted: i=1; AHgh+RqcIoMWQiN6PB1ofygeCex+DIbHSZpVCjB/5zleeH9+nyEshZLtdNdvzi4+26jtxyYblVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxofd/4cb6VyHRBUUckeOxWP2r4cQYPo+LXaMnxP8HgRNtFYBdy
	PtIST1IqJwuhAF6zbQUS0ke6ec9QXNpgcT4MsGquWaKaW6Zl9pw5sxov2c29NqFjmaFho1c6u6U
	UQdI8Jw==
X-Received: from plkk12.prod.google.com ([2002:a17:902:c40c:b0:2cc:da2c:808b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e945:b0:2cb:3f5b:6663
 with SMTP id d9443c01a7336-2cfa6bbfb61mr11511955ad.11.1784766436910; Wed, 22
 Jul 2026 17:27:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:27:16 -0700
In-Reply-To: <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
Message-ID: <amFf5MAhc8sUqeYV@google.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026, Jim Mattson wrote:
> On Wed, Jul 22, 2026 at 3:09=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Jul 14, 2026, Jim Mattson wrote:
> > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > >
> > > > What complications?  Advertise the lowest common feature set for th=
e pool, just
> > > > like userspace has to do for literally every other feature.
> > >
> > > The problem with passing through the number of host ASIDs to the gues=
t
> > > is what to do when the combined host plus guest usage exceeds the
> > > number of available ASIDs, particularly when FlushByASID is not
> > > available.
> >
> > But that doesn't have anything to do with the number of ASIDs that KVM =
enumerates
> > to L1.  As of this series, the number ASIDs KVM will consume in hardwar=
e is a
> > property of the total number of vCPUs in the system (one ASID per vCPU,=
 plus one
> > more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1, all =
10000
> > (10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->nested=
.asid02.
>=20
> That's not the only conceivable implementation.

But it is what is proposed in this series.

> KVM could advertise 64 ASIDs to L1 and reserve the corresponding non-zero
> ASIDs for L2 VMs (i.e. the first L1 ASID is 64). Then, vmcb02.asid =3D
> vmcb12.asid & 0x3f.
>=20
> > Of course, that completely undermines my statement about suboptimal per=
formance:
> >
> >   And potentially suboptimal for performance.  There might be a legitim=
ate reason
> >   why a CPU generation advertises X instead of Y.
> >
> > My bogus assertion about performance notwithstanding, I still think adv=
ertising
> > what hardware supports is the simple, sane approach.  Because at the en=
d of the
> > day it's just that: advertising.  Userspace can do whatever it wants, i=
ncluding
> > peeking at raw CPUID.  E.g. if we want to pull a stupid and emulate the=
 behavior
> > of ignoring "unsupported" ASIDs, then we'd need to do that based on use=
rspace's
> > defined CPUID model, not KVM's advertised support.
>=20
> But you could refuse a userspace CPUID model that claims more ASIDs
> than KVM supports.

Nah, that's not the KVM way.  For this one in particular, there's zero reas=
on to
enforce anything.  Practically speaking, *if* we want KVM to act like hardw=
are
and ignore unsupported ASIDs, then KVM *must* allow userspace to define a m=
ax ASID
other than exactly what's reported by KVM_GET_SUPPORTED_CPUID, otherwise mi=
gration
pools become impossible.  And at that point, disallowing a larger max ASID =
adds
zero value.

If KVM claiming support for an explicit number of ASIDs is a sticking point=
, then
I vote to zero the output in KVM_GET_SUPPORTED_CPUID, but I'd prefer not to=
 do
that because it will break reflecting KVM_GET_SUPPORTED_CPUID directly back=
 into
KVM_SET_CPUID2.

> And __nested_copy_vmcb_control_to_cache() already ignores a bunch of
> unsupported bits. I don't see how this is any different. That's how
> the hardware is implemented. Intel likes to fail VM-entry. AMD prefers
> to just ignore hypervisor stupidity and move on.

The issue is that KVM has played nice with unsupported ASIDs for years.  If=
 we
want to change that, it needs to be quirked.  And I just don't see the poin=
t,
because KVM's behavior isn't outright wrong: the APM doesn't say what will =
happen
if the hypervisor is being stupid.
