Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FB2E738B;
	Tue, 28 Jul 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250220; cv=none; b=i6Puxy16Y8AgmCytXmF+uUde0+QA/kKGYoujTKZwsPX2vdvPjhtiNrOfuuHxLUdXrA7RbhzZM0DA0Gg/DCszj744VoiDHUWfJVEKVeeC2ka/1Gzp9KnD40FTeegxHInJ28w00faeVRTL82WGRHZ646Y3OTOvBGXd7Tbqzx+i9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250220; c=relaxed/simple;
	bh=7/ZTwUCs2P936mJ8HkKS/sqTxvVBcQW1Uj0yb8wpqoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOnvWGFZcIK20AdNOR+LmDQFuJiI1oM5u94Fkt0okiqqtodAaDDfhm1w4T2lU0DyxsQM5L0tzxSXPU2zpJqHrPoOJtoFgcX6ttBMviV2/k8QN0hchXWyUI6ZHG2Dd4UhDwC7wAktTnmhRkTNPz68JePhzkKniHKccyjA9oMbDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WfxkToMz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WfxkToMz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=FIpnIbjJ0pzN59/UsQ51DXTnfaDdE7kwlCIrC+Ft09U=; b=WfxkToMz9J4yo7htdBdApQX/+3
	/j7pFQ4Azzl+R6EK8CJCB0HorJqtYgyXCI3ci14hiUBFQuc78tdSkTFpjGKD8+59AkeHldWbH1Js1
	NZsBFb6yC9rysE7YhuRtIReSOpDKn/jRZ/4IwwST0FvXqtsQ5AKcjnurjpuNvjzpv86VwWbLfmMOk
	ACy+qLDjDwFP56e4ogOZ2idEmvDx11DWacVylhKJ0224yPnVRTazNdL5I+npc4QbRMfQoQGTWkgLz
	FvXNK4kkwhRVuQWMdMdwfno0gOPchLCYETpMDrc8TpUrjd847bKq1tMhxIFWjeaPZX8TsfnaVo9g2
	6uV6Rzxg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052VV-34XV;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYA-1Is7;
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
Subject: [PATCH v7 07/36] KVM: x86: Restructure get_kvmclock()
Date: Tue, 28 Jul 2026 15:39:47 +0100
Message-ID: <20260728144954.355376-8-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Wrap the entire use_master_clock block in #ifdef CONFIG_X86_64, since
use_master_clock is never true on 32-bit (host_tsc_clocksource is only
set under CONFIG_X86_64), and declare hv_clock inside the block so it is
not left as an unused variable on 32-bit.

Use 'continue' on the master-clock success path so the non-master-clock
computation becomes the common tail, avoiding a goto and label. When the
clock read fails (e.g. clocksource transitioning away from TSC), fall
back to that path rather than proceeding with uninitialised data or
spinning in the seqcount loop.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 590a7ba723f7..51908d7093ba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1653,34 +1653,38 @@ static unsigned long get_cpu_tsc_khz(void)
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
-	struct pvclock_vcpu_time_info hv_clock;
 	unsigned int seq;
 
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 
 		data->flags = 0;
-		if (ka->use_master_clock) {
 #ifdef CONFIG_X86_64
+		if (ka->use_master_clock) {
+			struct pvclock_vcpu_time_info hv_clock;
 			struct timespec64 ts;
 
 			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
 				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-			} else
-#endif
-			data->host_tsc = rdtsc();
-
-			data->flags |= KVM_CLOCK_TSC_STABLE;
-			hv_clock.tsc_timestamp = ka->master_cycle_now;
-			hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-			kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
-					   &hv_clock.tsc_shift,
-					   &hv_clock.tsc_to_system_mul);
-			data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-		} else {
-			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
+				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC | KVM_CLOCK_TSC_STABLE;
+
+				hv_clock.tsc_timestamp = ka->master_cycle_now;
+				hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+				kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+						   &hv_clock.tsc_shift,
+						   &hv_clock.tsc_to_system_mul);
+				data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+				continue;
+			}
+
+			/*
+			 * Clock read failed (e.g. clocksource is transitioning
+			 * away from TSC). Fall back to the non-master-clock path
+			 * rather than spinning.
+			 */
 		}
+#endif
+		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.55.0

