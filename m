Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FE456DFE;
	Tue, 28 Jul 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250216; cv=none; b=q0xVdJnvknl/SPe0ofBctzjuc2P+X3q5F3/AGmhC9pfy91mlS3z4uU+wvD0URRiAUROUKM0klS0SzLiM7wcHyUwqsKrhJrp4LBeq+8Hd6oXv6D2+PeBV5XoY9doa3juMves0RSGLyIP3Ms615EoJdfsXi5kHoWaU8WfP+IkRC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250216; c=relaxed/simple;
	bh=whZR3T8ziQI+fce1e9k/XdkohnbPf33HmGJb/97cChQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnQjVleKVTzfcxKEHMTGRfLnUlg8xzbnzuk8mAyZfVDegPFeD/2I43PUl2XhB/Ztm2yDXYq22n7dKnVf36DjKV5B5vHo/EWAZmTrPx6je7r9B/KMVJyszWskieIvLSfonP5xvzeXQDTLBypmasW6k0BFlj25nLtRHy5nY44FRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jiixrmxs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jiixrmxs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=e/GsYKz0pMOG8zTWZYGttSiBilY1RWe8Ai2810usw0k=; b=Jiixrmxs2uO1KMlro/kcFd7OoR
	UymNdsIswG1NHxkJWRMbPxTO4uVpF8JGPj7hpU5z+fkHRo642OFsOB3E9gbnotIZSy82Nfv1a+rgC
	FKslcdlrF1Q8SKbjURn55jHJaB96T7WC0aBr8YlRRmCCOWLeIQS7EOZfkQjTjweHFPa1Oc5n5ISpr
	ISmqkz8Mw+OG68MiUAU+/bXRDjC+jovXeMwwD0OCIf3N39cfJIzPnHch5cfvilStzHJww2AvwVttv
	+9IMMuufPcE5zLelaSObs9iAOAeyIeG/elt20owcrLirJmJgUffWNGcnvoe/0ZbxgnT2TsLPbGtL7
	nPCQmLDg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOp-0PsO;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7y-00000001UXs-48Me;
	Tue, 28 Jul 2026 15:49:55 +0100
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
Subject: [PATCH v7 01/36] KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
Date: Tue, 28 Jul 2026 15:39:41 +0100
Message-ID: <20260728144954.355376-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
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

The kvm_guest_time_update() function scales the host TSC frequency to
the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
scaling ratio previously calculated for that vCPU. Then calculates the
scaling factors for the KVM clock itself based on that guest TSC
frequency.

However, it uses kHz as the unit when scaling, and then multiplies by
1000 only at the end.

With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
the KVM clock advertised to the guest is based on a frequency of
2,499,999,000 Hz.

By using Hz as the unit from the beginning, the KVM clock would be based
on a more accurate frequency of 2,499,999,999 Hz in this example.

Use u64 for the hw_tsc_hz field since an unsigned int would overflow for
TSC frequencies above 4GHz. Use div_u64() for the Xen CPUID leaf to
play nice with 32-bit kernels.

Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/cpuid.c            |  3 ++-
 arch/x86/kvm/x86.c              | 18 ++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7a258831616f..bffce2167141 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -864,7 +864,7 @@ struct kvm_vcpu_arch {
 	gpa_t time;
 	s8  pvclock_tsc_shift;
 	u32 pvclock_tsc_mul;
-	unsigned int hw_tsc_khz;
+	u64 hw_tsc_hz;
 	struct gfn_to_pfn_cache pv_time;
 	/* set guest stopped flag in pvclock flags field */
 	bool pvclock_set_guest_stopped_request;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9e9cf6538a96..7049f5a5597b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
 #include <linux/sched/stat.h>
+#include <linux/units.h>
 
 #include <asm/processor.h>
 #include <asm/user.h>
@@ -2146,7 +2147,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 				*ecx = vcpu->arch.pvclock_tsc_mul;
 				*edx = vcpu->arch.pvclock_tsc_shift;
 			} else if (index == 2) {
-				*eax = vcpu->arch.hw_tsc_khz;
+				*eax = div_u64(vcpu->arch.hw_tsc_hz, HZ_PER_KHZ);
 			}
 		}
 	} else {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f1a829032c0..f7e1031f8eb0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -61,6 +61,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
+#include <linux/units.h>
 
 #include <trace/events/ipi.h>
 #include <trace/events/kvm.h>
@@ -1763,7 +1764,8 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags, tgt_tsc_khz;
+	unsigned long flags;
+	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct kvm_arch *ka = &v->kvm->arch;
@@ -1789,8 +1791,8 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
-	tgt_tsc_khz = get_cpu_tsc_khz();
-	if (unlikely(tgt_tsc_khz == 0)) {
+	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+	if (unlikely(tgt_tsc_hz == 0)) {
 		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
@@ -1825,16 +1827,16 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	/* With all the info we got, fill in the values */
 
 	if (kvm_caps.has_tsc_control) {
-		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
+		tgt_tsc_hz = kvm_scale_tsc(tgt_tsc_hz,
 					    v->arch.l1_tsc_scaling_ratio);
-		tgt_tsc_khz = tgt_tsc_khz ? : 1;
+		tgt_tsc_hz = tgt_tsc_hz ? : 1;
 	}
 
-	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
-		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
+	if (unlikely(vcpu->hw_tsc_hz != tgt_tsc_hz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_hz,
 				   &vcpu->pvclock_tsc_shift,
 				   &vcpu->pvclock_tsc_mul);
-		vcpu->hw_tsc_khz = tgt_tsc_khz;
+		vcpu->hw_tsc_hz = tgt_tsc_hz;
 	}
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;

base-commit: 271255273d5ff348fe29d89fe4712b2f7f7907c3
-- 
2.55.0

