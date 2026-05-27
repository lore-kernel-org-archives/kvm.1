Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821E47CC8A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905685; cv=none; b=ioiR90PiyxzCmpOGwFFeuaFQuEmHskOJOdlstXT6s9tUb7rkpDwzMwT14sCp8FD66S+TLBeJYx/ghRRwYK7q9CbC3N/3Tque0yFe8IZrVQOgW1TZ+8cB+dy67W/X7zp6ODNhCYbXUAPhxopYuRFiqpVOWkIyvIDMbFrZw4hSnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905685; c=relaxed/simple;
	bh=OdkQYg9fKRcLy8CeKe0nSAB38xYFhj3xHHgAxKzfI/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zmr6ITGUBzWPY1088ug6yS0kWHflXwKO1Q698Bw7D0BGE+JlT9NQJq+AbvcJwX9pBaL/0wXcFwRBFQX2Y+B8RQWrur0AvMvDfGpSI96C41sXw8SBq5dt9mdNgsy9MbPHU04sZpWu/Fkf4fps+CJt+8kJHNckUNmcKoSHJwgXmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLtPsTCA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLtPsTCA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368b01f8adeso14910136a91.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905682; x=1780510482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v08qm7HHU6Iqudc85UgZ/ZNchG+m9a7a7G8otExlR3M=;
        b=cLtPsTCAwezMVoUH4uejbZr1wfZlvFg99pg4uYjHfuIAJNjH4ipWg3Knz4ZJ/PmJ7s
         Q9ofgmdmlvnh1EVZtVRnH0eLpGML3z3uQSf/jU88cWzdsrsxNBcC0HpIL/RYu0SwGpv2
         C3k1CgLShQG9kpa014pRTaiDROvasFmgiBIa7F5DueTR8tjB8x/tnCh1Gwj7d7cWfs1I
         q941JRlD+RhcqoL/y7d1TEe17u6m1139j+3X8O9opre15TEJxOFWCRkHXdyGXvHZlWkl
         CbESVC9qkYF2MO2dG+IW69ReLKKPidcvHwQRYj503FzRCg5Pfd73qTbNOnxudI1WvH5k
         NNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905682; x=1780510482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v08qm7HHU6Iqudc85UgZ/ZNchG+m9a7a7G8otExlR3M=;
        b=b587FyCoJpYv77E6AExUDHWB71jIqykvtNpXfWbKzXbMTT+IsxI0qWxL9uPQ/W1CgH
         Mseb8kkXYdMm1apVCruXj0NHhfxaDS2nIj7GHFGLa/ucKXqmQS/tTUYbxfOnfJQUu6UK
         dbv7vxEHxN18CKsDIJdhQxIGYDNnKt0wdL8piPzrjEroEOtTH3XZzoPB7ZQZqyIlj2bm
         iE12JZZz+7r3hA1QF9ppMC4i6ql7Q4lV5Y8WEHvWTqPPr9UmGNBLPd1/mOYM0fMvED8F
         qX+elosqP/jOWiO5OUMQCiREidGs/RHZcPIec25xP8beg8wBruyG7Pcuo3znLL14GLxY
         7S9Q==
X-Gm-Message-State: AOJu0Yw0+TvkkJhGy5tSZ4FYttXne94Ob4EpJoAu6HkDoCb+BAJEMXC8
	6Q0QtCJ2TmSnsCtv8HP6CyK0ZgVaohsaCje9YYk7UlC3a2hanbWGY2+apMXU9qj6RqF8F0h3cua
	nyICmgA==
X-Received: from pjbtd8.prod.google.com ([2002:a17:90b:5448:b0:368:b689:fb90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:35c:30a8:330
 with SMTP id 98e67ed59e1d1-36a671ddedcmr22896140a91.0.1779905682359; Wed, 27
 May 2026 11:14:42 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:16 -0700
In-Reply-To: <20260522171535.3525890-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522171535.3525890-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990525056.4121118.3430310763169481740.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: selftests: guest_memfd close() fix and hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 10:15:33 -0700, Sean Christopherson wrote:
> Fix a bug where freeing a VM attempts to close an invalid guest_memfd instance
> due to checking if a u32 value is non-negative.  Then harden closing of fds in
> kvm_util by invalidating fds after they are closed, e.g. so that freeing an fd
> multiple times will fail instead of silently closing the wrong file.
> 
> Sean Christopherson (2):
>   KVM: selftests: Cast guest_memfd fd to a signed int when checking for
>     >= 0
>   KVM: selftests: Add and use kvm_free_fd() to harden against fd goofs
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Cast guest_memfd fd to a signed int when checking for >= 0
      https://github.com/kvm-x86/linux/commit/849d65e27bd6
[2/2] KVM: selftests: Add and use kvm_free_fd() to harden against fd goofs
      https://github.com/kvm-x86/linux/commit/3e8a0b991223

--
https://github.com/kvm-x86/linux/tree/next
