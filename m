Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214156;
	b=tpMLsJqR5Mdv8EkYwuvDUKc2xGMn+u5TFXQMWvzvEse1SgtkUDw1jGu3kd+K5Bvaw6qt
	 Q06eq2HVJ1eqeqXAyFDnTrUDp2D/iBXye3ABe1mnNzMMB9SD8DMGv64FRb+gUYKv/wX4B
	 /eY5f8QNo+lEJKesZKt8OCZHVb7fCwuTXPhl2Pm+Am/G4mvR+hdXQVv42zQKqfguKtwwi
	 LnrE6Okhwy+/9bTb/mYmJyLinF6uyXwZAOZ8zroJONT/6lqyRuJEGzcP/Nvn8EJoiGbBY
	 RhGaRFSvNQEfLqGdF+vLKo+IuwutofhYDIgRCMW4GDl08igl3F/GcluoFPHXUHtM44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214156;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AfXeCeneHqNmuixn/C9DCjk2UEGT5HCCQsR07Fy0vVk=;
	b=knOf2Q1SmKxTAO8MBbrUxqvtZH2fFQeLVab83oNtiKJGpToplpohCr/UDFceY8J2LnZg
	 N0XoDQZFFOtyvCqzypD5AjTPHDrGvyPzJ5RO31KMqjbgS3ExoxVUy4d01LgyuKR6XFkgB
	 sohZvksXLZfOpPfWgJy+Dn1fBUmgXVMVTXB48p9aF+d6WQ45SiDxCin0PlIhN115OCMh8
	 OG3npCKHN2T3Z/7LV/4GtkX50M4he64j3P9z8x6WU9Us+/dDqlQ74rR9gt52v748RmW2y
	 UhM3nkMZw6lsr5uPDSUAN0Bwj5YW1TZssX2Rilbyvy0vQts2PaF4h+LigK0ja1op4wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GgtV2rMd;
	arc=none smtp.remote-ip=95.215.58.153
Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60112606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60112606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GgtV2rMd
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RoNzd28AyvTb0ibr+4xItgKDPl/EqyvaBO8VS7dD1Vo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214153; v=1; x=1794818953;
 b=GgtV2rMdHkAv2ej+ig2FtoiekZcw/PpaUYvKu19D7m/vypxOQTR90wu3EHIc6YIRNambBwlV
 qlp4ZWhZfcpA46YgvjovCbehCYIqw28KSvEGwlSDoQysx4BTsp1nVgccCDqm8IzSf8HFNxb4EQ0
 EaJ2G+V1y52yXP2AYhS7LVPI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 00fa88a3a43f583a;
	Mon, 09 Nov 2026 08:49:13 +0000
X-Mizu-Trace-ID: 00fa88a3a43f583a
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/19] KVM: selftests: Export the ucall pool's guest physical address
Date: Mon,  9 Nov 2026 08:48:40 +0000
Message-ID: <20261109084854.840576-6-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A protected guest's memory is private until the guest itself shares it,
so the guest has to share the ucall pool before its first ucall. The
host can't do that for it. Only the guest's copy of ucall_pool holds the
pool's address.

Add get_ucall_pool_gpa(), which reads that copy, so that the host can
pass the address to the guest.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/include/ucall_common.h | 1 +
 tools/testing/selftests/kvm/lib/ucall_common.c     | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index cbdcb0a50c4f9..3a6cdf9aa0464 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -41,6 +41,7 @@ __printf(5, 6) void ucall_assert(u64 cmd, const char *exp,
 u64 get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa);
 int ucall_nr_pages_required(u64 page_size);
+gpa_t get_ucall_pool_gpa(struct kvm_vm *vm);
 
 /*
  * Perform userspace call without any associated data.  This bare call avoids
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 029ce21f9f2fa..aa1f0f92c6d1d 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -21,10 +21,17 @@ int ucall_nr_pages_required(u64 page_size)
 
 /*
  * ucall_pool holds per-VM values (global data is duplicated by each VM), it
- * must not be accessed from host code.
+ * must not be accessed from host code. The host reads only a VM's copy.
  */
 static struct ucall_header *ucall_pool;
 
+gpa_t get_ucall_pool_gpa(struct kvm_vm *vm)
+{
+	struct ucall_header **pool = addr_gva2hva(vm, (gva_t)&ucall_pool);
+
+	return addr_gva2gpa(vm, (gva_t)*pool);
+}
+
 void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
 	struct ucall_header *hdr;
-- 
2.47.3

