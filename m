Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325632E72F
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394490; cv=none; b=kbOkZA0iSFZdB9nDoiLf1lUmGqpfKevJbJ0e4k7fGTPuJU4KeufpheCqkN28UFsv1X8PpzB2n9q/rMkYuDapOd3kDzuVZ53ABZDr+l47xTU6oqCS7HWcCocOgr/f2U7XUS8Zx5l4Piy/Q2ibBesQShmhH6ANOkDF18u2bvzv2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394490; c=relaxed/simple;
	bh=MsTfG6JcbfCM2twbdG81+d65qpetG18xhuYgt0QOSZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tlXcr68ot/4bvmluJf6SZa0mZ35MTXNJof1xIQV2wHJvNuYDpggs9mTaSBGVjHB1BHq8C0JgX58QVu2t8sCtQo+zYXEkym8KBxUJqF2BYkaemy27x8F53coDvjbDQOQv+kUAH2o1ERyX7nLCQ9Pb9h9MwV4cm06F4Inx47oZfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiSmZwRp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiSmZwRp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2caf4173b1cso72794065ad.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783394488; x=1783999288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4DaDc3Kbo2F0+gLPnDRRq0qCXtYzK1Rw09RDMbRFeLA=;
        b=AiSmZwRpyPBGA9KqjJYnT6BVrfgWrRalY4bApqNEipU1ODWb/PjrWQ4/XAZpanQxGu
         jbd6Qd26OeSK6TbYxe3z7kJ8NtehdbnAbQ8Qg7WsM2NXMgMCHgnqgk2EeF19R1ITeR5q
         nt8VjRtwwTOpQlAIB5w0AfTA2wtUl3yB1dVEXWuDhcN/UiNRen//fZfxvMfrbKXfZzqX
         pvmK+OMqTJ9B0sRYLNFrz41uRwUsVskW3016cQtaENx+P8qyuiBwaAu27zuom1+V6+SD
         TQWLpKg1Vd/SoGHPSpt8IIxK4GiJVH9y7TsTEAM6doiRzjlWTPdfcpj1d0/2vRlI2eyr
         sC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783394488; x=1783999288;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DaDc3Kbo2F0+gLPnDRRq0qCXtYzK1Rw09RDMbRFeLA=;
        b=XncEB3g3V86680XkbvmqMAAC4xYri2Zf+4PwRaFzsDnI/iDcfqmcNjKGixjCtRTFBk
         lVDkY6qRj8uz61HRWT1fbrvq/xYCyJCgP4S/UxT32t/uv4gXeoctzxaf7Hr6su2uEol7
         w3bisJ+xvQ2aPpTKR6SUGAHJZH0yN0l193+CdiSGwPIu5lmvaAbLlsC1Sgpu7/ZnkU7N
         w0nyYtdBeqB2IwBbHuXXLcxgDFkunZTlx3fQ/DjgEbZlrsiP28q+ctlfI4+VlpH5g8e/
         4EBp73oP8FLaZukXmnalK+25HmU9g3qHKwG0OUl53aN268kUAli6L5a1NhwpJuyCjTUI
         FqjA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ3c6HsAvfrGyWRsFRg8tlHJfKnO38YBb8S7VyAZ7CA8HG0DRPm5dXcW3udlLZAir+0L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvr6xCs2z9EOyWUkhfZSOy0FZR/pefM+sUnOMstDYKixf8Q2h1
	Fp2g8mIK80SjEPCYz8frJRnl3O7cBy0O7aaoSdaCwu64RYYtITKW8TXOk6+NgpJi0iEV0jO9cMW
	sPGVs5g==
X-Received: from plq4.prod.google.com ([2002:a17:903:2f84:b0:2cc:73ae:7d4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:2ca:ca48:c380
 with SMTP id d9443c01a7336-2ccbf1ace49mr32602895ad.47.1783394487964; Mon, 06
 Jul 2026 20:21:27 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:21:27 -0700
In-Reply-To: <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net>
Message-ID: <akxwt1mX6blSnkxI@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Jim Mattson <jmattson@google.com>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Tina Zhang wrote:
>=20
>=20
> On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco=
.net> wrote:
> >=20
> > > I will take another look for the next version and try to handle the
> > > remaining pieces properly, while also making sure we don't expose sta=
le
> > > or incorrectly synthesized decode-assist state for emulated exits.
> >=20
> > Naples erratum 1096 seems to imply that the instruction bytes stored
> > in the VMCB are not necessarily the same instruction bytes that were
> > fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> > emulation, it might be sufficient to read the instruction bytes quite
> > late in nested_svm_vmexit(). That would certainly simplify the
> > plumbing.

The plumbing doesn't seem all that complex though.

> Thanks for the suggestion, and for pointing me at Naples erratum 1096. I
> wasn't aware of that erratum.
>=20
> My understanding is that late fetching/decoding from guest RIP is not
> strictly equivalent to preserving the exact bytes observed by the origina=
l
> decoder, as the code bytes or translations could theoretically change in
> between. But the suggested workaround for erratum 1096 also tells the
> hypervisor to decode the instruction at the instruction pointer when
> GuestInstrBytes cannot be used, so it seems that this is an acceptable
> model/fallback.
>=20
> For KVM-synthesized/emulated #PF/#NPF nested VM-Exits there is no fresh
> hardware GuestInstrBytes state to propagate to VMCB12. So I agree that it
> should be simpler to avoid plumbing instruction bytes from the emulator, =
and
> instead fetch the bytes late when constructing the nested VM-Exit for L1.
>=20
> I'll try this direction first.

I'd rather not, at least not as the primary way.  It's going to raise a dif=
ferent
set of issues, e.g. how to behave if reading guest memory fails.  That's pr=
obably
unavoidable, e.g. if reading the INVPCID descriptor fails, then KVM doesn't=
 even
have a pre-decoded instruction to work with, but it should ideally be a las=
t
resort.

E.g. where the NULL case triggers an on-demand read of guest memory.

diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
index ba985a02208a..812af3a8d8b9 100644
--- arch/x86/kvm/svm/nested.c
+++ arch/x86/kvm/svm/nested.c
@@ -42,6 +42,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *v=
cpu,
        struct vcpu_svm *svm =3D to_svm(vcpu);
        struct vmcb *vmcb =3D svm->vmcb;
        u64 fault_stage;
+       u8 *insn_bytes;
=20
        /*
         * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
@@ -68,7 +69,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *=
vcpu,
                                    (fault->error_code & ~PFERR_GUEST_FAULT=
_STAGE_MASK);
        vmcb->control.exit_info_2 =3D fault->address;
=20
-       nested_svm_vmexit(svm);
+       if (from_hardware)
+               insn_bytes =3D svm->nested.vmcb02.ptr->control.insn_bytes;
+       else if (vcpu->arch.emulate_ctxt->eip =3D=3D kvm_rip_read(vcpu))
+               insn_bytes =3D vcpu->arch.emulate_ctxt->fetch.data
+       else
+               insn_bytes =3D NULL;
+
+       nested_svm_vmexit(svm, insn_bytes);
 }
=20
 static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
