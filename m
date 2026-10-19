Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792452385;
	b=i6dQWGh3A4/E4hy+2DBH/23PRHG3E0lN1rK8yy8o1uV7fXgoMpgmExQ0ugBhEcL80YHK
	 alx2FpHt85NvzBQk+mFwU02zhxxOsud5+eLiAIQEHaLOoAu1wPMUtmqe9dnZl0HvjBQ5L
	 /dEYWpkpqnyApGPxY353wLUYgY5KV9ZNAEKetDVkB+Aac1i0icRGh5Ubof10q/KEHt7q5
	 pn/Zgfa5OMWfVKzAvOVp/UtgGZjkecolMcxA10DiXhC6p+HA8EZak1vToT2o84Txa+I2f
	 CXWnhO7kNHxXOG4q/nRF6d5OrSXMR6f6CIJsRs/PvWHUZV02SW6HhvruANxefAlYfcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CLC3zjnxIjKArH1FQcGvSs3bjt/7iKdfVzrRyl7zBcY=;
	b=rzxDfNj7GTbYyLhANXmY7CAKI7bK5zR7P13wUmIlArdMer2sgCW91r+2HEUeMwLj6O2u
	 cvZuZTIJyy8OsmIx3CajgAenl57c+qkN4qByiaHFNbphIZgXkc3CFsJE/HRrkIkQjS/JU
	 g+Dil+kE0JfG17lYx1wtSbZXyx48d7WDJFqzwIrkMexLWOs7+w6yS9dFDnmcY73y2K9rb
	 PYkHcfFkL3T/+fIFyXH6LyZ9Vo7lE9vz/DibspOWDSy7oSAqXtYVAzNPU6gpE/pytsWCM
	 ZpTCR3Z3o1lp13ZpEXYLVjIti8usn5xCBvRCKlaQ4Nz9Iycan/4/W0oI0KAGwQJlegg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="KfOw2Bp/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084A606A319
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 23:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2084A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KfOw2Bp/
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2544a12.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792452383; cv=none;
        d=google.com; s=arc-20260327;
        b=UldX/XhGUtC8TgcnJPxy2vK6VSUSp+paDEwzFJppx990wuEnxgBidA5I5A2vErs6Y2
         ROndwp7168yRIc6X1uGySSgbdSv/FIW05HWL85/vD9/7drFG2QCgDJqXV6HbWOxctDCs
         7HEEJWeoKfAOm6Zk3r/Z3QQFLGTf2YScN1tPd/+fnAJ7Cb/sOAzEjfa3m74Gi00Bbq5/
         MSlJpX+j9U2AGlAqYl10NaW56fCrzSLxhxA4Fkr50SJMKPx+97Qt3fBuo7qIbtgkt2ig
         fjFw3371Iq1tBXLRSNeSdKqKjKkYzf4kFfWKIZVTpq1kWcJnrmOZGZC5LGATTsh+lrYg
         fJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLC3zjnxIjKArH1FQcGvSs3bjt/7iKdfVzrRyl7zBcY=;
        fh=j9+BzdkehH8aUtF+0uHUNpt3UUrfZnZMT9jT7hWpVYc=;
        b=KKviftQAcULRDh87xvNKwcfZe3CoB2QuTku5IoQpb/gJv2LtUCExTvcLS/xZ+JTapo
         doJeY+cuImlxDUG0M/JtHACveUZBojZ3sfhZ3QLexSp84Bb8yGbkNWBaLb07M/Xk/Y6A
         DMRTKnxWxjprGoaRnyl3/ZlDKsp58lGkXciuLNkGbrMmQ4d3iA1yP/zIT1pgPrLVd3OV
         lWJcmEFQIJTQbPkVUDhiPzey1s1UHu/UqcPjCZf3fG0bUv9y/J4+KNMcKCSG5moPJ+SX
         rrkAYzG/vLGmr7IYeYcfm6vqDLMNX1Vvb1n06ntD8SY+0MykK4bcPvuw6fQIu5VW71HI
         FTsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792452383; x=1793057183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLC3zjnxIjKArH1FQcGvSs3bjt/7iKdfVzrRyl7zBcY=;
        b=KfOw2Bp/ckflu3yP//2FjjIVuRufE//wgFl7r2i3ijRfRuhds/q10dt9MswPLuNvru
         K+58IaR3Aaw8Dcd9HRxErhuj1c5DVPsKwi0AUow32IID+2xQSFGdZzElK/T8HhQJ0lBW
         BldR1xqfF/ukP1iXCaIyIUI1HDYiky88R9jWgkZ42turnV3p5ZwAb9fuBI0cjAC/Eue9
         1RJG2uTGndtWLiOktka72gsZ4e2clM252K8Oi9/CvT14+hfp/EOGwgeYuyUaPdPPHD1C
         aPT3JNQvzHyTyKmyNyClPHzeh4p+gU/uauiNp7xQ2QwfS1BOt1GtLkGlfRqPZxCx1KOx
         qXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792452383; x=1793057183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLC3zjnxIjKArH1FQcGvSs3bjt/7iKdfVzrRyl7zBcY=;
        b=lht/79LqFk1UINeWqUfR2sce3baGTH7w6P911ZdIX+ZltsuxNKg6kA+xCrdqz+Nvt3
         h2pWaO7mS0fLeCp/lgXIAg3Pl2hihwBbPq4Mgawfesqra3umfgxhayYYBLAU6uMBga0X
         hL1/DQJwjBdN2xe0NiTDzIoLxy5bTKZ6DBrpgO9kzrU4oFSKR6Ne+LXmKs3++TvnAfRU
         rePk+WDbef1wStUr+zwDn4dHN6OX0D9f2P/d3ioOX2/5V2hue2QxQKNQL2I/u9PUxGzj
         lbVMNv6HADD0mH7BNPePHtNXS5EMu6h4f1x2SGfhysVYOdoEB96FIm81PAk89Hh5MoiK
         LzXA==
