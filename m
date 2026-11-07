Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011841;
	b=VPeOYPjv3gWDmTey7+Nngxkf5RiBs9xvN8aJwmH7FMPFeV9Qto0sA0pJg7TI1vED1GMu
	 C5cMON7VC5Cut4waeUmH+QGymko1szxst6Ttd50/tLgBOk2WKQCUVjNhwy8dPguA7MrP+
	 E2TuNPEmKzH+HHFa9NEirDkJXWG3NsirGCBVuKpsTAPQxH/Gkl3ldyYAInZHzIDFDI5kp
	 /r7YDvPuMlp5BDTcUW7r+441NYLXj8VbKM3DLEcuUDXFUrzFETAOkdT64UZVKJyIm92dw
	 pqqYiFL6/i1I2aFKUAbE582JIPbJKfuXUm3FvbjI3UNrPkZacP8ExyubgFlwRdRBBoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011841;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OWCXc+dnEMwbKTD43nC4EzRdsnsdpyvJeWlTCArQCRA=;
	b=jIcMjQXM+bukCh9hE2FafyVx93gujAmdVzzYXmOcSVgD3yzFJ3o4DdkvcwXHF/TMo/bB
	 LFhaMo1pzk2rXsEDK6WZObyZq6srOm9kmAl59/evIZRt0TQHU99sxRCKjpE/npJSHAvwG
	 ZCmdqOjOH5WOZTZk5BxaZ0lRtaltHY+JzNrUNvjCcZMtvJvfO05bq2hNfJuOx1jiOH2y4
	 SYqZgEy/cEjlOw4MhiN419DiINtmDp7si9HHPndDcfhdq8RcZ9HaB+NTGsA+UCuAIYTMn
	 6dxP3rv6PTGEBOnnFAbwaP9QnHy5Sy6ASmtXaSU/L8iSi3/7kExCMS+YT1sto8DFnhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrBWd6Vu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05E606B753;
	Sat,  7 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrBWd6Vu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011840;
	b=um6h63HLeCa8SHiHA8pvn9VyIT5T3n2fRgCDGrhDQJOlBUbYS5TXkJbl/vuuokN8uqa3
	 9RBrimLF6FrqUS2ai4YoWQ/QvynlXSoQ37gm2RXAICftctPes/LzXqOxDxiqAMIzPQJ6v
	 jYUKhKx+aSR6IbsnOdW6qnJqG5R4r0XlWhzIt3dbCvDmM+CCGRs5Ms5Nw+gxrdlZPgbXI
	 To46EC8Q71RU7/nOt3o0vfHmyfvyo9jWcXmMZj3sCLHqnhvTxZzrHTi7ayyT7GsBlyduY
	 DtiuYYZ/AV34729CWjLd7ftNFi0xUpI+Eps/RtbGneUyR8MuDg3eS/EsJSQ7e7QboaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011840;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OWCXc+dnEMwbKTD43nC4EzRdsnsdpyvJeWlTCArQCRA=;
	b=J2E1eUc7RGU35+GCxHOHlXm2bQK53e7bBYieiVp5pvqGOFaAJRtT/3/WOd4JEmYWWLpO
	 BsnqisBeIf2pIQa5KZcgurthYcqHKwkJd9m6WO/GuiDQ1ElizZ68fdLiAn+LIuKfEJglY
	 IVWM6ENkSKHlQsClC4h/LXm+UIzXUy9QTvow76fMMbZoEJO/6jvHD/65VqF5HQYci8Aqs
	 ETd6uXEhn7jL6WfmVdB7PnzCKziB74YSSeHnMgCmkXtOUp7ij49PBr9gR1EwXDtofMFlc
	 limgh9G+xG1bCMudziZPHgelT0jaM/6Y4PCrWHOxWfHBzr79M8iopU3DV0bENqWkFwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D0D01F00926;
	Sat,  7 Nov 2026 00:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011840;
	bh=OWCXc+dnEMwbKTD43nC4EzRdsnsdpyvJeWlTCArQCRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XrBWd6Vu3Moee3w+OGR6e3eLfKy+aBp2gFpBtsgi7DQ5JQo5FFStzw6fKkoDhXSkK
	 7GrMP/nrDKJWCoZUjTynFZ2E9jrbBHF1CF2zQPFblXFOYKhqoyGeQx60p/dSRMHbCq
	 Q1RXnEA4Q3JDBM0TtYCidmnqzGWf32tZxNyDWB7LE/JxMDXkJZRsv6DPlPko06NiJF
	 T9GB4O0IBSntioURmoEYKLfYpDsctSyIDK47aSoD0odmPXaxoR+S8jNKJ4z9a8eRZL
	 m2roxUhYjfKDwumhoggheCgFzmnuLNHxFpo+2N9qNp2G8u7Fwsp6zyvls+B28ICCuv
	 fLJ5Mv9m4aZWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7ED5147A58;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:58 -0800
