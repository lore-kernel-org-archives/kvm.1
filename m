Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711680;
	b=Tf/TA1uFOUVTCSmHi7XtKE4d1QwinWuPv7zK8xgi2rHsncWQ8iiKB0vdx67HhMbM4mnA
	 HiHD2YLWpZ3yPmUA0WbfHfkwsDOUQIzZQlYEZCoXPNiDfeYcupiE7NmNLx0CY8r8A1vlI
	 fpKyZNY6rAwQZT1njt1oAENf5aNKej13gb99UmaikZi4MBquRp57UGsy+kge1lDm+I2x5
	 DQ/8EZZJvizVOx2FAJiKXjkjw3uZ8e3eQAcyeLbyuYMLZCckYC1xw9hKC2+GKOcR4VR2L
	 U46QypSyw0HCo0ACZkRs4/z079H6zzbjqAozeXNVar9YGRaQNx095MahvVBFBqm/p1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IeBKuFbI5RouGS1BqE5uNK60CXrNCKPcOeZV9/GDpf4=;
	b=TLln+ZtL5WeYvZ9UGNiGxjVXR7MyECgHLNPEz1srTTSPhr6etS1HeY6Yvu5x0+ri9yHu
	 Lx7GKuXYeDbrTv4AG2sGawSenUuvJVyKnl3HqAs7WPPt2h40RUPE0JEcHkmr3MUQ2U9wo
	 MpBtIWNhwNXnzqaPVFSz/xEs20Nsikld03XltREUMe28tOEu1q/OS/DbGSbd1Jg6h0631
	 cIUMojt5AqzXKaymfwdi9rqGxv1oCYwA8+WrvvD3vovZM8FnO4pHcSEXDbtL6LKt3B2bu
	 wUhNMc10lWg8HIONs3J9619+qApU7dcjFl91R9HCpp07VGMWaX4epHIib+0Ai5EZGLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nj+TiSZY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBB60A260F;
	Thu, 22 Oct 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nj+TiSZY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711679;
	b=1q69OPGMxptt/9Rqel/UMGTuXK8Ce3y0DDz61Ur7vYUnRx5EPEpHuaNgvfhOY4NAnybj
	 m2tOcRLdJD4mJf/Uinf3OChrwKMoedFW8ulC5yw2G++r/w4IZo7LxT02Ok+F3xsLZqI1B
	 vkaJxD3F7XPjQsT241kOcG8LqjqVEEFnIZscWrBdLELndikbuZ912egUgqQtAXxRjgU2/
	 YKKTozHYiCNN0g5+2qWvgc6IiFSPkh30R3dLJPXr4xLtJCKOgm+uT0SVjLNlQh/QrVPlk
	 XKvuMvsH7l6syDWcm0GEH/jqcjvCCzgXFv5jAkX6Jl4gKAt0TPTs7jAJwpGVO7hmx0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IeBKuFbI5RouGS1BqE5uNK60CXrNCKPcOeZV9/GDpf4=;
	b=p9o9xZ3cnXLM0ht5NAyv8IWHZGmS3FbkHDZO1h8fnNcFNFon7p0sNf8ZEUaZzeuDf9dZ
	 83vStgUT4I8D44XRE+r7v50jRF7JOg//ZFaqdmSTwOet4rBOqmUPqr6Gx6f0P1YPeZ/ZW
	 upepaSQ6J1upNBfXcBG+dtOdvWNoolaoGf9Obm73oGkjRhmeK4LH9nhzRVd/8nSxivHWC
	 KBXhR8K0k1T0IGCo35UwXGhqNilqVSCpxFVcNSeEal9Xwl5jE45wakZTZ3C69cbC5a529
	 rATljN1aFxkB+AyKVldoq+MbU2C392nGKfNAlB9oPu0OFJaXSzCOcc0AJe/c+ZpuIiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DD5011F01185;
	Thu, 22 Oct 2026 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711679;
	bh=IeBKuFbI5RouGS1BqE5uNK60CXrNCKPcOeZV9/GDpf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nj+TiSZYgKRwu6dmh3++kCeiItFqHi46Q9yE13sYBkQQ0MfiguFVChe/NCKrG+Ygg
	 IWM41RTCvOx7GQNtApWpCFEzw8nhnlrWX8g27/TvFAkT0V4+aC9FhHCEBWTfdwhPOX
	 XukFvnbZ0OlL1SuTzsZjRmwp5KcLtZiJGb+Xm1jlEa9N17TL2uAjQtviSb0ss2o8xd
	 1f/YO0rToVCalEnWUs/QMSQtxkkxIxYVHY6fUx0ddYYt97h6vvN3x4HlYHmJwwDWRD
	 Lntgg1vsKqvOoZ47ZaEpR7rmXXg+SaDJf8fcT+pOAkDz8bDkwzaeX4b9vu7sa1OP6l
	 e4pVYbu16Pw0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B56C84206B;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:42 -0700
Subject: [PATCH RFC v2 10/50] KVM: selftests: Test rejection of swap tmpfs
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
Message-Id: <20261022-gmem-alternative-providers-v2-10-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=3539;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zR8MX/2CQi/SqTXqjQrd0mWj1p+sOZKDt/EsWzdKyV4=;
 b=L85dc5nPJTUd1vfqIJYkB9OBf1jiRRCQbTzjK7L0KKv8MXi0Hk77tRqYzylP2QhdB9rQHTqc1
 qLKKxC3ZuL3C5WnjXjJ+unmgSB7LWFhYNht/YdH2QYBBeq5YpmrcOAI
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
2.56.0.257.gf7497c7d27-goog


