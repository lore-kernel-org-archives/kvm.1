Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011826;
	b=5sVYAF4T+J+AUJF98lXuIElWgbRwTZIss6SZ+jdcgIW4lY63B/tSOgXyuGEE5tI+Kt5o
	 tU4DVr1ij/NKfwIy1pEEPZT8h85/rdPqcE5HesNAOpI4fZRFPO2xFBzkhJOJQ90Vl17De
	 72/XcvO9xXF4Aq5rdnk62Ahz4lBpIEbUHJiEBCY6L5SKqq44tCU/vBgr7GMbWJh4ZudOV
	 eo1k5EQtrizD1caD4RE00r7zjTvW4YKQLAb5lcS9x4D3skKyBvPpmLAL5D7DyhQErPYdS
	 m8p7E8AtT+s1uk5AjjI29wsZA3x253z5H/c5OqjEIIK0XN9CicV5jmaZLHSEl+hA3yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011826;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8Tz/4R3+nBGJbuRMe2ive2nBKLEVbhjpacp28U7sWIg=;
	b=T9HpPy9tj3B/JEi3gpPzCLFPwp2Vz5a3/Xo9itvw3qF6dSLhWei1AV7I7Y1MNPaNlYhM
	 T80u3X68fskQuLAuPbRT/QrqX0XFOWsmWFFjFlAupGjaqD6qpDOqb4tCiraT6Whq9Ks8H
	 t25r8Cs7mzJTqBoxkF+9mkDC4e5ml2XJtV7QO8C+l3ZdJZ1tRRvfnuZ7otbCMlou8pg5I
	 VSGj+kGtDRQTTaqB2qKjaMnxXWQWPbayE567mPhcWjuHJkvHBvMM9Tr6y8JOVW6fqODem
	 pCnvFZY9LaqYE0scr7DNt9jVhTUgn89Km7FRVxCc813hTUtZ3oecImGpSTGoGiP3ixA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcFgk06y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C047606D803;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcFgk06y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011826;
	b=us3VkzdYHP08912mKq5PN8ekRTFJmXPZ04BxJYq9g68sMU91aqsJTY5SgZ7AiioWEoPh
	 ZQBZiprsMcjB+z4SZUyo4Ut0EFE74SJk11aF1idkiWzht8ZhPh4N3TO/bSW2ZmKebqFLN
	 X1txzHT+KCxLN6gfhOd8GBRmRrgPVFIoSVLu8V6OL6uZ85VY8M4r+eCSVU2XoCNHixC1S
	 exjDV/1rdkhAPL4/k14HRnTqx4mWlZfwtSRCSHZ/FaV6dCTzgMhxg5UMXbMwJCQG+RWvL
	 LMQkoh0RCLn12i8VV57/RKT4LWfrqk7oeUrWDqwgoL/6zmSY++vMBNULttKt7QHJiQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011826;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8Tz/4R3+nBGJbuRMe2ive2nBKLEVbhjpacp28U7sWIg=;
	b=RBNzmu2e/EnV4QYovyyO3EZXgsLuTFRniMk/XGr/g6vX3EPHBWe1xjsnX7ZxVnzqLsHG
	 oEx+OMR/dwI40100Qh0U5q6v6GmvWuRw2OiDL2xsGW6AglDH/g+jLC5vp1tsuTrarOB+A
	 ok3UBgi5xpyUq0pG6qXWG2YLhznO/WclX+E6VUuPptGXO3we2XYgImxSH1poKThHWUPSU
	 BhJ+yMVSgSXWV9w/iErpagk/eJ94FlJ4g698xI/6UkrYjzAG6fSr7x5Pqz/646uA7sif0
	 rqYnPve5mqcyUIqYpMBqJM4YDhRFctSxlITbnlLEfMmH2NR5rUZJibC11I+XPAJa58Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E6F101F008A4;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011825;
	bh=8Tz/4R3+nBGJbuRMe2ive2nBKLEVbhjpacp28U7sWIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YcFgk06yhJGMx4ocEtTr3gFzuX5jO8NFKmGUP29JT/g/8d43ZnvGlJn39kJwh3ifM
	 sGG8YUQn6msPVOxgGAvKqsJsbl29PDvVcHnOWnqgnWzFiIg6Aj0kyXuLE7l8kAlLW1
	 vwMSI5sZkeOOsLiHJMPWhXENSb9ZPGn1Uq8ag5oKrlFKzCTePF3XHaf2QiH0cCuHSR
	 r3SFVQ4M+MJQbiwJD5gfbiEQ7jV2nLwgR23K6L7k2Je7bhUsMhhofNqGGRcwPvqDow
	 RePU/m4urp+n7NCqph7NJ+hxsB1kO079i5FeOarqAVutz2CmAsZIo2YjCnhRnhwks/
	 wLD2gE9JJXVog==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B52414797B;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:00 -0800
