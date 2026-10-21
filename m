Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792626838;
	b=KOmhJ+JJUHytE9CfX01Er7G1e8vpa9PA2WurS4NBHPJHiCsbED/TVjlCoDaXno7jykA8
	 fV+FrziAAjHGCx/awJreFUwt/zNsEHHk3wjpdcvJHz4jWasd4bkaXXoLnFtB56cf3mmOj
	 jbSF+S6dMQ5o4yzHwrTbmIKFiGya3URCLOyRO28joaVpMwy6I9TE6Kb4QXUd8O7ibNoV2
	 jw/hNUc+1WtmX23Hpqd8+r6uqHBqS2fwCKQ8TAjVCEBQqlWmYMoYMoHh4j1HN4feigx8C
	 agKL/CeUZG0EUjpKEdmg6PZuxWyY9vRMdSgZ4vjsNWZhjqr8k6lizsv2Eq/73wnF4Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r0+Eacjq7TKx99CpyvhHARkB1wBae7CDCliDkpOXnEU=;
	b=FianandEJA/N8n8HqFGAcy+E3SKqWLGjCBMAFhOXq6m0+ao38veLjOt8D58BmSqFwjuZ
	 7zV7+6ouF1yP9nDJ3OYdlFkMRjzAR/mlpra+1b0rohWL10mI0z5YSHaoQqEo6c4kgIYav
	 IooydfdpKj4VJSoVxSee7YzdNaGh75aHuHLhuzMg88rMb93TS2iwDz7/LifFl0kLgfFku
	 EipcMLJVd7fP7oqs2/jBUiHCDO1e8PCKgnFE5PiJ3Zw/9XgQrNq2WLpWqPVRxPlUTw/Cy
	 CaFzL0cfuDUymmT7xpC9fEvDFOwsjt7kmCSFLZvVpd0uU0Y/T5EsUKLL2/wqWCOHKOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fSpr5bZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64163606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64163606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fSpr5bZR
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2888a12.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792626837; cv=none;
        d=google.com; s=arc-20260327;
        b=eeeZmC6KaEKVWkRP55Fm/OJl3jC5p3NFQM2cC6MW7SYGuzeiNiifLXBtY03BB738Qj
         q6aF2mD64kO5MquaHBEMavERTlG5rHJ8KhTbcQNLiGkfL4gevlN8YIkjMpk9bn8n1npd
         3S3IPWebBw1npOKvOGxPsuqDwge3xVBcabFU4Wi/w6dbuUdRes8vqaulktliHnrheiIo
         Z/sBp129PERFKaqjU87XVotyXQ+3xtxUdKg5Zqowpusw7cPNL7SqGtPp5jIhmRG/NFQR
         VlX1+J5GvMrTmmc73Z/OhRlxsZ69SbLgpeaftHTutNXUTd7bSRmGq/rET6Fn0iRxn4BX
         ePWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r0+Eacjq7TKx99CpyvhHARkB1wBae7CDCliDkpOXnEU=;
        fh=y3vyZIq4WIic036fCRLWovQkquRacGasl3m87ZhAA1A=;
        b=KjUatGgPKXBkYwMTz2jAh3cMrrM4+hzIBrNEANvtpjdpTnCagfiS/MOHDUAJgs2TRx
         2By2kHCpT0rK7+LwMmiAJjPcs2LoV++cMU9S++hJkXBK6lWCscDfBOEO/Y1efpB+nWxd
         OKfrRPUYDtGLzPxBPQuIMiDwKTCGQn4S7FOOMMKQAQay1Y24R4h/PIy1YkCgRd46Q0VQ
         2HR9s8K6Vh0NyNFTd7iN9D03v58BaDncW1M2SNALsH7QMKK5v74VmGT8DojrSTd6LXQQ
         Y+Su9ajNOkfghiV/m1YijXrpkaCzQBuShOVb2d1OYbegqvPaxIpvWLVYWvOXeIA80wrF
         QeiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626837; x=1793231637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0+Eacjq7TKx99CpyvhHARkB1wBae7CDCliDkpOXnEU=;
        b=fSpr5bZRSkKghvSb1ExgE6YrTFm+Qhw+rBXB6e+clmQor5CgvOIU4qAOF7bvQOtMcD
         Nhc7suFBUsUjx4Bzp5ldane9Gkdyi+n2ypBkMQc/IIHGuSjM2wGOegwxlpEczS6S2r26
         bcai2lggiv/XHqEV4Zt8Vi4rxsDnYbj5xVn4hSV19dMPoEXuL6u3lcgCRATOjSxZ5KjA
         uXzSbgiR9XNi/ZnVXpkzBAlqAEfuOhXV+O7AAJ0Qr0bPFV64sGhBZ4KqeHwQH3SDWeOF
         5ByRbB/Q6tGJgHaL+U7Cssbrydv3LwKd981inz8Sypc58M2y+tyu2xskIwsftFVULVhx
         /orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626837; x=1793231637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0+Eacjq7TKx99CpyvhHARkB1wBae7CDCliDkpOXnEU=;
        b=HNuekHAriSJdX1++qmGFr3BfPMPZHnSfk9zquOvZ2AMx6teRPBNOUaV91Hdk9Bncna
         K/FD2JM1YunbDk9xfp8Eshk4W7N9iwntXLHM6w/Xj2MW45aWUFKm9w1UF7DPwgbQ9QuU
         iWYrqcqt1gGeZaH2xWhhS3MYdkSj258qFmPcLlO7RTCQRvviL8SYDS/pSLVxBt/Hdjjw
         wZwTMpj/eXO+lYQYgtixjj8DYZ8z1i2VWDatLZPLebr3NK4Lg1a+K8D0kNHSAcFi6FWc
         89bd5x7uqfUi7dC7qVBJr65kSOmC/IfbxYsFnZ6Hqw6eFDppjRc+vthv7teKOQ42KiO2
         FEyw==
