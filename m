Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACF2DC350
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311845; cv=none; b=ZCYcXqgsWhpipAjMixduodCfrjkEFMhMqBo0qJ/TjY/HbRERTTh7VZnEUcdkpnyxlzSep59PxvWVtKIK8JlNykR6OA77q7rGr1ZmkOuPZJf1rjJyCpeN8K3SHiMilr9325juWKJriuOyMO9mD1MZEVfRU4wdTueehyoHjMkOyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311845; c=relaxed/simple;
	bh=/zKxQ8iZdsr4xi48Zzi51p/ZB/+gEn/4USORIOsChPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Li2U3Z0Yn/Ie4LKpwCf6zA/MoA7kc/LrjQRt69nYOVM9zSJZFSpf7h41kSyd0rGaGOzMyqPT32ueSFdnVumsR9bci3VUHhrZNGQdyPsFtNzCRCpiLFc68mySCwk+ZUWn+tUQsD+EOQI4vu8fCaAOCfbnzLgu13+avrQAgT7VlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPslj8G8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPslj8G8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so686204a12.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782311844; x=1782916644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfGrFNRlDSxWyNH6ES/kvZyP4LNyB/raplg5IjcauJQ=;
        b=MPslj8G8iluDeg2qqZoyxihwrggiODfv8Js2UxSjWwBqjyitxj0/mvQbEIhGsEoxcg
         dRYOg5t+/tDPDxJV2VQFhlRNKyPWpldgMUwSdeGXHRp62xGsIM+2EEcc3qGxTdsTdVli
         XaEUBWHC0TaUAzbf9z12Nx79TeR1pEUjgBl1mgy9c7//HiCdRkN2GiWWrDzawd7IaAuZ
         KskneTYLQ/0G0sQjiIwRtpd2z7TX8GtYfflV7f7cZz7YjzCId/RJnooRrOCLWuPXF1SH
         FUJPrRB1N+Jqtzjb2n5OIkhQsLMmmu2E/zePjuMkMoxMXdKc+w6iIVQiNL+E79wsMFH7
         BVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311844; x=1782916644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfGrFNRlDSxWyNH6ES/kvZyP4LNyB/raplg5IjcauJQ=;
        b=GjK8wTlQsILwDWFZfEu5OaC4nDN8iLraEVpG3ZRXQnio0TxGBiC1/3pYNQwIGgAXIU
         G+WFcuW+2Ts2x358n8tG4cuaB6nzPTUUk2y6l2REn2IRDNCv+ME+YB+vdWcKaXrBSMCH
         /zzmT9qga8/tU28EGX1+rIWSt+PH1HCX36YajrkUhXrPxTnW29VkGbbpl1KeL54jxCwD
         xBJ/ovtZPswqZG+XEGtLYjsp2a7yZk8hJBTyMUXtPJMsrCcLeb2ZpE8K3LxBwcR/nRA5
         EXfpIK0p+Ls5Ax2P+zSIXZuDhuXbVYZfN/AQuA758v86mAUjWLZoeBbqMinPHSyY9D8W
         BUxg==
X-Forwarded-Encrypted: i=1; AFNElJ9S02nOeRU7dlmpwAsXGFV5667Qp6ijsmoutYOAhGtNjx3eq65+IY7WxqJI9b9rpjgKi9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhURGmcYKU5lPe8fWDOQbE8aXvmtfiNUm9/5Noftg+GvXWqUpv
	izP2OUbUx+8nSQN47+cIfMb8kW1ShhdDKcK1W6yXt/lRpNVKXHHZ5XoCHeJv+oU26kXDEG5e7Z6
	6MtkTtA==
X-Received: from pfbgs5.prod.google.com ([2002:a05:6a00:4d85:b0:845:4368:93b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e17:b0:845:3c47:915b
 with SMTP id d2e1a72fcca58-845a2a7781fmr4360645b3a.5.1782311843770; Wed, 24
 Jun 2026 07:37:23 -0700 (PDT)
Date: Wed, 24 Jun 2026 07:37:23 -0700
In-Reply-To: <ajvVaYBFjweVcqlY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <5c254d26-1dfc-4037-8ab6-5f8af6d0501f@redhat.com>
 <ajvTrLNWGgulNJaj@google.com> <7d03539d-2a97-44fc-a9c7-0b3687730157@redhat.com>
 <ajvVaYBFjweVcqlY@google.com>
Message-ID: <ajvro-o6V4ciUFNA@google.com>
Subject: Re: [PATCH v4 00/30] KVM: x86: x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Sean Christopherson wrote:
> On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> > On 6/24/26 14:55, Sean Christopherson wrote:
> > > On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> > > > On 6/13/26 02:02, Sean Christopherson wrote:
> > > > > It's still technically spring!
> > > > > 
> > > > > Perform spring cleaning on x86.{c,h} and asm/kvm_host.h, by adding regs.c
> > > > > (the kvm_cache_regs.h => regs.h is already applied) and msrs.{c,h}, and moving
> > > > > relevant code out of x86.c.
> > > > 
> > > > Rebased and applied to kvm/queue, with the following changes:
> > > > 
> > > > - Collect more tags
> > > > - Move enum kvm_apicv_inhibit to x86.h
> > > > - Move TSS constants to tss.h, include it in vmx.c
> > > > - Rename kvm_x86_vcpu_ioctl_get_sregs2 to kvm_vcpu_ioctl_x86_get_sregs2
> > > > - Rename kvm_x86_vcpu_ioctl_set_sregs2 to kvm_vcpu_ioctl_x86_set_sregs2
> > > > - Fix conflicts
> > > > - Changed srcu_dereference_check() to __force cast (see 18/30)
> > > > - Adjust commit message on patches 11 and 26
> > > 
> > > Shoot, I have a fully refreshed version that I was going to send today (well, I
> > > was going to send it on Monday, but life happened).  Any chance you want to wait
> > > and grab that?  It has all of the above (except for maybe rebasing?), along with
> > > a few more cleanups.
> > 
> > I was expecting some kind of conflict which is why I put it only on
> > kvm/queue.  If it's possible to have them on top, that would be helpful
> > because it means I can move what I have on kvm/next, before leaving for
> > vacation.
> 
> Roger that, I'll see how things look if I rebase on top asap, and report back.

Everything can go on top, and shouldn't generate massive conflicts, i.e. doesn't
need to be rushed into kvm/next and can go through kvm-x86.

Thanks much!
