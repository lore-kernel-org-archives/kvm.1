Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711696;
	b=ESo/CKKdRmO0VYm3FOdRkbnh70HKGFRT9u8ehhJUcccWlFkRAUiBPF9EYA43wFErB+Xy
	 3nclhnfF/Gm4DAHrs9AGyrfp6wpFAzNGZwdNnoUzsd/p/7c1Dk95bK7B1fbKjkTfjjXlK
	 LekPebmU3ekoXd2z/JyzqPhIKzjkW+nRdTn5OukPgSyQYXo+X752Kc8NGz2XKKwf4qnR8
	 0ScChUVAnNADcBfK0oK8Df0+KXlczms5fciu32EwRmI14zZL0VQ84jnP+D8gkJoS0etsA
	 hQ5HFroxyQP2sKNENh1mtd0PgeTVzKcfR9TtFyHrXPodFbsaquXVlZB/+qZOf9XlwyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711696;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k68GYBk436CaPNprL/QXtHO9RB8x7lga/CshgV9NcYc=;
	b=zuLQGmnAuKXf34NuWuysw10DeVQhFhwsY0aolwdAH4VVe2O7Fj/FJjOyUttbMI1AhIAj
	 2dQG0TaiWfgMD+RUbUHmF3Q4IlJhltcj4Ak2YUtwaDNa9+elehVMyDNVUqdqYRuTWJYX5
	 7+yi4m8PMcz+pKwr6tlJBYf9eE/L7rtKk4kapKZtSNzUld7XCFIyvxCFfthKlMk+C0dof
	 56AAywijWmCEgjJr4RdjeVfgEmuXRHNZ2Y2378C7pABJAxwP5WGXgYvVWIKSn180sHb2s
	 UlqrMvco3dADFFbx0wHxnVOYcsPWI7+9787kMPxXeUMIihakuaL0aGvnQuOd6NUKWpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhxqA100;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8E606F4A2;
	Thu, 22 Oct 2026 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhxqA100
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711696;
	b=cvDtnGyYarj2143j7NgZGvdsQbwfEhxHa8YK3V6xlyo8Bm04I+Ji8Ps19YxVgNJEaEQn
	 rLu0bXgKhQbfUIXSFOho8f2Ei49H6udfzd9PaXrlduhGoDKIO1VKTzV9CX4QuK81dNZhC
	 Yom+zr/H9mzgPHy5MF+B9G/WEME/IECJA05aivwLGnxakYxi+actnxcvXZH0J/N+jiIPP
	 zkjBoaekBVoxP9MGdzfMPNfBbnoKkOBjQo3tlqbxwvhNQ1QybiU5hdReFdcg3vTN4B6Zx
	 sVmrJMA9SJm1lRgqJ3XyaRjNvHat8xkbrmSGwbrPz5LJJiPsOMNtcqMB+k8h0lW6t2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711696;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k68GYBk436CaPNprL/QXtHO9RB8x7lga/CshgV9NcYc=;
	b=SSGMnw4F1a8Z+G/YGjJXYAF4ivm8mNp7ZSOEGYTEY8q+txTgXyURIRedXwTp23bTECcG
	 s2+HdcRDA9y5Q8ZzBEdUZRP2si44Z1CKRCUsgE6I3svyfxlue+lr78GbpOZyPDgaUcgW+
	 ZARY5MQ+q3VN8kWYD+w9Fb3GqIxk1/dP5FLqGHt6Pbhi6g2G9MGOOFOJNiAM+uAPq78i1
	 qNbY7RlaA8o/w1JXN0eRMOB4MaoGb2xG2mnygjV/dzD5e2OqAmU8gyzxj1otir2K2t+l0
	 pAm9dhhHsl+q/mshsuJyVtCXuVpgT5GC3Uw2YOx9+q2L8thQaJipEXK+9Jr7cCmJzOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D1041F011B1;
	Thu, 22 Oct 2026 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711696;
	bh=k68GYBk436CaPNprL/QXtHO9RB8x7lga/CshgV9NcYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QhxqA1000h7kswdTR8r1ZnQuYv0OC8zXLQGB8nxldWR9Lu8xMdBqBesTZTOxLj8mP
	 cGobQyGslhd46XULNRJs+l8J0saq8xea91BJMvR2Gtnk1bI5VpTia/IzcNL77VGkIy
	 RkyZBl5nNFlug/dxp4vLSlXJOIy5k8N6eMpNWqRMUtV8AdAEH/vqecdQnS9gPXJLIi
	 fhD1VfBW/ODIyxqvU6lNcptj9FXLy8CMJnTg940nm3ly+15riWBFOpG3nXuv6RsOxh
	 HV3gXA6kYXuaOmYmN20et92U7YFfu+c+QZ4aOtmNitcgcTORV7oMbY/4TybHDM8FG/
	 vqLxn4N6ff9BQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B1B82420BC;
	Thu, 22 Oct 2026 23:27:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:02 -0700
Subject: [PATCH RFC v2 30/50] KVM: selftests: Add basic test for sample
 memory provider
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
Message-Id: <20261022-gmem-alternative-providers-v2-30-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=5553;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=DxHc6o6FnWpOH7kMAejZmhFMGKZWARQeHZ9yAfr2gtM=;
 b=MZWm5OhI65j5qGliKRKMwC78fhjZnRK4OJnvkL5NZPMB3GRVId6GmA9lc7rWY/7Oe6I17BuFk
 /BfBpbRroEDB7//o/KaeRPl5dErRndTcfCEIUCt859LcAinaQKoho5Y
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a selftest for the sample memory provider (/dev/mem_provider_sample).

