Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011819;
	b=RZ2Z20vMmyUGbn3kr6A5uflAgZJViwzSf2r0KmQXDoQt+gOGe43hn073iyWRlSPus4GZ
	 d0YFyqxtZecabxyjh5QXtOBe5UL7Xh3XymsURUsUuYN00zL/fVVGls3GVMK7yalvs2dTU
	 OsUs6CmnJ96mF2NhPPOUc0nSgsyGovMThWNH0miBfVl6ifhtvde8IeYIeQ7bJOlozqQKw
	 MbCRrtyWv9Z2GrLhN/zCh3rjdD+NcphWELPdHp7Mg6Kvg6v29pwQJK2ee0O8DVMp9ychn
	 HfasIiDK6/Yy0TRsbt8Ywt0o4tHzeWjBXH3qHVtuTyCMcDxdgp6lIgAEGlm8F0q/RKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011819;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oNPewxIMb68UUcd1Cg4cHswlI8K0kn7Az249dYW9mE=;
	b=yqWyw6hVpc/SoNIFYS+QkXzZLPucx/8oIx3DK6xLMBDRJcyJ21YiX8ClOeVi1fnu+9Xn
	 HJ2w70dr65YYQfr23PaxWiYbUqP6fQo7C3XFqeb3OpjEV35pfqgoutG75aWV7afLRqAYy
	 fVCT+dCy0IfPola3O6tD+V5oLV1+zN75Lf/Bu2wFMdtikDPB5JX4zzQcnVVl614cd/ZKi
	 4jDb86eRnrP1TMMqcyWWip9C5YQAYDpxasuyTrHYkalRVfrdhbzCXJ32m3I8SX2fUuZYV
	 EGa13a2zabtYaKCGBesooxHy0RWDVWVhbBsbamZpvW9/Vu3dGdwzBGKp5YuNGSX4OVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPelHZMv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE1606D817;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPelHZMv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011819;
	b=H0A6ARcoOlg/wGWvBYJusSL4nKPO4bZ2f1h+yqOPoo4sauji2BnhwPPDFmuKWpNkkW9n
	 gBGnuF2ez59YJytA+9Ybvw3LyjQqgDRSiumCV4EkQ0Cr9oYwep7hfYdNZn0sRTTkb3YAq
	 BhnoP0vGXveFOnEP+Zpk72KIFknMP5KaS5OURsM2NiCqqsF3CW2ntG6LRleP7vCHF6xn1
	 bDsFef5DHQuGEuSCxo0EIcT7v2fZqmUrKgTcIGDRKfwtR+YhbpDE3IaQb3HIVKQESplar
	 mCZeaQrp2+cm4RgkK+pL9aD43NpRXSgli7gQ4hf0kczqEOXiThCULu3dA30kwR8n+Vw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011819;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oNPewxIMb68UUcd1Cg4cHswlI8K0kn7Az249dYW9mE=;
	b=uI86uebgOTx5uMY9VAba/WL6rQCbS37SyFp/8lPvCvFwiICvXakETwmqGQCZOcvYJOJ4
	 Uf1gJaUh+xDePSt9C11xLdMyH/vZF2UwY42/kR0RydhSjhCdZ2arq3NebwKqqgPUicehM
	 wGNpezbnfQx1NwxP/WvQzwCiyjKKLhbM7eoxxlNDbvAQEPVJqdDjUO1nGD4r7EpxNHWQ0
	 gs1jmrnTujKcq1kjMWieFPxh6tR6NAjwAnygP8lepTthGcVapbRHoZQ1Z/hgZvMc+QthX
	 e+LRnDn8s/o+p/SPzCBk4DnOU08JXNUSsabYvcYfAnVzD8X3WtDpz/1i0mWPvMtARRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C6EFA1F008BD;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011819;
	bh=7oNPewxIMb68UUcd1Cg4cHswlI8K0kn7Az249dYW9mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TPelHZMvf1BVZHG1LqQKlrtRjK5OTeVpzqOpk6PMUoQF+IcST36bzANR148bghBXG
	 ORX9l4XsfMqPT3zwgMfbx1zeIDo5AE/PVL6KlggGNDLKVEUaXLQx6UD/VP1PwYfc6W
	 yExO2euukrk/VKf0Kn5WJxT/Q653T+LMKC4wpf4iqZsLF8JzVcfUA64GZCGU+ohJSw
	 NgkiOGHm1vwKdxZMlxoJSmyT66C1yZTBERxEKt0KwEPMjZ52Vfs0wZd6AdPfQh/MeW
	 nqL7ZwNRuVYQV60cpGdCZYG59dwGv5noltzmeYkklzkjUYJbfECqcXU7UDcHkOTWSn
	 d6NGENvzPARUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9167A4793C;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:44 -0800
