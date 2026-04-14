Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF883E1CE2
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181746; cv=none; b=S7p7HJK6EULIcJQTTOsJ88EmNv+zvjDXhiI0q76Gfk4IHf9I7jUcL0xKxSgpmB0JikzMjQ21hKe3dk6Rq2Ok3jJ3ryXbEy0vTmqfwhHHkQsH0IHgBSX70akCGMLCgjkWlI+7SmdxGuC25cgI5Deif2KoF+zeHysl8znfB9Pdm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181746; c=relaxed/simple;
	bh=rxsydUejMarkrwk2AKdIKIxkz0zcXI9Bv6gWvm2199o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtG68660pTdR6KvY6AzS+ZHLCAhBN+EC13dSUmqVrXDHzlaubEEYveVFLGX8gMh9nlBdJl2AeLGV1YRCRvd6+vz93OGQPH9vcHJtC4bNX5GIhQOLC/rgnfS0JoOStjqenUtXBHXyhd+1wwkU4fpIb4em5XBdMI+5HcihF2W1Ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2M699qe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2M699qe"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso12513499a91.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776181745; x=1776786545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h84POdD1fK3F4sl6KYnP0DuC/1y1hwWZ8DgthysiBOo=;
        b=W2M699qep7UANJQXJWG4yM7ghYZqzTJH+Je/rSjFJpDF8V4hWWz/lAnZz1FpLOGTee
         FTwR6wrfAwXWSKnPbXKX9GQbo/B/w+MGcibQkrMFpUUaZ0tDS3qdSnTOYJkbxgFYcf6y
         3ukd4tlkLa1Tx0Mc3jpb1uFIOSIoj+BHM33/DGY5lqQKk2Hpf4WZZ73Mb7kg3uCHbmzU
         oGXbnonfKvfiO/Nl7ZCKG7Y3DFgKGOiF709uvoZ35/pGnldSJBt/3sFYyhU4E1EU/liw
         OPfV06zv28ag2O7UNNaGYdUgMDwirIdrwct9m3HbHvRKCWgNdiGAL2bq91HmqBvs/wdq
         XyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776181745; x=1776786545;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h84POdD1fK3F4sl6KYnP0DuC/1y1hwWZ8DgthysiBOo=;
        b=W3BEbzgr2O2jkFKi1ROxUUrLghhMTdhHHEPtGlBYzcYdRjBTX025voMaRfhT3oZ+w5
         nyLyL3T6w1D3is3ijsir6FZO22+INchpgynd4fabSMtQc8tn27p0BuagK5nobXeZZixY
         uWM+aHhIzd16CHj5sRhM27aeWRqAT4b2JzOYlpymkrhD2QW/QfzHtzxpozMkBrL1HH3q
         ySsZRNqUaLL7f2Oan2YzHKcBagngi0QGX9CjNhx22OGmtJ5PlbhdN8IZc28FGO2z3RBU
         i2FFevX+PjDBVrKh7UdUbqfX8HjTSEpckbV/NFVejIDO7Oj3eJDzairq3AQ6d6YY3rYA
         OLMw==
X-Forwarded-Encrypted: i=1; AFNElJ8w//6aehmcBy7INd88pkSFoWq4wu6LVSnb5dJDs7VbBc1l/mrnui09Q7Fw+QxCFnKF7io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLjmq8alj9HR7gzc0Ei7QXh2Nw2Az8VCeosz22P7RvyPkYJS+
	Fo77baEg/gMfD5QSnv90CxnQzDlTyTvFyCCahE6ukuirV15124VfmiCmml02dGLZpguDq885Reu
	0Cm2LYw==
X-Received: from pjsv9.prod.google.com ([2002:a17:90a:6349:b0:35c:101b:e59e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d410:b0:35f:b784:d3bf
 with SMTP id 98e67ed59e1d1-35fb784ddb9mr7468639a91.1.1776181744906; Tue, 14
 Apr 2026 08:49:04 -0700 (PDT)
Date: Tue, 14 Apr 2026 08:48:54 -0700
In-Reply-To: <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com> <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com> <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
Message-ID: <ad5h5hO7_QmJlOVk@google.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Chang Seok Bae <chang.seok.bae@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, Kai Huang wrote:
> On Mon, 2026-04-13 at 07:54 -0700, Sean Christopherson wrote:
> > More importantly, because the TDX-Module *requires* RCX (the GPR that h=
olds the
> > mask of registers to expose to the VMM) to be hidden on TDVMCALL, KVM *=
can't*
> > do any kind of meaningful "available" tracking. =C2=A0
> >=20
>=20
> Hmm I think RCX conveys the shared GPRs and VMM can read.  Per "Table 5.3=
23:
> TDH.VP.ENTER Output Operands Format #5 Definition: On TDCALL(TDG.VP.VMCAL=
L)
> Following a TD Entry":
>=20
>   RCX   ...
> 	Bit(s) Name         Description
>=20
> 	31:0   PARAMS_MASK  Value as passed into TDCALL(TDG.VP.VMCALL) by
> 			    the guest TD: indicates which part of the guest
> 			    TD GPR and XMM state is passed as-is to the
> VMM=C2=A0
> 			    and back. For details, see the description of
> 			    TDG.VP.VMCALL in 5.5.26.

The problem is that bit 1 in RCX is required to be '0'.  I.e. the guest *ca=
n't*
expose RCX to the VMM.  From the spec:

  15:0    GPR Mask Controls the transfer of GPR values:
  Bit 0:  RAX (must be 0)
  Bit 1:  RCX (must be 0)

And the code:

  api_error_type tdg_vp_vmcall(uint64_t controller_value)
  {
    api_error_type retval =3D TDX_OPERAND_INVALID;
    tdx_module_local_t* tdx_local_data_ptr =3D get_local_data();

    tdvmcall_control_t control =3D { .raw =3D controller_value };

    // Bits 0, 1 and 4 and 63:32 of RCX must be 0
    if (((control.gpr_select & (uint16_t)(BIT(0) | BIT(1) | BIT(4))) !=3D 0=
) ||  <=3D=3D=3D=3D sadness
         (control.reserved !=3D 0))
    {
        retval =3D api_error_with_operand_id(TDX_OPERAND_INVALID, OPERAND_I=
D_RCX);
        TDX_ERROR("Unsupported bits in GPR_SELECT field =3D 0x%x\n", contro=
l.gpr_select)
        goto EXIT_FAILURE;
    }

Oh, dagnabbit.  The spec also says:

  The value of RCX itself is always passed to the host VMM.

and then in code:

    td_exit_qual.gpr_select =3D control.gpr_select;
    td_exit_qual.xmm_select =3D control.xmm_select;

    tdx_local_data_ptr->vmm_regs.rcx =3D td_exit_qual.raw;

    // RAX is not copied, RCX filled above, start from RDX

I don't get why TDX requires bit 1 to be 0, but whatever.

So I was wrong, KVM can (and should!) validate the registers coming from th=
e
guest.  If we want to harden TDX, that's the obvious first step.
