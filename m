Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28612F8EB0
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394597; cv=none; b=mWd/XjdK2rC5lndX/HuMqMffiu3RkcEnG7QYYyY6ppEo8IwWjgI9XKmMta/Hmq/fdwLbB56/c8n/rxXh6GZcU6qewpR5lcqw6myOyfe4q1QOHbaGD0Z2rxMb8Hm8l233Snuplu1EF1AaFxzpNLl+S0kB/qLoabtJncQVappGhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394597; c=relaxed/simple;
	bh=2wdycaWyTr3wHjL46Oi7oUlErQKHgg3C2UWG7nXhvBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i29N+lumLB0YdKqnQkOOUUqHCTQGw0ln/S7R0sbK8pd973fvG9e6fThdKpEyTEHeXFvNBuSDfL68IXw3DXBQLjJPmZBInlAop1r8WUdV3sLOxPlp3kFVXDq5UckHsP/44VzcQv3UXynIxlfUIx61IKxJ9hLVXjZId82Y9hV09uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sdv6u0ly; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sdv6u0ly"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2427005a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394595; x=1788999395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=en9sy2X7KNJ42ALulbCcGpogsZZzDqcq6AiqI0KX/uU=;
        b=Sdv6u0lyuMlDJdqei9v0UlsqAwJJ/ttVCKQAzL+ullg8pQNkvFrcITscBmgTsXu1Sy
         aeXbgwUWnDBzQpfLxh9xjIhaEBEraUsF1IWXbQ4p4t5a8PvlbSwHeRRA168bEzRzLR3y
         bmTs3zSJU0VZSdB+vOpaxoS9kTxzlwe8gzNDB1gS0RudJEXqj1aqlWFdxcCcFKtrJXRi
         CIIKNOthZ3DGD21gqlkfgkz/e/QwRl5efuYGK0njOpuzeCkNvfX6HDnE0hXpkS1FKpkA
         M5uBQb8Mn3flexMNdRXTIpgthFFQztxKzn7dQzucyWU76DFfIx8FOkY3ew5NxiSfjEuf
         LlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394595; x=1788999395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=en9sy2X7KNJ42ALulbCcGpogsZZzDqcq6AiqI0KX/uU=;
        b=flH4djyshFCWrUWLuyWrRBxxPL8bqz+0P61PVAoAlIYMD7qU3W9AuDCnUfYO9+h60n
         LOjx545HRmcdC2ZaLWQcyGyBX108++4TQ6TAxJqihXMHXwdzyuLgI6Qr5y2yK/rS6B8P
         GDSvjukoSI8ZJ67del4osJGBIth5Io2AURncMzatyIEAvM7fVp6Rw7hQLLyvfEb9y5S3
         CsLGXaTS6h0yipZx/xCnI/xcSGYmnqiQfEkUu0ekvqCm9IFNGppYes1J3sqocF3bc+9b
         ItKsmyvWhYbEYJNp3npkmKu13Y/SdNm69MgttwXfk93MEwHQvWELjN9flNKveaJsxw0i
         Hj/Q==
X-Gm-Message-State: AFuF++kL3HuO7Cc/FFcn9TMmDUK7BcAVjeu9a+dYXvUl/N/gk5zkkJjf
	xZXF8JJV6lckVAqtvpxX16x4ZWIafThrB/tUz2CJQU3IdN0NMty+iemm+vNXtVE47yF5JXMBpwT
	NYPrBmg==
X-Received: from pjqd9.prod.google.com ([2002:a17:90a:a689:b0:398:d766:b8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8d:b0:398:c292:ac80
 with SMTP id 98e67ed59e1d1-39aedf55732mr11951831a91.10.1788394594927; Wed, 02
 Sep 2026 17:16:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:24 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-7-seanjc@google.com>
Subject: [PATCH 6/7] KVM: selftests: Automatically run xAPIC IPI migration
 test when possible
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

Rework the interface to the xAPIC IPI test to automatically run the
migration testcase if at least two NUMA nodes are found.  The test exists
specifically to validate KVM's handling of migration of the APIC backing
page, i.e. forcing end users to opt-in to running the test in migration
mode largely defeats the purpose of the test.

Run both the "sleeping" and "migration" testcases by default, e.g. so that
the more basic testcase will fail if KVM completely breaks IPI delivery.

Keep the -m / migration parameter so that infrastructure that wants to
specifically test the migration case can do so and not get false passes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/xapic_ipi_test.c        | 40 +++++++++++++------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 42c601617f5a..c5b506eb5e7f 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -245,14 +245,13 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		delay_usecs);
 
 	nodes = kvm_get_numa_memory_nodes(&nodemask);
+	TEST_ASSERT(nodes > 1,
+		    "NUMA nodes disappeared?  nodemask = 0x%lx", nodemask);
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
 		"(each 1-bit indicates node is present): %#lx\n",
 		BITS_PER_TYPE(nodemask), nodemask);
 
-	TEST_ASSERT(nodes > 1,
-		    "Did not find at least 2 numa nodes. Can't do migration");
-
 	fprintf(stderr, "Migrating amongst %d nodes found\n", nodes);
 
 	from = kvm_get_next_numa_node(nodemask, -1);
@@ -351,26 +350,17 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 	}
 }
 
-int main(int argc, char *argv[])
+static void test_xapic_ipi(int run_secs, int delay_usecs, bool migrate)
 {
 	int wait_secs;
 	const int max_halter_wait = 10;
-	int run_secs = 0;
-	int delay_usecs = 0;
 	struct test_data_page *data;
 	gva_t test_data_page_gva;
-	bool migrate = false;
 	pthread_t threads[2];
 	struct thread_params params[2];
 	struct kvm_vm *vm;
 	u64 *pipis_rcvd;
 
-	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs);
-	if (run_secs <= 0)
-		run_secs = DEFAULT_RUN_SECS;
-	if (delay_usecs <= 0)
-		delay_usecs = DEFAULT_DELAY_USECS;
-
 	vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
 
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
@@ -458,5 +448,29 @@ int main(int argc, char *argv[])
 
 	kvm_vm_free(vm);
 
+}
+
+int main(int argc, char *argv[])
+{
+	bool force_migrate = false;
+	unsigned long nodemask;
+	int run_secs = 0;
+	int delay_usecs = 0;
+
+	get_cmdline_args(argc, argv, &run_secs, &force_migrate, &delay_usecs);
+	if (run_secs <= 0)
+		run_secs = DEFAULT_RUN_SECS;
+	if (delay_usecs <= 0)
+		delay_usecs = DEFAULT_DELAY_USECS;
+
+	if (!force_migrate)
+		test_xapic_ipi(run_secs, delay_usecs, false);
+
+	if (kvm_get_numa_memory_nodes(&nodemask) > 1)
+		test_xapic_ipi(run_secs, delay_usecs, true);
+	else
+		TEST_ASSERT(!force_migrate,
+			    "Did not find at least 2 numa nodes. Can't do migration");
+
 	return 0;
 }
-- 
2.55.0.970.g62bdec98f9-goog

