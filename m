Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011823;
	b=qqtDNy3nPXwCzjWKG4/655QgQA9cx6fjD2UxWaxCylZ8VOQNmmtJZdejnSU/Ya+CWvRM
	 ObfpNtunbJLhyhtaSbc8FpicT6/D5caNKnuykLU0cAnI9rh35a5dsqDPhAhYLOhVp4FzS
	 xURuhi863//6zkQbIDblA/5oGLih9HzMF1KStGpFNeLG16xDYvObgOvcNxxNmvxN12aGn
	 QdCJdz0g2xkLFmWV+yTGkYBjyZUluaaTdavfOLEZd7LUWP0VivpYx1Fq1IA1K299Ztgq2
	 +EhLlL+6b9dpD0vT9BGm2ToMw+tbiU4xw3ay9X9idd7VzyzS3cXOao1fgDYQvYBs84Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011823;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xU/UQNiUIyt+pklbBhbiTSxK7mseKJX4CEa0PS9WIcU=;
	b=rALjWokaIEr9tsYE5yKrRl1+wnzGd/+3wTJ6e0OvZy0/4glJ2TbmbCQ4Hk+pk1wCg2Sr
	 GsmFUNK2LkOVn249xJ+JZhDc4kJQsjRP4LIHMkPf0sGUGj6bIgkZnaIBs0CamO9KuyAqV
	 idz1QdM/BdvfpWGnzveCugyaLnW9CmJTOS9so4218Bj+FQXfgrzE38/R1NiHR3iHoqJgb
	 pKEea2tjz3XCnU1lhcNMwSONbLiekWOckwuVEO1gE/EabAzKUU25Rzs+K79BSVI2tJ8I/
	 IMztlDq1XV+/285Lguuo8qVhMuSxA3MdzmAUb5qBqZzYvWzT3Fz6BGthdqT29cOcUNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iK3vWSYI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B2606EE92;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iK3vWSYI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=yv/918BhOVQk+kI8AB/Ddix2jqNhc1Acbv0k2fKCRCKwtR9L7NUKpCsz+hTBjJ2bhGm2
	 t7POReBD8udftzZLtp4BrPN9Znba4m4jxOkYPT7g3qXFx/kNmIhNzy9Wbu/fgDa0Doe2V
	 Vnk2uEbOHmdFixXXlavQwiCk9V8/xn0nHkBtE3et0PYoolGAc/1DF7GebvlJswqe0cyum
	 pld0XkVWrtE9uzml/I+TgCgwB7z6lEbByFg5EhGVgjBzsbXey5RJpz8re6lg0hLxhPINE
	 5yYJX8Qxl+BzazyI5qZ0s2JOyxEIW3hK9q6kbcMgfS3mzAa+b5RDK1E1+oT+wx/YFqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xU/UQNiUIyt+pklbBhbiTSxK7mseKJX4CEa0PS9WIcU=;
	b=IBJtIAqnZVM/izkS6tPzOKTgdpC+V6sjLbm3d5/IifQqBWLyUNd3dpNGOip5JCKqc6xu
	 ED25ptjOGR0jc5mAnAWdnIJ9jOJF+tqJEHsos4baXYCUzyX4cQ9kpreFTd5E+XlchtyUw
	 aoE7qJh1BsBeQmR+vIrEHx3Tohbe99ZXnMWGZtvDIvE9uAGL0bd34cU9evIlYikfOx8EJ
	 QB81s2+nvlJEduMRC1IzHHGvFlqb63Nn1telsR3x6xzT8FEke3xg+s4N4iZIYEYpeRrGn
	 PEbwxAzlde1SHc+c4na2nLiz0ZANS4o6e9FHK7QxFmudpgm18bXGP5kDJfC9sbrEqeA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C1A951F008AB;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011818;
	bh=xU/UQNiUIyt+pklbBhbiTSxK7mseKJX4CEa0PS9WIcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iK3vWSYIA+CDNzUHbtXWQhDoOlRPy0O/UK5/+2gSox7ItgB1Mv10ljtL9ZFEr0Usx
	 9NVZHbK4f6vRZy5F+hFh9vRP+/J4L/u3ilgfP5IhQMVDyxAltA4pP2Lziqu8gkbLu+
	 ZwN5ON1VW7+yw1y89RO39Ionub0Q9ZmYtpHdELiRIrXIrvx6jLXObkY27uF/gbxASp
	 V4Z/pDseTxa/Mi3PFseR2hd0Jbj93N+H7ykmgRYcuKZ6lWeTmsTX81sm04Vdx1qmx1
	 DEdtiVgCc9AWMno1cKDOaZiKKmWQFfptXUjKDllAaw7sugX14mie1lmxh7r8XizALS
	 fiXLRQFMS9EQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FA1D47938;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:43 -0800
Subject: [PATCH RFC v3 09/88] KVM: selftests: Test rejection of memfd for
 resource_fd
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
Message-Id: <20261106-gmem-alternative-providers-v3-9-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1909;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=jiwqzVYGQdXa1AlyMlZiDSlQ5Amwfala9fk+uK/j2tc=;
 b=PszqvFys8SqnJc1HxGZEKNlvVEFwz7sIeHsPskHnWi4bT6RpLtog7UsESKEfmxvHt5TZCim82
 VpkdFcaoV62BbYTF3YA+BLAEU556e8Oz+fbgR9PXpvhp9j2rNyMPT9f
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that passing an fd created via memfd_create
as a resource file fails with EOPNOTSUPP, because regular files do not
implement gmem_provider_ops. Only directory file descriptors representing
the mount root are supported as resource pools.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 445396860d819..d62ae23256083 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -457,6 +457,27 @@ static void test_resource_fd_unsupported_fs(struct kvm_vm *vm)
 	close(file_fd);
 }
 
+static void test_resource_fd_memfd(struct kvm_vm *vm)
+{
+	int fd, file_fd;
+
+	/*
+	 * Passing an fd returned by memfd_create is rejected with EOPNOTSUPP
+	 * because regular files do not have gmem_provider_ops defined on their
+	 * f_op. Only directory FDs representing the mount root are supported
+	 * resource pools.
+	 */
+	file_fd = memfd_create("test_memfd", 0);
+	TEST_ASSERT(file_fd >= 0, "memfd_create failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with memfd should fail");
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+	close(file_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -517,6 +538,7 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_resource_fd_invalid(vm);
 	test_resource_fd_unsupported_fs(vm);
+	test_resource_fd_memfd(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.455.g6c5a503b38-goog


