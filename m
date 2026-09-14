Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5738DC6B
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412396; cv=pass; b=AOd8dl4hUjewoxZVb93M2iBe5+cmiI9OEZNHE9zGe9Ov2Pq1jA1kPKt94XSjrHtpwQZqJVkfdK8VIYddBXenx86YZ64m/W+9KDKsXH828dOa9ip1+5rEUiqRB8fhMzz1nR8WN+b2x1m/7RxoDPCE+hDm/sG91bI+FuVI90V4utA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412396; c=relaxed/simple;
	bh=NhbjBxjZC9QaqhJh1oSQvVf3rlrk3ZYiHUcnxcsGtM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm/KOP5ojLWotfPxe69o6MCFG2ACVB2XD9CugXEaFemi9tTvztBBYF0fj5uodbnFvT98JJ3CfRdPlbEvbvGJ2IepWm931/igdCM9HAsitMpGWUjbY1SRRRFZkU39iHBMRkqp5ElQLFHF6lsftn5HTbAU60rn5EqM17f47WPm9Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1TW4fJE; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1TW4fJE"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so454111cf.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789412392; cv=none;
        d=google.com; s=arc-20260327;
        b=UDvFxDzqpYvMSEZijQy2R/MbIIBcxatxHeDvIkIoUXNFmWTw3dzDC7ONiUkA0IQOxA
         vWHQ4TgNu9qLcEXm3XEPazhNt+eUnuoTTQzvnWp2oXSEvvRcIiPsmCSMGoXmOSEsbgaL
         HN1RxuXM4cYSCOmOEFPSkVNgn2EY/RwxJg0paOUsYgnJzE7k9jQclAgw3w8UCM3pmKQe
         WO+L98Ltrlv0Z1s1rbFuA4HHEYaF+6mCmCYz7kdaSSxfAQcasYQ0sgLDDk9AkH52KAwt
         zBZFmmLp1vHmdYaq2Q4KWKO54xEjE3EB+am2v3R+q2iSeQF28kZUHPIjn7TelSLBeEUC
         Tt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MXbtIxiTnl0yl3kL8iSegb1NJaJ65aO3IifGdRU9GVg=;
        fh=jenQLWXW3aoiMnrvH4ux16m5khM1CPNBy6BOlom/zz0=;
        b=rugv7n1tV51GYzOAIScbnN7K+JoRy8FY3sM0sR+d5urww8Hm80YABqsU9cTCg0fL+8
         BovnS1n6JwKJHdNDVsMAhgHu8hYv7xmG1e9XucS0eQiOKVWFhHKQOFy+UvuaPmRta/8t
         DPJGznXJYPzkR8vSnTSMfzD3B/0gS7A1/oFtKageM4hpBQ0Dzqd1V9U8tTK6f0NLFbNk
         nvRpkfj19H3sgqqYEX2uOUQQSBccIkRXdtWFWDe1UUE03b+QqNmmcrRvMJYS25G9G9ec
         m+ggobpEk9ov4BThhZN+ahyF0TpKblZTnoG1Jr1YXF9ZqLjP9CBS66VkYHW/RPh99S1F
         2Y4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789412392; x=1790017192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MXbtIxiTnl0yl3kL8iSegb1NJaJ65aO3IifGdRU9GVg=;
        b=M1TW4fJEAJrPGDk8d7UWtlra4MHWA6oBITL7jbkAMqOfllWA5yBxUbEikRE/HsxfYL
         AEGWXpApRu/EWbXTY63y3Ep3M80NjsyfGNqUvAKY2RSKaL1yp4P/Zm6dsVdDzaiVbw30
         SX+eS6xUownioV1D3YzlPM9MYTu7jfqAmo2NJR82Wud0jwczZyNotOPjEGsZr1RxXm3y
         +DTIHw1oByF2WavsyCUjM5Q0yyB4GBvOEPbyAIyVJiNb3PsLpLwSv/sHet0xChf4YBzX
         bl34x8fAyqfNjxVjT0Bgm2Dz15A6s5paaTbbXQHflX9RH7xCrX8TC/986QcBDxVyM9Tl
         betA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412392; x=1790017192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXbtIxiTnl0yl3kL8iSegb1NJaJ65aO3IifGdRU9GVg=;
        b=go7o+sCtypJIklTEb60R3g5I9aCn+5YSxw19cmo5cWTw/inh7r0LEjZbQvK45++EV7
         kvsVu5PWibwrELrN8mbGs/NzVPtS4vFroLCBLwvijGuWhVMAZHWsSx3N2rxBEDafZwd8
         SkRBW70xOD11D4DrlY8AV3AcNWa3c3lwbXgh6lnM5OhklYCJGbUuMbQZE3d4k5XwvnLx
         o1vyjvO4nymLim6QkA5wGj045T5A6Ks+QY54gOR5kELO/ghyQ8VohM3XLLawZtpRHJVm
         GGiJpdsdHX1Ey39h8L55ewYwaebu3qcr9vPH93RL7HEFjNWEVRWZgYAMJqNKWAGChtl8
         gIIw==
X-Forwarded-Encrypted: i=1; AKwUvByf7v35EMFxlIZQ9gesejbnWUJV8wK1IgqZmsu2gYiYReJvhEJiAFbB0QJUF6aw1uAq4iI=@vger.kernel.org
X-Gm-Message-State: AFuF++lfi1V73idWi7rN0m0888lgmytpW1daikGtYX4S6RbawcEvsHzP
	am6cpjwO6H10dP2f+ku/fQDUIMLAB2F3w0gxx9zliGZW2MqOL4svtq6eMRXWOHsD2J8rXQwahWu
	ryGOAZSFtbPBd/6pnk9XrL1/tS9YSiSt8zr4ZZB82
