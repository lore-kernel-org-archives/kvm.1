Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602F3CB56F
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909518; cv=none; b=ONf5mSJ64UqWjh0CFmq+bzAEaP6pWaIUFh/NUZ4/fdPhIRHaxjWN8V1apvsFVaO6EDJFhUYH02wMkluDQDZOgdS74y/aeAYa9G/vlcIDA1smCkU/qIOPMxWrhjF/dLYcY6skCn/fuzCmPjoBTUGO9Y5xzjsxEsaSYek3xkCz5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909518; c=relaxed/simple;
	bh=8X9Pt3b4HhtnYUSt2HOxZHNwbrEh8Z1iKaOic7de9uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/FAbd03IXTFniw3CKOq6dJnGBbwrz33xz6iJXlkWLT1pYY/j/no6jHCZBRSu6xKygdGuCZ0iu5ZdXszPxh/sNX6pVGX8TTK4Vjw98/w7gEJWFQfS4LwmIBqHEDTvDIpIOOW5TOt/QbAIQ1lVrmOkuuhvHqhsVde/gZqZLUKxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZeyHE6K; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZeyHE6K"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso752611a12.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785909513; x=1786514313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrrMpNZ3EbUZ0vhwBdXXhCA5baZrY7jz1a714Vgbih8=;
        b=cZeyHE6KmkuQKEDUs631bZvRMpJb9rKxngu10OM0iTHyFKgLKJRUDduCeZ5D3u1LFm
         1zOujJbzOtApZrhdzboboByvJ2xpZR0MVEkNebkQktxpX3kZ7Oa9ZpXANsZ2M2z8TJKK
         /ipQ3CNFkA//BHv7LQaLu2M+cSTJR2XnceiHkNEYWD3wuqQzn/xMA7cdpd5rrk4mcNCN
         PjRH1zSqRLGAqu33gULP/a5wYPmJiM7XEpNKaOLTdSLOgU4mYlzKdaJtB/cVxOI1eNqo
         88umjeO5yApbR96x9atJJiXhKGHgCOuehhAEtrHEyO3/IsqPDrff74Y6zY0oSdBAk3Dc
         hTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785909513; x=1786514313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrrMpNZ3EbUZ0vhwBdXXhCA5baZrY7jz1a714Vgbih8=;
        b=X3XUgyx3nImtkfhNEM3Meu+Wt8kNZQThq4RME3c17SUG7X95qwfrQB8015HYNBGkSx
         84tzODD/ll7X0YQzkZbp6HrexLTP+5t+cVn5bVhCtoslZm1JIJ0yaR2F28ZL7Lj3gv+B
         QdQJfAtb/cd4a3HO79d5LKKJWGsyBjFZ+wy5dxnrHOseCT0DtqMe18joAZeK1rns8BfM
         CKnx0TIwJB/aRQZu2s7AxEQbWk5O/rCPi0kU2uRHn+tBakxY7v6QOOea/Cer+QH6iZIi
         cW5Ceu3FXe2ARtkwoVQY0hlaKA6FF2uf+ESy2wBPuy0Z236C3+dTMDNGoVgwL3uLrtNr
         fk2g==
X-Gm-Message-State: AOJu0YyHk3J4CSrwgv+c8lmnu/g09KiwRgZW97pTqxOaDvxP9vih8VsU
	JY3AqzxFhuatpupGC3wSqXsP822mwpCnRfPGZCblG3zlujXEog9t65UX
X-Gm-Gg: AR+sD13ugNFGrKuia5/8SsDZhri8h6cKIFrcZm57uzsz5EhVCSaWKb6xYhL1/qOJ0ID
	+S6pwmvHaMy4siDQKxsohvMIBdPZzjMb1zNtbumkpkeo1Q8gxr8m/PfJNbPNjwZMae3U5Wl1nCe
	Olr9njqc0BImrQQ+hBIZs20UsT32QHiUwUSCflw33ZIxaXUFLJ5jg4/bOmc67t3xZZZ87iFdjFN
	/FQKpvBvMhtgmeBvQD9ZtV143Y9chGetrV5d2Xkq25DOtQp/tr44D33eRWh8gjUVeIJIdfD0WaB
	r3/4+csKW2zL8AwzN8FCK/Y+4ZeuYFzVBQWj7Hu2mSX2FeFi1h7Im5MCaxVcZW6JmDo3oxtYT4I
	4x4ZvdIXFwEHe0+QPNjMs9/ad8vte8n6NuBiNb46FUsZJ1y5G+Gdexkb96wNv4CP5QymrH77igo
	x6e1Skbz9CeBeIiBgieltS89hKAgWqGFhuTxdNw+rMurlaLUQhRkVsR8ZRca0mrbk488RJv0OmA
	9XGvPwAG5xaoY3BaXldFmCd9A==
