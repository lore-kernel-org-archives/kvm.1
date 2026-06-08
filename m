Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49147AF5C;
	Mon,  8 Jun 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930551; cv=none; b=XZy2QJq2FRAMZPLSlWQizG4GdVbsPXmRBLbqaY0R5QeRlUp4jcHwH5yp43GyShkJuuXG9cJ121AWARtAnJYQ4N0M9rTg6QkafD3yEpLdsgqwPe+vWsedrrqohSmOomaLmuXBCsQk1jhriSUxHJaTpSMC0pEPGbPO3FZyJ62+ItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930551; c=relaxed/simple;
	bh=U0Off8Gt4aUWFvtQ+Z2BLcCThTzMu2R19NdWYIh4/bg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQAHJwIqrh4IvqxVdJLZ7f5YIVggfts7E2VSAesa6oHni/33/tCK3fvie68FXM0dIJ9pt2W2Zm67sMVAIiGg6qsC1lip3AV3hZmJxV4QvK8bAv2NryF/+MqA1K1MMWL6t2RmQR0lAj9rsp1RlfYOvVX0fOaylFIccnUdq4/WtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9MXUoXj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9MXUoXj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TgKl1KOO3MJY6Y2LA+lrNOwCy2WWSJSUW1q+Go58VwI=; b=P9MXUoXj7e3DhrM2y3IHOHq84j
	Dep6NROhhD5T6eCTvYbJKAS+eTglb9s+jKSn6uVmst9s5JTyCVQV9f14aN3sUIGo79+gzb2WHc7YU
	E/8Zq1W/ZqewrUv9ui/cszWJWLCs6e2QqNUl7nvYGE9dtX/H7iRVy930wxbzjbHuzIfv0YVWsdSey
	iZDAnFMYmwzQ3frOMg9RCyIqvH8dapfKqWvZL6LU/mPacHRped/qRnvVQbUDpKDMTuzG2/7idCnTT
	wdfpfALh8+kMdn0kKQZPa5Ce4FWQMNt14NCd8ogagcqSIYCifP5t8FEZENqDYEFTlW4j9MeiChGsp
	mPromYJw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNU-00000001Afw-2M3l;
	Mon, 08 Jun 2026 14:55:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNR-00000000NEV-1CLO;
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
Subject: [PATCH v5 00/34] Cleaning up the KVM clock mess
Date: Mon,  8 Jun 2026 15:47:41 +0100
Message-ID: <20260608145455.89187-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

This is v5 of the series to clean up the KVM clock, rebased onto
tip/timers/ptp (which now includes Thomas's ktime snapshot series and
the read_snapshot patches for hyperv, kvmclock, and vmclock).

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

Changes since v4:
 - Rebased onto tip/timers/ptp (includes ktime snapshot infrastructure)
 - Dropped "WARN if kvm_get_walltime_and_clockread() fails" — the WARN
   was spurious during clocksource transitions
 - Dropped guest-side "Obtain TSC frequency from CPUID" patches (adopted
   by Sean for a separate series)
 - Dropped KVM_VCPU_TSC_EFFECTIVE_FREQ
 - Fixed false re-enabling of master clock when a single vCPU syncs
   multiple times at a mismatched frequency: introduced per-vCPU
   cur_tsc_freq_generation counter so each vCPU is counted exactly once
 - Unified nr_vcpus_matched_tsc and nr_vcpus_matched_freq to use the
   same counting convention (1-based, >= online_vcpus threshold)
 - "Avoid gratuitous global clock updates": kept global update in
   non-master-clock mode on vCPU load (CLOCK_MONOTONIC_RAW means no NTP
   drift but preserving the existing safety); only optimize master clock
 - "Xen runstate negative time": refined to update state but not account
   time on backwards clock, always update last_steal and guest shared page
 - Added "Activate master clock immediately on vCPU creation" to avoid
   unnecessary non-master-clock window during VM setup
 - New final patches: use ktime_get_snapshot_id() for master clock
   reference, then remove pvclock_gtod_data entirely (replaced by direct
   ktime_get_raw() + offs_boot computation)
 - Added masterclock_offset_test selftest (verifies kvmclock consistency
   across vCPUs with different TSC offsets)
 - Added xen_cpuid_timing_test selftest
 - Added pvclock_migration_test selftest
 - Addressed AI reviewer (Sashiko) feedback throughout:
   - get_kvmclock(): goto fallback on clock read failure instead of
     using uninitialized data; single #ifdef CONFIG_X86_64 block
   - kvm_synchronize_tsc(): changed ns to s64 to match function
     signature; moved time reads inside tsc_write_lock
   - Kill last_tsc fields: use kvm_scale_tsc() subtraction for
     backwards TSC instead of zeroing cur_tsc_write
   - KVM_[GS]ET_CLOCK_GUEST: validate padding fields, bounds-check
     tsc_shift
   - pvclock selftest: seqcount loop for torn-read safety, per-vCPU
     pvclock addresses, graceful skip when caps unavailable
   - KVM_VCPU_TSC_SCALE: return -ENXIO when !has_tsc_control
   - UAPI pvclock-abi: added -D__KERNEL__ to xen-hypercalls.sh
   - VMX: also clear SECONDARY_EXEC_TSC_SCALING from vmcs_config

David Woodhouse (31):
  KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
  KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
  KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
  KVM: x86: Activate master clock immediately on vCPU creation
  KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
  KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
  KVM: x86: Fold __get_kvmclock() into get_kvmclock()
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
  KVM: x86: Replace pvclock_gtod_data vclock_mode with boolean
  KVM: x86: Remove pvclock_gtod_data and private timekeeping code
  KVM: selftests: Add master clock offset test
  KVM: selftests: Add Xen/generic CPUID timing leaf test
  KVM: selftests: Add Xen runstate migration test

Jack Allister (3):
  UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
  KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
  KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                     |   37 +
 Documentation/virt/kvm/devices/vcpu.rst            |  119 ++-
 MAINTAINERS                                        |    4 +-
 arch/x86/include/asm/kvm_host.h                    |   16 +-
 arch/x86/include/uapi/asm/kvm.h                    |    6 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h      |   27 +-
 arch/x86/kvm/cpuid.c                               |   16 -
 arch/x86/kvm/svm/svm.c                             |    3 +-
 arch/x86/kvm/vmx/vmx.c                             |    4 +-
 arch/x86/kvm/x86.c                                 | 1039 ++++++++++++--------
 arch/x86/kvm/xen.c                                 |   30 +-
 arch/x86/kvm/xen.h                                 |   13 -
 include/uapi/linux/kvm.h                           |    3 +
 scripts/xen-hypercalls.sh                          |    2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |    4 +
 .../selftests/kvm/x86/masterclock_offset_test.c    |  180 ++++
 .../selftests/kvm/x86/pvclock_migration_test.c     |  382 +++++++
 tools/testing/selftests/kvm/x86/pvclock_test.c     |  441 +++++++++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c      |  230 +++++
 .../testing/selftests/kvm/x86/xen_migration_test.c |  194 ++++
 20 files changed, 2263 insertions(+), 487 deletions(-)

base-commit: bc484a5096732cd858771cccd3164ec985bdc03d

