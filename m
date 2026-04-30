Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96092344D9B
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564584; cv=pass; b=VA+JIkIF8O6Jtr1WJHKxBWvhlchylp27cBPwBDayim9FM51SQRmXL6Mj/+YU5z9/Pv+98M+up6oTxwRGDdVt2UywSapGeOtZO02pknmpRk32jYU6ZsIUfwTEXOgEN9K0HO33AHR6caMQ940/PxwfJS4It+S5mTRc7nprUZamzfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564584; c=relaxed/simple;
	bh=VTJYUql25eupJTm/JUHDzzu9EwTmKEBNPtYaM8Sh1Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilijAomPCg1oOiAWEL9qD0Svlj89t7P9DbbVT+edemye5wctQ9Y5tzL4fVX7tM7b9DRrenpRO3KGs+2qb12pYeLpQ93byjapzAkBTN1oVs0uZBHaglzZFBUlLV1f5s0TvxnpImoXnOEdETYmGgKJHmAlpQqUBOvlcA5zsh02I9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSX9cZzs; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSX9cZzs"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64937edbc9eso937419d50.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 08:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564580; cv=none;
        d=google.com; s=arc-20240605;
        b=EUDU5K3Cins89PrVH6vXPTphaSyTmy5dMglKaJIHjJWd2/sU6EpgQKT6gb+8q8ov7l
         KI8VZGvZhcFuI83A5WStkhmKErzzUyH5yQ/NtRWBOuOkNCVlAzv4vsjs2k0ygtBG9nCB
         1cC2HNZ7wwgZfwywWV3ViYULU2irBIG4Qi5KVaDUpXscJSweLw4jtum7Y8LdXKw9Z2N0
         4b2Jh94jPL9tUfK3MQGpQsxeEv6Y3yNmghoz5vZceYb769I3t5SbYxjACx098im7g40+
         8PkLB8hOIDLQevqeiSex5KHgzjMx+EE7ObShXXdMBf67BDizGQ7i1vg9Ct/cmHPuDCAl
         2moQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
        fh=bXcI0ElBKnA9L7iB3lsQYW3m25qaUpkq2nqEf6rqgoc=;
        b=DXLz9SYbED2g967ZGjjWkGkhvB76BkBHj7hocvvCHt38/yF7aQHVWSjJtvvKHLcO0I
         TkXc9tXKaF+OKU9nXv5pBM+c836K0faX7+Zx07xZlJF2HnIvPQY+bjzmrRAlwdGYUVHU
         V6LVbEuXm/gCzDuEOQEHkoAoQom/imRw08C+H28V1fp4h7uswgmvHy5nFgczMOxsoikd
         X1x2AYGxCVtqYpHnQnny9ozn2svpwOzaKeZ9vNJn+vNujYfwy3MAsl8kHNj6ZiandQ9H
         FSQ5Xuvvqc8lzvt0CEll0N8+JIJotiMGYdJ7aeUgkktRv/W6LW5h2GfgKW/5uPKOatEX
         s14g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777564580; x=1778169380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
        b=aSX9cZzsAU3gwdTn2v3SGuRLHa73eOF67gAPkAcXFJ25fe4jl/1UUhW6dECmtkJt8h
         J6oHgfwEcDR4Qpczu0XKbmQ7Wj42SWhROmOXP2Qa1f3XcpQO/enNwKJSe4IZN8dORlzk
         YVEEDus5/YWbM/9VWRm2eFMcC3Ku+nIYzB8IkZrdEfTOaqvz4INt+UxNodoEcmp0Avnl
         4S3cbTBVx5vcpSiwQok9z9uyv5g+AVqyPt9p+yQD5BrmaYyVqVxnKpmms/bVFZhU7Cyf
         GAt8VeW2IGERTPURfxjCASYFSwDdrKAR7SVKhsfctlJ9sqS9SO7fXQyNM5RSiME8IODP
         ee9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564580; x=1778169380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
        b=mnYYSliGiYteu2mi2svcDyIp3nUKGcWF3byUm59QriDiy2TN84sRbWrBjuNmJfyMKx
         VTCqHpK+RoqYXIm+kuYDKz/H97G3rIhoKHZw1BtQ2g4Fux5g1rqesgrHMHz1epqKIXFI
         9rJdE1fFtiDKY62XhtN0zyRmnyAD67SQcVqB6ERqpm8usaozsBya0Tfqh2cC5vf2iROx
         8kSC2nL6F9LIwg+rD2eqyJ0pxm5JcGXjocPdWo+ewajYVisw5ZP+TZl1uvJBlXDn92+u
         xvLBQySLMM03gJ46xeOD9+BqgFv6KCOYAPoAWFOaIc5g2QKABcwDMP+8HpNUdj8IveS9
         eaIg==