Test basic lifecycle creation across multiple sizes. Verify file capacity
and absent pages accounting using the MPS_GET_STATS ioctl. Also test
marking pages absent and present with MPS_SET_PRESENT, verifying that
absent pages are reflected in stats accordingly.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/mem_provider_sample_test.c       | 147 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e90819..5f7118bddfc36 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -72,6 +72,7 @@ TEST_GEN_PROGS_COMMON += set_memory_region_test
 TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
 TEST_GEN_PROGS_COMMON += memslot_perf_test
 TEST_GEN_PROGS_COMMON += vm_types_test
+TEST_GEN_PROGS_COMMON += mem_provider_sample_test
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
diff --git a/tools/testing/selftests/kvm/mem_provider_sample_test.c b/tools/testing/selftests/kvm/mem_provider_sample_test.c
new file mode 100644
index 0000000000000..932ea3f30f494
--- /dev/null
+++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the sample memory provider (/dev/mem_provider_sample).
+ */
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "../../../../samples/kvm/mem_provider_sample.h"
+
+#define DEV_PATH "/dev/mem_provider_sample"
+
+static int open_provider_dev(void)
+{
+	int fd = open(DEV_PATH, O_RDWR);
+
+	if (fd < 0) {
+		TEST_REQUIRE(errno != ENOENT && errno != ENODEV);
+		TEST_FAIL("Failed to open %s: %d (%s)", DEV_PATH, errno,
+			  strerror(errno));
+	}
+	return fd;
+}
+
+static int create_provider_file(int dev_fd, uint64_t size)
+{
+	struct mps_new_file nf = {
+		.size = size,
+	};
+	int fd;
+
+	fd = ioctl(dev_fd, MPS_NEW_FILE, &nf);
+	TEST_ASSERT(fd >= 0, "MPS_NEW_FILE failed for size 0x%lx: %d (%s)",
+		    size, errno, strerror(errno));
+	return fd;
+}
+
+static void test_lifecycle_and_creation(int dev_fd)
+{
+	size_t page_size = getpagesize();
+	uint64_t sizes[] = {
+		page_size,
+		2 * page_size,
+		2 * 1024 * 1024,
+	};
+	struct mps_stats st;
+	int i, fd;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		fd = create_provider_file(dev_fd, sizes[i]);
+
+		memset(&st, 0, sizeof(st));
+		TEST_ASSERT(!ioctl(fd, MPS_GET_STATS, &st),
+			    "MPS_GET_STATS failed: %d (%s)",
+			    errno, strerror(errno));
+		TEST_ASSERT(st.size == sizes[i],
+			    "size mismatch: expected 0x%lx, got 0x%llx",
+			    sizes[i], st.size);
+		TEST_ASSERT(st.absent_pages == 0,
+			    "absent_pages mismatch: expected 0, got %llu",
+			    st.absent_pages);
+
+		close(fd);
+	}
+}
+
+static void test_set_present(int dev_fd)
+{
+	size_t page_size = getpagesize();
+	uint64_t nr_pages = 4;
+	uint64_t file_size = nr_pages * page_size;
+	struct mps_set_present sp;
+	struct mps_stats st;
+	int ret, fd;
+
+	fd = create_provider_file(dev_fd, file_size);
+
+	/* Initially all pages are present */
+	TEST_ASSERT(!ioctl(fd, MPS_GET_STATS, &st),
+		    "MPS_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == 0,
+		    "Initial absent_pages mismatch: expected 0, got %llu",
+		    st.absent_pages);
+
+	/* Mark page 1 absent */
+	memset(&sp, 0, sizeof(sp));
+	sp.value = 0;
+	sp.offset = page_size;
+	sp.len = page_size;
+	ret = ioctl(fd, MPS_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MPS_SET_PRESENT (absent) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MPS_GET_STATS, &st),
+		    "MPS_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.size == file_size,
+		    "size changed unexpectedly: 0x%llx", st.size);
+	TEST_ASSERT(st.absent_pages == 1,
+		    "absent_pages mismatch after absent: expected 1, got %llu",
+		    st.absent_pages);
+
+	/* Mark page 1 back to present */
+	sp.value = 1;
+	ret = ioctl(fd, MPS_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MPS_SET_PRESENT (present) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MPS_GET_STATS, &st),
+		    "MPS_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == 0,
+		    "absent_pages mismatch after restore: expected 0, got %llu",
+		    st.absent_pages);
+
+	/* Mark all pages absent */
+	sp.value = 0;
+	sp.offset = 0;
+	sp.len = file_size;
+	ret = ioctl(fd, MPS_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MPS_SET_PRESENT (all absent) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MPS_GET_STATS, &st),
+		    "MPS_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == nr_pages,
+		    "absent_pages mismatch after all absent: expected %lu, got %llu",
+		    nr_pages, st.absent_pages);
+
+	close(fd);
+}
+
+int main(int argc, char *argv[])
+{
+	int dev_fd;
+
+	dev_fd = open_provider_dev();
+
+	test_lifecycle_and_creation(dev_fd);
+	test_set_present(dev_fd);
+
+	close(dev_fd);
+	return 0;
+}

-- 
2.56.0.257.gf7497c7d27-goog


