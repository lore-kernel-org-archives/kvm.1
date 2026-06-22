Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758436607D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170661; cv=none; b=owD1zhTeQHynwAsKy8ILAvUrikKLy9Y/ylNJUtUdviaJncchVoD21rCfkqSEdDnW4+kV74bI8Rhie78ur/J4jf4oly6DZzNwm0A3qsR9frnQEU/igE9UYW+FGIdXeAzXI2Miuy20kcAaGMYct+bvWwqO2QLfBSLoGFeXxokW6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170661; c=relaxed/simple;
	bh=0V5aFlTAP3HDjqJchWWwkrKYsK/J0SVPgaTqiNVCWCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DB76LvzSEENV9mRQpfc/j/qqAgrqY5A0jHyBwMFVMt7TKc8MtycKv6JXAxojCd8xUk2/EstPKz+vNZLzN1HXQugz4wo4UimhfsZ14ESoRc+Hnl61+19Z9VmIGc9oyGkSO/TRFtTMPqTtLdTc2CIKIttTjVu60zYNvrwu7Liu32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmgvvJbX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmgvvJbX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c64f7ff48so5692967a91.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782170659; x=1782775459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3f7XLGqPTxRTmDugimLMchWIMvzKC9ZhqGzcD0/AM8=;
        b=nmgvvJbXNoDB9Xahb5veX4XAT4NphFtJQLgUB4gLboXgDwNZ43Md3jEHJeZjkZJyUX
         QXETw60MIaZEQ0XA3bbYyKcMa8lYdVAP2z06aMj6t4JxaRcU5hlZ0jo+xGVsOqdm0sTk
         P9ye8POFytN8tlwwXIv+6hkNXA1EtmQG8uqSX7q1LcKJlq5vf5wk2AyIyBl8OZc2yB2D
         BaB6zvn6ybypfEbDp3a308QhxIdvj4+76Hm+AksZt759ZYfRZxTYFzax7FpzgBcLPPKu
         dsuixsSjEN2uxO/xSHZDVBMpRivaGGZeyu3N87ev0D+3dKQqxZp90Ezu0LA6Rg9GQ8cL
         b7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170659; x=1782775459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3f7XLGqPTxRTmDugimLMchWIMvzKC9ZhqGzcD0/AM8=;
        b=Pr+3zXkOl9QldQx/kXUrwBrabD+pMiMVweHULMKf+qxsV/jkSzjCbBlBytY7wadTXd
         lvYO8ysY0zM0oIMZBy2a3TItIAbevuHS2VCt1Mj5YSIk74woI1xdm66Gr9OtAK1fpYSL
         wwZvQqepwlct8s8J+VkhmICsvDoWp4lDQKvghS9UWlubqar5e91I8/8HQKLFDJRTqNtq
         c/1MwH3mtS6V5SCO53XVyViVffcCs4sz2e308cHcw+CrR2z6rfxWNpSGLIi6+KD3Daep
         gROHXSeccPA6+OZXbqRCdVo9Lhm+sEj8teQ6zdH78Om2mxvzPISXIiKamjiyizIydVFe
         wgyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+c4v0rkyCf5ovUxQGUH3a/D2Pgbs6MxhJzt/zIP9lvjCANXQiTYkCJ+0UlwNOEoBeeySk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VkHQbu7aFrZX2R8CWRkf2dnOlDWvXcsjoTnCsTTyafdt1qxZ
	k9jjLaIQvY/ThdRgo//FGJdBg1Wxbv9TUN6IZy2KtzltAGHDKtmV/ejfCXMRSu7I62olfSCApZF
	p8fq2uA==
X-Received: from pglq30.prod.google.com ([2002:a63:505e:0:b0:c88:a076:b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce47:b0:3b2:8675:4866
 with SMTP id adf61e73a8af0-3bd151a56c4mr594172637.31.1782170658663; Mon, 22
 Jun 2026 16:24:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:24:18 -0700
In-Reply-To: <20260619160645.57f4e325@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618185746.2023283-1-seanjc@google.com> <20260619160645.57f4e325@pumpkin>
Message-ID: <ajm6VPapXJNQpkzx@google.com>
Subject: Re: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad"
 nested GPA translation
From: Sean Christopherson <seanjc@google.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, David Laight wrote:
> On Thu, 18 Jun 2026 11:57:45 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > If KVM attempts to translate what it thinks is an L2 GPA with a non-nested
> > MMU, simply WARN and return the GPA, i.e. trust the MMU more than the
> > caller, as there is zero reason to potentially panic the host kernel just
> > because KVM misused an API.
> 
> Except that PANIC_ON_WARN stands a reasonable chance of being set.

Not in cloud environments, or in any environment where the guest workload is
untrusted.

> So it makes little difference.

I disagree, vehemently.  There's a massive difference between opting in to
minimizing risk of data corruption at the cost of availability, and forcing all
KVM users to sacrifice availability, especially for no tangible beneft.  Paolo
and I are fully aligned on this:

https://lore.kernel.org/all/CABgObfZJV5hU_7WoPWLRH3-EvKts%2BUBZOwtCXmwVZYJP8dDo2A@mail.gmail.com