X-Received: by 2002:a05:6402:1cd0:b0:6a0:a644:355e with SMTP id 4fb4d7f45d1cf-6a14f0a1306mr2074623a12.2.1785909512786;
        Tue, 04 Aug 2026 22:58:32 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.148.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a145de6b07sm1305396a12.16.2026.08.04.22.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:58:32 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: [PATCH] KVM: selftests: verify toggling KVM_MEM_GUEST_MEMFD on an existing slot is rejected
Date: Wed,  5 Aug 2026 08:58:30 +0300
Message-ID: <20260805055830.740175-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_memory_region_test covers creating a private memslot and rejecting
overlapping private regions, but nothing exercises a FLAGS_ONLY update
that toggles KVM_MEM_GUEST_MEMFD on a slot that already exists.

Add test_toggle_private_memory_region() to close that gap. It asserts
both directions are rejected with EINVAL:

  1. clearing KVM_MEM_GUEST_MEMFD on a private slot;
  2. setting KVM_MEM_GUEST_MEMFD on a slot created without it.

Both are enforced by the flags mask in kvm_set_memory_region():

  (mem->flags ^ old->flags) & (KVM_MEM_READONLY | KVM_MEM_GUEST_MEMFD)

which gained KVM_MEM_GUEST_MEMFD in commit 9935df5333aa ("KVM: Disallow
toggling KVM_MEM_GUEST_MEMFD on an existing memslot"). Before that
commit, direction 1 freed the old slot without calling kvm_gmem_unbind(),
so closing the guest_memfd afterwards wrote to freed memory; the fix
commit records the resulting KASAN slab-use-after-free in
kvm_gmem_release().

The test runs only when KVM_X86_SW_PROTECTED_VM is available, alongside
the existing private-memslot tests.

Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
Built and run on x86_64 against a 7.0 kernel; the new subtest passes.

 .../selftests/kvm/set_memory_region_test.c    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index a152ab65c657..8fb2e7a96f6c 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -500,6 +500,50 @@ static void test_add_private_memory_region(void)
 	kvm_vm_free(vm);
 }
 
+static void test_toggle_private_memory_region(void)
+{
+	struct kvm_vm *vm;
+	int memfd, r;
+
+	pr_info("Testing that toggling KVM_MEM_GUEST_MEMFD on existing slot is rejected\n");
+
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
+	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE, 0);
+
+	/* Create a private slot. */
+	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
+				   MEM_REGION_GPA, MEM_REGION_SIZE,
+				   0, memfd, 0);
+
+	/*
+	 * Attempt a FLAGS_ONLY update that clears KVM_MEM_GUEST_MEMFD.
+	 * Must fail with EINVAL. Before commit 9935df5333aa this caused
+	 * a slab-use-after-free in kvm_gmem_release() because the old slot
+	 * was freed without calling kvm_gmem_unbind().
+	 */
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, 0,
+					 MEM_REGION_GPA, MEM_REGION_SIZE,
+					 0, memfd, 0);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "Clearing KVM_MEM_GUEST_MEMFD should have failed with EINVAL, got r=%d errno=%d", r, errno);
+
+	/*
+	 * Symmetrically, attempting to set KVM_MEM_GUEST_MEMFD on a slot
+	 * that was created without it must also be rejected.
+	 */
+	vm_set_user_memory_region(vm, MEM_REGION_SLOT + 1, 0,
+				  MEM_REGION_GPA * 2, MEM_REGION_SIZE, NULL);
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT + 1,
+					 KVM_MEM_GUEST_MEMFD,
+					 MEM_REGION_GPA * 2, MEM_REGION_SIZE,
+					 0, memfd, 0);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "Setting KVM_MEM_GUEST_MEMFD should have failed with EINVAL, got r=%d errno=%d", r, errno);
+
+	close(memfd);
+	kvm_vm_free(vm);
+}
+
 static void test_add_overlapping_private_memory_regions(void)
 {
 	struct kvm_vm *vm;
@@ -645,6 +689,7 @@ int main(int argc, char *argv[])
 	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {
 		test_add_private_memory_region();
 		test_add_overlapping_private_memory_regions();
+		test_toggle_private_memory_region();
 	} else {
 		pr_info("Skipping tests for KVM_MEM_GUEST_MEMFD memory regions\n");
 	}
-- 
2.53.0

