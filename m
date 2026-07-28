Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E49471267;
	Tue, 28 Jul 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250228; cv=none; b=mnItsVHZHd98libBK6OIgtHwXhkS9untOVTkc5vaO2eoNmi8OleMBWVv8yBEFwKpvZEY0LkEazxZxJPIj431dEYkL3g5IaItmTIc4KQP+g9Yswmp/HX+4rKmmq3tZLmI/RFWrVvAIgSs1cNbe6o3rG1pajYeaZcuZs0dAKnEft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250228; c=relaxed/simple;
	bh=PKyP4m6FTHAhwv8BGqJtw5QtrCj7mUA5QC2N+xbsapU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcaxSy5htLlBUJKJVwJZlEnPSHLyt4Unltxld+/gWFPDQqsbaCquuMApFpV1JOxSzANX/1mrHc+rkbBbdlIhzXCVd7b/AMUtcnt0gVQM8kW2/Fisc6eXStsIJYgqnrvbk9o4TTQCkl1qNOZntyctmJfvWivb2fDxWrXnS5hvku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f6dhSniq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f6dhSniq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=ZtZ9YnYy5dF7af/68gtvS2260R2QcKEKM/9qQa0E+f8=; b=f6dhSniq9iMaTSYwcnoi/N8aIY
	TF1KArsadCgFH4mrrosXc6xm5v/Vv5C7SHH4C5qzhpBTonCLWovpotK+RfSQt6bnTEvJTX1CQ08MC
	RVol+IkLryE4lN8xJG7J2qVj805qXOyEkuSpGf7iWJFa1x7ay2QjL/1uXk5IPqgMuu+O8c/s1re7f
	HQXnA1sr4EQzfKO+wcHuchiFuyJ3N9lP9xgLqiyX2qNlrIqkTSC4rjdgrZNrOQmfAbJMPSGr+5PD4
	nYCHx/dSLvBGMlmRRKk9PfJ2CXRcOFyrJO/JGMPmCC2p2kdj98sgZa3Cc2Fm9r5ajGee06BeO+eNg
	L1T0q7Zg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052VX-34lM;
	Tue, 28 Jul 2026 14:50:10 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UY4-0yXn;
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
Subject: [PATCH v7 05/36] KVM: x86: Fold __get_kvmclock() into get_kvmclock()
Date: Tue, 28 Jul 2026 15:39:45 +0100
Message-ID: <20260728144954.355376-6-dwmw2@infradead.org>
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

There is no need for the separate __get_kvmclock() helper; just inline
its body into get_kvmclock() within the seqcount retry loop.

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 63 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71e0653aa447..1a598e99852c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1650,50 +1650,43 @@ static unsigned long get_cpu_tsc_khz(void)
 		return __this_cpu_read(cpu_tsc_khz);
 }
 
-/* Called within read_seqcount_begin/retry for kvm->pvclock_sc.  */
-static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
+static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	unsigned int seq;
 
-	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
-	get_cpu();
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
 
-	data->flags = 0;
-	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+		/* both __this_cpu_read() and rdtsc() should be on the same cpu */
+		get_cpu();
+
+		data->flags = 0;
+		if (ka->use_master_clock &&
+		    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
 #ifdef CONFIG_X86_64
-		struct timespec64 ts;
+			struct timespec64 ts;
 
-		if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-			data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-			data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-		} else
+			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
+				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
+			} else
 #endif
-		data->host_tsc = rdtsc();
-
-		data->flags |= KVM_CLOCK_TSC_STABLE;
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-	} else {
-		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
-	}
-
-	put_cpu();
-}
-
-static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-{
-	struct kvm_arch *ka = &kvm->arch;
-	unsigned seq;
+			data->host_tsc = rdtsc();
+
+			data->flags |= KVM_CLOCK_TSC_STABLE;
+			hv_clock.tsc_timestamp = ka->master_cycle_now;
+			hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+			kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+					   &hv_clock.tsc_shift,
+					   &hv_clock.tsc_to_system_mul);
+			data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+		} else {
+			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
+		}
 
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-		__get_kvmclock(kvm, data);
+		put_cpu();
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.55.0

