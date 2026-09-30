Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8C4C33F6
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775621; cv=none; b=QkohyVtRk/6a2GhDwojR147GcmXsE5NTl9BTttgMKf6DG4Eg4q/KUyblbHXlkkMJ+s5fE6zIpa+XFBKMFmLKPk1x8nPvHa8p2gb8mvgy8zllQgDrA5hwoXToBWmcrjmU/SN+a9MPtz7asauuvsQwtaYevihIxMHMBmqOiLRRLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775621; c=relaxed/simple;
	bh=8WlU2Pp4Tblnh0B3ByiJ5CdsMxGlkBAiKBFIr6x6cu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOQIk6RC6uxVOMhI1XI1QI5cYLnUWW1FPGaWE+2CUBLk4PlBaUQcZ53svsj8x+qLqU8Pv9pU5qP/pYQI7bejdjT9sqbJ5vfbnQo9RNXyvYC04NyA5pUQqYIzG/6LMmxEf2BLwkv5gIBCq0ltgXScVm/9/BVk2GrlLbFbn3ed6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5Ey2+wC; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5Ey2+wC"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a74698972so4393328b3a.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790775609; x=1791380409; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TuQ5nRZHbUkS4XwzAQm9tdQMeatdxeR66kmNV9t4zvU=;
        b=a5Ey2+wC2JSHYPuWs0McBs3LqQgt2e8nmj8+zdnxLeyqUC7e/Aa4bYgCbA8nhTiSOE
         ihOY4AbOj3dRJekETbmdv1bYTU4yrWNsK6Gb/l4u3uReNYcUGk1j74Ins8rKXQPzUeDv
         u+h/TVo5w2A4V1oLdL2dSJZlzXrXhdgbULhfcKD0YJfrVjlBSLmS+yI0HQ5K5W1SzAvs
         heo9sIwjK1v6VSnsSDLU+x7HU9Tu4uxRbcZjDbLzh8KTxnGQq32hK0m+lIHJ6ejUv2K0
         /e0c/o/3zsZN4ND+YPBXTe3scUZIt3GQSGqo1CdmyMFEZ1m6ydtqNMkvKoEEDLzaKNxD
         VqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775609; x=1791380409;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TuQ5nRZHbUkS4XwzAQm9tdQMeatdxeR66kmNV9t4zvU=;
        b=gzsQnDMB3B1Y5qv4SAwjUTyepH7JuYQwqm1i6xyTyin3mM98OfyIeIv3cDWDha1fWE
         EpGnJ3boQ9vpunQHOQQ/eTS6ghwoIt2sUy1+SfQJVvPm9z4mTBkzQdeqZ97rsdCTrS7I
         RfRezM2JR6NtWu7S5H1bOtDJ2G1/+xFvf5eLEpg3hJZZafd1fTQcqcUb32GjAuQJhMpb
         aXaH7f292Lgv+Upk4qYvEJ+A+6vmBwyQ0DasZt5RTXICWdlb8w22EDwDMcDE19popM7t
         SbB8/Ih3pkZiZIG2pGrTy7LAiF4we4oQk6h9/ErVOJ8yzzAgifJiJlhGRhUCVCTYRO5o
         cwOw==
X-Gm-Message-State: AFuF++mF0I78pTwZWcMyI1Vh8AbCyJR8YUMudc4VuBJBsmk+0O1R3gYX
	+IzGPbRc0tdtHL+m9nO+FX9UE5TV6V5EOuBQAZZYEoBoAjoh8gYwd1UIQDSYIr+rgGk8uNNjbUT
	kKqEakA==
