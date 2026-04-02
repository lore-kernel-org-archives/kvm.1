Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE725C613
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090742; cv=pass; b=gksHZMexyE95GgGSOdShofJ/VW4V6HKZxw9gP3Gn4daraHzmlgJKXLkajCfTc/DDOO8ApAE3J3RrxgUOAOPSuOrJgrRxVx3m4WEdA/WpQk7H+04PKwNVC9Fqhm0DXpWqB5FuDh4iZYYRaeVjLDWJIKrE+DBcfKz/XSRXuRPM3DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090742; c=relaxed/simple;
	bh=iypML06J/fVo8aK/qstSGfmwvknVJLabbsaK9Ana1vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQFXQ/QzdKklJqccVA4RMDyIA4f+IBJ6xfd3HvHbqgL8e0gptpkTGEQ/yc9vqE9WmVa9vWDvDdqSxUwaGbJMjrMp85+zgKK82rqhD2UR6mMitO+bKnwTjhhAmFQajjqRLKAk/JahAoBwP/F1ma4RVspNTo3m0oUEloguYzvK2hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw/SE6y/; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw/SE6y/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f9568e074so50963766b.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 17:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090739; cv=none;
        d=google.com; s=arc-20240605;
        b=PfsB8wc5em7eVADGCokhKTJviUH7cQ4CvR6E8s8BLjjW9ugy950ZehyKSq5BhXbGGY
         3RnJBlvSKIFoXDLLHXKavK/gwP1f/4lMlX8emGztt5vk6UsVsVYFhPhf3KA+/4Gpdpgl
         4fkbPyP8C2crsGaPTJzJtl9O9QQio35RfO/z9caZzmHMvfx7Kdh4mK1SkKdvPczxrI8X
         ArRVYCjhOfu240NV4UxrADJ6qNHnRuyUNwXuoYvMePv7ZghAHhymiCGY5YOJaKrK2lRv
         Qu2+gNtGisZfqSvm1pAj1WhA2k50Kyc4v6WCyMJzy0F2cuZ+QtbjykNxfoEjS1z89QSc
         lJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
        fh=t+zX02BDBG5+PV8ZgASAufRPSVesOhMKvHKJ3IXd3Wo=;
        b=NMGWaqRprSrCh6MUezBAZ48cfE1yg3l7q0wNpCBAUWdx9EGBp0a2n72nYSYFzoedxl
         0lCBPzA1Ybvnh0gVWQhplyRy2iH4km93p6YU/D8lDoclNA5eQIUc0yvV3GethKwVgqNQ
         WHvpBrMdeUX6W3P2RbGxRFp293gAlThmrD8CtrSyl0pPzOhk0vFQWUl7J02lK71dRXpz
         MU2gCn9Sxw39p6XualwfkxPofvVhe4qikcVimgiezTSEVoisoBgdMNM48iJKOeuLE4hK
         AtLk7hZzQgDYc4+Sw8bQB3J3WTwPWZGdT4USe07srthxhLK5bvpL6g3LUnVR89+5MH3X
         5aUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775090739; x=1775695539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
        b=Rw/SE6y/Ntzy6RzBZ2UgFMyTebB7NBEyQJKJij16rlhD7oyNKk8+hrNyO5Khy/Y8Qf
         xNgl0043FDJkBFHShpzT4R5CYdmAZIAS/W/PHCS0/N3/ZIOZv66erO9rYV0P0jbhE6Xk
         sYUDqqMx6RWsSlbpoK2auAI8tIZ6256oLOulBPuJe5CAt2lByGULQAYMBhSIduJSwivZ
         9/3h1b/lbNwC1bkMrW5Fhx3Ac/tUBzV6sBJln2dHwAthN0qkIumBzvkgpymhnQWck9SC
         zZwwU1BFLiMQGzOruvbsbyByxkYxYToj5p6M0dwHZlQWmH3Dy96nXYAbtOPClUh4gcDs
         y4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775090739; x=1775695539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
        b=N+ODz4OeS4cgW1vN8EL8AhOhP4AZr30DeONZ7wrvelMRC1HUyLUFHDH1ArVcxo9IM5
         HyniO9p5kVrCsMFkSFNjqVfsc/nCm+JK1uDO4IahH1oz+z5cs/2wSg8kq6kSyMqNGb0w
         aiIuSDgGgxHaCcoF3vhOCrBePHQDCBRdOrWzwEWPPhWJO4iOOFZTXr8TgwkFbw7KIA65
         jGZ5P7dYw5pDGy68RP7T7CW8fUGMgRKpoi0gcHRzzdEuqxu/KhaXTvx5+IHObc6RkUQP
         wgkb6Y5iyqIQFhQVZSPR4+aAtscfSPA839nQ+WguUwIwhzmdaAYVTSv1kZ1zJiZ2tRw7
         pJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGeJck1C5Q7GsBk+9eaN039Cji3iVOhxFVEUUr19hyHliqZDIh9uQNeraJ5ekOLKzjScE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/uJ8rjkGrh/PBG/keBBRpuW1ucPm6iv97jM2yJi86Cn1Je99
	S2Qkl581/gDNFMD1cLZQOMBM/nIz5gtSxwMN+NXDg4hE1jBolvNzWGR0XV7YqG7nWedOyR12w+j
	KOrsWIPOy6NYnItI6+yiBWA07d3N8vWs=
