Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B378838
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362859; cv=pass; b=lJ2dLEw7x2JFeiy+LjvMujCbtuM1cy0vVDGn7166R3D8Zh2mgJgJmWsue5Lq4lDk/bWLKbR5G5+AiuXQwBN07QA4qGFiuPwmjz7BzWeqq1eB8yzCW3ZzaWvua5QaxDgtJ0y2l7oAiGbat3LqPBNfvpHOVBfXb01ZGoJ8CSBrXLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362859; c=relaxed/simple;
	bh=txys08ETjEf856Lf5y0MJ/SEqvDMNnRTDlYpklG067o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/v/6OcpepJodiQCGsKSGBkleekfZn3tngI/xYGyNTEvFJVerxcxNPWIUjII2HYjxbv8M37WgUzr4yg9SNtML/XM4o9PXBy0JCf+5p4YfDyOW/TKo94RWYHaQEnwQouoH241FqOah0TdNwdkzfxP7L/Vp2G1Y3wqw9rbdwGLCP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=Aj2lb8zs; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="Aj2lb8zs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49e717c9841so8297145e9.0
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 22:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789362855; cv=none;
        d=google.com; s=arc-20260327;
        b=FEwMvKzimCjiH1xMzr3P9rZAbyihaT89Y4sNlKSDlnd4HTnCG/QhcW9BLcCBxtFuVi
         loYaZzeE1nDLks7evYrCk+onrg5N2AcWQmwvVCiQ71ppOQrkQGqj4yqXZPSVTA3xd/DW
         hXMXQs9k4zDnRZPa5JuRwR6W11HNyUQPTYh9/9zgRn9hT6BO/e1xr7sR7YT8BfB7Dg+u
         u8Kst8RF08fGKsSaWJLPM7DY48eRa0VIj0mT0m2Mg/14ibnHV3LOm6EHfs8ceT+G/7yC
         nYjn0HeLrzac8NqXaeP+Ch07Ly1VjKkBkpgkoeGKnpmg3n6qBcTvu66JxEc0DnXdxLhu
         uOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        fh=w2gUdlnhau8hHy3WsLAOFuANbimiCtIJsflvLCe0hTA=;
        b=RIo/kXKMrYxcTwAlwXtvuiAcYw1wymMCnua3kRGLt+yI9p+5AjR4fuNq9Ff2NL8bg0
         rRgAChh57JvKMpJTNzd+D3OWl6/4UHIqpIEbysdnSlWWO1hs+/JZe7hv/WBFLVnMCfOp
         7FH+xIEjC+mhVi3U6ZwKvHdPU1BZmpsALbVuahHvK0PJ4osOLJfgy9DD50FDrqxY1Xoo
         nypHKoZPmwwMU2/2U5vRbBVyqWYheUtHscIbKDZ0NBgni6yFinDQVXXYg7ukpdMtSXIF
         HbqWB3QnEgghN2PSqY3JZykrrWgT4VpEgmg5Ft+XvO3yB73XgFi/b3augdAeaoxWYlvp
         y44A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789362855; x=1789967655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        b=Aj2lb8zsdf0cKJmeb9ML8/3uaFZZ4C4nhc9SHY7Dj7yGCkAOVVWFnAEvxzLFB3Iolr
         yHEK6u06hqAuiwsfoEuY4ESPeNCNnzalH6jp372nEJppgpcKfEI3vqRpeEqGovkQJ4oj
         8ijz2GRWLdHptVVpzKKIuShSOEzafS2oSJ0TiXClHCvOp7YpNvMVFKrx3YBJuQ1tZYFl
         D4MMbyFqVYDQpiSgEN5XOrDEU6uHUegvRsVyo8r/lkebdOLxqSCn3hgNT+fM+3yWGxT9
         854Cps9XIpLDpZ6+ByZWF6zK3FvBb29Zw7ju73cfOtmWjNbPRAmQzQbjfJbqrgbsyf8X
         doRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362855; x=1789967655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1vq0Y3VWCX7lyWdlee9zNWImptkP5hflAUk9JcRAgU=;
        b=Ft32Wk95q8vLNlBYRqV8s50LEsj15UrF3ph5Lg62aJ9f6JfBV5NM1vCHlPYgFL74XA
         4pSHSZKhytJG0yWjov51feLkDyC3b1LnGWxDv5mtKh5xWKEki6NcDoMD6Y0gttm0udNh
         AD7LMb+tgsX+MZP5DiKiuXxneWzzWBqOMcaBdhd5Djzj14UYVda4txDarySuuytgVDfK
         ztm+lZHi5Yoj4fweeJPGFqYYsmfKEA2L/sU7kjLk/OjhjPq6O9TDx0RF1db6r+lmarTb
         u5aJtTLZ6e4XyE4sMNxEVrJaBC2M/+3vJZBhvWT+Ms/oAhTyU1MCfJyiaa6EgmjZ320e
         xPAg==
