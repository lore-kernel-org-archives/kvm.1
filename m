Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997072;
	b=kTFkWltKCxdOlgK4+cynb3q/jHanYld6CHVvAhJuYaFIaoT/zAPpm9BiY0xT3RSJ+Rk2
	 Bl6dghLGmC/muSEOdEt5HQQqD2EQbgMf+Z63aSfxNf9MZjz8X4wXxS0I40QVY7vYXd3DW
	 +6Vn7ZGO0f8389TQ1riCTc45LyVq7w1qHjjZCUnLAYEr3Z93bofm5GBnPEm8h6w7PfV3y
	 UtBmjmBt5SyEMKS9jAvQu2OG4JKhibAzL4lT2QZUnvcXJWZr1L/uAZb6l8JEt/NFrteGC
	 Owx1eB7k+yHUVExWTuuA6yFEvaFgfQ0X+03R07fWb1xwSwguQWoyLu/5Qb1jFRx1Yjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BkMA6KiIZX+x6Fw055agcWqeTm5DVghF6ToY3p976RY=;
	b=32JKg3zijRDDI882MOydlMHPWCxwugrE2taBYA3lkfgwPhpYYO+hpsfQJiLpoA2ZwK9h
	 uuwqKNeF1cXzB7GauCCsDcme8Nu2N5syb9YryGkseEApcg6H9Iq8Q9IelcZSy1+H4R1P8
	 WNSNWXB8wOYWIgOYEavx+LQXS1hQdmLoViEjlds83rgtW6uHPcG5S0+CtcAB0aDJbzVzy
	 2wEJq18EvAhOA95SSX/z/wfG2IO4rTl1y3TU4yy+RyVlJbBacXthxNc6zNf61+8APeJOf
	 IPHtzj4evmUELNQ18x9VuEokS6XZIymS+nwKTg0DJ4gqWzgkC2Oyzww99qYk0w3jQXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L6vHx7Hd;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970560A2635
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 06:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7970560A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L6vHx7Hd
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso3053237a12.1
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997072; x=1793601872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkMA6KiIZX+x6Fw055agcWqeTm5DVghF6ToY3p976RY=;
        b=L6vHx7HdclpTy+278zPV8cd/WtS/GAWbTpArL9bsAKKGtfx7lDOZyxlU5x27346+O+
         1wiSpDhhwlaxxn35+FyHgYrPS5FGIaIDq8PYv7Ha7K8tCajyLyR1V+ZSUYlqKBgVgxrl
         4J415R8kpbqc0F+Kn48OHcZHxSzMRRfhRNUwx7Gm9/bkIQAAAAQhu6s5/Q7ym5ZUv3pT
         FNQy4Vu36JpNkeP2V+A7N2qXc7BeoFEf/HqS5zSY2BAdsRzmEbWZE+bT+45jJUJKnK/J
         Da0F4KX1dwlGNKqc4T+ZiSGvAFA/9YeY3rLySv9yF4Tv3WZKe1rxbWtd6wrx654mbRyU
         NYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997072; x=1793601872;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkMA6KiIZX+x6Fw055agcWqeTm5DVghF6ToY3p976RY=;
        b=TEFjpzmhulmm7OE6zsKiiWdZ6CFVaTaNPFCH6J+pbP9rZDvzWvxT/iGpWGto2O8e3X
         baZ4QZCqkt000x+hbl8zhDmPebLrZQeUvOYx891ZWHa8xU0q7BeQmFs7XqisoN9uHyR7
         eXEmOR8ffQiQWMV+07DERDrGJ2eP9oKYY27MS/5s5aPlsWXR05P+aSfiftMjwZwZktZR
         n3X7TSekDySnCyJjExfWgf5dGly9BkzB+Y8MKfxe6Vouj+CSxQLKUsswoNAyCPJ2M5TR
         dquM3bUqYr847or2fC1Hk3l+jl2FRrGrCC/lclgYHQqB4qACXamKo/IrlJ1iO9E3gc5D
         FXLA==
X-Gm-Message-State: AFq9FYKjxtqqhbnbUK3f2rV/YbhB1qKjRPg/vsG5oPlxL1KEX+USl3eL
	7PIRvTR+g7XLakuzFsiGSYy+bW0JrL8dDQtFU8W6Jg5aAtLVxFlO6CP1kee05Tyy93+CAbIM2Rl
	cFtZhxBOpSb6Dug1sRcDQuiICsUEMuXJYnUplWE9ggF7GBn+LJgh1+Rjm3IukHjUoEQ+t1UMNnz
	h1g1InRTFiWgHgTZw2AVZVpuMd17hd0+PZS6WTww==
