Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9135C1A0
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575798; cv=none; b=pLQVxVKznqeJeZv+wtJs4zaGygCU8zxan6OOyYTUrDf9syHeuxvUd+umApPcaMHAe4FrTASeofOP8x6zxY73pmP7Z+tN3MvymuRQoLvTkhTTUrSX31ITleUTN3EKFjQWV/d0M0RUM2aPwKmaZfZgfG5auFbslSQqlUEYduKubrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575798; c=relaxed/simple;
	bh=rhwUho6yoZ07MmJcqhTRzrKOVoru0E/tIqnep00ikhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ovYuqNvfY7xYOwGw4K7hGQBpIolpcyTdrhF1fTjztPIpYMwfxBGYpXRjgMRZlywGDqVmQn+ghgjfYHNYF4vB18veCb+04adS05qrcCHBTqLGTJ23H60ZNFNc+UxwZFI3vAjTq+3vdmDNy9H0j2jrfq7HApnTOIKjW6LcH32m620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ0210ik; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ0210ik"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa366fb79so1416453b3a.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777575796; x=1778180596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZQTc56VieBq4iKhMHjHZ1mJOLehd0ZXe5Bs1H9JyO8=;
        b=pQ0210ikO891g9nUiZeGcwuBFp7meA5HwE1q/9PJdswPiyO4CTbtYZF0KkY5x1ESVo
         gUTyFOpQV+DqAyFo6D3kOgHwip4x0coezrmbBfW+S4pf02+nPhbugJY7oe6owN0EcGUU
         fSLYAdYZFaGFMF44MDaBnmGhorveuO/X2tQ8LyhU6niEjMB/PwzZ/P4g0N3fCvpds0lE
         sy7CSwibP7uCVRZ2e6cfDCOgbqWFDRjPTDocfA04/GmlURzwVZ/qVXOJYC08iF0ijv6k
         hAS0mPY5ZOLtvkwaSxiDssTMmnk/3N3J7LoOb7GGiBuFSsxcZuIzkcg/zpeS+LFqmheO
         0BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777575796; x=1778180596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZQTc56VieBq4iKhMHjHZ1mJOLehd0ZXe5Bs1H9JyO8=;
        b=IFTQBfcrtCR0ULOfkzuAAeY93IDtafdK4ksMlgRe4F2b/XZsQbCsEKqhVK/ryy7R54
         osouhHt0wiSgqlH+g/bXyuHKg7SFUe6vopA4UCkTpOfanPqs4AM6I33tYeV9CIPlCGDU
         8dXYbTl9+K/dwLHQqK7VoXXGdqS0d0JevlqFwf5O9y7Brbbn78FbxxDVoFr68EkVvWgj
         QP7nsvjx1jmuavHsprRVqshCjsAuoIh8sJzADIKQ1JrLgf8kqCdcNt8EyumN/5kofrCG
         HHAujVX/rPSkXP7WrQIEBAJfElVC6Dsj+GWEj1Zp05Sg83pqKYitQcn1CkNxtVc3IA2G
         zQXg==
X-Forwarded-Encrypted: i=1; AFNElJ/fiFU0pfKGP/+pBFLm82nBBWYHbyUczxizexYfza0wzm/0bnB5crmzaZTykNmAyKA37pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcncXb5bRNxAtefTli65YmuOvxpGjto3+38U4ccCVI7f294Z2a
	aW/lLv8n2kF44OjXo5h+6DpENYacFRrKuddaE7BIur2dY4fC3fV6LpGTMtzsGAAbH3rDiV4yeWx
	uG1vW/Q==
X-Received: from pfww6-n2.prod.google.com ([2002:a05:6a00:8886:20b0:82f:b21c:a00c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a256:b0:834:df57:9d31
 with SMTP id d2e1a72fcca58-834fdba7411mr4729827b3a.28.1777575795978; Thu, 30
 Apr 2026 12:03:15 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:03:14 -0700
In-Reply-To: <20260430150747.76749-18-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-18-pbonzini@redhat.com>
Message-ID: <afOnchO-w029RKF0@google.com>
Subject: Re: [PATCH 17/28] KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> For EPT, PFERR_USER_MASK refers not to the CPL of the guest,
> but to the AND of the U bits encountered while walking guest
> page tables; this is consistent with how MBEC differentiates
> between XS and XU.  This is available through the
> "advanced vmexit information for EPT violations" feature.
> 
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/common.h |  6 +++++-
>  arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 40fa72f31fc7..48520fa1c8e8 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -100,9 +100,13 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
>  		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
>  			      ? PFERR_PRESENT_MASK : 0;
>  
> -	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
> +	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
>  		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
>  			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
> +		if ((exit_qualification & (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))
> +		    == (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))

Ow.  Maybe add a helper or a local const u64?  Actually, no need, just drop the
ternary operator above:

	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
		if (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) {
			error_code |= PFERR_GUEST_FINAL_MASK;
			if (exit_qualification & EPT_VIOLATION_GVA_USER)
				error_code |= PFERR_USER_MASK;
		} else {
			error_code |= PFERR_GUEST_PAGE_MASK;
		}
	}
