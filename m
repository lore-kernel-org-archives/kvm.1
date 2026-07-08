Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C92DF719
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550810; cv=pass; b=QQfezdB0trFlup3itYwR1SR5QrZ1Oizy5cM1eHEAzamiwhcyK+It5ShQN946HycnttT3qzCcAft1V+q6zIfONLMZ9FEznneCA6JlNxoLisXuAgfc4MB9ELW2EM8Sw+RaNGBVSHnqYAVH998Qprz+/DoVV3nJyI2HTk7xEUdcXBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550810; c=relaxed/simple;
	bh=jJ9U2GoI5SR8Cw2AlMCKkMuXsx3l4CN37Br9EgqXpyQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFzDhCNDjc0CrK23LBA3ahkcISdKEeri2h0tGY7bN5smbPbisOkE+aOV2mddG7qpHdQKGJ3+zZeIPBb8f/qhv5mncCn1oUgDGqsRA81+KfhG6P2d8dQcM2UbfGMjB0m2C42CJteHnipqMc3vWo1MSPcE1g2de3y6no2yfGk28nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvQe6t0O; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvQe6t0O"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88cc025f54so181379a12.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 15:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783550809; cv=none;
        d=google.com; s=arc-20260327;
        b=qS0dWkHS9vtZHTuc65nDaNCph9FShmHRzAp/fof9Qmay41D6HDTKem8VTwdvBw+kuP
         5+EKoX16TDmSnPSbh3urryoegzplwH4oiLuFG0d8PBWisf4wnIXKWK5XvcuExrsHUUYr
         dmp/VsfeSQ9kgsGpXt6PdSOgIsl9Ylt8L/GHpsyrzyryQN4ZNAv99OVFbQhPtvnN3HEu
         6xYmQZuiSRCne9416NhQBpblpQfV9fiM6NEaM3H86xXGkev8e21hE/yhGX0pz3zurxgW
         HkRIozhRk4SQ1UxsNtK7KMi3BrgT6AWCKSj/ghVNuW62brCH4KZvm8+JHLJZWGmyVIza
         mbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CacpuI+dCOekV9AAI15TarlBf5aqwFeqoZSIFdDlTHQ=;
        fh=SH9t9TFPeQ8bPdsk3rquMb8Ls+3hlsbagh6aBc008A0=;
        b=W2vSZSX74HvPceIe/BglQgaRqTFjoMHu9kbHFXDwCdQbo152uA9iwR9dG8vFebXJY+
         DxxWa2BkAM9cL1aGj7i11vaxNI+4lgW/zt8jPEnReSmlNE6etw+Ztxq/+sqqZdvQio+6
         F5RSpRSBbmjJs6VJ/zcXPg5To44kkhFQBjSHRMDxGXeUysLgeQG30fU/4s2K67TE92ZI
         dubkQIMzyhkFa33GJs4FDGP5ZbyY0oG1NEU8zXWtQDBYHx6OeikYUWjFlqx6toBvyBGM
         5qgD6ygig0zZfemHKnNjwtN4kFj+i4PaSg5E4ruDyQOvIoLpCs+c+DO90VNI17cDrdDa
         hpjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783550809; x=1784155609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CacpuI+dCOekV9AAI15TarlBf5aqwFeqoZSIFdDlTHQ=;
        b=mvQe6t0OlNPbxDtGI6VmxAlg4oPThLxb341BaxcQ65bkCmLF/avJqruR71zP7rdo+3
         L27i8TnITq4y0ciy9YXrdt5xndlvxNSfyIwhWx+WCFnpd4FLoeqFoEDEjh+wf0xUa4ew
         zTw/cAriPgCrMEHAz0L1BkG4C9niywAhqK+yW9sy5ZYvmHjWOZU8yq5qguwyx1scdHyt
         LANc7r8leVqQEytYtiTO4NB7u/k0+fn4qRAZBO/tD2E5+NrGx3NaZ+Ad4TRMXhJMK7Ex
         6v4Wo8k+jkXwb+ZiIlo3F6lwgLekBye6XBny6OTtVDIzl0kdzRcV3TVq7Aw+Tz5AXx3K
         Yklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783550809; x=1784155609;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CacpuI+dCOekV9AAI15TarlBf5aqwFeqoZSIFdDlTHQ=;
        b=ccr9nHeCMsp/9zzrIiKXD75iHSZKFT3yzzPI1dvHD/eBn11Bb1YWuq27LCFFCQ3vwO
         IH9kOLnyMoNxyGNZAv4Ze5DFwnfTt9u2o8kyxgWiDI6SpbAJSZoZmUvBSDw2rvhxlwtf
         LTZ5e0eD9+3FsVTegf806DP3LeJUGRYsgXgs+k5JK3MADQeg22PNVVn7ZawL9Z0GeUTx
         9CXZ+o6nKCAQ5w100wUfGGxOWq5gNu0XqbvHuvLKtcR2aWinOrAN2rReWT5Xuo+WSJVP
         Onn/aAzy2+fHGeXF9lnLF0yRquzkg7nzTS7hcr4am57rQcjN8VgbKBWfdMNSYVMpvLCJ
         sxdw==
