Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088743161AD
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164526; cv=none; b=muprMbB1D6xWIIFv4d+UDJNCU6fpfxWVXkogiJExBxfSZR+46+KT5ZkdQHfnn06PC5HLoLPeiVFdiXdxG5YxtHj7PqZv+R+N6JOPEsFKGpo3mTKRTwZVKvzBaqhRJ8zknZKH9dGrLdPzTLdtQE4WyJOGDL9d+zAOaYAn3GU78T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164526; c=relaxed/simple;
	bh=vj2d3TM753Qomga1RBJYrcXk+fAbZ3DoPSidDJ7x8Jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jl+C4USfuG/SUs/OIEs8IdrpUxdEfVhqnK1N/8VGyXEfbk9dk0MRXWGXBP8vM3vDe+mRSoalrx51woZBrBi4o60htVpwmo7dT4iF1DY2wZa4UnzD4ZrMr4U9kCpbDewB6Q0stlfFXqNTCSUfONiimLOhRXUcPM3JkEigudlEMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfSOMtet; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfSOMtet"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662668b825so788426a91.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778164524; x=1778769324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOrneIt3h9O5z2JucWZogecaGRGz+fXsHgOHCEh5Dqs=;
        b=UfSOMtet5o84WTezCAT5Qo3OS9Kn/iF31GDgbrix27RoZAnSSrHO23S0W18nnQ/kZ4
         MPvvH1OD9/sNpw9nAIYy6UdAvSiq6BCJWJyyu3BbgMfLtABf1TsrX7t5SZghMI7ucwg5
         l96Gcmh7W+zKl9HlxMwmTsan/Ng6v7CHYHAxbsztDy1Sw0R5u2gKLDDHZ4jkbbUltGvU
         cUF4zly2BLqFrDfZs14EQw18qjxKV5L2YVjPlWBqQEUZK0AOtEexva/eE1FUbcEUg1rQ
         OWS+wV5tCdCoum+/tWjn/BGyq2pEgjenPv8kw11dz6XEE67zc0DTob4nyGZ27QLz/V9Y
         DhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164524; x=1778769324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOrneIt3h9O5z2JucWZogecaGRGz+fXsHgOHCEh5Dqs=;
        b=SXl2wmUW7khnkuUdZmNQv+tqB98gz/AzfzGRJvz6/o3wOMBpEx9t9C8b7DKxe6JoAx
         tsWANdlGBcT1iRQNdVcU+eUWwyt1wP5H9DZZld4Gx70Oq1SMNWkLeOLIAg/ohBYbG9WP
         KmPloiZh2h74qRTLsxlgpmtaM1Xr9786XqsJqDmWLGKWlpz9hUenAnfmqjGP0KGMfbhW
         AJxrNai8Fo9j3rVTb/uupPdmColRY1SoFTRM6ab1La4JexMOFLJQsO0Zso5/LKgeyK8C
         mbX2vc8eZvUbR51QsHpuBXH+kvMc6mlNhvXDb0RxUUdZ6nJuo2ouxa0pEfAqBD46k+cL
         0xAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3o6edIsVnmX60F1e5KzTbRVAS5v8oKVU0JjEZEuLzjxfSgy3kthKdx0c5qZrh9NnYWeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwoMjfBov8orNWbHgTjgr7xyGmSRLfjj2ienD0bFBc57UXxXJ
	0jciFMhdjCPvFYEZbrgeoZTASI4tV4iWTGUz2CU4dGAG81PDecqWPE8YZpOjjJ5QUSzNVtTMAMO
	5nqzrMQ==
X-Received: from pgbdp7.prod.google.com ([2002:a05:6a02:f07:b0:c79:607e:269c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57eb:b0:366:132:fda7
 with SMTP id 98e67ed59e1d1-36601331e37mr3678227a91.10.1778164524025; Thu, 07
 May 2026 07:35:24 -0700 (PDT)
Date: Thu, 7 May 2026 07:35:23 -0700
In-Reply-To: <20260505195226.563317-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <20260505195226.563317-9-pbonzini@redhat.com>
Message-ID: <afyjK5HOF63-95XL@google.com>
Subject: Re: [PATCH 08/28] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, Paolo Bonzini wrote:
> Move more of EPT handling entirely in the existing "if (!ept)"
> conditional.  Use a new "rf" variable instead of uf for read permissions
> for clarity.
> 
> Merge smepf and ff into a single variable because EPT's "SMEP" (actually
> MBEC) is defined differently and does not need smepf.
> 
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d94a488db79d..fc34536c536b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5584,24 +5584,28 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
>  		 * that causes a fault with the given PFEC.
>  		 */
>  
> +		/* Faults from reads to non-readable pages */
> +		u8 rf = 0;
>  		/* Faults from writes to non-writable pages */
>  		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
>  		/* Faults from user mode accesses to supervisor pages */
> -		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> -		/* Faults from fetches of non-executable pages*/
> -		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> -		/* Faults from kernel mode fetches of user pages */
> -		u8 smepf = 0;
> +		u8 uf = 0;
> +		/* Faults from fetches of non-executable pages */
> +		u8 ff = 0;
>  		/* Faults from kernel mode accesses of user pages */
>  		u8 smapf = 0;
>  
> -		if (!ept) {
> +		if (ept) {
> +			rf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> +			ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> +		} else {
>  			/* Faults from kernel mode accesses to user pages */
>  			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
>  
> -			/* Not really needed: !nx will cause pte.nx to fault */
> -			if (!efer_nx)
> -				ff = 0;
> +			uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> +
> +			if (efer_nx)
> +				ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;

I still think we should do:

			if (efer_nx)
				ff |= (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;

so that the order of the efer_nx and cr4_smep logic doesn't matter.

>  
>  			/* Allow supervisor writes if !cr0.wp */
>  			if (!cr0_wp)
> @@ -5609,7 +5613,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
>  
>  			/* Disallow supervisor fetches of user code if cr4.smep */
>  			if (cr4_smep)
> -				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
> +				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
