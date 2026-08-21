Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49212E040D
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289465; cv=pass; b=EUJk/no3c5HIvAs7gEz6amjcTNMW5icksZU6zprRA80atTp+vkm+c2dCDmq51sPTYK3+W3lHsuKNE4iQ7t3IgwNJKschSZ0h70aaENzFwEG+5vF9y0Y/PYJzhIOfeAmOPeDutox1F9xubnVy4vehHSI8o+9BVEQBIDGMut+iLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289465; c=relaxed/simple;
	bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tltelSOHx6Vfr3YE5SSThFO1oqT7KLR09qiS5aqQrs43WFIbsktV+o8umHA/iROTqWplsmSTGs3DLT+oYTjcUzLrg9OevG9rkZFuzy06fd7VH0TUvPgopfJlj0ubTPp4vpu/fkgvpI3Rl1EPZIXSwZ6gwi2jlZmQu2wA0D4GMF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=mriWnuoM; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="mriWnuoM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13916775e9.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 22:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787289462; cv=none;
        d=google.com; s=arc-20260327;
        b=jnVfXyx2IbNs4KcrnXH3P4QYWc3Pmi97zbNjeQr6gjSjhqXhFvBbZqPT1OiMlDqm7W
         aUhaLv+or3z0rLviHJlq0igV2qOTDag7vcLM5pmGDDtY7P9D6LytrrO6D9AG6Ef0lqGl
         f6oN+HoUG79mzZmDrJrjrjRlXFUcGDntpw9LVz+o15rqT8kJpDJDqKfAUTxWFmB0zQnN
         j5N2ZXXGaBqjhR1+dlAgzdQ2yJ4GQtHq5tlabkMgMFgu5xSTv+BwTb8C812FPRuFgzW/
         f7uQv/Ej768P0Kl3vKem+VK+Jgawff5D4X4GAbQ6n46P64/TBm5iENRhVPDklszG6DhU
         yuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        fh=CbtTJc3e7FqMIE7fHhcS/jQl5ZcEYqZo1M3QClyd7s0=;
        b=dBCObZdCHDR3bITmXD6kyrhxa5aN/m4ytlP6TtzmPq350yaRcq3rH/1mnMGvuS8nW9
         ihw6JjNE89ChxQ4Z81eOa1r5Aon9x/l2KjkfMv1amBevwgJZvjGlZKQ81VUBWMG3C/6s
         gdjJd9RbIwZFmGLXcB1KtUoHAgSVkvQxU09segBIo9Np149d/d8CxOypnA4IeowwKMOl
         FS+etUEGtH4Fv3cdhElH3PD+81w7c/2LqTeco7A9IqTn6R/FHopnZdTgs4CT0xQkbanI
         dA9+yDP2A5b0JxSi1yxZNXQDKOIAVMVYL6dDBlfqG+Z61iU8WK/USn3OZJKz2RPPZ1Hc
         oarA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1787289462; x=1787894262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        b=mriWnuoMN0TktLIEBPQp48uKY8GRxvlwq56t98AIndzWS5NbacpAxyyFaSoz7HV+Mb
         h2Ya9kT6j34XuTq6n8NUzV0UncBWQfPOhJ+G4iz9OMZd2UYqI3jQABX19+FUPoppdjiD
         BvRIGCmsdUVNnzt43ZFwJ2K/vNIeT7GKi3hX32XYtwh37fe/8ftzxYiTOXBtx7ppZ00l
         aLb4WNRWPyR3RnaZQl0NWsuWzG63v3YjzhpOVyAuT8+m4ve0L1st/yR+sZ1Xqo1ycxNA
         X5kfBKBJfq/t4R/8uwHnqopgcAYlGBfh1oecS3OEuhOlwsdVukwNy/+FhlZhKkZpeEa2
         5QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787289462; x=1787894262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        b=jKD1JEQHKT7Q4mf24VBQnJdJQ/As8EetCx0eJhdTcUN/kAlSgmhekCLQ9+zwXUstMN
         YwNA26re9jtUbZApa8LeoJekDMU+nqFbWaBroLlgiY3O7BhPeMoSov4GGmWLdxYk8O1M
         YTQrK4Y08/943GpX58jmVNyahXO4DOc1HxFMCTiK9MQJHR0njiuXqkgpyGn3rwDdE/YS
         akHKa8Vy6da3ncnCe1ca72tndBHVJQYoOIXnBiI/jzSIJFidm4rZgYo4C01K3s4qzARF
         /aq/NWwrAo78Do9uGZDNItkI2EZmRpHUsta8YrKUZoF5jdqAYhpTWMgUizDObaBna/T3
         1r1w==
X-Forwarded-Encrypted: i=1; AHgh+RrooP88tWtObaKO9Sq4XpZDPZUpvHHDNTPx/4rYTT8oV4Xxwi9aDCwh6D6kamMmGXJVmfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ciY/0RdBvixHHQ17X0f2Y+JDNPAyVmPjYXX0jC//BekI5eI5
	b7+LVdZTfDzzoFtz5c+IOp4ZLUNSOzPH+nCFM45ws6UprOTaOn3rmuVAOwhCplJC0twKxg0ZKlS
	p3Xl0WwBLyO/BwEFKYpqVNEfSG0252s2bUua3I88KrUylUR9AahCITBo=
X-Gm-Gg: AR+sD10cfQ2LPmLeCvncAbkO3/Zamcfy+EutSy5NA9NhJp0h+o2h6+d+vnEtGzoTsHh
	oBVADoQclFA6MXHTSoJDhO/y4iZ1lCG2Mia6LQCbTX6DOm08jXyyNZwxzpBMItMRwPUuU/Es6fC
	n20dpt/ohY2EHjliNEr7IHy2LWYDkSSwtNjmiH+u7Lm1OH5hKEEUfLGwsaMDjn1sbViSzpZ0m4H
	2i5yrfjyCE7oI38z9wsSu7JxPmXbK686hqcHYN8Par/zlvsH7RI3YzEYKbRSdcfRcO3p1Ui4Flv
	5WmWIuFTcegd4aOBG795E3zRXcMZfN7Eu6+Gn/hvL1jFG83fbf/L1rFx3kI9yK2mxM+VIBKxQGI
	8rMnUBGIGu23gtCqqFKaC+neh3BbaBUN/sea0rWMQVsPaVv7CK+d020l6rS3pQaM=
X-Received: by 2002:a05:600c:8b63:b0:499:7f37:cb74 with SMTP id
 5b1f17b1804b1-499b06a36demr94909825e9.1.1787289462039; Thu, 20 Aug 2026
 22:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com> <CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
 <178728288861.534500.12009100192281293732@ultrarisc.com>
In-Reply-To: <178728288861.534500.12009100192281293732@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 21 Aug 2026 10:47:28 +0530
X-Gm-Features: AcwNN1VyOTE5mxX9-Emhx7eOr0LfPk9cSJYrSJElhptVzuqH563CP-bjvH7fuKc
Message-ID: <CAAhSdy1shnw8-4yNVtsO8tJdebGYdX9n2mJyhoMQ9KpuitsMoA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:58=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> Hi Anup,
>
> The issue reported by Sashiko has been addressed in v2 by using
> mutex_lock_killable() and returning -EINTR when the lock acquisition is
> interrupted.
>
> v2:
> https://lore.kernel.org/r/20260810-imsic-attr-race-v2-1-00ed95ad321e@ultr=
arisc.com
>

Sure, I will consider this as fix for 7.3

Regards,
Anup