X-Forwarded-Encrypted: i=1; AKwUvBz57VNo/BUWnbeqbpYFXYm3Kjo9T3G6DPBkGhGarGxn9O89cqTbkVqF8xelOZZcyhzDE90=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlf1ZKa2cg5DOkxtdKUKQsly7z8TEFs1Oes6k2Y0Ankz6fnDef
	oXh68gOumhl76MrRLBYB6ANQdE7qtr0VmX14e0pVei72RXxNQfTJHcWNxCkLzxYMGIMqwshlDw8
	R2p+TS3vD9TL7x/W3VJPgK/viDGYMkxOfA3yz7SiD
X-Gm-Gg: AYBFou1EJAe+zyFTJxqQJ4SCsDlNTDUZI/wUG3glEJRWpTsHtsrN0uWl76MgjgV/TzL
	b+sKIWt3XqKViH5pZHAZvDPfCDQhmzg7OpxHRTxNIHA/5avbbmbnlMgiTU1Jf9BQOmNJm1P3EwA
	C3EFwO1gh4pASohOoY+gowJQvFSbfuOxpRu37vfWSljYr067AxGKdfyGeEmvrnY87J6q6WFtQBX
	bBYCQkRzaO56p50JozTHPCaK/qm25z3GpydLLG/AXiLM3IKSYYaG7k92r1D53pRXBqHhe41rk8u
	UHdUGlN/6gSlYv0mJ5RZC9y4BrAfVUU0nL4g7Mhh/4O1cCNHngoEmXwbOEHzj0yiV1ZkFm5NR/T
	t2VBaCVOuNCJwrhmNvNBkz3Sm6fRRc78V4NR1
