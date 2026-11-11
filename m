Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420579;
	b=YzYcW6V+TUWcyVLzrMLhrcGBGDJR4Gq/8MqzZgaU57M/VLrdglsboG17YnuahV42FIZv
	 NnBsxa+EeXju2ph/ArV4Q6S4T2SNfjGi/hgLqdDeaJ2KvYLl8cpnVzB5ir5yyFLbuFVVj
	 8WD2uEswkzz3uxY0mZZUKDGdipFMXM0kfZvPtFO1zKuSdEXd3LKF+XJ1416oY3Vzaj89f
	 Nvz8Me8JugtijYUnYAZt7hLoH6pyYHBMSN0t2Gw4R74dXkNkVhxGdqC6Ov7k2Kf1y82tW
	 hO+tKW6TMXmD7G9ssDNDQdrZy4KBBB2chQrDwOrqKO3/8cVaaabksLspFZ6clOwYGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420579;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=oRCP3DrtxOaEPcoJ0ufoNhyzkRiBwBsBmFUUnUqVfYA=;
	b=bu418ueMuWhkEWoBMx2iyfVeGcJKs9yGHPJFPeW0djSQMGFT8IhxiXhNsdh1Ar6CSkGT
	 u8Ztk33ITxZtX2OelnBNkcsjFadZhT/dgsxQbiesXKjX5ORlMobTSqzVRZq++2lQ0WTvh
	 yP/BEWxX+MfVbQ0bkuIeDmjTS9QjBRnKFYjZMNsAFvQCpgWrmnNrQ/jqEGD5j6Mq/T5lv
	 zBQVCrFwtK/JQcnpvIrKOhzXnw0d/WLELfcX1oY0q5bX9leMC8OpzgI8Mn/rrsvd439LS
	 iBEK9EWndb/l4ntlQZs+DRiJNZkKziILiyUjDy/NyKsFqiZYoLhYZPWciyuNaiVB1uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=j26ot3K9;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D7606B785;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 367D7606B785
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=j26ot3K9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oRCP3DrtxOaEPcoJ0ufoNhyzkRiBwBsBmFUUnUqVfYA=; b=j26ot3K9cQLLxemLhlK4VGVIhY
	Gd/attbYZo+2V5KGpH9CSWAr4iyTerNiuPpeOGJuadQsTM3wbLcZyOvC3NGusdg9wRC/C/y79sXk4
	OyQtESzJki1eGGzKkSRYv//EvUUzxQkkjVMFCIQnQ5iTYGHTNV5qX0FouU9nXOQBIalH+R7RBBvCy
	Pd1/IqTmnT2M37dwRj0YGlpij1f1leUL5RhDo2lK5roJRFaAVzJdz89aHEU2mcz64vxPdydrooq/s
	2u5DZAVNonW5BFu4w1Utz9mpLFdTjFAg5EvpPQYvV+pE3ysy9uaEPMR0ajeJ7JV+1LoNU43JbBFlm
	muYMPniA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvH-3Dr8;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl8-0000000HWs1-2z0x;
	Wed, 11 Nov 2026 18:09:22 +0000
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
Subject: [PATCH v13 00/26] KVM: x86: Cleaning up the KVM clock mess, part 2
Date: Wed, 11 Nov 2026 10:08:56 -0800
Message-ID: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

This is the second half of the KVM clock series which has been churning
since about 2024. The first half¹ is upstream as of 7.4-rc1 (yay!).  This is
the remainder — the masterclock overhaul, and new API for fixing migration.

Sashiko is helping by finding lots of things which have been fairly hosed
in kvmclock since its inception, as well as things I've managed to screw
up for myself along the way.

As of v12, a guest can no longer force the KVM clock out of masterclock
mode at all. Even the old SYSTEM_TIME MSR (and that SUSE kernel from 2006)
is satisfied by updating the master clock when the MSR is rewritten.

Tree: https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kvmclock13

v13 follows one more on-list sashiko round, a second 0day report⁴, and
eleven rounds of review-and-fixup with sashiko locally. Two
pre-existing bugs the review flushed out are split out as standalone
fixes with Fixes: tags (new patches 7 and 9), so the series is now 26
patches. In detail:

