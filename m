Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DF2931C8
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914668; cv=none; b=kXV0kofKQUBfJACQ92TiZ2oUevtFub9q+7MhCr07sjjz4ALGGBvPSV/Cih6PUL6XRIcLK7lu+qbzNxKDO0M2HbIbGPSJoV9xaISUgl69opl/dGEiCdKBvjx7eWz4eKeSt3WDffTn8xYhqMcHKeAExfpb1EllhPeaoHFgQTW3gIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914668; c=relaxed/simple;
	bh=l8uG26RvwD8Y2HzTaOEH9KFHmRl2+85En6DMcf0uYHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c26YHV3QeO+g1sg9q7DKCOKJzFfW7q36UDIWXiQ2BLmk1dkCWFDbVtLRUo3yqGT9t83XpbMieD2h2lknEKA1fFKhgB2vobsrbegnnsSL3e5deRTZ49yVa9LBdKT9sv5FC87hPmMjRXC0zzpD0cgPQT8K5+dfjLcq5WiDhLdwwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1L3eya4; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1L3eya4"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so12645365ad.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914666; x=1785519466; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88i2FAPnNSs5PtZ+XyIQEY3WbgvQdCR/vHvsQd7vMxk=;
        b=M1L3eya431CPEvBTnIwR76V5b8M51cjP7dIhoo4+O+weUfpiAIe4796Bt1ZrcMu1zs
         AHq/EOJtF9kTNBvZ5MZ4SCIrH1OEMtDPIbY7zlGDQ1FwhdvK1Re/ua+hOjb8mb9eaKGW
         BsZiXkMj7ivLN748rMyFUg09Tui583aJVTXxnw4EekgecAE4SszdCaSonegP1lH3Y7m8
         d1GDXBeZ/KQw/7mkK83wF/tPPh5/CIhdv61zZ43KEgXu2Pt+oOqqMK/eZ0zzavIq3sEE
         gAPbhaC/wZ+dHhiQuyAAbIYOe3T11wd6HdY5yLP/noKghUqnpyaNxAObPBbC5Cx1G4Au
         FPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914666; x=1785519466;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88i2FAPnNSs5PtZ+XyIQEY3WbgvQdCR/vHvsQd7vMxk=;
        b=DHE7eBZ3Kh4TJin1QX0B5NXqyAZNpfoOmCXqYc1IJ5gPP4R641/KLVMz/glka/jA8G
         /uu2aCWyyiIqinqXbb/1pUdR6HPIpUVF9CkPnI05wiG27Tx2PLfWBMc7GQs1OdlUkaCx
         +6ARatafEBbmtgeeJjjwq47H8+RFnTQolhOSamce0KSfzsQ4gUI/GfBywO6JxO2A77gz
         qf5M9NwdUdpcuqFJofBcKH8njGfmNP5x2BDU7mJg5lOwvQgd6APJFRYdupX0QKzPtF7+
         mAxQ7qdMs1gfpX9193bVfk80zffdrFk7KIork/bS+756hrBax9BMHOTHwglOWu0xYxfj
         65Qg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4q5jvq/QIuH5nqyb1o/iLNQ3HhZ6pcH1NWsINPgHtT3pyxL15ud8aqaHsRNpjH/efguk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyza67MO+TUhRjYw3r6v89cGxKvcp05oWlwYIa6pwmO56dvY/Y0
	mVOgq6KqJx0CObj6zpeAn2rExP/GUlkmukdILcnxUb2Gv6KWy0qsi2nrMqNq/9UxZJZ9I4/qrGo
	LQIPg7Q==
X-Received: from plrp20.prod.google.com ([2002:a17:902:b094:b0:2cf:a0e2:93f7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26cb:b0:2c9:e835:ac67
 with SMTP id d9443c01a7336-2cfa74502e0mr91804565ad.19.1784914666082; Fri, 24
 Jul 2026 10:37:46 -0700 (PDT)
Date: Fri, 24 Jul 2026 10:37:44 -0700
In-Reply-To: <20260629183746.699840-10-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-10-yosry@kernel.org>
Message-ID: <amOi6HdZXL8C95AE@google.com>
Subject: Re: [PATCH v3 09/10] KVM: selftests: Support running stress
 save+restore and #PF test in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> +static bool parse_args_nested(int argc, char *argv[])
> +{
> +	bool nested = false;
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "n")) != -1) {

Since the test ends up taking args anyways, might as well have it take the number
of iterations too.

But, why make it an either-or?  If nested is supported, run the test non-nested
and then run it nested.  While I am sloooooowly working towards utilizing Vipin's
selftest runner, IMO this is still basic functionality that should be tested by
default, i.e. shouldn't require fancy opt-in.

> +		switch (opt) {
> +		case 'n':
> +			nested = true;
> +			break;
> +		default:
> +			printf("Usage: %s [-n]\n", argv[0]);
> +			exit(1);
> +		}
> +	}
> +
> +	return nested;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	struct kvm_x86_state *state;
> @@ -136,12 +188,24 @@ int main(int argc, char *argv[])
>  	struct kvm_vm *vm;
>  	struct ucall uc;
>  	u64 *pgtable;
> +	bool nested;
>  	gva_t gva;
>  	u64 pte;
>  
> -	vm = vm_create_with_one_vcpu(&vcpu, guest_access_memory);
> +	nested = parse_args_nested(argc, argv);
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
>  	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
>  
> +	if (nested) {
> +		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
> +		if (kvm_cpu_has(X86_FEATURE_SVM))
> +			vcpu_alloc_svm(vm, &gva);
> +		else
> +			vcpu_alloc_vmx(vm, &gva);
> +		vcpu_args_set(vcpu, 1, gva);
> +	}
> +
>  	pte_present_mask = PTE_PRESENT_MASK(&vm->mmu);
>  	pte_huge_mask = PTE_HUGE_MASK(&vm->mmu);
>  	sync_global_to_guest(vm, pte_present_mask);
> @@ -216,7 +280,7 @@ int main(int argc, char *argv[])
>  
>  	sync_global_from_guest(vm, guest_faults);
>  	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");
> -	pr_info("Guest page faults: %lu\n", guest_faults);
> +	pr_info("Guest page faults%s: %lu\n", nested ? " (in L2)" : "", guest_faults);
>  
>  	pthread_cancel(sigusr_thread);
>  	pthread_join(sigusr_thread, NULL);
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
