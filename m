Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011839;
	b=UlI4reOJ5m8rdp9X1Xu0jsyLxw9hIstdJOMVOjmYhXfX9rY8OqRUt/u4FRwdULUuk+EV
	 jA6xqFYGhis4v18bDC3JJaXQ1leKESlvp764VzDtf2rZ+QUr8ySeIWCc4+eoRsp+mEQTr
	 hx6fRD+byJqxhNrOU0mQQ81ut8Aci3WmLM2KPO3Ba7lQxdqmPkSrNXidyDUsYUR5cfyLs
	 E0Xi+POioBN1o7AmqNX6RaVVSfzEchymlYyo68ZPMpfrrMuvvnxecS0eLeJkPy4QwD+Js
	 d7q1KtmE46TiJ5DxrV9IFDJyV3DxUSh8xj2L6pK3St3GXU19gCUoSsPvEKJUJi3QRsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011839;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LZOMQbbwROsg3RJmo5tNBpuYTJxKTJ2ke5j/Ex7a5iY=;
	b=4D+SwA9+cXDf3NcQh9zqQuTRewO2D/egYbmQhzCXSze/in6FguL2uOfYwOvRSqdasBzh
	 XWfkMhgTiYc9gIO+sSlKW64mbHzYdONGRVEPQ3fnb7D6TmdaRfF4eSYMGAqe9gMvYRncf
	 1RzTrtLSNqFOCjcDpDqOuOiA/bouTPxdT3siUaCyi9jNjcxcWEckiR0J86YCjXN59fPeG
	 vFPGnzmhh44KiD76zgHv0/4e6XUzGNP5X2zniTrSQP4+vGjcleZi2SijUgRrQmChWzcCL
	 kJMeMCLQ8a/wz+jELHF/ljboRzoCinqj9hkY58iRGR0nOadJwLgB8wGUgHgHRhCRHRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtHV2y36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142C606A837;
	Sat,  7 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtHV2y36
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011838;
	b=Q7CEpij3av3k2nbISTpV+xuRk/HBYUd2JJ9pV4+OeLltEqYt+Mf7AL9lKh7eqVvoP0zB
	 xdmN+htVTvft8NROTmnoHCyoLoEWYLwqKQRX/egY8GhyDfwdqn0rgJbB2F4n5ozxe6pwj
	 yALOykOlHVQTCYknG/J5G1cbpgvOknzosaYE6m/Te29ApU3BEdSVabBRf7xF8Ukk0Xh/u
	 j/WpOWZ5+ltkMDn2Gr8md4jZXL+kWn88p53JE5l2HpVGzdxIh7TbzdO8/KUmcfE82qX/E
	 OTJcShnJuuy0IHMhG089QQVsxBpOOVXPkixhssuHzA+5vvTtyDHkfDBczgjB7PxnzzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LZOMQbbwROsg3RJmo5tNBpuYTJxKTJ2ke5j/Ex7a5iY=;
	b=aYUncUAOF1z24CX+m25wIoBeOrC+feCAcMh5v0XeHTYGxjVrpxE8oNYPYrZV99P/Lg4i
	 zmCFUB4t8RvzYIAYbKp6uwYusu8Z6DuHTdqS+QVxxSuknrOB1S8V8kPaov2J0MM8ctSuO
	 mjlkJLCSErEsD87vl56J2FAenMM56NjTnujgHuOjjyUi8kArcxoKYxOFhxaA6DzD6SMzb
	 o+uPrk6M8UibVBbTN4tpUgbAEZgZdCHLv6lKBYdBiun8cdWRa0hl90er5NxBMAgpIQxc3
	 L10+ujEXTfaWWlvL22QGpL0JAjvVjJ8384HhyzOEziKpK0UVNiv+6UqD16cjtrZh9Yg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 84EFF1F00922;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011838;
	bh=LZOMQbbwROsg3RJmo5tNBpuYTJxKTJ2ke5j/Ex7a5iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gtHV2y36PgAJHCS5NiPs0Ma8QHOH4Srr3v45JFj1jY/zag3RUsy8mG6y3f50gqCmr
	 auq/cLI2JWUZjFWx88XFLhSH5BqQMvvXKcyJ+gjSu6S2+CRdu4u+suleoP2zxsFt6j
	 IA57r3NRnu+/QDCY39IRfzWhcICBifOm62nSJN+EgGUwsfDY4gtUCT/rzqU4mUVjaY
	 gfsx8XSWqocv/pENT0zGunXFpJHtFPmjfPWTKcGF4a7/PZL723A7YWpondZ9/I+rNk
	 dRuO7YowuBZPOpbfTsDbSI/rGPf1+G+9KPmyXPYZ9dsS5MY3zowyoVnORpyARQfADn
	 mWqODlfLAj7ng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43F2547A4A;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:54 -0800