KVM_SET_TSC_KHZ:
 • The {guest TSC, host clock} tuple could be sampled just before a sibling
   opened a newer generation, wrapping the elapsed time — and the first
   fix, clamping it to zero, inflated the matching error from |F1-F2|·Δt
   to F1·Δt, spuriously splitting the generation when two vCPUs raced
   through the ioctl.
 • The 1ms matching window for exact kernel-internal samples was
   unreachable unless userspace had already written a TSC.
 • preempt_disable() did not actually make the fallback {TSC, ns} read
   pair coherent; interrupts could still land between the two reads.
 • A creation-time frequency the hardware cannot scale to left the vCPU
   with virtual_tsc_khz == 0 for its whole life.
 • An internal preserved sample of exactly zero took the userspace
   zero-write path and was snapped onto the generation line.
 • A forced synchronization of an unrun vCPU racing a sibling through
   the ioctl could wrap its extrapolated TSC below zero, which an
   unstable-TSC host then re-anchored the guest TSC to at vcpu_load.
 • The 1ms window computation needed libgcc's __udivdi3 on i386 (kernel
   test robot⁴).
 • The fix for stale always-catchup state is now its own patch with a
   Fixes: tag, since the bug predates this series (new patch 9), as is
   the fix for the Hyper-V TSC page latching stale parameters from a
   superseded snapshot (new patch 7).

The master clock:
 • A scaled protected guest TSC (TDX, SNP Secure TSC) left the master
   clock computing with the host's unscaled frequency.
 • The first protected-TSC synchronization cleared the frequency match
   for the life of the VM, since such vCPUs never reach
   kvm_track_tsc_matching() to re-latch it — and the re-latch then had to
   raise the masterclock update itself, or a refresh racing a second
   vCPU's creation latched the master clock off forever.
 • An aborted vCPU creation could clear matched state which a racing
   host-initiated TSC write on the already-live fd had made correct, and
   for a protected-TSC first vCPU it skipped the snapshot refresh forever.
 • KVM_GET_CLOCK's no-vCPU staleness check compared two reads nothing
   kept coherent, so a reader preempted for a second mid-ioctl served the
   flag-less fallback from a healthy snapshot.
 • Deduplicated masterclock updates removed the accidental heal for a
   Hyper-V TSC page rewritten from a stale snapshot: a vCPU preempted
   between its pvclock read and the page write consumed the HOST_CHANGED
   mark against the old snapshot and set HV_TSC_PAGE_SET, permanently.
   kvm_hv_setup_tsc_page() now revalidates the pvclock seqcount under
   its own lock, and the updater re-marks the page once the new snapshot
   is published.
 • The CLOCK_UPDATE broadcast sat inside the pvclock seqcount write
   section, growing the interrupts-off window with the vCPU count.
 • A CPU hotplug runs the backwards-TSC compensation while vCPU threads
   are live, and the unlocked consume of tsc_offset_adjustment in
   vcpu_load could discard a delta the generation reference kept.
 • kvm_vm_ioctl_set_clock()'s epoch-wrap guard left the anchor off
   master_kernel_ns, wrapping system_time for a near-zero clock instead.
 • Patch 12's subject and opening described an earlier patch's work; it
   is now "Keep the master clock trustworthy while the VM has no vCPUs".

KVM_[GS]ET_CLOCK_GUEST:
 • GET after a host suspend with the VM paused combined the post-resume
   offset with the pre-suspend snapshot — frequencies still matched, so
   the destination accepted garbage. GET now services the vCPU's pending
   masterclock update first, and fails with -ENODATA.

