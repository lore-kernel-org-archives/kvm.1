Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BB48381F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329409; cv=pass; b=stG9AhMhEPADQfWYBRDgVpiAWUdEs0dyKZBmMq0G4zkhLMIoLjU+TBuRNTClhy9M2gsvoRoplxQ3FeJDLkAcKXpZg7oyMt3AXLzpnzfut3HS+k8fDGyKrBmtrswDXMi8veFW9f0iggIKuqxgsLWQexdmXNZ2pQSjrw79dJKts2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329409; c=relaxed/simple;
	bh=JGRGDiAJOaG2w2NCqn2ChsJscwfpJhdBeZ8nl6dBIXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll/rsmwn0wbu5CLccSHx+87Rgn8n9bpbIVqKBDPfl1MmnFx0r9UzZA/SqrQoSSA+aFf9URGvq64YIwDQ0aMdyks/2SA4ZqWOziGuZJT3OFjsDmrvl8k/PGeukmD/NMVr8HtuOM958VWHk5X6gnCBrmceenqyPf1ETU/ZLCLqrkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=LR11f3Ew; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="LR11f3Ew"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so378898f8f.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329405; cv=none;
        d=google.com; s=arc-20260327;
        b=ok/+Hytco1DJXyIz3SfC8MBMV2dILrqM0VHxaK3N3z1XCvazRFBaCZ7WBycc0McRh+
         QYHJpHfESTH83YfkRfDJG8+egexGkwOKmbI0bSnvaW38CBGzftcM2xPUJevOsjOtqR2v
         zpzSnvxb6xLm7CfHg6nk7svM71PktmVCwOlbb80bsV8+uoZ/Xe4zqWT3HWg44+8Q5ZtF
         BAs0on5SUTpJHGgNiu5SFqrN868h0J6mscYuGISUIWTlkFi6jo15aFgE6ZA0rYhv5piZ
         hKWL1vBd0x8+SRZ3D5jkmAVzoSRxiJoNcrVrwKFGn9sDIGcPJ1AfFnkeHbA9YRX5FRfe
         p5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dx/CmVrpueSln+pSRsdy5aEFve/DvptB38ixtepw5a0=;
        fh=M3XZxanlbkj11Y4I+e+bu3fJJnfZXjrGQzK1ksZ1hPM=;
        b=rdYwJTUqANbnrVgm2Qe1qsFixdaUIDUVBiP18pyQCrYWO3MKYtc7VCoMccewy48uDp
         iSH02OrmW9yErfTWxJMyDYuJAVn8852KRXpE5tGok6R/a2qEyIQm4D8YVD94J7lGsQQN
         Gh4WHQNbkfPYw4+mNOtZq/l9w2/A87loAyG3TMn2POXt2iLMy0dYNGmWlByJamtpjUEd
         bgBN20A178vT3gNoB2Mz+DdHCfiraIlh7tx48xGfulz/9Bsfy1ipk972ld1vMd27Ik6C
         g2U+zg4sV12QLetjCQrQ7Yl5jBOPg6N9PIag4WrnWxLW9bRxfJEyy+CnKxmoiJHcELAv
         Ow1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785329405; x=1785934205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dx/CmVrpueSln+pSRsdy5aEFve/DvptB38ixtepw5a0=;
        b=LR11f3EwMYPhBLa0O05e2nU65PA7uFXrjLAPnSrW29JDZjFu1gNCGHb+E8eDc7Mesp
         Oj/aRq+YVl1hw7vXZa7/5Udvs2zhhxOEFT5Hn2Q/3vi3Cguyl/M0XcHB86kTk+5TY/v1
         aT80TwivmK7KkC3tvAqDRtaJtgIP7NwFceQolar/u5KclbuShAPPAkQpIE9Jab98wKhb
         swBFaRkP39BT/f9osbIB51zFvSFIMMXhEq4r44L1KdrqxPjmcdPjxY0MSSgxZxoygRMV
         WTo+eZa0Yrzj90BCbwdoEBTGnU1QWYSUn4gRkRRTXNNfdmJffwiFo8ljxhsjsrl1L0EL
         kIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329405; x=1785934205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dx/CmVrpueSln+pSRsdy5aEFve/DvptB38ixtepw5a0=;
        b=BHUwlfTJ0FF72Dwn9+kw4MqvEB/ixyhZjGyTZFNIq1OBL5UJTgWlV9lV1zy2fRPNzS
         eQqDHSGTxM2457gqKN0x5gqMec1CYgBEQhi8oi9jcLusWfiZy4o1L83AvZdNKzRrL85c
         e441KrOiVS7s2gcDuDKNDvgN+vPEUBZmvPUP65jnJZJ9B0FCvIBGxH3RCpaDSG7HKtXQ
         TnjKfwoggs+Tae7b0TYtoIEHdIZ/gIl3/iUtg3FSP/4tmmCa/221/gvLUjeqabc31/78
         lQMMRR/vUhrKTU604CCG1z+jS9DnoFlI1wPR80dSzFMUo9jnmbU/lDDcVp/hZNl3gq0f
         VsYg==