X-Gm-Gg: ATEYQzzKZVYZgUziSYSSqAIgBXrUwTP9oQ0E6fkf3UbOxqw3eMKxF7jBB9X3URwtEvI
	7KIp8sB3gio9YQaTCy3IKifidjjqDA64qk4rVcrgL2pxzG9zkpoxQSwPwTnMvDkVjXT1qLT6TbL
	D+Zqeb4E7WLu5SA1D/7Ev6d+G6TDGpF8of0JDiMvXjXEKdbm7DxK6JMVYRloUaIApPs1m6OCF2c
	Yn4Klwl6AI9FJ6Nt4dCVDLBp7Yph9mH8Fl40xUWV7s3BbpsF9kDcLEItQKnHw7MWxjqgzTc42Qn
	CQ7xLqcd9ag7YLYalGWSpeVOKLcEWMC1kO+oFw==
X-Received: by 2002:a17:906:a50:b0:b98:8d3a:7d26 with SMTP id
 a640c23a62f3a-b9c138fa8bemr271649866b.15.1775090738694; Wed, 01 Apr 2026
 17:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401201753.92290-1-philmd@linaro.org> <20260401201753.92290-2-philmd@linaro.org>
In-Reply-To: <20260401201753.92290-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:45:12 +1000
X-Gm-Features: AQROBzCgjpsbOMdvqO6Me5z7QKdDwVgBMzoXedFW2J4bujABd0nif11HRMEEc1A
Message-ID: <CAKmqyKM0aBzpg2E8h+HziPDTL2sDQSNdu2aZfhPfhRiFw1gf+g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 1/8] accel/kvm: Include missing 'exec/vaddr.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org, 
	Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org, 
	Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, Anton Johansson <anjo@rev.ng>, 
	Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>, 
	Aleksandar Rikalo <arikalo@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
	Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>, qemu-arm@nongnu.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
> kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
> structure but forgot to include the header defining it. Do it
> now in order to avoid when refactoring unrelated headers:
>
>   include/system/kvm.h:404:5: error: unknown type name 'vaddr'
>     404 |     vaddr pc;
>         |     ^~~~~
>   include/system/kvm.h:405:5: error: unknown type name 'vaddr'
>     405 |     vaddr saved_insn;
>         |     ^~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/system/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda3..12f7fc8fb58 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -17,6 +17,7 @@
>  #define QEMU_KVM_H
>
>  #include "exec/memattrs.h"
> +#include "exec/vaddr.h"
>  #include "qemu/accel.h"
>  #include "qom/object.h"
>
> --
> 2.53.0
>
>
