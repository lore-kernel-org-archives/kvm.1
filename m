Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3A20DD51
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563243; cv=pass; b=Ptnt+Uf+2kac5pkaqybhh3zywH1zyndaRyBuv9gcZF0mTaQf+YgUnzsvJI2APODq9nDsFkx0hvkZqnFiRTYumbyytRwOUFqUj11qE1mU8ofPFuCBECxvE/Wgx2bIpxysvfThoe4ql7x5B0/VZSLD627tMHIh9BFGqgOSvlaKwlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563243; c=relaxed/simple;
	bh=gb4dOZ2ww7j3/A+6+TU83/q7vS18PQ0rzYZIjQp5d48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGkEVx5jyaWEnNqZx6QxVf5r9xpK9vddEv5zCO74p8VmBAenTAD7MYQiamc/Tnsj8XR5Mx4OOrN510aLjectZ6HTpPHVsvRcwNuBs2kKualjlqOVLPGfU1i4Mu/tW/YHWkbFNLADEWrU1QhIFZ8y779aPluoab/QCNjetGmMdbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+Mm4LUy; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+Mm4LUy"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so2173a12.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 16:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788563239; cv=none;
        d=google.com; s=arc-20260327;
        b=GTvtq8h+/VbzPZC6b0MYCj1KLEKBwEY3NVYpq8u6Czg4si4HFfyOGaIVYp0RgakSTM
         7XFjaNOFlTumgP8T5Za1m4wDMxPghORnk2NLay4ow7jXHWbE6QFIFTXF/cSVFl0uhL/k
         yRz3od0q95LP8eE0cJ1dWq1eMWF4fun6Zylc2aSAGOGDnqWAHuz80iOcFO7EnOy+zdMM
         EDWGEqhrvOyZHUY0EDvJSc08MLoQ16DwqgEYl+gKuoqlh278xV7reWrEqDCqNhDzasaA
         OBlMoOZz/EOfpTUWj7DHYNbEPeMxjOde4tfZj3XYVVn7VaU1GPL4PAGNre5/Ocrj1+Su
         zSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6zIiOUhrTcb0uUWQ8IotYmhxf+N+MfQ3oz9P1c3HMU=;
        fh=KJk6LktSIohoIyT8tEbG8SjiDfy2aiCJwnw2O2zcGIU=;
        b=OwuEdr85m0u93TNso5KuFJDZ2exmy2sBUcUVbKJnPQpee694BEl4azQ3X/QrGVyxBI
         WkBr1efEdRG+onRsVuDCYP8KtPm95sdIsQ689SiIXP8f8AMPzmVzVpXwflUBBKTA5o64
         E8UbhlnFgxmsGRSiCnNUx/cFQq1LSQo7eseGZOI5+d3qv2anzOLX+5oCSzqZ60jwYumY
         iXHdCuNCIzWKgJ2uFWg7St0ZCA1CfD0NnxJJd4+9Q0ZMJWIFaSHVEjsl+iYe9lc+Cd6N
         Vonvc6x4uznvabAXgcYV2hdq3E6KdiWQGhqdqW40G2pocPARtdV0/3JCd3qs9hECy8N6
         NZeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788563239; x=1789168039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6zIiOUhrTcb0uUWQ8IotYmhxf+N+MfQ3oz9P1c3HMU=;
        b=c+Mm4LUy6CQfMa6+qhM4yfbVh1vMpIvUyh2B2j+e69FRqYw3Ov5mzgNtu1GXPZEntP
         kMTxC3cWeGGQqL/i3eplHjKRxsXvAW8izmZl1o5JclnxB5Utk01bOVDW2Mg7ofN+vhhl
         wI/Ge93armEP8pAWxKTBcSbmcr1FTAxLMHoxjcK4Jx2v4yOFGqePGjRBMIZYHXex9bfo
         erXeJPKyV5fMhSg/NnKGWj6AFBWy8Z7NTa75p6owNJBAsJL9TFDGXIgVNHjjq0k7k0h5
         t7rrZLOkSvlRmISH3qR37L5xBb4RgwWkQNV20z4i+dg79OWa3T/qsqxrXsZlYMDsav8Z
         R8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788563239; x=1789168039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6zIiOUhrTcb0uUWQ8IotYmhxf+N+MfQ3oz9P1c3HMU=;
        b=oWe3uX6LnSPqHSs2Kp3pb9WiYoT5NUuG+kwz3/NMr9muX2b9ISjJaWV9Y1Q4OMoLli
         lmiz0vtg5qd6ZCmjsuiYKX6P/pWNSajdL73HSlG6Ej2gNFLcF2gqPBpldjtCsEs7Gjox
         g7A+1BBVpOUrXHw3jYzU527ybq4sg8Qyak7EpTch+DOqNgib5gqw8PhG7BELVGLKy6Mj
         UJa8SmjQC1MMveUOnZWDeD2EqBs7/rhUO/FV8dCPRVmjGWvJ17+RANox7q0+FHgZ3oXs
         Fme1CkMBRhXa+WJPvYhjMWCdTG42I9Ua/wvyxato8SGT6Vfd++5Tqj4m67xTqX1XtUti
         +dlA==
