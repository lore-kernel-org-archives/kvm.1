Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD53403E0;
	Fri,  3 Jul 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113728; cv=none; b=Vt6OAh7HFkQprnD8XY3ax0wMPgFjwvJ0zIQUTR54q6MnTCxRaE3XXnknRkAdK67gC0ctLYa14f57RqkqT2QWtQG/1CkJLShES02szMIFqkIoPIhbPz0iyhyEj/xxG9SY3yRTHJ+aHkTxeCT/quemavD6L+CfzmNspHQTojgtqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113728; c=relaxed/simple;
	bh=9mGiQUKRAIzkU7xBNiFoxOQ0lev2fQX3eEuG+hhioAE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bV+ZEbCOK4ST17fQxmLzDsseDrVfef1UoNdM6Iq5zQAOxY9K9+ezSWRqMpcLD1OgyAhQbTlbSKqfFKQBnrYJTN7XiKt0uL3BE6dNuT7GupZv2C45MXVzXF07yC4Rnm/WOdUOTv6DKAPoZAQKzMR13Vhx1eq7Q9txcsMbt1av8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W9XzMKZF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W9XzMKZF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wvuVYxcpMKTUzB1PVAb2vp+z8q/daFQH97Zt0FzYdTI=; b=W9XzMKZF+Q5CoOq/aV2FImKmn4
	+MBNEUMz1UUX//35ieMEnUbaiZsHQsTOrfpMqJyem7xM2MCXsESLogrweax1K4VEn7VGsaAxuFtol
	n+KQ3EN4fgjtWaRqFyqxHg1HXf/yi2skXyW+jTaS0Qk1V7TSrvx56j13mRj5oekE/3fEQ694N2cEW
	mgq2fLxp2c99mW3FSQvDkCeudg1OHZOrce5n9XulglxvOXfr3wtY6IequF8Fr3xVB2motyCwj4WPC
	gykHtGQP7j0TgEtGz5X17+6/VdjMQG4YNf7bRWnBi75ZgSnmbQsHS/Sr74SliiI5bkrRKoTzdHNeY
	jhjnQZOA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflKV-0000000AsXw-3fP8;
	Fri, 03 Jul 2026 21:21:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKV-00000001RNm-31u8;
	Fri, 03 Jul 2026 22:21:47 +0100
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
Subject: [PATCH v6 00/36] Cleaning up the KVM clock mess
Date: Fri,  3 Jul 2026 22:17:39 +0100
Message-ID: <20260703212145.343527-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

