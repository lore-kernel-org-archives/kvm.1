Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B33EAC82
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097015; cv=none; b=VoW9tMp8QYO7y9hfgiPV5Ky+8g1j52Ho4UQA7YrSV7tsL/UdyD0aMzJGJKSidRht1p7ryT8Co+9aReT2DICyJDPcsSQ3r9qaAzCpC+KAMJJbvtMfRW2Cvg97j77cg9qcbBxkxvraVly7Vw0GbYUeFKgC2qT5KYNnGsK/aJYtfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097015; c=relaxed/simple;
	bh=0yYslqANZr7F7xyw6UlV2QqcV1CLiunpaYZtbU4I8MA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p5wd1vl3zcl+btzAnANZ/a9gKvx+GwdZ1loJaDZjPbzMlE838lwQUos58HBglvJxpQM+t4NwI42yCllCm3STsE6XvkUB/FfPjyT/8z/kb5Puwaatp7I6baRYAitwnViW4AJLZFnazTsQl6rG/pnsVzb7WR7EtBfUa/aKR0nCVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2TpQQpG; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2TpQQpG"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bcf70e19516so181943466b.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097011; x=1779701811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=;
        b=s2TpQQpGaLR8eefmXOzBNHWP9KaG3NXQR2TIPzF7aQHmwaeftFBu7KISwvQNHPkfBs
         4d5FpXzfZ7gZRu53qC7vSgFzuyN8vd2+WQhxlTE9IhczmFuwBypKGW06hkKSPUhDTE47
         in/DwitH/LvEvqqIv4cromsbR2qzJQvwCrPA5Qmrs6sSkFF6N3Y+GUSUIerjZ31e8tdq
         PAS4WGzcCC2q5Y9RDFhwu1rKZz4/6JhwPOI04xrcRGc6vyET+SOQOii1wR45Ovhsx2hw
         x7ECNs+TPE4Y4y8eBCKiE9VZ9tCyWImxK5D90TePidzqAHD8vW2F2aFj4MO9Bpnt7SA0
         g9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097011; x=1779701811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=;
        b=SbeW5Na3ezNqGAXYGQ8D3ETX3vX6kEgQ8NpaGg+eBkBayEI/txtfGOascgQ5hiebs7
         XRNhaYaZodkT8ghFQiaH8p2kor55qtHKcM8h/0o54wnYmM3juWi6NsHoSRH826oNnHz/
         CqJnw+uhgcQ2I1ZTupyykMTc8jziFSN/c/Y5R+QKhYPASnygr/0l+ugYMb7lG0fJ5Dw1
         +gLMNPyYdXC2in0ay7DnLdazdrVrTGonqVA+QPPw0jLIjZYeMwVp5XmurUPao2btVv5i
         b3QhfQhh2NXpNb0efd9T3Z/Pn9v1sqjXVN0rE0CDgE2b+5dH+XBDca7IHvCRSM6wue7y
         o3gA==
X-Forwarded-Encrypted: i=1; AFNElJ/dbsbFNFqbB6bGqkJVV5/a4G1PEZ6de8HyMmKOjcu9/QLA2WLaCDTm/oBngyCSaXYzgRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbijs+qbiGGWipcth9sVzSq/NzAzmfeSaWDkRhg6dqWb7RAjH7
	jxupAAJlAyDCplikQBZ6LPSm5bpcLaOXfqnng7UGXnztPZNMW75lphPUUigt4lcITK8/DYfc++H
	RLqJWTIBE+IFSBA8Urw==
X-Received: from edcc7.prod.google.com ([2002:a05:6402:1f87:b0:67c:a74a:6214])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1b1b:b0:b9c:3d56:e4ec with SMTP id a640c23a62f3a-bd51797a576mr551071666b.24.1779097010457;
 Mon, 18 May 2026 02:36:50 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:38 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <8bf92f738d3456ea71ffe2a8406714e0d2afa114.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 8/9] selftests: kvm: Split ____vm_create() to expose
 init helpers
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
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
index 2ecaaa0e9965..d10cd25d0658 100644
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
index 2a76eca7029d..f4cd06d34ce9 100644
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
2.54.0.563.g4f69b47b94-goog

