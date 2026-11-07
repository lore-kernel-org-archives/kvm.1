Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011840;
	b=w6px+idG8Qodiq0zf1GAHzGSsZa17mA3GzMXdyvyvGoNjPkesiuslZJRG0vyPoYXHiI6
	 2FkcCP7uQRdZd069AiS7iVqn7i1RLhz8hGVlwB5Y0qIq3Jk07Jfig5hYRYEAJJdIB+2Tj
	 ma5L08/h2+0L7sk/Rzy4dJMkCcrenMu7mQcujs1RXml1lxuJ2awzQsvESukFrcZIgcnt3
	 uHcdluZuld+rwooQRzku8ZXSNzGmy+S1JaxhNzs6relfCE124WYZjZcasObvdiiXCt9/c
	 psK5G67sKcCxH2FJ4+PpGaNS6ZTpYXCrx8/xF+6ugn6SBOmK41Imjv/ZjfeK5daNZrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0nkKW4qaDx3asj2guFXILmxbH04Ei7Qw0v+PRGtBfmM=;
	b=DeV0ca24W8+d1x6iEbecLoy7E5QmRQ+2xHVpZvrlbW7qfm6e/NuYLjtS8iNvPVpEjMr/
	 AkI16Kv8Ujl4/AUCTyUiE20GGe+04Qs5eZD9xtiJUWJt9w4kdwnuM0ouGcxDiOWQZudVw
	 RoLtbrAdylF4UywsIprga7CT9fg7u63ce3BgQ2+8bk4LZUDc6o1rGNXPRPc8TYGwE+emS
	 WNWiZwNGtDtLfwTF+RPYy5oABdv4lmOPdjw+DhjtDgtTPabkh7TRRsNXPR9MalgIjiX7x
	 ns+A6vJKR/gqQQa+M/9tqpsGiygSXNDoh0xtyIKiRNGRMTjgohGaKMQrAHxByqkje3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hazlIY6T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE481606AF8C;
	Sat,  7 Nov 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hazlIY6T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011839;
	b=i3OjkfOEm6IXp1VyiCWIyLE8QFPCgCTpa9ToPd1NL9YXN/iV4mZfAp8VDWdWp83YIXfo
	 AFyYe52P736v5tjTqrEFeyuxdYDOMKejSwrTT0duKlszhQHP44b6rjO053RTbThhKGgdN
	 tAcfPI8G/BBLOkCho1W8jVEY4XYKaIphx/PMvTXC2QMemgHVAWylX8CPB17HOb2J1dQ2s
	 AOaVa7jCkaIzOY2okmZxzW3RtX2a4SUwv5efZFdP5fJXpqarjNLy516BFk+qBm2g3pXE2
	 B812GoLlHdSsT/uCof1lrZUaM1tIDszuoIa+a2hCPM0eUPaKv1AGMu4IvQdryWVFIbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0nkKW4qaDx3asj2guFXILmxbH04Ei7Qw0v+PRGtBfmM=;
	b=zrZ65MbsloqKg+o34ShyiAI9rC2PdFU0auT0c6t+rwvqRHuiVYq0Js7Kb9J1HpXZzwrF
	 M9o1X/LSpwMLqNyH44cx8gH38t7sLyo7qm9oOyTzw/SWaXNqGB4dRP16OYJ6K5KbnOyMW
	 SscE/01qzIzluMwEejpGYK8b3oZwxudmvxO4/GwNC2k7lrXSH9+VbLZ5DrqMSAJOdKbRF
	 PPWqatBwQi/yepuWx33Ovn9LmypTB/Ym+Xqo1Krim2rAV8a39AFJdF9pCYK+xC/SL0W/6
	 ObPtZsk0fJHicBdoPqkY0ZXGD+n/MQ/+fs5J6y2moaM5+21woDpqVTD08lddCQCZ28g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 420141F00901;
	Sat,  7 Nov 2026 00:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011839;
	bh=0nkKW4qaDx3asj2guFXILmxbH04Ei7Qw0v+PRGtBfmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hazlIY6TaUYJJBHK20yeEie7vDuC4nIuUs6rgF5AWjaAsWS2CR3tdgWF9zrpnxyfQ
	 dlLfxX/O+9rSMGB3ImgNqjX7jRPH8TaUg3lRxijCT+c6OdznXVyiyJrVwFWEK59Gun
	 SEuQlLLYn4z6QF2wQnJUlHlPrqTQSa249YP3JFjHvI+bD7ZSOJEKcY3Lp2hWCRn1Im
	 GkUa+f5Uj0W2D06vn9830RKJxd/TlXD0zUqdlfFW0ZUFlKoOZs7GKWjIbSQTY0/xPG
	 iak9/tablOE2/IwsA/R76zv8LkqFWlwwUXHlSSjeYMKEx/CKcdyBL5pBWIX7H+IqA3
	 jKFMSj8pbiIUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18F5847A3F;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:51 -0800
Subject: [PATCH RFC v3 77/88] KVM: selftests: Verify VFIO device reset for
 igb device
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
Message-Id: <20261106-gmem-alternative-providers-v3-77-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2756;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=jIcxaC8x28xPsLi5SMudkDfabTx4GIIOp8BRTMbwoBw=;
 b=22zVgyg/vzsiW0zlhJ3ne60GqMpiyEfDMQk6bsvNnD6uIZt2eSXJ3foj8SNHHIzAaGagwcB/5
 y8itLkPWPqaCVForcElwYW6W+a1qYjsL6jumqYkGxAoeFuJhkUTZucc
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest for VFIO_DEVICE_RESET on the bound Intel 82576 device.

Configure PCI command space to enable memory decode, map BAR0, and write
a distinct test pattern to the scratch receive address low (RAL0) register.

Trigger a device reset via the VFIO device ioctl, handling potential lock
contention with retry logic. Re-enable memory decode post-reset and assert
that the scratch register pattern reverted to its hardware reset value.

This verifies hardware reset lifecycle behavior, establishing a baseline
to later confirm that resetting a device revokes access when BAR0 is
wrapped by guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 4d5211b6acf79..91cba359e4392 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -331,4 +331,49 @@ TEST_F(guest_memfd_vfio, bar_mmap)
 	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
 }
 
+TEST_F(guest_memfd_vfio, device_reset)
+{
+	struct vfio_region_info bar0_info = {};
+	uint32_t val;
+	void *bar0;
+	int retries = 20;
+	int ret;
+
+	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+
+	bar0 = mmap(NULL, bar0_info.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		    self->vfio_fd, bar0_info.offset);
+	ASSERT_NE(MAP_FAILED, bar0);
+
+	/* Write scratch test pattern to RAL0 */
+	WRITE_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0), 0xdeadbeef);
+	val = READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0));
+	ASSERT_EQ(0xdeadbeef, val);
+
+	/* Trigger VFIO_DEVICE_RESET, handling possible lock contention (-EAGAIN) */
+	do {
+		ret = ioctl(self->vfio_fd, VFIO_DEVICE_RESET, NULL);
+		if (ret != 0 && errno == EAGAIN)
+			usleep(10000);
+	} while (ret != 0 && errno == EAGAIN && retries-- > 0);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * After device reset, PCI Command register memory decode is cleared by
+	 * hardware. Re-enable it to access BAR0 registers again.
+	 */
+	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
+
+	/* Verify RAL0 was reset and reverted from scratch pattern */
+	val = READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0));
+	ASSERT_NE(0xdeadbeef, val);
+
+	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


