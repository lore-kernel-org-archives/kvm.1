Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E24221FBB
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238521; cv=none; b=R7yFzjqKsunUEiZjhONA0MAtoeupfDEqgTHblLF2D3iQhR8UW03kJQ59qwLNnsOvme6fwxtm0+Oy335daRmx1zBequqfLorpmX3zsHT7XRPPLTLrHwbMWOQ0cqXRkUj//WcLQfLhZcmQV0XMs/5Wvxy2W95qyDXXQ3fDsz7aqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238521; c=relaxed/simple;
	bh=IRdQHaIGsdSoCBH5B0OHZNEfWZFitkLqXLSqpnGZeHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pid497qNM5TTw4kFdVWQQWqCpLu/4LHudkzEmgyb8DaOk9ctTlXhlHxnN7qz5pBIHx4fFFYKTZpNeUGpSEd3LeC3rSgQlX3/dowpyhfioYfZ+xdFnuVVVD5XAcvuAEbbWxFTBl57OfA+R3nuyNkW8mbhckvtJDXSLx6vSXBH2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev4VRRYh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev4VRRYh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4e9577ceso537537485ad.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773238519; x=1773843319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=32AGf21pa1XHN25iothH4Nfw6LkakhGMZaNhl2RKfBU=;
        b=ev4VRRYhkZzIDLNax75a+B8fBhPvOzF+Q1/cgsoDVYW7C2YNI6ZxkfMh11kOWNR84x
         wMTPf99q87GEilu7QpkRx4RaTfxOpm/t7NliXJyqtz2vjzO8LIIgbJmA34TbCykOoGpu
         pa96jPEfc7Oe3xoRUAydcEiOqGvNY9noHjtN9qaYpA1Uc+AT+oa5V9NpRA34NsoTSGI2
         gB5osbDZnpNy7QkHELV54EHR4UzrzgZ2c6N51I3k6LVB+8lIdncjaT3vpBgqdUMo5FmK
         qKomXI5VldOkTLKw6M1BlvLaXpvuKufIeEd9NtPCkcsWtbN3N7F47FfGER2jvmGiOxbI
         vFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238520; x=1773843320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32AGf21pa1XHN25iothH4Nfw6LkakhGMZaNhl2RKfBU=;
        b=Di2Do8Hggqkr5J15URausXdyoWkiT6y72lI7+jCm29E/pzd48+0k9efYh5koREJUYm
         YWZnYHn/P6CjcFFbyKmFdKyULri7OykyechWPiuvpPGl07obUGsPzFOcxTHIypVp03ZS
         eLyV7JYLbEJ3C9pzcqB69uYdIXben8gNSBK4FEErer2zgcAL0vZ4/3vX87PM/zW7HkpF
         XkwquF5s2MMApwIZv30+cr/JnIrPaL+Y/2kGQG3l1gVJ5vUTjSYHj2zcwsbHKS0ctE96
         ctGpX7ckLEUG9jBFnDiZyw0sxPA4OUOQrZsVd7d4Ct99lkBLH26CA4sToTJ06i2qfO3A
         KDbw==
X-Forwarded-Encrypted: i=1; AJvYcCVLv4gDN8MhCSH/4EMeCtdyiVO9nB99+QVyHKPebVoJEwjQ2BKfOLjHdNKBzp+NrC0PNOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaMqKFGBc/6SP+8ILC8ALhMgW+TcXv5LczYGptmNHmmXKwxce
	c7ShYxTMSCEpHrSKi6WXhJZ0iE5knJ2y1vAQeBO7+vyMBqLbBKihWNAqsiCLfWffZ7dC/HMTT+L
	GUfG6hQ==
X-Received: from plbld3.prod.google.com ([2002:a17:902:fac3:b0:2ae:4b5c:a2a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a86:b0:2ae:7fbd:3dcd
 with SMTP id d9443c01a7336-2aeae8ffae8mr30306955ad.52.1773238519493; Wed, 11
 Mar 2026 07:15:19 -0700 (PDT)
Date: Wed, 11 Mar 2026 07:15:18 -0700
In-Reply-To: <20260311130611.2201214-4-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311130611.2201214-1-kim.phillips@amd.com> <20260311130611.2201214-4-kim.phillips@amd.com>
Message-ID: <abF49hzCdFsMNJNs@google.com>
Subject: Re: [PATCH v2 3/3] KVM: SEV: Add support for SNP BTB Isolation
From: Sean Christopherson <seanjc@google.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Kim Phillips wrote:
> This feature ensures SNP guest Branch Target Buffers (BTBs) are not
> affected by context outside that guest.  CPU hardware tracks each
> guest's BTB entries and can flush the BTB if it has been determined
> to be contaminated with any prediction information originating outside
> the particular guest's context.
> 
> To mitigate possible performance penalties incurred by these flushes,
> it is recommended that the hypervisor run with SPEC_CTRL[IBRS] set.
> Note that using Automatic IBRS is not an equivalent option here, since
> it behaves differently when SEV-SNP is active.  See commit acaa4b5c4c85
> ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> for more details.
> 
> Indicate support for BTB Isolation in sev_supported_vmsa_features,
> bit 7.

This isn't very useful for the changelog.  I can read the patch quite easily.

What would be useful is a description of the change in conversational language,
and an explanation of why it is the correct change.  E.g. (not really, but you
get the idea)

  Advertise support for BTB Ioslation via SEV_VMSA_FEATURES when SNP is
  enabled, as all hardware that supports SNP also support BTB Isolation.
  BTB Isolation is an optional feature that can be enabled by the guest to
  sprinkle fairy dust on the CPU to completely prevent all speculative
  execution attacks.

> SNP-active guests can enable (BTB) Isolation through SEV_Status
> bit 9 (SNPBTBIsolation).

That's not what the doc says:

  SNP-active guests may choose to enable the Branch Target Buffer Isolation
  mode through SEV_FEATURES bit 7 (BTBIsolation).

> For more info,> refer to page 615, Section 15.36.17 "Side-Channel
> Protection", AMD64 Architecture Programmer's Manual Volume 2: System
> Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).
> 
> Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
> v2: No changes
> v1: https://lore.kernel.org/kvm/20260224180157.725159-4-kim.phillips@amd.com/
> 
>  arch/x86/include/asm/svm.h | 1 +
>  arch/x86/kvm/svm/sev.c     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index edde36097ddc..2038461c1316 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -305,6 +305,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
>  #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
>  #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
>  #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
> +#define SVM_SEV_FEAT_BTB_ISOLATION			BIT(7)
>  #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
>  
>  #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3f9c1aa39a0a..ac29cf47dd08 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3167,6 +3167,9 @@ void __init sev_hardware_setup(void)
>  
>  	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
> +
> +	if (sev_snp_enabled)

If BTB_ISOLATION is actually supported on *all* SNP hardware, then that needs to
be called out.  Please also separate this from the core kernel changes, unless
there is some dependency on them.  And if there _is_ a dependency, call that out.

Ugh, I'm getting deja vu.  I suspect I had a long response typed out for v1 of
this patch, and rebooted my system before actually sending it.

Oh wait, no, you just made the same mistakes in two different patches.  Please
revist https://lore.kernel.org/all/aaWog_UjW-M3412C@google.com.

In general, spamming patches without internalizing the feedback makes for grumpy
maintainers.
