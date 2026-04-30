Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435F44D696
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575625; cv=none; b=U+5Bx0qkNTTgTqji30iMkpIh6cNGN1ypK47mFtLa63wUeuCYKs7PJNWQdnTHh8+B1CfpEGZpjKUlMqiSi6VIGyu+p2usWyv8T26uaLyztRY0fUtFBjWYrhTk799g50WNEvejHAh4oSFXXkgmdh+1OUzGxRLVF+c/O8bRGzThJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575625; c=relaxed/simple;
	bh=CFU4G826UYWStCgEgr8XC4m1xQMl1MJQiG8mqJ3Eb4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kC7KqPvhzEGCw8OxAOau+TzHBESGTCUp+aoXHQFcsZ35wMCNioacn/ytoh3Mtt2Wf9uK6sP6xGF3V9kxU/kno/oVlIUgxGv3GRd4+Wk1gSP7xC3Lb3MANFXGwOow5TpdRwgOrF/3G8H4LMKUn8Di1sSwpGLIGZ1OfLQxnSVuYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KfH7nU0a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KfH7nU0a"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7c2ee830aso27791615ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777575623; x=1778180423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PKmgrZ4X5GUMmFyEBgr1tVZDOZG3a0A6/yqZK5v2kc=;
        b=KfH7nU0aD2beTiK1vP1vcYGF+GQDmm+BmEH68O0oOGqCp3iFKtkkHx0B2+stii6M6m
         U8atua0+RMnxbNOqZ5FKRtoKM/39tjB6OU1GRGcQTmzvX+3yn6iHgTFeBqhvPw6B7Nn6
         k4nYxTRnmNxaX6y8xAd8nuL5SXvudyzaIqp+H/7LYT96RIk+oY5r6BsGi2Iv2R53oHIY
         jySikzQjQOpHLjQw8qFG56BuF8kgGa7Y0qj8BbEeqEFLYfltwQQZcSwDKneYKkCz2HQy
         dEQFe111hG6R6oDIUjTdYigLSfk9yooVxh5k9d6MBcHzJwnVTooSbzz3dv1aHShgyMj8
         lEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777575623; x=1778180423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PKmgrZ4X5GUMmFyEBgr1tVZDOZG3a0A6/yqZK5v2kc=;
        b=LjxvYxbb69C323wMMsTk365lbFO2X+iJW950Sjgdf873uTRYla4907B8iY3G4Ca3Kg
         YhAA0nbm42Ob8ZsQwjykFHp2a2iyDuuFfWdh6WNGwBPgrxmERh72wCHIdOU3Clq1g+ol
         2NCG1bBeOh3udGvtcupWuhMUvsOJGgCYyNd5pTMRMavuXqUD4HiGh/prR/oK6uEugwWs
         u6XgPWoGqbU/iakDJNVnnJGMT/Agqntc/XjM6zHB/0HPquBYYUgk8+jOFfGlTQgCeZPi
         Dx14U0U7DA6iImBqSnG+IBMCvJCIBtIzy60603/WgINdgtsh9TqYtbS5SkkLWyPTjBJ/
         y8Iw==
X-Forwarded-Encrypted: i=1; AFNElJ9cji58q3OKrvLFVZa3ETFrUGyb1SalFh0jF1plLZu4da3+dZpv/N29n+XaxaamuRNLRfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHfXCOpPwdYlroF9RrgqDYjxu0S/uObKYsAGuUzUzRrDJ0lAa
	LZThP4a0qT+Kin+v4sCgRXoN/5FQ3kJ6V43MTnpgPEYBmt87w2bVkJ9lqxe52wNvWD1nR4LZbPO
	TyLC3eA==
X-Received: from plpn19.prod.google.com ([2002:a17:902:9693:b0:2b0:5659:d8f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d506:b0:2b4:656b:aeb0
 with SMTP id d9443c01a7336-2b9a250a817mr39262065ad.35.1777575622742; Thu, 30
 Apr 2026 12:00:22 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:00:21 -0700
In-Reply-To: <20260430150747.76749-16-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-16-pbonzini@redhat.com>
Message-ID: <afOmxZhdeBhIwq6_@google.com>
Subject: Re: [PATCH 15/28] KVM: VMX: enable use of MBEC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 337bbfecc021..72a75fa33c93 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -114,6 +114,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
>  static bool __read_mostly fasteoi = 1;
>  module_param(fasteoi, bool, 0444);
>  
> +bool __read_mostly enable_mbec = 1;
> +module_param_named(mbec, enable_mbec, bool, 0444);
> +

...

> @@ -7823,6 +7830,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>  	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
>  }
>  
> +bool vmx_tdp_has_smep(struct kvm *kvm)
> +{
> +	return enable_mbec;

Given that enable_mbec is made visible for nested.c anyways, I don't see any
reason to trampoline into vmx.c.  Ugh, never mind, because VMX needs to provide
a function for the ops hook when TDX support is disabled.

We could at least make vmx_tdp_has_smep() a static inline though.

> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d09abeac2b56..69cf276be88e 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -103,6 +103,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
>  int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
>  int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
>  u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> +bool vmx_tdp_has_smep(struct kvm *kvm);
>  
>  void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>  		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
> -- 
> 2.52.0
> 
> 
