Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011816;
	b=bnKhRMipkeyPKqUs8F1C1TZtKwAkV+XleLFgUw83A5hwtaVhmuBB7vC3sV8JfUaD/hw7
	 mlRGlHh9ImebFYD2M/DGdepm+QZQi0eis7KlFPtC6j4sIOsq3UgaTq7gg5yaew0ebxc/r
	 FRGdKF0j9sORh9KSO12ZibDrZNOt7MVVFTHAZlx9Tv+NEXlO7S8Sp1KD0jdtk569zH3Ay
	 ZhOWgNduiRAwQWuyPC9OWk6zingejFbrECsQ/KuhfWUWPIQv2HS6sJ3sW3QfkJc99O++A
	 CWFjpxs4nqlAfFMdeDPGbk3p8ABPp5g4wRTPkVt3A9wiPVxC32gm0QrcFYA2ieWE/UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011816;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gi8XuOW2wUclJkl6EeeCVIIm/en8gL+JZvwDfeVWmPQ=;
	b=ZiDFVk8m6Pp/FFQZsbqMMnyKmLVtF9LlLu56H5oUV0eZJxXaQVQ1R2rHmWCMas36NuP/
	 VcRCOoMMAUI+5zKbkspnLlT0npDAQW8sIS4PrkGXLVrwPWBR9IFkmHXnUw2cX70SImkSI
	 16iq8d2oWQfPnWsP1D/ypiQ0CakmNhgFsd+MloB3HOqOQYv2IG+WWD+ah0KRexO3TMBI0
	 BVHbcGKwf6VoYKc+EYHXXExlRj9ZSIG8RtyO1W43VwEOCQJ8nSDIQfnvayegOl5wGNWja
	 ZY5MVp2FHx6b282+JRVeyd0TgSKr7Rh7pAAxzLSF7pPIqVLrX9dRDpkGZJVz8U8FKrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E51g07kz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BE606D80F;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E51g07kz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011816;
	b=uC+N78YAWJ2VbMp/jBogGI7zF6vLHH7ZNBexkTBDSGyNSLXB4qaOU4NVF7jnjJIbwhvg
	 DbmcmYHBOm5PRHqS12o8dpnctUYK/r41Zsbq7LUMlXTdRzZXAvNcHP9PQ3dkQ7rBdSm+O
	 d7jzmJSo2dhh+IEX73Nvh92B16oYjKwpKqmoynV4xGPVCluYdgn5/98qDW5WjOPT73xFd
	 zgevrNZI1N078bKJaK0Zcbo2/pxuS+kA2J2HSKzcSjYBBo3E8aMytni1NF0y2FmKboO7v
	 XoC3xo03s+SEqfpe7dGIaJMW32ti8NF+wJzHUdNc9brH2Nk5sDbhyv8szQ4rMGmH6pQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011816;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gi8XuOW2wUclJkl6EeeCVIIm/en8gL+JZvwDfeVWmPQ=;
	b=1UWiIFFZaSHmpldhS26+yzIrw4hUmFhxO7Dl7Z0TSxL/Uz3tKbpMwLzkL9yBuj8LxLdj
	 SV/Z7k+KizYq9PbTg/G4x7XZT3Js9UosCRfgtMc+CEtj07dbGOi0HI4gGYbbDgSc7cV+y
	 0TzgfRxtyYgNLD1zMGJGPp7xyGQbaXspNhyj6aZdP+i3I+8T1pOfTyxFBmSENltOHhhaK
	 uYFLaB9zMTDqXCMMeDvEVDhlX3G6ItULwOnSM4jqOPLerO7hFHl/RSJXHOa9cFokozee5
	 bdvA0iHeKKKflRKt7xOMrDQOzn/zrqdbh0x82YEfqejRDD2DQVFm9jnTiGPU9mgyShA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4267C1F0089F;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011816;
	bh=Gi8XuOW2wUclJkl6EeeCVIIm/en8gL+JZvwDfeVWmPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E51g07kz9YvSZucHRjfCOVwSLbe8N1hBf6XGtUmqX6TGGe7PWVnoEAqcisjJuIbYJ
	 vRyvm5Jg0oGJYACor1ahI+Q/n2DDpqMGpgV4l2FDH7ciNC8M3r30Lo3uSd4gumuwyH
	 WPDeks8m118XFNrNe+OMQnrFbO4H9dGoiWw9LcSXpxfDKFwCGcFpHboCuAf2d4vpRS
	 ksR0YUcIE+xkxdDT7o7frhyE7LFeNIAXBTMNPRjBdLiE0+Fr5BdrJx7ydUFzdxxOw4
	 OPhqaDNoB+meYLrmY9+V+VrM0Usg2lpkJWYoookt5O4SI1iNaFWDJ/lnRpn6aRZ4Ud
	 Oybhxl5ulUI0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 530DD47930;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:41 -0800
Subject: [PATCH RFC v3 07/88] KVM: selftests: Test negative validation of
 resource_fd argument
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
Message-Id: <20261106-gmem-alternative-providers-v3-7-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2102;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=dKdQoJ+6E8rrtajy5+HMr37wBSZwSe5sC1LJJuGdkHs=;
 b=LxXhMdKPAOtjHYRtDSEnmO6i0SyBR+8ksuLusE+lUgxFRHpPSn5ekpfaFhOJgoQa3Kb6jOzAg
 RiLZHyldizYAfAkkTkilm4Hka1ub4SCVyl4AjywJN2UjejjfdHGfboW
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add negative test coverage verifying that creating a guest_memfd
instance with a non-zero resource_fd when GUEST_MEMFD_FLAG_USE_RESOURCE
is clear fails with -EINVAL, and creating with an invalid resource_fd
fails with -EBADF.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index cd5df88bc6427..3313d306c0bdc 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -404,6 +404,8 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	int fd;
 
 	for (flag = BIT(0); flag; flag <<= 1) {
+		if (flag == GUEST_MEMFD_FLAG_USE_RESOURCE)
+			continue;
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		if (flag & valid_flags) {
 			TEST_ASSERT(fd >= 0,
@@ -418,6 +420,22 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
+static void test_resource_fd_invalid(struct kvm_vm *vm)
+{
+	int fd;
+
+	/* Non-zero resource_fd without GUEST_MEMFD_FLAG_USE_RESOURCE fails */
+	fd = __vm_create_guest_memfd_resource(vm, page_size, 0, 1);
+	TEST_ASSERT(fd < 0, "guest_memfd with resource_fd but without flag should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Bad file descriptor with GUEST_MEMFD_FLAG_USE_RESOURCE fails */
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE, -1);
+	TEST_ASSERT(fd < 0, "guest_memfd with -1 resource_fd should fail");
+	TEST_ASSERT_EQ(errno, EBADF);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -476,6 +494,8 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_guest_memfd_flags(vm);
 
+	test_resource_fd_invalid(vm);
+
 	__test_guest_memfd(vm, 0);
 
 	flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);

-- 
2.56.0.455.g6c5a503b38-goog


