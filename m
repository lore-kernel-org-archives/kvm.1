Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420571;
	b=ee551EEHp1A1m5VyH4Y3zEwipy4wJLspns5/ctkmz4guO1WMGlrCFllprbJ0mfx8puV3
	 QwiXW5IQPhwZoDNIo5q4jp4RjfnFKNGIHh5DIJh/iq+afRtHo5WfHYEWQq47NLIStu5UP
	 E8XxkqBk/hKQwNRb0tN9NCcBrY92qFArxDFCofP40eAFVzgXBjLqfE4VeyBQVJtL8HE9P
	 qg18NoVi62x8MLFq4kMN0UMEU3jKVjDj4a3iomBhqq8fSFSrDYsL3DsZDwBVUlXN38h+7
	 zADBrrrysKbAgxGARzCEeBBGtF7lfcPzb4+aX7Jo0EuGADaJAjNKCTGNQiqaGskWX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=RWJYzPBfROH0RDNcb8a2gkFZRf2P6KvtNVjLim21s78=;
	b=QMJGYnGLyhmc1d46ILGEPYdi5NLIC417zSz3TLGn6EJyF2oeX8hs8eDaYkng/KRLGT5t
	 M/q8PjykJGBtSdD/COxmA9Yt6zEZpRtN+VBCzSip3GieKJJr6W2JNPv3yuCE7DeX1Fewk
	 fSjZtifxSJeArZJ/gWatodRrVx5UXEkTgrSCRg1NZTK/yQCITSMVft2TKyvr/qi5UZ+DX
	 H0F53nyy4o4oyX8/q65ahJayO34ogtIlFeCgpm5en23zUIXAd9HnMvM0TgP9U2dUzl6dO
	 OzHW9aZS9B1NJaNPj56gGJrR6Le2SaTI0eST3+E378m8YeFlHn2LFCQOewhCm3zQCfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KPI+rh0q;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563C60A2604;
	Wed, 11 Nov 2026 18:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C563C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KPI+rh0q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=RWJYzPBfROH0RDNcb8a2gkFZRf2P6KvtNVjLim21s78=; b=KPI+rh0q9L5E0n3PtrKdGzqxmC
	u6ZqUrVz47cB90lrmnZyoDvUftETMhbwMtlWKnleSuFFI4TiaV6t4SXkd8qxz6PWW3oqg9YLVYuEC
	wzjlnYagA/T4nyMTbJS595bEm35vpz2RXbk1L8BXZpbpTz7C2CRBskFo74yShLtJuhNm8Vwl5SwdF
	xngOACk6Td8Z51U8fiO8a7KVDwEYru3NUcMgvtocCl5bM1fTBK/Db6fkqwLTjEar8mljiHnTDY9Ce
	adxalyGh6pqDgAtvNfJkV4fL+gOzZa6SyomDyG5Gtlh4BmaBqbtho21ORBMrQ+xHF8MoVLcp9c9P/
	JqRPDpcA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClA-0000000CKxJ-0WPu;
	Wed, 11 Nov 2026 18:09:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWto-3rsi;
	Wed, 11 Nov 2026 18:09:23 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v13 26/26] KVM: x86: Keep master clock for guests using legacy MSR_KVM_SYSTEM_TIME
