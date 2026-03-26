Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031913C9ED9
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568231; cv=none; b=rtk2XrMICIqE+gQMSYZ62y/zS8w3G0o38SlmjS7SMazY1Liceu+JQQD0JAOGEalFtKKFau9ui2UbaW31ikp8TARPTCBtW2+NNLCAJNal3NojR7LvgeUeVlgEu9CjIwl4GWhCoFQ9btjRUYpD6dGQ1zURn3hgI1SxD+ULeP2eVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568231; c=relaxed/simple;
	bh=lIGMTC/UU+uXAbXuWzKQ+RB//i4ISUTF/7wnJ89FeSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+VzvqvUnCrL+PszHSiipx7p5tyK7zGRUHtkK1A14TYuEZ9NVMq2uEaZ6F7aoZJv5noHlIOlQiFI/MRCY2tgaFRLiZuVEFCOPX7ALX8O3WGFQfFH7J0/aweEfykVbSI0ezvy5MD9gtsTZeSuyKnTZs3zXpyMmjV3jYB/ena8/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlwcVAdU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlwcVAdU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso3207637b3a.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774568229; x=1775173029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGHA+MoXXkOWLz+GDyK6vuU1BU5bAOng9gVTAO3EQWk=;
        b=VlwcVAdUt/436ouTuQUFd8v4TjBPa73KUxpx9aqSRK6dpc30IfMKzykbZ0PbeZOAM9
         vHUbnZDmC7Qksng/SJWxLBPVqlfX9w+MGkdoc9Gu9meQTIl3iRwg3jlqZCPv9BGD0WGj
         vG9x0abwtdXQnV50delK9ltQ3GxV1SensV6iv0jRQHTLqSr/aJrUFQ+agfuiZvJXnsf+
         m21VLVts3j9hMw2lhjYkbbhzUvLsVwaJ8QNI3qOY3koHvPPecfqALdlIgIBLwLfZYOrE
         XIRf700/vnVUKIzX5Bss4+JyVgUEoVwX56VXukcTclgzf7sI322ds7R/fS/rG5hDlf17
         s4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568229; x=1775173029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGHA+MoXXkOWLz+GDyK6vuU1BU5bAOng9gVTAO3EQWk=;
        b=Mu3sUKBAv0WhvAm1nrir/N3LBV8h70P+HeRhPKbpEoKlR2YVu5fv+b9TyD6gtTIrUr
         7jpQax1PcsQ60BuUtoMG/ikp5TTGgL8H7rgIL2SSjtGXj6BaIeyL1SEFd1WjAXv8SI+S
         8aGHxQs3Lx8LKhh2nmJzxXNVdlU2Sv/pQ1dC3XtYXqaeLQLbJ5bOCIYwzSnHZ5pUbpTd
         gMpBgAxFr1XFhuYP1weAoHTuy/oQX202uW3MXMnswkdxEUGjSnBWonDJZu5E4F4SBF2i
         d33o0ZtMjObTSuv22xSiCm0gfgUEzshZmAQHMPKLUKSLTFC0W9cqQTYiNLEDCw5uQOjm
         LzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAD3jKLQ88EzoQie4uUg70+IFHI8HKjJM3jVyPevZXHVfXDVillsk9mG7XyCzBorGbK7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIg+nlQKGYZOeJXM9ttrJzXu6W0lTOwOqs3NADMC2ZB9YWGjE
	WiSLg6Wr7RBMqgu4aJqJUkQKdT+xeQCFK7tx+r6DLPAKdiRMZv8Zo5HcCbAqpFg5TY/FHcEXu4P
	NlAziCicQmsXz7W2WNwxemoVOUQ==
