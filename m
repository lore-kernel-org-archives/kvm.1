Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA2366561
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337760; cv=none; b=mAVS0ZJf5ugtTdje8BXqTMclvONyoJJvlulHv+Erry2bp6SWQXE0pYAG6q5uB05XLvbtqcyis1MTi+EMOYUPE1YtshNesyoSK8A1VGoBCSt0veuNWR4TD90Zfk6WgrEseVb98x1fi51zduyzrFn/RME5fin+tNjiuQh9jaqdtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337760; c=relaxed/simple;
	bh=xpP8GEaWsx0WZR2bBt+NsJMr6G978MTpJRXnplvOTMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8tsFKdktpR8oFGqgPv8RyqYqrSj+zlcpERYNbi5C8gNGMjwKPOzUvvomYjrNWeevo2bruFpCxjT824zXKaYmi30rHYNRZnvSLY23lh9kFde2jDxqG1aBS1SnOydE3pltNgUdyzDyvSC5aYrGGO6pEV0d2cPoBG3h6obxUOLq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHa/w4XT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHa/w4XT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae47b3adacso13025155ad.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773337758; x=1773942558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp2dppEjJ5UkRzLym3Z+pF4WitJgemauS6UzqyQhU6E=;
        b=VHa/w4XT+618RPE7+wEulZTlqOK6tQ65nAZMj/qSLtxy8pZkna4T9oHHTeivu/LCtB
         rxCehg0ekH4wMb2ZTzC3cxGp0qKLRnMMtLLAai+WHgdb2KuNb6mvUplovsWMgS84DGuc
         YgYGVHIgJqS5jrN5BUvb1XyEeKCkZkiMiMi7oDokbRBbH17drHC6yjudlzcR6L/A+juS
         aIgNRxgXcnXF8LJImluuiS1xFYy9k1V6FlkP1AaA1Mrfxy50abPL5mIjyqdovlZ2sleG
         66fMU1OVSeuPeBxOYdkMOceVypq27Il8F5vP/stc9gd3vh7/vMcZKf3gvQcs6P2RIT3L
         hHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773337758; x=1773942558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp2dppEjJ5UkRzLym3Z+pF4WitJgemauS6UzqyQhU6E=;
        b=O9S7bK0+balSjE+hLj4wq7Cx3QJVIXtgFKrMPy+vPzdERStbK7VshKyn/a/4zHl8xc
         LoZ5p6BwMzlC8Jujz2VpdtSL5ND4nSktoWpEULRCwOgP9FoTyBNddZwTyYGC0JPqjyUj
         L/k9CixoJ9RCccRxnjvtj98O1Z88vsy2MWqSNg0pL/zSQVOcDkFHbEAguFKPbKBcp7YC
         8q4U8bLq2vdOU1r7gFqOnSrvDdKf4ozfFxdQTEFT2Vq9HEt51i/SGCiZGc2jdnPhOqK+
         d7ci7wKf3dsyfTBHujVtQ+OllL59wBeCgsPJQzlD+DYDcB6pwk5q01dGWB25YhZhX/5M
         0tgg==
X-Gm-Message-State: AOJu0YxuxUPvo8WpYZ/Bc0ONXGSEpbZwHdsFRST0SAMN5bkmaudJA1hv
	K4naMclJoqouun1HP8e7SBxmP+mes+0XLQ/6lvAh8DmSzuRSZtneVfGumA440bzMVtF2wvwdLZ9
	tGd5GWg==
X-Received: from plxx2.prod.google.com ([2002:a17:902:e042:b0:2ae:5fe0:d464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac7:b0:2ae:50ec:fa34
 with SMTP id d9443c01a7336-2aecac93676mr2940935ad.46.1773337758105; Thu, 12
 Mar 2026 10:49:18 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:49:16 -0700
In-Reply-To: <47e4570a1db6f68eacdde989c6cf4f53175cea75.1773193126.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <47e4570a1db6f68eacdde989c6cf4f53175cea75.1773193126.git.isaku.yamahata@intel.com>
Message-ID: <abL8nHNYkUCcS73O@google.com>
Subject: Re: [PATCH] KVM: VMX: Eliminate warnings by sparse in vmcs12.c and hyperv_evmcs.c
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Make ROL16() explicitly mask instead of the truncation by u16 cast.
> Sparse complains as follows for vmcs12.c and hyperv_evmcs.c.
>   > vmcs12.c:17:9: warning: cast truncates bits from constant value
>   > (20002 becomes 2)
> 
> It is because ROL16(val, n) includes "(u16)(val) << (n)" whose type is int,
> not u16, due to integer promotion even with a u16 cast.  The outermost u16
> cast in ROL16() may truncate it.  Explicitly mask it to avoid truncation by
> the u16 cast.

Honestly, I'm inclined to ignore sparse.  The code is correct as-is, and adding
the GENMASK just makes it less readable IMO.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603061942.wdSsERnL-lkp@intel.com/
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/vmx/vmcs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
> index 1f16ddeae9cb..b5b5f4870655 100644
> --- a/arch/x86/kvm/vmx/vmcs.h
> +++ b/arch/x86/kvm/vmx/vmcs.h
> @@ -18,7 +18,8 @@
>   * wasting too much memory, while the "algorithm" is fast enough to be used to
>   * lookup vmcs12 fields on-demand, e.g. for emulation.
>   */
> -#define ROL16(val, n) ((u16)(((u16)(val) << (n)) | ((u16)(val) >> (16 - (n)))))
> +#define ROL16(val, n) ((u16)((((u16)(val) << (n)) & GENMASK_U16(15, 0)) | \
> +			     ((u16)(val) >> (16 - (n)))))
>  #define VMCS12_IDX_TO_ENC(idx) ROL16(idx, 10)
>  #define ENC_TO_VMCS12_IDX(enc) ROL16(enc, 6)
>  
> 
> base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
> -- 
> 2.45.2
> 
