Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061123A7F62
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378444; cv=none; b=YUG4UWj09M6JKsekFS3/q35j6/7slpp5U7ijPsuB4+nmGaxE6RA+ELwMtuVOOdWvvgqlkregRvfOeWEw4geZ4zNs5LE/+qd1taWUwAQYNOhecqu0dTEmpS0+tU55JcGzoh47gvHNda0bCOqgEGWS+Q0q1Oe5jaNXUBrWeALzVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378444; c=relaxed/simple;
	bh=l/O097XS3NY2FSXC1MdvNZgKvqwkv0yyxmFMASNwv2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stNpKqkOvWDHZImEdZCCg+6Q3LmfaiFdeMa9aHgCyRV9qPoBYdNjbY9CnzXklBPrwVIwl7E+FuAd7HSf8weWnXqiUeE5nrrDtKMXdb/4o5m7/RUpk53FCkUzM9hV/3vwkCq+b1rqBR3ZT8ym+BpZzXzTov3Wyp2h4ovbzRIpGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HLDo6YBW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HLDo6YBW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93900ed2925so144575085a.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378429; x=1788983229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0iWDp9wFRQQy4gDc5F5inYbcQx9NkSfWa5yO100B34=;
        b=HLDo6YBWdyFHirVD91ZfpUFtWWrKIKk101t1i9aB3LS2AcZX6nOvjREFMCl33HeIz0
         6+lo2zfq7/V/iBR8sotg18Cec86cC6+4cG9wXbsF4uZ3bS8RjMs5kqCws0mtOxKFEqWC
         b5ldep1lOpmU7dTKYNb5DGNV5zHf5Cp6awGvSU02bygydynrIgoaocJ6ke1xCijl0ilE
         Co0dlfM00/8XKijTKjGuzeOqMd0fwQCkiptDJpA5K9hp2cSHKnAvj5P/HBnTmSgzeAv3
         fUccdtdsTAYW4ndKizZfeiI5FIgaY/uSp+tNPgskIuC84t2tllwiCQaVovZGZR5re2Gp
         M0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378429; x=1788983229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0iWDp9wFRQQy4gDc5F5inYbcQx9NkSfWa5yO100B34=;
        b=MBl49GiOYyEzslI3F8AGFi7nXQEuuwjcWAMshBf5yuGJa0Cb6hpdmAly8CmsOpUbtG
         bM2ywVEyU9G174gkJUF2f89OdCydve2zFwjHPuU2I8omer+Mw5TRAcdMMa/nwvcDxNeP
         mE9/Pp9IYVD4+zPcURAm3jhm73LTEjHo0IIdOBJUMbl3BxB10VC9uUvYaYBfSq2ZPizm
         jbrh24wYLSGMTjiub9v4Ckq68ppy2eerXn9zqkTOM9/oV1vfkVTfLWxzN2nrej98PqFu
         Ffjxk9Qv+Wm/d4fBqKhOYMjkOf5/QDhtXk/PE4K2duKLsAkeW2/YaSz3Sy9dfSs/uceF
         xw2g==
X-Gm-Message-State: AFuF++lcAnv9cD3Cs4TeGBIEjnl9qglhHwW5knJUT3//QiNkHEekVFzt
	9sM+grTLoqDlmG0Rn32bmy5r1Wa6DBwAtJdxcpf7xwv/KiywmwFB5W4tw3yrSgejyC4=
X-Gm-Gg: AYBFou3iNWAAriMDgpcSruCRtx34DSeK2nFF+syBexjawhf8+08d9Mzx/b9E5uk0nFz
	KgNwwZ0OZVutukS/U3QWRou5szvWQmlJTwClWHbxH05RTEk6S6uWP23tAvyqml0i+APxZ/k9Iqk
	Ter3mBE8r4I11Stb83L0ArE+swUowmYZ2HxgBmW3ioB6FLWKln7EtJyghkDskbqTbvCymLlwUqF
	BVp4uzU3MWFzW0Ldq6UVC0O+sO+RnhY6ai+7Jfgl/0aIsrZH2wlzf6wxSzm3deU19R4UMLjoXer
	GfjJiq44HulK8/CuKI8bSnviEvTzDbVdjdEhYUmY135WRbKAtyIGfJjW/4kXH0H0E5OHkH3PxL+
	MnYDszytfQ2RR1ZncaAynC3o/zmAMeiLvtbqPQnEkok+BJzG4/jvFR3rZqi4JWptvJE1EWwjHQP
	SmWzTNr19mfp3U5KTAY55QYgP3D+c85VZuuXTSlO8JScGR/uyTWAuLEunx15/RFOUTw5UhRhAgA
	6BfAWamODZ3ZkY6s48NyNXXjs9m/6JaEW+ah+ed8t5Tt2ss4A==
X-Received: by 2002:a05:620a:7002:b0:933:aa0:bb83 with SMTP id af79cd13be357-93960f69d21mr852874685a.34.1788378428558;
        Wed, 02 Sep 2026 12:47:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:47:07 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	shuah@kernel.org
