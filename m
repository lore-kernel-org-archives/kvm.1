Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D31DF248
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179697; cv=pass; b=MeZZL4+3jcSKEsHEGN99eTUCGDRTP20eF5vUsMt4GXQL/KdHf82dGttbOgYGMsFzQSxBi0aKvrLXbCKDwhd+VQIv80II1x62sBrmle87GvdQj5tIbPgpJVWXjqQnhqvWEMhzrsU0U+6QK5Rfg3GfstcqnwarcQFpVr6r0sCIdsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179697; c=relaxed/simple;
	bh=S7u97F0mKuHEaXlleeG6ov/Y3VkqNsMCwMjqHsihwxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWjp1pd6BAjKEVaBkHx+Okn1M+gX+BPeiz4I4MgcIuSp6ujL1d0OwW4B3Qdu9k9TaV0SUcQeJWDdIsOMpInLNerf67dcQGbsR0MBoH22HLOQuG0kJwETzfgo2WhF7jQ20jS/ka9f0ysIiboK9a/NL96IFNz8nN7tTHHIs5ArUy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQ4WZRH/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQ4WZRH/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so61571cf.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179695; cv=none;
        d=google.com; s=arc-20260327;
        b=Uh3oPRrpmceJZFIo5JjwI4e9A4eQv9k42BQF5vsOVmAzfKViSs6pwLAEqo+9ZuhxWX
         6D4ggsAAgIRxStEQEmAbHjjuSIy3MhCrR5Mwk0CSvpYxG4w+9wdGhfbWk+WWBRilccEr
         A1Hr+9k5TjTRu8X7IGVsGS5UaW+6CRqG/tuOdVWyCE3Uj5Zs959EMLEAmQ63UYD/jlre
         pCwJeWHasG4dCPZ4lHJT3nIGjZY0w7bTe7uKN6KOEixz+e9wwpF7ToCwXJ4+kqTrefgK
         EcxRIo2iPoD5MEhEuleziLJKpCu/2A+uCX/om4MMWzBESAOME7PSnKtPv+ctXJL6tuJb
         70mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7I6WLMkKR2BgKIxGRcqSFhqIpV9v6f9mjoXxwWLiuPk=;
        fh=WFlLmmWDU+ybWkMF5PYAPG2AiuALf8zXitLFjihV+qs=;
        b=VaiXwG8bTxI5qu6m8TIdRmAAAFC5j0/NuSAkmLLl5BoPpAGhNx4M+4OzBayyyjI6Ck
         NAMuXyNtbM3ZyLxLYUqcFCA243PJNIuR2C2EBQI0n6NZZolKs30XgeybKVl+1DpBmntz
         1A0ubQZnMfcq6E0fq2KaiTfT+pOmkWjdWh7X3bfNUNzhIG+m+VQyWt5WAHuSD0+TnFK7
         KD27IKyb2seCgSVY9F6etzsKhi7ZmSi1BXZoJXz2x1uIW97vEQKXsEZfys+4XX3y41Rk
         +9Yy5H1eDVwjv3efaAqacyXKW194tKtpjBlkng2OCxnqlagpIaNiXdYKGGI1EsBEz3MD
         xlLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179695; x=1792784495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7I6WLMkKR2BgKIxGRcqSFhqIpV9v6f9mjoXxwWLiuPk=;
        b=oQ4WZRH/s4OlqMsSt1YCy+GDPxLQD8NKDV3kNsjiU4D/ngxoJmU5b6qr2TuhbHxLh3
         KQcR1ogam8OZBBoG3NNM+ABOG6d4HWcms3gs5NHs5NFgySsjLxheDPE75gNHKGefi1sp
         Jc7oudV06kCUrL5iLnrxgGBAtGU2YqfMHZb1NHGIsdCmvgFnkhccnQMheDDgMjeJvypI
         XvBz3aI/05Xdaf6d2pgrydkbSAhEs79Rl/oLVwM1qo7379T38fGoBKRwq2LUXtYrOR8G
         Zza/PUdosEaWkeX6C8JXb1FPddosj+2fQCTPz4MFkRfE9+pDcTJt8CY/RBCCAnhFF08g
         N2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179695; x=1792784495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7I6WLMkKR2BgKIxGRcqSFhqIpV9v6f9mjoXxwWLiuPk=;
        b=jf0fPmzbGwG3+8cDC+X+MuwLUi+h0xN+nqueUVkQ0REEuaSSusFjrRamD91gb5cwFm
         tpRWGoShAcTox0ymWhZ1i7R7Trx61qfDcIM+879uh1TorwFtksoTurfdUkTDBhtpCttu
         LVrtmvcPR8wy6jCsA4DH1u7CSyaXh6eFn4l72u8EfYzklna/c3D4F4FSHJ49ItYHruLF
         A2h/+yzraeow7ekh23KaawW7+rjrK5gKgWVsDxltB8QswNr5A6VaJnZEhh7EGnFss5hM
         kiJZh8aQWDzFB/OZxDhpfZT5PUSWZaC41JdW7w4yYkAFBV+3y73lebNqWmmpl9Ocsj4D
         Qugg==
