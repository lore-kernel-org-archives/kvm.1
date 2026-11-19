Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113648;
	b=LeVQNGeGCIAHe6oFpzL3UI5/AlB+TUE6Pze5r/9t39OAnx1rbj1KGKGvpM3m8doQzmAz
	 93bsLQQgWxVZVzN1SO1rS5F5O6gs2+x5QWxxMFihdc1Sv6pa3XI2t9RU03100LKFus/5E
	 vQfTruXtHQRBWh/sQdvnVucgbZR2sIZNKLg/doWm9S8/UjUcCNwlvc5esVgJgswysX9Aw
	 gxtjyihQEBmu4luIS6t3gyOvUOa1T2YMt/gzttE+4NZuJxRarhlWZwQkOmE8qH/iaqHVi
	 DvuN1X7wc+JZnNgqH1d2D93bmH4pob5J0mcnaLQQ3lJPoyrIB04NzDEw7cfQU3Lr5mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
	b=CxkKcxSKXQZQojSzrz0ZPvtZNN4824yKNeQfmB8d6hjQy0HY5ke/OK2Nqpx0SD0kooZs
	 VAgaWvuGJ75Q7WNLeTpOkkrmBAQa1m6ySigWq/A+l8+FiG4QCuK1NFG5peIOwTjuluRv2
	 fmAp8xUaBJXLsY30Wua5u1K9QSZVnmsq5yoon0cU0FVIQiPaUpJVOe4d9JYunj6525XT9
	 VWml1YOKKOPatEYjiEgDF2P1i0/S3CqL4VdUr6+33D5NRA6DErGv1mJFqLFO4ViKW8ZC1
	 n7X8vDHZ+kuKnyctb7Xjgvu5pLt55P+wqvzEJscwjU6ZXSQfUo1r1939oB7ytif2wEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ILt19y9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D74D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ILt19y9r
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4c685c751so412867b3.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795113647; cv=none;
        d=google.com; s=arc-20260327;
        b=aDsmKLQLUVpG8iJGO7xwvGuqyyq++HOnKf/YjPjBXqtbHQGizEp4cuM5GdGAyffVm5
         hFxxQp0nZR7Ogzn1XTE9XnnmE67v/ZdIhDnzov9i9AL25d7F2QNytekmFAplbZ0EeVLi
         u+z9vQUHpbrqo6XpCigaf0V/HXzge3Ba419f9D4qW7gNPGGX+Kt72W660pGwp/6TokO5
         nBjWzkA3zCCr21G5Hxa+FTUHVCQu9KyJ/IQcKD4PRtWiPd4as+AZOZA+C2PU4zooYbSe
         A22uQD4ZdNqTQL8EqXGOZaiCqBXmb0oNeWBDYnNl63A5ahlefJd9NX065EfJZeXy5fVC
         ypng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
        fh=PWgW1O033Z6d8KrhNOlJn5bh+OTwlOThdGVvHAYXjhA=;
        b=caKbsm3HMJ4E9+OlN8GaKrIhEaomhiV7ZjEquJUQ2mOd8APBkhVLdChEvYYfKiQO0o
         T16+lnMy4NkuZYCxoWEKTLH9V1DF/dmjCwxLj6OMwu7eGQcD+vsTgSzQdiQ/9DCemGzJ
         lXKVsQZno0T3kfCeUuX3gleCVHuKG7qtM0Swo7lNaQMyJ3irV/06qtoo81B5W7G6d5ua
         eDLt08UYXv2/KEtViIV4s+Jh6p1fi+o9rpWFxXpSpnXwSrZeBGfdSXBqQVwkLb3ZPIto
         2+cJbRDriLVrLzKMBt/sMv4VX4A6vcg0rfDwHOX5WuwdXThS/lEziVmEpv4mdLhMBkUY
         eAeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795113647; x=1795718447; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
        b=ILt19y9rabSAOlz9bWXtlPJQ0mgBwGweSia25LsTBEVmljMTEeyl9J1gF28ozOIqLu
         LVnSmQ9w49Jr1UCEXmOvMLaVaizJhdAkH+5Tr6bG+qevlfxNKT1RoauWie1Drncggrx3
         A23JQcVPmjJWnKjqkcAOe5zeMwP6p5/ix+bl6MODc9u7IRlzeCoHAXDqBKWpBkwE9Uk4
         hf1B5w3dF6TyL3bx7CUlBgK79ZydsMIEGn23drsVTTsO8uYvLvc1osB4elU9h1Zx1H9G
         krWKR2kikSfgmYwQk10R47SVbUWyu59XY1VKjsAW5Y880pWq2YOr7swgxbLBJZ9MZYBt
         U7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113647; x=1795718447;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
        b=eBYXTzAHXNvRqh8wdupxF8FMt7Z950dcla3vwhoXVPS8rIV/3YsavChKu+HnuCShNX
         5oJDObFAoEPkaq5HeMnh9yZ7oOEP1bLFZgRLDwYoMAZF1ZVVtnqmeCbUhrhyYcTLzEaN
         PDwU+zH/qZg2yvEsNRPWqe9l0sKbixXRf3EosnCNeDZCns57fPpLgONXcSKNHmOaB9tU
         wCADYoOhaeQELWKp2+JDQ5bCHTkoIxzEYEWOzJvamQDNvf84Fm+n4/I+ttt+AKfOOs/e
         JjMGN6BvdfO9ReisB27J+9erQOcEkn7UwA5rIs1KqiTywaNRcoR9EtNQLYwt0WbxGs5Q
         wlOA==
