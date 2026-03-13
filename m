Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC37382F39
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382436; cv=none; b=BrchqvBPxbdym8WV+Y4w0zOSyTpcNg/0B7saTnncrfa3MEmjRfWLZamCPsIg+Lc2XF/+Swx8IiHtq34W8PLvXoGl9sxVtye/W9SerB2IWtCkQGMBo7RGDBz1DiQvesv6T14h7WmbnGgjH6QBwxieAXOn/hwbqIk196UFtfr2+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382436; c=relaxed/simple;
	bh=q7T7ZM6Tl29gC85LGwaTuH+syvZLFPTlKap80u9yuvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aEaU0f3sEtELYgaThbuEFF108BTo08kLdW7YPFD6MSsFcbNXs6MLQNyAjbEHNfJdDq5Z3Paur2V8KooGOXrmFgtLiHGd88edWpmkMk9S4l2gDGe9rFd5GTltrdTK3e0rlpVOpufPAkNOr6IRgrvCxYb9rAoz3VvA/vc3bs7gUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgFYdifa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgFYdifa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so2150458a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382430; x=1773987230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3aNezrU/0SWJmlPS/7C9/IAodmtbuXAL+hrYf+dJM0=;
        b=UgFYdifaWQyITjFoRfZkYw2HVv9vuJJso7i/x9r+rV16X9fFymEKa3sLl6aEdRf7HT
         oFk/+fLFEc8l927mKPZ/HHvoZLYp+UfNrVAJv6moFRYGBrBQ5+cAPwRE4XW6RrkKQv9M
         3d0kmsJ/GP73B4ZIluZ9aNA01np1sDtOpe4q9Lza3xO8zB/C+T6+hLKdsBNhHya//hoL
         40+6vEI3NQZ0szmGpslB+5aWCaCpDZdlUzroH0j2mLGrqcxutEOdRbaOkSMKqJWXjPqB
         yUz2NnSwrNWaX3Yl62B68SywYSLTRFtiPOC2/zWltRHKSOeHtWThOKa+MpvX8x39mIok
         oDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382430; x=1773987230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3aNezrU/0SWJmlPS/7C9/IAodmtbuXAL+hrYf+dJM0=;
        b=VNPFRUSlTC/YAPrz3vA/PvHCAtT3LAhCXgqhS79qTSunfQpLFkTRx5oGGZ5pQdBk/Z
         DfU9nrXUkjRuq4ZK8jFfNaxipjx0ED6rrCl27emH0bOkJ530nnPguGLeWQ1YEMRy4z68
         GpJuogezEXWoU8r7AkasZ2JDwBTLtRzdva70FPEBevukE0PBX/zztsxEdC5ec6RrtYE6
         bsU5Ok1OMHefPz3c3ZFVVJ9wqqT2Z6LD+7Ame4CWH3+bx+oAWYB6XRum9sRkfbFqUC9W
         Cl5ci+vB1cSfRrA68dkwSkkRkPVd4/5pZpnukaawz4du8gCpCAel3LmWlqtS1loj0+H8
         0+9w==
X-Gm-Message-State: AOJu0YzlEecLMeQyL1mCNGUvEzhavXnPOTgBYXNYkq9aUgfpLS9IJLfP
	AFREFNLI+AhbWJmU3251ArSDdwecdSzQyJXXoUYDQR/hpHtiXnIZkJkTw1i4OCLLsjRDR3CNT/M
	4uP/W/UcIwY1597Rsh8YdRPztEw==
X-Received: from pjvh11.prod.google.com ([2002:a17:90a:db8b:b0:359:82c7:183a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f42:b0:35a:26e:4522 with SMTP id 98e67ed59e1d1-35a11a6e854mr5613559a91.11.1773382429299;
 Thu, 12 Mar 2026 23:13:49 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:16 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3738;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=fumWrtosXoiY4bOOwcVjeexuh6Vm2zjygpTEl7sB3pU=; b=bV/2YPQeaUtgT8k3bUw9lMPPh89LZPCE9CbaoTgQbZMG2AuOkox0NLGeax+/GBTehdn2UPJ3F
 OlvqZWJ9B3FBXkjZk8Oojxn6Y59PEsKT+z2JB3W945OMYHALufF9tnC
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-37-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 37/43] KVM: selftests: Update private memory exits test
 work with per-gmem attributes
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Skip setting memory to private in the private memory exits test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Expect an emulated MMIO instead of a memory fault exit when attributes are
per-gmem, as deleting the memslot effectively drops the private status,
i.e. the GPA becomes shared and thus supports emulated MMIO.

Skip the "memslot not private" test entirely, as private vs. shared state
for x86 software-protected VMs comes from the memory attributes themselves,
and so when doing in-place conversions there can never be a disconnect
between the expected and actual states.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c | 36 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index 13e72fcec8dd2..10be67441d457 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	pthread_create(&vm_thread, NULL,
 		       (void *(*)(void *))run_vcpu_get_exit_reason,
@@ -74,10 +75,26 @@ static void test_private_access_memslot_deleted(void)
 	pthread_join(vm_thread, &thread_return);
 	exit_reason = (uint32_t)(uint64_t)thread_return;
 
-	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	/*
+	 * If attributes are tracked per-gmem, deleting the memslot that points
+	 * at the gmem instance effectively makes the memory shared, and so the
+	 * read should trigger emulated MMIO.
+	 *
+	 * If attributes are tracked per-VM, deleting the memslot shouldn't
+	 * affect the private attribute, and so KVM should generate a memory
+	 * fault exit (emulated MMIO on private GPAs is disallowed).
+	 */
+	if (kvm_has_gmem_attributes) {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MMIO);
+		TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(uint64_t));
+		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
+	} else {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	}
 
 	kvm_vm_free(vm);
 }
@@ -88,6 +105,13 @@ static void test_private_access_memslot_not_private(void)
 	struct kvm_vcpu *vcpu;
 	uint32_t exit_reason;
 
+	/*
+	 * Accessing non-private memory as private with a software-protected VM
+	 * isn't possible when doing in-place conversions.
+	 */
+	if (kvm_has_gmem_attributes)
+		return;
+
 	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
 					   guest_repeatedly_read);
 

-- 
2.53.0.851.ga537e3e6e9-goog

