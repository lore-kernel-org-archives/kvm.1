Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4A3DEFEC
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248624; cv=pass; b=M5om3UbJ3PdtuBJ5LAUJnQQf8XInZE1JajRjQDTmA1duUvAtusU7Y0RjBzObSBq54DRp+My9dkB7t6/ywb4LpSyr6w30deBdrlz410yiiPG4NvKR20Ym6hrzeWHRfeNtTxztQHmcKQRpVRB0xFil2lulry4sw/PexMSxdrRgngw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248624; c=relaxed/simple;
	bh=7yFf1gwEF/eReqW1I0wMnn/542KpVJQJx4afx/LS4hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC4DHO9RpAfETrpq1A16Wrj4862yHKDIeJHEz905ED9nX2NeuliV1YXkhfkx4i/mNMPZ3F+EeTj7VJCIqdrs8Ri2bjGldT5sZwZO6Oc1qWWyuXykAFBJSrY4zQ3Znxs1eTIh8Hm5m9zNyF1KE/WtHnxosNRxKVGwzfBRrFk2jb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyA/Zbll; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyA/Zbll"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d87dso87502d50.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248622; cv=none;
        d=google.com; s=arc-20240605;
        b=GqasrdRBAbeyP3jLwNbSsZe+zqbuLZwXNVF/+p9OBiGczKzT9UWgn6LaZhKk7Cofoe
         U0aIrroNhwHExgZw5Y6tLiEGiu8870WmkVwQhsY2b/RMslFtAZinrFQ91Z3gwUPT/ptj
         pBpdSdVzPpjSNyWZa+AmE0iOQmsd8VZtrUn5KV6H8teOw/25W+PwR2/ykIi9yjw2FBoX
         gQKJwoV+4ciBqYU7lVhGnVN0D/ZYAiFYRZsc5SE+Kl16GsMnYA4+g+TmJ7UhyeygpYan
         uQm/SAjgsNywcQM25OUZLUwuhIKjtiuiyEwf/KyesDQ5z2AUm7YO0mV90LXHK+YReRwn
         bjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
        fh=SEuamq4GLMt38WpHJIHwd4qzP9a1dmENpqYxzl+ZhWI=;
        b=L+G+25rV9bylXuZPtFeIy+yYQuCCvKghnQE55fk9hIHJyGFLGgwn4cNZEoQkhrUMyh
         8effo3FCesi61c1OTyshvCeBCuAWzqgUnx7nzIj8VU5qSTU8SghOCAqFs/s+7EsEsgeX
         3PX8gNim3UWBXfi/GSiygvYmXeDTrrBWWTE07mcglLz7R1HbIEVeaZJtSuCKGSx5co/Y
         LxKxRXHUPH7wL6q2JyqOZqbboCrIKfTc8ED0ogv3GYLASfQfo1YpXvO/6kGCDzmoDC05
         3kxyBAgDTeA1H1RmFmtrxCgxK5wCSXlgQDCr7qJKJWP2OWFTsfcJOFdYecDw46XzC2KY
         d3Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773248622; x=1773853422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
        b=jyA/Zbll4KpjaKigrk/4BcNFwzJARQBXPKmnyjhTX0S+alZt9Z+cdTWGyI054V/d0p
         YeRqvY2Ofc6Tys473QaVk3Qt4O5YoDXcNsuUFLFewbBWgwJnxzta6nH21XAcEiGpDfZl
         XJvCnOgELjX4RfwRYxRfJQ8JzZgxgcVAc5vvKs1bOpXbx7+lnxzSeF2wkaVcdHminlNT
         VAhi/CsUT8YGHW2/PRUCpF5cjtS9TIlLDb/U9ATACvLQhcDTCJIAB9F1T//yDchDM2AO
         F/lNitxQ+pklbQdivRugTUtomxU3Ci38y0yx3P4qQnSEjfusDH7eOndOr+KMMoPXbWGp
         5HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248622; x=1773853422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
        b=q5ro4AWTptUpUNVkRAOEi4g21J0rP4EjjqV0AD6PbKlx7F6lSc+uXU7hAGeEtFcYk6
         QpRj9v2Dvz6cLRfGWDiUQdofdNklHRt4uW3HyQMQ7R3Axt/G3ohnEstjhqhcOGeSm0v6
         GXLtlEXas1TBFBn2qgZADyagpA3/Wh/8cuvZC8D5D2DqntnjJkmMDFy5tuEi7BgMXCGj
         xVoqaanlujdxBpObCkQqQkNthOXZ5ZCoOfMAZlbUUd0XfAtm0eBfl9pHpwdg9rsqzeNW
         JF/0kufrI8L9vXQ1wGtUMBQm6QrtBcbyVi78L9cR2KU9DFRg9CDIArNNQ6y3pFQ14thJ
         MwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpWWM3fJjv6ZuROUPE977iARp2W5uFmDrxcCOLsWUZlPu12vEBXXT7tIt4pACO7VMLjDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycPHInU5n+dPdnUN1Wd1kKkWJCPm5gLl1Y8vhpXmldQ8cnFg2
	2Yzc8fhBDZ0flG0F/UuC2SpHJ+SjiIGKtMGAe6RDCp6yHqtH+LsZNXhLgktpoRLyqTl/DVQC3g5
	FavOaPTILmc99CAm1tJnJX3EzKCWU757Gg05Oj7K+ukw+9ANd/ShR