X-Forwarded-Encrypted: i=1; AKwUvByhCBWEIYJWlaWvgPbFGyc4+3mwa63r7DmSEmTtA8HDCuxLFfVN+nA07MJybGFOwRjQtzE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqIbmq0a4inc5ZUjp8aWIYvzChlQjPORkrwewtZEgsYSsrfosT
	vTyBDjlSw2lDUDj1RQck7Iw1RzFjcRpN5vTdvhg+fg67tQ9YZyhltovZNXucASFMjik7vhfHwxU
	YdCEdsOGlOBxxg8mIGVJ0SauP8LnFuvr4TkCFYIjz
X-Gm-Gg: AYBFou38YgLqo2LrdUVFgEdcNtS0OdZ0fplnl9bUKdZvOkvTmtEol5cnWvjVohW8vRp
	FRi+ueZTOmm0RiqlqxVs39nmQ5wYqNpXVr92Lt4QxHG/EDpa41wdB6JZ3sP7qkIxKh3XVDz3mH/
	kcBkViKo9rNZaX8YQQoKfkJKabnyKssDnHQHjasDk2l0FJATzjdcWNzG4P4RJghHFwPzpr457Jy
	skaLYDWvr4uRYQUkq1obivcvMgVcE+QgI6KZ9TBJFZvOJZ9JqVZk5oQLSnnHRpAApKfjUGqtZ92
	WvWICUHCRmrmQEm9cTADFfRbMieEZq/JB6WqojGkQ1O7jg1MW1jRdGjnKYbf35/KICXKsUuC8wd
	r0oSNZr38VO3rLdkWtiXVrBKQx2F/WYz2z68+
X-Received: by 2002:a05:6402:a514:10b0:6aa:7db5:ad39 with SMTP id
 4fb4d7f45d1cf-6b41e0877dfmr15334a12.5.1792626836304; Wed, 21 Oct 2026
 16:53:56 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-9-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-9-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:53:44 -0700
X-Gm-Features: AclHuK_CA7hCALiz2MfNfa6HCixuBTQVkjn14jcxkIDbubeBiA2-BGuC_xwiAuc
Message-ID: <CALMp9eSs3vhi1mmhK=Mj+8R9UXDzvDpHepyDESvQvNxg3YTOkA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] KVM: SVM: Support LBRv2 virtualization for
 SEV-ES guests
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:08=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Add the LBRv2 fields to the SEV-ES VMSA save area and treat LBRv2 as
> always active for SEV-ES+ guests, which run with LBR virtualization
> mandatorily enabled and keep DBG_EXTN_CFG in the encrypted VMSA.
>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>
> Changes in v2:
> * New patch.
>
> ---
>  arch/x86/include/asm/svm.h | 12 +++++++++---
>  arch/x86/kvm/svm/svm.c     | 15 +++++++++++++--
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index fb42c6806655..0473e38e33bc 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -446,7 +446,8 @@ struct sev_es_save_area {
>         u64 br_to;
>         u64 last_excp_from;
>         u64 last_excp_to;
> -       u8 reserved_0x298[80];
> +       u64 dbg_extn_cfg;
> +       u8 reserved_0x2a0[72];
>         u32 pkru;
>         u32 tsc_aux;
>         u64 tsc_scale;
> @@ -495,6 +496,11 @@ struct sev_es_save_area {
>         u8 fpreg_x87[80];
>         u8 fpreg_xmm[256];
>         u8 fpreg_ymm[256];
> +       struct {
> +               u64 lbr_stack_from;
> +               u64 lbr_stack_to;
> +       } __packed lbr[16];
> +       u64 lbr_select;
>  } __packed;
>
>  struct ghcb_save_area {
> @@ -567,7 +573,7 @@ struct vmcb {
>
>  #define EXPECTED_VMCB_SAVE_AREA_SIZE           1912
>  #define EXPECTED_GHCB_SAVE_AREA_SIZE           1032
> -#define EXPECTED_SEV_ES_SAVE_AREA_SIZE         1648
> +#define EXPECTED_SEV_ES_SAVE_AREA_SIZE         1912
>  #define EXPECTED_VMCB_CONTROL_AREA_SIZE                1024
>  #define EXPECTED_GHCB_SIZE                     PAGE_SIZE
>
> @@ -598,7 +604,7 @@ static inline void __unused_size_checks(void)
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xd8);
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
> -       BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
> +       BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2a0);
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);

I think the VMSA structure changes should be included in patch 1, with
the VMCB structure changes (or they can go ahead of patch 1), since
sev_es_sync_vmsa() does memcpy(save, &svm->vmcb->save,
sizeof(svm->vmcb->save)).
