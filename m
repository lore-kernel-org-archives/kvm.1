Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A027F19F
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401845; cv=none; b=mo8H8BY0ifvq7KGgeZZMruRZQsX2SSzV9aH8+D0u6v4Oo/KrBAbrDvbEbvMYAPpLnsmuJuJIBjo0RKgNBSfqB6Nx3Ajv1TFhPL5nYvsf9/v2Gm5RF2BRKmL9nhCk91MVjUsZGFgVFpqGu3EdcsLeLLlR1kuaoI6I4btv+mPE9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401845; c=relaxed/simple;
	bh=+4dWjNW0MAtI7qbpEEHTSK3A6idXP3scE6YWXGSI2Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miTaQBWEYkBjApcoqhj2ybbv2bkgSe02hJA1ck4yd538k9bu4lOSN3yWYj1W7yyTL+C/eK+9xTeJVa4gzXwHNzzKBwjz9Ksf8Dn51pKRwABxNA0ZbMUU90MBxMHSpFXTEhTSU5eprYNI/dlul3d8btLU+ydMWEQZFpqmFq3IV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wT9BM3dw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wT9BM3dw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4678c6171so111760995ad.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777401844; x=1778006644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTnb3RdkOOM3FgAsrKAJXfLReTvrvHzD4M2LtCPRIn0=;
        b=wT9BM3dwA3S0jQ4WXuaudI/6JNSb6xcnDmJuisoMKee000mqGezwg6A1/Az+L8HFZo
         BTBI56A9fpnHrvMMfuc/qeDOOm/YgoGFW5fwgj3LK8ld76WavzzTPUzLcYmRGMipB1Vg
         4IrwCN3KxS2J5kzuTRfbO5dpgOsOcV2MjfWgFlDGXv1IbPftFC8ePJUM2zE/8FYDdyQ/
         UflvJxMmETtahWEQUmObDp4HXXmHqYEVLS9aSt068dQHNUoXwar7hprVTIdajDylYpug
         1Jy5XzjaRuaLZyUi5iMn3RcEarDmO98SuDcompkyBEAwKSRVuNXXu2/N5YkAQh1xUOzm
         AAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401844; x=1778006644;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTnb3RdkOOM3FgAsrKAJXfLReTvrvHzD4M2LtCPRIn0=;
        b=g7Ok/T910I+tnB70iRpJR0gqyzjpn4WeOCMzsoAz698QJ3SoqM8hmeyRPdqCZq2nMI
         +ltdq6cb9GGCXaW3uh7BCYgO03AjLtLdAO66N7EXzf5JpfPWg+B9fl6bLgatapQ3Dub3
         8ZOm7CBnQuMHjYdsDPp/JsW3cOp3U0G/tOVc7yYmFy3ZkJEpHv6Gzueb+cte7O+3O2LD
         xzWTlZt4L/GqixaZUQnEpuPUKznWB5UjGugfPYz5v4i5vnc3kMqtQmMWhO76jOiCttey
         SWQPB2zKrCsUeeJI9tWJ+1dt7S7x0hFF9BjFyYMlHwHZHT9RcKzVmVOz4iOACyjsxpES
         y6wg==
X-Forwarded-Encrypted: i=1; AFNElJ9jvK8/d1tBjOC8D7ecBWErkQ6RGbnTngmVHSLrmF0btciOejYAL0W0Wqlf7MQLncGSx8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYVJm9pnxQr/k3SJ1cDgZAb/k4+izv2+lXtbKQ86VEBx/b+z4
	/6fVcIEUxebvZAQNfpo1uiaMozB6dXqB+/JsmTxOQJFsW0m7wJlJMZfb1vIO+4rqDp725gjyVfN
	6QpBPlA==
