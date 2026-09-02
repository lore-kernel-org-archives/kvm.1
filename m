Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D04ACC90
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367297; cv=none; b=mtcj/XvvGffMBBVVNw649Dcq66Ltf06wEkxdc3m3bbcsFJTryEBIb0fmPMEf0z/aNw2Tq2Kj7kkISZGRw/n5R6dSbYyx93jPU5Pl0Uj+WuXkj+48y9FQz80g7Wj3mIob7rs/yYIn4vH4tE+umavyhkaITsz5yviw+4hC9CgA98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367297; c=relaxed/simple;
	bh=wsoBQD4qq6Et3vmrWdvEDcU5mPTJSW7kE60nWbUUw1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNfApxBtzHq0HtrP7E0ULNTHuUtiSU3bKZfNFdrABwHHR2Qb1VV027GqV+gNXMV8ghJvq26sIiNS1ZNB8CqVPWY6aLlgVWAn8qzxDj7hOKPZlprXcfP/+Ve5d/eXQAFPDv8S6+DV9eJXTEq2Z0Br2svBU+kVbam4JyrJiWOra1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CoDV/rMi; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoDV/rMi"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso2514908a91.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367292; x=1788972092; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PFS8FckNWR5Ypo1TjtxFOP+XgfwND0gTpHBze+LVvng=;
        b=CoDV/rMi3wXQcIFfpDJEJwOSFcAe8AwHgQYhqSKnx37lPTzLE8BwcctmfTf7fTmuxa
         cbrbaE36fua4gM4G50OaPdDtl9TOGfqqRo8IuqTjDFCRxGdKCbaR0UaeKDn5rJzT4sYA
         nW83hlnQrYoDvedAsnVxrYX2nIcoUeuQd7upTg9XHgN0YY91iL75AH2BuHvSuDXO30nW
         Y5RM0VG32hhMkh+WIlcXNdwXfjHx+Ywj8fea+bp6CDQF+AJkKoGNOVFaHshdct7sLksq
         w1A7vN42/NzUcYMsfHYUO2/UtrPmJI4sWxxcr0fJ6gmBRGlLaQ5uQfFLxCnQvuecRxpU
         1+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367292; x=1788972092;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PFS8FckNWR5Ypo1TjtxFOP+XgfwND0gTpHBze+LVvng=;
        b=fYgetZtg7fITbXxgec2NFFSC9aCOM3LPoKTkdSTEwSxJGVBqrXs4B+Q1qwytlEHZXa
         rk0HWOpk/B60RWJPyvBDeZHE55UTy074ZkPc2/zVFBvRDbNWdb3Ht+cXpwZgTIAepWVG
         5+3t42XG2WAsESz8TNysWIV24ezuS6snMhnrnbqfg3cwtSyPlgkPKsmrPVynPJKiJMRt
         JDu+m/5bwshCuH+gI1Uc1Kr6GmKheoycZDK48cNSWbVB0sJBH1GtdpLisBXSE3MAx8CI
         Z5VuoRzybI2QmOrHwyRUKi99nEl55b/6EI59aSvwRkZOUnhL/eRdDJDd0Rr+YNFaf49P
         4afQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPnd549kYcLylfG9sy022Kto+YV9PE2h/Wgq6k+NipWJi2FUNV+veEBixxSvSm2S6umck=@vger.kernel.org
X-Gm-Message-State: AFuF++kOk86Irpq7CsQ2hZfR/I64CKrPZa9o257x7pcScAOaZqkptP9J
	yrDT4iYWM2D42o31u6i7DrtQlwvbYVwCzSPX+I/HqQwoUquTNpJJMP1KNTUrUuIHCmqxi1lBxJY
	JNF1P0w==
X-Received: from pjmm16.prod.google.com ([2002:a17:90b:5810:b0:383:7b51:b1cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cb:b0:396:65dd:4093
 with SMTP id 98e67ed59e1d1-39aee153a7amr7412902a91.14.1788367292151; Wed, 02
 Sep 2026 09:41:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:09 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-7-seanjc@google.com>
Subject: [PATCH v2 06/20] KVM: selftests: Extend page allocator to support
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
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Extend the page allocator to support naturally aligned allocations, as some
flavors of PowerPC page tables require multiple guest pages per table, and
those tables need to be naturally aligned.

Take care to align the potential base address *inside* the retry loop, i.e.
the base needs to be (re)aligned on every attempt.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 95bc0a78d2bc..4732b9528812 100644
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
2.55.0.966.g6673acef38-goog