X-Forwarded-Encrypted: i=1; AHgh+RpWHW7BiinhBtC/cYTfxlond0ZG5VRFs4pBnHFyJ68LPHyCB7A29Hyboh1iBqBFtYHZor8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CD+YwF3LrTe1r1tdWFQljU7+yorGW0Qa0Jm8071VzDZQUqLQ
	49RsxeejcQFT0Bl5dLQLXHRd5oMal2RqPZxkU5A5VsNKk1yOBvQydFBsOXmKZ8aIKpzdNFBFj7f
	6+Htqb+zoyKtszSVsXp3DFACC748cxHQZGCH8cRAN1A==
X-Gm-Gg: AR+sD10w5qlG9y71pLEeDSYvuFzZRzEjPEymX8FboP2xsYCajP/1QHmQxOpVTuQNx3P
	Ej/YMO09nmSyT4F+kyAMhZ9yLlkqrszx+aComEqd2UITQBfcrg19vRMfi60V4wVqjd3ZPmcA+0I
	vF0wkCYy1MAfwhIyTAppSe/oEBQc+zKHG1tm24TOiGHnkFjtRv1blPfbPtcyVDcCuLB7JxF1uKN
	fHm8xjTmfj09chqcNUZEHGvg8BJwMoIBobJHjJ9UTZAac2vJyO+uiRf7L1rhGFbLHcbZyHYilj2
	d7/G/4YVo17aHK5wr0Jj9pXcpdi2BAH6Xd5Js4q9GN5mgKX4xIahiAL6hhW/ao502752rFlaNyl
	CodFDCr6Y687in2Lc/V4ME3aHUHTlgYWkhtvQnefcoakoGrjNKdRPXVbDWuUn0O4=
X-Received: by 2002:a05:6000:4310:b0:473:6e8d:7f3 with SMTP id
 ffacd0b85a97d-47fb1e8282emr8113564f8f.1.1785329404905; Wed, 29 Jul 2026
 05:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-4-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-4-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:19:53 +0530
X-Gm-Features: AUfX_mxIAIAYLjpHcgaD3ozqXoaXRQtjaEsHbcis5uT8wvm3w9BPM7ZLbion2z0
Message-ID: <CAAhSdy2xe7DBRY0bhM1S0G-6ebEEi5y0x9fS3YFUC6D7bN32LA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Deepak Gupta <debug@rivosinc.com>, 
	Thomas Huth <thuth@redhat.com>, Sergey Matyukevich <geomatsi@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:33=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> Extend the KVM ISA extension array to allow KVM userspace to
> detect and enable Zicfiss/Zicfilp extensions for Guest/VM.
>
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/isa.c              | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 7bbea8812d92..a27de850fa4c 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZCLSD,
>         KVM_RISCV_ISA_EXT_ZILSD,
>         KVM_RISCV_ISA_EXT_ZALASR,
> +       KVM_RISCV_ISA_EXT_ZICFILP,
> +       KVM_RISCV_ISA_EXT_ZICFISS,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
> index 1132d909cc25..9852a91fdecc 100644
> --- a/arch/riscv/kvm/isa.c
> +++ b/arch/riscv/kvm/isa.c
> @@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(ZICBOP),
>         KVM_ISA_EXT_ARR(ZICBOZ),
>         KVM_ISA_EXT_ARR(ZICCRSE),
> +       KVM_ISA_EXT_ARR(ZICFILP),
> +       KVM_ISA_EXT_ARR(ZICFISS),
>         KVM_ISA_EXT_ARR(ZICNTR),
>         KVM_ISA_EXT_ARR(ZICOND),
>         KVM_ISA_EXT_ARR(ZICSR),
> --
> 2.55.0
>
