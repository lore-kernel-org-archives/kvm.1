Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E3311954
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420563; cv=pass; b=VV9sGNMNqC1mg2E6S3qMas2DHjy8i2bw1Eh6RqHU3wuNUWLpp8rN+440PKTIcj5b4gWeDTebrncVgS3H8x/yj/IqC6X9oaSYjdKxY5kIAhXN57VWYtf9nCZEGFDh7K4rtfbu/21r+FT6PYhfoZGqnkhALB4hfCKZkX/hWY7kDBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420563; c=relaxed/simple;
	bh=HbUNG09i5qLUllqNxbXcNA3/jD57LiEGUfV22Nd8aVQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V73CQef/0seUGyaYt++wGhCx1Liw+CXotVV6PYJ0tdmjamIsmsAEU4Hn1QoUl8OQYv4O5wDvrtjnG7a+z8uYW4+3kQGDt6KP6Kcl4YBYOwvuXxXkFIA3t4j1KQMVdNSDNgSZ6ipngllnZWvtXQicx4WCeTaqyRw3dkxWqPWd0ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNPo7qki; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNPo7qki"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60579b9c0ccso9491489137.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777420559; cv=none;
        d=google.com; s=arc-20240605;
        b=Dzjqg/Leq5dBbRB3HpiJu8VhYUQqh8q07zFUFFJ+ozyEnKJgU3xxB7YuP3k8/qLp7D
         wDYOMwLEB7w/75o9x4JSTiTJjMviXFqVpnelogwKmkdlTEg8I9v0dZvCh9l57umf8a+b
         4msLFUVcUGkxmI/V2eODHnCrj7xUFWm7qCOyAx6QO2XUfjp+rn1d3GOjC9BTtGSHN8SO
         jPid0BGqihg4nN6ZMS9std9Pjr+dfF0imM2+pMUi25jxzTmow+Xnb9BUI0c61SKvA3lX
         oFmz7jqtP4+DPpw1Av3QlxuKjywkdVrpFBIqHs1bxU9I9PSbk8fGI+AKjllLR7zR8RMY
         RVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ge/rG1b9OBe+4PbHVqQyIr/aQn367ZGUNhS1U8adnfo=;
        fh=ZUBDkris78wSPtwN4yc2SGghSMB+UAGpTYQ4m1nvd7w=;
        b=baFpy+EbZ/cM265yd/a9HzjS/9ek7bBHigzLDh+V0caOHanI15UQKWHFlJm1C8ox1W
         vW6KsiXmsm7ZcD/CRh1lp8nQb8cmJbd7wslJSmFZz6AdN0J0w0yLO4ve/RYjD5cHp6Yw
         Dl95T2EoCT4YRouWgaBqx5gFPI+4IBMQPr766iQhQkfAV7AmBqEblVAJpL9JdXFTxVen
         olvGydqwabngMH4YnhU6JvcoLRA/kkrAY3bXlesY45pFI0bmUw5yQlt9bWcMkdcobD53
         vZloaiWp4Li55CYFNm5nA9g5SmwDNOVc278lxBVwwgmTit4lFIJhhAw3jtxX7nkwTiAY
         R4lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420559; x=1778025359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge/rG1b9OBe+4PbHVqQyIr/aQn367ZGUNhS1U8adnfo=;
        b=PNPo7qkiAmabfdkxwh/In+5nnimWub1lgG7yNYz7Q2ylsanyl6nYH6vuwu7gwYRqf5
         py/6I35KD4oWzX//nEjcGt6DukEI/iAcP2MJdbGzlZhwFY8ZkrdEO28NCIUYlEgknAaM
         Wt96bA0calBImoo9jGVphR8Pnf9yvY4trHGkVdXaxkOUsWWHcBQNsJyEDNIGFUe+msM0
         Je7VwrINSSeTSMzkuvH6a/749jJE+abdnHDNuEqphz4VVu514+6vHU57iUW2vCma/TOr
         HT5rnwNTDFFhwaVbLNeWSuR3+lbwwWUV4zELlmrVFYSQIVMJFphw1s8Y2ys7WnE9TuWs
         RyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420559; x=1778025359;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge/rG1b9OBe+4PbHVqQyIr/aQn367ZGUNhS1U8adnfo=;
        b=scuuLrBshQc82ocaqQw032zmToNy+Vj8tUa9C5lQiaOyW5SAtMR5cHmUOJdPW5xPLD
         ygJxYi8YUOeFsfTBC6JGsvxNrkmn9Kq6kgK4/fsCs7RtqbzETE8Ab0peRlLytWylKtix
         XXcffuKNP8SmG+fYWdEm5jS9//6me+CwTilMXaPSn+EatdSkWnyUuLgtRYRf8h8fCSaI
         JQPwaMgtkUQmTmTeppOAeEoeQVHpZssRrfv06RUjFiteZLxZHmiCLM7jw9AzNGacL5T+
         aueqUkplCqof97SMhDV7enu9gnNEptf+mmhDFS7WcaJRi5cPDj3W7G5asBpf0DRQFvuK
         zgpw==
