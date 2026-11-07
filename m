Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011836;
	b=QznCDzZb+lbyoSgJZp3rkJFzq8whJ2NhCuqQGZ2CRyzc5vAYM6OJ5xfpKnqOehQna4wz
	 Lq5ZQynIpYp6vbC9NGPzMpme+mwJbsW7swuRBEbB2b90Nk5l6+1bc87+LgSSLYLp4lYWd
	 ghdxEy2Vs/1mq3AmcKPJ0AeOY6WB8twr+XLY9iqIHSMFGLl3HVhVRuxBP/Q+3/UaZhS8m
	 QBnkLh3wg3PwYlWqlWy2vsQRkhBF7A2xc7YVpfeupkYQI0OqXb1wWU91UKSP2Ow23iK1Z
	 3i9JzLPFI622PSyc6SjeDeAw3CgPngtL5pDP7vcRtUGfXLrlvGkQyyhbaM86Kyraepg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011836;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mCFMpOTu0j+6Ae8InLL7w0WPXWrYNgO/akoMq6zJJ7g=;
	b=eSLcxlR/HusvxGoZBKDhgipSjK+gjfJNWVZGivePWIP5fPvkdmTCGINhVnHTF0T6oIRN
	 oa/Qjt8FGKVnl7OVxUH8vXFKakgKaFGUQNUqRQ8jh7v0G47TJnYNgZXYhwqDUfdhqfW1L
	 J8snZ/7RP4AYK3zGUHy2EY/6gPc5y26yp/KVr0usc0kIxcHHGWX07v1ANHKAzrucZo3CM
	 c263iQihEQMKP0H5WUffma7WPhYXZmFGcqyJP+KVMBoU349w91R3Ek9Cl7M2fvroc3DHP
	 a1VlDsXu8XR0nfnrfp2E4FuY/1R6lMZHfaeJ/Pb7Qw5tKwHLuMgLndJS59HqN5bU2wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWQR3ePD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579A606BFDF;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWQR3ePD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011836;
	b=GI59OHI4jXTmxklcXJneelhHScY5T2jMzG0UpeHlq+0y7Hiqrd5oZFGLRmHwJVkb5j4i
	 cxyQuz7vBbLeVkAqas78eLHd/RK/c6J6uoH2x8fAkktG5Ri3MkuYHuhEXgvQjK7fJhoM5
	 83gWycD6ZnZKLKb2bWR28nvqvQh5b1pMoj1cF00o8imNXvtFRqYquScPlbC8la/60WVET
	 vEvvRvlGeCnYqnUQsWgkOEJOSaGWl6QgAuC8l3geuiBbka1TZ6hn/bSlVwoNVQ1D1PBoO
	 q7d9OKCZAj4DgXIjS7SuP+Hob757N9u0CMwF15Mjvjx0tHqX0tKD0+vfH8rXXPF9Tdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mCFMpOTu0j+6Ae8InLL7w0WPXWrYNgO/akoMq6zJJ7g=;
	b=Tq+6xslCS6y47JNvGGxfcu2urz4qqHFFvS2DECl3XSfGeNk8hSWRdtpMJn8Vr9n6RBA1
	 hdk8wroJfgBY1otigi8DhQKJBhjucax4rqJX2GkMGC2uAbTUQ1JI+VPF27ro/7ixDjcJz
	 K8uEkGjUTTtNZWBXhL8K/DX4vCzvoWKrhKfMh67QFrnpJlwGn6BiwO09H6H6JQIqqdIVg
	 tutQQskM8+z1+YkXP/Ds2zpKWNx++v8pOLmt/wilpVXPdsId8y/V7QTTonEqKvL51VDW5
	 wCgwQuE8ZUYwkHCHfG2lLFzSMhrIGmWtA60ensvS6mCdYI0ALuFP/+wKejg+9EO7V9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D9D761F00A14;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011835;
	bh=mCFMpOTu0j+6Ae8InLL7w0WPXWrYNgO/akoMq6zJJ7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OWQR3ePDlqin4tx7NS6UiyORjBYsjzluakJzEl1OelZPwFAFJwgQ3vWQ05PI0TyfQ
	 Gnh5754Ha/+SP0OfqmM86dz1WBc5n/4donc22oxfxBv7LUTfbAJth9YLwm4vD2lSEC
	 lxCJAW9bkbyn/08xoKM1SkJcykBU9Se0T9LDt4H3vV7JhccZiXc2BRlhjpWKofI1G+
	 aV2zt4p1RsgKFJrqz1qpONtiJY0l/E3tk731tEHhiE+4tnCJQPh+DGFoR6nuMKdvUU
	 958C6vYrqMgRzz0KVXz+WN6po3nqVjWTMoJ2zR3VjfyP8f63gQyW5/uG4oDqkKl2O6
	 7/XhInxAr3C/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF6AD47A34;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:48 -0800
