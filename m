Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F333262A;
	Fri,  3 Jul 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113815; cv=none; b=eSkDptnTcqqLjq4XmX6PNuEvAVdoxKEWq3/jWND4ZsfPVz4riY5uBt3HiriO+Hi2FinjWB6YIYtTww4/+J5UzbJZNq+O+10EEEvgZ3jybIXKyoFxSlJYmY1mFAI3h3k1J/gfk+YNRNfnuPCR+PcDxIZV7ATIxzDvVYU8TeM4VZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113815; c=relaxed/simple;
	bh=Y/JxhU9HB4BOgiuHWRt1ucIdJ1J8tpV3oyqljLT3whA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRorNWhOFsNcPFEpcZrY7Lgo5X8Y/sgUrXl30Q7ReLHTYkaPCyy+ip2Ihufix6oPS9+QUxAvsnFtPLSGR2b3/wXRlZ0yWMaklFLtoq7G/+5metG9Tbc7LJSAMExMWW4pYrNXP2A0SVwhOTK2yt0LvOZyI8YERSs4TuiGNZN0TZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LK2l6nQj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LK2l6nQj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=tXL7aPo/yAWhlGILCeEnNw76Lh3seTcvuCYSfmK7zhI=; b=LK2l6nQjgd7DLaXcp7LIMUlNxA
	epcMuonePcQII23FEgetXgqFD+AaZXALFS9ajZIDA0hOhsfpISgZHAO8WzmAlWco0rLd/8BVw/en/
	jU+YYEMLC4dz5fOSsczVKgQ5CxhKFAMTcfj/NRJEX6CND9xVsdtvLUQfOoACz0uz+cc3LS3pPW2In
	TTff6EzdA3x8+ljSoDSNP7+bzp9Xyl6SHQtIw/3pX7snHqV6H52FeGGVgfEkScDfUMCZeqkL+myG/
	88kadjllLlyrTpys0ZML5ORFoQ4EuiwHCVQpvfEWOALEIblsTSGQ1eFvv0cZpOrGRfIFSE/87cT82
	lURSRZaA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKY-000000059O0-1xLJ;
	Fri, 03 Jul 2026 21:22:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001ROY-1YDI;
	Fri, 03 Jul 2026 22:21:48 +0100
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
Subject: [PATCH v6 12/36] KVM: x86: Restructure get_kvmclock()
Date: Fri,  3 Jul 2026 22:17:51 +0100
Message-ID: <20260703212145.343527-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
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

Simplify the use_master_clock condition: the open-coded CONSTANT_TSC ||
cpu_tsc_khz check is unnecessary since use_master_clock can only be true
when the host clocksource is TSC based, which in turn requires a stable,
constant and synchronised TSC across all CPUs.

Given that, the get_cpu()/put_cpu() pinning is not needed either: both
the TSC read and get_cpu_tsc_khz() are CPU-independent when the master
clock is in use, so drop them.

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
 arch/x86/kvm/x86.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50f088570dab..37b1f8192842 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3203,40 +3203,38 @@ static unsigned long get_cpu_tsc_khz(void)
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
-	struct pvclock_vcpu_time_info hv_clock;
 	unsigned int seq;
 
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 
-		/* both __this_cpu_read() and rdtsc() should be on the same cpu */
-		get_cpu();
-
 		data->flags = 0;
-		if (ka->use_master_clock &&
-		    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
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
-		}
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
 
-		put_cpu();
+			/*
+			 * Clock read failed (e.g. clocksource is transitioning
+			 * away from TSC). Fall back to the non-master-clock path
+			 * rather than spinning.
+			 */
+		}
+#endif
+		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.54.0