X-Forwarded-Encrypted: i=1; AKwUvBxxjieWzx8bxE4vyaaAd32HgWtUuy5aCIOccEwj5rdAI1kTgSZ/wqz00XgYT/PASFB5eAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu2pvV4G3WKgJgOwNS4Ru9JqKHyFCtc1ddbJhIh0TP4501CV3e
	0qfiT88DRhie0RXvDZMlxtlr+5KsQhbzV7ejEI241BEfVO1iKrmZKJcObVN9MQNzjegqYqJhwzz
	PEaveJkSCAOfhZCeZj0ze/1VrbZ/e9B5etlSd1A7H
X-Gm-Gg: AYBFou1q7WvAONv7uelBup42tyoyeVFkewqsPvHVtcYEZgezboM+gTxrcdmO/RPBstq
	ogW6QilV0Gpb5YzCR3cFVxYO7Ckmlsnz9Z/yhtexhqeJd2maAWkYZqDuf0GMhvYBkCfBJe5HgIZ
	I7ubk8ZOSP8ZsbSPh2EvN/nSwBMBVOThoInBtCO1mx10ESyN7BUrB4Vlg5Xyig6Cpmqut2wkSI7
	ldlyHCETDLEPeh1qV5EOj3mI9LHiC2We4eNKOTNDA/uG/E8ENk9G7/hmKO0ofgdLF9Fhvb8fvJC
	rHBboN4ZHtm/ttjDNCftoQIpnzLaRaEDNVqVndvuFTiSIP/Bh8jiAI8=
X-Received: by 2002:ac8:5ace:0:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-53646227b1amr1807741cf.8.1792179694296; Fri, 16 Oct 2026
 12:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-25-yosry@kernel.org>
 <CALMp9eRb3ExsQ0g24YQyo85sV1fnHZadh33hBChUY=ZGUaT7jA@mail.gmail.com>
 <CAO9r8zMt5ZNwr3Y+NfFcAW5Cf4JaerCScSsLxcvsvHYR=DoYBw@mail.gmail.com> <atF1lByf9w3Pvzyt@google.com>
In-Reply-To: <atF1lByf9w3Pvzyt@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:41:20 -0700
X-Gm-Features: AclHuK_lmx3knEDpq2O9cX91zu7wMSJRiSiXRo3aJT1GBy87KnfcOtvuGmB_cxE
Message-ID: <CALMp9eQ0j9mpaRFgGSgSzbpLZJL3hmQEY9Ey2VEMuqST0uRTsg@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 15, 2026, Yosry Ahmed wrote:
> > On Thu, Oct 15, 2026 at 4:37=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > > index 8f2542357e78d..436d13f106369 100644
> > > > --- a/arch/x86/kvm/svm/svm.c
> > > > +++ b/arch/x86/kvm/svm/svm.c
> > > > @@ -2468,17 +2468,61 @@ static int clgi_interception(struct kvm_vcp=
u *vcpu)
> > > >
> > > >  static int invlpga_interception(struct kvm_vcpu *vcpu)
> > > >  {
> > > > +       struct vcpu_svm *svm =3D to_svm(vcpu);
> > > >         /* FIXME: Handle an address size prefix. */
> > > >         gva_t gva =3D kvm_rax_read(vcpu);
> > > >         u32 asid =3D kvm_ecx_read(vcpu);
> > > > +       int cpu;
> > > >
> > > >         if (nested_svm_check_permissions(vcpu))
> > > >                 return 1;
> > > >
> > > >         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> > > >
> > > > -       /* Let's treat INVLPGA the same as INVLPG (can be optimized=
!) */
> > > > -       kvm_mmu_invlpg(vcpu, gva);
> > > > +       /*
> > > > +        * INVLPG on a non-canonical address is a NOP according to =
the SDM,
> > > > +        * assume the same behavior from INVLPGA since the APM does=
n't specify.
> > > > +        */
> > > > +       if (is_noncanonical_invlpg_address(gva, vcpu))
> > > > +               return kvm_skip_emulated_instruction(vcpu);
> > >
> > > If L1 is in 32-bit mode with junk in RAX[63:32] (e.g. bits left over
> > > from long mode), the full 64-bit value may not be canonical. Should
> > > the kvm_rax_read(vcpu) above be kvm_register_read(vcpu,
> > > VCPU_REGS_RAX)?
> >
> > Doesn't kvm_rax_read() already use kvm_reg_mode_mask() as per
> > __BUILD_KVM_GPR_ACCESSORS()?
>
> Yes, Jim's probably thinking of older kernels before fc40b1254c32 ("KVM: =
x86: Add
> mode-aware versions of kvm_<reg>_{read,write}() helpers").

Doh! My bad.
