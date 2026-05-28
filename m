Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E1279DCC
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937019; cv=none; b=kIXDVNRSm7s99aPLwZY0FLkwXRrKf5NAPKyopaLaAcDEO+95S93PDPIG4m8l2hfuNIiW53R6RuNSz4sxEzmHirbIfdt+ZmxMED7n+sk4oGe2PfBIcLa549y3BzUPZbOPBIaWBwnVfEItpCJEmlbiCCWbANNQw7qSZw3MgyhbH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937019; c=relaxed/simple;
	bh=sSUE263pM5fCSFMCmXi9zpAfppmZLBicafOQwQzXNSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kb1eOmkcoK8yDRjNZjNQfWvzQ7RU3oyUOQmKxzeVjECB0bjlcV6ysNc5PZqZeqAfX/DFF7TL2/KMA92YcWgqvAxbd2L47CESO0BFVLMtVccKVaEG3YBekZFVMSzxZJmS6dsLSmekFIYmRuDgVzlwueUhyy37S2BjH+SMgApxRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqqhzyxF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqqhzyxF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beff6b6e74so7078995ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779937017; x=1780541817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfCR9CUr24LHfVO7c0KW/FkIupT+TiI46QESYSMQfE0=;
        b=SqqhzyxFKDM3Jfn3F4ctzxRx9gCtQVtrhilg81+u6srBY9p/2q+mwSaMeCnPNERC+d
         70PrhGcp89nKSnVQ6jEdefPl0JRLX1OwDEfefaEZ4ZWEqHVJMGk1H/80xvGwBDfM9dHJ
         mL4n1Yff1KtS5vcZXNBVGs0sGJ0DnPu0Ck2OfEZ/ZFdfuA7xQWcUp//zN+8ss5idVP6S
         ZPJUgoskJsDB2xCdMX+jCVsrDZbDJOu76NsrEZnFOQWGTYOEm7ShYoPREoinshHLsG4n
         zFSj6o8IjfEG5T7/bkayETTxL7pQVebets4w2mhAZsVcSBKZamE0/EQ3efKcRLOiWVSD
         HGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937017; x=1780541817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfCR9CUr24LHfVO7c0KW/FkIupT+TiI46QESYSMQfE0=;
        b=CIMuJsh9nWqX2jC8GFG3MB1RkbiFsxg8ehDEQcC991qrSmtYjGiROhVFxo1UJ/XBvT
         zFAGoGDjrV7H2JL9BW1Fm76CRik5DLH3n7O0NT94PcXK94rE/hah06RE4ZHJh38h9Mrn
         knnkP0pY2H4mWMIHJqCPqI2xHBCsTt6d7zVKYQNdggchHMxp2fhlpo2h6RbZmW3Gfddh
         gfuuMsL2u+4cV1QZbu40YDqRKZta3wFpg4dQnE9mVjs8Ml5Kjm+j6261rJM/QVTa700t
         RSA0i3rqD+H3WFGYwm/jf0sqqmTUSQbgcasrrOwz4+Grt46KXC418ogxk/pBWTx0K6Ze
         +tcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dg/IfYpui+66VvYP2bK68wNfS0sBsrKZw9BcY66fmQwG+HqD9mADvjy5ahJORRRVKCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RRxpP2BRyppdReXbuNI10R97u+WQz4eXbyTwsEZcxxQMReDG
	l3rwh1xHeZIE2TuGbqPVBx11l8/DSzwQfVcPjYcvNJdsSLG3y4m3x5aIBG1Nv8OcR7XW2dcxAWp
	F4o/7iA==
X-Received: from plqu16.prod.google.com ([2002:a17:902:a610:b0:2bc:c295:bdd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b10:b0:2b2:4d36:7ba
 with SMTP id d9443c01a7336-2beb058078cmr256874455ad.0.1779937017326; Wed, 27
 May 2026 19:56:57 -0700 (PDT)
Date: Wed, 27 May 2026 19:56:56 -0700
In-Reply-To: <20260527234711.4175166-16-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-16-yosry@kernel.org>
Message-ID: <aheu-KReRnd7qK1l@google.com>
Subject: Re: [PATCH v7 15/17] KVM: selftests: Allocate a dedicated guest page
 for x86 L2 guest stack
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Yosry Ahmed wrote:
> Instead of relying on the L1-provided stack for L2, which is usually an
> array on L1's own stack, allocate a dedicated page of VM memory for the
> L2 stack in vcpu_alloc_{vmx/svm}() and use that as L2's RSP in the
> VMCS/VMCB instead of the L1-provided value.
> 
> Most L1 guest code does not do anything with the L2 stack other than
> stuff it in RSP, so this change is transparent and the L1-provided stack
> is silently ignored. The only exception is memstress nested L1 code
> which puts the vCPU index on L2's stack, so update this code to use the
> newly allocated stack.
> 
> L1-provided stacks will be dropped and cleaned up separately.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---

Blech.  This exposed a nasty edge in selftests.  For tests that enable TDP, the
slots need to be identity mapped *after* allocating SVM/VMX.  Found out the hard
way: the gPAT test starting failing.

Not worth worrying about right now, just one more wart in selftests that needs
to be cleaned up.

diff --git tools/testing/selftests/kvm/x86/svm_nested_pat_test.c tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
index 392ede74589e..6798b1b9d910 100644
--- tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
+++ tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -115,12 +115,14 @@ static void run_test(void *guest_code, bool do_save_restore, int nr_iters)
        vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
                      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
 
-       if (npt_enabled) {
+       if (npt_enabled)
                vm_enable_npt(vm);
-               tdp_identity_map_default_memslots(vm);
-       }
 
        vcpu_alloc_svm(vm, &svm_gva);
+
+       if (npt_enabled)
+               tdp_identity_map_default_memslots(vm);
+
        vcpu_args_set(vcpu, 1, svm_gva);
 
        nr_iterations = nr_iters;

