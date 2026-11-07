Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011848;
	b=k0A9tkVKkqXL94cuVhMVx7YapJuzNW4PD/rXwSWTOwISlcI2PN+ziKadys/cUtRsCi2p
	 h+YxLZT7dtZHj131LbmropbC42KMYFCscUR2ONKg5Gq7YltQCGg4CBtnmoOngIzGny8Xa
	 UPe4btoLvUmfGsQfQxysfWgozVRZ2zIv1MuIHTKKHaTWvZBB1ERivaPHM2FYOEeLrTLWq
	 diaysxJDynshxTwL9tb8E16TrMHIf7wzX2y3XWLs3G1c2AfrtA+HsH4RTfmpjhtMebREE
	 YURrUf9lmRXCYG3r2ejvRcLmhnVNHDcENiRUSRhfDPDwp5mFhUAPIXmgmOPivU0zsWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011848;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SxZseH1D/U//4ssKZEL6OBhMNAqOusdgqcQCPzcsa1A=;
	b=0iT2JSa1WceNS996LcTt0wrT+9Nc79PlKXr8j0DAA6ir5whPSAg7Mdg02U4cR9cf4AAT
	 ErL9xtGnKTXNzLKV2tRtYfOHnx3u3ysglpVLpmsVPC7XqU7Qc998bAPvFHSgdV3h44XCq
	 c50FpKe1RJ3YzMM7+2PlS6szipJqxKacy2HIFQwCpAmmLAhUlKYGZR2HoK/QVfoTwWoFl
	 8X0ivgusdxZnaFxMhlwtjIuqcTc+B8fv9iOfyR0fl2vu90N7cxf1ZqFpeOSnyIfh02IFa
	 I9aj2RwSMfeWDoHtanjRLxtkRL8VKrVCjI1Vkuf7orX6HlyO3hZnAanqZBHMEYc0bjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mUBFs/H/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB576070BAE;
	Sat,  7 Nov 2026 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUBFs/H/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011842;
	b=jzOrZDWUD1p8kRij7cmVHLLe4mumO4XJrdbrb5T92+kjvRJlJX58DBxDoPOMgJbStZV0
	 zUYQWk1qUb62mmo0x+Z66by7GK0AFWNpWx5dQ7rwn+m5yMtMmsDflC6kVIx0UlRVIbdhw
	 NpwjBT5b2SD+3MPRPXbgaJGJY7GxjGANJsNT805PRK+3QAS6bkNPkWgP90smMZ7NN0R5s
	 37anuPvmlYENpYaLPfmKt/2v8IS5EX22MfaJLH9q0vnYAQOJH6XYFRYjkupTswBHb+svS
	 1kaMGgCReRBiB/oUKjerFal58QYnHsF2jHAzgrqMlLe+KrqzE3vZBnE3wpEqnEdUENQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011842;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SxZseH1D/U//4ssKZEL6OBhMNAqOusdgqcQCPzcsa1A=;
	b=Dy+Z+ObJO3FzbV4FOUB+h7rnmNS1gQ8AMaGQxZCHs5oXZGcMl99n7uqOR9sJRAyBzoTH
	 CcoXXdGb2DZdEEzIIEchPKWWIx1FWTtLaKaYBDVx5x8srY9y8bIHXsY7csJjuqyO9mH+P
	 BfUi/zMBB75GslOqpIA7UXudlgN3YKErXkmo7JIOlFe7gbDDGyMoh0fu3y25pIr1B1uup
	 98fymrOignzArdl1iqhHxtcsnaBityb2XvpwqOS845qyfu3p4O+k5QQSS+bRsk4u7tXQU
	 09UCChdjCiJecFSdHlWyX+7RiRsYmmf5b0+1pjNZmIFzgWymHlMfwjg3KF+a4561eug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D5AB1F008A4;
	Sat,  7 Nov 2026 00:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011842;
	bh=SxZseH1D/U//4ssKZEL6OBhMNAqOusdgqcQCPzcsa1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mUBFs/H/7OWwoFBVxL4CLWIAEgOJOkKjVNsHtKrGyqlRUKut7S4Hgy/uPK56zo1B1
	 hCYuzouZpkZkjFbKVLdn3ZRjkhftiwdOE0ZRH1Ro8MoBanvvLQW91mro4yeSqM4eD1
	 OwlbCh8IytC02h4XXubQQtfX3FjwzLwf3cKzfbcI1sREobTztwhzr2++avhhOnhm46
	 gJj17sf5PdbMAvLLMs0mK750/ntTjXUOZ2Sbw8CL3sHaMoN6SK+SEAybPmFlPdiuQ6
	 N96KjR1WgCHQQ7BbaUV0x0WSb6B+aLjFEg5d1u/JgohH9qWkbOVDSXYyhreOVr0qKo
	 7NhGXGhma0QcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EF32A47A37;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:49 -0800
