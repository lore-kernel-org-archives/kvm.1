Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792648152;
	b=CjsEQA910TxzAO5lizW9bonL3dRXl1X/d9oyCN8ZV8tQM3Zrml+50llT7R/kDyMOrhdi
	 qiF29h880riIuOSa0fn2jucoNlbXq1wU41iDNR8FHF7etJdFMoJx6HuH6hReDLpy/W8T/
	 yuQECo4o+JOABR/KHG3IdeoeZ/14g7vbRVxZBvpLPCmEXm8V+S8Dqwh7GT5DBrC6Dfl+A
	 zlWkgRc4Iaw/SiGh4lmV5vEXZ0PF/s9gmFJDoIIf8HaeYIvB1lOGmcVutp2hFIVNCVIJ6
	 M2ZnJ0fPFnP89KbdprFmtMUataZE8VSodyLlTShPzo0O20WXL0OtBWSu4oFtcWiOK/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OLwqPe6nKylyfAeT1HYsvD0areP6du4KRg580T8M6Fc=;
	b=j9E8p5Cc66kvlBcZn0YcC5gzESnoQ30qstwxk8Zy8tuUeq9ZkLLSOwtAW9pRhW5liD0I
	 mlFy9PSMr41h2ESsNk5DLSMKFc8jKplLQMQZubDvyfO+tMDD74tM4Gq74dWzgwu8L522q
	 ijfUHE3qbfpQbBfjZyNIhskfb+hlr7fNKdo7HrAgBZtxPH1Pp0NrjAohqsG1tlSuXa8wv
	 smS6s3Cad1KEvfsOi3ZEcRc0sQyfEtIRSl+YmeVskXXXRCAAVCSm4OekN1P4rAMaTxAIM
	 AIayysDwMxax5TjCNBt42ANn8+VjG3rtBjAiw3OfYlvgUendeemaVTRfwJwixfIxrFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=FxzMc2HV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB9606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EB9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=FxzMc2HV
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so8288555e9.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 22:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792648150; cv=none;
        d=google.com; s=arc-20260327;
        b=VgYWE84oDkl3XC/Vxw3CDS7I9nEpTOrL2R6FSDSp5tEEvlhKSAESXLGJGo0vhYmO5Z
         B6X3FW48F2JjcVJgNhbQsavIj6IKc/j4LYsmO4LEIRnO4Su71ENrxiew+H5E8RVdAfWh
         FV2O0TZfJEI+7dKxkuYDKr4Qx4Jlu12/XEXIDrc5h9L1vM7vWl8XbnVdLoN2cAFovDfA
         UnWiL2li81KfYgIJ96JvVK0NOu1ogwIx0kXMLkg5wyA+reoWomiyKjNYgAOE3d3NJMXq
         jqm6qKArcsTx7l0j15FiNZdAI4pxO5i3hfFf38Fsg1eddTAM9qyd6qobWss91Ssk4WHK
         2zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLwqPe6nKylyfAeT1HYsvD0areP6du4KRg580T8M6Fc=;
        fh=UUcMyvh+amVhMOEmkG5SDcjP1kIGeX829h5IWwoLzAs=;
        b=NH0N3QQIx/Ba2CfkSieGnbETRlw/sKm4LGhXLNp9Y11w2cRv0rS8TVRl9KiY2RUf3w
         O/kCytKi0M1k0JCgi2ydVnAUc2xcF2+WhofrptKti6qETisZFfW/oQzyDfBh5wRNuaWk
         D05sE9mh30KUzHnswVxB/HUcRnx4jbknBjJEAhHW83/ynKZQ1WUKbt8lD7OkpD61fCtJ
         HCvt9RJ18U4K1qliSsJNCVev2ivEbdd4MZ2iAaaHPoWJYeVYNzJrU5MZzRf46JIyNqKq
         klyFjnvj/+NPCrBg8fAJLCtBH86W0EA63iZ2cfWEBWvnK99feagU8s3k7PlDLbK1sGln
         NhJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792648150; x=1793252950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLwqPe6nKylyfAeT1HYsvD0areP6du4KRg580T8M6Fc=;
        b=FxzMc2HVv8J5ZNXL3wjrsLGqJXPd+ONM7JttQMmkSUf79DQYV/GpJhNb3Z4dxvfGUA
         IXdTRyt4feW+Ujnpv+6kvIYxaJhV5IXEfPle/JcFkUYEYx9290IDYA6NuWjRPNeBU6ds
         8WEcLAV7eoIVOBiAAhezBtRFYDxiiwWzb0O9QT2h2xYJnEiNSIV00QCDvgpuBGhxoLO4
         Cr0ZHL8yGXZnNRsybe0k5Y1uaMS8QdEjgowK5ObwV0j3LAk+ijaEVI1XXJDt5jgQBBbs
         GGh7GvGVykcUOZp6eDO7awodH3HfoJ+fBlRnaRMI5OJ/R6+X+fgnwscJoqTHQz2oBP81
         Raeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792648150; x=1793252950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLwqPe6nKylyfAeT1HYsvD0areP6du4KRg580T8M6Fc=;
        b=weDFBK5lw2k2pZm+jNKuVLavKHZ2+ORMNYEDjrUGGwEaQ2Z2jucrYwmz3NSW/zz1Nz
         V7FnOq6O/nGgS4jxqjNL+7YfdBnH/J/N1XdhbwGOxTTfZtImQle0rhKZGLv061XPpHSm
         J6upHC8jyLZRKuxDsOWlVR3zW1dTpaZ5MLj+uqeSdZFTmQFr7xxs2UhO9R+R3kcb+isS
         PhJ4PqbLnBuR8n0oHUVPmcvvR/+pEIrEQhtrx6V882ih6jnMQXbkFfU3yW0zP+sD0Ck+
         yBan1uAUnNR/SufyPZnXmIssvj9cMLYZhEROTCkpSxZP4zZeekUNE0FKy8pPchqJtalX
         6u0w==
