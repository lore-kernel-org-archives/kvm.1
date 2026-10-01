Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E533B9931
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885644; cv=none; b=JVsS9McjXG5ZQQdX+doSbXbGSMVgGhp2gHK86gjp/UzI6ES2SNKvEXDf322Keox7akLbTJUHoozQW8dHdLO6foYcKSqMtgtWmU8uzYJ/Uac/26uv0ULCCdi5icRw983tqHbUv0ZoGkxE6K9eYzBU8/xSEKtSBNrSAhXxEPMF4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885644; c=relaxed/simple;
	bh=9jDVroTFpMrKNa4oENyKHz4qYCXvrptO4EqjIDHt7aM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H8ezytWnaQ3QetNVVnfWNIn+fcXxTCexiUl8HIXb+b7pN2uXjCw4rLOTTnhPy3eOb+oNi2TBAp/7pTVLDiOnb5RwlxGOvD3pP01NPoB0ZePeSYwhiQJMu4LQDRcwcAvByo0g3N9j7Amf/2p3FZ2JvPhfQKGmyeb2AhanEUEgMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9SO+1ig; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9SO+1ig"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so37590885ad.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790885641; x=1791490441; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/30PgqyrtTRCdxPEBiCLZKlSeOkm5OSb0s4OxH0XUk=;
        b=v9SO+1igpUdqEw0sbQQ2r6J5/pw0frMOBk6SDhmBRmZRot066ZB+P/pUl1bCYQZEyF
         bFn8XvbiwI6w4RUpNwH4qfEogMhJ7IvKnPxTq6G0dMr6GT8t77kqhm1z+SKkgNNxEz9F
         3Yy+f2wKq9S+NfQj8npaCk344mO9F/CkwUd1BsF0Oczyko6zm3zQBFp2TKT010X+zzH6
         Qp8RNJYAPKzBiPfeF72VA1RjkXHH4w96KXYPoqyh8GnjuQs1iBqAl8mAzISXR7pm8zlM
         OFfgEPzmPqQWn8mQFbYR1MY8j+SGLtPPZPjs+DnfUR6Bz7GFUfX/1o3Nx4gR1RcUonUp
         fgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885641; x=1791490441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/30PgqyrtTRCdxPEBiCLZKlSeOkm5OSb0s4OxH0XUk=;
        b=yxm/iV8NJhPAhgsY+k0dffzWQpxWHWuTKqoKV0hfGYGl+6YDuq78f8dNR9Quz8u7w0
         yrS3WQb2MMYr6HIIYcIDQRUPKW58dIeX7a5x2B2EZyvXFpl9c8m1Y7W0RLZ68aFFyv7a
         mxUngec3Hp5oeBcIzXO326aHmQx+Q3CTWVhKZSZ8JN4Dip2CBc5cVeO6VWxWRndgIfrI
         QWfFGrsVgttkaB5ZIn6knWG+mIN326YfPGQyDyT7nQXSS9NrfGsa2/TSLv0oFbh0MycH
         CGkdYlW5qJ8vzmcoqnUUYOFcUIatzb293RtIAt/DAx7kWMOJXfWRV5O9KTBH+x16c1HP
         /VmA==
X-Forwarded-Encrypted: i=1; AKwUvBzt0TsES03tuE6GtWBnHjyiAutonrqwr8kRvO/xZ+O7CnruwECeXNUEVVylgB5VoDBTEi4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs112BPIO955UEoPlEIxAPXNYAg40JeAo71/s594697xfBTSRd
	Aab9vaZfqcyuzzY7YPhpAYHs6JDMe5vFRASEcDScAQ5mYo3nYlphy8nRhwxhCyzUAd55mHfOLoz
	VBRRZXw==
X-Received: from plbjj13.prod.google.com ([2002:a17:903:48d:b0:2e2:edf1:4104])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f608:b0:2e4:901b:9dc1
 with SMTP id d9443c01a7336-2e49b6ba182mr4575795ad.50.1790885640512; Thu, 01
 Oct 2026 13:14:00 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:13:59 -0700
In-Reply-To: <20260911191011.528460-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aqREBvLRKgD5cGgk@google.com> <20260911191011.528460-1-jmattson@google.com>
Message-ID: <ar6_B0Cj831UB-wh@google.com>
Subject: Re: [PATCH] KVM: selftests: Add test for shadow VMCS flush during
 vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 11, 2026, Jim Mattson wrote:
