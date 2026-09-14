Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08371481FD6
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401202; cv=none; b=WLuyJI4i3wAMXgPcfD32mKeB4CF0wMzBTlPEAJq1/nUTU5Jfm/6Jjm/DeSt2qMUDGhdxoXa6Tnhx8lMV+m473J0HziKu12iJS+6OvEwNsDgV7Y1UDj4q0GfxvZKS8etJcPM5FgeKM+ROnPgNOdqNSjQjFXkfyr6B95FIv0Ij4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401202; c=relaxed/simple;
	bh=crM3R9hRHTxMxzuPeb+4LXPev3iRD5Mq5JnkLkFMHiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huLQTzLv5qNp1E5z07rOabZC6CmEVNwSMEiVUaWUPQYMh7h3MBcGKn3Lp5NZnD2ZCxmFzL1z0I9DyLpckhCGce1nEXDOMIdN1roVlKbO+ttuqmZegfxh7n2T9enlQVplA06RDJ38kaBQuoe5TgjV8on61xxPH3368HHGZ2hooMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddd62YMR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddd62YMR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-869d181419bso3238144b3a.2
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401200; x=1790006000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yZDlFBVOyLbSIx2cXxBcavLUPo8eOaYZf7Gr8V9kXY=;
        b=Ddd62YMRRTbQ/kWDkmhOG5xakWYXBCs6XOZjLDezh1pkQGApQ3ik+w343au6yOIsMo
         zRhP3pE9KF/rL0Igv+qZ/fBCju2nahW0kPUcifS/9D0RylL/0Yk0NDXS3RlB/tuZPr2x
         jIJf0+JDwipMCY7et+IsJX2TbGbzm2IFmPUA89jkb2jw6f9RxI/CoRHJMekTWnzmZP/X
         3ogjXI7nXhZdpMC+AvOYzTHWU+AKsbydxyQr/+iWMk//1K+UfBieQ3PUyY/wKZpKRE2E
         hxm6eTP6YEz+Koqpg7fkGb1dlprsCqrjlRqoJHPB4OWr09VqQNWcCt4QKqgfDQcVjhXC
         QK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401200; x=1790006000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yZDlFBVOyLbSIx2cXxBcavLUPo8eOaYZf7Gr8V9kXY=;
        b=CcgzQw2Th04T1FqBAE0QeWeJ7Jyy8nyBNEuZ3Mdzmr7+nZlBGXhFH2LgfFiQK6Uotw
         wjDdUwk7awdxKirFQRHtAsuIMv4mAc2smltNtAhpC+FNxOAT8qfTm066OMHHLJP11u1w
         dx8BxmnXBg3XnsWEQJmXwyrr0nVHOX0bIUdMg8KzKTSREpBnwVUw5o7zEZY9PrthnqcH
         PW21gGZgqWe9xwHP+PoNFdy291veXL6KakfHPHQrUt4s3XpkjBnufkXvXmSwZICbz0bs
         rp2ZxWVGPDNkNCsg2dlV4kwcDyNtZy3iPcPaqewFu4/z5r3BBnqYd8z63Hj4mdlp8nE1
         1g8w==
X-Forwarded-Encrypted: i=1; AKwUvByLS36ye0YZtIsejGaLqfuZkP0ImMZUjO+PMgdoj9M66Sd9PIPCXwNsZWWe/BS1zyR39V0=@vger.kernel.org
X-Gm-Message-State: AFuF++liSX3CFRFfUAkVBHUuMAsKPcy2wqQm4TUTAtk5o2iowv68cauS
	lP9zddubNtJ30lnt3hvOxKTsDxe1cgjUV1/dc6Z/9af7aqgs+A30x9h1
X-Gm-Gg: AYBFou21A4zKTED5a0WX4mu+eAWqzkHtOlnV1WQQKqjOVhdeBU6WO6tbl9CBKjC7b0o
	p/sIyTN01iHrqJ9c8/D27JbnuQppVOd8ZhA6wV+Cwjxm3eJp7Y82Kiw6nLO9CZKJQyhS6DW/DMh
	Hy0/62mm/bdBbKzvmBdNfBhSNYKQZ7QoggQSkvPzc20qkPzc7BTKpyfwhXnpZzKKGv+2L2sCa+k
	+7doV5KtzcFU+Hz36MrM5VqshVhWiPdLcEGP8pAarvP5/J1hG03GdsEGTI50Zco8t0EsvL6OZUP
	q5xHJOKzz+62rWBmrpUAPr0vnQua4M5JcLDL5wUR5NxosurbAeVEYIKtYantXMCehAQAQCNFCnX
	15ajb3XsywKQNaa9kSYeXG+MYBFKghzJ0/RREQkS7Kl9xTEPI+hR27tNeuWxWWqXidSqG5FpyJV
	8RcOlHu0j1ywNr6Nn5sdd7+nyQ4ze4KAl2b9T7LIXIdbkURKKwvX51ENEcLjLkzvLgkKWRmpEqz
	9by5eJ2lhnNS/yUCjoVJhE=
X-Received: by 2002:a05:6a00:2403:b0:864:cbc5:b8c1 with SMTP id d2e1a72fcca58-86f83344128mr6350391b3a.2.1789401200037;
        Mon, 14 Sep 2026 08:53:20 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:f7d8:563c:bb30:8f02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b6139e3bfsm4767999b3a.50.2026.09.14.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:53:19 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH] KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG requests
