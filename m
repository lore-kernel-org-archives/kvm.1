Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55403BE620
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378439; cv=none; b=Z7Ga6sHUV5in8q1Dow9USBlJiw9iXNcFEt8Kp/KL/Cy0BDpryvRU74xF09FnHHCh1QS3WmkJhuojXVvCx13/hHdxjpiA/L8ktR57yEFx3FXin8qqsNCZhBlB2Rmfb7WaDg0E8zx5ctYuYVdd3/uMlnk1o/voAcA2+44iSLGE5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378439; c=relaxed/simple;
	bh=3roPg4ZfXvCu9H2QE9Rl5CyrdVkiobJpwL6O2Q76emc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROHLYm5SbV8p+/kG1JHfQ4xJX2+IleOX/H1xShBckBKfuwdFZyvAJywJNYIC9Mo6JgWIuVjQrzcCL6TQqCkL09lKVNmKvCvl8v1beXOv6CKNdGwPTRb3GQcjqjp9/sfUnB6nRq80f6Czw01FSTyybu0TsiqkomxW9t7haL4m3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RqW2ef64; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RqW2ef64"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90e7d9c747eso18414816d6.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378427; x=1788983227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jK2MmrU5PHerjBBjkrNgI0UI4L0yhiHtWM989h7yfSE=;
        b=RqW2ef64Dc/9ZRfrHgRDo90wDTDKIu9w78a73wauD9AG7v8UkzkHNEhej8zt2y1ben
         S34SCE/9Ww4KgV7MmtL9YljeZ/UlvtKXcMqFf8OG7uE3/Xt4Z4jKh1RfZIKHFUET11GS
         XSWsIijEmmWLnx+Ccl2AYR8XNBqzxYEQz2YkBaFqsjQOTSaQ/SRmCGZn7taedg4FVFgH
         QoW3oVS0EoawlLIGaZQHooI8lFXwao0pSSxwvbvS9mwA/bPz0JVnJ6iZ2j+bDl3wArJL
         9vANN+zk0eTfF0zh+lWRJMnfGqWXPNSlUwA8zGpqcW9ZrX4Y2rfndyJu/yFtJhVPf4I7
         SXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378427; x=1788983227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jK2MmrU5PHerjBBjkrNgI0UI4L0yhiHtWM989h7yfSE=;
        b=GbdQhUrQcT4OngO9C1tJizWdvpO4XpFrcqYe6RPZ2SXzajRWYpDgCgt/PE09dfVBfb
         +7w9aAElOvkPwOHYwWORtuZogV2uXhBhorle6IW9b4oWlhRmE6NZmfqwf+6BApq4lJRO
         MiRSvAo2U6v74QPMYQjjl4Nyh1BTxztpVKJtQD24ZFsTR3oZzK4Ku5ovwfekzusoFthr
         tHPuW0+E5T4qmsH+oGD8TQg8tpdruy7YDUhx36oFYm6lD9YK6fnbebUjbFeZtZRkCNPY
         Iei/GAdDi/B8xSlLafj+QJe2aydL2cG6Omx7rFlxrtdltMMr3pDvZDDu5rgqj9DmH2sK
         by3w==
X-Gm-Message-State: AFuF++kOhXNt5YgqwOHhvVZu392qzMKwWASCSCREEZAhpNpvvc/Opfl/
	y0bdZ6cNopaG5oJjNxkCRg/HE4mczXdyqiun5X0fy8+iRuGuQqlET6X10kSEUV04jI0=
X-Gm-Gg: AYBFou2c9v2QBPu1pNoOFZyzX1jCBn7eFVMq8LgOeLPzG9ZyoLV4AN35V0ELh4ibJVx
	oDFs1C0pYYjcA3QBSiZTp8G03zpjGxAXD1maiy/c16Cm11q8BcU7IutdcXH1XO9EGrWA81YgVkm
	bdUlSe2gubre/wZpHPDMTCxfTz8pP2chVDFVRgd7jSFiJbO2bmKWacizFXxR+qYPs3jBvNVKC0m
	qIuzaXt812qodFWcWSiClynmixA7fxDGFfQW5SM1D5Gl2M2TGUcE8SMC1RIBQPATy9rfRy9/y5o
	S5jT6J2+HyDrfxlXPvgpmc+U4Sahu7VR78t4TOiOcKkBef2IKXGId7XAi+HnClduVCdw8zVfThj
	bXhjI1NskdHWBN4mBDAgwunaEDPT0FJoVV2NwauHPUMWnRqlwemUfJH6cBgxU2W4nuNksV7wDxe
	7y9aJnfLODeuYvMwkEXH3hEu6TQ6tKdTCrEBevoh1NcftaZHgxki+FkdyGI+E1PrlvldxtLEFWO
	xCzJGsKYWF0ICFqZ9M1M7Irj/B84j21cVFVBf6uZRxFeInq7UBSr3W4ZJ7n
