Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C536E460;
	Sat,  9 May 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366931; cv=none; b=JQdgy7x1fPtCJE+5U6+2IYkoapMJ5yQOnctxY6YrrxmJA+c6lM641vZ3+fF79zfmSRN/8EMFeDiTUWxTkaS5JkCRTBG8l9CjDnQ6N1L0G/tdWTiQkXAnApZ2tXKr87ESWBF94iVCL+6czGh+2xxae6wXNMqF1r6X8nVTPwc+u80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366931; c=relaxed/simple;
	bh=b9k9Uie0qnjI5OX6l4VIpFlS3HfJkPehfFu7gJXA8Kk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5cQ4wD2LXVMLHibPiOxdY1TAkZ5Loh8V+nEDpOCkS/1IXEncqW38b1XFTrJP7GYqzPd6qSopeh/B3ZOnfQcPIC9aa9XoF2/Uvkf1+I3KAm7L0etIwCBCdThFnHIlYZSSM0rlLEiv+JHtU8OtmJwexF6F52OlruCooBW1X5tvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TIN9a1E8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TIN9a1E8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=1qL8Ver0eVRy2vup5TVneuXo0fgeLVr0y5FVTqd09W0=; b=TIN9a1E8sNcAlsWC1Aa8d+j4n2
	ykdU+MKOO6mMS//0nZ9gk/6GtNeig/iy0ktOWfZxfE3Y9oC+BDjozpK+YTRlioH1mCNDrnrIIELfn
	Dk90c8X8czam38NJuoQCGkKSyonAfsIF0B4Gxy6aAg4JXguhERu1nsTDdjXKIBO+eLUfCrpEUY/KI
	TvcJr5SlC/FZt8Ny/XRCRRj8ai9g6+Wohw9ZHE3J4GVELHu0tc8Vjezkb9vglY98NiUkuDsAWG3W4
	8Keg1ENmXJQKCp20kaYBBMtgVeR3RnqtpIwL3rLtS4PlhMLY7MseveZJDp6XxLDLJem5Fzuh0or1E
	O8puK54w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzG-0XFY;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhI9-2vDj;
	Sat, 09 May 2026 23:48:26 +0100
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
Subject: [PATCH v4 14/30] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
Date: Sat,  9 May 2026 23:46:40 +0100
Message-ID: <20260509224824.3264567-15-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that get_kvmclock() correctly handles TSC scaling and captures both
wallclock and kvmclock from the same TSC reading,
kvm_get_wall_clock_epoch()
can simply call it instead of duplicating the pvclock computation.

This eliminates the last instance of the "definition C" kvmclock
calculation that computed nanoseconds directly from the host TSC
without accounting for guest TSC scaling.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 58 +++++++---------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09b00906b1de..2bbc2c7ac449 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3491,60 +3491,18 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
  */
 uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 {
-#ifdef CONFIG_X86_64
-	struct pvclock_vcpu_time_info hv_clock;
-	struct kvm_arch *ka = &kvm->arch;
-	unsigned long seq, local_tsc_khz;
-	struct timespec64 ts;
-	uint64_t host_tsc;
-
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-
-		local_tsc_khz = 0;
-		if (!ka->use_master_clock)
-			break;
-
-		/*
-		 * The TSC read and the call to get_cpu_tsc_khz() must happen
-		 * on the same CPU.
-		 */
-		get_cpu();
-
-		local_tsc_khz = get_cpu_tsc_khz();
-
-		if (local_tsc_khz &&
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc) &&
-		    WARN_ON_ONCE(!read_seqcount_retry(&ka->pvclock_sc, seq)))
-			local_tsc_khz = 0; /* Fall back to old method */
-
-		put_cpu();
-
-		/*
-		 * These values must be snapshotted within the seqcount loop.
-		 * After that, it's just mathematics which can happen on any
-		 * CPU at any time.
-		 */
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+	struct kvm_clock_data data;
 
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+	get_kvmclock(kvm, &data);
 
 	/*
-	 * If the conditions were right, and obtaining the wallclock+TSC was
-	 * successful, calculate the KVM clock at the corresponding time and
-	 * subtract one from the other to get the guest's epoch in nanoseconds
-	 * since 1970-01-01.
+	 * If get_kvmclock() captured both wallclock and kvmclock from the
+	 * same TSC reading, use them for a precise epoch calculation.
 	 */
-	if (local_tsc_khz) {
-		kvm_get_time_scale(NSEC_PER_SEC, local_tsc_khz * NSEC_PER_USEC,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		return ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec -
-			__pvclock_read_cycles(&hv_clock, host_tsc);
-	}
-#endif
-	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
+	if (data.flags & KVM_CLOCK_REALTIME)
+		return data.realtime - data.clock;
+
+	return ktime_get_real_ns() - data.clock;
 }
 
 /*
-- 
2.51.0

