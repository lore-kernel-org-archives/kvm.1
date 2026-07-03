Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B8321F5E;
	Fri,  3 Jul 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113728; cv=none; b=Ndf+w42KTVScrL+mhK1zkWPLFzvcqbfHYRgVjWfwa/wAzzOGIvrnorA3BgdaPoypDZpUsnOXP5YTNkYJ3CBkejngl0qXLs96mM2IHpwrkC5Alz8y15upPL1z09UupRuaUruLZ2Ilnz8IvsfmvR+QnxqNi1rCDRpZ8bGIF5tlnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113728; c=relaxed/simple;
	bh=GPQ4RVhn2z0gC5h+3i62w3f/Gxsc358KVYQk9miUThk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llsUl7SHjAIK6EHC92HgjtfyBIfnI3hkDjkCEeKpXgd8e6k8Tav+v4OBmLPkEWW4D3X1L3UjYSQD5cx/OmbDoVWUkpY8RWmUDhZQwp7MBECWGggkBIawi6eXsawO1op+qShrqn/pgOyVgwGbJORlfDj4YVlSlvnb4JeJbKPVH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RUX0gU2B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RUX0gU2B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=aJbyYvbMlra4ob/lrPKW+13k0D2GomXNtoUlefAARyI=; b=RUX0gU2BmZAS8Mc7MvtqcjpKaA
	4X2GDo7Scxh/FJ1zfZj/ZZUyMDJLZdQtdY/yzpdVZO3bM/BQQLjwYOuR7nQJiiOLfJN8o9bXd0KEm
	l746azezEjoQE2RTg+hpkWKNpt6Vb5ogWz+nAFg5mQQ0InOMCWqd7vLGDc76I66RSvfzFQY+yfOne
	tJbmYqYf4y8NcSnh+ymr0gQ0qUnSjLlbP7a9/JcR68N/4qX/IVF7uUKlxqNM4lp3vkFKExekknJt9
	4Ipax9FNfOZuryGMT0mvzgT9ncQ6Of+VmYZ1R2nRjr/PYhl4mTt99MskS2b0Erewa9tJ3yQ+Kw6dt
	ciUtLalA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflKW-0000000AsYA-412E;
	Fri, 03 Jul 2026 21:21:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001RP5-3Puq;
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
Subject: [PATCH v6 19/36] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Fri,  3 Jul 2026 22:17:58 +0100
Message-ID: <20260703212145.343527-20-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When synchronizing to an existing TSC (either by explicitly writing
zero, or the legacy hack where the TSC is written within one second's
worth of the previously written TSC), the last_tsc_write and
last_tsc_nsec values were being misrecorded by __kvm_synchronize_tsc().
The *unsynchronized* value of the TSC (perhaps even zero) was being
recorded, along with the current time at which kvm_synchronize_tsc()
was called. This could cause *subsequent* writes to fail to synchronize
correctly.

Fix that by resetting {data, ns} to the previous values before passing
them to __kvm_synchronize_tsc() when synchronization is detected.
Except in the case where the TSC is unstable and *has* to be synthesised
from the host clock, in which case attempt to create a nsec/tsc pair
which is on the correct line.

Furthermore, there were *three* different TSC reads used for calculating
the "current" time, all slightly different from each other. Fix that by
using kvm_get_time_and_clockread() where possible and using the same
host_tsc value in all cases.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0fa2050f4bd4..ffe5f98a5688 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -203,6 +203,9 @@ module_param(mitigate_smt_rsb, bool, 0444);
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
  * returns to userspace, i.e. the kernel can run with the guest's value.
  */
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
 #define KVM_MAX_NR_USER_RETURN_MSRS 16
 
 struct kvm_user_return_msrs {
@@ -2854,14 +2857,23 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
+	u64 offset, host_tsc, elapsed;
+	s64 ns;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-	ns = get_kvmclock_base_ns();
+
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+	}
+
+	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2904,13 +2916,18 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!kvm_check_tsc_unstable()) {
+		/*
+		 * If synchronizing, advance the reference point to "now"
+		 * so the matching window slides forward with each vCPU.
+		 */
+		u64 delta = nsec_to_cycles(vcpu, elapsed);
+
+		data = kvm->arch.cur_tsc_write + delta;
+
+		if (!kvm_check_tsc_unstable())
 			offset = kvm->arch.cur_tsc_offset;
-		} else {
-			u64 delta = nsec_to_cycles(vcpu, elapsed);
-			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-		}
+		else
+			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 		matched = true;
 	}
 
-- 
2.54.0