X-Gm-Gg: AYBFou34EKygwenEha1EQx281TO/IEuU6kdq3aJymLGTWQXLlTEW0sWoYKffADjBtU/
	8O7+3f/u7ZaWP+EwFlmnMm7e8BI2D3uZHiM4AsfZq0fyq6b9bn2HtM5KDHFq7ToqPVsLYiY5lnm
	VYTVK26PnHTqYRjqjOWqnQOz64O96od8T8Iz8gr8i5JcFyjZEP0yNpcljuhTta43Ypl4LocVxHb
	wWbqOOXi+FcvT/FJ7h4YVBvA3R/AYGli2/C+QRbCU51QSGgP7Q0IRwiZoRUAf1hZLvT1MDQTfeb
	4jMRNub3MD+GlEFIOscNEJNFNjtSYlHRSLNnGZ/F10uQSfFExqp4Ym0=
X-Received: by 2002:a05:622a:8b:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-5311a495dfbmr2698831cf.0.1789412391372; Mon, 14 Sep 2026
 11:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <a362ecf119a7e1c6a42c0643537cc51e83f78bb2.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <a362ecf119a7e1c6a42c0643537cc51e83f78bb2.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 11:59:37 -0700
X-Gm-Features: AcwNN1X2mz6cTxPV1l_OulVBMfNkr7dwm4_Z-lQ3Da2vVo6vle-Sc_6TFpBuX9I
Message-ID: <CALMp9eRL2rTkRMj0cuhxUcrzJ9G8VY4an6vCiCDSu5X139UKtA@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> When the x86 emulator encounters an instruction intercepted by L1,
> svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
> DecodeAssist state.  Populate the architectural EXITINFO1 field when
> DecodeAssists is exposed to L1.
>
> Provide the GPR number for MOV CR/DR, the interrupt vector for INTn, and
> the linear address for INVLPG.  Leave EXITINFO1 clear for CLTS, LMSW,
> SMSW, selective CR0 writes, and INVLPGA; the INVLPGA address remains in
> guest rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed,
> and leave unrelated intercepts unchanged.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/svm.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ea647938a2a6..6834e1101bb6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4837,6 +4837,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcp=
u,
>         int vmexit, ret =3D X86EMUL_CONTINUE;
>         struct __x86_intercept icpt_info;
>         struct vmcb *vmcb =3D svm->vmcb;
> +       bool decode_assists;
>
>         if (info->intercept >=3D ARRAY_SIZE(x86_intercept_map))
>                 goto out;
> @@ -4846,14 +4847,26 @@ static int svm_check_intercept(struct kvm_vcpu *v=
cpu,
>         if (stage !=3D icpt_info.stage)
>                 goto out;
>
> +       decode_assists =3D guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSI=
STS);
> +
>         switch (icpt_info.exit_code) {
>         case SVM_EXIT_READ_CR0:
>                 if (info->intercept =3D=3D x86_intercept_cr_read)
>                         icpt_info.exit_code +=3D info->modrm_reg;
> +
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D
> +                               info->intercept =3D=3D x86_intercept_cr_r=
ead ?
> +                               BIT_ULL(63) | (info->modrm_rm & 0xf) : 0;

Nit: CR_VALID | (info->modrm_rm & SVM_EXITINFO_REG_MASK)

>                 break;
>         case SVM_EXIT_WRITE_CR0: {
>                 unsigned long cr0, val;
>
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D
> +                               info->intercept =3D=3D x86_intercept_cr_w=
rite ?
> +                               BIT_ULL(63) | (info->modrm_rm & 0xf) : 0;

Same nit.

> +
>                 /*
>                  * Adjust the exit code accordingly if a CR other than CR=
0 is
>                  * being written, and skip straight to the common handlin=
g as
> @@ -4891,13 +4904,30 @@ static int svm_check_intercept(struct kvm_vcpu *v=
cpu,
>                  */
>                 cr0 =3D vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
>                 val =3D info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
> -               if (cr0 ^ val)
> +               if (cr0 ^ val) {
>                         icpt_info.exit_code =3D SVM_EXIT_CR0_SEL_WRITE;
> +                       if (decode_assists)
> +                               vmcb->control.exit_info_1 =3D 0;
> +               }

I don't think clearing EXITINFO1 here is correct. The APM says:

> MOV-to-CR0 Special Case. If the instruction is MOV-to-CR, the GPR number =
is provided. If the instruction is LMSW or CLTS, no additional information =
is provided and bit 63 is not set.

The Decode Assists depend on the instruction opcode, not on the intercept.

>                 break;
>         }
>         case SVM_EXIT_READ_DR0:
>         case SVM_EXIT_WRITE_DR0:
>                 icpt_info.exit_code +=3D info->modrm_reg;
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D info->modrm_rm & 0x=
f;

Nit: SVM_EXITINFO_REG_MASK

> +               break;
> +       case SVM_EXIT_SWINT:
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D info->src_val & 0xf=
f;
> +               break;
> +       case SVM_EXIT_INVLPG:
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D info->invlpg_linear=
_addr;
> +               break;
> +       case SVM_EXIT_INVLPGA:
> +               if (decode_assists)
> +                       vmcb->control.exit_info_1 =3D 0;
>                 break;
>         case SVM_EXIT_MSR:
>                 if (info->intercept =3D=3D x86_intercept_wrmsr)
> --
> 2.43.7
>