Date: Mon, 14 Sep 2026 22:53:01 +0700
Message-ID: <20260914155301.14499-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clear-log mode invokes KVM_CLEAR_DIRTY_LOG with first_page set to
zero and num_pages covering the entire memory slot. But the clear-log
allows targeted clearing. So, the test does not verify that KVM
correctly applies a bitmap relative to a nonzero first_page,
or that pages not selected by a partial request remain dirty.

Add a focused test that creates a memory slot with
KVM_DIRTY_LOG_INITIALLY_SET, then submits a 64-page clear request
starting at page 64 with only bitmap bit 1 set. Verify that memslot page
65 becomes clean while every other host-page bit remains dirty.

Write to page 65 from the guest and verify that dirty tracking was
re-enabled and the page becomes dirty again.

Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
Tested on x86_64 with 4K host and guest pages:
	./dirty_log_test -M clear-log
	PASS
 
Tested on arm64 Rock 5B with 4K host pages, including 4K, 16K and
64K guest page modes:
	./dirty_log_test -M clear-log
	PASS
---
 tools/testing/selftests/kvm/dirty_log_test.c | 104 +++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..a12b538c3144 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -815,6 +815,106 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	kvm_vm_free(vm);
 }
 
+/* Use the 2nd 64-page range to exercise a non-zero offset. */
+#define TEST_CLEAR_LOG_FIRST_PAGE	64
+#define TEST_CLEAR_LOG_NUM_PAGES	64
+#define TEST_CLEAR_LOG_BIT		1
+#define TEST_CLEAR_LOG_PAGE		(TEST_CLEAR_LOG_FIRST_PAGE + \
+					 TEST_CLEAR_LOG_BIT)
+static void guest_code_clear_log(void)
+{
+	u64 addr = guest_test_virt_mem + TEST_CLEAR_LOG_PAGE * host_page_size;
+
+	while (true) {
+		vcpu_arch_put_guest(*(u64 *)addr, 1);
+		GUEST_SYNC(1);
+	}
+}
+
+/*
+ * Verify KVM_CLEAR_DIRTY_LOG only clears (and re-arms) the requested range:
+ * with KVM_DIRTY_LOG_INITIALLY_SET every page starts dirty; clearing a single
+ * page must leave its neighbours dirty and must write-protect the page so the
+ * next guest write re-dirties it.
+ */
+static void run_clear_log_partial_test(enum vm_guest_mode mode, void *arg)
+{
+	unsigned long *bmap, *clear_bmap;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 page;
+
+	guest_num_pages = vm_adjust_num_guest_pages(mode, 3 * BITS_PER_LONG);
+
+	vm = create_vm(mode, &vcpu, 2 * guest_num_pages, guest_code_clear_log);
+
+	guest_page_size = vm->page_size;
+	host_page_size = getpagesize();
+	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
+
+	guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
+	guest_test_phys_mem = (vm->max_gfn - guest_num_pages) * guest_page_size;
+	guest_test_phys_mem = align_down(guest_test_phys_mem, host_page_size);
+
+	bmap = bitmap_zalloc(host_num_pages);
+	clear_bmap = bitmap_zalloc(BITS_PER_LONG);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    guest_test_phys_mem, TEST_MEM_SLOT_INDEX,
+				    guest_num_pages, KVM_MEM_LOG_DIRTY_PAGES);
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages);
+
+	sync_global_to_guest(vm, host_page_size);
+	sync_global_to_guest(vm, guest_test_virt_mem);
+
+	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+	for (page = 0; page < host_num_pages; page++)
+		TEST_ASSERT(test_bit_le(page, bmap),
+			    "Page %lu should be dirty after INITIALLY_SET", page);
+
+	__set_bit_le(TEST_CLEAR_LOG_BIT, clear_bmap);
+	kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, clear_bmap,
+			       TEST_CLEAR_LOG_FIRST_PAGE,
+			       TEST_CLEAR_LOG_NUM_PAGES);
+
+	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+	for (page = 0; page < host_num_pages; page++) {
+		if (page == TEST_CLEAR_LOG_PAGE)
+			TEST_ASSERT(!test_bit_le(page, bmap),
+				    "Cleared page %lu should be clean", page);
+		else
+			TEST_ASSERT(test_bit_le(page, bmap),
+				    "Page %lu should still be dirty", page);
+	}
+
+	/* The cleared page is now write-protected; a guest write must re-arm it */
+	vcpu_run(vcpu);
+	TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
+		    "Unexpected guest exit: %s",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+	TEST_ASSERT(test_bit_le(TEST_CLEAR_LOG_PAGE, bmap),
+		    "Page %lu should be dirty again after re-arming",
+		    (u64)TEST_CLEAR_LOG_PAGE);
+
+	free(bmap);
+	free(clear_bmap);
+	kvm_vm_free(vm);
+}
+
+static void test_clear_log_partial(void)
+{
+	host_log_mode = LOG_MODE_CLEAR_LOG;
+	if (!log_mode_supported()) {
+		print_skip("Log mode '%s' not supported",
+			   log_modes[host_log_mode].name);
+		return;
+	}
+
+	for_each_guest_mode(run_clear_log_partial_test, NULL);
+}
+
 static void help(char *name)
 {
 	puts("");
@@ -913,5 +1013,9 @@ int main(int argc, char *argv[])
 		for_each_guest_mode(run_test, &p);
 	}
 
+	if (host_log_mode_option == LOG_MODE_ALL ||
+	    host_log_mode_option == LOG_MODE_CLEAR_LOG)
+		test_clear_log_partial();
+
 	return 0;
 }
-- 
2.53.0

