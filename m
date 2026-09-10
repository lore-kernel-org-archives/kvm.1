Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4E47C11A
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040798; cv=none; b=toUaxRIIBKwrfS9GG2xFX+4PE3E6IyrWhVWLduN/ZhQvwLjZMqeb8Hx4gowOzJQ4U7Olqi2QVKJ1jWRT5E9/0Bst49c3xc99UB/EtYPgcDODEzqyRlmmtIdj3LLL6YfLHH6JC6bOiZc2i52BXVBeOfzJdbukSITyVAO+xzuRp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040798; c=relaxed/simple;
	bh=+9G8GC05NdLHXF8cStdhp+Ruyt/HZZEYr3s5pM8Whfc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WejcsUnWOqaJj0OYGfdOpqWdK2P8wKlV8+3SsyXu9/Qf9ZMtL5WnFP39+QuhI0AH78DnW0RvVcLW72oTKT4aMlcwl+dRol7+moPlKT84QlDnIIaGG0LuRTyzw4Aafx7PPBGiCiglL99vDm+KjzcF7gafASXwgGGhtRH8WrKFmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2/VTanL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2/VTanL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aca0f482e5so7509923eaf.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040785; x=1789645585; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4oV1R7Sem2YZktphiH9OH9k3wSSCyVuVuzldh1QWGuY=;
        b=b2/VTanL4b72R4AcNHSpynNtDCaa4WE0PKorNmjOfAm7uCvAXMQAtf3fYC7MEWScop
         DSgX8sQlt7HWIwoOkABi2eCWTAWBQk+p4rznr9uonM0Aomgy/BqTiScfx+qz8ZjTf0fb
         W6VYob07EjgkFJh6tp5bbV1j7kmFbulSvWCHlaaEtsd1oJfZWdnlhKVQRd2MTRpDmaMy
         eMr+v9+Qv2on9A8lzWtV3AA0B1Ru5tUveO7XCGvmqn8iksMEJoePH0MjwSd8+1NFDYg8
         SEgF1Kz2zyEewqv3gFPCoFBd/rCP0e1T6cSpJHG6tTfFxBDlhR/luN8smZ9BKXHKoOhd
         va8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040785; x=1789645585;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4oV1R7Sem2YZktphiH9OH9k3wSSCyVuVuzldh1QWGuY=;
        b=ijRbtCuG6ruabI+A6zWlqVI9bY+3EtUsLG207AoA6gdYNTR3vEASJ2RwPBK5O+bW/k
         zXYNNWwJkxNFAzblzIrOrMITwDUMXujxlBlU4tWcdFE3ovJCBTAQ5vUDYr97rKChRkIz
         TGQEiunHoDSy/sEmqZ5gPkBe35aRaphF0cAb+oWiSYrivJFYakExwFE/zVHvid8Hgax/
         mrXcM4zbD/CQGm1d4vJZPeKdT20InD4SUHOWVEjHI6S9t13h4d3WbVAmkf2x24+Y59ND
         rfaNi84QZD0UTDRLyCDxj8QBqNWJL/Axa2wQgZ2MVo5MMJYQNhXZtSa8Le6A77ShdkCb
         g/eQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5BcBakbLdxaa3tNfFAG3UoqG5zGa0mL1YGXIAAkrVymwXbhx7XteYhbbZVyfSHQFt5BY=@vger.kernel.org
X-Gm-Message-State: AFuF++kHBX/cA31b/LfIt2fTgco7eBNODPtkFQlvzvK0KBic+SNx8ng+
	dNigpuqmWEO96DlmkoYlVOUhhFc6mf2Gll6yIfT9ey6MISS4w0Q84F6D
X-Gm-Gg: AYBFou3zF2OIwYV8tndSK18xbrZFeyyCPIwyN/vLJo9qggSZOMUbUQrCB/oxiwq8c8x
	qKvo8Czeo7h0vcO9X2T+WTKn58Ela2aRHuwxn7UQF/VDRcaSs7qnw095Lq3Xr3qFwDqYQOzw3QI
	8R99JvluGVBMlWiKW1pHrwQfqYeMGbNLY+i4GSdtvu/vs8t/iL3rJuTw9DHvaAH8JNv6O3mUQPk
	MFoXzBL0kcFV+hNVk4i+KiAKrOdPMC1DydhB6C5bqUIHiIZh7bQkMABw+z7JlZLWF6a3r8A+Djo
	59Moi+ay6lHPcMm1DYeokk4akgf9dXm7DkFyfpm3YG7+L2qbzgteqPrpWqPnIXbyOjT2kpGDIu1
	9b1dKQKQl0ixjdkfLajcVzLdDPyfHgkb5f9FYFyLHoGzaA+Q52IkDrSG0Aot7HgtQ6gRD0B5Yf/
	qYImRAmhZmwhMfHh6+UNHfhwfj8pjq19pf/xkmtnvrTDjJRG1BR7ywncgKBX6U4d13f1xZrw7i4
	2V1PORaMuecNUrBsQbm/OELbDrY8zPjjjwEYIwKQZ4D3fZCNYwKaRw=
X-Received: by 2002:a05:6820:180d:b0:6b7:8415:d78f with SMTP id 006d021491bc7-6b78415d8bbmr19129181eaf.58.1789040785360;
        Thu, 10 Sep 2026 04:46:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm46857652c88.0.2026.09.10.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:46:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 17/20] KVM: selftests: Take the memory region type, not memslot, in page allocators
In-Reply-To: <20260902164123.2546762-18-seanjc@google.com>
Date: Thu, 10 Sep 2026 17:10:56 +0530
Message-ID: <33vh1ghj.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-18-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Take the memory region type instead of the memslot in all page allocator
> APIs, except for the innermost quad-underscores function.  This will allow
> automatically selecting the minimum GPA based on the allocation type, which
> can't be done using the memslot due to all regions sharing a single memslot
> by default.  PowerPC support will also leverage the type to ensure that
> page table allocations are naturally aligned.
>

yup, PowerPC can leverage this.

> No functional change intended.
>

Sure, even though the callers are changed to pass type instead of slot,
the inner page allocator is moved to pass vm->memslots[type] to
____vm_phy_pages_alloc(). So no functional change.

LGTM.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

