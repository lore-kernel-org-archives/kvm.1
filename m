Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5548B373;
	Fri,  6 Mar 2026 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831353; cv=none; b=kYuC6v+tKWQ5TaD6AbWYJ2Nxcl5gzWlKeyy5g/kbRaQupIc+SOD/af+owgnIJU5PS9GxCt59XSSCzth7D5MEVI/NDX8QkvzNhP41Ar28Px/FuGMk5cDHBfuSUPLwgSCFMhmZRykQCtasNm7eWxpTqrapodo4Z1QcgfgR8km6KDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831353; c=relaxed/simple;
	bh=PQv0YwZqQyXkAMWT1d1pHmZWI0WGoRIBaeSq8Yg083I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmrGBhOcgq+FDH4cIhzJBMB5zJYi2OEBpRtH+J1P0aHoOx/4ICzGTuGBKq49brW6yaxk+VIFJ9rxhqPGtoM/Iu0Ft9nt/ttWbOAlMDj1uXt12Odb1vD+FHY3V+BhgDf52mYJgHVtRyAjitc9iZf0VXeYrgnAxoYjbmr7VxBz7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxhsvnsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxhsvnsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C6DC19425;
	Fri,  6 Mar 2026 21:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772831353;
	bh=PQv0YwZqQyXkAMWT1d1pHmZWI0WGoRIBaeSq8Yg083I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxhsvnsjaqg33dt6rqlGrxnbtjjA4ebttt8pEYpK8RzwwjCe13X+u12pN7Ay9d7J0
	 bO7dHhHtDIrvUibi/mx/6Hn+OGDaG/AkhtGVceDkLyhJH6e/nnuRVDy6+SqpeOBllu
	 gZYuOwiNnOsr+7BbaT781amjAGmS+YyCSXSSFr9AIGSJFk1aCGd0+vyBI2xniMJDCA
	 J2Yn8LDjFMxANyZvSqo0Der7uf4Yj8JnrEOf5DgPcHIO26+uBsE5aq851AEfgAPajr
	 5D2y8U7iZGtPpZ6bCcqAs42fXfwCoV8THtJ89eCYgbrsu98fSGQ1er3h5GXDu1dfRP
	 Z4mMb9hmnnJAQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 6/6] KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name
Date: Fri,  6 Mar 2026 21:09:00 +0000
Message-ID: <20260306210900.1933788-7-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260306210900.1933788-1-yosry@kernel.org>
References: <20260306210900.1933788-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test checks both invalid GPAs as well as unmappable GPAs, so drop
'invalid' from its name.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 ...{svm_nested_invalid_vmcb12_gpa.c => svm_nested_vmcb12_gpa.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/x86/{svm_nested_invalid_vmcb12_gpa.c => svm_nested_vmcb12_gpa.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ba87cd31872bd..83792d136ac3b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -111,9 +111,9 @@ TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
-TEST_GEN_PROGS_x86 += x86/svm_nested_invalid_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
+TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c b/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
rename to tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
-- 
2.53.0.473.g4a7958ca14-goog

