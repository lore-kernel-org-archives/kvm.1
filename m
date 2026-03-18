Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BF2DF12E
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868766; cv=none; b=NnWyZkZlL9Q/DAGZ7P+V+qVePO0CeSift0EJCFgXEgHFJD3mGpM8frrmtTddBMlKWYj6+cEkgxaE6fhLMq0xfE/a77rPQLHw6YBhX8gmTObuIbfz420V3mImrffBqAkE5v1eTT1bNolXEZgB12+NqPHiLR/B7yc8g/SbznotR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868766; c=relaxed/simple;
	bh=s1Qp9lS9mJbsbw6BdqhHIoqJG66lBxCc3NYAKkS9f8Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GXSiV0L3bk22V1ZdFpaJQFEWKA6NxkgMBlv0iLJ2GbKphvWY3nbWdtE9kSJEbCn/l1MQK6Ydm8nWjO1xlxdsmDL/gQJGGqq77V1ZDF6lj7/OKU1HPOMJGzMhgC8HPp9FGNdVn72JevHYWJRUaoYouRmm+jlQAUqN9nSbCbhRQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkMo/X2R; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkMo/X2R"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a5ad7cc52so4172597b3.2
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773868764; x=1774473564; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1Qp9lS9mJbsbw6BdqhHIoqJG66lBxCc3NYAKkS9f8Q=;
        b=FkMo/X2RL5HwAxJFx62+IqwDiAbwfajbTlZ7deTXl4tr5SXhbRNf5wpuoRItwFEyqi
         PjNVZWFlv9d/iz3i3ptkzyhdHT42BM2QDYrDJIzfY7PZa96zkFnlazvvQR/NfXIfWt1I
         iggfM0Bj536s/mMM8vR1QaZ2C0LqLI3/C3HtOlQQmm908miFicE+t0bB88OgRu4Zvnmh
         SwdNGI2Nma+6C6Z2O8MuwP+dW66x2Uylm1JcTX1EffC1td0fjKXt9c/zIT3mo00E3pWy
         dSodlh7CWlwOXCcauJc3L/c1YqF6h3Ahnn0gDjZ2Nyo99pWxJ+YvB12zIT9o0iVrtOfB
         L6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868764; x=1774473564;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1Qp9lS9mJbsbw6BdqhHIoqJG66lBxCc3NYAKkS9f8Q=;
        b=DiXr0MUwqtE2JZ2ZEZwLYp/vfAD7ouTiQGr6b5vCRuPFyZgF8Pzy23jL5A81cOXpM2
         nnQMb3+Vy1pEQl3Rli2UvSRpS6jpg79pT/Bc58xaytYqd0KG7qNp+C5TzkexLjDl9xza
         6YvkYI/OHP8vvydUNf2B+1kYHuZwr8rewgx5oe7DrK0tNFXLPWorzpKivhQh0UxY8wmr
         vTivxvl31vM2ur6ZMWqjW0VD4uU+vXABGb2hxlvl9/u0jLbpnJ4z60kGOICO2O29uhEI
         cffPP1ILrmu2qnNQDIzsHd/UXqr1vuxMRENI9ef0grlBibYTar3abwLRKQgc63WeVfVz
         wcqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3NtzDUCTcWw2b572YpptXeBaY+UIUoA/B37Jp7OJLYi4651Kh3WRxrbuYVlfh8vXwwEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiEp6oS7bwjWeI2822/zYufM/5pOBjtAQGutIuZkgwORO3bmb
	4eVIDk4Md9lTxOkXLu3uTl/mmp0EmrCaC5ilCBg4t2PfWwiT/O2OVi20
X-Gm-Gg: ATEYQzzw6ji9HHCVI6BUbyXUzYkg+oZkkhYi/vwreWwHU9xypBexL4CHLb7rguQcdB9
	nTYp0ZB0cy1h7h2n/drDtVsxi7LF4V452jh5hYNaDq9Fa+nqbRYiORJa5aOeUfQCS+aEJ7+KqMC
	eBaXZeMmbwF1Pmpr7sFVDF27osz1tpu4sLLhxMfIvwp31u/YgNvhnj96a00ykXyfqDpReWNVEoz
	91NrOjnUh8NImFjfnvwMXZhFJTmx3Vi6Sc2IgKQksd1azupMTogv7UT/18EPJeTmzU3hM8PvZpG
	sqcbCZQopJvOUeJ5spyf7fFuN09Rii0gqJhdcq2J29cay8Kdf80ZurV56l7TDJY1f+tyNfhARfB
	zG+BxQeJ0daanDA03v2MClQap11rGDmNuDpI3wVTrGEYM9/eDQ+D4Sn9rDWVrCuqgvl9aVQBqUV
	vChAPyctNBm0gbK3hR/ohZdnjjadKMxDrV28Pl9ppsQ/4SoCYPAeJx5/CldOZkcqQkPZ8SKGv6a
	j3BxNIFa3V8oKREXVE/lIvAfSbFHK0u
X-Received: by 2002:a05:690c:dc4:b0:79a:2ef2:82a with SMTP id 00721157ae682-79a718c82b6mr50873677b3.20.1773868764218;
        Wed, 18 Mar 2026 14:19:24 -0700 (PDT)
Received: from localhost ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a7136de7bsm24223777b3.2.2026.03.18.14.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 14:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 16:19:22 -0500
Message-Id: <DH67ZVO5UL9G.3SP1BFT4TQOI5@gmail.com>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <ajones@ventanamicro.com>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: KVM: Fix out-of-bounds by 1
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, <anup@brainfault.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260228152226.2116895-1-ethantidmore06@gmail.com>
In-Reply-To: <20260228152226.2116895-1-ethantidmore06@gmail.com>

On Sat Feb 28, 2026 at 9:22 AM CST, Ethan Tidmore wrote:
> The array kvpmu->pmc is defined as:
>
> struct kvm_pmc pmc[RISCV_KVM_MAX_COUNTERS];
>
> So, accessing it with index RISCV_KVM_MAX_COUNTERS would be
> out-of-bounds by 1.
>
> Change index check from > to >=3D.
>
> Detected by Smatch:
> arch/riscv/kvm/vcpu_pmu.c:528 kvm_riscv_vcpu_pmu_ctr_info() error:
> buffer overflow 'kvpmu->pmc' 64 <=3D 64
>
> Fixes: 8f0153ecd3bf1 ("RISC-V: KVM: Add skeleton support for perf")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Friendly ping.

Thanks,

ET