Subject: [PATCH RFC v3 10/88] KVM: selftests: Test rejection of swap tmpfs
 mounts
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
Message-Id: <20261106-gmem-alternative-providers-v3-10-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3539;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=lpdQUuXZRi5HMPPsDaXRCAlhoLcAGTXnceeQBzFXLus=;
 b=8gMlAhCQDehpdhBKMnVKx7w1xPC7T5I9VIapWU//NYUwuh9viMkkDkY8Lth7l4Nzmwxv3uzv3
 0m7ExSF1OwwBGyGeTkzOhAjzWOq3kzo+pxYPQZad5a7uLNh6tMiN/Ux
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test that guest_memfd creation fails with -EINVAL when passed a resource
pool fd for a mount that has swap enabled.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index d62ae23256083..205f822e10c6c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -13,7 +13,9 @@
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
+#include <linux/mount.h>
 #include <linux/sizes.h>
+#include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -478,6 +480,73 @@ static void test_resource_fd_memfd(struct kvm_vm *vm)
 	close(file_fd);
 }
 
+static int create_tmpfs_pool_fd(const char *huge, bool noswap, size_t size)
+{
+	char size_str[32];
+	char template[] = "/tmp/gmem_test_dir_XXXXXX";
+	char *mount_dir;
+	int fs_fd, mnt_fd, dir_fd;
+
+	TEST_ASSERT(size && IS_ALIGNED(size, page_size),
+		    "Pool size '0x%zx' must be positive and page-aligned", size);
+
+	fs_fd = syscall(__NR_fsopen, "tmpfs", FSOPEN_CLOEXEC);
+	TEST_ASSERT(fs_fd >= 0, "fsopen failed");
+
+	if (noswap)
+		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_FLAG,
+				     "noswap", NULL, 0), "fsconfig noswap failed");
+
+	if (huge)
+		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_STRING,
+				     "huge", huge, 0), "fsconfig huge failed");
+
+	snprintf(size_str, sizeof(size_str), "%zu", size);
+	TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_STRING,
+			     "size", size_str, 0), "fsconfig size failed");
+
+	TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_CMD_CREATE,
+			     NULL, NULL, 0), "fsconfig create failed");
+
+	mnt_fd = syscall(__NR_fsmount, fs_fd, FSMOUNT_CLOEXEC, 0);
+	TEST_ASSERT(mnt_fd > 0, "fsmount failed");
+	close(fs_fd);
+
+	mount_dir = mkdtemp(template);
+	TEST_ASSERT(mount_dir, "mkdtemp failed");
+
+	TEST_ASSERT(!syscall(__NR_move_mount, mnt_fd, "", AT_FDCWD, mount_dir,
+			     MOVE_MOUNT_F_EMPTY_PATH), "move_mount failed");
+	close(mnt_fd);
+
+	dir_fd = open(mount_dir, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	TEST_ASSERT(dir_fd >= 0, "open tmpfs mount directory failed");
+
+	/*
+	 * Detach mount from namespace so removing mount_dir upon exit or
+	 * unmount doesn't conflict, while dir_fd retains the active mount.
+	 */
+	TEST_ASSERT(!umount2(mount_dir, MNT_DETACH), "umount2 failed");
+	TEST_ASSERT(!rmdir(mount_dir), "rmdir failed");
+
+	return dir_fd;
+}
+
+static void test_resource_fd_tmpfs_swap(struct kvm_vm *vm)
+{
+	int pool_fd, fd;
+
+	pool_fd = create_tmpfs_pool_fd("never", false, page_size);
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      pool_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with swap-enabled tmpfs should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	close(pool_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -539,6 +608,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_invalid(vm);
 	test_resource_fd_unsupported_fs(vm);
 	test_resource_fd_memfd(vm);
+	test_resource_fd_tmpfs_swap(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.455.g6c5a503b38-goog


