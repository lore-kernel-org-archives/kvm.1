Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65E175A9C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928008; cv=none; b=pMrXqeiPKhEx80QRte2hskwtaXR1EBh3jxsQgHy4datxh0fTU7rLnp7bEId1I8S5cTvbAk9750oQCHixJs4F3gN5SMGfQlx4WCaI6CHZwg93SD/28GsNENuaEso65OWsNGFzbHAPsM/KFMhmpYfQAF1mmBgAo/pKRndVA5jm5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928008; c=relaxed/simple;
	bh=N6OL9PB0DsnhRdJS5hSyym+D6GQbTxXhGNe9PNzoWdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlYosmR2QiPxbTH7aPihTMRrjDXFHD+hhsUhGcZMjcmfyPs3MjVbSkhDxh5EQZQj5G6YIcermoDid0rmGjrWzJZ7hGD7CDV3sNSG4y0W/BXCrzaOH1MrAirDWDzdZ5SYu9EDdBL/ErvBobpMje+VGnVKHTGKk+6BtI+lcPkqEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLhhkIDs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLhhkIDs"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so12102687b3a.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779928006; x=1780532806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiZ2RYDB/Ckd9/P01Fk/JVwWBySF/YgM3g9c463Ds+Q=;
        b=kLhhkIDsqj5TCx4GfepGJd7SKxyeJVpnlunnNbF6Woo4o+w/ZxGSksSpuT3qjhonXh
         KOwxvXV/Y8NZa2bbTq92g3vePGEFHsNIeihE2+0g2eRi20bDiMsZPbfgzi6Vu6dC90vB
         Q0ypD/AxhQ5J3h1PBYd+7KSF3thg99RmaDFNMpoJ4sJiyymXyTRUMNwOez08kNFr6VBq
         aKDyecZpAwdbp4x8Ir/TPTE4/vMZ4qXo2BdDuEMsoOC4+dQagoaprhoEXiIJRMLP1HFI
         NRDHoHivdKTu9YHkPslBIMwL8HIg5UrS6lFO3o1j1ew0zrkA/vH1+8XsPy9F1YcBmqIa
         Ln7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779928006; x=1780532806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiZ2RYDB/Ckd9/P01Fk/JVwWBySF/YgM3g9c463Ds+Q=;
        b=dQfPmWWHpUcKboXm1kLngQ8+SoGKNsF8t3v8zqtExrTo3QvlrCgMuHvtig9PddZeeU
         jsNAY/aeSqumEMTWgtJ20VxvoSwf8jqIYk7+l1WvFy89WaE9r6ZHR9/ECCWSnoYB3x6M
         cvLPAXCFTYhtYpbca8wceB6Tyhce2Plv9Cble7bW7Cu0C+2g7M3YTFyyAsTna5bp5jHh
         kj+P2tLXQVGw+W/tRAQFKDrURSormaw3gKt9Dv5i13MBN+fpx8CHHEAiCnbnVpdr7DIb
         IIQTpjhIRg/monZ2hpiQ93dRK4ItzcIqNQ6xrNwHiCoEPECU4NRSuGg/16NjJhHWZa90
         kP+g==
X-Forwarded-Encrypted: i=1; AFNElJ8GGu2sKjhRdu07TkZuj6D49Wg+Z1Mqr3n2efh2G31if9fJbDr9gcYDj3lZL/IIe54xvyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBMcR/g+PSN13GnbgAgNFExZpq56teMT7VpZ04WyinvQku3m3
	CaBX8+39F3Xla1G6bTHpy4hCjBTqUA68KDydfeSyiRmChRx2pzmOF+t5J1HWDmDyU038DR5Wk8i
	+dU+T2g==
X-Received: from pfks22.prod.google.com ([2002:a05:6a00:1956:b0:83f:22c:66ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bc8a:b0:82f:39df:dd54
 with SMTP id d2e1a72fcca58-8414b40f5c6mr22119779b3a.8.1779928005835; Wed, 27
 May 2026 17:26:45 -0700 (PDT)
Date: Wed, 27 May 2026 17:26:45 -0700
In-Reply-To: <20260513124846.1622462-2-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513124846.1622462-1-ewandevelop@gmail.com> <20260513124846.1622462-2-ewandevelop@gmail.com>
Message-ID: <aheLxW0meHNVhDvc@google.com>
Subject: Re: [PATCH v1 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai <ewandevelop@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cobechen@zhaoxin.com, 
	tonywwang@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 13, 2026, Ewan Hai wrote:
> Advertise the Zhaoxin SM2 instruction support to guests via CPUID
> 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
> 
> The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
> elliptic-curve public-key cryptography algorithm specified in
> GM/T 0003-2012; the hardware-level behavior is documented in the
> Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
> instruction multiplexes its sub-functions on the RDX[5:0] control
> word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
> signature verification (1.4), the three key-exchange sub-operations
> of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
> uses for the initiator's ephemeral key; 1.5.2 responder shared-key
> derivation; 1.5.3 initiator shared-key derivation), and two
> preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
> 
> The instruction is user-mode and available in all CPU modes, with no
> associated MSR control. The SM2 and SM2_EN bits are redundant by
> hardware design (set or cleared together) and both serve purely as
> CPUID-level feature-presence reporting flags requiring no KVM
> emulation. Both bits are advertised because different software may
> probe either one when checking for SM2 availability.
> 
> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> ---
>  arch/x86/kvm/cpuid.c         | 2 ++
>  arch/x86/kvm/reverse_cpuid.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..1eb4b88aaa80 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
>  
>  	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
> +		F(SM2),
> +		F(SM2_EN),
>  		F(XSTORE),
>  		F(XSTORE_EN),
>  		F(XCRYPT),
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 657f5f743ed9..7b55110cc046 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -76,6 +76,10 @@
>  #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
>  #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
>  
> +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
> +#define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
> +#define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)

Oh, just define the X86_FEATURE_xx flags in arch/x86/include/asm/cpufeatures.h,
all of word 5 is carved out for the leaf.

Features are defined arch/x86/kvm/reverse_cpuid.h (versus cpufeatures.h) only
when the feature is "scattered" (not guaranteed to be at its architectural bit
position) in cpufeatures.h, or is not defined at all (because the kernel doesn't
use or care about the feature.

The changelogs all look great!