Subject: [PATCH RFC v3 84/88] KVM: selftests: Verify memory conversions for
 VFIO BARs
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
Message-Id: <20261106-gmem-alternative-providers-v3-84-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3071;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mn5g/ezQrSRqlCWnN+nnDw5IsR21Pq9gAvdK+Fhz9Qs=;
 b=i70tv0oqLMTnZRiaorGz0DGcWmezkAmqsVWRLymSSoaq0esH9n1mJOUngKhCcFjJnStDZemCf
 0HxnamsoFriCtQi8zwQet6zCIbYdktgo9xCiTYL76eXOLvQvfBusRFi
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest to verify memory attribute conversions on guest_memfd
files backed by a VFIO PCI device.

Verify that memory attribute conversion to private succeeds on
operational register BAR space that does not host an interrupt table.
Verify that converting back to shared also succeeds cleanly.

Verify that converting a BAR that hosts the MSI-X vector table and PBA
to private is rejected with -EINVAL, and that the returned error offset
identifies the start of the invalid range. Host kernel drivers program
MSI-X table entries directly to mask and unmask interrupts, so
converting these pages to private would trigger fatal hardware
protection faults on confidential computing platforms. Verify that
shared conversions on this BAR remain permitted.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index dde249571ebc4..18fab1a39041e 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -764,4 +764,54 @@ TEST_F(guest_memfd_vfio, ioeventfd_creation)
 	close(efd);
 }
 
+TEST_F(guest_memfd_vfio, conversions)
+{
+	struct vfio_region_info bar0_info = {};
+	struct vfio_region_info bar3_info = {};
+	uint64_t err_offset = 0;
+	int ret;
+
+	if (!variant->use_gmem)
+		SKIP(return, "Attribute conversions only apply to guest_memfd");
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+
+	bar3_info.argsz = sizeof(bar3_info);
+	bar3_info.index = VFIO_PCI_BAR3_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar3_info);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * BAR0 is an operational MMIO register space with no MSI-X table.
+	 * Converting its pages to private should succeed.
+	 */
+	ret = __gmem_set_private(self->gmem_fd, bar0_info.offset,
+				 bar0_info.size, &err_offset);
+	ASSERT_EQ(0, ret);
+
+	/* Converting back to shared should succeed. */
+	ret = __gmem_set_shared(self->gmem_fd, bar0_info.offset,
+				bar0_info.size, &err_offset);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * BAR3 contains the MSI-X vector table and PBA. Private conversion
+	 * must be rejected by check_set_attributes to prevent host kernel
+	 * writes to interrupt tables from triggering fatal protection faults.
+	 */
+	ret = __gmem_set_private(self->gmem_fd, bar3_info.offset,
+				 bar3_info.size, &err_offset);
+	ASSERT_LT(ret, 0);
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(bar3_info.offset, err_offset);
+
+	/* Shared conversion on BAR3 should be permitted. */
+	ret = __gmem_set_shared(self->gmem_fd, bar3_info.offset,
+				bar3_info.size, &err_offset);
+	ASSERT_EQ(0, ret);
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


