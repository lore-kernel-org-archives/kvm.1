Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011818;
	b=e4h0VbKLywKQwMo2YeyJJXXztLChwbe4ZcIL6lb2TtNbzhIomTXXO1uMWBGIKIhU+vD2
	 LJ2goNC/XWTlMCbZQyoTCJdIficmvGUijZeJ1hh7A7k+L8miXiqGO6sYtySazvSAw5kwa
	 LqTYzG1xdX3hDmpb1K/jK1tSp6H19xshp6h5XfN5e19GLDmI+ZCMTefRK1UMOaBT1/T/9
	 EwwSeZ0aioyOIDJy8DdmUnDxQbGqVFUAsssUEEV/3MMfV28Hiqne6CAla4SN4Jz5EgqFL
	 pKzuIJhM6qvCYQbe9igiaqLEWdkJ+2bxju3BSeLmtdyXCAGaJ0LS1QXXk0spXMagt+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011818;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=akPF8Rqd0NP4tJKzjNxFnOYnLuQsFWTXNmC9tcZ5B90=;
	b=MpwD0x9SGyhVg1KG1QSytJU+9Ad7Kbw3t8/IkuX8mWDlqOsQxIIGipsiPwBqACiaXs2p
	 MWfGEsoIQhvHSDwzqpIkM7WMvKj5nx+2Tz7MTwiMeoGxWIapH7HP6gYzBXMQO1yq6tgro
	 KBjbhw1mmBIu6/mt+8O8rbqt0uqC7Xsmop/H8ZZpNWWcMeBF4rssFpE327jn7IRfp/Sp0
	 7l0RHN33vQrkuThqNIKbJNOA6q/egZJhDCroriLIyfbSsaRU5vUw1tR0Rs6gbIT2DNUbh
	 2EaGLxd6hLhaLzuvN8MAdlMLUmgHhJyrSYl6LgmMWvhrAouG+7OLZzRP/gqZjRNRmYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXiLshyn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76476606EE90;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXiLshyn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=rCpI9X9dDe2locV8qN0VXeon/7oeKXhMx/OUMnAtjcKT8h9V5bdoS7n6iEIlumfjd0T4
	 fH4S5EzGKgQSxWVE/uXjPV5u58WltW3l9Stde+MYK29kSjsngWsKpipt6SqhyK400UmUy
	 iO2t6lrR1cux1migopo3thNMy4JAcl3B+ifQQw1SLkD56B4i8yMgFXjp3VdoVEHMndK0d
	 CgYTPuwrMljn4f57rS1BqNTvHeMX+xeLXV/X0ttPS6iB842ugC2pnzuH9eGKFFd4NsC7+
	 CbmAsGHgIDkE90o2ueFFF4L2ldcmBreFAJw3vuLam1ane17fu0cYRLWvBYD13MvivkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=akPF8Rqd0NP4tJKzjNxFnOYnLuQsFWTXNmC9tcZ5B90=;
	b=ed4/aEHoGaKMOWOTgWQxbcXCqyCSvtt6bAzwRYKLSDGnlprBR2OJvMmXNJdkya62eHQh
	 oA36+UHDAl2VXcSovxiLy9Fp+TzwY0EQVN6cHslPmtOlj9bzYod1pLtVeqy34krfbIoLq
	 MrJ87xWppo2L8DREES+YA6wnEOyxGVG1+QUc3gaznioBFV3MBaTjcUN2qNtNyXKUrbGi4
	 X2sfjI2GYzKM1llrSUzj7wKJ+a7btjDLiYfesv+GsRSC6G3dLAOTG0YAVgTAsPqDNBBuX
	 LUNmke1s9UwF447CmrNJsCMXn57g+sXeBpuBDvxdYcdHYDajC/6BJK7pMjjLa2dglKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 681061F008BF;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011818;
	bh=akPF8Rqd0NP4tJKzjNxFnOYnLuQsFWTXNmC9tcZ5B90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jXiLshynmjH+vfW3rFTL5wxzqLabHmxKCirdsmFJKIby2exN3faZ5OoCT63y0Kfwc
	 PUBqcQpd2V5iS56LtVBCDvZejt2IHL9IlUQwn7rkn2oLkKs1Zpd4o7mPyQjl+x/lsE
	 Fr/WCc/NFuybWWLBAiXPr2tJcwAVkZJKdUcU7CDC+WC0y1hFxOPt279MZPrbmm3KL3
	 FKT5GwODej81IUfmsaER91lcRZLPvrOVMZ+IYnSwNS2V5O6uzIUnQ0rwN5IRbn8PnB
	 BGiH4Vck2mtdzuy8fx/g8NOSrJPlx+sxBOvF2kNjf5OP8gtznznZ6Lljz5HBUyZGtY
	 jrvR1ZrZXbH+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E31A14794C;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:48 -0800
Subject: [PATCH RFC v3 14/88] KVM: selftests: Test guest_memfd resource
 pool sharing across instances
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
Message-Id: <20261106-gmem-alternative-providers-v3-14-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2262;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Gtws3yU3EcBh1drSj1dqMboJlKnfe65yAU7eXv1PUw8=;
 b=OVfxZMrlK188RJKT14VUnpM99+TTasCQygc3Z7C8u4dEwGMREbDFiW6Wd7Pfo/6tGxJRdJRWf
 1hFExBp/dwhCPnzWJJ1ZBLuQ8kK3ekznkfaIsHb7pMrhA/xJLqcJ5Dl
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test that multiple guest_memfd instances can be created backed by the
same tmpfs resource pool descriptor, that each file descriptor reflects
its requested size, and that they have distinct inodes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2250c3e9a583f..310a45b6656aa 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -562,6 +562,39 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
 	close(pool_fd);
 }
 
+static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
+{
+	int pool_fd, fd1, fd2;
+	struct stat st1, st2;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size * 2);
+
+	fd1 = vm_create_guest_memfd_resource(vm, page_size,
+					     GUEST_MEMFD_FLAG_USE_RESOURCE,
+					     pool_fd);
+
+	fd2 = vm_create_guest_memfd_resource(vm, page_size * 2,
+					     GUEST_MEMFD_FLAG_USE_RESOURCE,
+					     pool_fd);
+
+	TEST_ASSERT(!fstat(fd1, &st1), "fstat on fd1 should succeed");
+	TEST_ASSERT(st1.st_size == page_size,
+		    "fd1 st_size (%lu) should match requested size (%lu)",
+		    st1.st_size, page_size);
+
+	TEST_ASSERT(!fstat(fd2, &st2), "fstat on fd2 should succeed");
+	TEST_ASSERT(st2.st_size == page_size * 2,
+		    "fd2 st_size (%lu) should match requested size (%lu)",
+		    st2.st_size, page_size * 2);
+
+	TEST_ASSERT(st1.st_ino != st2.st_ino,
+		    "different guest_memfd instances should have distinct inodes");
+
+	close(fd2);
+	close(fd1);
+	close(pool_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)		\
 do {										\
 	int pool_fd = -1;							\
@@ -656,6 +689,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_tmpfs_swap(vm);
 	test_resource_fd_tmpfs_huge(vm);
 	test_resource_fd_tmpfs_regular_file(vm);
+	test_resource_fd_tmpfs_shared_pool(vm);
 
 	__test_guest_memfd(vm, 0);
 	__test_guest_memfd(vm, GUEST_MEMFD_FLAG_USE_RESOURCE);

-- 
2.56.0.455.g6c5a503b38-goog