Subject: [PATCH 5/5] selftests: KVM: guest_memfd: test GUEST_MEMFD_FLAG_BIND_NODE
Date: Wed,  2 Sep 2026 15:46:57 -0400
Message-ID: <20260902194657.79075-6-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194657.79075-1-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for an umapped guest_memfd mempolicy configured at
creation via GUEST_MEMFD_FLAG_BIND_NODE.

Handles:
  - !CONFIG_NUMA (skips)
  - single node system
  - multi-node system (faults onto remote node)
  - invalid arguments (non-zero pad, bad node, node w/o flag).

BIND_NODE is skipped in test_guest_memfd_flags() and testing later
because that loop asserts every advertised flag succeeds on its own,
but BIND_NODE is the only flag that depends on a second field.

Signed-off-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-5
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 1818e0fea5690..b333cb42fab29 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -196,6 +196,83 @@ static void test_numa_allocation(int fd, size_t total_size)
 	kvm_munmap(mem, total_size);
 }
 
+static bool has_bind_node(struct kvm_vm *vm)
+{
+	return vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) &
+	       GUEST_MEMFD_FLAG_BIND_NODE;
+}
+
+static void test_bind_node_invalid(struct kvm_vm *vm, u64 flags)
+{
+	int fd;
+
+	if (!has_bind_node(vm))
+		return;
+
+	fd = __create_guest_memfd_node(vm, page_size,
+				       flags | GUEST_MEMFD_FLAG_BIND_NODE, 0, 1);
+	TEST_ASSERT(fd < 0 && errno == EINVAL,
+		    "guest_memfd() with non-zero pad should fail with EINVAL");
+
+	fd = __create_guest_memfd_node(vm, page_size,
+				       flags | GUEST_MEMFD_FLAG_BIND_NODE,
+				       1 << 20, 0);
+	TEST_ASSERT(fd < 0 && errno == EINVAL,
+		    "guest_memfd() with out-of-range node should fail with EINVAL");
+
+	fd = __create_guest_memfd_node(vm, page_size, flags, 1, 0);
+	TEST_ASSERT(fd < 0 && errno == EINVAL,
+		    "guest_memfd() with a node but no BIND_NODE flag should fail with EINVAL");
+}
+
+static void test_bind_node(int fd, size_t total_size, int node)
+{
+	const unsigned long other_mask = 1UL << (node ? 0 : 1);
+	const unsigned long maxnode = BITS_PER_TYPE(other_mask);
+	bool steer_away = is_multi_numa_node_system();
+	void *pages[4];
+	int status[4];
+	char *mem;
+	int i;
+
+	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+	for (i = 0; i < 4; i++)
+		pages[i] = mem + page_size * i;
+
+	/*
+	 * Bind on a different node if possible order to check whether faulting
+	 * happens as desired. Without a second node use the local node and
+	 * just get coverage of create/mmap/fault paths.
+	 */
+	if (steer_away)
+		kvm_set_mempolicy(MPOL_BIND, &other_mask, maxnode);
+
+	/* Deliberately no mbind() on this mapping. */
+	memset(mem, 0xaa, total_size);
+
+	kvm_move_pages(0, 4, pages, NULL, status, 0);
+	for (i = 0; i < 4; i++)
+		TEST_ASSERT(status[i] == node,
+			    "Expected page %d on node %d, got it on node %d",
+			    i, node, status[i]);
+
+	/* Dropped memory should fault back onto the same node */
+	kvm_fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+		      total_size);
+	memset(mem, 0xaa, total_size);
+
+	kvm_move_pages(0, 4, pages, NULL, status, 0);
+	for (i = 0; i < 4; i++)
+		TEST_ASSERT(status[i] == node,
+			    "Expected page %d back on node %d, got it on node %d",
+			    i, node, status[i]);
+
+	if (steer_away)
+		kvm_set_mempolicy(MPOL_DEFAULT, NULL, 0);
+
+	kvm_munmap(mem, total_size);
+}
+
 static void test_collapse(int fd, u64 flags)
 {
 	const size_t pmd_size = get_trans_hugepagesz();
@@ -429,6 +506,10 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	int fd;
 
 	for (flag = BIT(0); flag; flag <<= 1) {
+		/* BIND_NODE depends on a valid node field, test separately */
+		if (flag == GUEST_MEMFD_FLAG_BIND_NODE)
+			continue;
+
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		if (flag & valid_flags) {
 			TEST_ASSERT(fd >= 0,
@@ -476,6 +557,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 {
 	test_create_guest_memfd_multiple(vm);
 	test_create_guest_memfd_invalid_sizes(vm, flags);
+	test_bind_node_invalid(vm, flags);
 
 	gmem_test(file_read_write, vm, flags);
 
@@ -486,6 +568,8 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 			gmem_test(mmap_supported, vm, flags);
 			gmem_test(fault_overflow, vm, flags);
 			gmem_test(numa_allocation, vm, flags);
+			if (has_bind_node(vm))
+				gmem_test_node(bind_node, vm, flags, 0);
 			__gmem_test(collapse, vm, flags, pmd_size);
 		} else {
 			gmem_test(fault_private, vm, flags);
-- 
2.53.0-Meta