X-Received: by 2002:a05:6402:5286:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b3e7032ba3mr19962a12.7.1792452383122; Mon, 19 Oct 2026
 16:26:23 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-4-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-4-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 19 Oct 2026 16:26:11 -0700
X-Gm-Features: AclHuK8oRMv7kqF_KPOsMxBijtohUAtErtLXfKrtkvZWID5tE48bkobhU1O1LAM
Message-ID: <CALMp9eSS8W0CQF4pVJmo_fcKzA19pfK6et+i3cVDLNcA2M5Esw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] KVM: SVM: Emulate guest accesses to LBRv2 MSRs
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Back the LBRv2 MSRs with their VMCB save-area fields in
> svm_{get,set}_msr(). This is required when guest accesses to these
> MSRs are intercepted. This allows the guest to retain the values
> of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.
>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>
> Changes in v2:
> * Use KVM_BUG_ON() in svm_vmcb_lbrv2() for an out-of-range LBR stack
>   index, and then use entry 0.
> * Do not mark the VMCB dirty on writes to the LBRv2 MSRs since VMCB clean
>   bit for LBR doesn't cover the LBRv2 state.
>
> ---
>  arch/x86/include/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/svm.c     | 69 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.h     |  3 ++
>  3 files changed, 74 insertions(+)
>

[ ... ]

> +static u64 *svm_vmcb_lbrv2(struct vcpu_svm *svm, u32 msr)
> +{
> +       u32 offset =3D msr - MSR_AMD_SAMP_BR_FROM;
> +       u32 idx =3D offset >> 1;
> +
> +       if (KVM_BUG_ON(idx >=3D SVM_LBR_V2_STACK_SIZE, svm->vcpu.kvm))
> +               idx =3D 0;

This guard isn't Spectre V1 safe. Use array_index_nospec().

> +
> +       if (offset & 1)
> +               return &svm->vmcb->save.lbr[idx].lbr_stack_to;
> +       return &svm->vmcb->save.lbr[idx].lbr_stack_from;
> +}
> +

[ ... ]

>                 *svm_vmcb_lbr(svm, ecx) =3D data;
>                 vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>                 break;
> +       /*
> +        * No VMCB clean bit covers the LBRv2 state, i.e. the CPU never s=
kips
> +        * loading it on VMRUN, so there's no need to mark the VMCB dirty=
.
> +        */
> +       case MSR_AMD_DBG_EXTN_CFG:
> +               if (!svm_lbrv2_supported(vcpu))
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +
> +               if (data & DBG_EXTN_CFG_RESERVED_BITS)
> +                       return 1;
> +
> +               if (svm->vmcb->save.dbg_extn_cfg =3D=3D data)
> +                       break;
> +
> +               svm->vmcb->save.dbg_extn_cfg =3D data;
> +               svm_update_lbrv(vcpu);
> +               break;
> +       case MSR_AMD64_LBR_SELECT:
> +               if (!svm_lbrv2_supported(vcpu))
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +
> +               if (data & LBR_SELECT_RESERVED_BITS)
> +                       return 1;

Hardware doesn't raise #GP. It masks the reserved bits off.

> +
> +               if (svm->vmcb->save.lbr_select =3D=3D data)
> +                       break;
> +
> +               svm->vmcb->save.lbr_select =3D data;
> +               break;
> +       case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:

What if the guest CPUID.0x80000022:EBX[9:4] declares fewer than 16 LBRs?

> +               if (!svm_lbrv2_supported(vcpu))
> +                       return KVM_MSR_RET_UNSUPPORTED;
> +
> +               *svm_vmcb_lbrv2(svm, ecx) =3D data;

Hardware does some funky things with high bits that should (a) be
documented, and (b) be modeled here.

On a Genoa host, I found:

- For FROM MSRs, bits 62:58 always read back as sign-extension of bit
57, but bit 63 reads back as stored.
- For TO MSRs, bits 60:58 always read back as sign-extension of bit
57, but bits 63:61 read back as stored.