X-Forwarded-Encrypted: i=1; AL+hErFn1BWJo7tnu2BNhCEiq7BnzKuMQlRAVqVlYl5FL/CHGDL0+KUcGKB8QdD6NqHYHTz9qDM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/03gTGo037VI6KDM17RKl9CQDMWQ9IbaKaW2UPKDvMwENstwKK
	4wwtwBTIHg7zuQK67cJAQ0DbrWH9iO2WiHJ6x9b1GZLWGa/q2YjlPHgYW9CpbhXIDwudLIv387g
	4gVdqNjtRYqSG57a5cdwXCZu4xMBZ4Vimtk5i/J0/kA==
X-Gm-Gg: AZFdTZdzyYofgUyK58iCw7HlIubywxgOlJLkBxb3ZSG8rmvdotUsZvKsdItp4osskjB
	6n4WEOgo4GlJqd/EzkUOX1QUyif9jaiulgGpLtxq5RXXCObuUiD/K1lezkpTjpStKBqarrZG8yN
	qnAbLN7jhuOtpzUpIDtwoE5BSUW1RyddX10Fr2XrtFT5rDOB5y4pujji3ggGFpD9veoD/YHF/ZQ
	S5h/sGQNZ2t+WK4H17RV+WF5snn5LOfXUzd3iVJxnxVFo6ayPR859JLSNH2/OhzQC/DiGUEpO8w
	sbS+9wsGmOL5ZrwEyuNXJGSW4Beebkm+ORZlsMK8ja9tr3Ged6fnEJSBzV4EgQIa2sUA8n4OwUi
	BvcfcyxVnptMZm+nmIeFmnhv4lsO1L6xXn6bSBo4N50plvBEuaVAyMSvcI8oIx+LwWkJiNjSfMT
	WlT45pJO1AIGxJ907lh9BG
X-Received: by 2002:a05:690c:dd3:b0:8b3:8d8:e997 with SMTP id
 00721157ae682-8b5204e2330mr2924437b3.81.1795113647105; Thu, 19 Nov 2026
 10:40:47 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119180859.1044425-1-jsnow@redhat.com>
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 18:40:35 +0000
X-Gm-Features: AclHuK-RqLZ0_vbXu1GNXtzHg8OBsUVF1GTw2kG-sw8IhGr_ntzvM6dj-NIZxYw
Message-ID: <CAFEAcA8JRxANnfUcUhy7qoKaoCY0e9qJk4UKtoC7FVx3RD_OJw@mail.gmail.com>
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 18:09, John Snow <jsnow@redhat.com> wrote:
>
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  target/i386/cpu-internal.h |  2 +-
>  target/i386/cpu-system.c   |  2 +-
>  target/i386/cpu.c          | 30 +++++++++++++++---------------
>  target/i386/kvm/tdx.c      |  2 +-
>  4 files changed, 18 insertions(+), 18 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
