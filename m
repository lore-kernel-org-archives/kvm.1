Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BE33FE05
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644426; cv=none; b=sbuFGxZdWYG/aHy8YxWpceDwtnbNpaCsji7JOTJUMxqB9+aApUj8lr2m4fEuEIGpEdd1e/1RJRqEQ9YInpXpqfUhViVwpGPe2dC0DBCKO0d27XQc2KcwLGrhk71lJtww/2iDs21Osf045wmR0Cl6r5OJXgQX88qiWFm1/3L2vAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644426; c=relaxed/simple;
	bh=OCcx5VVJ/q2Jdmy1rWLozlqCvJow6mD6/PAj34IO0r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMZZRk98gEefC+EoNK5mjLcFhhp250WrxVLBBZZ1k4LySyqH39f/J8NmcMzxf4fX3sRFxA5PcMA+psDppJK2vekLFMuqEGg6TG8qb8z8XfFZIZjsUGFbly5gmc578jRa6eiASa69gCwRxylsX8fLgRtdD7lqzAvmGheBS2WslVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O34hvFaC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O34hvFaC"
X-Forwarded-Encrypted: i=1; AHgh+RqGQAvG1zOqOdkE/Qpjbm7O4QtVOkxOusiVM0RIc/xuSShHJtyp9lIk/c4lnrshY4SMoKk=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784644423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tX/2tl07+yJqbOuLTPdhA092ojLMqUmxZf/n+rIp9Kw=;
	b=O34hvFaCRVwONCvYjcQGGe8DSaYRisiuerUSpm6H0K+BJlwK+ptaAhXkord0ovGZY4yoX6
	sDcH11aGqqYhj+YzRrpRIbM/kN2vvRp18dgqBMcagELLK9/3zeUQrJ1oOLsQtvm6SPdi15
	4dalFMcTbbbKj8aHMi6XzzAwG36cQbE=
X-Gm-Message-State: AOJu0YxTq1gasnQHRvF/RzRRfh6dNApbpZpjDbSB2D/YEjqSm/A46ZCl
	KkkENb9x3vY3N3/6z3E1rqK7QxpC+SQ4FdzhclKLuYHi/t6gwHzyHBGbRoaQjj+99PrdZUC2jAs
	wwHZYKX1LQh3BDwt13tYbKkL95Up/RG5BJcUiW3Tl
X-Received: by 2002:ac8:7654:0:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-5266416fcf2mr9196991cf.12.1784644413281; Tue, 21 Jul 2026
 07:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703154811.3355680-1-sascha.bischoff@arm.com> <20260703154811.3355680-34-sascha.bischoff@arm.com>
In-Reply-To: <20260703154811.3355680-34-sascha.bischoff@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 21 Jul 2026 15:32:56 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzwC3urfr2FZZsd-2QmMrqKj-65X-FW4VTcfR8V4LdT_A@mail.gmail.com>
X-Gm-Features: AUfX_mzQa77h9tPAu2s-6As5Zputo3VkX3T4yUJNcdJdYwyNb5k2wGjd3E4MrGI
Message-ID: <CA+EHjTzwC3urfr2FZZsd-2QmMrqKj-65X-FW4VTcfR8V4LdT_A@mail.gmail.com>
Subject: Re: [PATCH v3 33/40] KVM: arm64: gic-v5: Add GICv5 EL1 sysreg
 userspace accessors
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

I found this one harder to follow than I expected, and I think what
makes it hard to read is also what makes the two things below go
wrong. A PPI is numbered two different ways here, by its position
within the register and by its absolute index, and which of the two a
given line needs is not obvious from the line itself.

Two things in set_gic_ppi_enabler(), set_gic_ppi_activer() and
set_gic_ppi_pendr(), both latent while VGIC_V5_NR_PRIVATE_IRQS is 64.

The first is the loop bounds. All three walk:

> + start = VGIC_V5_NR_PRIVATE_IRQS * reg;
> + end = start + VGIC_V5_NR_PRIVATE_IRQS;
> + for (i = start; i < end; i++) {

but each register covers 64 PPIs, so the slice being handled is 64 *
reg to 64 * reg + 63. In set_gic_ppi_enabler() and
set_gic_ppi_activer() that is explicit just above the loop, for
example:

> + bitmap_write(cpu_if->vgic_ppi_enabler, val, 64 * reg, 64);

With VGIC_V5_NR_PRIVATE_IRQS at 128 and reg at 1, the loop would run
from 128 to 255, so the test_bit() inside it would read past the end
of a bitmap that is VGIC_V5_NR_PRIVATE_IRQS bits wide. The absolute
indexing there is what the bitmap wants, it is the bounds that do not
match the 64-wide slice.

The second is only in set_gic_ppi_pendr():

> +            bool level = !!(val & BIT_ULL(i));

Here i is the absolute PPI number, but val is a u64 whichever register
is being handled, so its bits are always numbered 0 to 63. With reg at
1 this would be BIT_ULL(64) and up.

I appreciate none of this is reachable today. All three start with

> +    if (VGIC_V5_NR_PRIVATE_IRQS == 64 && reg == 1)
> +        return 0;

so reg is always 0 and the two numberings coincide. But the guard
reads as though the non-64 case is meant to work, and as far as I can
tell it would not. Would it make sense to derive the bounds from the
register width rather than from VGIC_V5_NR_PRIVATE_IRQS, so that the
loop and the data always describe the same slice?

Cheers,
/fuad
