Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC52EEE85;
	Tue, 28 Jul 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250214; cv=none; b=uSgNlwfyA4Drxn/9OOAe4hNv7kHHzFXVehRU8dghufWf0CGmEqKqAmMxXMdHqcTLFUMCnUKUSWlKyxffU8vbwQIFlqtxfPUsO0TaS37kWaQmI3ZEMcpZeW0JZ73AAQqJi3OqX1QBDWTz7L47iX1QP55sfpkFL8yc1VNLNEVu+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250214; c=relaxed/simple;
	bh=XadhId8uVR+GaOi+biMxG9UE70XQRlCCYHQL2JNUDI8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UI1ET4KK9ufTk06VaLWPBu9CZof+NgSsgBqzo4C6vrDM5cUSztsVObTPWQ1zy7zhI6E/lNGTVrI5vWfNmIZx+Dh1Me2aU0EQMGaeFJaK1sV/pksm1z9JBbOcmjlACKaYfhzWe7jmv+XbA/rqQI1TfGURYwM4daUHcWsI4wB7edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VXbaCjsI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXbaCjsI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BrGFErkBIg68f71LqKvwO1FDGYKc02JGxomF5JLDYzU=; b=VXbaCjsIawB18OTg0d61vKLhQj
	xvN0gx/rLhETd4S4qz4cXmD00ftzJNP/EkfQlw4o779NWET0obf/BzHXTstvBIwcG/2dBTAqgSwfN
	zVpLBkFE10eZqhmOB4voQ1dfqDhZ0BBrSXwnX3/EYTWll2d7o9E9xw757XKf15yrOvDzU6xIrPbt9
	1/VE8Uz36y3XCk6z69eTCQiCfuC5+lXTCGMtmCc+/ka4OxfAGgQysShSuzfZDXggHcFIsr8zw8x+7
	0MrzZUSWRtCJhqNEL/Tjx+/roJyukbhuBtET//xZwE3Ub496060JFIKNEYTljBOX4D2aaSzhDvIHp
	WPQzizbw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOi-0MAA;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7y-00000001UXo-3m6Z;
	Tue, 28 Jul 2026 15:49:54 +0100
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
Subject: [PATCH v7 00/36] Cleaning up the KVM clock mess
Date: Tue, 28 Jul 2026 15:39:40 +0100
Message-ID: <20260728144954.355376-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

This is v7 of the series to clean up the KVM clock, rebased onto
kvm-x86/next (patch 1 of v6 is already merged there as commit
710b3a30f407).

The KVM clock has historically suffered from three problems:

 1. Imprecision: get_kvmclock_ns() computed the clock from the *host*
    TSC without applying guest TSC scaling, causing systemic drift from
    the values the guest computes from its own TSC.

 2. Unnecessary discontinuities: gratuitous KVM_REQ_MASTERCLOCK_UPDATE
    requests caused the master clock reference point to be re-snapshotted,
    yanking the guest's clock due to arithmetic precision differences.

 3. No precise migration API: the existing KVM_[GS]ET_CLOCK only allows
    setting the clock at a given UTC reference time, which is necessarily
    imprecise. There was no way to preserve the exact arithmetic
    relationship between guest TSC and KVM clock across live migration.

This series addresses all three, and adds new APIs for precise clock
migration and TSC frequency reporting. As an added bonus, it now rips
out the whole pvclock_gtod_data hack which was shadowing the kernel's
timekeeping, and uses ktime snapshots as $DEITY (well, Thomas) intended.

The series is now ordered with the fixes and cleanups first; the new
uAPI (the pvclock-abi UAPI move, KVM_[GS]ET_CLOCK_GUEST and
KVM_VCPU_TSC_SCALE) and all the new selftests come at the end, so that
the former are not gated on review of the latter.