> As requested, a half-baked selftest. :)
> 
> I dropped stable from the cc list.
> 
> When a vCPU is destroyed while L2 is active and VMCS shadowing is
> enabled, KVM synthesizes a nested VM-Exit. This flushes the cached
> shadow VMCS12 back to guest memory. However, on process exit, do_exit()
> calls exit_mm() before closing file descriptors. KVM teardown runs
> with current->mm == NULL on a borrowed lazy TLB active_mm.
> Consequently, nested_flush_cached_shadow_vmcs12() writes the shadow
> VMCS12 into whatever address space is active on that CPU.
> 
> Add a selftest to verify this behavior. The test runs a victim process
> and a nested VMM process on the same physical CPU. The victim process
> maps a page and fills it with canary bytes. The VMM sets up an L2 guest
> with VMCS shadowing mapped at the identical host virtual address using
> MAP_FIXED_NOREPLACE. When the VMM exits with open file descriptors, the
> victim yields the CPU while the VMM terminates. This scheduling
> heuristic attempts to hit the race window where VMM teardown runs under
> the victim's active_mm and flushes the shadow VMCS into the victim's
> address space.
> 
> ---

FWIW, diff to get this working on the current kvm-x86/next.  I hacked it to use
VA=0x1000 for the "bad" mapping as the address picked by the kernel for the victim
was colliding with an existing allocation in the VMM (I didn't bother trying to
figure out where the allocation came from, didn't seem interesting).

diff --git a/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
index e0863ef20d3e..fbaba40ceefa 100644
--- a/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
@@ -45,18 +45,15 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
-	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
-	GUEST_ASSERT(load_vmcs(vmx_pages));
+	prepare_for_vmx_operation(vmx_pages);
+	load_vmcs(vmx_pages);
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/* Enable VMCS shadowing and set the shadow VMCS link pointer. */
 	vmwrite(SECONDARY_VM_EXEC_CONTROL,
-		vmreadz(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_SHADOW_VMCS);
+		vmread(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_SHADOW_VMCS);
 	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
 
 	vmlaunch();
@@ -77,10 +74,10 @@ static bool kvm_cpu_has_shadow_vmcs(void)
 
 static void run_vmm(int pcpu, void *target_hva, int c2_to_c1_fd)
 {
-	vm_vaddr_t vmx_pages_gva;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct vmx_pages *vmx;
+	gva_t vmx_pages_gva;
 	void *shadow_hva;
 
 	pin_self_to_cpu(pcpu);
@@ -97,12 +94,11 @@ static void run_vmm(int pcpu, void *target_hva, int c2_to_c1_fd)
 	 */
 	shadow_hva = mmap(target_hva, PAGE_SIZE, PROT_READ | PROT_WRITE,
 			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
-	TEST_ASSERT(shadow_hva == target_hva, "mmap target_hva failed in VMM");
+	TEST_ASSERT_EQ(shadow_hva, target_hva);
 	memset(shadow_hva, 0, PAGE_SIZE);
 
 	/* Add a caller-managed memslot for the shadow VMCS backing page. */
-	vm_userspace_mem_region_add_caller_managed(vm, shadow_hva,
-						   SHADOW_VMCS_GPA, 10, 1, 0);
+	vm_set_user_memory_region2(vm, 10, 0, SHADOW_VMCS_GPA, PAGE_SIZE, shadow_hva, -1, 0);
 	virt_pg_map(vm, SHADOW_VMCS_GVA, SHADOW_VMCS_GPA);
 
 	/* Override the shadow VMCS pointers in vmx_pages. */
@@ -156,7 +152,7 @@ static void run_victim(int pcpu, int ready_fd, int c2_to_c1_fd,
 
 	pin_self_to_cpu(pcpu);
 
-	victim_hva = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+	victim_hva = mmap((void *)0x1000ul, PAGE_SIZE, PROT_READ | PROT_WRITE,
 			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	TEST_ASSERT(victim_hva != MAP_FAILED, "mmap failed in victim");
 	memset(victim_hva, CANARY_BYTE, PAGE_SIZE);
