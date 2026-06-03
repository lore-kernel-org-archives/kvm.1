Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1136920C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491539; cv=none; b=TCmTK+p3vAVvlfRKqOQxfVwmt1+XfGJ0WVtsSIGdM7iFMhXOzbc8iv+ILvBaBRzeJ1wL9dA2iCbHlrkkq2OJYqx/6uDsGJmwLazu6UtN6uKH62rtW6t7rdNEobqr9K/aDWplE+28/AooZo1ZnZhvmTi2qwoi97TXViEfjn2kuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491539; c=relaxed/simple;
	bh=FoBTOu1Hi6Moal5H0OnsKeOPkY87ImGvnlylQI0CaEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Al1N79fDD0jVe9Jw0xNoiDqQGBIFg+zxKBlM/4Mp+Q7WaTZTaLmLJF/cRjl8SEKzWeg47jQaVQR8kuYf+U/zfCE3bBJtgMPk7JJyr0+xxirapzUgAdL6YjRlBEQPvas0o38DB/vRg6esGbqSLKu0q6nFRJ0VBNQZxhjuAhxVc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwziCltP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwziCltP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423770d72dso5141282b3a.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780491537; x=1781096337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e6Xor7KWIOLHBGPwzaSZooBoZoPu+si4cO9i0Tt5FY=;
        b=MwziCltPG08o5EV30EARNBl9yitRLCSjoR7DlyfAIQoPVD3cwnZixsA+k3bxju2RyC
         WmNmXdmGEr6Nms8RsvyHWVakF/8xzU5G0EUWwlsuh1fkXTjDF/AGjBhPxxHhkXtFN9Yn
         EFLw7bN+CA4wUOB1svUMlNiscZL8DEs5OvlamFUfPECxdQ/ojUHf0U2pTI21wftRppPK
         lCSqJE5eEOTNT/o97owNl2F+/vrGG1lTMQZ6ByPZWH07b7nM7Q13JrYiN5PudYkbWs88
         BErluefeFPN3wzC7zRWKl535UsViwrd6lm6gKVBLEFd6ggkiPvJZv7UjocGelBvuRtMW
         lxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491537; x=1781096337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e6Xor7KWIOLHBGPwzaSZooBoZoPu+si4cO9i0Tt5FY=;
        b=X35mwSHPii67UAzSp9cdQqN5OvfNQUf4cVO532wSMT2AvD/TkFZ9/IutDnOSnZPAJs
         ztiiaRqh6atIaWzmBG+uVzZm68z0185In+o15qf0ZajR0tKQb7FD9KWwC4f911UfOIGc
         hIymqo6qo8B3K/rVBXuUtK/pD2BcjJ+kOoqIgwgFx8OMhjBX7R1zfcZCTGdFHnLlYmxy
         zpnrFpnSwEhVRJ5hHdn/RpBI2EzDxWp+el3vtAcglFdoHQ2b85iQG+wCBejY7Zyg08Ak
         JcR/7N/ZKpUwEUsblSmuxbEoBMtHL9hLNc+CFQrqKRHjqMThdm4uSU27Uh0x+eSdR3n6
         7qMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MIMNtpFaslhVo3mHrizmxZe6/n5w5R0RxqGkMyqIyU89T4qWKgMXQ9DyZ10JPmNtrHGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGw7MAQkr6vD1BaKy4yf2zlxiMEmZ7dI+2Qew5GLbP2jLJD9mn
	zabhaJhBUdTshCzjLvrgNITC5lJ15wYpgfeY7/sxRsikd6Mm1uX3ZKsMJgEadOHe3MUMYuybGL0
	4IoYRsQ==
X-Received: from pfbfb40.prod.google.com ([2002:a05:6a00:2da8:b0:842:8522:9ada])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:429a:b0:842:708f:39a0
 with SMTP id d2e1a72fcca58-84284c5d1admr3412510b3a.8.1780491537367; Wed, 03
 Jun 2026 05:58:57 -0700 (PDT)
Date: Wed, 3 Jun 2026 05:58:55 -0700
In-Reply-To: <f1cae8a8-8842-493e-9b6a-6f0e0d761c4e@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <f1cae8a8-8842-493e-9b6a-6f0e0d761c4e@redhat.com>
Message-ID: <aiAlD1y2St12j49z@google.com>
Subject: Re: [PATCH v3 00/40] KVM: x86: GPR accessors and x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Paolo Bonzini wrote:
> On 5/30/26 00:21, Sean Christopherson wrote:
> > The first half of this series adds proper, explicit "raw" versions of
> > kvm_<reg>_{read,write}(), along with "e" versions (for hardcoded 32-bit
> > accesses), and converts the existing kvm_<reg>_{read,write}() APIs into
> > mode-aware variants.
> > 
> > At the end of that journey, introduce regs.{c,h} to avoid moving _more_ code
> > into x86.h, especially since the resulting code split would be super arbitrary.
> 
> What about getting everything up to patch 14 into 7.2, and then starting 7.3
> development with these, the MMU split series, and possibly the pfncache
> cleanups?

I like that idea.  I'll grab these two as well, no reason not to.

  KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration
  KVM: x86: Drop defunct vcpu_tsc_khz() declaration

> I'll be away starting June 28th, so we probably want to get those three
> merged into kvm/next already towards the end of the merge window.