Date: Wed, 11 Nov 2026 10:09:22 -0800
Message-ID: <20261111180922.4177927-27-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 54750f2cf042 ("KVM: x86: workaround SuSE's 2.6.16 pvclock vs
masterclock issue") disables the master clock entirely for any guest
whose boot vCPU uses the legacy MSR. SUSE's 2.6.16 kernel treats a
pvclock tsc_timestamp more than 1/5 jiffie behind the TSC as suspect
and re-requests the time by rewriting the MSR; against the master
clock's long-lived reference point the delta never shrinks, so it
re-requests in a loop and fails to boot.

Satisfy the guest's freshness heuristic instead of capitulating to it:
a guest write to the legacy MSR now requests a masterclock update,
sliding the reference point forward before the pvclock is written (the
masterclock request is serviced before KVM_REQ_CLOCK_UPDATE on the
same guest entry). The re-requested pvclock then carries a recent
tsc_timestamp and the heuristic is content. Each re-anchor steps the
pvclock function by the sub-nanosecond (possibly backwards)
mult-rounding divergence accumulated since the previous anchor — the
same step every pre-existing masterclock update already takes — and
legacy-MSR guests now see PVCLOCK_TSC_STABLE_BIT like anyone else.

A guest hammering the legacy MSR forces repeated VM-wide masterclock
updates, but only its own VM's: a guest has always been able to burn
its own cycles. Re-anchoring just the writing vCPU's pvclock along the
masterclock line would avoid even that, but isn't worth the extra
plumbing for a 2006 guest kernel.

This removes the last way a guest could force the master clock off;
the remaining disable, backwards_tsc_observed, is the host's own
doing. The pvclock_test selftest grows a legacy-MSR case proving the
master clock survives and the rewritten pvclock is fresh.

Not tested against a real SLES10 image; the behaviour it demands is
reconstructed from the guest comment quoted in 54750f2cf042. The
freshness that guest observes can be no worse than before: with the
master clock disabled it saw a tsc_timestamp one exit-to-read latency
old, exactly what the rewrite now produces, and the update's own cost
does not age the timestamp, which is written only after the update
completes. A host loaded enough to defeat that would have livelocked
the old scheme equally. Should a real SLES10 guest prove otherwise,
the revert path is to restore the boot_vcpu_runs_old_kvmclock gate in
kvm_use_master_clock().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h               |  1 -
 arch/x86/kvm/msrs.c                           | 26 ++++----
 arch/x86/kvm/x86.c                            | 15 +----
 .../testing/selftests/kvm/x86/pvclock_test.c  | 63 +++++++++++++++++++
 4 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 773df58898ea..0db8169612a4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1275,7 +1275,6 @@ struct kvm_arch {
 #endif
 
 	bool backwards_tsc_observed;
-	bool boot_vcpu_runs_old_kvmclock;
 	u32 bsp_vcpu_id;
 
 	u64 disabled_quirks;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index d07831b5dfb8..94cd4d73689a 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1275,19 +1275,19 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_o
 static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 				  bool old_msr, bool host_initiated)
 {
-	struct kvm_arch *ka = &vcpu->kvm->arch;
-
-	if (vcpu->vcpu_id == 0 && !host_initiated) {
-		/*
-		 * Store the flag before requesting the masterclock update:
-		 * the update may now be performed by another vCPU (which
-		 * consumes this request), and it must observe the new value.
-		 */
-		if (ka->boot_vcpu_runs_old_kvmclock != old_msr) {
-			ka->boot_vcpu_runs_old_kvmclock = old_msr;
-			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
-		}
-	}
+	/*
+	 * Slide the master clock reference point forward, so that the
+	 * pvclock written below carries a recent tsc_timestamp. SUSE's
+	 * 2.6.16 kernel (the only known user of the legacy MSR with a
+	 * reason to care) re-requests the time by rewriting this MSR
+	 * whenever tsc_timestamp falls more than 1/5 jiffie behind the
+	 * TSC, and would livelock against a fixed reference point; each
+	 * rewrite now genuinely freshens it. A write with the enable
+	 * bit clear deactivates the pvclock; there is nothing to
+	 * freshen.
+	 */
+	if (old_msr && !host_initiated && (system_time & 1))
+		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 
 	vcpu->arch.time = system_time;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 921d834b9682..191f811a0cdd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1181,21 +1181,8 @@ static bool kvm_use_master_clock(struct kvm *kvm)
 {
 	struct kvm_arch *ka = &kvm->arch;
 
-	/*
-	 * The 'old kvmclock' check is a workaround (from 2015) for a
-	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
-	 * its kvmclock was too far behind the current time. So the
-	 * mode of just setting the reference point and allowing time
-	 * to proceed linearly from there makes it fail to boot.
-	 * Despite that being kind of the *point* of the way the clock
-	 * is exposed to the guest. By coincidence, the offending
-	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
-	 * only because it resided in the wrong number range. So the
-	 * workaround is activated for *all* guests using the old MSR.
-	 */
 	return ka->all_vcpus_matched_freq &&
-		!ka->backwards_tsc_observed &&
-		!ka->boot_vcpu_runs_old_kvmclock;
+		!ka->backwards_tsc_observed;
 }
 
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
diff --git a/tools/testing/selftests/kvm/x86/pvclock_test.c b/tools/testing/selftests/kvm/x86/pvclock_test.c
index cb57f5e2bf1e..f3c8d9d8303a 100644
--- a/tools/testing/selftests/kvm/x86/pvclock_test.c
+++ b/tools/testing/selftests/kvm/x86/pvclock_test.c
@@ -189,6 +189,8 @@ static void run_at_frequency(u64 tsc_khz, unsigned int sleep_sec)
 
 static void test_tsc_stable_bit(void);
 static void test_clock_guest_with_offsets(void);
+static void test_legacy_msr(void);
+static void run_vcpu_once(struct kvm_vcpu *vcpu);
 
 static void usage(const char *name)
 {
@@ -251,10 +253,71 @@ int main(int argc, char *argv[])
 
 	test_tsc_stable_bit();
 	test_clock_guest_with_offsets();
+	test_legacy_msr();
 
 	return 0;
 }
 
+static void guest_code_legacy_msr(void)
+{
+	wrmsr(MSR_KVM_SYSTEM_TIME, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	GUEST_SYNC(0);
+	/* Re-request the time, as SUSE's 2.6.16 kernel would. */
+	wrmsr(MSR_KVM_SYSTEM_TIME, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	GUEST_SYNC(1);
+}
+
+/*
+ * A guest using the legacy MSR_KVM_SYSTEM_TIME must no longer lose the
+ * master clock, and rewriting the MSR must slide the reference point
+ * forward so the pvclock's tsc_timestamp is recent — that freshness is
+ * what SUSE's 2.6.16 kernel demands instead of tolerating a fixed
+ * reference point.
+ */
+static void test_legacy_msr(void)
+{
+	struct pvclock_vcpu_time_info *pvti;
+	struct kvm_clock_data clock;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 tsc_now, age_limit;
+
+	pr_info("Testing the legacy MSR_KVM_SYSTEM_TIME\n");
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_legacy_msr);
+	configure_pvclock(vm);
+
+	run_vcpu_once(vcpu);
+	vm_ioctl(vm, KVM_GET_CLOCK, &clock);
+	TEST_ASSERT(clock.flags & KVM_CLOCK_TSC_STABLE,
+		    "Legacy MSR_KVM_SYSTEM_TIME should not disable the master clock");
+
+	/* Age the master clock reference point, then re-request. */
+	usleep(300 * 1000);
+	run_vcpu_once(vcpu);
+
+	pvti = addr_gpa2hva(vm, KVMCLOCK_GPA);
+	tsc_now = vcpu_get_msr(vcpu, MSR_IA32_TSC);
+
+	/*
+	 * The rewrite slid the reference point, so the pvclock must be
+	 * anchored after the 300ms sleep: allow 250ms of slack for the
+	 * ioctls around it. SUSE's real threshold was 1/5 jiffie, but
+	 * asserting that tightly would flake on a loaded host.
+	 */
+	age_limit = (u64)__vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL) * 250;
+	TEST_ASSERT(tsc_now - pvti->tsc_timestamp < age_limit,
+		    "pvclock tsc_timestamp should be fresh after legacy MSR rewrite (age %llu cycles, limit %llu)",
+		    (unsigned long long)(tsc_now - pvti->tsc_timestamp),
+		    (unsigned long long)age_limit);
+
+	vm_ioctl(vm, KVM_GET_CLOCK, &clock);
+	TEST_ASSERT(clock.flags & KVM_CLOCK_TSC_STABLE,
+		    "Master clock should survive a legacy MSR rewrite");
+
+	kvm_vm_free(vm);
+}
+
 static volatile u32 vcpu_counter;
 static void guest_code_stable_bit(void)
 {
-- 
2.43.0

