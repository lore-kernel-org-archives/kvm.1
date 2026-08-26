Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F239B4A3
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785530; cv=none; b=Rk0zzTA938mLpXXEagIByHmcJXzFPVD3RCF2mElhy4L4Igv/+B0QSyYDUtiEcoPqQ2GnqpkIheiVeVxk1qo5Agmyq/Ko/00d0NS6dlSVstwNVI/gwijInGHYLYB+tmcfrpOTXGx7R8T9S0flbtEqvGb3sJJ4b8rRfbgIoG8DOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785530; c=relaxed/simple;
	bh=m3Lp8WMJLB/tampmgFN8ph5luv5ZjkhRNjnxAVae4ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdSWTUZxa4YATo8/E29dcMgE9wPBGTSwyHwf5IO9F1S32UIk4lPc8SPxV5qpyPFOh7Id+rKXVU0mwqYfg6Y0Dfyak6ZZajNLrhwCH1nRTSW/KJJC02ZeCCzao0Vi35OeaENCRY5Fjany+AXs+mbvDGDlvJCXhP+WkpVAdvfk3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCsNvrFm; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCsNvrFm"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e048a801dso2173201b3a.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785523; x=1788390323; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ypnv5ADnidmiHmk4i8NjwAmXQS3vAgk870JArYSva+A=;
        b=VCsNvrFmzwwOjwaZW6yMNLBk6X7MZvMd1W7hC74fgkPqVrRjfzh3EOeAKaILDgaYdN
         gg+EUnewdGXsrNw2zIzIP8v7drp4nJZnWdKQF1aNOdZw5Z5sxYA7AbKFQZiAwUDGuFWX
         tEaEzi5pS6OiWjUZjh6eqrDXCUsgxhKZKqIL6VYlN2ZSRIdUPIJs+7YGVWG9QjSKT4OA
         RedTabCTtaZjqyV7HK71vKy229CTPbXtrdhXm/j2og3t/WJTil3G12B+S1YNEMyS4B8B
         +baf6a33VHoeWgD/PbEJK/QoR1wO8sGmNQGGRhvtN816zyA1M+Zi5vvqIukZHJ+OTQvn
         R5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785523; x=1788390323;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ypnv5ADnidmiHmk4i8NjwAmXQS3vAgk870JArYSva+A=;
        b=ahenfgBC+zBRTYJb/fWt2iUAezKlLjrGhCnAQTlqr3WvQe364GM4ULTAjC6f4KToqY
         rtwEcQQ4EDZNzJt38lmOR0woGGsp2imvEfNYtZYvDfL7In1Rd5k+qV/qHxi6xeeql+c9
         PBPMOCa8jB6iK36H3w0hCYXQePNmw3Rhz4O1C6KjADAK32Hrpxv64dEs0/F3s00ZSvko
         A6nxxkcAzrSnL+0FiknDEcv0rTjo3SvZ4ET0xrM7lN3i5HOKZFPvY5vmqhgd1hblWN4o
         hDYid0z1Tr46nWmxDspsqKl/yb69P8ZA2MqZ3utDdLboLzvu6SwufAjAFILY3YM8mbIL
         p/0w==
X-Forwarded-Encrypted: i=1; AHgh+RrGq0b5xPJu2prmOa4VbIZj2LPcvfUBnmSgyTh5BOv9f79Ye8Gh+k7qSPm38uQPFe18NRw=@vger.kernel.org
X-Gm-Message-State: AFuF++kUx8EV4TFOt9Rf/9MxelL+RYIEZ/A3u5oVOXQvIwYkSHFptdb1
	SQz23EM4frZxi2cGDFOerIXA88GSGlVD/p+sbybx63txpbY4cnTpCoZf8MJXEU777R1VxGfxNkW
	PgYwXQg==
X-Received: from pghz21.prod.google.com ([2002:a63:e115:0:b0:cbe:ddc9:c670])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a110:b0:3c3:33df:4d9a
 with SMTP id adf61e73a8af0-3cf7596a65cmr18790428637.1.1787785522980; Wed, 26
 Aug 2026 16:05:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:57 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-7-seanjc@google.com>
Subject: [PATCH 06/20] KVM: selftests: Extend page allocator to support
 naturally aligned allocations
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Extend the page allocator to support naturally aligned allocations, as some
flavors of PowerPC page tables require multiple guest pages per table, and
those tables need to be naturally aligned.

Take care to align the potential base address *inside* the retry loop, i.e.
the base needs to be (re)aligned on every attempt.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b1c5597b1def..96c8251c224a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,6 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
+gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
+			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			   u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index bbf6d7684c0c..896da440659e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <unistd.h>
+#include <linux/align.h>
 #include <linux/kernel.h>
 
 #define KVM_UTIL_MIN_PFN	2
@@ -2032,9 +2033,10 @@ const char *exit_reason_str(unsigned int exit_reason)
  *
  * Note, success is guaranteed!
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
-			   u32 memslot, bool protected)
+gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
+			     u32 memslot, bool protected, bool naturally_aligned)
 {
+	size_t alignment = naturally_aligned ? nr_pages : 1;
 	struct userspace_mem_region *region;
 	sparsebit_idx_t pg, base;
 
@@ -2051,6 +2053,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 
 	base = min_gpa >> vm->page_shift;
 again:
+	base = ALIGN(base, alignment);
 	for (pg = base; pg < base + nr_pages; ++pg) {
 		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
 			base = sparsebit_next_set(region->unused_phy_pages, pg);
@@ -2077,6 +2080,12 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 	__builtin_unreachable();
 }
 
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
+			   u32 memslot, bool protected)
+{
+	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, memslot, protected, false);
+}
+
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot)
 {
 	return vm_phy_pages_alloc(vm, 1, min_gpa, memslot);
-- 
2.55.0.887.g758fc8c411-goog

