Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE63D332A;
	Sat,  9 May 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366931; cv=none; b=b0bs+o6T0CdoqUv5S4j2VWvYM24RJQ6+/kKZmOu1tU+TZ6cmSrJvnYWWymzxjf7hO+sCr5vBesw5dOWzgMt+UvvbF1GiQLxH/+TbIYdQDoys5fboIOcJNDS6/QH/2MOMepWgMQt2u/Z1uMdkPiPltSQs+KCcWNX91Pdj+ZHXENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366931; c=relaxed/simple;
	bh=pCzUlPoOPyoroNA2wb7IPo44nSGyNvAuAkDwdMrU8q0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lK/34UDrpgmcGYC6mejrB01vZW7seMB+qnAi3BtOWDgaJzSGGUppQrfMmMeCaHbgPVroU00PEHHnc6U8RA9uep0v0MFUVjlmkPGLNtOsNu6kPni+A3+BQd25h0AJNar+2EDPGhcQwIkfvoH2UPxQc+K0Xn1QhNUFz0IlLWZyRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ES7WV1Ia; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ES7WV1Ia"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XG5p4cJcLgImpvW6Me4R9NQ4kt4cFymqrFSnQMVMwOY=; b=ES7WV1IaPYdAPQghiFOJa/RmZY
	4LlcRdnPpTdc4p2WmH6+v831QI/nCxKhQTpeiQvQrzWuSN4lUBadGmnwriNY/sd4I32yr/WcNisPu
	zxc1dbf2YiOSilzjsQoIyixtVnPxtRgYEGOk/3O7TNWwNux0b0TRIy1Ou5tsIHkzYUvYbfVgT6xxo
	TFOzByeaxUYJVDT/7L+l+B0HN24YMmuUuyb51SEhxtyguBU1yjwvirNy12P9s7lrPmH1QtMISeoV/
	VY6XaeAoQkrjuUqg8fTQThOxdknMqCh4N9HgtHWTEQqrk7RIg92pmHDd09fvkAm1nJkmrZgL2jgs/
	oRqO8Acg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTC-000000060L8-2QAw;
	Sat, 09 May 2026 22:48:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTB-0000000DhHG-3mRt;
	Sat, 09 May 2026 23:48:25 +0100
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
Subject: [PATCH v4] 00/30] Cleaning up the KVM clock mess
Date: Sat,  9 May 2026 23:46:26 +0100
Message-ID: <20260509224824.3264567-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

This is v4 of the series to clean up the KVM clock, addressing review
feedback from Sean Christopherson and Paul Durrant on v3, rebased to
the current kernel, and incorporating related work from Dongli Zhang.

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
migration and TSC frequency reporting.

Changes since v3:
 - Rebased to v7.1-rc2
 - Split patch 09 (__get_kvmclock fix) into 6 incremental patches per
   Sean's review
 - Split patch 10 (TSC upscaling) into 2 patches per Sean's review
 - Split patch 15 (offset TSCs) into frequency-match vs offset-match
 - Addressed Sean's review: hw_tsc_hz overflow (u64), KVM_VCPU_TSC_SCALE
   gated on has_tsc_control, pvclock_gtod_notifier unregister path,
   kvm_get_time_scale() readability, and many more
 - Incorporated Dongli Zhang's masterclock drift mitigation, reworked as
   a proper deduplication of redundant updates via request clearing under
   the tsc_write_lock
 - Added KVM_VCPU_TSC_EFFECTIVE_FREQ attribute for userspace to populate
   CPUID timing leaves without KVM modifying guest CPUID at runtime
 - Removed runtime Xen TSC CPUID modification (was updating wrong leaf)
 - Added guest-side patches to use CPUID 0x40000010 for TSC frequency
   under both KVM and Xen
 - Selftest covers clock correction at multiple TSC frequencies,
   PVCLOCK_TSC_STABLE_BIT behaviour, and multi-vCPU offset scenarios
 - Fixed RCU splat in KVM_GET_CLOCK_GUEST (needs srcu_read_lock)

The series can be broadly grouped as:

Patches 1-5: Core clock fixes and new KVM_[GS]ET_CLOCK_GUEST API
Patches 6-8: TSC scaling prerequisites
Patches 9-14: Fix get_kvmclock() precision (split per review)
Patches 15-16: Fix kvm_guest_time_update() for TSC upscaling
Patches 17-20: Code cleanup and simplification
Patches 21-22: Allow master clock with offset TSCs
Patches 23-24: Eliminate gratuitous clock updates
Patch 25: Xen runstate negative time fix
Patch 26: Deduplicate redundant masterclock updates
Patches 27-28: TSC frequency reporting for CPUID
Patches 29-30: Guest-side CPUID frequency consumption

David Woodhouse (27):
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: WARN if kvm_get_walltime_and_clockread() fails unexpectedly
      KVM: x86: Fold __get_kvmclock() into get_kvmclock()
      KVM: x86: Add WARN and restructure get_kvmclock()
      KVM: x86: Use get_kvmclock_base_ns() as fallback in get_kvmclock()
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
      KVM: x86: Add KVM_VCPU_TSC_EFFECTIVE_FREQ attribute
      KVM: x86: Remove runtime Xen TSC frequency CPUID update
      x86/kvm: Obtain TSC frequency from CPUID if present
      x86/xen: Obtain TSC frequency from CPUID if present

Jack Allister (3):
      UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
      KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
      KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                 |  37 ++
 Documentation/virt/kvm/devices/vcpu.rst        |  69 ++-
 MAINTAINERS                                    |   4 +-
 arch/x86/include/asm/kvm_host.h                |  13 +-
 arch/x86/include/asm/kvm_para.h                |   1 +
 arch/x86/include/uapi/asm/kvm.h                |  12 +
 arch/x86/include/uapi/asm/kvm_para.h           |  11 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h  |  27 +-
 arch/x86/kernel/kvm.c                          |  10 +
 arch/x86/kernel/kvmclock.c                     |   7 +-
 arch/x86/kvm/cpuid.c                           |  16 -
 arch/x86/kvm/svm/svm.c                         |   3 +-
 arch/x86/kvm/vmx/vmx.c                         |   2 +-
 arch/x86/kvm/x86.c                             | 735 ++++++++++++++++++-------
 arch/x86/kvm/xen.c                             |  21 +-
 arch/x86/kvm/xen.h                             |  13 -
 arch/x86/xen/time.c                            |  12 +
 include/uapi/linux/kvm.h                       |   3 +
 tools/testing/selftests/kvm/Makefile.kvm       |   1 +
 tools/testing/selftests/kvm/x86/pvclock_test.c | 415 ++++++++++++++
 20 files changed, 1157 insertions(+), 255 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_test.c
 rename arch/x86/include/{asm => uapi/asm}/pvclock-abi.h (82%)

