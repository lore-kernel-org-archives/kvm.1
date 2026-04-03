Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484163BD237
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243277; cv=none; b=FUV5nuzD/9mTho6eqSM0vPEx+rpYZYGbJb4DyJCoEVLhp6fz75yhIdEVF1K6LWo2/LU1jLzW4Rnxm6slL7xni7m3WNh2v4XSXdeLvVMKLb8p30Bw3zDANt4XPDB5PKjhErBcEaT5VrtwGInc3PklpbmUhoQaIcHvSFpz17xzsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243277; c=relaxed/simple;
	bh=1QsnQMON75YL7mEZvMtcGUpdWC8k2PnitFmIYIXQ4ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHIAI1p7siVk+1xLPvdz0Ysj5JwBxaaXP9stQoe9Ak5O1HToJ9MC2ZUnVP8OQ5jae9KBu2MmRMRFs587uefSyqCpH/g6agrfEgLeGD15U0Olcphlwf9RwTso3yKSUVf7UjaPdQYiMtc3SFDKqGxXgMZHQ/a4MOf8LJIRgzVnL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjlqomqx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjlqomqx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2471321dcso59916605ad.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775243276; x=1775848076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgGRLe2N4RNPZGrafaVch3yXQwPK/GvM0Nk9j2ZEGBQ=;
        b=rjlqomqxDW5JQyQCCJFr7fGRkSIXFo36tFHDrwyo4K3CpSBX5CAcWrAtGr9tFBThn0
         sjO7Gzg7txQQ1Z4JtZ2WeVITSvfsaoaoMMPLXndbAW1Fyl1toWBCyIqE+YSlTVfxCI4h
         SgYPgjrUdipyabHLhRo6lCSRQpmeyHAFZVISeIqfNy8RbPGRZ9hf3UCQzvNa9xGyOkKV
         PjFzvPEhN29p33UiwJTPlDEcHDxkKvDcDWZPojauYdLmuL92guGJxbXEG7JBsE8JFNyE
         rwxNgOBRljOSn7kPW+ZaFV3skmMKN/xjS3znZjse7P9z6eGC1PVV4lX877HYrWNL9BHB
         2dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775243276; x=1775848076;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HgGRLe2N4RNPZGrafaVch3yXQwPK/GvM0Nk9j2ZEGBQ=;
        b=RNguxdPdIQ9oN9Alc9mRcxgNcEKW1ik3stJniwcSb29jxmC6XLqCA5aVHkOit6MBUw
         uF7kIx9M4EPi5o8sdg3DN1thJghybu2fk9eLEdMfsjUnowwMpDd5g0n4bK7x8qTmt7/x
         GtThYdsPrDuQbrnr3lklPSDCtC39afDzE5h4z2MV+WVOP0S/9PZqulpeUygInhQqOre0
         rEKSJbIeVezxwM0PGaB1a/WLETouim6HX6Ytm5QKwKokzVTxGmf+IIldXizq4IDyCG6H
         4L2JTd3KBM4YLVxqlpUJvVTysLzDvvSl+HkTTO6Ocxw8ubA01WS+T1j1tti0uQufyyCc
         t30w==
X-Forwarded-Encrypted: i=1; AJvYcCUUSWXORi/K8I0iNEXSpsVS4Wdd7a588H/iCDm2p7D2GxLj/47Ui/4mVYDWIBJpRPEiU6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrZ0SG6+RhwqlkY0S5hoxN5MhkckpnBdgytopS3vlvgwZKE42
	gGaeC0vs+T/SzzW1Vzm6rBxI2KXjkFxwDi2IdlNv8mBZW7IHbYVB+dhGkwwgMJmjZhMsjzKAyFS
	7ShUmSw==
X-Received: from plnw11.prod.google.com ([2002:a17:902:da4b:b0:2b0:4958:718])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:388e:b0:2b2:6df1:1112
 with SMTP id d9443c01a7336-2b281969a70mr39621565ad.40.1775243275489; Fri, 03
 Apr 2026 12:07:55 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:07:53 -0700
In-Reply-To: <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com> <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com> <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
 <ac_rNT69TdocrMYc@google.com> <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
Message-ID: <adAQCXI-7Yj0wcKA@google.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "tglx@kernel.org" <tglx@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dmaluka@chromium.org" <dmaluka@chromium.org>, 
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-04-03 at 09:30 -0700, Sean Christopherson wrote:
> > > > It comes down to a tradeoff. Should we prioritize code simplicity b=
y dropping the function,
> > > > or keep it to explicitly catch this misbehaving guest corner case?
> > >=20
> > > I think from KVM's perspective it doesn't want to help the guest beha=
ve
> > > correctly.
> >=20
> > Uh, yes KVM does does.  KVM is responsible for emulating the APIC timer=
, isn't it?
>=20
> Yea totally. We need to emulate the interface accurately. But we are kind=
 of
> making up the contract after the fact. If the guest performs the wrong ty=
pe of
> MSR write, should we make the contract that the VMM should help it catch =
it's
> mistake?
>=20
> >=20
> > > So we can ignore that I think. But it does really care to not define
> > > any specific guest ABI that it has to maintain. So tdx_has_emulated_m=
sr() has
> > > some value there.=C2=A0And even more, it wants to not allow the guest=
 to hurt the
> > > host.
> > >=20
> > > On the latter point, another problem with deleting tdx_has_emulated_m=
sr() is the
> > > current code path skips the checks done in the other MSR paths. So we=
 would need
> > > to call some appropriate higher up MSR helper to protect the host? An=
d that
> > > wades into the CPUID bit consistency issues.
> > >=20
> > > So maybe... could we do a more limited version of the deletion where =
we allow
> > > all the APIC MSRs through? We'd have to check that it won't cause pro=
blems.
> >=20
> > What?  No.  KVM can't get actually read/write most (all?) MSRs, allowin=
g access
> > is far worse than returning an error, as for all intents and purposes K=
VM will
> > silently drop writes, and return garbage on reads.
> >=20
> > > Failing that, we should maybe just explicitly list the ones TDX suppo=
rts rather
> > > than the current way we define the APIC ones. As you mention below, i=
t's not
> > > correct in other ways too so it could be more robust.
> >=20
> > No?  Don't we just want to allow access to MSRs that aren't accelerated=
?  What
> > the TDX-Module supports is largely irrelevant, I think.
>=20
> Not sure if I might be missing the point here. As above, we don't have en=
ough
> info to=C2=A0know which MSRs are accelerated. If the guest enabled #VE re=
duction, it
> changes which ones are accelerated and the VMM is not notified.

What does the "accleration" in that case?  Or does it reduce which ones are
accelerated?

> I think the below is a sane limitation, but doesn't lets KVM perfectly no=
tify
> the guest when it screws up.
>=20
> So the line would be to block MSRs that can never be emulated.
>=20
> BTW, I've been treating this secret contract change as an arch mistake to=
 at
> least not build on. It's a whole subject though... Let me know if you are
> interested in the details.