X-Gm-Message-State: AOJu0YwbicyfFurYx5wHJSK9tz7zw/AywPEUdMA1A0ai/+aOlj8JMhDV
	voEUrYabUxtXPedb/i3EpnaoA68F04qoRcdEj8RVxLRNVMJ9aKeX9FQpHiSyaga3eZu+mbZ7q2a
	m+cU7JUBEOn4fR2Vv5IYl8sI003+gEJIVMRJl49G/
X-Gm-Gg: AeBDieu5jmLLHi9lgP/ELcTt5BxCh1qwF9msPWIrSz7NlL61Eq62AJfcAzuK3QEBxc6
	k8ejhlA1WnDw5JJF4I0ib+RseVaV9PBGc0atza8Xb6NjSfjJgAbmZCecf/H5jCTuG5OLrs8HALG
	GtIaf7NQfOqtQQ0IAC3yyBveu5fplArSArWHJwGM2H6saPQdVJfrRHtP6LyZ+FxCCJDA+OmGekD
	NJMNna5BQ7QBqkrMOloUS2odgwC7q/fH+bAxYRWEEwmCoM/d1hOYg5+47h4MjMs9kdd73pItPab
	BQPBpLL9Q73dcAoO/RZ7jgh3pcQt2uSmgPYHt2bmzqff8qNmK1OV4BW8W/+b/Smq+wYPdKe49TD
	wE6niUPP10bJhMuQ=
X-Received: by 2002:a05:6102:5cc8:b0:607:a215:5b7e with SMTP id
 ada2fe7eead31-6292508be42mr1343754137.7.1777420558644; Tue, 28 Apr 2026
 16:55:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:55:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:55:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
References: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 16:55:58 -0700
X-Gm-Features: AVHnY4IuJZAp5GnOQnx5fskmUHrzgNx-vv_jZja4hevdBD0S2wZ6bkVyLEjbZIs
Message-ID: <CAEvNRgEapSgtbWaW_fNbDjaKSG-AOSqi0qqzODx2h8UrOb=cjA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Include linux version of mman.h
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, pbonzini@redhat.com, seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rick Edgecombe <rick.p.edgecombe@intel.com> writes:

> Fix a selftest build error by switching a mman.h header include from the
> "sys" version to the "linux" one.
>
>
> [...snip...]
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index ec7644aae999..7c113b8c4f75 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -14,7 +14,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/falloc.h>
>  #include <linux/sizes.h>
> -#include <sys/mman.h>
> +#include <linux/mman.h>

Thanks for reporting this! I'll take note for next time. This works fine
with my compiler too.

Tested-by: Ackerley Tng <ackerleytng@google.com>

>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> --
> 2.54.0
