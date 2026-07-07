Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC693403F1
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439883; cv=none; b=DvcMWdiXr9b83WqmgTRzO86JWyf03AEjQzItg33FWNcHH2XN+XZj5SSvLDJdpQbkiC2yVXYTrVP7nYQX3/kgoJYOa3iFdz9EzAcKAeeUf4L9TIbtdmvWvnxblYXRIzo6EUnWeBzp0QdhmCWfje1sfhetzY7DIyu0lHkLN3mlj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439883; c=relaxed/simple;
	bh=kFwLyf1abhaRclabjXjH9A7K3r5DC2OJA2ANJ0z30OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AnwaUlqFs9OEPcp7lqCJSb/zsejJs8S9iOeT7niq5r0LLsgK7hjiBlukKIUiDDVyNfik7NFvbKCvHo6MxjRzbioOW4eYC44gsoLUGZW8anOUHEYrNYiewzWT57/5DBs3OMKs4NfH7BkmIYuwG61HsAnY3z2I9Qjg0PyGfiN75ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsdcXxEA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsdcXxEA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2caf4173b1cso86840285ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783439882; x=1784044682; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0zV9fGaTZEmORdu/uK9aNfr0bdHaBWJMIm95AarhZc=;
        b=YsdcXxEAuRucsPNVVv+ycYp+5pDPp7TmsiaLggGb9UuwBknjje7cmiot7ZMxZZeLw4
         jkrXY2bnR11Rf9UeEdiDCjJncl4m0cvdvC8xJTgbKImluWKX9q6IaorYqrMpkeg6ixpP
         vjytPV07nJR7qDAnFJJ1ynlYVz2D06ihK95CLGasNO+W1UpeBQI6Tw9z5kaoYOSUxcTF
         J09UOpJ3E6zS0xZ54SlYjT2iGmos9tZLOUnKPz7piEp+BU3/3wOM+PDQuDhkwiq9nRQY
         4vnGf8ZS2ocAop8HeEDnUpwqVDtbxHyN5ugb3XprXK0TIHh5UEHzRbolc4S+ALW9sjgv
         FaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439882; x=1784044682;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0zV9fGaTZEmORdu/uK9aNfr0bdHaBWJMIm95AarhZc=;
        b=Ej3DgK4nRIk7mBm5JxksMaxC9Oeysx3II7R6EcIvYQ8p9rTBZ3rXXNpRxvktjMFn0e
         l+EjBSHEzNMqJnmaSkDouyqCMmlT9ej4zpPQoNUd590i2zpBHStOaptpgSTRn0RPuujU
         wYdjLKMb9FlxQLjwJaEn0F2YMrFx/B1EvWg1IUzmi5ZKNJ6NoDtHcIMeZHv2D23SkRrM
         7CRfuM/IB6M6Xh+tNhJFZ1L+R+4VH3K4yUI37Ya6qcp4SAxhIhTnXPYVki/npVfDdEsv
         nsmZjgAMDK0zBIRSBcpxqJZu8fOP1A127utKOElgGbAULyYsoKz7WBPOcFuAssFX2MBT
         7nhw==
X-Forwarded-Encrypted: i=1; AHgh+Rqm5zLHW2/2utCRfOTxDEuYHc3S0uamDSOZcStsDOG2s7EFS7NEvtiHMRfZAWNnqxkcHwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+xRr2Mi5vMo05GgdjkjcgS2GgyHoBoq+1u0V/SGJ78/YQX5m
	69VWxxm7Il9qj+sQjD0WHrei5vRAPJyeZ4bnGKQRKTqKMv6/xNf37XudUSCK1RjtW19CRbwEKgX
	C+xJLFg==
X-Received: from plpk2.prod.google.com ([2002:a17:903:3da2:b0:2ca:c401:c941])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38cf:b0:2c9:e9c4:82c1
 with SMTP id d9443c01a7336-2ccbf051685mr66239695ad.26.1783439881598; Tue, 07
 Jul 2026 08:58:01 -0700 (PDT)
Date: Tue, 7 Jul 2026 08:58:00 -0700
In-Reply-To: <kpmoqofdihxpnhj6yxkuppaepy432h6hh4c53wzptbilzfvqa2@vwboboldkb5x>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-11-seanjc@google.com>
 <kpmoqofdihxpnhj6yxkuppaepy432h6hh4c53wzptbilzfvqa2@vwboboldkb5x>
Message-ID: <ak0iCL0GPC8S_Urm@google.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Michael Roth wrote:
> On Tue, Jun 30, 2026 at 03:26:05PM -0700, Sean Christopherson wrote:
> > ---
> >  arch/x86/include/asm/kvm-x86-ops.h |  2 +
> >  arch/x86/include/asm/kvm_host.h    |  4 ++
> >  arch/x86/kvm/mmu/mmu.c             |  5 ++
> >  arch/x86/kvm/svm/sev.c             | 79 +++++++++++++++++++++++++-----
> >  arch/x86/kvm/svm/svm.c             |  2 +
> >  arch/x86/kvm/svm/svm.h             |  2 +
> >  arch/x86/kvm/x86.c                 |  6 +++
> >  include/linux/kvm_host.h           |  1 +
> >  virt/kvm/guest_memfd.c             |  4 ++
> >  9 files changed, 94 insertions(+), 11 deletions(-)
> > 
> ...
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index cf7c1a437f38..123e7bf687ef 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -996,6 +996,7 @@ static inline struct page *snp_safe_alloc_page(void)
> >  {
> >  	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
> >  }
> > +void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu);
> >  
> >  int sev_vcpu_create(struct kvm_vcpu *vcpu);
> >  void sev_free_vcpu(struct kvm_vcpu *vcpu);
> > @@ -1009,6 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
> >  extern unsigned int max_sev_asid;
> >  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> >  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> > +void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
> >  void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
> >  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> >  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index bc0c3163f4a3..0bb50997c0e3 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8170,6 +8170,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >  				goto out;
> >  			}
> >  		}
> > +		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
> > +			kvm_x86_call(reload_vmsa)(vcpu);
> 
> VMSA is SVM/SEV-specific, and while the event/handling might be SEV-specific,

It's not just SEV specific, it's SEV-ES+ specific.  Splitting hairs, but IMO
the distinction matters because while there is a "save area" for SVM and SEV
vCPUs, they don't have a dedicated, separata VMSA.

> would it make sense to make the kvm_x86_op generic at least?
> 
> 'reload_guest_save_area' maybe?

I think I'd prefer to keep the extra-ugly vmsa terminology?  We've already bled
gory details into common x86, and I don't see an easy way around that.  IMO, at
that point, any abstraction does more harm than good.

E.g. reload_guest_save_area() is more like to be misread as "reload the save state
from KVM's vCPU state".  Hmm, though by that argument, reload_vmsa_page() would
be even better.
