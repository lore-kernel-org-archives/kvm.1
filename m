Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804738B149
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620817; cv=none; b=vEomCL/E1RVT6qAAdytbvrhT9ZdylfvHbBuIZP6qUv/ciM8j1wa3NafQVjZ1mQKRtIeVUdF7/sTkjc0/IuZJk/UGdrRpET/ba4JgcpdoYVOaALO9Ynit5aDEQOJkjOyCn+xBdsLPUUEFA03sL7wTYmqeP3GgveVBJ1TnrGSzUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620817; c=relaxed/simple;
	bh=jI7Sv6dqu67mx/4yCMTsESjYULfCa0K0RrvYfIjlPgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPsnfSqltCu2lJoPW2eGHTXaiLmD5jL2BgOYuq8j3M8eDKToZGZUMbO82atRGVd008JYOEVisBnc0zzFDutu5O8wNNa06LwLPUHAO69OlPdUqQyY2rOxSzaAHb+w6eAjzJcQgDMiYd5VyM7fT6HS2bmKEDcb1AV6yJlRJmpAALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu2kGYnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu2kGYnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5451F00A3F
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620815;
	bh=nbJyISwukvfTNiu4CgjojEtsvVpKNyChClBc6A7uPvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hu2kGYnjF6VTA8ysP72FhkgAfp3R0tHfAbFkl0lksYtZhQkP7+h4u2fWpnbVE17Gz
	 PUlsaPMmzMF63WaKN+bRHWaCQB3z3f9zLbRfBby71ErSTj2zM02QIqD15YCMMBGq9v
	 gdhjQLTux0he7yAayCvtTWKVjtQZJKERMq5y/gJdK1N104tDW/lWtXwHi2JNzlyyHW
	 j080T69R1nm3QjR5TI4tl1GDQdKjnCMKSM5giPcmz7i1Qjci5JMJWCR9LMmsKRl+vj
	 ylF/07huds5xVDJLhuIqV7du8/oUm+xlUIm0QcPaqr1iE6D5X8i4MKZXHKWDqvjohY
	 pdF6uEOMsesJg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a7f5655823so1299520a12.2
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 08:06:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtI9I7//tGRoXIjIdK8+kfGxrYLdUMM/dqUaYISOjwYdJBz8XA3GD25/tu1jmI7aVxehI=@vger.kernel.org
X-Gm-Message-State: AFuF++mNbQU7d59kjmlhrtbQroi65I/z8EuaFLSbPG5m4pLJ1ecUs2I8
	OigcZS4LBkqd82R0+3/DFiluAArVVmNj4aKwZ5hCQXCo9myvl4cN7opJ3JvRR18WrlgwYzLTWQw
	B7jenZba1RbTxNs2cSrt5Vk4NN0EKg3E=
X-Received: by 2002:a05:6402:4348:b0:6a7:e5e3:35a7 with SMTP id
 4fb4d7f45d1cf-6a7e8e92bffmr4264685a12.18.1788620814049; Sat, 05 Sep 2026
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com> <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 5 Sep 2026 23:06:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_JYL=V9xJ3tg7_icGP-2MdspNw6upU6T7YpOqAe4LFQ@mail.gmail.com>
X-Gm-Features: AcwNN1WD2efM3XhoaqL7ottq-qxRaL6RjwMjDJTIzqWK8m9MWRupmYERi2b7gLc
Message-ID: <CAAhV-H7_JYL=V9xJ3tg7_icGP-2MdspNw6upU6T7YpOqAe4LFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] LoongArch: KVM: Fix kvm_loongarch_env_init() error path
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	lixianglai@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Wed, Sep 2, 2026 at 3:07=E2=80=AFPM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> kvm_loongarch_env_init() leaves everything it has already acquired behind
> when one of the IPI/EIOINTC/PCH-PIC/DMSINTC device registrations fails, a=
nd
> kvm_loongarch_init() does not call kvm_loongarch_env_exit() on that error=
,
> so nothing else cleans up either.
>
> v1 unwound only the memory and the perf callbacks. Bibo Mao pointed out
> that the device registrations should be undone through wrapped unregister
> helpers, so patch 1 adds those and patch 2 uses them to unwind the error
> path in reverse order of registration. Patch 2 also uses them in
> kvm_loongarch_env_exit(), so that the device ops are unregistered on norm=
al
> teardown as well.
>
> Link: https://lore.kernel.org/all/20260817115847.2705791-1-nagachaithanya=
9911@gmail.com/ [v1]
>
> v2:
>  - Add unregister helpers as suggested by Bibo Mao
>  - Unwind device registrations in reverse order
>  - Use unregister helpers in kvm_loongarch_env_exit()
>  - Split into two patches, so the fix only uses the helpers
>  - Reword commit message to avoid implementation-specific details, and
>    retitle from "memory leak" to "resource leak"
>
> Compile-tested only, no LoongArch hardware: loongson64_defconfig with
> CONFIG_KVM=3Dm and CONFIG_KVM=3Dy, W=3D1, each patch built individually, =
no new
> warnings.
>
> Chaithanya Lagisetty (2):
>   LoongArch: KVM: Add unregister helpers for the KVM interrupt devices
>   LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error
>     path
>
>  arch/loongarch/include/asm/kvm_dmsintc.h |  1 +
>  arch/loongarch/include/asm/kvm_eiointc.h |  1 +
>  arch/loongarch/include/asm/kvm_ipi.h     |  1 +
>  arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>  arch/loongarch/kvm/intc/dmsintc.c        |  5 ++++
>  arch/loongarch/kvm/intc/eiointc.c        |  5 ++++
>  arch/loongarch/kvm/intc/ipi.c            |  5 ++++
>  arch/loongarch/kvm/intc/pch_pic.c        |  5 ++++
>  arch/loongarch/kvm/main.c                | 32 +++++++++++++++++++++---
>  9 files changed, 52 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>
