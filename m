Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEB3DEAC5
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092079; cv=none; b=faJmnkOQKYNazYZccWrHR3Vvwmjy2O42Luhzsc2X375LhQ5S9WjCl/8Q47pLBRtV2+It38d/GJA4hEK+wXpSltgDBgjIv2iVsVskaebtS2tY3vlgw6/mMmTb6stLS4uNFiHuKFLkpZshAz6vbbOTQBzO/Ssfp2ntd+BvyqP+wHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092079; c=relaxed/simple;
	bh=e/yA9zOTW+FJSb+90hJJfffdxthT5LbM6b1XvxBUtWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDDsPlkZAWrvTLhD/wvZQGMxQL/EGEeBKR0tATLtPoQCZMypM2VIcu1PbXS3iPudN0twrFipWoX7AfClM3KUAHd7J5+lsS+vHSwbruaOPOUzC7sHt9ui60ItNf3b27ey08eGgUAtF96Nb2rtUAqvjbOK7Bga9GAC3O3zd79VqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqlWq01e; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqlWq01e"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f07078ff0so2425420b3a.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776092077; x=1776696877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJcPRN3ndueDSdYwxtdP8lEQ3v1K2ekmMZi16tT5qsI=;
        b=CqlWq01en00IR8nMkMcD3NxbnOT1q7oaQ+z9xCe1YWzLxzh2gxWmXouAsIMTvRHVNA
         z3Ur90fV+fNpOx519EH9fHyxd47hx+QJNY0Vivbg/z0XmTyvFYgVVkXkQTsc7by/6duV
         AyN+5EMoI0zF5HhFDkn9QFv/vqQBTS0qSHM9HINeYPN0PpxOI4TfZYQDcTgiX/7EoDKG
         efjRa6kTTZwRGZMvHjBNqdWd+MgnK8WZ1dEuECPfA+XIWPuJ5wzWaGHaSBSkCTv82Put
         NUguVO7a2Xwv3QZfej22iMaWvpBBSrBAGk25oajFa6TbRWfBwnYa2VWBftGD9S/dNYDH
         CeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092077; x=1776696877;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eJcPRN3ndueDSdYwxtdP8lEQ3v1K2ekmMZi16tT5qsI=;
        b=FiL3/xLolIqj0PCDQ3tLjauSOjmZctzOj8FC7s5uvhjNPgT212fKDDvgh6jGF5jkwj
         ujVLBQ71e5+5uaREOrYcSBu8ntlUoTR7tRIo4YUrbpgm/qCj0FLsszSPeL7Q1SyF7yTA
         AM6SF9IMy1hN3SIIIQe+MUbFxssKb9TQh0ii5Gg0j3CLNCqSOED+t57MI30EIIQ5g83S
         chEWQ0KejRAfZHx+SAV9/xy5h8b9ImcBI5ZqW/ASiiNY1Qvj0VhEWhNI04ksCI6tzm+5
         5Dn2oNfVHDfsmBqQR93cYKHJNua/M7nEglMzj6JJcXV6XXfcoJfso4XyaoMZJ1juObrL
         6vuw==
X-Forwarded-Encrypted: i=1; AFNElJ8jKx1h7U5AgBLRKz4sYdp/mS8D7fpuC1ppYfwG06Hi3kVivbkmDUIA1A9n4u5X7upA+Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffWyMwMBxyyfttR3p18Y9rUNgnpmF8jRpZNHPJ+tnyU/EKsQA
	9HZVDFp/VRprMMQPCXQBXaw10DajrliumZOG3MZ/mxOHZxge+GnexiRwKUbQnNyOlchUMb6s2ih
	q7vs+Ug==
X-Received: from pfmm8.prod.google.com ([2002:a05:6a00:2488:b0:82f:3774:4736])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e13:b0:82f:24e:6a50
 with SMTP id d2e1a72fcca58-82f0c26b7a9mr14410321b3a.10.1776092077368; Mon, 13
 Apr 2026 07:54:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 07:54:36 -0700
