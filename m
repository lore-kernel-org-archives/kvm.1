Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE126ED59
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050720; cv=none; b=jzvABTfx6XMNpN20Jge9Qr9Q5WDUxHfDoNqFU466to5E/EUIXGdFZtsJ6x+EPBGRsnG6l8UeTknqO1sC6lIk7EmuYXR9f8aY5GEJMcxLK7WM4z1AFChOLM/oM9xnGXSCpZ0/lCg41vT5o13MhyA+7hYGPgzohU+aShFRjv/dT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050720; c=relaxed/simple;
	bh=73uUBydhTJ9kiw40BhpuQa4vPgQRTsDCCbi38Y+iOis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FYVCau/7ESHXo+hpZSsNaKPcuZP95fw1QBmE1HWZ7GtH4CWLKu1oE5/8nX3Avr0xednPN+lrt/hr8Rb4V/YJQGgJc9X5IxbwehFodzWcY5dKEqpehYhWQogEn/5lfctY6JYc9vDQ6jicYvaID+pJdMzmnaW+jFrQKE8bzYCpZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDatz0xM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDatz0xM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so131447a91.0
        for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772050719; x=1772655519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGOTi7L+9kQkTZX4usPtOtn5qfNrhka9c/M4/aVdHLg=;
        b=hDatz0xM+JUM26K9lK4wxKv24uH/+W7Ql69SXOPbCrFUR5U0qY8RqQU646bLe0v+5D
         q0tZAisw5b5/2VCQPhk2v2+CkHIZFtpPFE01naSnH02RyOzON1lp0FGkEGsxT7nyVd3i
         M0yXI8j6j9H8hbcSECHcHswqNZQqX/5Dmi0FuAj25oFXzJ4qU/Mo/V9vJ8iiP2MeD6oP
         LCgHWrYoI5LnkXslKNxT1lOtSsPV3qZSPfGirI1f7lwuVvxVxxjmdS4+kqEbOrQ+AvNc
         CPqLEp4cqemQbrXpkdGCysVK1OQ1SB1GEx/tWJr5nzLT1P1jb4VCaohd1WucRVaKGmV9
         clVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050719; x=1772655519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGOTi7L+9kQkTZX4usPtOtn5qfNrhka9c/M4/aVdHLg=;
        b=LmpDF272KQHIGtQ+/RvIQZIRzuwbMNGDgKgKjrU6Ko4u3Fg/cfjFJC67IBcaEoBWpF
         EcgBTXJc7zFgDJ0A5+ZIDNZe++v5wlZ/fPh1b6IM9xHpSPRJ30aYoVM+GKnL3kU4+3K8
         Fjpcnn/O8AlfFxqeZ0C6C/98wYYBTHriIDUMnOvAOvJYGikAOONMH2RFGN+Dcm4A/7Uq
         mddmAK7yXkZ7MF66i5eNiimSg3po4ZvQ+OBlJvBQ1TaYkib+IryYpECfLGJqEz3fpNKY
         imUw8azjX1uyiodqcYeCNDgejlhTjRam4zHafyVHVOnT3maZoemh6H4dJv8GodVc062O
         CjPA==
X-Gm-Message-State: AOJu0YzueKSu1nM1UHRFQ/Sxh9O/b1/EZPpNJw91vmOIt+G5otUWD1Yq
	O1YatybFosgT2mShzsqp3NMS6R6RZ0quSfwAxgVtSfzmOxve8s0nR4O8vS4RpU8gIFdSCsoHQhM
	+yAjxYg==
X-Received: from pjbsl11.prod.google.com ([2002:a17:90b:2e0b:b0:34e:90d2:55c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc9:b0:354:57eb:c826
 with SMTP id 98e67ed59e1d1-359385d1493mr261264a91.2.1772050718473; Wed, 25
 Feb 2026 12:18:38 -0800 (PST)
Date: Wed, 25 Feb 2026 12:18:37 -0800
In-Reply-To: <20260120144550.1083396-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120144550.1083396-1-griffoul@gmail.com>
Message-ID: <aZ9ZHTGFCh_TGeUm@google.com>
Subject: Re: [PATCH] KVM: nVMX: Track vmx emulation errors
From: Sean Christopherson <seanjc@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 20, 2026, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> Add a new kvm_stat vcpu counter called "nested_errors" to track the
> number of errors returned to an L1 hypervisor when emulated VMX
> instructions fail.

This is too broad/vague, and very imperfect.  E.g. if a guest is tripping on a
specific VMREAD for whatever reason, it will pollute the count and make it hard
to detect more serious issues like VM-Entry failures.  And if VMCS shadowing is
in use, KVM could easily underreport meaningful errors.

I also dislike implementing this for nVMX but not nSVM.  nSVM doesn't have the
same ISA surface and so many of the errors simply don't exist, but at the very
least VMRUN failures should be accounted.

And counting VM-Fail but not faults is rather odd if the goal is to monitor L1
hypervisor health.

> This counter should help monitor nVMX health and troubleshoot issues
> with L1 hypervisors.

There are lots of ways to monitor the health of L1 hypervisors, it's not clear to
me why we need a KVM-provide stat for VM-Fail.