v7: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kvmclock7

 - Rebased onto kvm-x86/next; dropped the already-merged first patch.
 - Reordered so that all the new uAPI (pvclock-abi UAPI move,
   KVM_[GS]ET_CLOCK_GUEST, KVM_VCPU_TSC_SCALE) and the new selftests
   come at the end of the series, after the fixes and cleanups which
   do not depend on them (Sean).
 - Split "Restructure get_kvmclock()" into two: dropping the CPU
   pinning is now a separate preliminary patch (Sean).
 - compute_guest_tsc(): use abs() and a conditional negation instead
   of duplicated scaling logic, and note in the changelog that the
   negative delta case is believed unreachable in practice (Sean).
 - Use HZ_PER_KHZ instead of literal 1000 for TSC unit conversions
   (Sean).
 - xen_migration_test: transfer the guest TSC via KVM_VCPU_TSC_OFFSET
   instead of a no-op TSC_ADJUST save/restore, making the runstate
   restore and steal-time assertions deterministic instead of racing
   VM-creation latency.
 - Reference the kvmclock definitions taxonomy by its now-stable
   (hopefully) commit ID 710b3a30f407.

v6: https://lore.kernel.org/all/20260703212145.343527-1-dwmw2@infradead.org/
    https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kvmclock6

David Woodhouse (33):
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Activate master clock immediately on vCPU creation
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: Fold __get_kvmclock() into get_kvmclock()
      KVM: x86: Drop CPU pinning in get_kvmclock()
      KVM: x86: Restructure get_kvmclock()
      KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
      KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
      KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
      KVM: x86: Restructure kvm_guest_time_update() for TSC upscaling
      KVM: x86: Simplify and comment kvm_get_time_scale()
      KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
      KVM: x86: Improve synchronization in kvm_synchronize_tsc()
      KVM: x86: Kill last_tsc_{nsec,write,offset} fields
      KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
      KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
      KVM: x86: Factor out kvm_use_master_clock()
      KVM: x86: Avoid gratuitous global clock updates
      KVM: x86/xen: Prevent runstate times from becoming negative
      KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
      KVM: x86: Remove runtime Xen TSC frequency CPUID update
      KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
      KVM: x86: Use ktime_get_snapshot_id() for master clock
      KVM: x86: Compute kvmclock base without pvclock_gtod_data
      KVM: x86: Cache host vclock_mode for masterclock eligibility checks
      KVM: x86: Remove pvclock_gtod_data and private timekeeping code
      KVM: x86: Activate master clock from kvm_arch_init_vm()
      KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
      KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
      KVM: selftests: Add master clock offset test
      KVM: selftests: Add Xen/generic CPUID timing leaf test
      KVM: selftests: Add Xen runstate migration test

Jack Allister (3):
      UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
      KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
      KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                     |   37 +
 Documentation/virt/kvm/devices/vcpu.rst            |  120 ++-
 MAINTAINERS                                        |    4 +-
 arch/x86/include/asm/kvm_host.h                    |   16 +-
 arch/x86/include/uapi/asm/kvm.h                    |    7 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h      |   27 +-
 arch/x86/kvm/cpuid.c                               |   16 -
 arch/x86/kvm/msrs.c                                |    9 +-
 arch/x86/kvm/svm/svm.c                             |    3 +-
 arch/x86/kvm/vmx/vmx.c                             |   10 +
 arch/x86/kvm/x86.c                                 | 1089 ++++++++++++--------
 arch/x86/kvm/x86.h                                 |    3 +-
 arch/x86/kvm/xen.c                                 |   28 +-
 arch/x86/kvm/xen.h                                 |   13 -
 include/uapi/linux/kvm.h                           |    3 +
 scripts/xen-hypercalls.sh                          |    2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |    5 +
 .../selftests/kvm/x86/masterclock_offset_test.c    |  180 ++++
 .../selftests/kvm/x86/pvclock_migration_test.c     |  383 +++++++
 tools/testing/selftests/kvm/x86/pvclock_test.c     |  443 ++++++++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c      |  230 +++++
 .../testing/selftests/kvm/x86/xen_migration_test.c |  205 ++++
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |   17 +-
 23 files changed, 2325 insertions(+), 525 deletions(-)

