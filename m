Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BD3D47D0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527435; cv=none; b=AxF8TRb7Fv+i8QqvbDlwMv1DewxrRUssP2OuSEGli8MDLO4I2SEet4+Hdtrnl6SKmrV6hbmrp1kIAHdiLt+d67wMrN3yWpXT0csOTQHvHVO7hvGpaL8jereqPdVAFga+8OioTats+IvQvsotgMWvKsrkqrUjyG7/NfJCrIxpmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527435; c=relaxed/simple;
	bh=FzQIgMSWbhyIokUzOxSXs5X+eFiWlOeFpIZ5377y9MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TzszkR3NEDxtQGsaKlZxG2SRQzaf3LkJ7DclDpK2RZSQnTBIkmSNxbDgveS140sGRXN2c9rNL1MIAmXqJGTPidM90ma6FI7gecf/XPLl/UzBJFQDR/1mPDgOiVdd/bLn87bYICC5CdH3nde7yymqHDtaE6+rDhBHeSuNLUkXnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/Ixtu63; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/Ixtu63"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c1e112dfso1085755ad.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780527434; x=1781132234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7fQ0iZNCgyRYhbqZYljEyuSeGi7dGwcSQsPSC7GyyU=;
        b=b/Ixtu63vE7zJmTMtn/9SPRZ7sGhc2Od7AeWwnDGVmcRa8IDFjw2P7whU/q7sM3GHy
         yDEdiunQa4aR1SWdyg2dXOiCZnGEsGJrZmHxYXkqdygFl06CFYAaL6A4MfiTABFpSOXn
         d09GzFuL3dyssy0rFUGt4i3tI3NLdJArwgSSc/cRTYUiWLuOs7phT5MJhjC1yB3JfyD4
         T4XGXZWURVOnN2EyDt0SjsDtsTd0wZoAeQCF0YfsUJAK/YvSuZkYgoNEudkBQlCd3SAG
         R6KDoa9ngIhwoXCwT67i4T9/nNuRgq1lNj3MLOj1luxp1Q8ci5AU73aBpE2dHah9axgQ
         bz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527434; x=1781132234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7fQ0iZNCgyRYhbqZYljEyuSeGi7dGwcSQsPSC7GyyU=;
        b=TbvNT5wkpK39znnW/35HBYD4Kwb8W46MMqm+hylpomdc8FthY54780ZrE/bIKUBYfZ
         zEWLI7NXL6qqwCH+Jm87oYDIXDYZKoxZphIU4Hc56VO12GeiOjia+Zr+bAcG2wOmKxSA
         hVIWE798sK63auH4VY41sMk5hT1mtQcqRlrs+PCCagmAM1KuPXutDHjXWsDH9Akdjp3Y
         12dAXvZ+UlZ0+k6pPZa2gJRXg03dQ6ibAb24oEAhWMLf2qCo7/2W+wMNKgoxC63uRnGQ
         vmJFzsMmEsxVcsaDmVmIVY5DEafQdoIEOF7aMo7CJpCtKsmKZ99g14QAguxqlrOvcIun
         22vw==
X-Gm-Message-State: AOJu0YxCAI/kM1DzSG0Nc9WfnohGpVJOU+5g+hwKq7yyj/i/p3mDBXzv
	1CYmpL3ALIvJssByZT/hdH8F1BRLgESd8KJQ2e0G/Z6DI3/vXtSTmb2DnZYnxiURXgM+rkbyoDj
	ffHnfIg==
X-Received: from plgm12.prod.google.com ([2002:a17:902:f64c:b0:2ba:34b1:ff5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ece:b0:2bd:4b8c:fd30
 with SMTP id d9443c01a7336-2c1644dbdfbmr52249425ad.41.1780527433545; Wed, 03
 Jun 2026 15:57:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:57:12 -0700
In-Reply-To: <20260603225013.99E151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603223418.1720035-3-seanjc@google.com> <20260603225013.99E151F00893@smtp.kernel.org>
Message-ID: <aiCxSL0rEkUFTW06@google.com>
Subject: Re: [PATCH 2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot
 L1's CR3 when EPT is disabled
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 03, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -3651,19 +3651,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
> >  				    &vmx->nested.pre_vmenter_ssp_tbl);
> >  
> >  	/*
> > -	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled.  In the
> > -	 * event of a "late" VM-Fail, i.e. a VM-Fail detected by hardware but
> > -	 * not KVM, KVM must unwind its software model to the pre-VM-Entry host
> > -	 * state.  When EPT is disabled, GUEST_CR3 holds KVM's shadow CR3, not
> > -	 * L1's "real" CR3, which causes nested_vmx_restore_host_state() to
> > -	 * corrupt vcpu->arch.cr3.  Stuffing vmcs01.GUEST_CR3 results in the
> > -	 * unwind naturally setting arch.cr3 to the correct value.  Smashing
> > -	 * vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
> > -	 * reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be
> > -	 * overwritten with a shadow CR3 prior to re-entering L1.
> > +	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
> > +	 * VM-Fail detected by hardware but not KVM, KVM can unwind its
> > +	 * software model to the pre-VM-Entry host state.  When EPT is
> > +	 * disabled, GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3,
> > +	 * and so simply restoring from vmcs01.GUEST_CR3 would corrupt
> > +	 * vcpu->arch.cr3.
> >  	 */
> > -	if (!enable_ept)
> > -		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
> > +	vmx->nested.pre_vmenter_cr3 = vcpu->arch.cr3;
> 
> [Severity: High]
> Does directly reading vcpu->arch.cr3 here capture a stale value when EPT is
> enabled?
> 
> Because KVM does not intercept L1 CR3 writes when EPT is enabled, L1 can
> update its CR3 without KVM immediately tracking it. On VM-Exit (such as for
> VMLAUNCH), KVM invalidates the CR3 register cache by clearing the
> VCPU_REG_CR3 availability bit.
> 
> If nested_vmx_enter_non_root_mode() directly assigns vmx->nested.pre_vmenter_cr3
> from vcpu->arch.cr3 instead of using kvm_read_cr3(vcpu), it seems this would
> bypass the cache refresh and stash a stale CR3 value.

Gah, yes.
