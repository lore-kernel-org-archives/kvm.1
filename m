Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19F3B8959
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038010; cv=none; b=e0w9/8oOTnTDom3HxionfhITwnfedvEIrYLTIjDFd+rQEq1e+a1RGFrqshcV5lCl78JVwcb63cpuyRd2p7Y3Ys1z9Lh3ALk85nYsiiI/z+UySoKr9AVqF5Au8W6MiXamwQuJmEgbtvHijERSJEl+TNQmdlI0DDn2xnyZ78YmWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038010; c=relaxed/simple;
	bh=UDzFuqayMptXRxyD0sVNI7x/dzCA7DIHFk14h2KsjfE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=O1clgqQ1wQbldBwgMXysjMMHWoEm8q+OuZqgW0GZ6O7LsfGAW+4P9N8ltFD+VKv4povwpSsKvKR1QIydcapvEKBMrFIkmXV66dBfcJffs4u3OxezOhF+/vgb8OY6CojYYXNypZLtiBeB6/E/XUr7RZ9XZICCrQ352kS6CooKaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIIrBGJq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIIrBGJq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b3d66515so7111630a91.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038007; x=1789642807; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NSugWeaGjWWxPTsA0WEUYFCIdkRuKo99PwV/yfMvTEg=;
        b=gIIrBGJqKIHk8cIyZEkCNQjmwhSOmnmB5SUHt4Pmb1Gai7K+cbZ6ZL+bUqRhSz5RGg
         vCfMEjdeRI/ZCrOCx3672xDJJNn1Akxim7g183QajbfB4c6kDZ/rayTsaeAxNxcth+oo
         ixs3gdUdANlnB26VAQEJ7uQu0C7hL1mlzZuSa4fxF+yTaANzfSWPzDfrQXGZfRhZyGn7
         oBYuZjmmgg2CWMTu7c7tW9s2lMQddbsSooAMIQNKVYZrL7qBR4hcEuXyZPFRaBFRnf4V
         6LEholhrwxGu5atDEOLGDKxj+tHvLugO5bblhPowVKJJSbwx44AKO6H6h8N4IwQ/rKMG
         cEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038007; x=1789642807;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSugWeaGjWWxPTsA0WEUYFCIdkRuKo99PwV/yfMvTEg=;
        b=BP1sT6LH9AabnR4uECdIH53yYLdRDhcZOBidfr0bMQ/aJgwjZghSI9jY2P/5HMKrBx
         16UiMpEG5NkjWcnlCWZxcyIjRt23P9Iiyz0mzuHXgZaq5vcE4qD/zDJiOXqbxObxwqUd
         Fx2s3CVvADiKEtaYLu9heRgDWrnSnjXs7kNVnIeqw+eh9KqyXPWhw7y9J3P54hIC+Qab
         Ev2c9t6A37JF6yMZdC9QETIjXkk36NFrX9jK6iBenR3c9EADVBYpnUd1gSD+0dvj11QF
         Dk8Oc3/yr3SNeYU5ixXZAIrOoBREJBEAaBgKcf093cPmKuGiaB6qzwapAlVDpfFKdaeL
         xKGg==
X-Forwarded-Encrypted: i=1; AKwUvBzwDLBZIFE8SC7G/gbpSXeE2morwlBflhEba1qjxoya7uEuUPZVpeMvHMAlWFdzgpNQG/U=@vger.kernel.org
X-Gm-Message-State: AFuF++lHTfC/mvo+NyuyjVlE5ypGnqueE8ZTDXcGPPxpGzzGFhBbh2Zl
	hmrVOwnfaP3M5De364Kg+ypjpfT2WC9DxNo80S3rclu7exH1IIElG99m
X-Gm-Gg: AYBFou14iqJxUz2Lg4biXEZYFxuu5jXQGiBz2H5901l7iTk+TBd7v54M0A/MbhKoOgZ
	V9Iv6uePnpvW0ZA4FDsiLEPn8rBTacTeWwLbhUD43rj4VtlpHG7h4GGOBZEb0ON29k13HZS39zT
	Kakm0BvMo9aTv1HDO4ZR+5ww/tx4aS4nnFzGqkbHouWBBL6MRtVtmQEHtvIh9OAjF2g6zL6v8sI
	JrRh9U0+WygUPr0JgkoUqdoyiBaKbITu2cnOZuRMoTc4IpL4WZygBU2qj0vFUBls7lzNyn6ycHg
	PTBZFxiIlTfEI2MOPINDUloZHxbsqYtscBuQJaaMW6n0e6xQw1X40wdAF0rSVKI4ImIwTtFCn64
	AIF1M9aKfzcxhQWbbqqCKvNucvfoLJLN1EC67jHSG6xl7herjHdhRPxXg/tZt6k+MsfXkoUKBvo
	BNivF0q0OFms8MSTtya+sHwE3+AVKoT3c2Px3JEocK+UEIDg7GYwIEp+Pv02QrYUUnvOXW3+95j
	niVt870Jp1XaDZnVsM1Kd46qcOQzoOoLqT6VSXar60Tz1Z5yBmOjbU=
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39b26277673mr58529054a91.21.1789038006053;
        Thu, 10 Sep 2026 04:00:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm46703778c88.13.2026.09.10.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:00:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 08/20] KVM: selftests: Use the innermost page allocator API in the memslot perf test
In-Reply-To: <20260902164123.2546762-9-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:25:00 +0530
Message-ID: <bja51im3.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Use the quad-underscores physical page allocator API in the memslot perf
> test in anticipation of converting the outer versions to take the memory
> region type instead of the raw memslot.  Stating the obvious, the memslot
> perf test creates and allocates from multiple memslots, and so can't use
> MEM_REGION_TEST_DATA to communicate which region/slot to allocate from.
>
> No functional change intended.
>

Agreed with the reasoning. LGTM.

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
