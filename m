Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011818;
	b=1VkwFP/4+Xca0MCE83guXgMRXYSREjtgJbFO5sGB00uxEjU73XkKj5J/eKRO9jHdwvKa
	 0/011Fy1ibUhGmpu+jq3vHA+pYi24HuLLnP7keKt9erj2iLWnSNgInjrq/lUhBzZ9p71P
	 3AASJBQfhF0QlBb46i+ozvptY22Io8kXNwoso4/yTM+FdMbaeL1WTQFotXNrA1qRNCC1+
	 uxI82hpniezdN3Q8MjmHqr0c9Q3i9rHr86lkIISWkrfJi6LjIZrE1dhWrwW6mfj9ldjw5
	 jRG2BiNnsjlBmxmuWacGYyGOh4kvx4AHDnzE/KsVG/YvjBd94TkUvuuITmYy5C2s4Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011818;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VLo4wSV4BvGJmZfunAX25yUFq4cfEBViuYey2K0U8Pg=;
	b=4Kwga2/ft+ltwfsJfKPNHvxL8GtxbDo0p7Xj1m7EhmwlqvqTR408rXP+qdW0eDAxHXCO
	 /e/9/xVHSkWjKaSwGdD1PwnyJwHIBiIBq7YC0LyQC5LkKTQZO3S/KIAXI7e4GEPdf0ceb
	 DnqtOWbFa9svxKi64QXTGtx/LiPUnfZGy3yBA800yC/iUmP4CFDpNsDJyN9JrraPzD2ak
	 pfeutx9UYhVYTNVtT4CmDJoTEmkmt7MZrRtKgqa1guZ4nQQsrOq9kUU5muL8FKfRN7pQB
	 nUBrqrmdR0u3JCDTXn+72S5/akWlPMdntF29rVhaWZMCHXRGf5yLUyZFWTcSpBYQ6ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJBRf9AL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D350606EE8B;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJBRf9AL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=HVq8nLAsD8c6Nf4hzdEj8wmcIqJTIbURRZn8uJgzUVH6znvcDuyaElcbFrEu9k4/RA7k
	 sHrgqDvFoUbc4/LEU9H2t0n5uAGGaOy8uxotKG4z2zIlJXpljLV0rMOJXmBLDEnVmgzQG
	 tnI2JEudMvE3pri155l4dfLjnqxOj4htKgTivq8zyYcAJomfdhOB6JZuYqt3qzxOEOb4g
	 V4rgpAHScysvpKulRMhVNz0PsSH0rGd4a/AIJRPNc7KEgJDYqeQH5zqXObH3Mx7GPvIuq
	 julFuaXb9KQEXZKSO/TbDmueTII3c8baMnpyYvZJoWPntK2m1ox0WbTpfNzWECMs3Fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VLo4wSV4BvGJmZfunAX25yUFq4cfEBViuYey2K0U8Pg=;
	b=HQB8wnP8+HwlrXSuye36K0yHABPb9B8mU5HkVGSZfR6Xpl4dGY3Y6oSXPbY5V6m7oB1Z
	 9Z/10VQJMcWeefARYAKgocidNc7+dgFw81oV12itRZ414rEG9Q2b4RomE1CXwK12mL5kH
	 Yw5nVHtAPE5AMlTe8qJispC9jgdi0fNdjbOsJyg/OaPgBS1lD8m4HIy9DDH1pBPg/Dxrc
	 1fV5kEDwROk0r6EP5EY7V88H3JontFt1wI8gTf4YBq13lVpMdQv8bbRzjJAEEo3tCy+2b
	 HyJARzdFKxgk20v5iN59LLzpLvMgcu/RYTA2dzJgGiAHZJYKO1JZ3csT75GqHx9xyZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15ABC1F008A2;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011817;
	bh=VLo4wSV4BvGJmZfunAX25yUFq4cfEBViuYey2K0U8Pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kJBRf9AL53hjDYlFL1lzfJHZby/p/ZCRNulfOFyCTsU2RlDMQygTV1wE2LeRwy76U
	 Hl1eLhdF/XaMemq+Q5tvhud6CCHMEwMXrlX+VuTCWJ2WR5ltvP+RBT4lWYQ0y2cQA7
	 efgjqVmoTkwrsKrNaUQAhRsvH2d0AMBsj0JQKBQkoU3e3VuVrIuzHFCJMkzs4D8g6p
	 5qWAIu83DBIndcutZulGfr+V99HYdPp1e/5KIdzYoHaSOiRpUVr9qeO2BaToGzdLQW
	 2R+0ED1wulxE2GEBOlcjetWCwXIk6+fSIGMonK1yAtsKC6hdHfOPfW36xMpviBsWdD
	 CqBhEWAhjYJ2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A38ED47940;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:45 -0800
Subject: [PATCH RFC v3 11/88] KVM: selftests: Test rejection of hugepage
 tmpfs mounts
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
Message-Id: <20261106-gmem-alternative-providers-v3-11-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1589;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zaKeMs3KSPAZ8XLq60eW5ZyEksb0RLvUfV4AY70LgAc=;
 b=zeNTQ7kWnwbnhgfRFPhxMCsZcOxq/l4xAVbQXp/pXp5aSFeR9lcN41G2KfoYyBwXFCzAiW0mT
 Lt5/IsQXI+1CtSyrPUglpGjVqkZIx/+5YtoHzvnxaiCI5O/YoQ6/TYH
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Ensure that guest_memfd creation fails with -EINVAL when passed a tmpfs
resource pool mount descriptor that has huge pages enabled, as required
by the tmpfs guest_memfd provider implementation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 205f822e10c6c..541d8cdd0bbf7 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -547,6 +547,21 @@ static void test_resource_fd_tmpfs_swap(struct kvm_vm *vm)
 	close(pool_fd);
 }
 
+static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
+{
+	int pool_fd, fd;
+
+	pool_fd = create_tmpfs_pool_fd("always", true, page_size);
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      pool_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with huge-enabled tmpfs should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	close(pool_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -609,6 +624,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_unsupported_fs(vm);
 	test_resource_fd_memfd(vm);
 	test_resource_fd_tmpfs_swap(vm);
+	test_resource_fd_tmpfs_huge(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.455.g6c5a503b38-goog


