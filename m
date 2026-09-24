Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284944F4724
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286909; cv=none; b=VS61vsOfM9bIRAUlNBEia7parVvQTPpyP5Jn91cSHkUIwyCvsg1WzGij1SIU53pi2Ylkvjkocr2dfVVCEOXgme3M8H5VHnlEmFYvPpY0NaqPvFGmrCZ0k3M2x3Hj9blY6Diyg2IlWcPiY98vCMfwQErk5T/15JWdqzps7+1G+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286909; c=relaxed/simple;
	bh=2ZGU//KYiJQWmwlH/Q/XMroPyMM9p/vhyZIryzwt08k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UCVsIjHfa4PTkGCNbWYjGlKe1LgPDGcGGZMSGCWP1opy11UXFl/dKgbm+AOKmDpSpt+8ElEWW1WjPaQ3Kwjt9YYv/jH6fFI1ZbDeH3NASSMJ4kzpXER9GFpgviMu5JiE8/s3lTqHRmBjOLBsh+DBD7WNfTC9T9af+FsI1ntt9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWy1KCmo; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWy1KCmo"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so177626a12.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286907; x=1790891707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktQrlSrVcwbzp91Jk2Fph37MAeo4cET8GqvsyuC/rgg=;
        b=dWy1KCmoM5R5MRuotI2vpBxq/diZG9lSCnXUkpXyUl6WMCPjs3P0CNTcm+W1SDZeEm
         gkngj+S+8C7VL5Hewq3NSFPmQPv3BYh9gi+Rk2qXGZN4mnqBo2g0+uz/87Y0JO8WM/oc
         uDPANSTBAaJGSYvrSBKhHlDDjXDCbt6XA3BvR3rGMeWzi2aLNnmlQistyhNMHVQXa/v7
         Bu68W4MiDMZTlNF69s/DK/IKUforWKdvXdpBmCIAYrwl7LLsGwTaFfT796k5b0h+rpBc
         bOwzLQ/vGOqbybToaMlUpjl/ROGKgh7/6JWJL07x3KOYS4FwJgegMFWsl8YPonl41N8x
         ixBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286907; x=1790891707;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktQrlSrVcwbzp91Jk2Fph37MAeo4cET8GqvsyuC/rgg=;
        b=URNN1wATQT0ECtLebEveeKxcabEXKudAmSb92Birh0QpV3V2CYLOd8ZdO/+siqEUmv
         clTs8UU+2GRWws5+BOc4M5iC/pi090R9zwAEw9x4PLJwuu0ydArBJ/fB/zFJDtPH4P18
         N6pCkheEoxI+mtBVj8P6kxHJmD80jBWviwbDXi1vZ5eJBIsjCM85/RGm1KPsEtcKPtOr
         kLZfFZwmm4e0MnCPZruCZ0jpicKGzu+irgfwZOiHUuOdlQNmZr5MIZ8AgS1FXygN5EXq
         D6e5t/LpUz+NiMXoOrmbkKy5sToOf73aCndPt4tLuSxpVJ01NIi+1AFQVv5NO8BHDMWM
         3rhw==
X-Gm-Message-State: AFuF++k/csFOl9IdhLu7iGg3ejuDZuQkosjyGjDhGdi4YveZ1TyfJbI7
	giG1Nyxpl4ebWhtxeGtHxu3qVGFlPEhwhg9JB3AeKKse/UhCO5kiN/Zr7KX7/WsWJDWOzG8BtwN
	zrV5+Ew==
X-Received: from plar20.prod.google.com ([2002:a17:902:c7d4:b0:2dd:4a8d:e22b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0d:b0:2d8:d4d2:d13a
 with SMTP id d9443c01a7336-2df7e251e68mr21560155ad.22.1790286907302; Thu, 24
 Sep 2026 14:55:07 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:52:07 -0700
In-Reply-To: <20260922000152.1113202-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922000152.1113202-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028365423.2005474.7634424655738990561.b4-ty@b4>
Subject: Re: [PATCH] KVM: VMX: Move bus lock handler from main.c => common.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 21 Sep 2026 17:01:52 -0700, Sean Christopherson wrote:
> Move the bus lock VM-Exit handler, which is basically a one-liner, from
> main.c to vmx.h now that to_vt() is usable in common.h.
> 
> No functional change intended.
> 
> 

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Move bus lock handler from main.c => common.h
      https://github.com/kvm-x86/linux/commit/6088c9a22012

--
https://github.com/kvm-x86/linux/tree/next
