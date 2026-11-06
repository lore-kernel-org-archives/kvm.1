Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958852;
	b=O0V3KMZIrC9w7EVDep5B9cAQ8ooEQv67JTuBPuWm6zBaapPg3aNyHmtEEbgjHshLeFiM
	 ZYil4fHqu+sR7Scmb2KbWHwN1V7GQRf5um57uGoTkYibUPCZ7ouBESHE3jAph+XtT0dg7
	 lBb+9GG2bwbuYHzj78ZIepFsguG1y/iifU4vMY3fNbdDuk95Z5IQHVeEZwfYeMuZ7Ajsf
	 I6eL4a+t+uG/+ubGv6QMiUFgNuUnt3LFHzmsc6SGGr1wGLriPj29dwh6qGgI2gVZ/lXTt
	 LrM4lmrei1C9BxAjYvboyGwtdblIWP82pNoNyQdJdKtPYjedarbb8PuUyjBK6C8vG7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
	b=4XxZv0CcghXx4kYaBYIiarJMtlM1xZcs/qRv2zyAwtOO4G1cKrEV+4sBcGYBYKMykpyX
	 YVQU39rt/xivpBMmmZof2z3CXESnWhV2n7DE+ab2tQuAuBS31x4ZFzAS4yLoVzwM2nJHk
	 W2yUbKN5cPwc4S+acdCykEItGqelVSj5NrHVU633DCZNUNArwK7YZz2m5f/MkENlWVdxA
	 hxZ+WlbQC94qVsH8lnRoDaNiZSYMl3IQYR7IpQ+qRFekqp//Apj846lcLdHIxvkdj9Fte
	 pH7vKMOpQto3DqiXXHBxFb/miEM3fO/bwxEBCwBYUjWsjlU6u7D9xU0LR1gBaspXWiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2GNyqHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10EA606A33E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 09:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D10EA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2GNyqHT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so418559e87.2
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 01:54:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793958850; cv=none;
        d=google.com; s=arc-20260327;
        b=G1LqSb7XD2R09H6yrZ+/SzvJDOAT+sGeeE+pBsn+9T/Zx2VVr8V7uICEW18qwRh1ji
         WFGq00vpNYDO2rtZby7/jAgCKw58TW3QqopJmClWM52RESiCOPNY6UYBuIwzlWR7kKlq
         hWHDj7eQ7rSN2F/B1WrM0yltogxHefJfpeVnN4wpuASYI3VCYo9w1uqqbCN1aOGA+dRr
         ZAX+xTRr7hDLK4HMxZcyy1yjHVIffQEIObDUfG/AH3d87skAcndQwD4NQvTUX2Frw7Pi
         GeNEE2nCSFdu4dCQUKnjJvJ9+/qfEGPq8V5ruHMs9CHIpWO/tf9ff6aEjjlDi1Yx0lB9
         w9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        fh=AqsQRUwxu2UaZ0jOmVysYCKrI4E3gHJWLf4Ea/M57IA=;
        b=jXtNP1lRLamVVpTUcfSMQMbwlXKLqZuF1rvNHFEINNVxUMiIK2kgN4ZmlYJOXhPIO2
         w6ryqJcJv8+xD6rTg6w84JHvbynj+p5p9XkGrFkISa/AcQly6nr6HpddiZh8uOmNI0CH
         ypI/X/vQEcSXcnpy2uk3QyqymEbjSYCsm8jQyPKPDlD5xABa+7lUCoRqz10jNf004MbC
         Y+fxiV8Vvbc9KmFcI2y7i7R7H/Bxbtd0WtvGDurN/4S9P0rtsY11Y8jlmQP7cb5Ulw/T
         zD7QzJCc1GvFIVnM3H3qTnpQz41HXBUmQoIUoiF9WBGCOP4UOpBnzUmOo6z44DGojf1j
         o6oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958850; x=1794563650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        b=B2GNyqHTw+bplblnkMuH26j++KRCL/oDDyzsrqB1IxCYAMLGUYggu3gxNT2HsNDBzk
         6E5ynqe9zZI51CA4CZ7J2o0PRN36aP2IXdnJcNRVXbZcG6MeKiFfZKhF29i2YRSmgFQs
         g7R5UdpgjxiTPB/5hvukxDxMhF+d5+9E9to2AT7qKjgCT3iNz8qv7pM25iAPrftwNAfI
         L19rw91YsEZrsLLabtq/odhS9rCw5LlF7vEIsP4+WkK8ZQK3S6BeNJueb9m1Bo6vsKze
         zRxwFuPIgYlpu7mJdcYd5igFvAibYDqAUKXo5sBnWhDU+vtX95zUCXDCm6PkmsxiH+IH
         EKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958850; x=1794563650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        b=i58t1KVufsMf1pkdM31wjbI1RBrIpN99L5bteZ9YbuB8qLkjq8/co/IpE5iJnUCqIj
         5VgAPKXiabj8HO+jLtPcM24N4B289KNCsi9vd4llBYF1Lr1wYknYFeg2fkPsmpz7hHIY
         0EvzfrzxiCvx8JZh2RqR3kZUwK4ZRTleOxJU8vtAD11SaIOyBWiT/CSPnXGqiBYZRDjM
         WpQ9Pe2QXsX4DbchrOqYJA5+mKibGHybMLGK0wfQ6SYkJFqXMShJr/vhFH4vEPSOxE4U
         r5UsI0t2mSyv8mQcxiyvFUZAQHKN8cHbYZh/5YuCcf2LxSvNI8fe567T8XZKVoZG4HcL
         G6Zg==