Subject: [PATCH RFC v3 80/88] KVM: selftests: Verify host VMA flags for
 VFIO BAR
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
Message-Id: <20261106-gmem-alternative-providers-v3-80-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2687;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=UlabEjEO5/7bc1Xc7qMAcF1rv+8kEYtRG7NVYEhErUE=;
 b=AYnUVtyYbnET239Be/q7ZKR7z0MuG0D/wBLiSNROBy6M+iTcydm/LLxQnKZUtCpZwDkUgkWWx
 NLfenWKq+rzDHvtjBPQsocyULycu+dcV6xLglIVZfDmfMBDwHdFzAaM
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a test verifying host userspace memory mapping characteristics
over a VFIO device BAR.

Map BAR0 of the bound VFIO device into host userspace and parse
/proc/self/smaps to verify that the kernel configured the expected
hardware MMIO VMA flags (io, pf, de).

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index cf2d46a365504..79a0001ca1733 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -529,4 +529,69 @@ TEST_F(guest_memfd_vfio, low_power_bar_revocation)
 	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
 }
 
+
+static void verify_smaps_vm_flags(struct __test_metadata *_metadata,
+				  void *addr, const char *flag_substr)
+{
+	unsigned long vma_start, vma_end;
+	bool found_flag = false;
+	bool in_vma = false;
+	char *line = NULL;
+	size_t size = 0;
+	FILE *file;
+
+	file = fopen("/proc/self/smaps", "r");
+	ASSERT_NE(NULL, file);
+
+	while (getline(&line, &size, file) > 0) {
+		if (sscanf(line, "%lx-%lx", &vma_start, &vma_end) == 2) {
+			if ((unsigned long)addr >= vma_start &&
+			    (unsigned long)addr < vma_end)
+				in_vma = true;
+			else
+				in_vma = false;
+			continue;
+		}
+
+		if (in_vma && !strncmp(line, "VmFlags:", 8)) {
+			if (strstr(line, flag_substr))
+				found_flag = true;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(file);
+
+	ASSERT_TRUE(found_flag);
+}
+
+TEST_F(guest_memfd_vfio, host_vma_flags)
+{
+	struct vfio_region_info bar0_info = {};
+	void *bar0_mmap;
+	int ret;
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_TRUE(bar0_info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	/* mmap the VFIO BAR directly into host userspace */
+	bar0_mmap = mmap(NULL, bar0_info.size, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, self->bar_fd, bar0_info.offset);
+	ASSERT_NE(MAP_FAILED, bar0_mmap);
+
+	/*
+	 * Verify host VMA configuration in /proc/self/smaps:
+	 * VFIO MMIO mappings must have io, pf, and de flags set.
+	 */
+	verify_smaps_vm_flags(_metadata, bar0_mmap, "io");
+	verify_smaps_vm_flags(_metadata, bar0_mmap, "pf");
+	verify_smaps_vm_flags(_metadata, bar0_mmap, "de");
+
+	ASSERT_EQ(0, munmap(bar0_mmap, bar0_info.size));
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