X-Gm-Gg: ATEYQzz6OOi329h79PCEGMCudyJctQI1sP0jzlMcHBfIyM69WL2itKDHL6Yy6lNF6MJ
	SfDr8gyM+4L7iNATyDvMFKtlYveYUYaWvOQtg+2P0zXBL7mIQhc2PTw1iv+5qxGOd7C5YK3kmWd
	ynjftAQ3XVYdY6lRuz+4wCchPt3ZGlBo4/WtlTJsMHQscp8hpKVA6ww1yVWKIRKXOnAlVnqNIz4
	I9gYeWqeqXVaLwvrlrvHRMYtrX/S7T9pcKW5OG8cPV/JGpeIQa1CNyvyWbYkCrgFx+L50lOGhMS
	iboqM/epHXpagOPCC/tiHeGq3udo678FzD9wT7RZWdEfDFZNoDDO0qpfs2RWfjXpsrU=
X-Received: by 2002:a05:690e:d09:b0:64c:ed9e:2e22 with SMTP id
 956f58d0204a3-64d65823d64mr3091544d50.80.1773248621603; Wed, 11 Mar 2026
 10:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 17:03:30 +0000
X-Gm-Features: AaiRm53fXzB5o-jO-zwjARu-4kwiJI74QwIG80HyHBOohcZT9gDOVcJOmSsF_wg
Message-ID: <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>
> If I create a machine with more CPUs than KVM supports, but specify
> multiple accelerator options, QEMU will fall back to the next
> accelerator.  This is great, because if I've explicitly specified
> multiple accelerators, I've told QEMU I'm fine with any of them being
> used to provide the machine I want.
>
> When I create a machine with nested virtualization enabled, though,
> this doesn't happen.  KVM often doesn't support it, but TCG always
> does.  The nice thing to do would be for QEMU to fall back to TCG if
> KVM can't provide, like it does when too many CPUs are requested.
> This patch adjusts the behaviour to do that.
>
> This is very helpful for OS development scripts that run an OS in QEMU
> =E2=80=94 I want everybody to be able to run the script, always with
> virtualization enabled because the OS requires it, but for it to take
> advantage of KVM acceleration when available.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  hw/arm/virt.c    | 6 ------
>  target/arm/kvm.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..0b63b2eac3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> -        error_report("mach-virt: host kernel KVM does not support provid=
ing "
> -                     "Virtualization extensions to the guest CPU");
> -        exit(1);
> -    }
> -
>      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled(=
)) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",

I think there is a bigger problem here. The code in the virt
board init assumes that the accelerator has already been
selected: based on whether kvm_enabled() or tcg_enabled()
it decides things like which GIC version can be used, whether
"-machine gic-version=3Dhost" is valid or not, and so on.

This bit we're deleting here is just one of multiple checks
we do that assume that we know the accelerator already. If
we actually don't know if we're going to be using TCG or KVM
then all this code needs to be rethought.

Paolo, can you unqueue this for a bit while we think about it?

thanks
-- PMM
