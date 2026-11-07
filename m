Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011842;
	b=2p/HQsshhVU+aPN5MVuAAyvvD4YAZRJoREDpcsyzdgVW0cLuUDbH6bCthQO4pRNoCB8S
	 zSIKmzOhYEeuDiKzcM/mgEWQ9bFjU5wdXsrT78ffoHPQiciWAQfXd9vAJJ4fGrhN6MSfa
	 5o4hD/9H39uMd+VZJFqusVCFY9/g1+QbadelcOeMMK8BiLWSGwAOOGoxPBfctUSE/oOSI
	 PoA+Ud9/g1H0XDdbQO0yg7yvls3r9yRZRNx0xZCZG9Yq1S9yhl2+v+d8kiNjON85GvGB1
	 FeiIZx5aJWwNr6P1D0pvOu1RKsyiUbNnnNurelilp1rOeWIDmFSmm5HPjI07Q7iweOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011842;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hrapFynDjbkWCcJyxHeJnR+LV5z34UhNLuAEeq9me1s=;
	b=P2+O8w7TbI1XK9/8mpjIhZ2dkJzDuw/HxXhLgOsabn8hZCPgobdzYIbK4lyTVuNN5hvg
	 8HZ4Krg7UNsfYQMFk80NN1gHr7xUseRn0krtL8vQzhD6dSPSAPBdI9vaLeceRm72T1hj7
	 7w+vi/up6y5a/WtU6iyveqpmA82vmMEXM7m2tBvkCLPDLqn7HBdMOKlHbjJ1jAAA1y8a7
	 6F+UnXOjW7dG+ddQSN+cUjt94+Ri9PK4DTuc63HT4Y69wH1aEzcP+cFJGocUCpUmERtbx
	 UocFcM3ejjuJKRE9Fvy6yEXXwlrP8DZe3UIYGFjm0643yfb1sGM3/ITz23G4iiYA6Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8iF5w9s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E06082BF5;
	Sat,  7 Nov 2026 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8iF5w9s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011842;
	b=VNfJeK4Ew4KoTwcuSD8lnhsDEWJk+XnDFK3xm88hYcZOqe52dSF2/bFGZZdcdE5IHfrk
	 1dOFVhUyBoqwYaROLFFlYzfW7vM7S2biLgdcU4nxDc+f53RsW2QbwSReolpyYDE91JVB4
	 VuUcNS6ExLa5RoYCMfCYkOgx3II9P664lPbN6yBvwdRb+TYfH+ahCC6JedZ51jytfQZDJ
	 aGYmrtFByI6Epz4s/xOX6POxnt59BZvy/ccO4JgIsWRC3viM/ADVrXlq3kc0eRGnWDymb
	 ROiTWaYJIFBZu3zvDA7Qx7OE0QTpEfYYNPQZwNO2srIw4sk6zE6zWwMvbXeOqUEz1Ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011842;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hrapFynDjbkWCcJyxHeJnR+LV5z34UhNLuAEeq9me1s=;
	b=3Sk1Bho5TxomfR2bF/xC/qGsT0NVpxWr3NQedbHWHD/sUENlwvTtrCPp4KZPhJu0aCjF
	 9rmWFlexLTQLVaO2UguowzueJvix2/y5aZgk9s4zsB6dKBxDHFz3NGvpuyalYfDn+NE8T
	 cK9QVYnLDss1gsyegTkIzzojWZhQ+gnOE7Dzh6FxQIrwL4/S6hJt0yILBvgwAdRU9gKQE
	 2tvAfk1cSUj1b9vvWSFmS4fXVRSBS34jTrCVUf3G9x1Cb1lJJuczfh1O7O6He/9EfeM++
	 aINtYiL55+XmGj7JUOKv2TKabgDEBVZjbGp/t8Ru+vevqJBZ14nAUx/PKYzLn65rXUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0A0B31F0092A;
	Sat,  7 Nov 2026 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011842;
	bh=hrapFynDjbkWCcJyxHeJnR+LV5z34UhNLuAEeq9me1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=R8iF5w9sJ4PegTdRDo7KyNnk8N8q4VmloiVUSpq9CHgUqnXvaL/laX8DGryxyPjER
	 szhcijqMILBRqgclc+OIpV1j19/U0tysieYFNlKXp8JIHyC8QQfCfM/39+mk/x7VlV
	 4bZ1KVAZlcPeaOMTz1izKsG2cM/W8pffydq0qs7eKevg5U6tLfKJYT0oZLqC6UHTZq
	 YEh5z9xzL/heIlREKIl4jrzsbWuJRGxIHb8k5YvdPGPREaJ2itu04s6UuYiYcNr6Mv
	 B7dEE1gawQuC5w4uCysdwTBtn9YevWgI0DI1k1wUSHxDqdp7sJ0GrNX/WTmN8qHB1H
	 ScRR6zZcMl/eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BAA6F47A67;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:38:02 -0800
Subject: [PATCH RFC v3 88/88] KVM: selftests: Verify shared and private
 pread and pwrite for VFIO BARs
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-88-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=6284;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=1zioOYnFzNTxpR7A0+7PoY30sl5nwpjzxC/1lW8AftM=;
 b=nb7C5koXUc0MibxX3u3xtZiyucnhH0jKaUaY3p2yk+i00QV7XkYLX8bgHiHUcBKnmJ0BMIExc
 bN5UY/TmbqBCspJMlH/ycgJCUazHR4ByTAP+dVGyqKh/42/RGYjwqaC
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest to verify read and write operations on guest memory files
backed by a VFIO PCI device across shared and private states using
file descriptors directly via pread and pwrite.

