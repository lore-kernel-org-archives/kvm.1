Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA6145B27
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408449; cv=none; b=cF1Zpl95imxWRDuFyBjfWkM9sS/LRTfAkdAiVgO0bP5cNl5gTzPzYkFgPORg+GoQn/7XDROfItq1PUBWWV8YuDiwHn3gtKw8o1GsxKnQV0zjZNOyk0vdu1jR0jTy+bEFlR40bwZcwcyVXMsteLJKxqcSPPeJU9AKaK06cMDuha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408449; c=relaxed/simple;
	bh=MMa/hp91Q4DQrF2Z+/sD8leicCizhFmkMuC0Yp4mbJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BENeA1HsVfF8BNKM1jonFQv07Cyt6YicET5liH+qEtb2Se6YsBsHJqJRgVh4tjvHKrDqzcoUlW/AO+QNN6x7iryHaCvoOb+dULzhOHsObmMr5qdg1ioB8r76lEHeCmoH2fHFZOsk8LreIeyy5l/ykVyIEayZTShGMLaHrWDP9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRmMJjUU; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRmMJjUU"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso1840542a12.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786408447; x=1787013247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55Q0ob263MwyA8FHi6NvsRaHz0KhR6aRDC/5/vbhWl4=;
        b=GRmMJjUU9Rs/N57zlNNxwKfXJ+Kd0MRwnI4NffVKUFjLV5ZnAwcY2iNNg2+j7DGxQg
         1Ir9N6XbxuChdQGTSDVOmXfpwOu7KGa9uJCsFHM5h1B6AAsuzGybCFIvrW/G4Q3A4x+7
         Ab7V4ix8Lei/mIktIrDQOZbEzpUPY6xHqeyEcJE1Vn7O8ncLYdfeHO5mKqHZOZp2mMC5
         49YUvfO+qGD9Ch646lnQliLI08e3rR8ukzBTT7AbhdoyCM1XLBf4BkPYBKky16IqAL3h
         rHbwE87iCULuRuIfBfQ5nsRUGD8gdVnztZAT0LVXTnDg1nuAKjD+MZO10HoaFpgbf5Fp
         1foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408447; x=1787013247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55Q0ob263MwyA8FHi6NvsRaHz0KhR6aRDC/5/vbhWl4=;
        b=JNsKAKPhu6VMANyWdaet4DaCuEzY6eCR2U5W3KvX4P/UV1wgMjXiDF/DmZjaXeqle6
         wJ23v2HtVhEp0yKS/a4WlabE7dzpUgC3817MIf5CI+g/kpGtg8h7+0MYYismBs8PMO0J
         BbcWBI04u7fQpc61FJO2yepcnwbNvVE8XWCIkm2VXoj5w+L8Z9hEa2MxDSa3EW5vLWuk
         Puof5mGsnT49pTPD2bgrxDn+H4e59LnUrZIvB2D7uHLpAFncKw8X61Rja5WBen100U5I
         ndS2/pmDxXRSu5pmx73XuVjR4t/G2Kn3rjFxQUOy41n7STKlTXrMdm47+Phfveh0mBEq
         IJaw==
X-Forwarded-Encrypted: i=1; AHgh+RrDVUbwSpW7otPiDYQtDOzf83LygDV8TqkwPLeBbrx6U7xNkPORTp3QpmOgTkhoKTQKnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWylBL1ks07ZPfEU/6sn6Mmf6S4KJj3+iD3pVUuls4b+0fMUkx
	4K/CtVFV3ZL+KarkfFUpt8FoPFsMoPavgZzsLeH+u+xckYhxwhhmM9bFoSf1BrKgrR5UCPIHS6L
	VJReobQ==
X-Received: from pgu37.prod.google.com ([2002:a63:1465:0:b0:cbe:a685:dd06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9106:b0:3c3:8651:b302
 with SMTP id adf61e73a8af0-3cc1a372bfemr6394430637.28.1786408446327; Mon, 10
 Aug 2026 17:34:06 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:34:05 -0700
In-Reply-To: <20260713105033.15405-4-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713105033.15405-1-sarunkod@amd.com> <20260713105033.15405-4-sarunkod@amd.com>
Message-ID: <anpt_cMpS1-ua-jX@google.com>
Subject: Re: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU running
 state to IOMMU interface
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Eric Biggers <ebiggers@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Li RongQing <lirongqing@baidu.com>, Marco Elver <elver@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
> @@ -1008,6 +1010,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>  					    enum avic_vcpu_action action)
>  {
>  	bool wakeup_intr = (action & AVIC_START_BLOCKING);
> +	bool is_running = apicid >= 0;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct kvm_kernel_irqfd *irqfd;
>  
> @@ -1024,9 +1027,10 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>  		void *data = irqfd->irq_bypass_data;
>  
>  		if (!(action & AVIC_TOGGLE_ON_OFF))
> -			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
> -		else if (apicid >= 0)
> -			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
> +			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
> +		else if (is_running)
> +			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr,
> +								   is_running));

Pass is_running here is rather weird.  Given that this is the only call site
that originates outside of the IOMMU driver, what if the exported
amd_iommu_activate_guest_mode() is a wrapper to an internal API and hardcodes
is_running=true?  Then the internal path via irq_set_vcpu_affinity() can pass
an actual variable.
