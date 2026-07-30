Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4253AAF4F
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432664; cv=none; b=BhdfcgcMhKkTlxrRgfczmYuJLo7rMR2PjyIP0N3IMwKEHxTaLty5MroB4lPaylF05jb0DSvaZHp+eUeSEpI/hBsFkPcnR0cOsO094d03gZTe7sFe/HWwHe43D5Z8cLS+fmwdjldpaZAj1CqGQlbodjW8p2P7FX1Y2IFLvJFfBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432664; c=relaxed/simple;
	bh=ASo3CSR1k4XpSIExSb42XUxsQPlrg9VT1v9CTYRhNC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pshd//TupGvOflg++mQbgrgXyLW5lD0GwLUuv0TAUWIYAlE25Vmj5AnkTKV4A+1yuXJELH2e4ku7Mit/RnETl+Pu0/reK6PH0bE4vAFG7aW6k0m9dmmzWyWl8E+boGx6GT5bAtcFlyTqzh2a0GfwkcS0x+ht199ZcG3h8bZmj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANKqMsZv; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANKqMsZv"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso105757a91.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785432662; x=1786037462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ouu8Y5jeG833FGaua+IzO9lFfQtuBKMW6QlirczT7MQ=;
        b=ANKqMsZv+C4kgo81m2TIrXbXRlcTNXkSG8yGg2V6HdNgehaiEVfwpujUs7nkxpeWVk
         b/PnRCyrXUgDPI2sL3EY6a9A89sv0QfIoBhC03rkuhyB2S9xMZyNTS1kd1SWZ9Rjd24x
         Y2sLZwaITfnCNYWOAjnVo5WM3EhxgQ0KqPx22nEDjV1zbVk7x8Gv5pBuZU/mrYXTqDw5
         Vx4Y72LwNDEwo/aFC7BfDdyCEUYV3AM6q5FkMF7aqFlpUVKPSjvWfyDi7z9IHq6vWjqv
         1Zsi7hsJegcDzA1F3iYyEGnZx45lpoyznUPp7g6PthNjwYiR/TZSYfKwgsO84E2Pjgus
         EMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432662; x=1786037462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ouu8Y5jeG833FGaua+IzO9lFfQtuBKMW6QlirczT7MQ=;
        b=fYKIrXXNtqle2FitvEOVAcEOtkOQRlbOl2Kn1Cv8LkgYswNeqauFQFL7EFwKWfhoas
         zPTxm5UsBa+RvDIhCEc+8U48sxOC8hCnPHiF0xHykWw1SfaB6a95PbLoj5HIcUdiJPbE
         Tb/pDf0d/sXwLyj/qkiuyhn6PuSHefO8eni/GJRZNN5RTnUKfLYjv7aDAXFqhdzaVvmL
         ebLhNp4BBQzd6kdNYp2LYVteU9juom3D1y8zF2vny8+wun2yLbDxvZ8fKB6HZa4LNgFg
         Q6tFGTMoKhf2LCpwo+gBKAg2Xz2q2u5v4JiaJ2l6lqjL8oTNZZLVW1e5C7cEr/QFJRR3
         VZTA==
X-Forwarded-Encrypted: i=1; AHgh+RrFx7wlLq00GacI9XDgE04kjFYshnzLB56bzk8KszUFFf6YPdA3d2Uf9uWL/vtRqXhcxxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82oY0qI2NOlprA/C2NrbodRlb6aJ2f2oBj/QWt5VjFN/yK2Uh
	lGIDu5QEgF/PI0wz3iwfPHOHQRnIPuTqwLkAu2gWXZtSVhbVhhehiHC056Z+uwRJfa8cD5Zeb5J
	gAzYgAQ==
X-Received: from pjc4.prod.google.com ([2002:a17:90b:2f44:b0:381:2921:e696])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:394b:b0:387:e0db:bc33
 with SMTP id 98e67ed59e1d1-38f9c099dd5mr3102374a91.41.1785432661657; Thu, 30
 Jul 2026 10:31:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:31:01 -0700
In-Reply-To: <20260729072044.25796-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729072044.25796-1-slp@redhat.com>
Message-ID: <amuKVfib5kela8AD@google.com>
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
From: Sean Christopherson <seanjc@google.com>
To: Sergio Lopez <slp@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 29, 2026, Sergio Lopez wrote:
> After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
> mmap") was merged, a guest write to an unpopulated PTE from a mapping
> backed by a DRM GEM BO triggers a VM exit with EFAULT, with
> hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.
> 
> This happens because that commit implements pfn_mkwrite for
> drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
> returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
> entry to be installed as read-only. This is done on purpose so the
> fault handler gets notified when the entry is going to be written.
> 
> In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
> fault handler but, as seen above, this one might install a read-only PTE
> even with FAULT_FLAG_WRITE present in fault_flags. The check at the end
> of hva_to_pfn_remapped notices that the entry is not writable despite
> this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.
> 
> To address this issue, have hva_to_pfn_remapped issue a second
> fixup_user_fault call when needed for write-upgrading the PTE.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---

NAK, this doesn't belong in KVM.  Expecting callers of fixup_user_fault() to
retry a FAULT_FLAG_WRITE fault on *success* is absurd.  Either manually do the
retry in fixup_user_fault(), or return VM_FAULT_RETRY so that KVM will naturally
retry.  I assume the latter is the correct approach.