X-Forwarded-Encrypted: i=1; AKwUvBxGIe9Aa/moVXLkirVw2UPckC9GBtjZdvFYRLDzJhbX+VhNLw854JWF1S/XrFx4t4N7eok=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS4OqFHqVMq31CHoDw2yDLbluzmf3LxEAr1NZ6FNIHj33J1E/r
	CHu5hyZ4mhGQPp+7ZXBJM5v4KY5NJPbR0BtMi+59JpIGtAneUcdD4BVn3WgtroH5GzyLjI4C4GR
	JpKMYNpYa7JSlFKfM+N6FYUkydh1GRvnVY0OiUfbbqw==
X-Gm-Gg: AYBFou0Rzl2qo2Q9A2/X8XKfM7f3bTgkDv4KNzTCDGWH3dCm6ndK54fTSjgVFIdm4C4
	hU13yvBqsg8199fo/E5D4iydE1SiiIXPkxeN0qcEWxoqiicf6dBUfu034G3Oxv82F/5eQewI6gV
	Br5k2i90adV/ftCQoIS540e62PRw+Q0CCrgTlPjGVcu55SJBgAZDBQmWbEMbF547PvQ8EFE7yH+
	njCf6FktWaYfk8ah0fc0vemqaJ5Vokv4KnzJuAeg8vMBG/N4FBUZ64FtMSP1E3CaZm3sCY8R0Eu
	bRw3IJkIwhOD8Cq07wJfF2MHbHOJo4hgkALasqH+k+qq1GOdgX6vw1m+XDsIuetlv0xhgs46/YF
	f2OPNcP8HQMQL861drYgIdV55qOlJrqz8/6byr7sLsUjSsopOw5g0tMp8uz3GTConLsELLKnh+Q
	ZooUsmg40k6z7IVP9W8H87BoEwZcAC2AcYujjMf7lCzRq86CjCkZFddN5g
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4a1fd8a7d77mr86271145e9.2.1792648150526; Wed, 21 Oct 2026
 22:49:10 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260926055227.3678332-1-matthias.goergens@gmail.com>
In-Reply-To: <20260926055227.3678332-1-matthias.goergens@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Oct 2026 11:18:57 +0530
X-Gm-Features: AclHuK8thstWF5FcOG66PqU0xPPPqsryWezn1ub_Gddpp_AR2RhbRXCk-tq945k
Message-ID: <CAAhSdy3ongNF4xkLXYjEc=jNyn+=KT1soH-kPNY=5wZdoad0RA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: name the kvm-riscv/linux riscv_kvm_next branch
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 11:22=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> The T: entry for KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv) names
> github.com/kvm-riscv/linux without a branch.  The repository's HEAD
> points to branch master, which mainline already contains.  linux-next
> merges the riscv_kvm_next branch of this repository (Next/Trees).  Name
> that branch in the entry.
>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].
>
> [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergen=
s@gmail.com/
> [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergen=
s@gmail.com/
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 140eafcbbd78..16f6b306adf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14357,7 +14357,7 @@ L:      kvm@vger.kernel.org
>  L:     kvm-riscv@lists.infradead.org
>  L:     linux-riscv@lists.infradead.org
>  S:     Maintained
> -T:     git https://github.com/kvm-riscv/linux.git
> +T:     git https://github.com/kvm-riscv/linux.git riscv_kvm_next
>  F:     arch/riscv/include/asm/kvm*
>  F:     arch/riscv/include/uapi/asm/kvm*
>  F:     arch/riscv/kvm/
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.55.0
>
