Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08C366047
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563954; cv=none; b=Fp2r+6lGOLRWtIm8md2yRjSak9wESitN4eoidLVKDv0THJIim3jCnb0ZMePno63wGcODEBV35v0ngjWLlznihqqbobLOQn9gvkLNo8qagaU02aGyVfjAMpzA7ZsYBpAuPqGVZzRBm/pmYC6m111G3nh5p5hhCBkHYG7d5Kh0e9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563954; c=relaxed/simple;
	bh=NOYvJCvJhjhVLEq2W9a+wwzkL2/hh8Nje+0OmjG092o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZGOscdsXn6WeSuKDyfCcJOI9g6Dd3CeHK1kv6YtHt13EFt5O+mDDIsp2w+ZNeC3IHPTIv1mlrYhRqv5sZG9Y2nkA6kaJ/98LRjt3RmvhQ7x/SefqlGfO/TbeqdiG7UqR/6jwXPA5aV5Kdo6eLnG1Yqidb9NuAGoCB3qZXvtbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1W4cBpG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1W4cBpG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1902545a91.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563953; x=1775168753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5T3ttFXBFTFqoigTPXjqr+RtWpyGmHMkCotHkIzhdo=;
        b=P1W4cBpGvJ3FWit2IevugYuMNELdcYbFGFRM4l5QN5xQKiTJCmQJtBwjXKJXHkYvLX
         AH8SX+OLH8vX4RF6eXC6AMqFUWszi9mmO0oVphy5cITNW6Zcp1ZB4EkaMy3M72d6U8kp
         LVjvbCJEJ09r5n9fsVU/ul8V4EVkjmV5p3izJKF47ZZCjDGx+gHduC+IQjKNkQy6/2a/
         qAEuoerpkRUBmbuHZroYbj2HA32KkTx/SnmO+cBQt0J2IBZzg1FIJ8eYFv5bv6xvAZ4T
         yAxW60Fr6zJNbbcD/lolKWh3BGtsUKGvSRyAtiwuVxvaj0hUyOESbS7eqgExfcJayG4q
         B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563953; x=1775168753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5T3ttFXBFTFqoigTPXjqr+RtWpyGmHMkCotHkIzhdo=;
        b=Zwdz720yqwprxdLzDciQtOHeMkqL1Ckv4aFRtUmOnsLQ1+vINqvQ1ajSvGqA1tKQl/
         /84ZlNPrtHPxAMKcGw2F1K6R42M2b+hymuCsJD4oGshX6VzLeiyoM+RXq/2GVrW1/kG0
         ne0kV6J5hun8EprKrDb81ePBSo+z8PQ0sU2R/s5LmX8Uuok3NhrnAlpqZNJo6EKomJS6
         OG/lAtZuEj9Pi56CDSNG4ae8vGOMlNfR4SUVr59UBViALwgwF/1nQIz74t2qV8WXe3l3
         rIiNRMas3+BOXMHj+jB4fG7OSHvMLW1mRs//XwhK2CTjTQdnCt6r6PdQ6jBhb7EQ0qer
         iysw==
X-Gm-Message-State: AOJu0YzVejMFSBmflPtnl3j/a20SLF0nNSTRmo7RIbIv3wPUROqjLiD5
	HtQwe0QsPcfvtBH9kYZfcPPr2J1up9YnDqJmfjbkfABTWBxPOjfOYgHr8UlQjQ54Xwbc33fYl3q
	qCjNcTlv3L2NJgYjZ28A+5Mblrw==
X-Received: from pgac11.prod.google.com ([2002:a05:6a02:294b:b0:c6d:c043:2cb4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e88:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-35c30056d6dmr246000a91.21.1774563952777;
 Thu, 26 Mar 2026 15:25:52 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:52 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1225;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/YIcGPcW7wZJhSlI+0RZdLWi/pX7t9Ru6z34+pKDs+U=; b=nilaAfO0iV6blJ3/Lyvhk7nxY4Fc9srAhxHYkSRRNw5e5PdyvPo5CFKL2qtZRMYmb7vAg9rSY
 2VuzYa5m/+5CmT3FIb6yGX1IS4Jrr+PUe0wpNjgsMrimNMuC1aNLWIo
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-43-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 43/44] KVM: selftests: Update pre-fault test to work
 with per-guest_memfd attributes
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Skip setting memory to private in the pre-fault memory test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 3b2c4179d42ee..7b7352487fe12 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -187,7 +187,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 				    TEST_NPAGES, private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, gva, gpa, TEST_NPAGES);
 
-	if (private)
+	if (!kvm_has_gmem_attributes && private)
 		vm_mem_set_private(vm, gpa, TEST_SIZE, 0);
 
 	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);

-- 
2.53.0.1018.g2bb0e51243-goog