Subject: [PATCH RFC v3 26/88] KVM: selftests: Test marking page ranges
 present and absent
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
Message-Id: <20261106-gmem-alternative-providers-v3-26-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3215;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7QFJFoFyo46UmZUpk/RDNGh2vejWq8fPg2Gg5WaYGKY=;
 b=ohlAxuF/ZwnJnySiSieqvLG3K3rQ2HRF2CfC9ljofHA8P0oU4N4eE4ebYlYM9FPPevFAFBfew
 2jjSIdh2dl6D92vo4evhVx/SgIK++1Q/1C6fef7z+b8ldarmKvndCR9
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test dynamically changing page presence in provider files via the
sample memory provider interface.

Verify marking pages absent and restoring them back to present, ensuring
that absent page counts in statistics reflect each change accurately.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/mem_provider_sample_test.c       | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/mem_provider_sample_test.c b/tools/testing/selftests/kvm/mem_provider_sample_test.c
index b39161f4933d3..8fe634b0b4f2e 100644
--- a/tools/testing/selftests/kvm/mem_provider_sample_test.c
+++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
@@ -72,6 +72,70 @@ static void test_lifecycle_and_creation(int dev_fd)
 	}
 }
 
+static void test_set_present(int dev_fd)
+{
+	size_t page_size = getpagesize();
+	uint64_t nr_pages = 4;
+	uint64_t file_size = nr_pages * page_size;
+	struct mp_set_present sp;
+	struct mp_stats st;
+	int ret, fd;
+
+	fd = create_provider_file(dev_fd, file_size);
+
+	/* Initially all pages are present */
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == 0,
+		    "Initial absent_pages mismatch: expected 0, got %llu",
+		    st.absent_pages);
+
+	/* Mark page 1 absent */
+	memset(&sp, 0, sizeof(sp));
+	sp.value = 0;
+	sp.offset = page_size;
+	sp.len = page_size;
+	ret = ioctl(fd, MP_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MP_SET_PRESENT (absent) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.size == file_size,
+		    "size changed unexpectedly: 0x%llx", st.size);
+	TEST_ASSERT(st.absent_pages == 1,
+		    "absent_pages mismatch after absent: expected 1, got %llu",
+		    st.absent_pages);
+
+	/* Mark page 1 back to present */
+	sp.value = 1;
+	ret = ioctl(fd, MP_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MP_SET_PRESENT (present) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == 0,
+		    "absent_pages mismatch after restore: expected 0, got %llu",
+		    st.absent_pages);
+
+	/* Mark all pages absent */
+	sp.value = 0;
+	sp.offset = 0;
+	sp.len = file_size;
+	ret = ioctl(fd, MP_SET_PRESENT, &sp);
+	TEST_ASSERT(!ret, "MP_SET_PRESENT (all absent) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.absent_pages == nr_pages,
+		    "absent_pages mismatch after all absent: expected %lu, got %llu",
+		    nr_pages, st.absent_pages);
+
+	close(fd);
+}
+
 int main(int argc, char *argv[])
 {
 	int dev_fd;
@@ -79,6 +143,7 @@ int main(int argc, char *argv[])
 	dev_fd = open_provider_dev();
 
 	test_lifecycle_and_creation(dev_fd);
+	test_set_present(dev_fd);
 
 	close(dev_fd);
 	return 0;

-- 
2.56.0.455.g6c5a503b38-goog


