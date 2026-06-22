Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534D348C71
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154155; cv=none; b=VfbMcgmb5XZOLtT4/Zpu6Wb+m4a8PP9awRr34CI1aIJyZzYOiWkcFyAwQ7/fIElMIW6X0EgWK8jypeQtXOPcn0UcUC7FhKRKnr/rhwTY0aLMpcvWENqFP+UZRH3bHlTRZa49ofdoilL0as7EjYSrn+YqPbzcCj6sdIT3vsN82ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154155; c=relaxed/simple;
	bh=iHAqWYoDEqoYF8IdRYlPpusH94MBu+nlDh/yTyijiSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FGUglEnWgjzIX14tHC5HqNa3pX7Yqht8U7AnNq9w7/gZnY9Ok27++nsSfTik/7vCp2NtcWeOuTxkF6x4G124C8jVUGY/NK7edmaMnjwlEqpSrGkNZ4SQhX40Y3A7KtLRCRPB4XlHsBKJpb4B+Eg72Y0gTnc5yzqCz/g8u7ZNdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvYl67L6; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvYl67L6"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-460153ce644so2915636f8f.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154150; x=1782758950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hLQE11StkUlK0CTXqXjUU/EPcv0l0L8NQfDoUdv0GQ=;
        b=bvYl67L6HP+/VYjgUXzBFWr49f85tzRcutXO1SLMoEsi12d6LQmf6Q+5d/65J8+nPB
         J2oZ1CHlqAu6FJw689bx0MXcDZAkzk002X9IseOF8tOodC7LgDLAQ6jqto9bE8yGScHl
         QgI7jdA5/G773UwabkTG2vFZjqYmi2m/y+Y0IpFUiR9WtcDSkmV3Ah6lzfpbl+cQbr2z
         hhX+r4m1V3kYcSDZ4rtZcCu8ExmtxG3KiGkHvNWxC3PCLIfRK/Ublf65Rd1kHvxUMKzn
         tfVkUSovBAqylVEEgPv52LX9P0ldXzMxjslmzUwSgxuPoihWKkx3RgS9wRa3aNl6LS1M
         0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154150; x=1782758950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hLQE11StkUlK0CTXqXjUU/EPcv0l0L8NQfDoUdv0GQ=;
        b=kmvqrPbwOfSHPZv2h6hTuDazwFfNNTkPdz3icu0CDfYRmrnV42cSs175OhOnjImRyg
         fT+AI/ZD6AtWvL5AxkpsaXyV3gqxf2l5gB9r9iCY1p8+TL8ks1qwgp75LjaiiG0A0kS4
         vLARIYBwIBmRyelObzlDCVHf2IUHOFcW0uPnjWZI39aOfqxrrR0bSmcmgs/oZ1XP3NYO
         8M2aAD3wBVEbJJ9FpQRegbdHFhUYy16t84SQiHIeLFs3Ndj9S1o9++XiqcelVziEkE6w
         mKj3EktkqIZXwdJVnErkqNRHPl1e1LmNod6Lda0WkizJh5MqR2XPiZa6AOJ8UYzAI5/m
         8Zyw==
X-Gm-Message-State: AOJu0Ywjz8i8twV/K6PbWFzA9kk7y5mI2vzjWaRQyjFiAb1ES2z0oIlu
	pjAYPwzQeBV0XkpyzW3g+NdQcZ3BmG/UzSzRz12mR7pTW6QOPnv7O1hy0FwA2a1yqR5vPC+MSTN
	4Yw0skxvgelB0WZuWpQ==
X-Received: from wmat25.prod.google.com ([2002:a05:600c:6d19:b0:492:52c9:b1a7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-49242189b1cmr243494115e9.0.1782154150022;
 Mon, 22 Jun 2026 11:49:10 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:50 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-9-tarunsahu@google.com>
Subject: [PATCH v3 8/9] selftests: kvm: Split ____vm_create() to expose init helpers
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor `____vm_create()` in the KVM selftest library to extract its
initialization steps into separate, reusable internal helpers.

Introduce `vm_init_fields()` and `vm_init_memory_properties()`. This
allows advanced test setups to perform targeted VM fields or memory
property initializations independently, which is required by upcoming
test cases that restore preserved VMs. No functional changes are
introduced for the existing tests.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 +++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a9101..88de0e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -471,6 +471,8 @@ const char *vm_guest_mode_string(u32 i);
 
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape);
+void vm_init_memory_properties(struct kvm_vm *vm);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 int kvm_memfd_alloc(size_t size, bool hugepages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fd..dc576b8 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -276,13 +276,8 @@ __weak void vm_populate_gva_bitmap(struct kvm_vm *vm)
 		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);
 }
 
-struct kvm_vm *____vm_create(struct vm_shape shape)
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape)
 {
-	struct kvm_vm *vm;
-
-	vm = calloc(1, sizeof(*vm));
-	TEST_ASSERT(vm != NULL, "Insufficient Memory");
-
 	INIT_LIST_HEAD(&vm->vcpus);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
@@ -380,9 +375,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	if (vm->pa_bits != 40)
 		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
+}
 
-	vm_open(vm);
-
+void vm_init_memory_properties(struct kvm_vm *vm)
+{
 	/* Limit to VA-bit canonical virtual addresses. */
 	vm->vpages_valid = sparsebit_alloc();
 	vm_populate_gva_bitmap(vm);
@@ -392,6 +388,20 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
 	/* Allocate and setup memory for guest. */
 	vm->vpages_mapped = sparsebit_alloc();
+}
+
+struct kvm_vm *____vm_create(struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm_open(vm);
+
+	vm_init_memory_properties(vm);
 
 	return vm;
 }
-- 
2.55.0.rc0.786.g65d90a0328-goog

