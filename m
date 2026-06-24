Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202E3AFCE8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305726; cv=none; b=Gt1njge0eEzYEufuoilCKGiF9KI/tMAgUqWcy6kgaRNMmSi23n16D3Qv5EbriGMQNMREbNv/0F2s2QP//y2p70fCZix2afLfPBRwNmB7HLNj2jiAlXUWUkHbXE1XEDOji2TEvO3xkvAHM2Xv5yexQN3EAu09m8tIqmMq8W709Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305726; c=relaxed/simple;
	bh=NLjtRvBkdhmNAGFal4tWXd7u8NKNhx62HEmkoID3kxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKiV4lSz4kN1hktmp8QSQ8EKUvv4lW+zdOitoCwEyM0MqU4tguTnJAwnKlnH+w+QGN9PxXrqCSpO0hr3mI+GkZbUyE5C/31wLCzib/F88v6LhlI7/qxG1kogN8OuuDBJlA2q7VuKRS/pMa4hAOd9e9wLSc+1YPXpZZYxvOyJkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQgXk8Xz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQgXk8Xz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so699125a12.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782305725; x=1782910525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgxssUOjnxNEhvqo+T3EzbX5gSgbIPqDF9WSUICY2jA=;
        b=sQgXk8XzQuactmbK7ANkZ/QfTPRJKoorxHQELLdn0zYI950Dx7o9i50tlZErQ8AsTE
         2+v3dUfcL4yLxDp+Rq382Hyxf4OrvIkel7zSzzYu/Ue+ak8p4/8DTKIAic7/gdOvniLE
         XGDFUu78zt/wtbQ+s3Ohnmi4zjXnfcOrxqdHt69EWHAitW//RESaIChRAY+lmUu4DzmN
         JbWz5DFSAl1APSF56N4kXBsUKij/IVAJ24bpTJBI59DEhBSUlOXIF8IvCXfO6MKkUzB4
         fyz5AZhBHP0JOxZr7x7vhRsq59x0i1pDruqUVx6VOmofmrCsIZZT9sDEm2Jf+pU9QAuE
         KJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305725; x=1782910525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgxssUOjnxNEhvqo+T3EzbX5gSgbIPqDF9WSUICY2jA=;
        b=kg0qA7wM0Rw77kucK6QDxwwK4/kb9H4beKIfioQoJMsyV/SNWnq8Nn5vkFWE4drzAQ
         RysCJI0acf4lOwJCWn3grc5XUDjDPYtbv9S3ch9wcm6zWMdOG7L0YKubbwRBWq6JmSRo
         zJ6VCJpNLf2gWL4DRnU8IelvoX0crbyrgqFkghZaZe4udi2andDDa5AFYbEsjLKWikLZ
         SmP9kicJn/Jjy2Ip7qhp7rT6mXiQYxMOFbqh+UDT629NSAmgaFrPQ1M9nF7oud/V1byx
         GAwRNe8h9M01QFZCuNIyvTT//yAg7l/zoBSjHyGMIlNAdbXfQc46k2i0J1qJTY5fQEnQ
         sh9Q==
X-Forwarded-Encrypted: i=1; AFNElJ856ylrxQE8fceQbQCWYsIr5A7NfcPIf89IuhcfD3Pxu9lW9Z4Uc5JgGpR4dLRklOEg+nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTo8i7/iZOHTTAAC+cwhaWAkyl6DRMZX0OhhE+XgLIHnewL+P
	N+S0pHT69zc8EFYzr474KLvI2CkBEjBqp6tfolHn/0aGu5sC7EqnOrWa6BWcmXnFekZVoB0QRYu
	6MTQhDg==
X-Received: from pfwz36.prod.google.com ([2002:a05:6a00:1da4:b0:845:aa6d:92ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2184:b0:842:68d3:e29f
 with SMTP id d2e1a72fcca58-845a26cf79dmr4484045b3a.3.1782305724733; Wed, 24
 Jun 2026 05:55:24 -0700 (PDT)
Date: Wed, 24 Jun 2026 05:55:20 -0700
In-Reply-To: <5c254d26-1dfc-4037-8ab6-5f8af6d0501f@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <5c254d26-1dfc-4037-8ab6-5f8af6d0501f@redhat.com>
Message-ID: <ajvTrLNWGgulNJaj@google.com>
Subject: Re: [PATCH v4 00/30] KVM: x86: x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> On 6/13/26 02:02, Sean Christopherson wrote:
> > It's still technically spring!
> > 
> > Perform spring cleaning on x86.{c,h} and asm/kvm_host.h, by adding regs.c
> > (the kvm_cache_regs.h => regs.h is already applied) and msrs.{c,h}, and moving
> > relevant code out of x86.c.
> 
> Rebased and applied to kvm/queue, with the following changes:
> 
> - Collect more tags
> - Move enum kvm_apicv_inhibit to x86.h
> - Move TSS constants to tss.h, include it in vmx.c
> - Rename kvm_x86_vcpu_ioctl_get_sregs2 to kvm_vcpu_ioctl_x86_get_sregs2
> - Rename kvm_x86_vcpu_ioctl_set_sregs2 to kvm_vcpu_ioctl_x86_set_sregs2
> - Fix conflicts
> - Changed srcu_dereference_check() to __force cast (see 18/30)
> - Adjust commit message on patches 11 and 26

Shoot, I have a fully refreshed version that I was going to send today (well, I
was going to send it on Monday, but life happened).  Any chance you want to wait
and grab that?  It has all of the above (except for maybe rebasing?), along with
a few more cleanups.