Verify that in shared state, host userspace can read device status and
perform read and write verification on device registers through pread
and pwrite on the guest memory file descriptor, and that updates made by
a guest virtual CPU in shared mode are visible to host pread.

Convert the memory to private. Verify that host pread and pwrite
operations to private guest memory are rejected with -EFAULT, while the
guest virtual CPU continues to have full read and write access to the
private registers.

Convert the memory back to shared. Verify that host pread and pwrite
access is restored, that host reads observe updates made by the guest
while private, and that guest operations continue normally.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 143 +++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 325d5e0c66026..eb3a2ce0e6ed6 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -946,4 +946,147 @@ TEST_F(guest_memfd_vfio, mmap_shared_private_rw)
 	ASSERT_EQ(0, munmap(bar0_mmap, bar0_info.size));
 }
 
+TEST_F(guest_memfd_vfio, rw_shared_private)
+{
+	struct vfio_region_info bar0_info = {};
+	uint64_t bar_gpa = 0xc0000000;
+	struct kvm_vcpu *vcpu;
+	void *bar0_mmap;
+	ssize_t ret_bytes;
+	uint32_t val;
+	int ret;
+
+	if (!variant->use_gmem)
+		SKIP(return, "Shared and private attribute rw test only applies to guest_memfd");
+
+	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_TRUE(bar0_info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	/* mmap the VFIO BAR through guest_memfd descriptor for memslot setup */
+	bar0_mmap = mmap(NULL, bar0_info.size, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, self->bar_fd, bar0_info.offset);
+	ASSERT_NE(MAP_FAILED, bar0_mmap);
+
+	/* Configure KVM guest memslot backed by guest_memfd */
+	vcpu = vm_vcpu_add(self->vm, 0, guest_rw_test_code);
+	vm_set_user_memory_region2(self->vm, 1, KVM_MEM_GUEST_MEMFD, bar_gpa,
+				   bar0_info.size, bar0_mmap, self->gmem_fd,
+				   bar0_info.offset);
+	virt_map(self->vm, bar_gpa, bar_gpa,
+		 bar0_info.size >> self->vm->page_shift);
+
+	/*
+	 * Phase 1: Shared memory pread and pwrite access from Host and Guest.
+	 * Initially, the entire guest_memfd resource is shared.
+	 */
+	/* Host read from STATUS and write/read-back to RAL0 via pread/pwrite */
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_NE(0xFFFFFFFF, val);
+
+	val = 0x11223344;
+	ret_bytes = pwrite(self->gmem_fd, &val, sizeof(val),
+			   bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0x11223344, val);
+
+	/* Guest read/write to shared BAR memory */
+	vcpu_args_set(vcpu, 1, bar_gpa);
+	guest_write_val = 0xaabbccdd;
+	sync_global_to_guest(self->vm, guest_write_val);
+	vcpu_run(vcpu);
+	ASSERT_EQ(UCALL_SYNC, get_ucall(vcpu, NULL));
+
+	/* Verify host pread sees the value written by guest in shared mode */
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0xaabbccdd, val);
+
+	/*
+	 * Phase 2: Convert BAR0 memory to Private.
+	 */
+	gmem_set_private(self->gmem_fd, bar0_info.offset, bar0_info.size);
+
+	/*
+	 * Host pread and pwrite to private guest_memfd memory must fail with -EFAULT.
+	 */
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(-1, ret_bytes);
+	ASSERT_EQ(EFAULT, errno);
+
+	val = 0x12345678;
+	ret_bytes = pwrite(self->gmem_fd, &val, sizeof(val),
+			   bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(-1, ret_bytes);
+	ASSERT_EQ(EFAULT, errno);
+
+	/*
+	 * Guest read and write access to private BAR memory must succeed.
+	 */
+	guest_write_val = 0x55667788;
+	sync_global_to_guest(self->vm, guest_write_val);
+	vcpu_run(vcpu);
+	ASSERT_EQ(UCALL_SYNC, get_ucall(vcpu, NULL));
+
+	/*
+	 * Phase 3: Convert BAR0 memory back to Shared.
+	 */
+	gmem_set_shared(self->gmem_fd, bar0_info.offset, bar0_info.size);
+
+	/* Host pread and pwrite access must now succeed again */
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_NE(0xFFFFFFFF, val);
+
+	/* Host sees the value written by the guest while private */
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0x55667788, val);
+
+	val = 0x99aabbcc;
+	ret_bytes = pwrite(self->gmem_fd, &val, sizeof(val),
+			   bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0x99aabbcc, val);
+
+	/* Guest read/write access continues to succeed in shared mode */
+	guest_write_val = 0xdeedbeef;
+	sync_global_to_guest(self->vm, guest_write_val);
+	vcpu_run(vcpu);
+	ASSERT_EQ(UCALL_SYNC, get_ucall(vcpu, NULL));
+
+	val = 0;
+	ret_bytes = pread(self->gmem_fd, &val, sizeof(val),
+			  bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0xdeedbeef, val);
+
+	ASSERT_EQ(0, munmap(bar0_mmap, bar0_info.size));
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


