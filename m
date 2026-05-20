Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45353191D0
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293602; cv=none; b=NFEpwJVHZwDHOakHkxiMJ12JdgblFu2Zq9KGnfO68UljUgBxuYlBjYiEAZtsEj0EjSIFT4jly8LHsmSyF/LuBYhBICEZHLj8TsD+9N8nzuC0hUrfVtpcIyHh4iT/I+jPLhVXglZovwtUv+IrjAP6GRisBYA6pNL/KouqEGy5eKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293602; c=relaxed/simple;
	bh=beiMOx9JN9mTXY/11p4HJBlgCiuGdLfJC2HvswD4TIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HVqwBmZGt28VmgjpUMEn1wPSWtHkVG2RKJBQ2ZDnNE0anQ+KyIjLQxiDR01geUciKnvnsuFlTnrzx9kM4SyyJtwTKRw9SlhOS45Nz+dHMTGawmxUOHNmAg6VnoKfJvA8jIOCnrkB5s7TEEpuGKNJy/WW4WG3kLcsJWB/mAKAg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTWgaXEy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTWgaXEy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso5062484a91.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779293600; x=1779898400; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpAP6G554nCVcaMEflSSTOrRUtbrV9g7KrQDBDZQ+UE=;
        b=FTWgaXEycWXrPmVxWCUWeeRRpPdv6F1TLx5DNDb6/Mh3asT02JjDG/y1GjIqsV2Lgs
         QGsgbR0FgWajI+b54d9USo7ciDC9cL6vfGbc0RdrK9cfpt9C6PaBvLpyztZXkJvKMtTk
         FQWR57mxxBN3a/qERgZmJnZsEqXVnZEk2xBEw5tDctkawi3FPYH8wF69farRzKA396i+
         Kzorh72woqOwqWMN7gKFqB9isWbCAMuDMgno0FmdLq+xceDIzeFLhGYRh3azAzcv8IvD
         ZyU/qWAIlUFKisnaYJgt3dmOedZaLYuS24DDP8bMcw3h9ZlU3slerDrzzc/KvC/qfh33
         cmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293600; x=1779898400;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpAP6G554nCVcaMEflSSTOrRUtbrV9g7KrQDBDZQ+UE=;
        b=BH8vseoxon3hO5v0gJXGhlw7azPhCDbDCFqv2sxjhSHkgD/4tYGWG9KC7lSroeMsbj
         GMHZCjsswwgUTQ47+erJLqtlBWnM0x41lJNk7Y+2RPFZMnsxCRgbkzyex/1poU46QkZi
         fYllNT1bxKUxDyg1Cw+QmvBlwDRMrKI6cBy+UU+bObaq1OnCKzDHJY/nQc5fMFTzhg9F
         eXSuzFm+k6hF1v9uoGV8eM8IMSHtvkb6TMTnWO5+qcNvEeCazYVrLLJitzm9o51R16oY
         Si7uOfBMF4gur4VhjM8u95d0+GQI+rSVvPGjAMikwwDh49BeebIDeuJaJrx0eu+no3QD
         hN2g==
X-Forwarded-Encrypted: i=1; AFNElJ/8NoLVct19WoZPYQwYcYpwDHjCuiGaeuPywl/7pV+VU8nB1Iae2N2kf+5bLD4gbZACH8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuw4IOIxn9/ty4zc6AoVgEk6pwIs3x27olUxg6qmJu3kMdp9Yj
	xtOzYjmYddMbYOp6tUmK5o9UjkPLz37jczkSeCJbQ6cyPFnFiGlIN5ULvRLrjH2O3Ct/bTuE0zb
	33Gqznw==
X-Received: from pjbdj12.prod.google.com ([2002:a17:90a:d2cc:b0:366:7d99:c359])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:368:3d3e:efa6
 with SMTP id 98e67ed59e1d1-36951b9adcbmr23361135a91.20.1779293599639; Wed, 20
 May 2026 09:13:19 -0700 (PDT)
Date: Wed, 20 May 2026 09:13:19 -0700
In-Reply-To: <20260515222638.1949982-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com> <20260515222638.1949982-10-seanjc@google.com>
Message-ID: <ag3dny0O2WOnYonZ@google.com>
Subject: Re: [PATCH v3 09/10] KVM: selftests: Verify guest debug DR7.GD
 checking during instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Sean Christopherson wrote:
> @@ -202,6 +207,22 @@ int main(void)
>  			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
>  			    target_dr6);
>  
> +	/* test global disable in emulation */
> +	if (is_forced_emulation_enabled) {
> +		/* Skip the 3-bytes "mov dr0" */
> +		vcpu_skip_insn(vcpu, 3);
> +		vcpu_run(vcpu);
> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
> +			    run->debug.arch.exception == DB_VECTOR &&
> +			    run->debug.arch.pc == CAST_TO_RIP(fep_bd_start) &&
> +			    run->debug.arch.dr6 == target_dr6,
> +			    "DR7.GD: exit %d exception %d rip 0x%llx "
> +			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
> +			    run->exit_reason, run->debug.arch.exception,
> +			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,

Per Sashiko[*], this should print CAST_TO_RIP(fep_bd_start), not target_rip.  I'll
fixup when applying.

[*] https://sashiko.dev/#/patchset/20260515222638.1949982-1-seanjc%40google.com

> +			    target_dr6);
> +	}
> +
>  	/* Disable all debug controls, run to the end */
>  	memset(&debug, 0, sizeof(debug));
>  	vcpu_guest_debug_set(vcpu, &debug);
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
