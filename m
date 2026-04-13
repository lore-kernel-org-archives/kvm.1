Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5921D95A3
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072812; cv=pass; b=j0H/1kY7345CbsqZMseLVitI4dmcW8vOQQAoYqEFOdI2oZtkNXrF8BkuNIY69aXgx2UiWAcp8MPoBj3j6OS+1+DElQ9r2QjxKq5UaKjOI0Ne/fcPsZnzXA2usZVBEUlFlKRsj7gOy3ykRCBmmfroRwDa6yCVt66zc9u7SQuWrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072812; c=relaxed/simple;
	bh=wF92QO/P9Lb2mmjnPcR4RkDbubCXKAc2bu/es6uLsnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL0FGvFrJior94Px3kImqDNGQ0Nly+JOIyar9fiUZqxXwAzZvoogowHv1Zd2/B+qjrsF9Nsc6qGmSMBvU9tvjsK+XOxw/zOSZk94Zr2fjMfTdmQ9eGmkFkIUfRlSYEBzI8L6c3EbwhYvUj6hNeFr7oMDWJF+jqTw7ljmY2CZhos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SV+jwDAF; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SV+jwDAF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79db5e18ac6so36243287b3.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776072810; cv=none;
        d=google.com; s=arc-20240605;
        b=bx0hKAZhPPr83WqIxSUI9nMyX//S1f4FvdBBNZIqprfeZmtSUhoxSM+CVX6XQBET30
         QmHPQLXuCV7i9zLf0mS2FP1CdndbEHo/nBBa8kMcixnHZjU6bWAfM9GjYwTDf7+t28nZ
         W/mZOcgZVxgDUoQ+jRnj2QFe1d/ZhKF7tdMQB6btDnZPDZUik3IcXLQXF17z+DAFO+RR
         oe1m3eyuJu7FXeUe6eErpVcRfDjIO3TYxtTRbNi2BA7Nwgr0Xr41TrTSRuGcXWyWFiZ9
         UBtu6j7qmRHndRzUQBTQH1JmK27Av2coNbjLG8U4bpSWOz7aqBwg0APsibnxPTSd37jI
         tdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
        fh=2r7Q7DygPBYf+gp1XzLlA/1NL+AT0rKEyD/L+rmd1/A=;
        b=JdLZUZ+AJndwXzjfDUEYJMft6Y19OwJV2L418hLk9TMiye/mHLJTdqMoA64eQZOVOQ
         t4Zf7ON7nEEA8dJ8dSbGPd1A4QgBpQpG1MmD0xaV6+h7sFSTeBrUFc3XXfQgg27bzXoh
         9P0jFH8+V5QHuVdVYc/Y58RA+FKjVuDhG08Kf9MiVj9f0Twhwmg6QTXE6x/gSFN9OQLw
         YctNlsoSfCY19pvia9IFv9B+OkVZIjVXHnHaDYn3tkYiENm51cEG9cdCMUj2fwIILsVT
         k69ELutkAGoVL5KDRXGwIlJLmCDLXCXofI0738vATPd/wVlu3a5ofgvsIfeWq5MkPwoV
         DzPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776072810; x=1776677610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
        b=SV+jwDAFtIVwlYY+wT7GpjGNEu86b3BlpI5cgWMVfw/Xmw0yyD/Ag7vz8muo6lJ4te
         AqRxPYoqxA7Q4zKh7OsVl9Y5DYtlCn9VM9mK0JkkBwH7RkndZCVSQoiGvQ5kRCmPmVS4
         WqJ1V15+4agj0waOqwf+EDZouDR8kVmZK6HeRA76pxQzaCf5pVDp+B1rJTR6Sh71PV90
         EUflXLVIjLEGDvPtz8oIiALQPMSydMD7YxwfH+Kg6dGsIELjz2pHoX5MvurS8UnKdIwo
         vVJFNIhoGnSD/+1KZ/jUCr7uDVJ9tX8KHaXw8Tv1JtH7Iv7RgjH8SctGB39m5WNa8R3/
         b7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072810; x=1776677610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
        b=qHYfpOM+G3yP9eRD9oM8ByHrhSiyt5O+5L85wN0UsQyAWoHIosJN1vqdQVp2t93XhP
         qbigrZO3JxPqKK5DAMAy0qh/bMCHMX5ZuASSk19QEqs+M3PasRqirUhFH6VZ4pjnYrgn
         FJ/DdyKC7edRC3MaVIinJLA2ObQJkxW6B2xG5EmyvaToqroaB3BIIUdyE1DyCcIPi/S4
         KF2di9BuDX4Mn+ENdHpVm+lSnpYgYHqtTpPqP+BoHHLkl1kn/80QI/epH9TzvCzDlfWD
         S1eSFefYCBjBGNkpXZZA5FxAixT6qdNTg12gzTc30YMaKtTMyY0Ibmt+6IlheRxuLus0
         YtiA==
