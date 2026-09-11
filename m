Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C538CFE8
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152918; cv=none; b=ead6Kp6Z0HC5YjScpLno5eD3czV+ZXGwmxYVaakWeKKCpzZs1sZAOEzwbxAnXK375GI4h/g1zE6TD2L/8az8TsD3YBZ+qkYBlFfHP1UltpQJCvj3Gg6/5e9viGyyP5/u+Wg6H7d3Qyj+u7xLL3yValm5WGVIcuW59/8ASI68+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152918; c=relaxed/simple;
	bh=n+DDeFg7TOLIqqFkQLI0huQH+gXR42KwePyrVYDRm9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CNxI2aM9PRTUH9qBQ+h5vuyZVQ4afgZjnXr9PwZ+VImDfYWy5Ni74kxTysFYr99WCKNX8FUXF0bbq8AGexVGXOSR9C//hG9guLZf54sSJI5+zgwojqNiS3ekTwnrrV81nZTPMj8pKxBSDyhZFljI71/f/+PMrtTNJG6TMG+wJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STvJ82Yg; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STvJ82Yg"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8627258ef12so2245546b3a.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789152908; x=1789757708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tndSaurmQgtNITvmfnqk27lDd3GCpP8a4kiL8q+A7kg=;
        b=STvJ82YgmgxC8x1m9Ek5Dno4goNGT9G8WjkUyuP9vLLEL4Owz+iD1CJpyFwS2kxjhO
         Osra+1qK63rAcpSHnznDAbRQoS8dKDwQMRbjmPf+L+TwytwrvNUgQcBbyvtJQeRBcB+2
         JyfmxtyT0Y6INqgnNKUZI4B+59u+pFBHOXpaIAHjgfi8gjRMkSwZEu/yXH4szPxRPyXg
         u/xYhF3NaIjcr4wgCXHsq8q/d1kNNfVZhjzpnZhGdclwJdRwN1GZTwVJ6aMcLTWML+KK
         6AGMAfjbSn6P2gecdMxlBtspYtRUc65R6KqxUcZa9PE6X+LPFtDCE0+VicsX4bldR04K
         LN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152908; x=1789757708;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tndSaurmQgtNITvmfnqk27lDd3GCpP8a4kiL8q+A7kg=;
        b=EfWl1sECWEguNH4cK4nO0FaO/o2Rl9cZgDjjmoY8GpNCwSe6D+CZ6HIPV/sPmRFpnV
         DgcCZGr3dtV1onwEZU9A9hFi31dsFeolSz9ihbLxwqABg6FQDMmspQtye0K9fOYUsAaD
         ejeqI4f6M7J8l45T/8K+VMfJ0OndrrTPt5U99ZCL5dXIys8VOMpkA3Ld0VjBP4+8SNjF
         MHeDKEpPQooPIQl42aTVNb6yW0BskNltMlr1lrGeruNCC6sIhdir5hHALBHFF4YXDu/6
         sQ6JP8TDiDrsrM/swbzAVf4KdWpnSNZtrZaM4+Jxns53AlGZobl+P+A2Jf1GR6u+46Rf
         Y1+w==
X-Forwarded-Encrypted: i=1; AKwUvBxTvM8PuWbrnBu7WtU29s+SqbA7q6vDpLCQPgxgWfxwN0SooYF6SjRpULcUxZxZgtOKe/o=@vger.kernel.org
X-Gm-Message-State: AFuF++l9akNt2xW4Gz2OzcXqvc4CWNTM1XJJPEnYdgtHxnmu8dX9Ww8X
	LeE/eZ7uzA0VEo5dLVfwnDE0rFoWMB79KrRVwwqfuoba34+88cDXtIGMKScxgEATtIe7v/6MnrP
	zY1SIfA==
X-Received: from pfbcp14.prod.google.com ([2002:a05:6a00:348e:b0:848:4e44:7f19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c8c:b0:848:6f5c:a327
 with SMTP id d2e1a72fcca58-86b314013bfmr9198274b3a.15.1789152907815; Fri, 11
 Sep 2026 11:55:07 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:55:07 -0700
In-Reply-To: <20260903062856.2090499-1-naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903062856.2090499-1-naveen@kernel.org>
Message-ID: <aqROi4Gp_vPvsOtp@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
From: Sean Christopherson <seanjc@google.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dmytro Maluka <dmaluka@chromium.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Naveen N Rao (AMD) wrote:
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 3b037e385523..bc2c699380b3 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  	return ret;
>  }
>  
> +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> +{
> +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;

I don't love the duplicate (triplicate?) code, and looking at the usage in
avic_init_backing_page() with fresh eyes sketched me out.  It's "fine", because
KVM will reject vCPU creation if vcpu_id >= kvm->arch.max_vcpu_ids, i.e. checking
only the architectural max won't exceed this max:

	return min(kvm->arch.max_vcpu_ids - 1, arch_max);

But it's hard to see that, and I can't think of any reason why being paranoid
during vCPU creation/destruction would be a bad thing.

Assuming it actually works (haven't tested yet), I'll send a v2 with a prep patch
to add:

  static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
  {
	return (vcpu->vcpu_id * sizeof(u64)) <
	       PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm);
  }

and then this code becomes:

  void avic_vcpu_free(struct kvm_vcpu *vcpu)
  {
	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);

	if (kvm_svm->avic_physical_id_table && avic_is_addressable_vcpu(vcpu))
		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], 0);
  }

> +	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> +	u32 id = vcpu->vcpu_id;
> +
> +	if (kvm_svm->avic_physical_id_table && id <= max_id)
> +		WRITE_ONCE(kvm_svm->avic_physical_id_table[id], 0);
> +}
