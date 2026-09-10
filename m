Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBD3D410E
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022086; cv=none; b=XKfMRYVGVemECQfAJF82oiaNGtR9cK8ytDJ0chMY/ES80DRFJvoTA3/6vzJwtLJNyB5woxJUDjuhZd3QwKawmFFm4DqKrUsCIQh3zIgIQFhsnVYrizeQaaysw68VfxoNuOUOpiAMxjzjVLPPUyF845Xk32gy5jweBwPYf6PuYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022086; c=relaxed/simple;
	bh=/uaCqa1UBzrB4l/x0ktWW2Ji3uA4tmOrYEYh+8w3GLM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=DDFEoXGG8VI1UKg6d1XkJEUP/H8EQVgfnRVP+UUMDrj79OsHnrmFYh8iNxqIIsHiqrw3XgA1ZW1Ov1g5Ih+7SiaHtr9NJTo2bkJsnH5qL5AQt1IW1qe1M0p7AHKJ0HZ5XdFX4qXJjis9WS0diinmaG5huwHGo786Nc8kURB0Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLLS2CsB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLLS2CsB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4b28b358eso523724a12.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022084; x=1789626884; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/uaCqa1UBzrB4l/x0ktWW2Ji3uA4tmOrYEYh+8w3GLM=;
        b=DLLS2CsBM/3zcihuPySTyvClBm44cM83nB5Qgwyl1nt/+zPA5+33GRfbfTD8JJNShz
         DbSQjoP+mUboKMKVZ8AqJ+pCBQwBF36bEl65kXCOdriAR0x9h2vbXdmfE/kYjTA3UNGb
         VYMABcaD9fNEKpRBAK/ZxOa01HjzMD1kBjYT6C9ywqQx58Oo0JeCNSusm2bZvZK/Bmhx
         /44CyQY1rpVJWFGYM8Wun1q5bCdFuIxrXo/8jSbDqd6F/uBdoM19kXpaoODXhf3aqaWD
         pCrGcHac0sNZ7raw2KT9l4O6/9Vs6gjEfTwEOR9KA5OWzRb/USpMbIA8vHj1W7LCaN+j
         J6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022084; x=1789626884;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uaCqa1UBzrB4l/x0ktWW2Ji3uA4tmOrYEYh+8w3GLM=;
        b=nZPvDO59Q2IxhGpnSdEpFUXgQX5Wf+ulwjQIHO0djsJUL4KwKSMmOPCeCAbZiARe8e
         wQbhXIafeB0XOOerCqW2KjP9MSLBMAENdD6SbIbBcVzyrvILZdLd2XTuLrp0hWe7EJiS
         +ciiyEwQBjQaMNAjlcXDUuLa9Kw378MDQxR+e9KYapSDLlYMWgOz12NGbXMDKOtt62Y/
         NOKjNbFm4gV5CL3mJ8/mpinQ2T9XKS3db1KUBBUTabNbScpeDTHqQp6orCdUUPSjHSwe
         UEudcBBZwpoqnnZjWMhwzwd8U84XZMHCyE+w3xO80NdrNfPUu8t+R7mC/BgzG5RCye42
         Yw+g==
X-Forwarded-Encrypted: i=1; AKwUvBxPhqTKq4jsStKO8na/V9p1JYL/oeYzUgXY5VnTIyKyP9Ca9hQZ0ky7apOhTZJ3ssbvDs4=@vger.kernel.org
X-Gm-Message-State: AFuF++lLoXkWC8ZGBwExPftilkfNYlUTaaGMg9EWzV0VqkRY+TRVTdPA
	NqAtlbyBHpGRV6I70BKaonbN2/N9YzhjYv51P+4ZhEq88MEpopz0kXXH
X-Gm-Gg: AYBFou2wrOyOshvbzbbKQlBV0WtWqenEiLL5Y4Lin/MeIpsF4xiYb32dECwccvyzHp6
	yxIN9cZtWWwDqbExtW5SHt5pkM2Akdcxlomrdyz3FoHH+hvhp4onYwDPlzYpD8hyHZx5kJVGckN
	2kGelcU3rjFA2EDG+Nrx2/wPuXIBUtUo9QQPYdfSUiUAt+actx4O7A+EKilc4j79dPKHznvGF9O
	TZlYK9sikZHJfmvGsckAY6x/miOYOTgnAczunD0vuwb9v++yTj1pS8QA0c7fNhNxLtmvvFg+5T1
	kOii0oO8S4A8DKIonFPkGyPif9LOM+IJNgblP+/4Ateln8usSJ/nqZkoXynGDdFdbGP966g/Ev8
	AhdJQz6Adc24LVs5U6o4Wdgiu00uCL0LGfqn96LrQVdBFHecLRyqgLAKGMon88xqWchBAft6k15
	HQXBiKIBS0ThPUc6byw0j7tBpdnQaEDVwsQsEjJJ6++pirHM0OPEwdnor3TlTjXqqYVQqWu8mpR
	vuw0Icbo3V0kVqrGWmDVaQWDB44mYvlbGlTSuyOg88+yyuGGQ35JVQ=
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr57429977a91.1.1789022083690;
        Wed, 09 Sep 2026 23:34:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33987ccf483sm10434389eec.20.2026.09.09.23.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:34:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 06/20] KVM: selftests: Extend page allocator to support naturally aligned allocations
In-Reply-To: <20260902164123.2546762-7-seanjc@google.com>
Date: Thu, 10 Sep 2026 10:57:06 +0530
Message-ID: <fqzh1xsl.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Extend the page allocator to support naturally aligned allocations, as some
> flavors of PowerPC page tables require multiple guest pages per table, and
> those tables need to be naturally aligned.
>

That's true.

> Take care to align the potential base address *inside* the retry loop, i.e.
> the base needs to be (re)aligned on every attempt.
>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for sharing the changes. Looks good to me.

Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