X-Received: from pgbd15-n1.prod.google.com ([2002:a05:6a02:64cf:10b0:cd8:bc38:3b48])
 (user=gongtao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7905:b0:3e2:2b76:bf40
 with SMTP id adf61e73a8af0-3e7bfa8d2f6mr4070475637.26.1792997071679; Sun, 25
 Oct 2026 23:44:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:44:23 -0700
In-Reply-To: <20261026064424.3003536-1-gongtao@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026064424.3003536-1-gongtao@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026064424.3003536-5-gongtao@google.com>
Subject: [RFC PATCH v3 4/5] KVM: selftests: Add tests for KVM_LINK_GUEST_MEMFD ioctl
From: Tao Gong <gongtao@google.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, David Hildenbrand <david@kernel.org>, 
	Ryan Afranji <afranji@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sagi Shahar <sagis@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tao Gong <gongtao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Test that

+ Invalid inputs should be rejected with EINVAL
+ Successful inputs return a new (destination) fd
+ Destination and source fds have the same inode number
+ No crash on program exit

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Co-developed-by: Tao Gong <gongtao@google.com>
Signed-off-by: Tao Gong <gongtao@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 64 +++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f4..ccde4d735c77c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -418,6 +418,68 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
+static void test_link(struct kvm_vm *vm, int src_fd, size_t total_size)
+{
+	struct kvm_link_guest_memfd params = {};
+	struct stat src_stat, dst_stat;
+	struct kvm_vm *dst_vm;
+	int dst_fd, bad_fd;
+	int ret;
+
+	/* guest_memfd can only be linked between VMs of the same type. */
+	dst_vm = vm_create_barebones_type(vm->type);
+
+	/* Linking with an fd that isn't open */
+	bad_fd = dup(src_fd);
+	TEST_ASSERT(bad_fd >= 0, "dup() failed");
+	close(bad_fd);
+	ret = __vm_link_guest_memfd(dst_vm, bad_fd, 0);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with an out-of-range fd, i.e. KVM must not truncate fd */
+	params.fd = (1ULL << 32) | src_fd;
+	ret = __vm_ioctl(dst_vm, KVM_LINK_GUEST_MEMFD, &params);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with a non-gmem fd */
+	ret = __vm_link_guest_memfd(dst_vm, dst_vm->fd, 0);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with invalid flags */
+	ret = __vm_link_guest_memfd(dst_vm, src_fd, 1);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with non-zero reserved fields */
+	params.fd = src_fd;
+	params.reserved[5] = 1;
+	ret = __vm_ioctl(dst_vm, KVM_LINK_GUEST_MEMFD, &params);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with an already-associated vm */
+	ret = __vm_link_guest_memfd(vm, src_fd, 0);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 0);
+	TEST_ASSERT(dst_fd >= 0, "linking should succeed with valid inputs");
+	TEST_ASSERT(src_fd != dst_fd, "linking should return a different fd");
+
+	ret = fstat(src_fd, &src_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	ret = fstat(dst_fd, &dst_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	TEST_ASSERT(src_stat.st_ino == dst_stat.st_ino,
+		    "src and dst files should have the same inode number");
+
+	close(dst_fd);
+	kvm_vm_free(dst_vm);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -467,6 +529,8 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 	gmem_test(fallocate, vm, flags);
 	gmem_test(invalid_punch_hole, vm, flags);
 	gmem_test_vm(invalid_binding, vm, flags);
+	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD_LINK))
+		gmem_test_vm(link, vm, flags);
 }
 
 static void test_guest_memfd(unsigned long vm_type)
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 777fa3dbf88d6..f8eca3f7993d0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -787,6 +787,24 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, u64 size,
 	return fd;
 }
 
+static inline int __vm_link_guest_memfd(struct kvm_vm *vm, int fd, u64 flags)
+{
+	struct kvm_link_guest_memfd params = {
+		.fd = fd,
+		.flags = flags,
+	};
+
+	return __vm_ioctl(vm, KVM_LINK_GUEST_MEMFD, &params);
+}
+
+static inline int vm_link_guest_memfd(struct kvm_vm *vm, int fd, u64 flags)
+{
+	int new_fd = __vm_link_guest_memfd(vm, fd, flags);
+
+	TEST_ASSERT(new_fd >= 0, KVM_IOCTL_ERROR(KVM_LINK_GUEST_MEMFD, new_fd));
+	return new_fd;
+}
+
 void vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
 			       gpa_t gpa, u64 size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
-- 
2.56.0.257.gf7497c7d27-goog

