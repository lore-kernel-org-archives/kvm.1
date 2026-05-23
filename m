Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DD347BB5
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534902; cv=none; b=dzx6n3Dd3QyuTouuFNWU8XjyeUD7RQAS+g+ieM1OLfRHWkuuwHQfH6yyR+JKu31mvT3Hmb8Vim9xAPsv1LZeV4V6VPzgjak3BrC1bdWoDx5V59hk8WX2cYZCF08UFPLa4pGxkRSYkIiWjDKrIhDF/xrxifaDVUwFmUKCywksQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534902; c=relaxed/simple;
	bh=tG/vwPXG+NgCJqpeTpzbd4mkkNiN98tDPGGb1Pn/dzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGKpN6yjdGhbAdgo4I5Diqqb7GU1Hl8KbD/dVk7v5XiyOopIbVpE12iT1mtCcz9TmAgoWvlGIaTqexFzkaTQBMMv0K9OrcAMoCVpcMfLUiqIbpyUpBpbxsrkq75lbU0K9duj7c4f8B/AomDY5wiMx1SJTO8X708WRceYHwSHO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svdZHpeA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svdZHpeA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so4196917b3a.3
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534900; x=1780139700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=svdZHpeA+lDg3VjDzv6nvdBatOGYY6ugw2mv/hPC0vEBGor2sP/eh2fONZVhVvQSSX
         jIPQc0ahWDQXh53mH9WzUhMTRyk+P4gLViB8b/l4vBhqBrMiy7EfbCEZ4eshV4znPzj5
         PkbBxlIEykUa2+XZDlTkfZws1PPkEIXVYsYT9PJTDw7Ulqnh/gdeLWO5eHmpu0czfvzC
         NIELraDD0bmbPoGYpTnrmvbTKaovCZ3+rKN+SoIV8ECMR4qgdWGPhtvld1evtnbiv/8+
         hkssuFWQt3EmKVCYX2/iyMauJ8rI9q43xkQcMAm9B04uOX0rdWWPCYXwPq8V6GBP8VMl
         i1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534900; x=1780139700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=V9EctkEFAYyKNQkFJZTjXlBS7e3WgSzWOAs/dPDU9lTGwHkvBa9WMTGNguSUt6jeSV
         Kg0ByJbwZKEPLSIY7K54RZPn7SRW6Ke0z3nHxrmtNqjQFqIbRSiDbTFWFPttJYSQpWe3
         MitqZ33pN4QPAsSbsobOBosqKkzyq7rAvxvn0B8mC7MiXpazU1aPhro5LK3LhrkvmsAK
         590+r2GbXnQdhFYshEPiA19FjZ67zkn1rYybMdvYI/zbkjEXGLpk0kKfc25d5ltn01FJ
         Jk754w7cJY0+1I+chDPlar1o2Xpn8tkjZsWKtUFkjcO6g5NkyMR/7iypw4DpixeLhUmX
         1eZg==
X-Gm-Message-State: AOJu0Yy1m5OVVBAY8ObTmBX1uz17aATaLJwKHzOfREOSSQaRtSeF8VVk
	XIn8mQ5zAsKTuzHbz9gbnujUS0mpEQRDtJKnMVuU45Vgb3EbnozZjGjKZWgGvg==
X-Gm-Gg: Acq92OG+DPVmTbKbuVuGjNCdMg9BEIiL11TjfDSC+IuPneIByFmlPHQNKIhP6hDfsbn
	4WJ7pyuQYNeKifzJ4d/t59FcZfwNHnmYuEcs8UEL7veNfc/KjR2u3zdrHkHugLvNBce6+1+get6
	lLVeoEwr1ZSLFdCZG56Yi8elfqqObreVdrtx85Ldy3uA8SD6WMXmHPpVtQ3lWYqlNHkAbqFUTtl
	RsNSVr0uD2B9lPQUZ5yRWbGJAVtwE108C+5YdTe3tdWlsyxLZbAwxzatEU8+Sk3uTAVh1z0HV/Q
	5S6OHlt+oDpheEPzNLdgDvImacLoQolAHbl8pR0C2jcgVbgqtX8OQ6vhgA2Vx2IRuYFHSJOs9PS
	ypJjzHPf+2HH5dU5dnvM9RUtW7FegnuYdEKldu5oFEvxgvDlwXESq02NcvdyE7aRltyINcmbn93
	mRUd8vqChLJtOQG5LpakK1UjngyRpuUuup4vueRDk=
X-Received: by 2002:a05:6a00:1c8a:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-8415f2dca4cmr7587485b3a.4.1779534899815;
        Sat, 23 May 2026 04:14:59 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 2/5] KVM: selftests: Add aligned guest physical page allocator
Date: Sat, 23 May 2026 16:44:21 +0530
Message-ID: <0fcea77119a6f4e0554f8bc0b258a54c2fe9d49f.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

powerpc will require this to allocate MMU tables in guest memory that
are larger than guest base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3666a8530f31..c515c918c2c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
-			   u32 memslot, bool protected);
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
+			   gpa_t min_gpa, u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
 static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
@@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
+static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
+					     size_t align, gpa_t min_gpa,
+					     u32 memslot)
+{
+	/*
+	 * By default, allocate memory as protected for VMs that support
+	 * protected memory, as the majority of memory for such VMs is
+	 * protected, i.e. using shared memory is effectively opt-in.
+	 */
+	return __vm_phy_pages_alloc(vm, num, align, min_gpa, memslot,
+				    vm_arch_has_protected_memory(vm));
+}
+
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 only).
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2a76eca7029d..cdb004c9ba56 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1442,7 +1442,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva,
 	u64 pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	gpa_t gpa = __vm_phy_pages_alloc(vm, pages,
+	gpa_t gpa = __vm_phy_pages_alloc(vm, pages, 1,
 					   KVM_UTIL_MIN_PFN * vm->page_size,
 					   vm->memslots[type], protected);
 
@@ -2021,7 +2021,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above min_gpa.
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
 			   gpa_t min_gpa, u32 memslot,
 			   bool protected)
 {
@@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = min_gpa >> vm->page_shift;
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical page available, "
+					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+					min_gpa, vm->page_size, memslot);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg) {
-- 
2.39.5

