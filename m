Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8102C15BB;
	Sat, 30 May 2026 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102766; cv=none; b=XPZe6IHYW0d/IB8u1dOlis5vYm5TJlTbZ51rf3SzHOiC9qAl0Ir3QPN3hFV7O8r1l2dGcUPfxpErNlhuW8qtjiojQdoy0OvDlCy6yFHgDV/mF5K+U5R3ozoB0/wkwhyGMIzwBPDXFg/gij2mL2dF8mK2jMYGONOYgJimwbLAIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102766; c=relaxed/simple;
	bh=YPy708/X7hj3RrCMwO6C9dDS1QD1sTA8xEQoPlqM0GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUoU+4lPURKIrRqfje2jCgJpAUwTb0+Pp9htH6FqzIqeOhzlNki+5E5HZ0izjRv9osWclc+xCA1BMmTDBhrZpv0jAOBnY7YEMT6rNFLRFT7QntoZ2+XgNoSgiICVreXirBum7cHcI7cT52fM2YNJ5q7ZB41aTfpnIno2wXVD2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU3rc3Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU3rc3Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863481F00893;
	Sat, 30 May 2026 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102764;
	bh=WokpCvYvWhklmoz0SkNuRhf+MNklg/Cp+O3G43EyWz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OU3rc3Y5C2m9URPo4/WLbpZ22/xCpVrAj0PbLnD5vHhDxJTsldWDyQvAsFrePAH8s
	 wuqnDa2edxHFsr8+tpc3LMsPupAHRmD4LZvAfLDoGBiNnKRIRI49SPWdhJe6hJSHTW
	 0+KJvqbCW74Evk9YhJhyZZvW9ZFrb4NeEdNPx//w0BHeD/9bgzDdTckHBBfUzCGOBL
	 UwKklGnIGcjv9cW4aWbPmVNpHe8XmTTXtWjDiviBrsd72KZeD+5TCQVJYfJtex9G0p
	 g/lnjVgepseJioy72nwjNdPhYXIfT4rkkbgMQLFriY6MMwzmF9wVt1/CEC6ilbBNZg
	 jQo9kgpw7Ydaw==
Date: Sat, 30 May 2026 00:59:23 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
Message-ID: <aho2Pcc5p-HUUKji@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-31-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-31-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:13PM -0700, Sean Christopherson wrote:
> Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
> x86's kvm_host.h to msrs, to continue trimming down kvm_host.h.
> 
> Deliberately leave the funky read_msr() where it is, as it will hopefully
> be removed entirely as part of a broader kernel-API cleanup.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 26 -------------------------
>  arch/x86/kvm/msrs.h             | 34 ++++++++++++++++++++++++++++++---
>  2 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a861c0d70be0..1143140592df 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2094,7 +2094,6 @@ struct kvm_arch_async_pf {
>  	u64 error_code;
>  };
>  
> -extern u32 __read_mostly kvm_nr_uret_msrs;
>  extern bool __read_mostly allow_smaller_maxphyaddr;
>  extern bool __read_mostly enable_apicv;
>  extern bool __read_mostly enable_ipiv;
> @@ -2278,18 +2277,6 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
>  void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
>  void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
>  
> -void kvm_enable_efer_bits(u64);
> -bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);

Patch 15's changelog makes me thing EFER will belong to regs.[hc] not
msrs.[hc]. Did you change your mind?
