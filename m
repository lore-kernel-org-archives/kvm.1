Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CC23EAAF
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915632; cv=none; b=Y/rO9BIt7Rj8iUwxKSICTmqxLSrWrIH+sg2zZSAWaq6eJJ1rRf/YUqkEmqlK9nybF/iIhnYIcQaiJnzBC8Q0XJdiyqvOQCeuRIeND872ueqoXSg214pqucG3q840O8P84VoiBCX9ZIBRLRvZtKyIhMyBVXMqk68UF/veMkMB37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915632; c=relaxed/simple;
	bh=OmEyt2Wpj2kwSt4MSk/c+OehbP6UR62f1FxHN9SJyDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLo0zbVeNrYn6JwPdUEz5YKqttTevFqaED4yxqiaFZfgwoAcD5aYTGANqmHhr+afudyQpJGMhf06RlXxw0xFzD6dv4Icj/C2MbzYIba7DWTK627t8aElONd9W6ucujRDP2hq0DDMEVlg5IOk9Qac2G09DdqiHaIsodMR7ZMQmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+6T6JmH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+6T6JmH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso1255992a12.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777915629; x=1778520429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrTuWszRV7GVD4d6H7eOtuZTEMFTuHRxmNPLKYgwrkU=;
        b=b+6T6JmHrDwI6bMiUOaVOPUu22HChCrXWMUnF5yiJ7t9MU/J4+0wvGatR9gAHPm5B+
         6cKA/hW/IGun2/B9mkCkRO9KpscavgPOKIXOuCXi+CCvNBFzZmYriTroHKsddlUk184n
         ci51Py48c4zm1YmiFSybGkzFRMoYYas9u0P0czHRwrCIl1CmtX3I5SctGr2LrKgYoB13
         4gpKWHJJG+X14bUznqLAs3VDHlZ/oJQmiyqd9UmOXpzgmRy7SyPPcSybAXx6HNV994UU
         oJ0AvDd0Py+qnFlf9sbmJs7otvCkOlHKHOCqVLk2XZDe7vsvIYSHnYilN2/ho1Fjictm
         IpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915629; x=1778520429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrTuWszRV7GVD4d6H7eOtuZTEMFTuHRxmNPLKYgwrkU=;
        b=nWulSDKPiIoTYz87vSMAMpNoLGAjIE4Qn9tOZ2TnsYpBi8CbaeTLKBh5aGXc2qgR3Y
         kwZhM+wjPB0tJ6qGBz4kF/m6kJSq3DeSAojahDY43UyE1LubaSX/K4RUqFUUXvmp27S8
         OYGh2bGVDkGlyRaJgTdo7U4M/Uc980p5yS7VtBAoTjS4BNNJ7Brrc0fMhrELm0+pXPAM
         MnE6r1esQttThE2tMEQD/3K6cHWBH506LP8eMBlFSTLrUrrpQu5QIOa5kCZa5+Vg/rmA
         I/NFUN0VuHxfJbHVvNOCsAZTJT/Cb54StaVndno7NSgl9qXWNewQeCQk2+mDpe+5cQI3
         oN2w==
X-Forwarded-Encrypted: i=1; AFNElJ86yj59a/CrBhinJZmr6jyPyM84tKISNdSeLq6855EqmS310XueCXjgJLaVwhsmr2D9pgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhw2XSbOfOgS+s9XPN86W5OCZGlFx188Ykcs5dMByEzUHkKJH
	3vMUzp4qcW4sUxtQy0xqXt5g7PwuH54CAsmYdwTdQwz4QF9lsCwcTzbMP/R3BplGUT64uFGOPvl
	0QaqlJA==
X-Received: from pghc24.prod.google.com ([2002:a63:da18:0:b0:c79:8016:512d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e083:b0:39f:2b9e:e472
 with SMTP id adf61e73a8af0-3a7f1a1e0afmr11438545637.3.1777915629068; Mon, 04
 May 2026 10:27:09 -0700 (PDT)
Date: Mon, 4 May 2026 10:27:07 -0700
In-Reply-To: <20260503210917.121840-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503210917.121840-1-pbonzini@redhat.com>
Message-ID: <afjW63q5KqkwHMK4@google.com>
Subject: Re: [PATCH] KVM: x86: use again the flush argument of __link_shadow_page()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

x86/mmu

On Sun, May 03, 2026, Paolo Bonzini wrote:
> Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
> clears the SPTE but leaves the invalid_list empty.  In this case, using
> kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is overkill.
> Avoid flushing the entirety of the remote TLBs unless the invalid_list
> was populated: instead, use a more efficient gfn-targeting flush (if
> available) and skip it altogether if the caller guarantees that a TLB
> flush is not necessary.
> 
> Based-on: <20260503201029.106481-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 892246204435..85bec8eeace8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2541,8 +2541,10 @@ static void __link_shadow_page(struct kvm *kvm,
>  		parent_sp = sptep_to_sp(sptep);
>  		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
>  
> -		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
> -		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
> +		if (mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list))
> +			kvm_mmu_commit_zap_page(kvm, &invalid_list);
> +		else if (flush)
> +			kvm_flush_remote_tlbs_sptep(kvm, sptep);

Duh, this is obvious in hindsight.

Reviewed-by: Sean Christopherson <seanjc@google.com>
