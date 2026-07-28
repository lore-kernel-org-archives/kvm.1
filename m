Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C33A3815;
	Tue, 28 Jul 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250213; cv=none; b=r5gkBaDP3muadiWjahO+C2sIgxjTBu/4N7RXgw+nbEGhkz5vbSD/plwUYOr832kukWgnmXXBpMQpzbdrHpLgjgNnTV4lEJpJHBO4PpGzY54D1lx8kv1HHxlOsYH7jyirpQA3QwSaZwddF1J/5JJhFkM9EI4swnz3w/grRX5Q3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250213; c=relaxed/simple;
	bh=M4TOCKhItKiPhvGtG8nU1CV/FiP4J14drfVe0VrW2Yk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHsxOdbQY5LJJLij7C5XayBnb31aNewXgLV3hiYxAxlmuW62uuJ4mF6jHgpwH//5HaCzvSd4f5x9B2YLvxmsrcLWBkLOREqhPNGbHwX3Xl3wXZTL4YXZ67by4My7Tc4WOfZCIfww4g/GeG5gBZDp6s15g5Pt/jkMDfxIUXCMcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XtKNCikn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtKNCikn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=+I3dInpptLqTW26MdB6BEu7uqX7SVYa01mQD7irMSeI=; b=XtKNCiknoJw9CdufrCRb6Qkxg3
	5JVjfUAy3Qvd53x8eFTkkhBvRaaX+/ve6hijfLYVVWfnXLXAsQcgZUKS9kPtBB4ZZ1HPC+DScHJBd
	JoNaHYZC0GhqXTHr/dwb3HaGAkCUD0CZb4I/sQN1hWpTYpk7e+KcuhK3PSxZklOg2kbk1FZNyhu9t
	fVtCKZQC94T7q/P7m4MdZXyVODtVPrBXB3VxmDGS+CBDjcVfRJWF3ykUFtNIe7dVFEdBTjDuB7UgA
	ArT0WakOTueOrz2XPs0FPni6KS+nptBZrwAlwanzw0p6jCF7IFSeBrjZ08H1s4LXwoy/MCcxBIQ4t
	Y1CvLU7g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOk-0PS1;
	Tue, 28 Jul 2026 14:49:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYG-1d7k;
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
Subject: [PATCH v7 09/36] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
Date: Tue, 28 Jul 2026 15:39:49 +0100
Message-ID: <20260728144954.355376-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that get_kvmclock() correctly handles TSC scaling and captures both
wallclock and kvmclock from the same TSC reading,
kvm_get_wall_clock_epoch() can simply call it instead of duplicating
the pvclock computation.

This eliminates the last instance of the "definition C" kvmclock
calculation — as described in commit 710b3a30f407 ("KVM: x86/xen: Do
not corrupt KVM clock in kvm_xen_shared_info_init()") — which computed
nanoseconds directly from the host TSC without accounting for guest
TSC scaling.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 59 +++++++---------------------------------------
 1 file changed, 9 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c00b1e19c3af..f7a9fb69e69d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1930,63 +1930,22 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
  * wallclock and kvmclock times, and subtracting one from the other.
  *
  * Fall back to using their values at slightly different moments by
- * calling ktime_get_real_ns() and get_kvmclock_ns() separately.
+ * calling ktime_get_real_ns() and get_kvmclock() separately.
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
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
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
2.55.0