Subject: [PATCH RFC v3 74/88] KVM: selftests: Verify VFIO IRQ info for igb
 device
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
Message-Id: <20261106-gmem-alternative-providers-v3-74-8484dde66a7e@google.com>
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
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2686;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=AQWLCgcApEEg/jyplbDhTDq5B3XgkxkLe0iSGXinQCc=;
 b=lzA7mjrnsoNNt6rCSt1o1c7XKjGh/b3RZ9f/ThL79ZgoHIg/TBQHg/cOHoFTJNTQBhv4Maxy/
 eIA9j9nVdKwBg73IhGl+U9b+AJRUyfp6pwsh2i/u1ti2HRsFODVqhyR
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest to verify interrupt capability queries on the bound
Intel 82576 device.

Check that MSI-X reports a positive vector count with eventfd signaling
support, that MSI reports eventfd capability, and that INTx reports
eventfd support along with maskable and auto-masked flags when present.

Testing multiple interrupt types establishes baseline checks on the
underlying device descriptor so that when VFIO resources are later
delegated to or wrapped by guest_memfd, native capability querying on
the device descriptor remains unaffected.
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index c76abe6d45140..6525f392b3930 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -188,4 +188,52 @@ TEST_F(guest_memfd_vfio, get_region_info)
 				    VFIO_REGION_INFO_FLAG_WRITE));
 }
 
+TEST_F(guest_memfd_vfio, get_irq_info)
+{
+	struct vfio_irq_info irq_info = {};
+	int ret;
+
+	/*
+	 * Test MSI-X interrupts (VFIO_PCI_MSIX_IRQ_INDEX):
+	 * Intel 82576 supports up to 10 MSI-X vectors.
+	 */
+	irq_info.argsz = sizeof(irq_info);
+	irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_GT(irq_info.count, 0);
+	ASSERT_TRUE(irq_info.flags & VFIO_IRQ_INFO_EVENTFD);
+
+	/*
+	 * Test MSI interrupts (VFIO_PCI_MSI_IRQ_INDEX):
+	 * Should report eventfd capability.
+	 */
+	memset(&irq_info, 0, sizeof(irq_info));
+	irq_info.argsz = sizeof(irq_info);
+	irq_info.index = VFIO_PCI_MSI_IRQ_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_GT(irq_info.count, 0);
+	ASSERT_TRUE(irq_info.flags & VFIO_IRQ_INFO_EVENTFD);
+
+	/*
+	 * Test legacy INTx interrupts (VFIO_PCI_INTX_IRQ_INDEX):
+	 * Must support eventfd and masking when present.
+	 */
+	memset(&irq_info, 0, sizeof(irq_info));
+	irq_info.argsz = sizeof(irq_info);
+	irq_info.index = VFIO_PCI_INTX_IRQ_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_LE(irq_info.count, 1);
+	if (irq_info.count == 1) {
+		ASSERT_EQ(VFIO_IRQ_INFO_EVENTFD |
+			  VFIO_IRQ_INFO_MASKABLE |
+			  VFIO_IRQ_INFO_AUTOMASKED,
+			  irq_info.flags & (VFIO_IRQ_INFO_EVENTFD |
+					    VFIO_IRQ_INFO_MASKABLE |
+					    VFIO_IRQ_INFO_AUTOMASKED));
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


