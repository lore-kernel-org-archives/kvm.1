Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711703;
	b=Aoctp0VMZkKAAqN6Gw4E44csvjk8VRsMbLQ1j43u1kxmZE3w9owGxSslN/tK6U7ZnTix
	 3XDrO+FbUOP6ldjJMi9rRdqiaf5+iVxd2f5sG9d3yIi23uI77ZV+YDcnmjaLcmtIgxVmj
	 i61Ynqzf+2SWDy56iFNx1cMlIrmyUOpuaXin4Z9z63OOO9iS9bGEnVWlWN2t/JJjSwavY
	 INZD/pfpj33S8HfV25xyvi6a+7xwLLNMh97OjiReint46A9rRUhVA94JXa1FyrC4F0tuQ
	 em730UF8fBedC0w5ryAGAYg2LU4/SfUia/5hE8C6kXHsqtsf17yeXfR/HVEMOiuSlMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=12G1tUKOcCzdQ+EGKbSED/OM//Ixz2V7HJnGAxW8y2w=;
	b=PINWp3lgsSLi6nY5nTWdtBTmrysoA57LXyE+6n48PcWOEeIrLLI6QY9oNZbpEqImYcF3
	 Yn6TTvs6pxO+JhHi/JRUADDuDKDZAg7NhNr0tXiUmHgGInyM5Ja2BvagpZSylLSM1bxve
	 vf9H3T1nAgi83w39LRC51JxxL1f8o0P0s0zzhVSEnEqMWFlxyNGqGiyoegga3EzP2tRYB
	 RAkh2JF/OPCJYLgviTzV3hoTTfmx6D4W0t0hOxVLRcg2t4F5SdHcLW+INmOArHIgBdpUL
	 meCl03tVqvbU8LTpB2XCrXGVS8OxdMOeup5Ps0hCd5qyu/xM+oIBdMgzXLii5EOSJsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RIvYO/NQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BF6073302;
	Thu, 22 Oct 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIvYO/NQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711703;
	b=Ji2mzA2EOfTPK9jsYhDXohgg/n5DKramxdJ2O/ev6t5WsI71Zrs2oV6kRF5Bqdfz/hO5
	 +Hx1zhbK8BpP5geeIOQJhZHz/tQi35cyPNKL6zfZ115zFmf+CWIu7hF/e0Sb0yPhiiLRd
	 O0As1NHtA/QU6e83y2Aa/PjHkdrpQ/KySGUXokWKVc2ySBprlgaKhFZXZG6U5AtP78QJW
	 1NxL5DkgzQzrshnyqVN8mXMOZzAjvo2QPgxQsymft5DsZTor8FX63W64zGyLNETYTPL3f
	 eDATX8jaTFa8XZNTTxYp4XEEtMdbjORVi+guGOoFQ5ri3AgISN4sxs5GZlr+HkThPig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711703;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=12G1tUKOcCzdQ+EGKbSED/OM//Ixz2V7HJnGAxW8y2w=;
	b=gQlqOaP7qvMA/DYQW5xK9U6FzSDmYf3IUbG0t7AwqZNGBpSfgK7fLjD0lwWlb/NJBf0u
	 tv2DaNv+D/+9wUaooErcC6wm6lJ7YTnDE1JEqlEX8bZt8E28nSQdczc5/QLWYF+Mkaj90
	 WdU2YLdvchdLgFzNDN4fpH+87ixCuOoo7IJWK6Fg7axaDAfETvaepZSK2IZ/ngiWzIa2V
	 GsJ5+SzVSmLWWmHLZ9hvshpLalNigliR8MHPKeXsZDw9/V2qKPSBoMyZ/lFtVLPIVknSE
	 i/da7ApM5Y/oeaB4Ce1iH+EigAlzcv6iWJBzq/TPuGbl7AixnUdGd5GLFdX+KxG28nA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27C581F01196;
	Thu, 22 Oct 2026 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711702;
	bh=12G1tUKOcCzdQ+EGKbSED/OM//Ixz2V7HJnGAxW8y2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RIvYO/NQDpufew6XKWfjIrSSeAbZa+sHOsgOgU52oBFjzE0TLk0OhwQtC2jpu0H2S
	 L0zSra+2ZKPg71Gl0CwS1sUNoWCLu04bKFN2CeZRYCriHuNA+qirEyWxW9YyGj0J6S
	 A4awroWwF006oO2mQVVlMXi4SHDojliy2zVe7HYwspVfl6B8vq5LqPROI9/4JYghnz
	 SKKQZ1QbaF1v6uZNYfrT/VxZer4zni5ttGFRhGCI02QyoXY/1NNedjLdczoBLHIEaB
	 mxe9Dv9FubwJ/jnhU3zifq5gBIVRjAKh7bNdnEgbVMiBcWM7k3fl0vxlhNqfbAUDOX
	 6RqHVoukq2XVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62D62420F3;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:16 -0700
Subject: [PATCH RFC v2 44/50] KVM: selftests: Test flag dependency of
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
Message-Id: <20261022-gmem-alternative-providers-v2-44-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=2495;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=hW848+QLjOl269a7jTABrUtgNNZFcVVtDQ3JXHLCB+w=;
 b=fU28rqS9xlt6ezgnpahjWog+2P1ewPQlBSE+tyB8TuF5+17PJac6BxJaoiYMYysn333j5bn6N
 TnDkxIkJYU5ALgLLw+3zeLxvcsKbeB38GL6yfutX+0WrdXscM2rsPom
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
2.56.0.257.gf7497c7d27-goog


