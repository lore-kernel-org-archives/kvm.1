Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD834844C
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630104; cv=none; b=bonC/STanINcFxLpv7Ul7rP5DemWYjx9xldE/vkEOZNHofpI5frrQ/qTgZ9fAd5aih6pKVdZ0tS7EXRsuq8SQHtJsJHX0D6PfZIN6eDFggqZ1i5t9HGNozMugIno73QW3KJaeomM9mR+amEwKzwHOQ1GXhM/DVhjz9jsXzNRiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630104; c=relaxed/simple;
	bh=yqx0AjZGZxPl3saua6UZMZdAh5t6qb6IEwHXZrkryZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o66W27ub9SJkFcHNtDFQmjMfQ17PeQoZJPsZjiFdIc/0McFNTe5Sur2LI+JxhXlR8Zj53ysVMvDVolFkhUmp7vrvVK4sc6VXa3obr9z2gfWL84z8mm2F/kbqwvOah5cVlBiuxCF0YQVyHr0mQS0H3Qwhq/WgngknWS/lLTJ8XQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3eziE3F; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3eziE3F"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso147735675ad.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778630102; x=1779234902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idjjIV85cN5FoIWvSVQA+tFF64SQCfddrgXmCpwuKDI=;
        b=H3eziE3FvN93zU4f8ipd7EEen7iwYZK6E9lLeQcXHYcooMCufTuL9IW7C3DTtUkw+m
         z62/noS/4n9ZJ7O7YYhJOXs2E/aNl+FWqEBcb0Mv2g89Mhtlpze+yyFIDXfsegHoZ9OM
         TFGUZyo+5a4YPVUhDVn1V83RZZSjKwk5EIV5gsOsZkNUBNUijmDjG6dYtL0oqpypdCMI
         01IFxI9PsuxbnPt4IP8eIdkiuiUESxcqme4gPXR3ELDYXTtgnoPrGdf4EypuVafSRb0/
         bxziZb6iy+MpFUdCimjxx5dQa2WskF5MONkJyt9o/JZLrm0hqT2L78QbXKleStn/kbCA
         yCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778630102; x=1779234902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idjjIV85cN5FoIWvSVQA+tFF64SQCfddrgXmCpwuKDI=;
        b=gS08WppOBZx20SYxGQZD6m6yvHMF4x5rz7LyhvHQfGjOP4GuH4AkMLJd3L5wqFPcre
         E3A2dso/ZoK8nnyKP3bBWW3Z2AYg0dGy57LvirsEOpsRwmSJiqZjlph8nzt2SYqOO2ac
         Qoj7l34v2YYVN//16WOj8HvozOkqqWktOn5wXAS1eQTJDvInTnxaRQ0B2aqbGZYKHref
         EJbuicekd8Jxwk6BHYry80CbRnqKBjUps/2NNPP/7GwshQYSg1lfUmPDR6gw8McSq00w
         FONJWt4h33jdtrJL0SEnGh8wEgbTXS5iawvYsnfUa1OGwRoW/+5buJBMQQHg35mSJnGl
         A/2A==
X-Forwarded-Encrypted: i=1; AFNElJ/yZ7ZDVcUXPzrXsKxgtkJjXdz05LVhaJ8kXPOYUGC4p50ZrTSE+rFxyVFB50aX9Ac1x6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOM2FVn83CxiyH0ICOOOBMSBJ7cWnh9yX2N1ScNzZIM75ADvA7
	nuCXf7CtRQ7sBtfwlqP2pCiGbhwdCZ3CWe4XyWqTeS+svSmjhq2zNObzRvEukMOrIcl+BUnzZtn
	SoXjI3g==
X-Received: from plyd17.prod.google.com ([2002:a17:902:cb91:b0:2bc:f38f:2ca3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea09:b0:2ba:df8c:11d3
 with SMTP id d9443c01a7336-2bd303365bbmr3551705ad.32.1778630102393; Tue, 12
 May 2026 16:55:02 -0700 (PDT)
Date: Tue, 12 May 2026 16:55:01 -0700
In-Reply-To: <20260512150016.2979228-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512150016.2979228-1-pbonzini@redhat.com>
Message-ID: <agO91crdKElYuh1M@google.com>
Subject: Re: [PATCH] KVM: VMX: introduce module parameter to disable CET
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	David Riley <d.riley@proxmox.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Paolo Bonzini wrote:
> There have been reports of host hangs caused by CET virtualization.
> Until these are analyzed further, introduce a module parameter that
> makes it possible to easily disable it.
> 
> Link: https://lore.kernel.org/all/85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com/
> Cc: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/capabilities.h |  1 +
>  arch/x86/kvm/vmx/vmcs12.c       |  2 +-
>  arch/x86/kvm/vmx/vmx.c          | 17 +++++++++++++++--
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 56cacc06225e..31568274d8bb 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -14,6 +14,7 @@ extern bool __read_mostly flexpriority_enabled;
>  extern bool __read_mostly enable_ept;
>  extern bool __read_mostly enable_unrestricted_guest;
>  extern bool __read_mostly enable_ept_ad_bits;
> +extern bool __read_mostly enable_cet;
>  extern bool __read_mostly enable_pml;
>  extern int __read_mostly pt_mode;
>  
> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 1ebe67c384ad..9f96e21dc1b9 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -202,7 +202,7 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
>  	case HOST_S_CET:
>  	case HOST_SSP:
>  	case HOST_INTR_SSP_TABLE:
> -		return cpu_has_load_cet_ctrl();
> +		return enable_cet;

As implemented, cpu_has_vmcs12_field() checks raw CPU support, not what KVM is
using.  E.g. EPT_POINTER checks cpu_has_vmx_ept(), not enable_ept.  Whether or
not that's ideal/desirable, dunno.  But I think we should at least be consistent.

An alternative approach would be to squash the controls themselves.  Though again,
I'd probably only want to do that if we plan on taking that approach for all such
module params.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c2c33a5f7dc..d4afc4bf6279 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2818,6 +2818,11 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
                                &_vmentry_control))
                return -EIO;
 
+       if (!enable_cet) {
+               _vmentry_control &= ~VM_ENTRY_LOAD_CET_STATE;
+               _vmexit_control &= ~VM_EXIT_LOAD_CET_STATE;
+       }
+
        if (vmx_check_entry_exit_pairs(vmcs_entry_exit_pairs,
                                       _vmentry_control, _vmexit_control))
                return -EIO;