This is v6 of the series to clean up the KVM clock, rebased onto the
tip timers/ptp material (the timers-ptp-2026-06-13 merge, which includes
Thomas's ktime snapshot series and the read_snapshot patches).

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

v5: https://lore.kernel.org/all/20260608145455.89187-1-dwmw2@infradead.org/

Changes since v5:
 - Rebased onto the tip timers-ptp-2026-06-13 merge.

 - Series shape: two new patches ("KVM: selftests: Use UAPI pvclock-abi.h
   in xen_shinfo_test" and "KVM: x86: Activate master clock from
   kvm_arch_init_vm()"); "Replace pvclock_gtod_data vclock_mode with
   boolean" is replaced by "Cache host vclock_mode for masterclock
   eligibility checks".

 - Sean Christopherson's review:
   * KVM_VCPU_TSC_SCALE: return -ENXIO (not -EINVAL) from the get/set
     device-attribute handlers when !has_tsc_control, and do so in the
     patch that introduces the attribute.
   * Clear SECONDARY_EXEC_TSC_SCALING in setup_vmcs_config() rather than
     vmx_hardware_setup(), so the per-CPU configs recomputed by
     vmx_check_processor_compat() stay consistent with the golden
     vmcs_config.

 - kernel test robot (0-day), i386 W=1 warnings:
   * get_kvmclock(): move hv_clock into the use_master_clock block, drop
     the now-unnecessary get_cpu()/put_cpu() pinning (use_master_clock
     implies a stable synchronised TSC clocksource), and replace the
     goto/'fallback:' label with a 'continue'.
   * pvclock_gtod_notify(): move 'tk' inside CONFIG_X86_64.

 - Correctness fixes from review:
   * KVM_SET_CLOCK_GUEST: bound the shift in hvclock_to_hz(), tighten
     tsc_shift validation to [-31, 31], and reject guest_tsc below
     pvclock.tsc_timestamp.
   * kvm_guest_time_update(): read kvmclock_offset inside the pvclock
     seqcount loop to avoid a torn read.
   * kvm_snapshot_has_tsc(): honour snap->valid and zero-init the
     snapshot, avoiding use of uninitialised stack.
   * kvm_synchronize_tsc(): advance the matched reference point to "now"
     to preserve the 1-second TSC matching window.
   * kvm_track_tsc_matching(): request a masterclock update when
     all_vcpus_matched_tsc changes, so PVCLOCK_TSC_STABLE_BIT is
     broadcast to the other vCPUs.
   * kvm_arch_enable_virtualization_cpu(): adjust cur_tsc_offset together
     with cur_tsc_write under tsc_write_lock on the backwards-TSC / host
     S4 resume path.
   * kvm_set_tsc_khz(): sample the guest TSC before changing the ratio,
     preserving continuity across the frequency change.
   * Keep the real vclock_mode (int) rather than collapsing it to a
     bool, so kvm_check_tsc_unstable() still special-cases HVCLOCK.
   * Activate the master clock, and establish the initial TSC generation
     and kvmclock epoch, from kvm_arch_init_vm() instead of a synchronous
     kvm_update_masterclock() at each vCPU creation (avoids O(N^2)).

 - selftests: use kvm_vm_free() instead of kvm_vm_release(); add the
   missing Makefile entry for xen_migration_test; guard on
   KVM_GET_CLOCK_GUEST / KVM_VCPU_TSC_OFFSET availability; use the
   KVM_VCPU_TSC_SCALE enum instead of a literal; overflow-safe
   arithmetic and looser tolerances.

 - Documentation: fix the KVM_VCPU_TSC_OFFSET / KVM_VCPU_TSC_SCALE ReST
   heading underlines (Randy Dunlap).

 - UAPI: asm/kvm.h now includes <asm/pvclock-abi.h> so the
   KVM_[GS]ET_CLOCK_GUEST ioctls are self-contained.

 - Collected Dongli Zhang's Tested-by (kexec/LUO testing of the KVM clock
   accuracy, pvclock-abi UAPI move, KVM_[GS]ET_CLOCK_GUEST and
   redundant-masterclock-update patches).

David Woodhouse (33):
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
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
      KVM: selftests: Add master clock offset test
      KVM: x86: Factor out kvm_use_master_clock()
      KVM: x86: Avoid gratuitous global clock updates
      KVM: x86/xen: Prevent runstate times from becoming negative
      KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
      KVM: x86: Remove runtime Xen TSC frequency CPUID update
      KVM: selftests: Add Xen/generic CPUID timing leaf test
      KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
      KVM: selftests: Add Xen runstate migration test
      KVM: x86: Use ktime_get_snapshot_id() for master clock
      KVM: x86: Compute kvmclock base without pvclock_gtod_data
      KVM: x86: Cache host vclock_mode for masterclock eligibility checks
      KVM: x86: Remove pvclock_gtod_data and private timekeeping code
      KVM: x86: Activate master clock from kvm_arch_init_vm()

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
 arch/x86/kvm/svm/svm.c                             |    3 +-
 arch/x86/kvm/vmx/vmx.c                             |   10 +
 arch/x86/kvm/x86.c                                 | 1104 ++++++++++++--------
 arch/x86/kvm/xen.c                                 |   30 +-
 arch/x86/kvm/xen.h                                 |   13 -
 include/uapi/linux/kvm.h                           |    3 +
 scripts/xen-hypercalls.sh                          |    2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |    5 +
 .../selftests/kvm/x86/masterclock_offset_test.c    |  180 ++++
 .../selftests/kvm/x86/pvclock_migration_test.c     |  383 +++++++
 tools/testing/selftests/kvm/x86/pvclock_test.c     |  443 ++++++++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c      |  230 ++++
 .../testing/selftests/kvm/x86/xen_migration_test.c |  194 ++++
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |   17 +-
 21 files changed, 2318 insertions(+), 526 deletions(-)

base-commit: 2d6d57f889f3

