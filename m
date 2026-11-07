Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011820;
	b=HJogtzdsnNB63uN8/xJJxHP3z23L5wyxWweVzFfgk0k4l6bf2Mkmgx9aude2+llPKb6p
	 MjXuzo8j79f5VpZ7psUdhz93Ktg9eFHyp/jRxgpyoRwYeKE9ILuYq71V6nZ0MSX7ypSKR
	 Qs1nCMaVEPHkhnUfvcTv3SgJk75XfaCxoGswsOEl9j1q4PsFPtokOvugck2L/B1QDGOlW
	 UHB7DNXKAEwUQexn20ZKIkhKyD5ieGf1pTTqaKA/ytai3v9Tac0BsjLhgBCBcvWDn9rVY
	 UeiomjrHd1h1BD51ojmLzoVvo5IR4hVZyQEag4WL0xom+BmGSW23qrc498bAXCBPn3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011820;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OOyDFvCTuGXq5yquXw+y8Fp6MR4CefxX7U/6uhjSYI=;
	b=tGDXdJU1x9UAYEEcjpvD4gKIt+4ShoXmNTIV/yf3dxEsarhPJFWgy/bzYH5B3ZI9vDAh
	 eTwSHQGRSiPyD7Nvg8EhZ2UrDyiZ6gM+9jzKQS7OgAjrRh83v0UQXbMyGhGxOLhTnBJ0M
	 lmwA2rox1oGY48AeDQcz6BGA92Av2MQMCfTUvlRymOkUMy8PHi3S3UVYrX5VgOYkbcCST
	 D6z/APhEijJYfKuPuQyGlOEVz984QH9n6g8k/cJmGwQMyAWEbI2x66GhYM1AQ3pX9MI7x
	 lEcGyxPqE7UO78+OL3fJRzr7dKGclOz/fUAnKuB8OJjSMHpmfAesvDAxabo4TDAm2+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nK2zrUjr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF9606A334;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nK2zrUjr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011819;
	b=BpJWEE76/Bpu/OGOAyY2F6pZlqk+xue0SA+Ul5knW/B9Xs6rEYl5VBxjecNm2fin5hRs
	 Q6+QMYyQH7qoLXLUnvmOLBrkNSFp26+d5EyoIzvFcnOxfI5KOt587pu5KCYrcDBbuttt9
	 ffk4/C8xek2svET8dNdhBJ2fMB9sS4MZaDYHWYIccd7rad7AxnGEOU2Pf5TAPYHwIoag4
	 d/XJWW6exeBfUuPw/wqejhG9UaZO3vqgPZaoVgSbT2c42nw9MgNqR1i99KUg0Gi/y+vo7
	 AwyuL8qZuD9NLGTTyM98UnanBsNzXouYK8jGG9bjtg8AduBp+PZMS+kPYOszlBnwYgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011819;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OOyDFvCTuGXq5yquXw+y8Fp6MR4CefxX7U/6uhjSYI=;
	b=CZiVDPaKEDDBS7LzsfZEX9gsmv3pObtfU6pFHGWKPB7tbQfH5PutVsxpwwytRfxNa7nr
	 0Wq2lxZCPgwlVTMuVZFIOerJoMNMm7A5QXJHKJwq/LXR5GPRkNPNbzam59xjT1kpdfLU4
	 hzjM391CAhaeEa0I0j/vRvNhqxYPRFBA6F23Vsz2elv7sKkMfdEo/j8oDccJTiukzD9Ke
	 Zr6IOtFHDeXKN9tvvcE/yo8Che3BAFiQOqRQ9qZAhbPh+xRxqY4Ru2Dxo45Qp0NrXPndL
	 AzHXm9UaVKMFVG5uLoBs2K6OWsYOF7vSpYqC97q1vNQBOKH9sCWepEEwwbeRqzWvzQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1ACA61F008BC;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011819;
	bh=9OOyDFvCTuGXq5yquXw+y8Fp6MR4CefxX7U/6uhjSYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nK2zrUjrxFTd9qFtkgVe6xnQXiIeN2e213qn/jK6wAfkBPl0tF+phmakH6eacm0qd
	 E+B73CFdvaH/uULTM7yopDkZI8VNzWXOh+AU2JV6b0/fkoN0IjEeLyNHjIcinAxDNF
	 yJFyObjs6SJG16KMvJDknv8bqD/9oQE+jIGXBOc7zklvkDDhTBvqsp84SwmWtuEgxq
	 WCBRzEoCMxCo5rLaAHWhp2XIUqYOXgNvct6njBLuHW857PdovHtSS8h2NGsWF2hcAr
	 jj7rfhPKNuAfs7joPqpATeeLLTIlC8By2mEudkfRvkwCFPQmwOmwK4OER07W86iq5B
	 Xdmwi0XeZKm4A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B94AF47944;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:46 -0800
Subject: [PATCH RFC v3 12/88] KVM: selftests: Test rejection of regular
 file in tmpfs mount
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
Message-Id: <20261106-gmem-alternative-providers-v3-12-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1842;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zYxsNZnCD+hu0G5QQ3lbC6j/2PC+WQYN9K55T6nzbPY=;
 b=ySV106WA3UxzgQMwS2cQCoA6sf5fFrB3K9KXQtlXVC9kRWRixPXJMjJH+mrpv7XnI7hdOfeRS
 R33krV9Y6j3DcoWX5+p00ZKWqh8uh8cBdypxdO3uBbxoZ7hkl/lhevi
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that creating a regular file inside an
actual tmpfs mount and passing that file descriptor as resource_fd
fails with EOPNOTSUPP, because tmpfs regular files do not have
gmem_provider_ops defined on their file_operations.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 541d8cdd0bbf7..bef1acead4a6d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -613,6 +613,25 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 	gmem_test_vm(invalid_binding, vm, flags);
 }
 
+static void test_resource_fd_tmpfs_regular_file(struct kvm_vm *vm)
+{
+	int pool_fd, file_fd, fd;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size);
+
+	file_fd = openat(pool_fd, "regular_file", O_CREAT | O_RDWR | O_CLOEXEC, 0644);
+	TEST_ASSERT(file_fd >= 0, "openat regular_file in tmpfs pool failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with tmpfs regular file should fail");
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+
+	close(file_fd);
+	close(pool_fd);
+}
+
 static void test_guest_memfd(unsigned long vm_type)
 {
 	struct kvm_vm *vm = vm_create_barebones_type(vm_type);
@@ -625,6 +644,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_memfd(vm);
 	test_resource_fd_tmpfs_swap(vm);
 	test_resource_fd_tmpfs_huge(vm);
+	test_resource_fd_tmpfs_regular_file(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.455.g6c5a503b38-goog