X-Gm-Message-State: AOJu0Ywqo3IkI2gM6U2ONsKKUq3s0H4o/MloLAfmqq8Ti0I7S87oInrN
	7ndWZjDInh3Bbey7E+M0gygM3OurkX/+whpgB/K58oiFq9TpxDGhl4Z2Uw1O5LFY3tlgBJ2ZVcd
	J6x3tgpAt2mga6pt0TR2TGh/eh1rZYI0ip555RrzS
X-Gm-Gg: AfdE7cmT3XNCAffT4kuAhBqFV2PHklO1dWECITWkGeYmBAzXeKyFuUS0UzXzQbrr7Wz
	3f35ZIN4RiT7ADkfMsA57qxj/sGs0FVIwxmSdhZS65aZxBHEg20wJGS1iwVyOASAJPPhLovkfo5
	R9L5MdyRjdjm86XODMGCmype2P0lG8h3qJOGNRlKcYsilDTS8jJpj+BD815hfisyMVjFRsc5H66
	/8C8CZWI8MBtAFqqakJUC8yPBgGHUM0DghKtwb+tXZFWPtuKsussVAdaPF/YKf0dM4Ut7Kk7yxG
	a686Orn6uUi/WRAGa0hkQ3RttGacTbIyyNAVni7F3HhI7yNTtvWvJ8H1P2M=
X-Received: by 2002:a05:6a20:d493:b0:3bf:7110:9949 with SMTP id
 adf61e73a8af0-3c0bcbe9106mr5539597637.6.1783550808476; Wed, 08 Jul 2026
 15:46:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:46:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:46:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260630222607.497895-12-seanjc@google.com>
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 15:46:47 -0700
X-Gm-Features: AVVi8Cc5lmCWkbrTZoYI9_Qr1jniRGz8uPvrxrzWFz94PPBeefEzw9aQwh6BJzc
Message-ID: <CAEvNRgGy7WVt29PohktWTmAquiTbcMntqWHokAXfP1Y-+rEY9A@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] KVM: x86: Guard .gmem_prepare() declarations
 with HAVE_KVM_GMEM_PREPARE=y
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
> non-SEV code doesn't try to wire up a callback without doing the necessary
> enabling.
>
> No functional change intended.
>
> Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h    | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index deb3ded5796e..39247d2f29d6 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,12 +146,14 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> -KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
>  KVM_X86_OP_OPTIONAL(gmem_reclaim_memory)
>  #endif
> +KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
>  #endif
>
>  #undef KVM_X86_OP
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 93af3bb82869..cf2ec19212ad 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1903,7 +1903,9 @@ struct kvm_x86_ops {
>
>  	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
> --
> 2.55.0.rc0.799.gd6f94ed593-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
