Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFB43E9D2;
	Mon,  8 Jun 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930540; cv=none; b=NLgYieoNNHXy2EErJiA43vsWti6vBOf1LQHZJ8mg8xkp0B9/ISgK38sxBUUG6sfHs/yZJBr+H/Lzx4VVT9Zlhpk+m9LHdBdVA9FMBP+x1kuYn7gAkZoI1p2siGtHbgWlBK6igAlhVAUnASKHRUhQr9w3YGEpQ/JuLXG3r6aIT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930540; c=relaxed/simple;
	bh=W0liJgLUP+4F6PDsC7cXp3OtJreSUh0fBECzJHMveas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8RdlKCUS+4kLgT+N4WW5D5PCAyfCTwc4CoC25k8dZ29yB8+JdqaUzB6fHB0Z0KnmxqP+mfdxMKNwUyOXfSXuoqaZ4BnQPNzAv8z/L7Of20YerkMzcqvWT2oO7+W4JA6iFTUHcrIh4s5RckEJkLpTUvsmLQzWvqA8OZYFp2DN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=szg0DuJa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="szg0DuJa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=mK9MivH4Sa09pKns/iaOBplM1ylYPC1nLBsprSjeCoQ=; b=szg0DuJaBDaAO6gJ+6si2oIAis
	T91YLENzCyD9xsWd+xbTgQw7GqijATO+tnbaTBL01eGHLbKCN5Cc3aCoQxj6HIAMG90eZjZs0Ydug
	jPIbOu8aN+jme6AwIGKke4AjYZcyV9ipCdmVuwkICFvP8Ht0pf7uBv0dj7EY00YzdrWDTlNiKh6N7
	pTg/dfcczCehCy18HLpKxo3Dhch1c3qYACouIglNEkfV4ijxAmKYsV6yx/YJ8ZfFPAQYuCyDeRHVv
	gqbeTfHqe9xZAshQmAkH2NTO9GqdT8NLIKMzSAguCJgjcAqyyI+RQVUTleE5TBh2TgG8xYP3fhq19
	TmvcWxLA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNR-0000000DtxA-32IJ;
	Mon, 08 Jun 2026 14:54:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNR-00000000NEz-3a70;
	Mon, 08 Jun 2026 15:54:57 +0100
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
Subject: [PATCH v5 10/34] KVM: x86: Fold __get_kvmclock() into get_kvmclock()
Date: Mon,  8 Jun 2026 15:47:51 +0100
Message-ID: <20260608145455.89187-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
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

There is no need for the separate __get_kvmclock() helper; just inline
its body into get_kvmclock() within the seqcount retry loop.

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 63 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50bd2871b051..fce898811fe7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3200,50 +3200,43 @@ static unsigned long get_cpu_tsc_khz(void)
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
2.54.0

