Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711676;
	b=vobEcwBz49QNwV1UpH4eXg0RwmFmyHhB1CTsp64Qe8MYd7g6IgXoyJvJpLp/DFlW4Kaj
	 5RSYIhYwFWnigPuA3pag1FX1lmda6P7hbDeidkIwCBWT0BtdIIVR2HmJkvf3cHcuGsPYj
	 30Trnax6mSmc7RbtQGjvGhDD+ujbw0mGU5dUnQi0MZ0k/Yuc1bZ5ioRqB02sHaJF3W5FO
	 iXCziXnowNhEdCtf4yg2pIArYa64RW+Ey0LcA4JQGbRTTZoaQ+hbs5ObiEB42OQXt0tNC
	 3etcLZCEHkf3QMQ8sY38ocSOakOf8yegOFvBuQXtp3MOmqYs2Ct2HXIJBjOfcaLMOpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711676;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mw8NuWe2zt3uYUYLmdslwurewyfFMdDfAeZucA82mOY=;
	b=bo07rKfucjUcd8mXnkUzbUnt7cOvGRS9TM1PGv2nqHyi/PkQp0mAq+0JH6PNBa7rsUAJ
	 ycLGxhXYdfhBJ10nyW+CZNkA0oc2KyoAoUUioGY9uc4FIq38Vls99eOZtz/2/tjEZpdJN
	 YU72MR6QcsFm8W10ipElA+1EePR7jsLMLcB+L4VODP8VJP94IMLeZXQQI1tdQtkAsVmVK
	 Lox06C4IjjYLxxZmiTLRp7WwlwxNJxauLoZJZFPZhiHFkSx0XxjrMYuz8qBRd+qP7pKz7
	 MH+454aIAXSh0yOhAor7Bu7NsEdVy7VCOyjLnBOg9FScx3EX6Vuz9IBhmB5bwpATx+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG7HU12f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39260A263E;
	Thu, 22 Oct 2026 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG7HU12f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711676;
	b=Ibj16u5/bIRb0iNZk3zDQYwojotUEHCdOPDwM0csqkXRoCYqMJkWWoGFIkM22d/L9HmJ
	 H8+eLv43Wroi2SUA7ZIAG1Ql12mOFkCwKIYsrH2aqe2KzodLBCh+gQ0tUhahIAM7xoQ0B
	 ilva1KVoiwxroJUQzUQiYPWyB9MwItmJRqr22SoubxP6FUD3stbaArNo9bWwEqIn7tLNG
	 dIEE8jlRoO4Ao7VBX0DMNkj8ctphqdjTgSx5NdNiqpy6lXBFfglYvhksbTfAVqBA/WfsO
	 7j55xDUeJjgnr5KNQEzUKtQH/0YOYnvvU9U9TZadmCFvVRMWHub5LslCv+W5EruxmyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711676;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mw8NuWe2zt3uYUYLmdslwurewyfFMdDfAeZucA82mOY=;
	b=gkp+MIEIIK0WwRwQBspHz0Ug3TYopEIJUeN3dWhUQTuM9/bO1Ppy32+rVnvo4gPsWFXn
	 Hwk+mpHHZJ6Li3Z60AzhnRURUqcd4XkBJ7bEi7C6Rvl5qAP51SuhqmZ22HyJa8waE/vzo
	 vl4NnRb8l4JTAxI032gN2WV+HhtjCvcpzIq1PtS619c5PBuoPFxLCtcxor610AtE2ewyH
	 fiNhHrMcS3aPZH1ty/kW403Ap7NUnTmo4pM4gBo8m7MijzOWi3wDSJkHSOvk8lgdCKa3D
	 y3VnETCptW5ALMXWbJlMQXAhp7wCqIwF3Z2YHXF9j+wuaR57a75C+AWYVu0Y6OgYD6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EB631F031ED;
	Thu, 22 Oct 2026 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711676;
	bh=Mw8NuWe2zt3uYUYLmdslwurewyfFMdDfAeZucA82mOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DG7HU12fCW7Ul9TeYaF8WXju1U3fRV6dSKP8Zo5SyWXPL3j7JLlHg7+L/oNHCHr3u
	 PfMIZDPm+hJZLPo79G1+eaDuIxHld/Ld3PQiqS6sx6OsVoAyio1fP5Az8P3N7LFf01
	 kndl3QAQN/aLegK+5A75g2IetIk01Y4KZ8O1zukE99woUtAYezf0zCf0sXDHYJtfSo
	 r3ZqFPuBvGItzEoIHNxVlTqII0VQOWp3WSP3IDu07XH/YWqf05F0gQohf+cMAR15KI
	 7ciKv0w0an7+IaghWduTvLXFxlnoiUzBMQE3ihz3xyFzLXguBYDbODnMnVDPNIPSRe
	 tjHuyjhOJ4FFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9BCD542062;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:40 -0700
Subject: [PATCH RFC v2 08/50] KVM: selftests: Test rejection of unsupported
 filesystem for resource_fd
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
Message-Id: <20261022-gmem-alternative-providers-v2-8-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1756;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=MKtSCk+ZsgV89o0Atosj30SncvaeVEKWTGxyjRkwt3w=;
 b=LXu+Ja9u5BkvgZlmzPdoqaK+INQtueJHsx2u2mHiJGo0Qpee/AO8GRK5ofjeZNlIF2IbkfNgX
 MPs2NATgGOTAyxWhfu7Nl1Hb2BTO+4kwolIttfLzGdtRCeA//sq6R6j
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that passing a directory file descriptor
from an unsupported filesystem without provider operations as a resource
file fails with EOPNOTSUPP.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 3313d306c0bdc..445396860d819 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -436,6 +436,27 @@ static void test_resource_fd_invalid(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(errno, EBADF);
 }
 
+static void test_resource_fd_unsupported_fs(struct kvm_vm *vm)
+{
+	int fd, file_fd;
+
+	/*
+	 * Passing an FD from an unsupported filesystem without provider ops
+	 * (e.g. the /proc mount root directory) is rejected by KVM with
+	 * EOPNOTSUPP.
+	 */
+	file_fd = open("/proc", O_DIRECTORY | O_RDONLY);
+	TEST_ASSERT(file_fd >= 0, "open /proc failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with /proc fd should fail");
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+
+	close(file_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -495,6 +516,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_guest_memfd_flags(vm);
 
 	test_resource_fd_invalid(vm);
+	test_resource_fd_unsupported_fs(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.257.gf7497c7d27-goog


