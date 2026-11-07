Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011846;
	b=MFI1OgFay6o4LFWhWQ23TTa1Z2SWB9unMWlx4TvWm3Talb7/f9O1kJ1DJG5N8LGsWVDC
	 Rht+V7PDM2lnRknT6WJVsXmmLBWx+Nt7oHnUbGIs79RV1pJ7WDYfBNjcXApPVwkV6C8lx
	 0Txo1SEvaBGnN9vBBNsGbF+fl/rFTw83q+K034L9Y6axhDYnJonOlXx/ZiqB7l3M6IPNw
	 i0jWV+AKgv6/O4numNt1RK7wao4MCFqQNAHu7pvpEsRtQdo+AbRpd8I7ukeKPiXKKJ3mD
	 F41FRihiYGFp6FSLkI+TXmpkemcpfzs9fNiHJUIob5LtEEQx5b+wialCE42T5UQ7vDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011846;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s0F8jvacFzHXtq1BNYj1XM72iSeOawkyFa8eWHiNWfw=;
	b=PRY/H8h8TaanIzWK5fGCdaNS9voubOOEBKCXrDTpIfh8iaLZNM2byMczZkRs8SDae47l
	 lQ2DmK3k9Vqsbp4nwYY5ed6SwOanidh3R2Q0kbrxl2VV/iMCGf/F1/3aYlRbFdHHPTF75
	 ZtszZsa8JMOIFO/hzPOAbg+4LXHllkqJzipZfUugu85sbnOYwevuxCvK/hhLzKweoM0W7
	 JF1r7y1c7u5vY0eo5xbPIQK7tKIOfU6BZ4MGZ/GxAhQoAnE9gMQyx9mEq0KfRiHmILTOb
	 w8AiGXmHZrancZCLac1zixaikOLyBhFAylXEOuZMHZtFipWYiqUWvS3u0VT+4zZFJlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cjRjDf/U";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B4606BFE7;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjRjDf/U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011836;
	b=ROLs1mGmGaXr4nf5VeW7xa4FI4ARw97o9g8w4Mk8n6OrZSg8GX2Ph4gEE3y85HJz3aqQ
	 cJsaG/CRZfOxrYrCSPkXsp6CT/PP02sXJws9G1y4RPrDf6SwrMstI+KsqPE4VeR5Ci/lf
	 vGUd2onDjiBvaj0rCeapFfzeeU93l8Pg2TwkEIXrtpm11zDB/X9Ch3tgMVPnf9QT44al6
	 R0GFoqhv1H3bWvAYtcNP9ycVi/je+y/wlokWpshBCFMlfcocEvM6ISvJJz7kLC1f2Eu4u
	 aS2hVxU+HlfCX0m/HxYAvOTefosaMqYbP9dUTrYCHrW4qx+ePgWoMh9aob5JOAa7jIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s0F8jvacFzHXtq1BNYj1XM72iSeOawkyFa8eWHiNWfw=;
	b=B+OkdPsHUv8ySdiYEuVCd4HOaAVFZlR7RUbdaghw0ZfAw3DdDbHmZsKyVxmd7NJnHAi0
	 yx+0/3SXYFXguDhF0q1U6AZcFkrTC1LbZXQ2tdG6iPtvZON9dJ/OMMSKTsIK7yQ0wBAZW
	 8cBKNtmHGDZF7u7CFyeZ0UfzjhwGzSOV3W+Mj8Ph3/O+FchJT6iGzvwrZ0v3tlNChXHfm
	 kn8xCb6QtNebwEfUVN1IcjA5g9aEZkNiZ78Tm5F+AeO6JwF/ZT33f/VM7htb9moJglZX1
	 27y64/foBL5hJr121aSWrdF8IATf3/ch8TBFYAj3R0iGnRlVgizrash67KmBn/tiEWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 537A61F0092F;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011836;
	bh=s0F8jvacFzHXtq1BNYj1XM72iSeOawkyFa8eWHiNWfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cjRjDf/US9xa3V98KO6V4mH2o1LdydfcwvxsMwmk+UkSwxLoF3bix9AAFi1lzaVja
	 qRF1IFAD0pt5NU7eBEQtDsrKBMJcGVztW1hkCADtM3qr1zgcGGiDx4BbNtz97WSS3k
	 qLtOYWrvFc4ktIXZtWXvTvEinxQl9t4biA8nXcmHKITXdyoK16Af4nN/1Z2CvZPaGg
	 fnD0gJMouFMV1T3VmBAkeJ4RNcxbo40Dwk1BV9ps4QgR8RtpYoPOvg8bVVzzNFaxnQ
	 7TjnZzsf/Ii+ZNv9DvooPJ5KVwP1XXx+GqgPwrAro/7pngSUGNVWo4qN9Isf+H/Y0r
	 +/ZLTgbufeX7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB285479BC;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:17 -0800