X-Forwarded-Encrypted: i=1; AKwUvBzHAZtBNboGSpK3z9o5Wqhw1VbL5+vaNe5jlVNQsmcLTHCLgpqV2DWV54J5F4fOlXpGQfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JiQmSJoU6oyibF0Si86QJvfbn68t6UadGJoufQLnwvMhlpnBO
	bhRYhUyhXwXMdOQzWDKW7L7K7LerbW3y4hP9RB+lMmMKv6up6cdKvWRDAm09ixAmM2/wpqy427n
	WUTEB1CTG51RCEOUKrGMC3fNA8XvZKVA=
X-Gm-Gg: AYBFou3pBT7JTNUMZidwo5IEqCjRG0mgO3Ot6Rvhg9RfbymfL9akvU5Kyjd93ieblPY
	ktxuMNWwez6z3NkE7nXlMhZs5s9sRdmA6vzuisrEjyLUuK6PjogW0iMzGqF1RJnIaV+odyS8FQA
	Lq5GDLvXoSaapWf/+4Bv2JTTkUMPQyHZGKIm/4ad0P2SN+P9hArjcVtuenM3OhyoHJThv70fA8j
	YkRb/R+9A72ssal4srM9rdKWkb+meQ22OMUsi+rZ3D147VcF9nx7z98d1iyzO91mKzovOeasNTB
	U894bsA2QUHLFt7T85mO2lT7P6SvcoA4BIlNkFlEDwSFHoDhq0z2IYHy5R6Kt1skGYwyzoVaKoJ
	11GpHry1JOo4N5gEb8gNeC0LEPEsSqA6LNpvsvnypdpoQlzd9orSd9Kv9mdS3uNeJ1qo6
X-Received: by 2002:a05:6512:3f23:b0:5bf:c239:71ad with SMTP id
 2adb3069b0e04-5c003ad0afemr607795e87.38.1793958849775; Fri, 06 Nov 2026
 01:54:09 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017030927.345454-1-suunj1331@gmail.com> <20261023115747.2545223-1-jinyu.tang@linux.dev>
In-Reply-To: <20261023115747.2545223-1-jinyu.tang@linux.dev>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Fri, 6 Nov 2026 18:53:57 +0900
X-Gm-Features: AclHuK9nk148RfY2GyVdkkH5dnZpSne9-B4ydq0oLeo4XvcO3mtFibrpLrfrSO0
Message-ID: <CAGwK=3r0LRuhYNWZ1Rq573qWFv9HNwHE_MxqXJa6Bfuc1QtWTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: anup@brainfault.org, atish.patra@linux.dev, tjytimi@163.com, 
	inochiama@gmail.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, andrew.jones@linux.dev, 
	pbonzini@redhat.com, seanjc@google.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:57=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
> Tested on QEMU 10.2.1 with a private memfd mapping and dirty logging.
> A guest read followed by a write corrupts the shared backing without
> this fix; and with it, CoW occurs and the backing stays unchanged.
>
> Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>
>
> Thanks,
> Jinyu

Thanks for testing this with a private memfd mapping and for the
review.

I'll include the additional fix pointed out by Sashiko and Inochi
in v2 and carry your Reviewed-by, unless you'd rather take another
look.

Thanks,
SeungJu
