Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794977071;
	b=T8HdEp5b99s0igvYxsidW+G7fq2E0vxGUXqQuH5dLA9Z5UJUVMKyTU74d4Jt1MGlD2jq
	 P+s7g6+ew9hprswgzO3I8yzwMzJEzYkaEk5J353GRODvHq+GwXV1Dq7tuO1/6h2IKKt//
	 AfTMc+dIhqR+cDgTL7sRwqkcsxUIY53S0UGFRVlVBj+6WeHb2dsk2FUJQie16uegrcX7o
	 ckCDGBL911s434UlNWtdiip+lYlNxyLg9B36qyiMei8TpDAXDi4TNnsDRoAd0aLHhKZh8
	 c/ctwVDfvkSZPO8yUeME2N40nQMmEMd57eByQKt8V8LpQW1Qs7ZHnsdzQi1euSjpOiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794977071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GzlnWTqopo0YjHkcJsTJjoTbB9TRUt21018gFM8sivI=;
	b=Q+jFlcuQplzfF2mLIXDmC0nODflXeoOR0JSiTGJuUhmtgkA/hSese4dTvOc3IDRaNg/T
	 q4RjgB2CPgFDiYymXV+ZkJwZldpkgoALZqz1HtsXKWenMr7/d7zTQhrSilaBt4ztRhcox
	 PUk05yip1NCjgrPLbME9i2HGE+UmFTTMKR1tSgi+LkvS9rlmSxrh3vd6ypNH/D0WfmFeg
	 3aRlnj+9AWR63TOPNlbQwX3vwuhK0SgzHDAk7svXnts9fkEeb+hxKtVk8FwBucY0iqqov
	 Vs9Zlz8GKkaOkr4sUmGFc8EBHfPqXSfcuDoefqWNr3BFfNWSNbLx2O9/ryOlN0ciZVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1k7wM3h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A888606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A888606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1k7wM3h
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso8391a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794977070; cv=none;
        d=google.com; s=arc-20260327;
        b=NTU7sKpBJTOrOPDQleqD7EUNuKGM8Nnq532AP9yK7suUGfTuP4TT9zgqcG/WR3o1YW
         8SEBzABo0d41O65WqOLco/yLWB3sTOiO2AASzWfQPkWELaFWPEMJzO/Yyh/NkorwtQib
         /I0CNCPaRBqnKalzaz96mAeinUCc3I/XX0ZFttTjpBiqTwzkD8w7eEhRotKuRJLHbEu2
         fiOeY9j1NTBnt13fIFSEVQzy5HYyOFYH9znR71c3VJwztqKU+knAiE70J2gRZL1HxvB7
         lsBqaZcq5ZsJf9KpLwmSTyHlix0iFfrU+XPQ9MjjZGnt4l3hzPVbS1nrAkr/yb0uTRI+
         mkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzlnWTqopo0YjHkcJsTJjoTbB9TRUt21018gFM8sivI=;
        fh=HTbU44U/vVypkOgwO6UW3P8QXojOSX/JOUuQ4Kd3lzI=;
        b=KvSZ/tySpGE7aLFF3xeeTn5X54qpdTO45mAyRLPshDztUcm+jXnlnh/cHgsWgqL7cm
         ar8OTbuwTIeTqnBW4XeftIiI5TH0kFpU7g1rEC08QsiDyjaPT36XNqfYp+Sf6b0BxYQD
         zCrP6D/NH8uM02sO5MH3uD6k56p3PlW4vMT0O2sdyyuhOE2g1U9pkAySHH1Jn8zRdfdv
         bTtHigAbO9JYFrwdU+VXVY2RpF2Ey4oHFk5xFvm/Jkpe1aoXCvAk6ybcB+bk/x5Ct08Y
         M5VLbrbKoPSkdNVlIVeOA8M8lCc2ct5pl4UcU3XN8vQ8w6erdpAiYF0UoUJ15oogxhNL
         lVfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794977070; x=1795581870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GzlnWTqopo0YjHkcJsTJjoTbB9TRUt21018gFM8sivI=;
        b=Z1k7wM3hcC2iJciHoW5EDy+//u32xGh36TPLHviEPkB/EOUTOb5uE8daZD7FTOsgQ/
         SvRx3cNhPj+VaX56UkhF8MSctdumBIhexhRR/NKaIdOurhcaNxKy7DCYTKEq3xJ0pgbz
         isCOduvCSei0td9iN7vEcshYJGbz6yblxFM6KzU/vy31/1M4wMSnGcPVH+LiASsFvEEt
         xnKojiBxsXuCBdK0MWJ7tQOCfYGPv5R4hB/fCWOOjPHJDt/8KIO8D2PxAYw1LK3hab1i
         FQVV+mcntRhG+AZP3I4j4gEmZYm/sbWqoou6kFdIhmwis2/FT4UMjk+VeQneJDpRYctA
         W8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794977070; x=1795581870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzlnWTqopo0YjHkcJsTJjoTbB9TRUt21018gFM8sivI=;
        b=Pe4xjqI9GeJx64jcCIjzBaRTkGyFgOhJ8Ci6cZ+MMTK5GBFcp5tLz6Gh/2TWALWBBI
         jdfe26l+uHxM++YTZVa/01YFPGD5fM4krIa7ut55Px6Tc+NVwFocSLbrqKgQkWJkOCZA
         XClW//t3taxy/8k32sZxeHrGbTQSAc0ErN9taGdb2pT7Kk7sGnmE0/vo9r8GHXNOmNmu
         3ULUBMEu2JggMaAswS6NarhA9Co5y9Gs82iB6mmikM3WA7J0OzTUJUineRryezk8t6lk
         Qno+/yupdodz0mHiJp6GSsJqyvddL2XzjmpoHJX/Tegkd9KQn/1U/hNM0AE1ZzwVVDm7
         ImSQ==
