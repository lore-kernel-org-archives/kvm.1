Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A843F54A5
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160215; cv=none; b=N3nsgodDQJwquTnb2f+ZF27bLc/cGt1YLY+6bTqsPmbNUHUiJFY+R1SFLyANB48OPWA1nIpiG38N0++tSKtl5StBRPH6tVGaxgpXNacexJzBz4Vfbrsbdn3odxv2NoX659mDddStY1ZX1c6qaixBO/YdUcp3TBrZ8t1rC0Ca0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160215; c=relaxed/simple;
	bh=QSvNn7mVCoqpDWRpLEwzsQYXhphwXaDFMVb19cMkdys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jn5MmPdrQwzqby93gLlvLyJ5CDNUH22cmNzJWuNacXTt8Rot7wdJfGB+b6XbNESWhykBShK5WiLnddBD3tcd2T0r2y4jG/jGdWeXOrslUW3uHQlrpmhAEDzdc3Np20Hn8O4h8cxfkvw5DgnRFYhGlBlSF0TI9eU1SOZHXEd9ICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRrp8JNh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRrp8JNh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba838c5ff1so19030645ad.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778160211; x=1778765011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2p7v66esSqoBYICxVl1Y8jghKc3MBnhyUfxMzYF7Ws=;
        b=hRrp8JNh8g4bUYn3uiR2GvW1Qgu9c8d+uvk+Nmlxyie9df+nhitsnX81tj//GMO2dz
         ayG6jpp8/o9tafl8bTrDaQidZrjwqPO2PICII5JezUbNy2lXWt3Dnmksns6lfEM4XW4J
         uX3qFRiCuCPZg0qUBsS1mdlbQ0NtglZOm2NTFFXQETD68YmCKZtTf8+f/j6sghVLmQmh
         RLcXBmEz1YtgIKdMGpbcmEynzvVpYaLGHOYWugi4lqz1LWdtC4TqszS/q5k9/9d4mubx
         qt8Mw845D6JPStQ3li6NLZ+ZgGuhZJymuKjzY85T4sm3vpS4bVFjvGDrYDieytFJxBG4
         0vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160211; x=1778765011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2p7v66esSqoBYICxVl1Y8jghKc3MBnhyUfxMzYF7Ws=;
        b=Xeui6cm3VK0IA5z2jyBATZfBvfPbAPD1qd6EB9vlj3GzR3sVUiLlAZ/HEdFQM97/v6
         HZnO8q1ln1mutLynlpg1wp0U6+rNg1TEq5fVo/FrcGxusXzK3GEYXukBv+qiWmQVNz3K
         MxZMjXs2HrKnoSRewvADAmX9hTUTU6gB0thCFGBMYC9zjmsGOynujrdsxMRfkcUGt3yP
         XruBrV1ZN3P19oejCd6fb6goQMxO/JI5kqTfCJ6HhL+uxnhhx9XLpoNqFY/NI4w/3TuE
         KRYPQ29oj9tUMsxC6b8+dr8TVWCBNNbstOd8bgyoHA/0MJPDUJwW5dxP6gLZV9woc4u2
         ezBA==
X-Forwarded-Encrypted: i=1; AFNElJ+PZ+dYU1meV8CW9xDmMcCovewj36oOjZz4N+usuzk5JGYqlBowhxk5KtSSFKr6ctnMqKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJJKJXAFZyE9FlITM+o0gJAiYq1j6YZcOG41uz/cSbIe7JNlO
	jctlstETyPTaD0TGlD5og8aMN5buOo+OQlMT88qSw1kx3Nyi3pomEdE/OqwVxSH0lX2GPewttZY
	3XVfZ7w==
X-Received: from plbmj16.prod.google.com ([2002:a17:903:2b90:b0:2ba:e27:debe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc9:b0:2b2:5840:80c5
 with SMTP id d9443c01a7336-2ba7a35a6eamr91003805ad.37.1778160210966; Thu, 07
 May 2026 06:23:30 -0700 (PDT)
Date: Thu, 7 May 2026 06:23:29 -0700
In-Reply-To: <20260507003613.1784851-3-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507003613.1784851-1-vannapurve@google.com> <20260507003613.1784851-3-vannapurve@google.com>
Message-ID: <afySUVD06XrJD0m0@google.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Set the has_protected_pmu flag for TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Vishal Annapurve wrote:
> TDX module virtualizes PMU for TDX VMs[1]. Host has following
> toggles to control the PMU functionality exposed to TDX VMs:
> 1) Configure TD_PARAMS to allow guests to use performance monitoring.
> 2) Restrict the TD to a subset of the PEBS counters if supported.
> 3) Limit the TD to setup a certain perfmon events using basic/enhanced
>    event filtering.
> 
> KVM will need to be enlightened to support these toggles.
> 
> Explicitly set the hast_protected_pmu flag to avoid KVM trying to manage
> PMU state for TDX VMs using existing PMU virtualization framework.
> 
> [1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 1e47c194af53..eb4b4518e6f0 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
>  	kvm->arch.has_private_mem = true;
>  	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
>  
> +	/*
> +	 * PMU support is provided by the TDX-Module (if enabled for the VM).
> +	 * From KVM's perspective, the VM doesn't have a virtual PMU.
> +	 */
> +	kvm->arch.has_protected_pmu = true;

Eh, squash this with patch 1.  It's not really possible to review patch 1 without
seeing the usage here.

> +
>  	/*
>  	 * Because guest TD is protected, VMM can't parse the instruction in TD.
>  	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
