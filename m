Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26A46AF16
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038460; cv=none; b=aJnoKOJiPobNPJd4mRFwGPQS9nQvz8TkZCB+LapqUMal91f8Q86NUjlihhjwLdP9Ciihv0wFhJbLv2dUgVbFKelRCQt6T6A0YSirhSxB+V/2V/KYUMoLoVgxfexpceEPCpo1nZp9OK4G4nZWzJZWiav8O83Xj7IcPP3S87ayCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038460; c=relaxed/simple;
	bh=70Xrz5Ek18W9RLHK+PGrZl6neyZSU/LQLxpuqNmBXms=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=rCMeXP5/RUv1RboZPtDLYhQoHoNrbVYkMYNYtfRTtw7Du9Pmvp3P3lT3Gihp8wSXV4FfsYSIPDeFFNVHf78YhT2N/J7O5Ek5jLeR2qihgwIYBXTpSea/87bNfcIUvj/JPmQToUCo7XLOiarQp91Ls+D4be9l+XGn+bAlbhq0too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiAiQghj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiAiQghj"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so5822666a91.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038458; x=1789643258; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=70Xrz5Ek18W9RLHK+PGrZl6neyZSU/LQLxpuqNmBXms=;
        b=YiAiQghjnVg7/KimUoFcaq9gk2O1+1IQL3xU0x8a+1GW8VHsy3zEu2Y+fr3bIVsY0R
         VR0akzR+ap5J0/xdKXsa6BSYMm6ve4Ot5SnQV3f6VBgFPEh4fj7Yr+qt/9Ww7i4bZebd
         KYS/6sv/o5U2NdzIzvkiy72MMM424E1Pdb1rIbdlEn9Jveup6ER6pRNy48tC50rW6I+P
         ryzJ5YtS1VRFjno0WHBtJyaMntqG7T8wUpofAbRJ46B8gf1Cv5kVgv5SdCKmDud6hTsa
         6xz7QMpeob2xJKOqUFYNRTQgtIE8KyB2MOs9jS8cBpwY2no5ve+aGKfywKhnygpg3ZFX
         eNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038458; x=1789643258;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70Xrz5Ek18W9RLHK+PGrZl6neyZSU/LQLxpuqNmBXms=;
        b=EjfjXY0CWLNaCQxhFQBxc36UvzCODKxJzdRj42RqcXKhe2WkTK9jkoLSfRXf5sYRWI
         JA2bI8XXh4/mnqMKNg4sbeSfokZGv/WgTqrArDJFnbMep1seXN1ZxI6Gd2g2PjojfEW4
         Vo+sH89k+XcuRgtcCO1ur7sC2reumRoW6FiOWaGxLZKk/Cg+LAwyl1BB8DbAbQv6nn+j
         BsgIQ/MZNNbQCusfbHqk91O9RlHlWe1wbytOJsIjWh9/R9EuhPWZ0K+FQrgpjitMtNqr
         s97pwcSZDuv3S2LHAxTSqA2G5M46KTa4LF9jaYleDNw+dC1YsaxdDQLxqizWOXn0VtKu
         c4Hw==
X-Forwarded-Encrypted: i=1; AKwUvBw1hz7BAvdv9+3L5NWmZ5eMqAQkuxFe2ws/8nqqZlAuUw6IuFi7F8+HNla/E5x28B9CguI=@vger.kernel.org
X-Gm-Message-State: AFuF++lwheoMnQ0RFKch7OgGYU1BqTeF2cI+PanWTD0wxL1IUmk2UAfI
	aSZP1eEFx+eHCq+WmxUFksAFzF8wrTsAoISKH95tDVlV4BRsQWa8QLJt
X-Gm-Gg: AYBFou1s7S23tOmGdBsQICL2m+V3LQjRqAAzWmOC3K/7+QrBLjZtcd5743aQ6/AzCnU
	abXembyFII0hKHYKz2SmAYuDBFGLzTP4ZMjIcRsnsQyGYlnkbPKuCjC8u1m4eGmJVZ9ZWcO7Xt9
	EyCrWqn5RV/sKYWPUvZkUneDKwmMBDMKdGBVMD669pYemriD3bGYbIe9uSHm0QNfqsqnmYvTMnG
	WAI6AOiOVzxPfXThRAnX0nCn40uNhtblxoy5jXNw93YJemevDqK0US56LjKdX1UkxNnBrCnGBtv
	yFZT6DELxnbxqoFT+DsBpl/th5CFFB69LTjvA+renh06D1CWOb70wOiPO0qNHpxM1dC9ZRmdchZ
	L9TBbVtV0GT4FU6J6yiAhX9/zgw6nteRKV2eXimEu4KHDrOIpyS0SWIzhNsQwVBcgB0XyFWgeQq
	88HA0334afAzV3jWaZCnK46eC04KwCcFzO6vOAWCwqW/1YnnxBtp+OqOvaF6zo/KXhnVV96Eljo
	JjLwIp9qzKYQVX7LCVz3JIIO2PSDKYP1Nf9NJGVQHtlTCdERf3HdZE=
X-Received: by 2002:a17:90b:1b06:b0:398:9be9:ab8e with SMTP id 98e67ed59e1d1-39b2622ba26mr58218547a91.19.1789038457819;
        Thu, 10 Sep 2026 04:07:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm43023781eec.6.2026.09.10.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:07:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 10/20] KVM: selftests: Add a wrapper API to allocate multiple page table pages
In-Reply-To: <20260902164123.2546762-11-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:34:41 +0530
Message-ID: <8q591i5y.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Add vm_alloc_page_table_pages() and use it throughout arch code to replace
> open coded equivalents.
>
> No functional change intended.
>

Straight forward change. LGTM.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