In-Reply-To: <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com> <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
Message-ID: <ad0DrDUsUKTMfrDW@google.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Chang Seok Bae <chang.seok.bae@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, Kai Huang wrote:
> On Thu, 2026-04-09 at 15:42 -0700, Sean Christopherson wrote:
> > -#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_REG_EXIT_INFO_1) | \
> > -				 BIT_ULL(VCPU_REG_EXIT_INFO_2) | \
> > -				 BIT_ULL(VCPU_REGS_RAX) | \
> > -				 BIT_ULL(VCPU_REGS_RBX) | \
> > -				 BIT_ULL(VCPU_REGS_RCX) | \
> > -				 BIT_ULL(VCPU_REGS_RDX) | \
> > -				 BIT_ULL(VCPU_REGS_RBP) | \
> > -				 BIT_ULL(VCPU_REGS_RSI) | \
> > -				 BIT_ULL(VCPU_REGS_RDI) | \
> > -				 BIT_ULL(VCPU_REGS_R8) | \
> > -				 BIT_ULL(VCPU_REGS_R9) | \
> > -				 BIT_ULL(VCPU_REGS_R10) | \
> > -				 BIT_ULL(VCPU_REGS_R11) | \
> > -				 BIT_ULL(VCPU_REGS_R12) | \
> > -				 BIT_ULL(VCPU_REGS_R13) | \
> > -				 BIT_ULL(VCPU_REGS_R14) | \
> > -				 BIT_ULL(VCPU_REGS_R15))
> > +#define TDX_REGS_AVAIL_SET	(BIT(VCPU_REG_EXIT_INFO_1) | \
> > +				 BIT(VCPU_REG_EXIT_INFO_2) | \
> > +				 BIT(VCPU_REGS_RAX) | \
> > +				 BIT(VCPU_REGS_RBX) | \
> > +				 BIT(VCPU_REGS_RCX) | \
> > +				 BIT(VCPU_REGS_RDX) | \
> > +				 BIT(VCPU_REGS_RBP) | \
> > +				 BIT(VCPU_REGS_RSI) | \
> > +				 BIT(VCPU_REGS_RDI) | \
> > +				 BIT(VCPU_REGS_R8) | \
> > +				 BIT(VCPU_REGS_R9) | \
> > +				 BIT(VCPU_REGS_R10) | \
> > +				 BIT(VCPU_REGS_R11) | \
> > +				 BIT(VCPU_REGS_R12) | \
> > +				 BIT(VCPU_REGS_R13) | \
> > +				 BIT(VCPU_REGS_R14) | \
> > +				 BIT(VCPU_REGS_R15))
> > =C2=A0
>=20
> Not related to this series, but this made me look into whether these
> registers are truly needed to be set as available for TDX.
>=20
> Firstly, all the listed registers are marked as available immediately aft=
er
> exiting from tdh_vp_enter(), but except VCPU_REG_EXIT_INFO_1 and
> VCPU_REG_EXIT_INFO_2 are immediately saved to the common 'struct vcpu_vt'=
,
> all other GPRs are not saved to vcpu->arch.regs[], which means marking GP=
Rs
> available immediately doesn't quite make sense.
>=20
> In fact, IIUC other than when the TD exits with TDVMCALL on which TD shar=
es
> couple of GPRs with KVM, KVM has no way to get TD's GPRs.  So perhaps it
> makes more sense is to mark the shared GPRs available upon TDVMCALL.
>=20
> But even that does not make sense from KVM's "GPR available" perspective,
> because TDVMCALL has a different ABI from KVM's existing infrastructure f=
or
> e.g., CPUID/MSR emulation.  E.g.,  KVM uses RCX/RAX/RDX for MSR emulation=
,
> but TDVMCALL<MSR.WRITE> uses R12 and R13 to convey MSR index/value:
>=20
>         case EXIT_REASON_MSR_WRITE:                =20
>                 kvm_rcx_write(vcpu, tdx->vp_enter_args.r12);        =20
>                 kvm_rax_write(vcpu, tdx->vp_enter_args.r13 & -1u);  =20
>                 kvm_rdx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
>=20
> So I think the most accurate way is to explicitly mark the relevant GPRs
> available for each type of TDVMCALL. I am not sure whether it's worth to =
do
> though, because AFAICT there's no real bug in the existing code, other th=
an
> "marking GPRs not in vcpu->arch.regs[] as available looks wrong".
>=20
> A less invasive way is to mark all possible GPRs that can be used in
> TDVMCALL emulation available once after TD exits.  AFAICT the KVM hyperca=
ll
> uses most GPRs (RAX/RBX/RCX/RDX/RSI) and all other TDVMCALLs only use a
> subset, so maybe we can remove other GPRs from the available list (the di=
ff
> in [*] passed my test of booting/destroying TD).
>=20
> Bug again, not sure whether it's worth doing.

Not worth doing.  Because VMX and SVM make all GRPs available immediately, =
except
for RSP, KVM ignores avail/dirty for GPRs.  I.e. "fixing" TDX will just shi=
ft the
"bugs" elsewhere.

More importantly, because the TDX-Module *requires* RCX (the GPR that holds=
 the
mask of registers to expose to the VMM) to be hidden on TDVMCALL, KVM *can'=
t*
do any kind of meaningful "available" tracking.  Versus sev_es_validate_vmg=
exit(),
which can at least sanity check that the registers needed to service a hype=
rcall
have valid data.

So unfortunately, since we need to rely on testing to verify KVM's implemen=
tation
no matter what, I don't think it'd be a net positive to overhaul KVM's hand=
ling
of GPRs to support SEV-ES+'s and TDX's "sometimes available" GPR set.