Subject: [PATCH RFC v3 43/88] KVM: selftests: Test flag dependency of
 PFN_MODE on USE_RESOURCE
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
Message-Id: <20261106-gmem-alternative-providers-v3-43-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2495;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=EE/Gsp3+vkbnMZChnYBAJO/h7nnosq/HYGBfPtTEjSg=;
 b=QNfSEUjkf0mmaRJLidwIxGxZJjYboqSAt3/LrwLXP/KiV2nJmCAw/FG1dfUDbyKYK7iveNUQ3
 h7EkpJWjXFUD0P2174TJKMc5yyC09FzAG8K29bj7LwtBDRnjEvqoMxu
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Creating a guest_memfd with GUEST_MEMFD_FLAG_PFN_MODE requires
GUEST_MEMFD_FLAG_USE_RESOURCE.

Skip testing GUEST_MEMFD_FLAG_PFN_MODE as an isolated flag in
test_guest_memfd_flags() because creating a guest_memfd with PFN_MODE
alone without USE_RESOURCE is rejected by KVM with EINVAL.

In test_resource_fd_invalid(), verify that attempting to create a
guest_memfd with GUEST_MEMFD_FLAG_PFN_MODE without
GUEST_MEMFD_FLAG_USE_RESOURCE fails with EINVAL.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/include/uapi/linux/kvm.h                 | 1 +
 tools/testing/selftests/kvm/guest_memfd_test.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 66c1f40b50c29..3ef7bc37a7070 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1655,6 +1655,7 @@ struct kvm_memory_attributes {
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
 #define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
+#define GUEST_MEMFD_FLAG_PFN_MODE	(1ULL << 3)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index cbc2f309664b2..fb9d50be2e3b6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -407,7 +407,8 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	int fd;
 
 	for (flag = BIT(0); flag; flag <<= 1) {
-		if (flag == GUEST_MEMFD_FLAG_USE_RESOURCE)
+		if (flag == GUEST_MEMFD_FLAG_USE_RESOURCE ||
+		    flag == GUEST_MEMFD_FLAG_PFN_MODE)
 			continue;
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		if (flag & valid_flags) {
@@ -432,6 +433,11 @@ static void test_resource_fd_invalid(struct kvm_vm *vm)
 	TEST_ASSERT(fd < 0, "guest_memfd with resource_fd but without flag should fail");
 	TEST_ASSERT_EQ(errno, EINVAL);
 
+	/* PFN_MODE without GUEST_MEMFD_FLAG_USE_RESOURCE fails */
+	fd = __vm_create_guest_memfd(vm, page_size, GUEST_MEMFD_FLAG_PFN_MODE);
+	TEST_ASSERT(fd < 0, "guest_memfd with PFN_MODE without USE_RESOURCE should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
 	/* Bad file descriptor with GUEST_MEMFD_FLAG_USE_RESOURCE fails */
 	fd = __vm_create_guest_memfd_resource(vm, page_size,
 					      GUEST_MEMFD_FLAG_USE_RESOURCE, -1);

-- 
2.56.0.455.g6c5a503b38-goog