X-Received: by 2002:a05:620a:3192:b0:936:ea3d:9313 with SMTP id af79cd13be357-9396ef7c45bmr114112385a.20.1788378426620;
        Wed, 02 Sep 2026 12:47:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:47:06 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	shuah@kernel.org
Subject: [PATCH 4/5] selftests: KVM: guest_memfd: let the gmem_test() harness bind a node
Date: Wed,  2 Sep 2026 15:46:56 -0400
Message-ID: <20260902194657.79075-5-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194657.79075-1-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test GUEST_MEMFD_FLAG_BIND_NODE - extend create_guest_memfd() to
accept a node.

Ignore the node argument if the BIND_NODE flag is not provided.

Signed-off-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-5
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 50 ++++++++++++++++---
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f4..1818e0fea5690 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -25,6 +25,31 @@
 
 static size_t page_size;
 
+static int __create_guest_memfd_node(struct kvm_vm *vm, u64 size, u64 flags,
+				     u32 node, u32 pad)
+{
+	struct kvm_create_guest_memfd guest_memfd = {
+		.size = size,
+		.flags = flags,
+		.node = node,
+		.pad = pad,
+	};
+
+	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
+}
+
+static int create_guest_memfd(struct kvm_vm *vm, u64 size, u64 flags, u32 node)
+{
+	int fd;
+
+	if (!(flags & GUEST_MEMFD_FLAG_BIND_NODE))
+		return vm_create_guest_memfd(vm, size, flags);
+
+	fd = __create_guest_memfd_node(vm, size, flags, node, 0);
+	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
+	return fd;
+}
+
 static void test_file_read_write(int fd, size_t total_size)
 {
 	char buf[64];
@@ -418,26 +443,35 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
-#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
-do {									\
-	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
-									\
-	test_##__test(args);						\
-	close(fd);							\
+#define ____gmem_test(__test, __vm, __flags, __gmem_size, __node, args...) \
+do {									   \
+	int fd = create_guest_memfd(__vm, __gmem_size, __flags, __node);   \
+									   \
+	test_##__test(args);						   \
+	close(fd);							   \
 } while (0)
 
 #define __gmem_test(__test, __vm, __flags, __gmem_size)			\
-	____gmem_test(__test, __vm, __flags, __gmem_size, fd, __gmem_size)
+	____gmem_test(__test, __vm, __flags, __gmem_size, 0, fd, __gmem_size)
 
 #define gmem_test(__test, __vm, __flags)				\
 	__gmem_test(__test, __vm, __flags, page_size * 4)
 
 #define __gmem_test_vm(__test, __vm, __flags, __gmem_size)		\
-	____gmem_test(__test, __vm, __flags, __gmem_size, __vm, fd, __gmem_size)
+	____gmem_test(__test, __vm, __flags, __gmem_size, 0,		\
+		      __vm, fd, __gmem_size)
 
 #define gmem_test_vm(__test, __vm, __flags)				\
 	__gmem_test_vm(__test, __vm, __flags, page_size * 4)
 
+#define __gmem_test_node(__test, __vm, __flags, __gmem_size, __node)	\
+	____gmem_test(__test, __vm,					\
+		      (__flags) | GUEST_MEMFD_FLAG_BIND_NODE,		\
+		      __gmem_size, __node, fd, __gmem_size, __node)
+
+#define gmem_test_node(__test, __vm, __flags, __node)			\
+	__gmem_test_node(__test, __vm, __flags, page_size * 4, __node)
+
 static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 {
 	test_create_guest_memfd_multiple(vm);
-- 
2.53.0-Meta

