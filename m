Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6B3D3D06;
	Sat,  9 May 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366932; cv=none; b=irBF2PJTNe/ymsly8O4GrL2GH7nSf2cpoODOjv+hkKy5vdDVkVUZkbxTDaqVaHYfVrMtrozDDfzMUUa7PkaFNcbck7IO9wIiD/FuK76h1LyCIPX4E542TEmKJp05JgHFDI4J+BJKH41a3pVqq//EEtLbwEeIjsa971+uMJv/OEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366932; c=relaxed/simple;
	bh=nD8NLvLQQAy3Q5Zob38SOomS4XrhxLrSOfIB14pPA60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3kZkw1cmJOZ3+s6o+wbqHeFGN4jyNfktsyy/zTbaDqygl730YSmHFCVLy0h6DwKdQ4VQfq3N9Ot4DNzquME97PDcn3a+X3qgXdoR+fq9yl4em2ZAoUPUM464xVEbgTINkVJYF92o/PAklb9FSiZkVdItdGMoy0wrsIhPcYBxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zf77LfPt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zf77LfPt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=HcPos2+xuZTjBV7pxq7NSClTpw+Fu99QdQJ5Jy1Ls+M=; b=Zf77LfPtfI70hL1gqLbAhPtLtX
	ibkr66p3p6/yNwf1wG6qqc/ms/D0cd+mf/gL9RKluGUlABJWL954X+hC7rfWjImiJ7CROZMthVqh7
	OTkMC4vADFkwf63SWHGMNbF2qJVf9rruhAcDBmTZgzvOH0jHPndB5bEQv9StPED9R1rJWRdq5KqsA
	idLIC0tiDnsbUYQlxQkaFsJ1rxU7HJqRe1UHoilCGBY2oTbY3Qok9mr4jH7I9F9puYYvsCXOgoRSg
	aGZgxEUEluS1lC7dL54o1eq6sM/iCEMUEUte4b9q7W4oNzFdeq8Z9C54Hgb9kHKHIxTuTapNwFb2v
	46Z9XONA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-000000060LP-2pj4;
	Sat, 09 May 2026 22:48:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhJ7-1V2k;
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
Subject: [PATCH v4 29/30] x86/kvm: Obtain TSC frequency from CPUID if present
Date: Sat,  9 May 2026 23:46:55 +0100
Message-ID: <20260509224824.3264567-30-dwmw2@infradead.org>
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

In https://lore.kernel.org/all/1222881242.9381.17.camel@alok-dev1/
a proposal was made for generic CPUID conventions across hypervisors.
It was mostly shot down in flames, but the leaf at 0x40000010
containing timing information didn't die.

It's used by XNU and FreeBSD guests under all hypervisors to determine
the TSC frequency, and also exposed by the EC2 Nitro hypervisor and
VMware. Use it under KVM to obtain the TSC frequency more accurately,
instead of reverse-calculating the frequency from the mul/shift values
in the KVM clock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_para.h      |  1 +
 arch/x86/include/uapi/asm/kvm_para.h | 11 +++++++++++
 arch/x86/kernel/kvm.c                | 10 ++++++++++
 arch/x86/kernel/kvmclock.c           |  7 ++++++-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..03fa1228fcf2 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -121,6 +121,7 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 void kvmclock_init(void);
 void kvmclock_disable(void);
 bool kvm_para_available(void);
+unsigned int kvm_para_tsc_khz(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
 void kvm_async_pf_task_wait_schedule(u32 token);
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..dc0d036fe678 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -44,6 +44,17 @@
  */
 #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
 
+/*
+ * In https://lore.kernel.org/all/1222881242.9381.17.camel@alok-dev1/
+ * VMware proposed a timing information leaf providing the TSC and
+ * local APIC timer frequencies:
+ *
+ *  # EAX: (Virtual) TSC frequency in kHz.
+ *  # EBX: (Virtual) Bus (local apic timer) frequency in kHz.
+ *  # ECX, EDX: RESERVED (reserved fields are set to zero).
+ */
+#define KVM_CPUID_TIMING_INFO	0x40000010
+
 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 29226d112029..60375165b66c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -910,6 +910,16 @@ bool kvm_para_available(void)
 }
 EXPORT_SYMBOL_GPL(kvm_para_available);
 
+unsigned int kvm_para_tsc_khz(void)
+{
+	u32 base = kvm_cpuid_base();
+
+	if (base && cpuid_eax(base) >= (base | KVM_CPUID_TIMING_INFO))
+		return cpuid_eax(base | KVM_CPUID_TIMING_INFO);
+
+	return 0;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b5991d53fc0e..74aca22dc726 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -118,7 +118,12 @@ static inline void kvm_sched_clock_init(bool stable)
 static unsigned long kvm_get_tsc_khz(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	return pvclock_tsc_khz(this_cpu_pvti());
+
+	/*
+	 * If KVM advertises the frequency directly in CPUID, use that
+	 * instead of reverse-calculating it from the KVM clock data.
+	 */
+	return kvm_para_tsc_khz() ? : pvclock_tsc_khz(this_cpu_pvti());
 }
 
 static void __init kvm_get_preset_lpj(void)
-- 
2.51.0