X-Forwarded-Encrypted: i=1; AKwUvBwlO1MADMElPzg3jzgeh4g+hWnwSJhr8lOnl1KhEXBcM7hrQzv22wBP4wFvT22zXgAyiUg=@vger.kernel.org
X-Gm-Message-State: AFuF++m078QpZGL3iam88OBQfc+bmoVttnIZWcniQRAjq4Hqu/hnPXgB
	RYphD7Nk9WHB1DRiqGpXO0OVereUGXQ2KVhZ2KEH8Mzvpm6jzrD2ptC9lgsIh9xxQH7ipLubGbg
	faOfYJyNXjCCe9dqNeDUTOvAY4sy2JeSCdP5fJmiHKA==
X-Gm-Gg: AYBFou3jVlTaL9hK16WdpUB4PidZ3MNKI498EdP6C/RZx/db/VFsN3//j+35tncliqX
	HEGZ6pseQ+rlgEb51IliQD3uDzWH6TX3Qe/jIc7h20qqTagPwcFvyPQGmwiVSr7ezD//z18yWlA
	u/g9rZLA0QxAKXeQ/mitflCd5ftYUlvWIt9meplOP9oMeu3HhTpAlZCpiFblanO1+drohusGmmb
	OX6ZvqC9LmToPGPUiOusjVlbUrv0MdZpaASvjWZnxvriTTk2eAlnIwFP2obVox0wfD1jKQnYIuJ
	DXRt51qSJJrSSLvg4dUfQup37A+JZ6yDr4FFO7uw3TJGJ0CtYsheaj04CjwZCrkZ7m8wQA5dnlD
	zrfJsE3IzoE2oIwJxJ1qzdNtHzEbFm4DkXyOoV0CrKNFAyAv0BJKoBC4nGUFal7CvefImge2B1g
	==
X-Received: by 2002:a05:600c:19c9:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49e7a678d7dmr8979885e9.26.1789362855198; Sun, 13 Sep 2026
 22:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914031146.446157-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20260914031146.446157-1-tanchi25@mails.ucas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 14 Sep 2026 10:44:04 +0530
X-Gm-Features: AcwNN1Xv9Q24Kz2JNPc5ElbJduPG-W_3pjLhuvmorF4ZD7AGszu1UnXv2VgFblg
Message-ID: <CAAhSdy3m8iBXiJF_=syKKm-JYpW3ou8P4FpWNB0_a-t+_dTuAg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix HSM hart status error propagation
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 8:42=E2=80=AFAM Tan Chi <tanchi25@mails.ucas.ac.cn>=
 wrote:
>
> kvm_sbi_hsm_vcpu_get_status() returns SBI_ERR_INVALID_PARAM when
> the requested hart does not exist. However, the HART_STATUS case
> returns from the SBI handler without storing this error in
> retdata->err_val.
>
> As a result, a guest querying the status of a non-existent hart
> observes SBI_SUCCESS instead of SBI_ERR_INVALID_PARAM.
>
> Use the common SBI error handling path for HART_STATUS after
> saving a valid hart state in retdata->out_val. This preserves
> the returned error when kvm_sbi_hsm_vcpu_get_status() fails.
>
> Fixes: bae0dfd74e01 ("RISC-V: KVM: Modify SBI extension handler to return=
 SBI error code")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>

Good catch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.=
c
> index f26207f84bab..06a15629c26b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -95,9 +95,9 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 ret =3D kvm_sbi_hsm_vcpu_get_status(vcpu);
>                 if (ret >=3D 0) {
>                         retdata->out_val =3D ret;
> -                       retdata->err_val =3D 0;
> +                       ret =3D 0;
>                 }
> -               return 0;
> +               break;
>         case SBI_EXT_HSM_HART_SUSPEND:
>                 switch (lower_32_bits(cp->a0)) {
>                 case SBI_HSM_SUSPEND_RET_DEFAULT:
>
> base-commit: df2908090cda368b01ff43709f51890076c56157
> --
> 2.53.0
>
