Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7973FBEAB;
	Sat,  9 May 2026 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366940; cv=none; b=aRrOWHb8qpFeYhtE+C02goQRDOMF/GPDm2EIwWLg/vciW/BmOOln7gKF/Wq1PNgvN6fSUi4qwC5DWQOVyvH9TykfnXj6Xb9yXGthOPPSOk19wxGYUPk6dO6XuUxkh3Vwt76mMr4rOChDDU9Wp0lcLHkY2ch92afA02PQ34hetxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366940; c=relaxed/simple;
	bh=U5WzndrfKfyanYf5TzqRh9YZIWtISUEBkNnrk6RlZFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK+kGXv9zw9rc4E0b6Blfy1829KWo2e/W6u1Ut+BYh1yVoAV4Bo4tKMog84is73ktlQZkAeIkr8B0zyHPHPPTjJrbN3pZ7BDGskoHW3lpsJ24sm5VSTes530+g+ATMRKylx37arwT6R+mEgdCNKaKIB+WuAWbvNu6X4ydx1Wtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u6RYDSbD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u6RYDSbD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=iccKma5DaUh/za+fsn0g6dyqukLvuPzbIDc21T+eVFU=; b=u6RYDSbD4U67hGcbeOF2FyQMxF
	4dNfxJgj+Jw1VpmpgORUTUZi/lx3jqCjscmmNps9Ktu6RmyhKNQqG8Zrshc/lCMPNKFIfu5ClurIy
	afITS5d2xHSMWTG1ed+ca466NtWYvBcu88t51HCKij8WUt4q45fFjeqxZY2/6d429QdDCMJqzlYX7
	P+yZB0umg7J4duqoMjVX9Fgti9c5kdgIh1TnkR32o+5SZVuXwWnuwEIwgF0Q+TO4dsFx/cw9gg56g
	4jcjQhe2ozp2dKpbnlzBRde2x4i2wfno53zqxKIRk7l41GA2YKpPWUPfJlcBAfuh3NmuEZZFoC7Td
	q83vedYA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-000000060LN-26fo;
	Sat, 09 May 2026 22:48:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhIz-16xH;
	Sat, 09 May 2026 23:48:27 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 27/30] KVM: x86: Add KVM_VCPU_TSC_EFFECTIVE_FREQ attribute
Date: Sat,  9 May 2026 23:46:53 +0100
Message-ID: <20260509224824.3264567-28-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Add a read-only per-vCPU attribute that reports the effective TSC and
APIC bus frequencies as seen by the guest, after hardware TSC scaling
is applied.

This allows userspace to populate CPUID leaf 0x40000010 (the "generic"
timing information leaf used by FreeBSD, XNU, and VMware) with correct
values, without KVM needing to modify guest CPUID at runtime.

The effective TSC frequency differs from what userspace requested via
KVM_SET_TSC_KHZ due to the granularity of hardware scaling and the
host kernel's measurement of its own TSC frequency.

The relationship between the attributes in KVM_VCPU_TSC_CTRL:

  KVM_VCPU_TSC_OFFSET: the offset added to the scaled host TSC
  KVM_VCPU_TSC_SCALE: the raw hardware scaling ratio and frac_bits,
    for VMClock and precise arithmetic
  KVM_VCPU_TSC_EFFECTIVE_FREQ: the resulting frequencies in kHz,
    for populating CPUID leaves

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/devices/vcpu.rst | 33 +++++++++++++++++++++++++
 arch/x86/include/uapi/asm/kvm.h         |  6 +++++
 arch/x86/kvm/x86.c                      | 23 +++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 56562b932280..75d1c2bbb8bc 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -326,3 +326,36 @@ host TSC values are converted to guest TSC using the formula:
 Userspace can use this to precisely calculate the guest TSC from the host
 TSC at any given moment. This is needed for accurate migration of guests,
 as described in the documentation for the KVM_VCPU_TSC_OFFSET attribute.
+
+4.3 ATTRIBUTE: KVM_VCPU_TSC_EFFECTIVE_FREQ
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+:Parameters: struct kvm_vcpu_tsc_effective_freq
+
+Returns:
+
+	 ======= ======================================
+	 -EFAULT Error reading the provided parameter
+		 address.
+	 -ENXIO  Attribute not supported (no constant TSC)
+	 ======= ======================================
+
+This read-only attribute reports the effective TSC and APIC bus timer
+frequencies as observed by the guest, after hardware TSC scaling is
+applied::
+
+  struct kvm_vcpu_tsc_effective_freq {
+	__u32 tsc_khz;
+	__u32 bus_khz;
+  };
+
+The tsc_khz field is the guest's effective TSC frequency in kHz. This
+may differ slightly from what userspace requested via KVM_SET_TSC_KHZ
+due to the granularity of hardware scaling and the host kernel's
+measurement of its own TSC frequency.
+
+The bus_khz field is the APIC bus timer frequency in kHz.
+
+Userspace can use these values to populate CPUID timing leaves for the
+guest, such as the generic timing leaf at 0x40000010 (EAX=tsc_khz,
+EBX=bus_khz) or hypervisor-specific equivalents.
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 384be9a53395..196899296f84 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -962,12 +962,18 @@ struct kvm_hyperv_eventfd {
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
 #define   KVM_VCPU_TSC_SCALE  1 /* attribute for TSC scaling factor */
+#define   KVM_VCPU_TSC_EFFECTIVE_FREQ 2 /* attribute for effective frequencies */
 
 struct kvm_vcpu_tsc_scale {
 	__u64 tsc_ratio;
 	__u64 tsc_frac_bits;
 };
 
+struct kvm_vcpu_tsc_effective_freq {
+	__u32 tsc_khz;
+	__u32 bus_khz;
+};
+
 /* x86-specific KVM_EXIT_HYPERCALL flags. */
 #define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77dfd4455a4e..c15303963686 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6079,6 +6079,9 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
 	case KVM_VCPU_TSC_SCALE:
 		r = kvm_caps.has_tsc_control ? 0 : -ENXIO;
 		break;
+	case KVM_VCPU_TSC_EFFECTIVE_FREQ:
+		r = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) ? 0 : -ENXIO;
+		break;
 	default:
 		r = -ENXIO;
 	}
@@ -6115,6 +6118,25 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
 		r = 0;
 		break;
 	}
+	case KVM_VCPU_TSC_EFFECTIVE_FREQ: {
+		struct kvm_vcpu_tsc_effective_freq freq;
+
+		if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
+			r = -ENXIO;
+			break;
+		}
+
+		if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu))
+			kvm_guest_time_update(vcpu);
+
+		freq.tsc_khz = div_u64(vcpu->arch.hw_tsc_hz, 1000);
+		freq.bus_khz = 1000000 / vcpu->kvm->arch.apic_bus_cycle_ns;
+		r = -EFAULT;
+		if (copy_to_user(uaddr, &freq, sizeof(freq)))
+			break;
+		r = 0;
+		break;
+	}
 	default:
 		r = -ENXIO;
 	}
@@ -6155,6 +6177,7 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 		break;
 	}
 	case KVM_VCPU_TSC_SCALE:
+	case KVM_VCPU_TSC_EFFECTIVE_FREQ:
 		r = -EINVAL; /* Read only */
 		break;
 	default:
-- 
2.51.0

