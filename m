Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58649B210
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144351; cv=none; b=lZfZE7Q6zfp4DbavtBIJiIYhAT1ONAZl7keGFD0iEXKavFjiJc19jYXZJ1yJfbvrnISfT+lPvy2viL6FIkEbv5AYuLYLV9h/dGv6oAcRfMCMuT348yPcf5EmvOLGbJqk2O6TGPGhNTWF7Go/ZfxnpWT/dPiU7rKC5054rVwPUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144351; c=relaxed/simple;
	bh=LmLURsucfjs32AbOYiyZoOtbcqUK///GisZHcJZVReA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HSjOPQDVYV5aoD6UZAhv9goQ6Btif9pCInSTK/Pbz1D12Ah1s+br05dSA9C7evBRoOUwS/yROsI5HuUjqUH+WpkXuCo9wsKysG8oYnIn06o+hBvVc0v+ywZKVKXH4vhjq7k1wZ//V58ALKGMiOdMJecl0yNTJLQ4TnT0C+SAWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNKmtWIE; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNKmtWIE"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86bb318386dso562343b3a.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789144341; x=1789749141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUA0SlbNNCb5gpe+rn2BHKxNgOo4ftcmt0Vnmc/8Eb4=;
        b=CNKmtWIE6BSf2CJuvn9loIypaD8fl4/w/jzHOdVaYB360qvDxIOtBvGND1OC3+0vzq
         mFCYeB5NqMau8mJcCMuSMkVRyFMNY5ZyD4F/5JX6JSPGg4nV7GfL1MxIwJe6XKdmQpFL
         DxnabQzySwl8Clur7h6EGm+s/c94iXCLbNty2pNdMW2gfqMCoTc3hJ+OibeISrDEAHCo
         wAukYRfvmOLtwpOu6feczY5g69yqoH0Qdczl+qcJezPBY2zMIHUtijmfHG3x+x1V2bd/
         PxJDbLevTfIgRwbo37UihfbmSmWxCzNJ5AEw7wUWNVC4TEpC+DDK/5qiTutm30uFLepl
         3z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144341; x=1789749141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZUA0SlbNNCb5gpe+rn2BHKxNgOo4ftcmt0Vnmc/8Eb4=;
        b=DDD3qS6IC684jX8TkdKUFUXWrMqE+Vhv7iiloCl2b9p7Fsdv/ot7pf+ci021bJRNDQ
         Eb+eVMcLE1Hag4PwzQ2DLsj/3ag2TGo1EBYZ6B8JjdufvZJHzSb5qiAbTx2sAyZpbn92
         x4rC/3aj/lY7HFwNV8gskyZlfLBHUKtrj3xveAIDZNjbL8YAMFWMU0ESqp30VWA51t6E
         +VoypNeNE5A4yRHE4tCUQXlz3g+Vuj9M27bGOagTvN9+9H1Wp8wwglnQ6LxA+jA4Yo9G
         NIBGEEpBC144EgEtLYRFH2hXjhKV8hYF7PL/QnQ2slhykmeKcvDvPg0vdUJyCwhS2kQ3
         NPyw==
X-Forwarded-Encrypted: i=1; AKwUvBzIMSFKHKwxLAtxsVfO6AGaIZE9cNnkle1D4gBodQhCDCu5LL9Brc+q+clXfY3KAc39wEc=@vger.kernel.org
X-Gm-Message-State: AFuF++nz8aPQaqcgoQby78426g329l+P52aEQD1R1HP4cFxFRGlk43y4
	xntJcMhkRB0bjE9opeEeBHy9dLycuQ8YBzgpXhIW6To3GqDlqXIGRDnzCu7BYTkxc7LiIJ5mXv3
	pNehAxQ==
X-Received: from pffl16-n2.prod.google.com ([2002:a05:6a00:c350:20b0:847:b24a:75d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a1c:b0:847:7f3c:b5f5
 with SMTP id d2e1a72fcca58-86b30413312mr7137606b3a.11.1789144340903; Fri, 11
 Sep 2026 09:32:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:32:20 -0700
In-Reply-To: <20260910115414.3015260-10-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com> <20260910115414.3015260-10-ewanhai-oc@zhaoxin.com>
Message-ID: <aqQtFOzx35CVqfDK@google.com>
Subject: Re: [PATCH v2 9/9] KVM: selftests: vmx_apic_access_test: Check APIC
 virtualization support
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Ewan Hai-oc wrote:
> diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
> index 089e1a8af..e512191f1 100644
> --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -390,6 +390,21 @@ bool kvm_cpu_has_ept(void)
>  	return ctrl & SECONDARY_EXEC_ENABLE_EPT;
>  }
>  
> +bool kvm_cpu_has_vmx_apic_access_virt(void)

This should be kvm_cpu_has_vmx_virtualize_apic_accesses() to match the macro, and
to match what KVM itself uses.

> +{
> +	u64 ctrl;
> +
> +	if (!kvm_cpu_has(X86_FEATURE_VMX))
> +		return false;
> +
> +	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) >> 32;
> +	if (!(ctrl & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS))
> +		return false;
> +
> +	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32;
> +	return ctrl & SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;

Carve out the guts of kvm_cpu_has_ept() into a helper isntead of copy+pasting.

> +}
> +
>  void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm)
>  {
>  	vmx->apic_access = (void *)vm_alloc_page(vm);
> diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
> index 463f73aa9..a1b6da4c0 100644
> --- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
> +++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
> @@ -78,6 +78,7 @@ int main(int argc, char *argv[])
>  	struct kvm_vm *vm;
>  
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> +	TEST_REQUIRE(kvm_cpu_has_vmx_apic_access_virt());

This can replace the X86_FEATURE_VMX check, since KVM shouldn't report support
for virtualizing APIC accesses without VMX.

No need for a new version, I'll fixup everything when applying.
