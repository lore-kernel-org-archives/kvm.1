Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=yJnLknCj+L1aupnO9tC9dDbIIJSeAPdftBXeafesOojba0Wj6TXXnaAk2liSJsUJQa1K
	 OkH1gsuaUlVsq/iUERRf5LCux91ztUPuz/5DW55UgvzC5NTkTT1JAWxaYjjAArw77RBE3
	 NFLle+mXRU15uogejG3wZlnhfLt5ZqX/noYA6+hComNo690jrwo+V5+b1MH90A+Tqnm7l
	 cZER9nI8nLBKqGiTYhGrWXeah3gEfocLPYxxrpEyprtkWGbMArTBWQ8YY4vATtOekBSv9
	 qpQGhR6hhcBjitOYdGTMkudBdaXn/EfFh7JBzgyhRddH6cVIRJTb9OxIPB/qp0w0ncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=E7RyVZdQRrFYW33Mv02BmWV0i6lT0Z4tqhtPA/W0mTY=;
	b=jYw863juCLQmF9LVWh/1wItc2S+sCnp2rEChDrTcCLdMfihzVvgjOb30+yUfPq9OsaE2
	 RbwB1gKKyt3NHrD6XMN/489cvaDyjm8H9zhOQOjjwoyrT0boo2t4viPW1rP249qxx8NWx
	 kiicUGwepbgRZGRx6S0aEzYeH1pqAJcH+VE6Eh658xJv2UZxlOPkBF6+LtfARMTCpUFla
	 o0jrbchGGCYVCERwHh90bDOUgibijeEslL+iOnUXKDw1NtQszSurfU4bYgkx2DgRv8sQi
	 VLrVHXsBukI6oGzG9V2BGVkxPbpGYp4n9HnwCgiacj6yBn8WNOmlZrzDEZYiE6O0l9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=eRTdCHqg;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1E606EE91;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DE1E606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=eRTdCHqg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E7RyVZdQRrFYW33Mv02BmWV0i6lT0Z4tqhtPA/W0mTY=; b=eRTdCHqga3teHg35lgOR34b6cn
	q5ONSuVeHNVKKRQhXyunsALN4W0snuo3P9WVT2d7Njg81U3m3z4gQXwrbGBsR9lv2Wf8dJpU7S83M
	mS4itC92IvwcCfkkkL7fNswxRUZUXwYCmS5TPnc/VqyBmamjBnBTKFmZoaHNNQVdUDN4YMI3S+pep
	mV1q+heYNq36ool1b3tGlQYF4Z2MKkTHnYtDnzZmJtcIbWycSi/Oq5y8mCLzq28umFgdLXjmZdtaX
	d4FWYiWkFNy/jOjxliGlMuPCKiag2jMn1tEXHwGnH8sP7zJYqSBVodjBlP4DFFubP9x/c34WmO5IP
	jISvsmkg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AYF-29HJ;
	Mon, 09 Nov 2026 01:21:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKV1-0MD2;
	Mon, 09 Nov 2026 01:21:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v12 15/24] KVM: selftests: Add library helpers for clock and TSC-offset ioctls
Date: Sun,  8 Nov 2026 17:21:01 -0800
Message-ID: <20261109012112.3415328-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Add wrappers for KVM_[GS]ET_CLOCK_GUEST, the KVM_VCPU_TSC_OFFSET device
attribute and KVM_[GS]ET_CLOCK to the x86 library header, so that the
KVM clock selftests don't each open-code the same ioctl invocations.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../selftests/kvm/include/x86/processor.h     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..4062bdb32716 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -12,6 +12,7 @@
 
 #include <asm/msr-index.h>
 #include <asm/prctl.h>
+#include <asm/pvclock-abi.h>
 
 #include <linux/kvm_para.h>
 #include <linux/stringify.h>
@@ -1029,6 +1030,55 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
 	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
 }
 
+static inline int __vcpu_get_clock_guest(struct kvm_vcpu *vcpu,
+					 struct pvclock_vcpu_time_info *pvti)
+{
+	return __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, pvti);
+}
+
+static inline void vcpu_get_clock_guest(struct kvm_vcpu *vcpu,
+					struct pvclock_vcpu_time_info *pvti)
+{
+	vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, pvti);
+}
+
+static inline int __vcpu_set_clock_guest(struct kvm_vcpu *vcpu,
+					 struct pvclock_vcpu_time_info *pvti)
+{
+	return __vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, pvti);
+}
+
+static inline void vcpu_set_clock_guest(struct kvm_vcpu *vcpu,
+					struct pvclock_vcpu_time_info *pvti)
+{
+	vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, pvti);
+}
+
+static inline u64 vcpu_get_tsc_offset(struct kvm_vcpu *vcpu)
+{
+	u64 offset;
+
+	vcpu_device_attr_get(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
+			     &offset);
+	return offset;
+}
+
+static inline void vcpu_set_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+{
+	vcpu_device_attr_set(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
+			     &offset);
+}
+
+static inline void vm_get_clock(struct kvm_vm *vm, struct kvm_clock_data *data)
+{
+	vm_ioctl(vm, KVM_GET_CLOCK, data);
+}
+
+static inline void vm_set_clock(struct kvm_vm *vm, struct kvm_clock_data *data)
+{
+	vm_ioctl(vm, KVM_SET_CLOCK, data);
+}
+
 const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 					       u32 function, u32 index);
 const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
-- 
2.43.0

