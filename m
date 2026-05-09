Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF83D904B;
	Sat,  9 May 2026 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366933; cv=none; b=oTVtGvwlJWbsjbRfUKuDo8Q/aJYIcgJvYsIA9cSzwQMAkNHB5PcRvh+6Dveaw7vAIWRDv7deXSiChLyLyzeCz5fH1oxBP41y9AQXV9ZiGxzMibexIAToHhlG5rUsrBpc1FBRSzXbXJLL1Dg5vjIO/coQ6P8UttWQb3YJivfdrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366933; c=relaxed/simple;
	bh=cZZuVSKxzn+7IBpGESTsaH3NAOveOrZCIi+5LaHgVWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbgphx5RhKjK8fLXX5Uv6LtO/uGU1V28HHYTscD5L+BG8I+mozmfQBnQQWamR3+kjtlsvzNYOl8IibDBTGF6ZhUaP4eVrUoCYeRkXdQeiBFG/DQfLB50rXWbKOZABgm79+73S3EbNadNvqQIGMxFWYWVQcA/xu9VqG+sZCSxQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PKujpKHm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKujpKHm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=fg8C3e0zngZ/qjTwoH3UeG+KjIQgclDXz6pRh4tinms=; b=PKujpKHmlrgXqjPVL9jaYkGJO3
	T53JltigiUhtpHLz+35Soyi64kAnFI6avFDSQ7/IsNyZ28l+qFCRvclVStCfZHOZz828JXHb31UdJ
	N7lE9EYlEhuJZCzxJ4ROVt9rXq8DoQ6Kq4DUaUrRGuQx0dP4khkmjRDJ/M13crOzpM7oqACBUXIs3
	Q4nD8VTOzo/a5INBq2ieHxDAu27u1CaWybhnejK7d4D9LRkfa7L3FXKr81GvuOhbDZFGzyrQ8YMGi
	8v/2/UeGdEcEt4bq95OSqY24tuE+B53teUl+Vpo85e3cKBhcevIqPiHpEnEnceUh3LIMiGmLn2PyW
	NDQeV2eg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-000000060LJ-1pmT;
	Sat, 09 May 2026 22:48:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhIj-0Fe7;
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
Subject: [PATCH v4 23/30] KVM: x86: Factor out kvm_use_master_clock()
Date: Sat,  9 May 2026 23:46:49 +0100
Message-ID: <20260509224824.3264567-24-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
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

Both kvm_track_tsc_matching() and pvclock_update_vm_gtod_copy() make a
decision about whether the KVM clock should be in master clock mode.
They used *different* criteria for the decision though. This isn't
really a problem; it only has the potential to cause unnecessary
invocations of KVM_REQ_MASTERCLOCK_UPDATE if the masterclock was
disabled due to TSC going backwards, or the guest using the old MSR.
But it isn't pretty.

Factor the decision out to a single function. And document the
historical reason why it's disabled for guests that use the old
MSR_KVM_SYSTEM_TIME.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d36d03b8268e..0656d901fe79 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2640,6 +2640,27 @@ static inline bool gtod_is_based_on_tsc(int mode)
 }
 #endif
 
+static bool kvm_use_master_clock(struct kvm *kvm)
+{
+	struct kvm_arch *ka = &kvm->arch;
+
+	/*
+	 * The 'old kvmclock' check is a workaround (from 2015) for a
+	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
+	 * its kvmclock was too far behind the current time. So the
+	 * mode of just setting the reference point and allowing time
+	 * to proceed linearly from there makes it fail to boot.
+	 * Despite that being kind of the *point* of the way the clock
+	 * is exposed to the guest. By coincidence, the offending
+	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
+	 * only because it resided in the wrong number range. So the
+	 * workaround is activated for *all* guests using the old MSR.
+	 */
+	return ka->all_vcpus_matched_freq &&
+		!ka->backwards_tsc_observed &&
+		!ka->boot_vcpu_runs_old_kvmclock;
+}
+
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 {
 #ifdef CONFIG_X86_64
@@ -2662,7 +2683,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	 * are fine — each vCPU's pvclock has its own tsc_timestamp that
 	 * accounts for its offset.
 	 */
-	bool use_master_clock = ka->all_vcpus_matched_freq &&
+	bool use_master_clock = kvm_use_master_clock(vcpu->kvm) &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -3190,10 +3211,9 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	int vclock_mode;
-	bool host_tsc_clocksource, vcpus_matched;
+	bool host_tsc_clocksource;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -3203,9 +3223,8 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
-				&& !ka->backwards_tsc_observed
-				&& !ka->boot_vcpu_runs_old_kvmclock;
+	ka->use_master_clock = host_tsc_clocksource &&
+				kvm_use_master_clock(kvm);
 
 	if (ka->use_master_clock) {
 		u64 tsc_hz;
@@ -3231,7 +3250,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
+					ka->all_vcpus_matched_freq);
 #endif
 }
 
-- 
2.51.0

