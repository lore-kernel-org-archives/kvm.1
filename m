Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011821;
	b=ujAFNxphaoeIyr9U7glkVxcZJ4UUotPNCsZsHSxf5yrRZgoCTnmZetqbcMH7+L6jJUER
	 O0bBKQ2RdKuOiuiIyyWqv5O3blDUoKFl1FNCgWvaG7cpkg7ySN5X9H1Z+keg71LLxpRqG
	 qHIj6NfReMwF0AlXEbKnxM9zgmGgQ9850KI4kAabzHHO29EGs/8KkeeNRAaA4hu78P5zK
	 50f5NNjxKGkhYYuPZSe3gqRPkEyHxNCJ6XJRRMeko7+5HG9xzcc9zf9Y6NRBtq3lIGAQ6
	 WEuePPQti/KiosOfx3p9yk1cngs2Mlo+6m3qUpFGXJAbroVU2HhZ2KpUuwn+p5MLqqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011821;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wrGLOYvm9qvd5ELar6tPaqbVxAMUuqMJGXo2FtOyYxc=;
	b=3MCn+TLIC4qtflOfVfwEElt4R2x3aUKQImjcodIsYQfyNKTLEsPy5NVDyNcDjJpHlmSm
	 6Byi6bvNHseCC6Iki2UtusjmsJpPpydRLSzsYn+Venb1Xo0Gv3bzMA9kFmW+S+MVJDXU6
	 PLbvIf0S35wciKg8oMpVL0Lprt6x1++WaI6aCk/E+mCa8mcAe47U8la4khoyGYS31b6Xd
	 Mck/kRGTXyAk1NvmJzicWZFngGg3hm4p3ziK7zuDOKz07KQFUOSX14KPkIRiD5zUkzun7
	 YHTl1hY+KTh72X8KF1kw/y38XaBB8PSyoVsJsXnVDLUOBDINJCDi5+te5CAlBgDEOOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2NC4dEL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD81606A337;
	Sat,  7 Nov 2026 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2NC4dEL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011820;
	b=xSCN/H2tptBi9VeRl/s5pu40+GN3JJndgFRhtQ2VhRu5idMMb8E/bs9Ey4vGq5u6uVCt
	 GxEZbRVBgDI4S4peGL6gxqgQt1nGtuxY81DXc2ILhCNxB+lFNgdK6op5spMXxQXumCZeu
	 CemOuS5XgoXU76TVc5PwhsMg+ABYtuc4gC2Clts5QsWcj1xNsYmrXG2+Vkdw3l4/EwPDe
	 stM/gaZrCQGg6Ly1F3fdqiVKQhmDawx7cekAble5edA5ymxSS6nFtuZ0ntXTLWnrVEQIc
	 pFIANzGeGeIy0Kc7GeEC7j2rhW7YYdz5ZIXXzEngtycc4O3YtlVNBsYGrhrjxWVd3kA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011820;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wrGLOYvm9qvd5ELar6tPaqbVxAMUuqMJGXo2FtOyYxc=;
	b=TXMA06a5WBbQVQ/rerFnUutS5vcZ1EC+qc6CwaJx40/E9L96hf3ycpL0aDNafG45er+3
	 bBBNzkJK0SmWc7KOCnb1nIum7Y4UbQGDmHD+pEPcf3Rk4ZzzosZiXChtLhyiSyOiirAny
	 iSNtwJKmpD0zT95a5FGeATwcbUpGAUGvGmn7CFsFlSbnF0d8wHJy0gmvHNN6/F8K+OykZ
	 BMFUBQhtL/APTQ2R4vC89fKde6gw9IQV1QnN/6jY060+kEguUyaFiqZrMFDnAiU8WIEJ5
	 H0JvPrr2qtdHGAqhCMb3J3Y37oPqAMgeAPhocOdvldU3Qakb7uNeOMhA3hPSOnW7G6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2402D1F00902;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011820;
	bh=wrGLOYvm9qvd5ELar6tPaqbVxAMUuqMJGXo2FtOyYxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U2NC4dEL6duTc4DI7Rx8CpTjKr1bgFIvp6cMvsmuO5xlCvacLsmJDYLpMeIkI4Tym
	 RuI3058XLzvMVW8Hywjusuu4wqmE/exCqPJggX63dfK/hBCiW7PKisG9el/aKWgB/W
	 rpaQxtPb0qRGsl4otS+lA4GkJ4rJsVlSrOaL7kioAZtELcsNsAX7AaarPZ/l73+Kh2
	 SpI+HlwG1lr47avkTvBuKQAAqjZkXtjkyml2xqqAnjo3j2171gK6Lz5zhFmbjjBBHU
	 c9eHTGTowULC655OkfwKdmdtGZXDh2TBtnPUfsDKLtxodCQwa6JzC9ZpXauwbBHfGg
	 WptigzRrRqFaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2856F47958;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:51 -0800
Subject: [PATCH RFC v3 17/88] KVM: selftests: Test guest execution with
 tmpfs-backed guest_memfd
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
Message-Id: <20261106-gmem-alternative-providers-v3-17-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2755;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=fr8rPkSzXLy1+7CQ4/dHoHPzEtH6SGICpYGF16TSzqc=;
 b=K4Phfaq4Qdgv8seGNPs3X+5Qw5d2T5Sa4NEyiI9XKn3pL0SWjZvjc8r3+b4a+mTomWCACaDzQ
 D8e2EDdfzkXAPLOc3KPgJwp9uTi2kMeJyUw0cg+ragVcNp6ain34P8n
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test that a guest vCPU can execute instructions and read/write memory
mapped into a guest_memfd instance that is backed by a tmpfs resource
pool descriptor.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 20de24ad535f1..8e9261db23354 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -799,6 +799,61 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void test_guest_memfd_guest_resource(void)
+{
+	const gpa_t gpa = SZ_4G;
+	const int slot = 1;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int pool_fd, fd, i;
+	size_t size;
+	u8 *mem;
+
+	if (!kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
+		return;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size);
+	if (pool_fd < 0)
+		TEST_REQUIRE(false);
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, guest_code);
+
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_MMAP,
+		    "Default VM type should support MMAP, supported flags = 0x%x",
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_INIT_SHARED,
+		    "Default VM type should support INIT_SHARED, supported flags = 0x%x",
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
+
+	size = max_t(size_t, vm->page_size, page_size);
+	fd = __vm_create_guest_memfd_resource(vm, size,
+					      GUEST_MEMFD_FLAG_MMAP |
+					      GUEST_MEMFD_FLAG_INIT_SHARED |
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      pool_fd);
+	TEST_ASSERT(fd >= 0, "guest_memfd with tmpfs pool should succeed");
+
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
+
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+	memset(mem, 0xaa, size);
+	kvm_munmap(mem, size);
+
+	virt_map(vm, gpa, gpa, size / vm->page_size);
+	vcpu_args_set(vcpu, 2, gpa, size);
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+	for (i = 0; i < size; i++)
+		TEST_ASSERT_EQ(mem[i], 0xff);
+
+	close(fd);
+	close(pool_fd);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -819,4 +874,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_guest_memfd_guest_resource();
 }

-- 
2.56.0.455.g6c5a503b38-goog