X-Received: from pfbih20.prod.google.com ([2002:a05:6a00:8c14:b0:829:f706:70e4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4146:b0:82c:20be:57e6 with SMTP id d2e1a72fcca58-82c959d4d68mr331958b3a.11.1774568229229;
 Thu, 26 Mar 2026 16:37:09 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:36:44 -0700
In-Reply-To: <cover.1774568083.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <cover.1774568083.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <ca43f8054abe83d7fbca69c5b2f1a831f3cf86fa.1774568083.git.ackerleytng@google.com>
Subject: [POC PATCH 6/6] KVM: selftests: Test content modes ZERO and PRESERVE
 for SNP
From: Ackerley Tng <ackerleytng@google.com>
To: ackerleytng@google.com
Cc: aik@amd.com, akpm@linux-foundation.org, andrew.jones@linux.dev, 
	aneesh.kumar@kernel.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, chrisl@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, forkloop@google.com, 
	hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, jmattson@google.com, 
	jroedel@suse.de, jthoughton@google.com, kasong@tencent.com, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org, 
	seanjc@google.com, shikemeng@huaweicloud.com, shivankg@amd.com, 
	shuah@kernel.org, skhan@linuxfoundation.org, steven.price@arm.com, 
	suzuki.poulose@arm.com, tabba@google.com, tglx@kernel.org, 
	vannapurve@google.com, vbabka@kernel.org, weixugc@google.com, 
	willy@infradead.org, wyihan@google.com, x86@kernel.org, yan.y.zhao@intel.com, 
	yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index c40c359f78901..b076e0afc3077 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -365,7 +365,26 @@ static void guest_code_conversion(u8 *test_shared_gva, u8 *test_private_gva, u64
 	vmgexit();
 }
 
-static void test_conversion(uint64_t policy)
+static void vm_set_memory_attributes_expect_error(struct kvm_vm *vm, u64 gpa,
+						  size_t size, u64 attributes,
+						  u64 flags, int expected_errno)
+{
+	loff_t error_offset = -1;
+	size_t len_ignored;
+	loff_t offset;
+	int gmem_fd;
+	int ret;
+
+	gmem_fd = kvm_gpa_to_guest_memfd(vm, gpa, &offset, &len_ignored);
+	ret = __gmem_set_memory_attributes(gmem_fd, offset, size, attributes,
+					   &error_offset, flags);
+
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(offset, error_offset);
+	TEST_ASSERT_EQ(errno, expected_errno);
+}
+
+static void test_conversion(uint64_t policy, u64 content_mode)
 {
 	vm_vaddr_t test_private_gva;
 	vm_vaddr_t test_shared_gva;
@@ -409,6 +428,21 @@ static void test_conversion(uint64_t policy)
 	TEST_ASSERT_EQ(vcpu->run->hypercall.args[1], 1);
 	TEST_ASSERT_EQ(vcpu->run->hypercall.args[2], KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
 
+	/* ZERO when setting memory attributes to private is always not supported. */
+	vm_set_memory_attributes_expect_error(vm, test_gpa, PAGE_SIZE,
+					      KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					      KVM_SET_MEMORY_ATTRIBUTES2_ZERO,
+					      EOPNOTSUPP);
+
+	/* PRESERVE is not supported for SNP. */
+	vm_set_memory_attributes_expect_error(vm, test_gpa, PAGE_SIZE, 0,
+					      KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE,
+					      EOPNOTSUPP);
+	vm_set_memory_attributes_expect_error(vm, test_gpa, PAGE_SIZE,
+					      KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					      KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE,
+					      EOPNOTSUPP);
+
 	vm_mem_set_private(vm, test_gpa, PAGE_SIZE, KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED);
 
 	vcpu_run(vcpu);
@@ -419,7 +453,12 @@ static void test_conversion(uint64_t policy)
 	TEST_ASSERT_EQ(vcpu->run->hypercall.args[1], 1);
 	TEST_ASSERT_EQ(vcpu->run->hypercall.args[2], KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
 
-	vm_mem_set_shared(vm, test_gpa, PAGE_SIZE, KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED);
+	vm_mem_set_shared(vm, test_gpa, PAGE_SIZE, content_mode);
+
+	if (content_mode == KVM_SET_MEMORY_ATTRIBUTES2_ZERO)
+		TEST_ASSERT_EQ(READ_ONCE(*(u8 *)test_hva), 0);
+	else
+		fprintf(stderr, "test_hva contents = %x\n", READ_ONCE(*(u8 *)test_hva));
 
 	vcpu_run(vcpu);
 
@@ -441,7 +480,9 @@ int main(int argc, char *argv[])
 	// 	test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
-		test_conversion(snp_default_policy());
+		test_conversion(snp_default_policy(), KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED);
+		test_conversion(snp_default_policy(), KVM_SET_MEMORY_ATTRIBUTES2_ZERO);
+
 		// test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
 	}
 
-- 
2.53.0.1018.g2bb0e51243-goog