X-Forwarded-Encrypted: i=1; AFNElJ+pxXVOFv++nWIYOQK1EKQ1gEM2p53Dl3+OXjCuGtyghmfOs5P3VqNwqu9n7NZr7ZuCmjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe766GG9AJeaFCq6YGHYQ0Ig71EdshzZN+/7oi3sqYsdGW7xwD
	V1kio4g9+Lfqv1QJGxyJQtGyzCYn6iMpp+yco9GQz0JhljH+eAHYQGu5YgeRvv1BkAemK4gfZap
	xv1uPIkqwHbVFzRqUtxtX0KtWIrdUBgsn3DBUWw8S7Q==
X-Gm-Gg: AeBDietd8SVK4O0cJOGt6zWUXPLIgtJwaWZbJn15l+Zw2ZrC0N58qqukNHVrv8SenpG
	NemrXE8XhCmAcPjM9wT4O6OgT0Jzi/XjJIkl4lTvocNo4xw6iwI48VQzBy6zEab5I9/H7mozsuE
	amPYeMVte4tcy0r0zF3lLh4S+V07Ryx8rouw0g+Wyk/7cmtCC/V3iufOKvdAsrhfCjrRjNZ/LWr
	mrg804ofZQ+XDAsYscQPL2KSqxu6CNvdZys0EcjiJpj5cwikxZQR4jnj4kimk/6Msk/4sUhG4OL
	jBCPUgk0w9/DLAmvC3TFBLRN5BbPapD9tA0UIuWKb52zTgja2ArD+QUgSuQsH87ZGUmV/zU4Enh
	jRw==
X-Received: by 2002:a05:690e:140f:b0:658:e840:d5b4 with SMTP id
 956f58d0204a3-65c18ccf91emr2957670d50.29.1777564580128; Thu, 30 Apr 2026
 08:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com> <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:56:08 +0100
X-Gm-Features: AVHnY4IkTiAPQC5mp_5g4LgXokUDMDchdMkceN42WvdN5sfP_aNAx2N9fUv0J1I
Message-ID: <CAFEAcA_tcK95_mOb0U=69zXbwWtT-Ty1wNbbHUs-sanMEsd2TA@mail.gmail.com>
Subject: Re: [PATCH 26/41] accel/kvm: free device path on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 at 20:45, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> kvm_set_device allocates device via g_strdup, but no
> instance_finalize existed for the KVM accelerator type.
>
> Fixes: aef158b093b9 ("Add class property to configure KVM device node to =
use")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 92af42503b1..96f90ebb240 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4342,10 +4342,18 @@ static void kvm_accel_class_init(ObjectClass *oc,=
 const void *data)
>      kvm_arch_accel_class_init(oc);
>  }
>
> +static void kvm_accel_finalize(Object *obj)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +
> +    g_free(s->device);
> +}
> +
>  static const TypeInfo kvm_accel_type =3D {
>      .name =3D TYPE_KVM_ACCEL,
>      .parent =3D TYPE_ACCEL,
>      .instance_init =3D kvm_accel_instance_init,
> +    .instance_finalize =3D kvm_accel_finalize,
>      .class_init =3D kvm_accel_class_init,
>      .instance_size =3D sizeof(KVMState),
>  };
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