X-Forwarded-Encrypted: i=1; AKwUvBzowdDQnZ4VUg2G0ycYuzWx3eL4glHxM5YhBM1FmuNuAvsruA9/ZmjU4cddQCoippA+rvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ko3TzXdOi2Wlh4HQe1YsEpmI3+xcniPrnSHgKP5CwvKUgXwj5J
	5vwrG/JrxxrYnORw4ZOk9xoPiw2bXtICTXmSB9nGrYe/PiIyGojd7bctcjomrhqlGo2frCVWXNr
	RjfgfigYdSldE8KJJ8s/u8wu+2uRGctz1G1Ild4xR
X-Gm-Gg: AYBFou3hPIjrHNcD7CgAmBI8IKcZVzWcNpXC5gVXmmAzZyoTP1a34tbnkRMswzeMx1b
	RVCz+vCFJ48Cvt6+OqM2m3xz+K4RSt8JSvbzKNwgn4Ej9g2FP27Ox6oeCyMzJn8dVb/9sYZV685
	8Ns6oTveyUsLaF5l4cMbX+T+ZMqkUzdJ5c5S5ELFzHn6LopUkKRzyQGrs1AOgaWFnkI71z0n+gN
	nvcAxXRZD9JsC5j9d5y/3p7uueTQUBHT17y1eOmbFOhTbshfsKJXdB1VWea6ODu40dZRggAUwOl
	C6wR5HSPC5mZOnJc30SslYBfo5MMAeiBYPi+Ef1w1MUo
X-Received: by 2002:a05:6402:311c:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-6a7f687b853mr12119a12.7.1788563238383; Fri, 04 Sep 2026
 16:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net> <20260824123954.315112-3-zhang_wei@open-hieco.net>
In-Reply-To: <20260824123954.315112-3-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 4 Sep 2026 16:07:06 -0700
X-Gm-Features: AcwNN1W1tvX6VzRjnC7l8gz4hxgqZGETgcAZJsyQxtEsA1mVWr9eN5JoJOp6QQk
Message-ID: <CALMp9eSmrHdLpOi9-xQvcRUxyVN-8CG2MKWnxKfXFaBBDztzNg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> When the x86 emulator encounters an instruction intercepted by L1,
> svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
> DecodeAssist state.  Populate the architectural EXITINFO fields when
> DecodeAssists is exposed to L1.
>
> Generate EXITINFO1 with the GPR number for MOV CR/DR, the interrupt vecto=
r
> for INTn, and the linear address for INVLPG.  Set EXITINFO1 to zero for
> CLTS, LMSW, SMSW, and INVLPGA; the INVLPGA address remains in guest rAX.
> Clear EXITINFO2 for all covered intercepts and leave unrelated intercepts
> unchanged.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9d607b98bd06..c7c1f1527c3c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4810,6 +4810,52 @@ static const struct __x86_intercept {
>  #undef POST_EX
>  #undef POST_MEM
>
> +static void svm_prepare_decode_assist_exit_info(struct kvm_vcpu *vcpu,
> +                                               const struct x86_instruct=
ion_info *info)
> +{
> +       struct vmcb *vmcb =3D to_svm(vcpu)->vmcb;
> +       u64 exit_info_1;
> +
> +       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
> +               return;
> +
> +       switch (info->intercept) {
> +       case x86_intercept_cr_read:
> +       case x86_intercept_cr_write:
> +               /* MOV CRx: bit 63 set, GPR number in bits 3:0. */
> +               exit_info_1 =3D BIT_ULL(63) | (info->modrm_rm & 0xf);
> +               break;
> +       case x86_intercept_clts:
> +       case x86_intercept_lmsw:
> +       case x86_intercept_smsw:
> +               /* CLTS/LMSW/SMSW: no decode information, bit 63 clear. *=
/
> +               exit_info_1 =3D 0;
> +               break;
> +       case x86_intercept_dr_read:
> +       case x86_intercept_dr_write:
> +               /* MOV DRx: GPR number in bits 3:0. */
> +               exit_info_1 =3D info->modrm_rm & 0xf;
> +               break;
> +       case x86_intercept_intn:
> +               /* INTn: software interrupt number in bits 7:0. */
> +               exit_info_1 =3D info->src_val & 0xff;
> +               break;
> +       case x86_intercept_invlpg:
> +               /* INVLPG: linear address of the target page. */
> +               exit_info_1 =3D info->intercept_linear_addr;
> +               break;
> +       case x86_intercept_invlpga:
> +               /* INVLPGA: the address remains available in guest rAX. *=
/
> +               exit_info_1 =3D 0;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       vmcb->control.exit_info_1 =3D exit_info_1;
> +       vmcb->control.exit_info_2 =3D 0;
> +}

Can this entire function be integrated into the existing switch
statement in svm_check_intercept()?

And, if !guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS), should
exit_info_1 be cleared for these intercepts?

>  static int svm_check_intercept(struct kvm_vcpu *vcpu,
>                                struct x86_instruction_info *info,
>                                enum x86_intercept_stage stage,
> @@ -4931,6 +4977,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcp=
u,
>                 break;
>         }
>
> +       svm_prepare_decode_assist_exit_info(vcpu, info);
> +
>         /* TODO: Advertise NRIPS to guest hypervisor unconditionally */
>         if (static_cpu_has(X86_FEATURE_NRIPS))
>                 vmcb->control.next_rip  =3D info->next_rip;
> --
> 2.43.7
>
