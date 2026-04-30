Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7493D8908
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575058; cv=none; b=nVl7wGbX7qa+t2ZBtu7FaqB2eRRP+ITZgzrYWsNNRuCox4dTPnBKFx0EzDtzdbcfOdZNj0+Vil0QGSB+4s5vlXZKna1nlW3PbtpfwQisF12NgfUIEdiB+ae9j5MiUXiang+G5XHzRZgKZXWI7skUDsR02CL9Rvb0lDvl+7R91BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575058; c=relaxed/simple;
	bh=wb9GRmqc/IIw6uajCQRhtjMAUJfDkF23eSLlPl6uddw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvE1Aacv+7yMEjC37GW2fSBh7qaMeMIUdhuiuNY9Itip9AqzrTWb4a8vMEvbAsJ7IxwdmTgpq+RYdHJooE4lI/41L6Ftb3DG96MaauW5nsPeRCPyvVZ39vU+vTyKdb50mNAnglX7jcMrSP58a7GPFxi6uVzDjn5o85+uSa+oOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eStVB8LX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eStVB8LX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-834e0452d98so1697547b3a.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777575057; x=1778179857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0e3+yDV1CkAO9M+2+Z5fbqi65giDgZ6if7u0nCSgck=;
        b=eStVB8LXvjjNC+iW1p0n01kTsVqBBKYY3NkGVBgu4UoUDtDh8teja6nRBsnwLAxuxM
         HnJyDapB2W79lyiAogAU3tgG6MTyFxqDsasKxGSJ8x9/MBVQmzn3lASNc/+68b6mqeSI
         lr97Bv8purvvydDwDv8TKGcADyxbwLrzh22j4zfMMMsCt+yBX+I60ac6CIxAX2DwfVCk
         ehOY2qlB6p7wj/qEroqwGBLrCCik95A9ZNxorzerN1txpTXvkS1NOQBuJHZEluNAtsA2
         38C3uz9dxF2++qsrHmw4Jbk+WRw7vr1n+0mz+yy920AKCsxrCsiPAXjewiRSPJwTZk8A
         t5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777575057; x=1778179857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0e3+yDV1CkAO9M+2+Z5fbqi65giDgZ6if7u0nCSgck=;
        b=KhJYE68J6ezd2mocl0WvI6a7JPFDH+2daD4MDYMJydxUYaX0HeMvzgaUX9fMv3Lbjw
         FTV6n2Qb6NXbNqG+BlgCCw24xY7uiyf9v0fUYmlJ+UffmJd6L2JEYY4DzNPD+HXyWRMg
         c2ndiH91pyXlsQ0LI47ghy9IwyRnH78n6C/jAXPTFb63aoXFaZRiLycPbZDPT+D8Q1WJ
         iGjjuKb3IqjDVzR3zpPD6s7bC/5OW2hy4KFuKk1COP1KEPNUvd/Z0hZQv6B/KhdWGSDb
         lOvxYN2l0BJIB9KvfC/Q9SHALjrpNrlEM+5ec131X3FwmSxv9+TOOstQd4cYD2MlIKNx
         txTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YM6UYDAoNHyogvNPNwaa5hGizUFsXC8a8/jf+VpDGtVZuwHpHljCZbPt4I0gLZ5gBQ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSEJN5rhsaO3DqdTWK+mr+xvGgyFVmSGituUKnFLonJIhiBgA
	da/i4i/I2Lix4HlIcckdUrLJ07jjADCUpKL6keLllslq9JMgk1/oPm+AYD76KcAK/rEPJyFdiGD
	CFNSlnQ==
X-Received: from pfbfm15.prod.google.com ([2002:a05:6a00:2f8f:b0:82f:8956:e620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a3:b0:82f:3828:a009
 with SMTP id d2e1a72fcca58-834fdb0e051mr4571516b3a.3.1777575057015; Thu, 30
 Apr 2026 11:50:57 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:50:55 -0700
In-Reply-To: <20260430150747.76749-11-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-11-pbonzini@redhat.com>
Message-ID: <afOkj-ngsW0udc7p@google.com>
Subject: Re: [PATCH 10/28] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com, Kevin Cheng <chengkev@google.com>, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Kevin and Yosry

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
>  static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index fb1b5d8b23e5..567f8b77ffe0 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -376,7 +376,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		walker->pte_gpa[walker->level - 1] = pte_gpa;
>  
>  		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
> -					     nested_access, &walker->fault);
> +					     nested_access | PFERR_GUEST_PAGE_MASK,
> +					     &walker->fault);
>  
>  		/*
>  		 * FIXME: This can happen if emulation (for of an INS/OUTS
> @@ -444,7 +445,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		gfn += pse36_gfn_delta(pte);
>  #endif
>  
> -	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
> +	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
> +				     access | PFERR_GUEST_FINAL_MASK,
> +				     &walker->fault);

Mostly a note to myself, we should make sure to land Kevin's fixes for synthesizing
the #NPF error code and EPT exit qualification in the same kernel (which I fully
plan on doing).  I'm just happy we all came up with the same annotations :-)

https://lore.kernel.org/all/20260313071033.4153209-3-chengkev@google.com
