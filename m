Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEB3C1411
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563930; cv=none; b=PhLg75WZNVOWjpbqJQAfAUyXqjhcsCGntKu6pVCi3JZJS38yGQVF3ybeSyIBMfIIUz2MYqKC0SvFI2p7n1hmYrcWridPkwZIO6hvprzzHqsR4YmcI3DCT0UixMXdXzbsRZu4TKFgf/Y+51VZVo8RkBovEmPOpyj/IRvb+XoYBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563930; c=relaxed/simple;
	bh=EJWEqTmrsqcShTogzYuHHUB7CpsDPadL7YI1wJxLFCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wp3EtIStJTC/ae9ub5g6kg3G02zOVNBAOo/m6pW/zdBTAhKWE5+b6Y6dS/19TNfesgmZ+ZmgMNgoiN1YuFH78HQXWOpGTHmBk7aKq1AK8JzpGEDMRPC0mmvUigAIFr6/9JqJaqetdVwqqRMKKOhZLy9hhdEPkS3aLlzttRo96Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FL1V894/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL1V894/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so1963235a91.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563928; x=1775168728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ggNswhhr/Zm517OANSqq2rkmE45vkRU03sHcZjDR0o=;
        b=FL1V894/67Qnw8yVSdMgQlcfwbov3WIhJNdTbHhEo8ZVi9X2ws1DKcLek6n9zJKm0G
         xh3BkjBRp+dlOnBaTJw02Gz2OqoX3o6+3vlLTD1TEhAVywHvZMnKoaJHUP5i9WT2WPfd
         dLxiswFagqLRq7EMSneLJ9JKFLYmA90KXfRkAIpTXcvm5L8iEKeVrSr8PQF3H+Xvt9eL
         EoDDNdkO54WoNJ42VXJlK34Y3Oq2dOMaKPjL06LYb1QcVVnaOTnfKIdZs59KQ6uflnkd
         gPqQG5wVP8ha4LEjxgIypCp8WmW/He5rFlFJmb6yLGWgAv3MM2LCAIei05RVlfXamWan
         lLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563928; x=1775168728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ggNswhhr/Zm517OANSqq2rkmE45vkRU03sHcZjDR0o=;
        b=KAHA+wukG5zehiXAsZ+AMWOKpFL1EUnNTgQO2NrpxQXyY9jYxKFP/QlG3Vo1VUqQa2
         GwvGiqkP9W8GWZb4KRSZQ8qR0MsTO2dD3jqAiYDOUKLXm69VgvX2m1rtE0GIPtwODu5g
         z4j7kqv+KCcwFkRDzJHq6oXLeCc/uTwknR8tLZBLXG5rlg0ts5PDTDSZ3KuLfieUdllF
         MzUQA+NU9cIA4Uv05jXYXf/ldyouELys8FHpWwvYLNPVn2DNLog3kR0MvT/5xYx3AtVT
         HFM7h89B5W0KsnUOvtjN/fz8vLBaSyXDWzrGMegFgiRAn6S2EP8nAS37ifbfFR6HRuBF
         ebgg==
X-Gm-Message-State: AOJu0Yw+NKetnyM7KM61GubKBrUbYkvD7P8EjjaL40939hi0nOt6TMeB
	ejmVdifc0AP/lUBclNvZjGkYtmotxNC6AeOhKbbnGEoDRCCY3aDwkFcmEduGHwAJpuI0p5/hA0J
	PP0raQNbxNmB/KITNhQi/sIU/9w==
X-Received: from pjnj7.prod.google.com ([2002:a17:90a:8407:b0:35b:a7ec:bdcf])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b09:b0:35b:91e1:e110 with SMTP id 98e67ed59e1d1-35c300b28c2mr201652a91.20.1774563927809;
 Thu, 26 Mar 2026 15:25:27 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:40 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3458;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=rCHdbveRHCq7Lbc/rPtcgMntFgrdjmRTxwCISj2xSoA=; b=94b8fZUYxxJIKK9M9r3xD06IQ9vXckRDERR0FGKGfKfHyQV+XY++9gfIYlhDE3CaPLXOwvElg
 etkz1NTy8bKCo8Ev2jmSLBQv/vyzxaNNaFAVWxjQJtFQibPkf6fSTHU
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-31-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 31/44] KVM: selftests: Test that shared/private status
 is consistent across processes
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

Add a test to verify that a guest_memfd's shared/private status is
consistent across processes, and that any shared pages previously mapped in
any process are unmapped from all processes.

The test forks a child process after creating the shared guest_memfd
region so that the second process exists alongside the main process for the
entire test.

The processes then take turns to access memory to check that the
shared/private status is consistent across processes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index f195a202b3785..ed310f26d88a1 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -334,6 +334,80 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
 	test_private(t, 0, 0, 'A');
 }
 
+/* Test that shared/private memory protections work and are seen from any process. */
+GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
+{
+	/*
+	 * No races are intended in this test, shared memory is only used to
+	 * coordinate between processes.
+	 */
+	static enum {
+		STATE_INIT,
+		STATE_CHECK_SHARED,
+		STATE_DONE_CHECKING_SHARED,
+		STATE_CHECK_PRIVATE,
+		STATE_DONE_CHECKING_PRIVATE,
+	} *test_state;
+	pid_t child_pid;
+
+	test_state = kvm_mmap(sizeof(*test_state), PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_ANONYMOUS, -1);
+
+#define TEST_STATE_AWAIT(__state)						\
+	while (READ_ONCE(*test_state) != __state) {				\
+		if (child_pid != 0) {						\
+			int status;						\
+			pid_t pid;						\
+			do {							\
+				pid = waitpid(child_pid, &status, WNOHANG);	\
+			} while (pid == -1 && errno == EINTR);			\
+			if (pid == -1)						\
+				TEST_FAIL("Couldn't check child status.");	\
+			else if (pid != 0)					\
+				TEST_FAIL("Child exited prematurely.");		\
+		}								\
+	}
+
+#define TEST_STATE_SET(__state) WRITE_ONCE(*test_state, __state)
+
+	child_pid = fork();
+	TEST_ASSERT(child_pid != -1, "fork failed");
+
+	if (child_pid == 0) {
+		const char inconsequential = 0xdd;
+
+		TEST_STATE_AWAIT(STATE_CHECK_SHARED);
+
+		/*
+		 * This maps the pages into the child process as well, and tests
+		 * that the conversion process will unmap the guest_memfd memory
+		 * from all processes.
+		 */
+		host_do_rmw(t->mem, 0, 0xB, 0xC);
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_SHARED);
+		TEST_STATE_AWAIT(STATE_CHECK_PRIVATE);
+
+		TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[0]));
+		TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[0], inconsequential));
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_PRIVATE);
+		exit(0);
+	}
+
+	test_shared(t, 0, 0, 0xA, 0xB);
+
+	TEST_STATE_SET(STATE_CHECK_SHARED);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_SHARED);
+
+	test_convert_to_private(t, 0, 0xC, 0xD);
+
+	TEST_STATE_SET(STATE_CHECK_PRIVATE);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
+
+	kvm_munmap(test_state, sizeof(*test_state));
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.1018.g2bb0e51243-goog