Subject: [PATCH RFC v3 75/88] KVM: selftests: Verify VFIO MMIO read and
 write for igb device
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
Message-Id: <20261106-gmem-alternative-providers-v3-75-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3042;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=3rXXPklnl0jKOPE29y7ipXm7LsNh6MGUlvgjiF//KXQ=;
 b=xloQFGBoKJ2DqV21AvqSu5E1J/CpqtQbloSW0T3GvaqdUgvm8xoOH8M0ztGaadapQ2nhxCakj
 IhodY//gGI6CJqHf9PiPv1GyWySREMT+8pDpBuxA/6S9HQ3zZS/kyLY
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest verifying direct pread() and pwrite() operations on the
device descriptor targeting BAR0 MMIO space.

Enable memory decoding in the PCI Command register, verify that reading
the device status register returns an accessible value, and verify that
writing and reading back a scratch MAC register (RAL0) succeeds with
expected data.

This validates that kernel-mediated MMIO operations over the VFIO device
descriptor function properly, providing a baseline to compare against
when guest_memfd wraps the BAR.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 6525f392b3930..fa05b7cfb3185 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -236,4 +236,62 @@ TEST_F(guest_memfd_vfio, get_irq_info)
 	}
 }
 
+static void vfio_pci_enable_memory_and_bus_master(struct __test_metadata *_metadata,
+						  int vfio_fd)
+{
+	struct vfio_region_info cfg_info = {};
+	ssize_t ret_bytes;
+	uint16_t cmd;
+	int ret;
+
+	cfg_info.argsz = sizeof(cfg_info);
+	cfg_info.index = VFIO_PCI_CONFIG_REGION_INDEX;
+	ret = ioctl(vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &cfg_info);
+	ASSERT_EQ(0, ret);
+
+	/* Enable Memory Space and Bus Master in PCI Command register */
+	ret_bytes = pread(vfio_fd, &cmd, sizeof(cmd), cfg_info.offset + PCI_COMMAND);
+	ASSERT_EQ(sizeof(cmd), ret_bytes);
+	cmd |= (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	ret_bytes = pwrite(vfio_fd, &cmd, sizeof(cmd), cfg_info.offset + PCI_COMMAND);
+	ASSERT_EQ(sizeof(cmd), ret_bytes);
+}
+
+TEST_F(guest_memfd_vfio, bar_rw)
+{
+	struct vfio_region_info bar0_info = {};
+	ssize_t ret_bytes;
+	uint32_t val;
+	int ret;
+
+	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * Read Device Status (E1000_STATUS) via pread() at BAR0 offset.
+	 * Confirm device is readable and does not return 0xFFFFFFFF.
+	 */
+	val = 0;
+	ret_bytes = pread(self->vfio_fd, &val, sizeof(val), bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_NE(0xFFFFFFFF, val);
+
+	/*
+	 * Write a distinct scratch test pattern to RAL0 via pwrite() and read
+	 * it back via pread().
+	 */
+	val = 0xdeadbeef;
+	ret_bytes = pwrite(self->vfio_fd, &val, sizeof(val), bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+
+	val = 0;
+	ret_bytes = pread(self->vfio_fd, &val, sizeof(val), bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_EQ(0xdeadbeef, val);
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