X-Received: from pgbcs13.prod.google.com ([2002:a05:6a02:418d:b0:cc7:b17d:4d15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:3b4:8880:2089
 with SMTP id adf61e73a8af0-3de9e8444ecmr1290324637.16.1790775608328; Wed, 30
 Sep 2026 06:40:08 -0700 (PDT)
Date: Wed, 30 Sep 2026 06:40:07 -0700
In-Reply-To: <ar0KIZ8HQEfIRvVJ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ar0KIZ8HQEfIRvVJ@sirena.org.uk>
Message-ID: <ar0RN3FICQ-PEqNW@google.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the kvm-fixes tree
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-x86 tree got a conflict in:
> 
>   tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> 
> between commits:
> 
>   b630929bcc4c8 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
>   b0bc51910f039 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")
> 
> from the kvm-fixes tree and commits:
> 
>   9b2f8146fcef9 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
>   a4bab1c12fd52 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")

kvm-fixes got force-pushed, which is what's causing the weird conflict.  In a
tree that hasn't refresh from kvm.git, I see:

  a4bab1c12fd528ccaafee00360e07463873404a9 (kvm/master, kvm/HEAD) KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
  9b2f8146fcef9faa73f9dc1bad9a8d6c585cfec8 KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt

versus the newer version:

  973ea70393e885e540f714904e51bc6cac80e3d7 (kvm/master, kvm/HEAD) KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state
  8abbc76120a74bfba1851bd97528099d715e45c6 KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
  b0bc51910f0391fea09c0a1d32352fec2acb2686 KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
  b630929bcc4c867c9abc8cd5a0ebee3bb5ce5dcd KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt

Ahh, I see the difference.  Paolo fixed up the Author:

  commit 9b2f8146fcef9faa73f9dc1bad9a8d6c585cfec8
  Author:     Paolo Bonzini <pbonzini@redhat.com>
  AuthorDate: Sat Sep 26 02:04:03 2026 -0400
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Sat Sep 26 02:22:15 2026 -0400

versus:

  commit b630929bcc4c867c9abc8cd5a0ebee3bb5ce5dcd
  Author:     Sean Christopherson <seanjc@google.com>
  AuthorDate: Sat Sep 26 02:04:03 2026 -0400
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Mon Sep 28 17:11:47 2026 -0400

> from the kvm-x86 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --combined tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> index ce204ce29a9c0,2ae698c9aa1ce..0000000000000
> --- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> @@@ -61,57 -61,55 +61,57 @@@ static void l1_vmx_code(struct vmx_page
>   		evmcs_enable();
>   	}
>   
>  -	prepare_for_vmx_operation(vmx);
>  +	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);

This resolution will probably break the final selftests build?  kvm-x86/next
moves these asserts into prepare_for_vmx_operation(), load_evmcs(), load_vmcs()
etc.  I.e. kvm-x86/next should "win".

Regardless, I'll rebase kvm-x86/fixes onto the new kvm/master and rebuild kvm-x86/next,
so this should go away.

>   
>   	if (hv_pages) {
>  -		load_evmcs(hv_pages);
>  +		GUEST_ASSERT(load_evmcs(hv_pages));
>   		current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
>   	} else {
>  -		load_vmcs(vmx);
>  +		GUEST_ASSERT(load_vmcs(vmx));
>   	}
>   
>   	prepare_vmcs(vmx, NULL);
> - 	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
> + 	vmwrite(GUEST_RIP, (unsigned long)l2_guest_code);
>   
>  -	control = vmread(PIN_BASED_VM_EXEC_CONTROL);
>  +	control = vmreadz(PIN_BASED_VM_EXEC_CONTROL);
>   	control |= PIN_BASED_EXT_INTR_MASK;
>   	vmwrite(PIN_BASED_VM_EXEC_CONTROL, control);
>   
>  -	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
>  +	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
>   	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;
>  -	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
>  +	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
>   
>  -	control = vmread(SECONDARY_VM_EXEC_CONTROL);
>  +	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
>   	control |= SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
>   		   SECONDARY_EXEC_APIC_REGISTER_VIRT |
>   		   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
>   	control &= (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
>  -	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
>  +	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
>   
>  -	vmlaunch();
>  -	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
>  -	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
>  +	GUEST_ASSERT(!vmlaunch());
>  +	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
>  +	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
>  +			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);


>   }
>   
>   static void l1_vmx_code_part2(void)
>   {
>   	u64 control;
>   
>  -	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
>  +	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
>   	control &= ~CPU_BASED_TPR_SHADOW;
>  -	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
>  +	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
>   
>  -	control = vmread(SECONDARY_VM_EXEC_CONTROL);
>  +	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
>   	control &= ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
>   			SECONDARY_EXEC_APIC_REGISTER_VIRT |
>   			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
>  -	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
>  +	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
>   
>  -	vmresume();
>  -	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
>  -	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
>  +	GUEST_ASSERT(!vmresume());
>  +	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
>  +	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
>  +			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
>   }
>   
>   static void l1_test_x2apic_intercepts(void)