X-Forwarded-Encrypted: i=1; AFNElJ8SHuArR73zgQGp6/o92YWhbjURqRTAWe4oK2y5Z5VBbs9d6/N3ezikqWdY4rBPJEqfDRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVNfgrfqG82JPwQjtiVCmdfoDHBuCdMyfom6W0EzmX0Yp3Xzn
	4TamaOsoNn0bB+LUyqWPoNre+3UAL9LDAhTgssAfEFu/D96xvqoyUZ7rmb0lpQARr4kqzArBUVB
	selqpGKMPEYB641CE8l/sy90s+7uhmtfmumHq5ltwUQ==
X-Gm-Gg: AeBDietNXNj3rGnQLmMryJliUyfw3scFf1xHvSG8KG5j7y+xc6AVenvw547yMBk21Uw
	FLESXpmCHavRy0Z/wke0yI+00liEY+FZvIQsmRf063YVom3y8GLaHD6m2ErkHkHsWBJrC/6sA1c
	xoMKlup501mf2hHcXm5+VgK29/DxYgfVWotiha2MKxZC8g+jPp6y0vTw2xa1epSmOVBcBGPnSmF
	bydsxMGnJWFNg6Mf9bk6nq0D7TEDnOb/ZfkQI0iXfaL4hfD020fThHjv1rbiYdbtmgJ/wFXhIgn
	88vUjUbgGGhMeLDnVlQCt6LK4+fKeiPdD+w+4xDBmlXgWZcGko9gErYwVvpuIVAOsFfnpw/7/O4
	g7w==
X-Received: by 2002:a05:690e:1341:b0:650:ece:89fd with SMTP id
 956f58d0204a3-6518721b5b9mr12869286d50.27.1776072809671; Mon, 13 Apr 2026
 02:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413090010.60339-1-anisinha@redhat.com>
In-Reply-To: <20260413090010.60339-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 10:33:17 +0100
X-Gm-Features: AQROBzCPNQstYoD5bOM-E3AUU_4dEQnR2dcVMuHGo-eva1X-zovzQPwiUKgqIfo
Message-ID: <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Misbah Anjum N <misanjum@linux.ibm.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is because,
> do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> EOPNOTSUPP error when required capabilities are absent and then the caller
> can check the return code and return early.
>
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..92af42503b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>  }
>
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>  {
>      int ret;
>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>              exit(1);
>          }
>      } else {
> -        return;
> +        return -EOPNOTSUPP;
>      }
>
>      if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {

This function confuses me. With this patch it can do three things:
 * report an error and exit(1)
 * return success
 * return a failure code

What is the difference between the cases where we exit and
where we return the error code? The commit message says we
return an error "when required capabilities are absent", but
we do the error-exit for e.g. "KVM_CAP_IRQFD not present", which
sounds like "required capabilities are absent" to me...

thanks
-- PMM
