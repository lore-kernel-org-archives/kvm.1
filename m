Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893807;
	b=SyLuxegY6TCxbl2VvuKAQac2dDw/9CL2pV+IZJeJ9CBPeNF/F+gltlgmqG2oChuNjphV
	 XpsmLohMgpvhq9pAgpaDP7mxW4XoHZ8VruX9mbCmED2ghK9d3yAsMXdHJ62V/rTtUdir8
	 +4CEB+Gs6RKzsLWb4J8bJHdk/IIeo1/3O1EEOFCr6DuLt0y3TXSOxT17fxeD9qsyEB8Ls
	 N4QR7cymNOV7+Mw6G5iievEA+w+i+XuTzOfvkdCeIygfxwQJ545g/MlBPNR3p+O89Ywab
	 iS4bwyoZNXCquL8ugAh5lRHfxSBO01m+psrTPn/hQ99CAFvtruh676gyPDJNOBZ6K1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=E7RyVZdQRrFYW33Mv02BmWV0i6lT0Z4tqhtPA/W0mTY=;
	b=0NjPT2yJtBf4dxuNumZeoqxLPhrTaUsMya5CKWawWNCTCAU/0diyuMa560Dh2a64r4SA
	 N5XUTKNVmsLy4jZhx1rXqyAXS+IySdOsRRjzFuetj8Yim7O3l24TLfvEfCcbeDc+oUQ9D
	 0I6m9aNVl+DsP7JpMlxQdpF33kBN0t6LrTYyeCMy34B49uJp33EteSq5Ln90yYsCK0n4e
	 u1rgB98dPHduQiQoQ/nn1+BYf7HX9ruBJ2Iu5zOEKb98v5hVxb8VlhpYdgsOgJ3u2AUDO
	 l0kXRNzM20k37f6nnqgSU1u9c7B1/QhukVNc5l9++M+TeGEC3UtqkQdCqUHYXPnRA1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=H3IO0BEc;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B560A6F7A;
	Thu,  5 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20B560A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=H3IO0BEc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E7RyVZdQRrFYW33Mv02BmWV0i6lT0Z4tqhtPA/W0mTY=; b=H3IO0BEc+tQjGnS83F/d68xSGQ
	sdR973IX6KJN+GBLVRhsF06Ti8RuEQwhNP+LZHL7gv+WSMh+J7yMufvn+h6VDCzabk/PZVNrqGHTb
	gSPrSNiG6QG3qq7mOi7ym0EaOO9pf9KzTjpHvdunnmnNJ+WN+h6UpSlSaP4TfzzoNfFal8cA2XU6Z
	KOK19dbEi/Em1Xm3qau8q0cXGtIbXMNM6e77BmNOZKOiFkLqmvhFmzQR/vR+KwS9QFMi2ACqLqKD3
	T0r6DRaGJJ7Rjft+clXBibsPDMfggrObKJTJhd5z1BZ8dY4v9uN9moIERg57kTWHufN4uSaKLmFk5
	RJcIlilg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziu-00000009aov-1vhq;
	Thu, 05 Nov 2026 15:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOziu-0000000Aazk-0yJg;
	Thu, 05 Nov 2026 15:49:56 +0000
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
Subject: [PATCH v11 15/23] KVM: selftests: Add library helpers for clock and TSC-offset ioctls
Date: Thu,  5 Nov 2026 07:49:46 -0800
Message-ID: <20261105154955.2525419-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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