Elsewhere:
 • The TSC migration documentation's step 7b multiplication wraps a
   signed 64-bit value after ~51 minutes of pause at 3GHz; it now carries
   the same 128-bit note as step 2d, and the exemplar selftest does the
   arithmetic in 128 bits.
 • Selftests reported a loaded host as a kernel regression instead of a
   TAP skip, printed no TAP output at all, carried a fourth private copy
   of the pvclock arithmetic, and the divergent-offset correction check
   could not fail against a silently ignored KVM_SET_CLOCK_GUEST.
 • The CPUID timing test's ratio cross-check skip keyed off the very
   ratio it exists to verify, and the first-write test's
   frequency-change arm could pass on a buggy kernel under adverse
   scheduling.
 • The clock library helpers now also convert the pre-existing
   open-coded call sites.
 • Various comments and commit messages overclaimed ("invisible to any
   correct guest", "definitely identical", "the only synchronization a
   protected vCPU ever performs") and have been made honest.

¹ https://lore.kernel.org/all/20260826213303.914988-1-seanjc@google.com
² https://lore.kernel.org/all/20261105154955.2525419-1-dwmw2@infradead.org
³ https://lore.kernel.org/all/20261109012112.3415328-1-dwmw2@infradead.org
⁴ https://lore.kernel.org/all/202611091411.tSxUx2Bj-lkp@intel.com


David Woodhouse (23):
  KVM: x86: Improve synchronization in kvm_synchronize_tsc()
  KVM: x86: Kill last_tsc_{nsec,write,offset} fields
  KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
  KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
  KVM: x86: Factor out kvm_use_master_clock()
  KVM: x86: Avoid gratuitous global clock updates
  KVM: x86: Don't latch the Hyper-V TSC page from a superseded snapshot
  KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
  KVM: x86: Stop TSC catchup when a frequency change no longer needs it
  KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
  KVM: x86: Cache host vclock_mode for masterclock eligibility checks
  KVM: x86: Remove pvclock_gtod_data and private timekeeping code
  KVM: x86: Keep the master clock trustworthy while the VM has no vCPUs
  KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
  KVM: selftests: Add library helpers for clock and TSC-offset ioctls
  KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
  KVM: selftests: Add master clock offset test
  KVM: selftests: Add Xen/generic CPUID timing leaf test
  KVM: selftests: Add Xen runstate migration test
  KVM: selftests: Test that the first user TSC write is honoured exactly
  KVM: x86/xen: Drop open-coded fallback clock read in kvm_xen_start_timer()
  KVM: x86: Use a single time snapshot in kvm_vm_ioctl_set_clock()
  KVM: x86: Keep master clock for guests using legacy MSR_KVM_SYSTEM_TIME

Jack Allister (3):
  UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
  KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
  KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                |   64 +
 Documentation/virt/kvm/devices/vcpu.rst       |  144 +-
 Documentation/virt/kvm/locking.rst            |    3 +-
 MAINTAINERS                                   |    4 +-
 arch/x86/include/asm/kvm_host.h               |   21 +-
 arch/x86/include/uapi/asm/kvm.h               |    7 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h |   27 +-
 arch/x86/kvm/hyperv.c                         |   20 +-
 arch/x86/kvm/hyperv.h                         |   10 +-
 arch/x86/kvm/msrs.c                           |   30 +-
 arch/x86/kvm/trace.h                          |   12 +-
 arch/x86/kvm/x86.c                            | 1275 ++++++++++++++---
 arch/x86/kvm/x86.h                            |    2 +-
 arch/x86/kvm/xen.c                            |   50 +-
 include/uapi/linux/kvm.h                      |    4 +
 scripts/xen-hypercalls.sh                     |    2 +-
 tools/arch/x86/include/asm/pvclock-abi.h      |   48 -
 tools/arch/x86/include/uapi/asm/kvm.h         |    6 +
 tools/testing/selftests/kvm/Makefile.kvm      |    6 +
 .../selftests/kvm/include/x86/processor.h     |   50 +
 .../kvm/system_counter_offset_test.c          |    3 +-
 .../testing/selftests/kvm/x86/hyperv_clock.c  |    2 +-
 .../selftests/kvm/x86/kvm_clock_test.c        |    6 +-
 .../kvm/x86/masterclock_offset_test.c         |  249 ++++
 .../kvm/x86/pvclock_migration_test.c          |  503 +++++++
 .../testing/selftests/kvm/x86/pvclock_test.c  |  525 +++++++
 .../selftests/kvm/x86/tsc_user_set_test.c     |  193 +++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c |  293 ++++
 .../selftests/kvm/x86/xen_migration_test.c    |  227 +++
 .../selftests/kvm/x86/xen_shinfo_test.c       |   35 +-
 30 files changed, 3454 insertions(+), 367 deletions(-)
 rename arch/x86/include/{ => uapi}/asm/pvclock-abi.h (82%)
 delete mode 100644 tools/arch/x86/include/asm/pvclock-abi.h
 create mode 100644 tools/testing/selftests/kvm/x86/masterclock_offset_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_migration_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tsc_user_set_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_migration_test.c

-- 
2.43.0

