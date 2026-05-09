Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01573FE372;
	Sat,  9 May 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366943; cv=none; b=LX1vsNQEstuDQM4dUjN+dKi4Lt7MS2trGO8/la/sIBgI4BrcXmWUIhkHWQd6sggJiIH0xdVX+llUYdzvFHFmrfEk8ndD+subRSsRZPbtQ6gilhidSMONxwy8dm6CGHcK/dBVw0GjBS1BaEEocR+f2/z58dqhsEGuuRO6Xymjsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366943; c=relaxed/simple;
	bh=+SLOJJIYgG5DVLATMx+mYw3JbuuiPCDvqRdclohpPOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWjUPpaT6VxYqoHb5VdkLvfwSSefL/FWomRfB4dNJrlLNvmpLhUOJgS9DiH8d4BLJgCrDRBNNj6WJ34oYEaqfBqAdHkSPjcpCp+AQJPKhTGH3JFvd7499NIqP8ChwahbsCbgllNeg2xrgL6lEQ0jNNzUbqDhGeIVS1v0WpjV4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HmsoA/x3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmsoA/x3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=r8GUuEfSqVDY4ObHqgt5fkCwzZUXPNLZaFFwnl8uecE=; b=HmsoA/x37thVn7QmEUqzXzZ9dp
	ISe/5Rd32SNWt4q/Hbqvi9qSeQ3m/RtXJVGMmKWoN+OBAG8rHeLvJxRArpgwhp/bdKz6lzirvf8+j
	lU6es406aj7gY7eg4CaYfnmcL3Ekw6pKnOBZbpEf5Yi7Ujp3B0CbSJpFSogmG934w7gSa13zWF15F
	8WY2cypbbhm5GfQeDwrC57KIozrcjnTuGUB//phuSrDxdxKUBVfD8R4QRbDbZwVGHlu49uXm1L5jK
	p7AtGqj6hNRZwETSVvraP00ZpIIBVXPuj3ThBQtbUkwVhFMHy4lwLeaSA6Rd3M8bbeKoJBkhcuJxJ
	rYlaHovQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzD-0P9r;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhHx-2Z87;
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
Subject: [PATCH v4 11/30] KVM: x86: Add WARN and restructure get_kvmclock()
Date: Sat,  9 May 2026 23:46:37 +0100
Message-ID: <20260509224824.3264567-12-dwmw2@infradead.org>
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

Add the same WARN_ON_ONCE for unexpected kvm_get_walltime_and_clockread()
failure as in kvm_get_wall_clock_epoch().

Move get/put_cpu inside the use_master_clock branch since they are only
needed there (for RDTSC and get_cpu_tsc_khz() to be on the same CPU).

Also simplify the use_master_clock condition: the open-coded
CONSTANT_TSC || cpu_tsc_khz check is unnecessary since use_master_clock
can only be true when the TSC is usable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f660c3210ee..9b395c00ccf2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3209,21 +3209,27 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 
-		/* both __this_cpu_read() and rdtsc() should be on the same cpu */
-		get_cpu();
-
 		data->flags = 0;
-		if (ka->use_master_clock &&
-		    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+		if (ka->use_master_clock) {
 #ifdef CONFIG_X86_64
 			struct timespec64 ts;
+#endif
+			/*
+			 * The RDTSC and get_cpu_tsc_khz() must happen on
+			 * the same CPU.
+			 */
+			get_cpu();
 
+#ifdef CONFIG_X86_64
 			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
 				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
 				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-			} else
-#endif
+			} else if (WARN_ON_ONCE(!read_seqcount_retry(&ka->pvclock_sc, seq))) {
+				data->host_tsc = rdtsc();
+			}
+#else
 			data->host_tsc = rdtsc();
+#endif
 
 			data->flags |= KVM_CLOCK_TSC_STABLE;
 			hv_clock.tsc_timestamp = ka->master_cycle_now;
@@ -3232,11 +3238,11 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 					   &hv_clock.tsc_shift,
 					   &hv_clock.tsc_to_system_mul);
 			data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+
+			put_cpu();
 		} else {
 			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 		}
-
-		put_cpu();
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.51.0

