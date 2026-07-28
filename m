Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED4459AD9;
	Tue, 28 Jul 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250216; cv=none; b=dvpxCNDj7Mgd5769tIVOxRSh8cgx4DJCACVixBeg2VxxObD560tgH1vB+wxC+fqOHRUk2Gb6Gl1ZuqARhNeMZwQr+vcSjtDeQHbU1Kt7SAD8IXO/MhOycFRC3+8eD6ziPBsRu4/V6j0vJAuslDxw1u1PYAjuwf4dDyMqXZhujTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250216; c=relaxed/simple;
	bh=0IHrcAutJwNDMgQjUZVNe1jrjOe7DdUspNMraQR85UI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJdAg3k7eVY0j1CIT+fhQQPWlr2a1DVhyNyWMgonvbrcwQ90Dm+IrpXb+RIP443wUDPZNwCM9B63Y3jsOe5mUZP/YEVOAx1T4g1ZAR+YzoLbWvPMi9dkLULsH+JZ59v94hpaX8lWnurKlrWbDWqVif5n9Of3dF81EzfJQczrm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QoMc0Gt0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QoMc0Gt0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=603BM0sHdBDUTRG410VdsA2pe0InVJPOHZpXThbNCgI=; b=QoMc0Gt0rApdlTLKtIKDAX7CYK
	t7AZFn0Y8sQj6UPd2NDXtpvtQn0aCCVdnDkrXHVIGeIVmuzy/0TppYiJ+7bWpKQwfyV/CEc9aS+H3
	vlOPf3OyM4Sj4bS5qpWV8Y2g1i4lJp6Kr7INoozvdsEuDNwq4N7tgzziMqOEmxr8kXkOEpicrzcoN
	7jDqtR+na2Ysuou4or91lMBWFjdjcB5iUXr5w9ATZZJp5qu7EHLJVAh3Yfw+hPuNXoz+nASxRoo21
	EtupXKlluiXEaWIc0nOFLMHYLYNUGy86CgSjOj0pRS+yG8zS5c714AJOQi5ICK+AGaeo+adkhdHBh
	PjTV6E7Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOh-0Qfn;
	Tue, 28 Jul 2026 14:49:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYD-1T7S;
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
Subject: [PATCH v7 08/36] KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
Date: Tue, 28 Jul 2026 15:39:48 +0100
Message-ID: <20260728144954.355376-9-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When in master clock mode, the KVM clock is defined in terms of the
guest TSC. But get_kvmclock() was computing it from the host TSC
without applying TSC scaling, leading to a systemic drift from the
values the guest computes from its own TSC.

Store the VM's TSC scaling ratio in kvm_arch and precompute the
guest-TSC-based mul/shift in pvclock_update_vm_gtod_copy(). Use these
in get_kvmclock() to scale the host TSC delta to guest TSC before
converting to nanoseconds.

This avoids "definition C" of the KVM clock described in commit
710b3a30f407 ("KVM: x86/xen: Do not corrupt KVM clock in
kvm_xen_shared_info_init()").

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  4 +++
 arch/x86/kvm/x86.c              | 52 +++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bffce2167141..c3b97ca24a8c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1236,6 +1236,7 @@ struct kvm_arch {
 	u64 last_tsc_write;
 	u32 last_tsc_khz;
 	u64 last_tsc_offset;
+	u64 last_tsc_scaling_ratio;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
@@ -1251,6 +1252,9 @@ struct kvm_arch {
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 	struct ratelimit_state kvmclock_update_rs;
+	u64 master_tsc_scaling_ratio;
+	s8  master_tsc_shift;
+	u32 master_tsc_mul;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51908d7093ba..c00b1e19c3af 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1247,6 +1247,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm->arch.last_tsc_write = tsc;
 	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.last_tsc_offset = offset;
+	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -1559,6 +1560,8 @@ static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
  *
  */
 
+static unsigned long get_cpu_tsc_khz(void);
+
 static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
@@ -1582,9 +1585,30 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
-	if (ka->use_master_clock)
+	if (ka->use_master_clock) {
+		u64 tsc_hz;
+
 		atomic_set(&kvm_guest_has_master_clock, 1);
 
+		/*
+		 * Copy the scaling ratio and precompute the mul/shift for
+		 * converting guest TSC to nanoseconds. These are used by
+		 * get_kvmclock() to compute kvmclock from the host TSC
+		 * without needing a vCPU reference.
+		 */
+		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
+		tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+		if (tsc_hz && kvm_caps.has_tsc_control)
+			tsc_hz = kvm_scale_tsc(tsc_hz,
+					       ka->master_tsc_scaling_ratio);
+		if (tsc_hz)
+			kvm_get_time_scale(NSEC_PER_SEC, tsc_hz,
+					   &ka->master_tsc_shift,
+					   &ka->master_tsc_mul);
+		else
+			ka->use_master_clock = false;
+	}
+
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
 					vcpus_matched);
@@ -1670,10 +1694,28 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 
 				hv_clock.tsc_timestamp = ka->master_cycle_now;
 				hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-				kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
-						   &hv_clock.tsc_shift,
-						   &hv_clock.tsc_to_system_mul);
-				data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+
+				/*
+				 * Use the precomputed guest-TSC-based mul/shift
+				 * so that the kvmclock value matches what the
+				 * guest computes from its own TSC.
+				 */
+				hv_clock.tsc_shift = ka->master_tsc_shift;
+				hv_clock.tsc_to_system_mul = ka->master_tsc_mul;
+
+				if (kvm_caps.has_tsc_control) {
+					u64 tsc_delta = data->host_tsc - ka->master_cycle_now;
+
+					tsc_delta = kvm_scale_tsc(tsc_delta,
+								  ka->master_tsc_scaling_ratio);
+					data->clock = hv_clock.system_time +
+						pvclock_scale_delta(tsc_delta,
+								    hv_clock.tsc_to_system_mul,
+								    hv_clock.tsc_shift);
+				} else {
+					data->clock = __pvclock_read_cycles(&hv_clock,
+									    data->host_tsc);
+				}
 				continue;
 			}
 
-- 
2.55.0

