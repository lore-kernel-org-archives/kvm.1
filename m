Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011845;
	b=Jp6wUFp04qi46RylToYcv0qtZ/n89cVASd+LB2I0sFkE9/jlH4JMVpyvbDlU7b2Ku+go
	 UU7tmSLYmDlQXqnbUo1v8hOVd97iy1lzRUEXpoFiR6GmSctKvftzsdDATAUCIrH+j9j01
	 Rxwqgz7fC6UhDAcxreXYg7Hx0FKlofhV2Cvxlpr1jwOGoTMtGD9Zom2TIRPifMf1WlvPt
	 NPlEBJmclfyabx/TB91BnOQXA8oOGRBxGO5ev1A+uEGnGZEoe/VUqbtB5mjB5XrdjC11w
	 Sd/7MUh68VnSMJtkOV7ZMNO17LG9pTeBSuhDGR6IMCR3odzdZ0WQGxfn4+mXj/Iy8xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011845;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M1cXkOgzZjDMJwHRh87UzeiwzMokp065wJbSjfeeioc=;
	b=DxamOa0fwqK0lZEHRlMlv6mNd2YSgs78a43uxEd4OyvExAHwtZR4zfVfwp9auGifD93V
	 cJOAuKW3xlT+hhChB+K4pfvRQCh26UJji4fFxyYq7tSpjX2U1dDhAD+S/q5xaNLxMF8j9
	 z8z+C/e0q85rGLhZqW7xVlmV9K9ZK5cmb1BRREK1otJCPwWXskXJgX5lhDSd3CaRyOVt0
	 TTb8D1865woVi616KxKSKsKEbapMcRug+bgshw8wmlZs5tDlWhfulib+3wwAeZ07pKlyj
	 Nrfd5sXxcxskJyZLhpBG5kYJvyZyNCvPKVTINfv8s9hma8dAtcSWLfOE/XHu3mCp6Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXxRtu60;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED9606AFB9;
	Sat,  7 Nov 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXxRtu60
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011840;
	b=BXXAr0Ytr0ihc6QOLCaVjWx6dsHGfm0vjxYYrWCpNQ39r9uvPzhucCJL4t2yRrZVye+r
	 uoTvdMPZyoti7VuGBnXmsebYHPcs5qKq3IZzfswFXkIsnMAEf3k1SqZ1VMlCtA/rOK0wT
	 GAwSGI2WfKVbQYnt1bB711mDU+Hsjemt5BbUeLsM4D82KFIf+iZc+gEYmlE9GieSRf57p
	 CJE4vNX2RomW5VVLJSlGAA6NPqWYhDt4m13QqKaRuv1aelvohOkucsyP2cgsw5C0T/AeV
	 84qfISAVikhwpJyhkGPoNikKbeQt6m9bLioKymwCb0XXGwctbNE8CEozeVhq8G51UQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011840;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M1cXkOgzZjDMJwHRh87UzeiwzMokp065wJbSjfeeioc=;
	b=IHum0TXEkhMnoSEe8xdw51h5zyxd+dcB+q2Ca4xWO5P4/kSutpVD936q/E+YfSDLDHcr
	 SSw37qTHWc4nm6MzgsGyE5KGMGBq+ScKMboXuo4ouigRlgLEkWd/vEsQ+uuPl8wHVVyLB
	 2IoERIxJm2U7F1fSF+k8Ys4RsC6B+spuVP23ZTpuy+Xik19LemP62346u1XI5zN5L2DjB
	 Kjojw2tgfw1pkPJ2bJHOVOgmUW+np1Hq2S9PXGqbx7O3ja9s0OQZK1CaweebVCHzXXn56
	 zvoKd+BFuWcTE+IOGhMzrqUCTn1wpkCnwpBKdE1WEY/Qv8XqQp+l9WbjT/oSIgp5j7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A01471F008A1;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011840;
	bh=M1cXkOgzZjDMJwHRh87UzeiwzMokp065wJbSjfeeioc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NXxRtu60BWP44qbkoD17v5SKSPpfy6O5yo6f8smG9mbfn9ef3nc72RIIyUOOKpjsB
	 Xp9CQ9d6MgSeYAy+GNZvkoA3kMD/p9DyDPJO0JXbetClrMzIZE2SJwR36CDCUC7OwK
	 s/oJlpfm6ksO24kCbGQBQWaop0O+nzZjFbdo43yUTzzibVWrjoNqiGKDJyXQR7hcEa
	 yloC6oKLfIrhIj1RrBMW6dEQsZ73+UCdftbkRLglWGo5rIqe+Jjfxesc9aDrISaDGK
	 zZPVXwU1iqB7wtds57HKFpOyVwS1OWyYqx0WmGMRPu3WyELZoLD+AUSQOh3iy7uzz+
	 vqVwlXURlZehQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CFF4C47A30;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:47 -0800
Subject: [PATCH RFC v3 73/88] KVM: selftests: Verify VFIO region info for
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
Message-Id: <20261106-gmem-alternative-providers-v3-73-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2549;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mrWvs6FF7l4LpcTEng8nbYIsnoTAo2jJxDhGuJ9QU+g=;
 b=wY395FIuwjLW/oJNaiS8f/FOkSCxKWTmBujK/E4H3vKhDyLPEibe2RUJEOyL3f7zZZ6SQEXMe
 pVDqo0rakbqDQ8XO4K1/+VBsAUIcnImILMrQ/YDvpu/qskpIqC2kMNB
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest for VFIO region info queries on the bound device.

Verify that the operational register MMIO space (128 KiB), MSI-X table
and PBA space (16 KiB), and extended PCIe configuration space (4096 bytes)
report their exact sizes and expected access capability flags.

Testing multiple regions establishes baseline checks on the underlying
device descriptor so that when VFIO BARs are later delegated to or wrapped
by guest_memfd, native region querying on the device descriptor is
confirmed to remain unaffected.
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 669acc6058b5b..c76abe6d45140 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -150,4 +150,42 @@ TEST_F(guest_memfd_vfio, get_device_info)
 	ASSERT_GT(dev_info.num_irqs, 0);
 }
 
+TEST_F(guest_memfd_vfio, get_region_info)
+{
+	struct vfio_region_info reg_info = {};
+	int ret;
+
+	/* Test BAR0: 128 KiB MMIO register space */
+	reg_info.argsz = sizeof(reg_info);
+	reg_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0x20000, reg_info.size);
+	ASSERT_EQ(VFIO_REGION_INFO_FLAG_READ |
+		  VFIO_REGION_INFO_FLAG_WRITE |
+		  VFIO_REGION_INFO_FLAG_MMAP,
+		  reg_info.flags & (VFIO_REGION_INFO_FLAG_READ |
+				    VFIO_REGION_INFO_FLAG_WRITE |
+				    VFIO_REGION_INFO_FLAG_MMAP));
+
+	/* Test BAR3: 16 KiB MSI-X table and PBA */
+	memset(&reg_info, 0, sizeof(reg_info));
+	reg_info.argsz = sizeof(reg_info);
+	reg_info.index = VFIO_PCI_BAR3_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0x4000, reg_info.size);
+
+	/* Test PCIe Config Space: 4096 bytes extended config */
+	memset(&reg_info, 0, sizeof(reg_info));
+	reg_info.argsz = sizeof(reg_info);
+	reg_info.index = VFIO_PCI_CONFIG_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(PCI_CFG_SPACE_EXP_SIZE, reg_info.size);
+	ASSERT_EQ(VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
+		  reg_info.flags & (VFIO_REGION_INFO_FLAG_READ |
+				    VFIO_REGION_INFO_FLAG_WRITE));
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


