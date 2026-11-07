Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011828;
	b=fBxJU+0IumfrekeLeMtLHF46hEhmLFOp6ogZ8IjNaN05aQRIChugql8PY4p2Q5Y1IJyh
	 dKuIX/NWm2SN5N5M6AFsDmIgUxihfwmHRb9E7qqdqhwToEPIHdk284nWNDaOaeaHRDD0e
	 W12ZyRP3Yj5ReYXMeNC6irePz/or6g9adHJiJxSu6Jg9luT1JIAhwZV61G7zbESUFhj9R
	 9tAUiNWi4oQ1FDGDAxjkvIN2JT3UYDqryM3GRtbfmSPR3ERgPDGK0n2hktC4QGum9GT7v
	 O9z0QMQ2a/GHcTv+thqIZZGQ/SahfSnc3ZjFYnqUAtVDy2RSdPWm5n03cTaXRmZ8h3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011828;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XbgD4ImI2n1rI6Htjo1pftOxgnHtLV+P5ZlvPe7/FPM=;
	b=NCsKwP9O5UKUD+jsZxrdgT5IAMACrlAH0GHk/JYmePxZRLhG44wGJL6I/ChmGqVDX4Wl
	 +GVn6WHtcbyd1CD+WGk35OwrAm32SBdcsOvQF0/5nX5V+h0mowtLQwDewBcppuq2mDRJ0
	 VUvShb1hTGJ/Tv91l8RcnatAuBPRhKX3aQaupz6w/xyvRAZxEDbVEP2E3dKjYXebXb3mv
	 /eO+s9J6yDdKHtAnVkmxupcvdA9bcAQV1IRyajyYDRam70vNJEx1ncjyrPOWWT+LgZtEk
	 JjyYqOWB6c+kKYKt0U2n79lXMn6kpHXtzFhJzEZSRvhTQTIa/elQT6oMqVCcRloUJOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx+Lrfin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B440606A338;
	Sat,  7 Nov 2026 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx+Lrfin
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011828;
	b=DhCW07Nn03Q+sJ7vioJGBqHKxhj94Gspz/XxJ+f966pMWIYuMynLGUhWqEsvnZ+D6NNr
	 JxwvHA/mYnrUARMRO0gkHr97CJAdp1dBC6buSy3h4hf1fZImOh9Kyxg8BPghYW4E5uQrz
	 j11uX6RvMmC0dJvrMa6KYGintB1WfxlXvtWlMcXFaBLLl9FtfQSHCVi74TUoIZ8Pz3zdZ
	 hSMCohuugs7u8RdU/X9vadKIxgFIV86L99nuV7BIKL2hzuyQGkPcPESdlxba1ZGQBASWX
	 hSS+mRYsX6NjwQDwgwWRD/uX0PRSO90K3BTPVkdID1ZFSOny6X1qE0SelZpcCu6zDyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011828;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XbgD4ImI2n1rI6Htjo1pftOxgnHtLV+P5ZlvPe7/FPM=;
	b=iBtBJ3JTtUyU6GAUDnZXdEx+XF+KPjBz9VlpnWGhxjFhBBQCfJ+qQ19NmqdgX4tIpNCL
	 pamOqcyTGQH4Yb/XOvVqcucwTZIhObsvusBeI77Itb7gNORPI4DAzhgORj2HJec44ygAf
	 W1gn5KGw2DVFMM2+f3cwoXQlfW/HlSXzrOAFCSflB7VaZTcBUrZeewTyRSpo+3DfjGond
	 f6/qjw3n4KecsS+9zsJOVUXfr4cCTaQI9yr1EEHTEMCam8G0rkGtq+BW0Z0hOQ7cgdXTz
	 dF8iJqtmikC7AnDthCzSgtqkz/J8ekC8PqzkpKu+QArFy1Upe4VWMhWebV2pAkFQvTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E22B41F008A2;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011828;
	bh=XbgD4ImI2n1rI6Htjo1pftOxgnHtLV+P5ZlvPe7/FPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Hx+LrfinJ+cKXfOoDEnRa6iap2I/5fgh1ug2S6gqUAVQgh4Ru/LwyE73BnFN6NQrh
	 gjbWihRk5WcBvYsVG/AnPSbAEUV6liOXdlVKFi4/ulUPLEMytc7GZ8nsqzwLHzx4SK
	 Pw5D8lXtNGYpGC3/QIYSOtEgqqzQTyakl6FT5lAohHexuw9GzVg1AKiMzpQV2Forrf
	 w+Av/aNks8R9+hayu8/OToEhj/0ictjzU3NChnqXOA7LuF4cYW/zdR/9Rpup205S+V
	 xodva+pE5WpqpLnVNVxT+XD0yu1HBM6LgdMF+3mfWRO1ofeLMFLzS10+DiZUGbXDFR
	 CU3cV8yAVBq6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A416247977;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:59 -0800
Subject: [PATCH RFC v3 25/88] KVM: selftests: Add basic test for sample
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
Message-Id: <20261106-gmem-alternative-providers-v3-25-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3413;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=egSCIn/Z8yZyelQp7cvP3qLOE5NIjYa4+lOtgqtkCcA=;
 b=eS+nI7PxlE1maO7QU8JcyjZXzc2ref6sfu7l8coYHFOVhGHBKNsZtFBYoz3WLd43hTPKAb1qs
 PP5daxaQ65oBQ7t7obsP+mJagOwOWNCEhUA/gMKhIeq0BPfUyn6q5uy
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a selftest for the sample memory provider to verify lifecycle
management and file creation.

Verify creating provider files across multiple sizes and ensure that
initial statistics accurately reflect file capacity, zero absent pages,
and zero read-only pages.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../selftests/kvm/mem_provider_sample_test.c       | 85 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)

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
index 0000000000000..b39161f4933d3
--- /dev/null
+++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the sample memory provider (/dev/memory_provider).
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
+#include "../../../../samples/kvm/memory_provider.h"
+
+#define DEV_PATH "/dev/memory_provider"
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
+	struct mp_new_file nf = {
+		.size = size,
+	};
+	int fd;
+
+	fd = ioctl(dev_fd, MP_NEW_FILE, &nf);
+	TEST_ASSERT(fd >= 0, "MP_NEW_FILE failed for size 0x%lx: %d (%s)",
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
+	struct mp_stats st;
+	int i, fd;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		fd = create_provider_file(dev_fd, sizes[i]);
+
+		memset(&st, 0, sizeof(st));
+		TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+			    "MP_GET_STATS failed: %d (%s)",
+			    errno, strerror(errno));
+		TEST_ASSERT(st.size == sizes[i],
+			    "size mismatch: expected 0x%lx, got 0x%llx",
+			    sizes[i], st.size);
+		TEST_ASSERT(st.absent_pages == 0,
+			    "absent_pages mismatch: expected 0, got %llu",
+			    st.absent_pages);
+		TEST_ASSERT(st.readonly_pages == 0,
+			    "readonly_pages mismatch: expected 0, got %llu",
+			    st.readonly_pages);
+
+		close(fd);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int dev_fd;
+
+	dev_fd = open_provider_dev();
+
+	test_lifecycle_and_creation(dev_fd);
+
+	close(dev_fd);
+	return 0;
+}

-- 
2.56.0.455.g6c5a503b38-goog