X-Forwarded-Encrypted: i=1; AL+hErFWPRM4GZxy6X8IQNJ/aitk/+1xU7eBt7VzrAnAEDFY6S7/8gk1cgjPETmxm70S32ndaiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VoKw/ywjNrVZzV3/CnljHj+Tq5vvh92pQg7aSI7g7cDLvUnSm
	p9UYbTsf0o4SEkdHoGwN36AWRfQuOZ62A3GUM9m7Qmq0FCsUbodhkr4InsIWeeIv/T3ZQZ2TcfK
	Lr6+Y21iG6H4VLyJd1tr9GskeMK5QW4efy8p9XOYW
X-Gm-Gg: AYBFou1amUvQHf+O9NziWZurRag5ukFqqflbhrdarvzBR+LQNS+tJqtahubTWNi1I7D
	+oHhWlAMFClLfOvNSfDjFlw1RqpZXIY5d5p++hETyzNO8as8mKjWYQ6l1TVHnq9TsK4MDg5M2l3
	2Rv5UiO2ngSUdUpSe+IT2QfA/iZa3BihAlCyLHJGn8UKeHQNIIkjuYUY9y49E/awNLbU4JVTMea
	zk9JH4xogaBOioNjILNsOXCI1M8MSfvrJfEiV0jhB0+P1EHhOfdMS2xeRL8/P0Kpa7vkwImmivF
	cnYQCk8aLOci1d7mN0jaaEgfDLs/IRXRE4jIPaDNn1AjCZw2JXS4GAW7kG9IryfOq7gqBAjktRm
	V7ujwLKX8kFJKVN3zdzFL/SwXStU6xBjhriHJOK1ZRlGZzm6BZQq71FKSaanVNaPRcFDcKN2HIf
	dg1gI9GYUwcItHRWweIHXEzRpXy3mIslYXijahxw1q789qdvsSXHaThQ==
X-Received: by 2002:aa7:ccd7:0:b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b887def50amr58912a12.0.1794977069248; Tue, 17 Nov 2026
 20:44:29 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-4-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-4-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Nov 2026 20:44:16 -0800
X-Gm-Features: AclHuK-IG2kb2mtcYBmniiP12M7N304vzxkSKy-lkbeN3KazwLBW1Z1U6rCc830
Message-ID: <CALMp9eRtQ4FLf5YTwwwpLAamH866KBmbVpGa81A-A-R2vdq4kA@mail.gmail.com>
Subject: Re: [PATCH v9 03/20] KVM: x86: Support EGPRs on VCPU RESET/INIT events
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:31=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> EGPRs are not zeroed on CPU INIT. Handle each register based on index to
> support this EGPR behavior while preserving the existing behavior for
> legacy GPRs.
>
> Refactor the rest of GPR handling together as the reset comment mentions =
it.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> V8 -> V9: New patch (Jim Mattson)
> ---
>  arch/x86/kvm/x86.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2cd9ee316aad..73bb1d25931c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9601,9 +9601,33 @@ static void kvm_xstate_reset(struct kvm_vcpu *vcpu=
, bool init_event)
>                 kvm_load_guest_fpu(vcpu);
>  }
>
> -void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> +static void kvm_vcpu_regs_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
>         struct kvm_cpuid_entry2 *cpuid_0x1;
> +       int idx;
> +
> +       /*
> +        * All legacy GPRs except RDX (handled below) are zeroed on RESET=
/INIT.
> +        * EGPRs (R16-R31), however, retain their values on INIT.
> +        */
> +       for (idx =3D VCPU_REGS_RAX; idx < NR_VCPU_GENERAL_PURPOSE_REGS; i=
dx++)
> +               vcpu->arch.regs[idx] =3D idx > 15 && init_event ? vcpu->a=
rch.regs[idx] : 0;

Nit: I'd rather not see a bare 15 here, though I realize that
VCPU_REGS_R16 doesn't exist when CONFIG_KVM_APX=3Dn. Perhaps define the
number of legacy GPRs in kvm_host.h:

        #ifdef CONFIG_X86_64
        #define NR_VCPU_LEGACY_GPRS     (VCPU_REGS_R15 + 1)
        #else
        #define NR_VCPU_LEGACY_GPRS     (VCPU_REGS_RDI + 1)
        #endif

and then this becomes:

        /*
         * All legacy GPRs except RDX (handled below) are zeroed on
         * RESET/INIT. EGPRs (R16-R31) are zeroed on RESET, but are
         * unchanged on INIT.
         */
        memset(vcpu->arch.regs, 0,
               init_event ? NR_VCPU_LEGACY_GPRS * sizeof(vcpu->arch.regs[0]=
) :
                            sizeof(vcpu->arch.regs));

With that change,

Reviewed-by: Jim Mattson <jmattson@google.com>