X-Received: from pgib18.prod.google.com ([2002:a63:e712:0:b0:c73:cc95:c0d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa2:b0:3a0:b65a:5def
 with SMTP id adf61e73a8af0-3a39c2726f9mr5138003637.33.1777401843677; Tue, 28
 Apr 2026 11:44:03 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:44:02 -0700
In-Reply-To: <b8c413a52c0285534d552c8646f9071fca4351f4.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-2-binbin.wu@linux.intel.com> <afCdoufK0D+1hKAR@intel.com>
 <afDgiz38tARlIQNr@google.com> <b8c413a52c0285534d552c8646f9071fca4351f4.camel@intel.com>
Message-ID: <afD_8se-aOikeHTT@google.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026, Rick P Edgecombe wrote:
> On Tue, 2026-04-28 at 09:30 -0700, Sean Christopherson wrote:
> > > This patch looks good to me. But the rule for which MSRs should be em=
ulated
> > > by KVM for TDX is not very clear to me.
> >=20
> > I would strongly prefer to not take this patch, and instead fix the gue=
st.=C2=A0
> > This isn't some latent/pre-existing guest behavior, it's brand new
> > functionality. I.e. Linux-as-a-TDX-guest broke itself.
> >=20
> > More importantly from a guest security perspective, consuming
> > MSR_IA32_PLATFORM_ID is actively dangerous.=C2=A0 E.g. it could allow t=
he untrusted
> > host to steer the guest's behavior with respect to feature detection an=
d
> > enablement.
>=20
> I feel like you could make similar cases about a lot the VMM controlled M=
SRs.

Oh, for sure.  And far worse (yet another reminder that I need to refresh t=
his
series).

https://lore.kernel.org/all/20250227021855.3257188-1-seanjc@google.com

> > And once KVM allows reads from MSR_IA32_PLATFORM_ID, there's no going b=
ack.=C2=A0
> > E.g. if the TDX-Module wants to emulate MSR_IA32_PLATFORM_ID, because t=
here's
> > an actual *need* to do so, then we're going to have a (minor) mess with=
 KVM's
> > ABI.
>=20
> This is a problem with the bare metal KVM behavior too, and it's just sup=
er old?

No?  Oh, I see what you're asking.  I'm mostly concerned about the host sid=
e of
things.  The problem with TDX is that a TDX-Module update could effectively=
 change
KVM's behavior, i.e. if the TDX-Module decides it needs to emulate PLATFORM=
_ID for
whatever reason.  So not only would KVM need to enumerate to userspace that=
 the
MSR is supported/emulated for TDX guests, KVM would also need to differenti=
ate
between emulated by KVM and emulated by the TDX-Module.

> For TDX, hmm. I guess the standard thing to do in order to avoid creating=
 a KVM
> ABI problems is just match the arch behavior. But for TDs, it is a very s=
pecial
> type of VM. The special TDX guest things can't work on bare metal. Furthe=
rmore,
> guest opt ins can change what arch is even supposed to be virtualized. So=
 the
> normal KVM default thing to do doesn't always fit.
>=20
> So instead we will just virtualize as little as possible to keep Linux gu=
est
> running? Ok.

Yeah, and the sequence of events matters.  Most of KVM's half-hearted emula=
tion
of random MSRs exists because KVM needed to be able to run existing kernels=
.  But
once KVM (and other hypervisors) existed, kernels learned to run as guests =
(and
hardware vendors largely did a better job of explicitly enumerating MSRs an=
d
whatnot), and so the need to throw hacks into KVM mostly went away.

> > > Maybe we can document the rule here, if there is one. That would make=
 it
> > > much easier to tell whether future issues like this are guest regress=
ions
> > > or missing KVM handling.
>=20
> Speaking in general now about TDX guest ABI, not about this specific MSR.=
 I
> agree it would be good to have some story about how this is supposed to w=
ork and
> evolve. Similar to the CPUID bit stuff we are trying to clean up.
>=20
> I'm also remembering the debate about what to do about the MTRR bit being=
 forced
> on, but not being able to apply the KVM solution (which got ripped out an=
yway)
> to the S-EPT. Or the guest maxpfn thing, where we got the TDX module to a=
dd
> CPUID bit support we needed. By default, we can try to make it so the TDX=
 module
> will, or will let us, faithfully match the normal x86 arch bit behavior.
