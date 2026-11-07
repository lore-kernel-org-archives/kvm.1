Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011843;
	b=dELsmD/I+rt3cLVnA+Q2/y0iaxswfiONgVOGPhzm/4Y+QvjJACGXGxcHtGDN/t6u96yY
	 chHa8IbY9FTLRC+IELDEdrKll6hswo8w4R3WJt8TipAktRGnLe1ALs7HOS6dsOvn83aOY
	 PEwUSpugiXsTElvaZjAjtE+WPXa4hKG5ddjCuu2NXNP1t5i8qpOIUgL8g98xwfO5LqMNm
	 PkugwHSeuDTTp3QCSFaDivW0dqfiS8bGky7KprTsYlUfX5Kea8oApRnetx4jXTWNnYX/o
	 oTs3V16lF88HyQsNthbB8Mjr5Gk6kUVfNuIhfEIsGSv/2j5WS9mrpgWN0nSwG9kiKww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011843;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pkX5RglPGJDEhnslhp8xP4OHF0T6ris68N5dtaSSV90=;
	b=GS+27fPAprRbjsnNfPfLTWmHDNb7bqk0VgngwtqNFlTmTCzkAcXdmVbFIxzfOSEark3B
	 HFb66/200TBup+1OZznrPEqHm0GVefVXSUrrG8vdjNO/7ZWAUmjVWMU0WXbcsvxBCJWs8
	 UX0C23kSi5POhfu/bN/ZtiuPw/TFDWo4E1I2SvY0HOwI0qYZK3iFIUZI8XA2yh1kfw2IQ
	 9uHdY5CAXvu0t242eopez0Gt0acC2VAst/ZNYul3+0BRWybRc+QzpvUJQZwFL/fCezuBA
	 9nmkxutzOxc67TXzcKQGiLxzKkbxX+pUkGAorgYnv1nixDoRjo59fNr0jDLDkePwqNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IK/m6TYo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B47606A824;
	Sat,  7 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IK/m6TYo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011838;
	b=jIhZc3YtIfe5cGjupmPKguq3MIOc4IViaBNarp0kezszBSIFeD+vPD8seCd1Al+3SJEO
	 VR34ACWL7VVY8kCdC65950LNEgqgK1t+Ly18bwxDs5JBsTmc04v4dh+6cPoOy+LUtpDhF
	 nJmORB1n0eS6nCeZ9g27wqIPq/rXu7vM+0Kjcq2fDBsyVMOt3akP9k2chiNCyG8UAKJQn
	 UTzsv8hJ7DEa/H66j6Aq8t78biqBmEc0nIUV5QN7Rr2vqpfzJ2hqMunHEsEV0nznp5yzH
	 7cPKLI+RD0ckxbb/xKrYqV5c7dl6ZYEJCRheBpen4BrhwrmCgQmvgdVCL0UzQh12N7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pkX5RglPGJDEhnslhp8xP4OHF0T6ris68N5dtaSSV90=;
	b=znU0U+Bvk6MTU7HjAJKMKPgZMxkvgaHbhXJJOQhopEd4l3ntegVilnlcOKygdcedpREH
	 dRU1Y4TXK50KyaDv52X3RTTIl7V6EUcaH8vuRKYA57BOSC7sRaAbcVNL+k+8rOo3FpeBB
	 mzd5aaiah9WMFQ8JOZ7yHd2T+upw8XvoSTOpr1ooVRWkFQPsGYvFkU7425vcqD/RvQSUC
	 VeC4fktfigpFXrrZfYM8pxGrDhBaKMhNz/XCjOpjmSvcFCy36u+2alrlTveh75ZLgTEgJ
	 OM76TdLjoRpoEX0YpFSg3vsSnxkllePOTWARQa5ymFaFOPMdVADiDZmJOYDN7hFD+Dg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F5AB1F00925;
	Sat,  7 Nov 2026 00:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011838;
	bh=pkX5RglPGJDEhnslhp8xP4OHF0T6ris68N5dtaSSV90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IK/m6TYodvJPSVDageZXSBAYTxQxbGrpYMBiiX865Fpf4W5Xl9gj22vVhvpjq0Ve7
	 bCe04St6ikuvo9AjP6+boQR7205VjcIvKyvfudmdaD/gH9zidXt+LF1/gDbsTxcp8l
	 r8BEC4wBThd9pPL8u8Xy9T9/0PHLU+fc7PUqhEB5HnpJAWFOwmw91kI45v5o1/tww+
	 KbSjbMNLOPJkZsZuK25UYWA0muMoflzeKQOTXbSznzaMQJnzMN2JAPjZGpvKk7ytKj
	 INtVQhNY88zlGGVQZtp0bOlJbHKQmbxSu6/7FUK0IBpZCKclHC8ot5C9pwEWX4kKxk
	 GMS3EHMSEy06Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 708A547A55;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:57 -0800
Subject: [PATCH RFC v3 83/88] KVM: selftests: Verify VFIO ioeventfd
 creation for igb device
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
Message-Id: <20261106-gmem-alternative-providers-v3-83-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2410;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=lOTB0T1ZgH2qBwxbzF1p5KVxU2nrnnE76xPmcwyhgYk=;
 b=dWWgKLHu4omBOrcbWgEzhyA8WgLPlocfMYQX0wM811XEqldFlmfdRwW/DSH6jtFRb5JzYUcHE
 Z8Q/wpLQ65VBYUKMm9/i2vELQblt1W1Vak0UmJun4RPZLtCa7JjWqVb
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a subtest to verify ioeventfd registration and unregistration on
the bound Intel 82576 device.

Allocate an eventfd and configure a VFIO_DEVICE_IOEVENTFD ioctl targeting
the scratch receive address low (RAL0) register in BAR0 with 4-byte width
and a test trigger value.

Assert that in direct mode registration succeeds and that unregistration
(passing fd = -1 with matching register criteria) succeeds cleanly.
In guest_memfd mode, verify that ioeventfd registration is rejected with
-EOPNOTSUPP.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 46d325228bda3..dde249571ebc4 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/eventfd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/types.h>
@@ -725,4 +726,42 @@ TEST_F(guest_memfd_vfio, dmabuf_creation)
 	free(feat);
 }
 
+TEST_F(guest_memfd_vfio, ioeventfd_creation)
+{
+	struct vfio_device_ioeventfd ioeventfd = {};
+	struct vfio_region_info bar0_info = {};
+	int ret;
+	int efd;
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+
+	efd = eventfd(0, EFD_CLOEXEC);
+	ASSERT_GE(efd, 0);
+
+	/* Register ioeventfd on BAR0 targeting RAL0 with 4-byte width */
+	ioeventfd.argsz = sizeof(ioeventfd);
+	ioeventfd.flags = VFIO_DEVICE_IOEVENTFD_32;
+	ioeventfd.offset = bar0_info.offset + E1000_RAL0;
+	ioeventfd.data = 0xdeadbeef;
+	ioeventfd.fd = efd;
+
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_IOEVENTFD, &ioeventfd);
+	if (variant->use_gmem) {
+		ASSERT_LT(ret, 0);
+		ASSERT_EQ(EOPNOTSUPP, errno);
+	} else {
+		ASSERT_EQ(0, ret);
+
+		/* Unregister ioeventfd by passing fd = -1 with identical match criteria */
+		ioeventfd.fd = -1;
+		ret = ioctl(self->vfio_fd, VFIO_DEVICE_IOEVENTFD, &ioeventfd);
+		ASSERT_EQ(0, ret);
+	}
+
+	close(efd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


