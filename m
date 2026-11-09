Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187281;
	b=D/fUveH3fMC03TECN8vluzRmwonwJQ9k/83wf76P84I/JrxE1QMAj6l4ztw8JDjIAdce
	 TOb+lT3viAWYXx9GpNoKtiWZCeVwlQlCKe9gufaH45g74TP1qi+JhISKShGGwB13SqyJ5
	 Lw9u0JCF2P6cqM1BtG0tJJdoynwb2MHbGCToFJ77L3KuDhK0iWuaF0My2+JzzsU7bmKvZ
	 mvvY96a2mQhFChBqC55TB3I6HgMkbK2v62JjpNgRAmSTFgm/r8hS5HFqk8vdBT5R/Ipi+
	 nsaPeoj2fRZhNcQuWvxBGZqDjxhe9aJMzYOCqYFFMtX03qfb/io/6NSq/PQIGLjVa6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=2JUWpAXehAdk2sueW9eETpGmCfDkYuUrUfomdwHxtKQ=;
	b=T731wnu/buL8P3Q6lxR5UfF68tosrOAwg7xIit576pm/oBKXk11ML4eJh4E7w8K258qe
	 hBawiGS5JVWatXR3GkFZTW+SDaCNN/MDbYn5tK5ZqGHR7LWSPYxosF08mbRBxokyr1tiS
	 YQtR7/G4HKgOR48RPCCQ6UZMbmjtyuRWHOwjmuTjs8sUcOad0wBwnFwxQFYtSV5gepmFT
	 3SpUsKvv/lrzbVZy2HrKXFpYZNFp73u+1XNsCIfFQvMQCWTPVZe4rXBVwA7PGLR/l5CTu
	 mjk4KOY0ChMglLprOVFp2/shiaCscg5TcE49IaUWuZ9vOXXFt7bz4KwvEFEYkUQ1aUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Q0PHCfEl;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DF606A332;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714DF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Q0PHCfEl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2JUWpAXehAdk2sueW9eETpGmCfDkYuUrUfomdwHxtKQ=; b=Q0PHCfElb3strszBz45LigVCIT
	3UJqLf36BDZ68nh49TcsICeTQWHXRUMLyJAUrFvBdyGpLMmye0vYT5823ikHuDd4C8a+0UUWULOeK
	wfS2yCD0A3dR9CSH7HNnTvR5mRA5HunaAJJfn/mF9MVloFyXqre1okr4OEYf0gO/5jycFCr9FIqK3
	VBvl72tQrOIHy/wpiDw24NQrNn6NvMusETpowpWC17V0n0uWw5/blJQa1B3ecQGVcYQPJ41WFh9d9
	b8EKm3gCZ4VjHF6EUMJgfAofZvoldwMH3n1UxFNIaGVYn+gh63I/aiWVamR0naPTLZahCVYIqr16q
	VLNhrigQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4O-00000007Pvo-3MrP;
	Mon, 09 Nov 2026 01:21:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKU4-1ax4;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 00/24] KVM: x86: Cleaning up the KVM clock mess, part 2
Date: Sun,  8 Nov 2026 17:20:46 -0800
Message-ID: <20261109012112.3415328-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

I love it when sashiko-bot finds things that my own local sashiko run didn't.

This is the second half of the KVM clock series which has been churning
since about 2024. The first half¹ is upstream as of 7.4-rc1 (yay!).  This is
the remainder — the masterclock overhaul, and new API for fixing migration.

In v12 I've finally removed the last reason why a *guest* can force the KVM
clock out of masterclock mode (by using the old SYSTEM_TIME MSR). Even if we
do still care about that SUSE kernel from 2015, we can satisfy it just by
updating the master clock when it rewrites the MSR.

Tree: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kvmclock12

Since v11², fixing what the on-list review found, and more that arose out of
that:

KVM_SET_TSC_KHZ:
 • Synchronizing during vCPU creation, before the vCPU is counted in
   online_vcpus, corrupted the VM-wide matching state.
 • Because the user_set_tsc flag was VM-wide, restoring one vCPU's TSC made
   a sibling's *unrestored* value be preserved across a frequency change.
 • Time spent in the ioctl between sampling the guest TSC and reinstalling
   it was silently subtracted from the vCPU's clock.
 • Setting the unchanged frequency perturbed the generation tracking, and a
   failed call committed the rejected frequency anyway.
 • An above-host-rate frequency on scaling-less hardware left the vCPU in
   catchup mode forever.

The master clock:
 • Making the first vCPU match the TSC generation established at VM
   creation was a silent guest-visible change (its TSC became the cycles
   elapsed since KVM_CREATE_VM), and handed it a stale offset if the host
   suspended while the VM had no vCPUs.
 • KVM_GET_CLOCK trusted a master snapshot which nothing refreshes for a
   VM with no vCPUs across a host suspend, returning a discontinuity
   flagged KVM_CLOCK_TSC_STABLE.
 • A TSC synchronization which changed the vCPU's offset left the guest's
   pvclock unrefreshed, now that offset changes no longer turn the master
   clock off.
 • When the last vCPU reached a new common frequency, nothing refreshed
   the masterclock scaling factors.
 • A pending masterclock update on a newly created vCPU wasn't serviced
   until it first ran, and a vCPU whose creation was aborted part-way
   stayed counted as matched forever.
 • Guests using the legacy MSR_KVM_SYSTEM_TIME lost the master clock
   entirely — the 2015 workaround for SUSE's 2.6.16 freshness heuristic,
   which is better satisfied by sliding the reference point forward when
   the legacy MSR is rewritten (new patch 24).

KVM_[GS]ET_CLOCK_GUEST:
 • The guest TSC comparison mishandled wraparound.
 • The frequency sanity check could underflow, rejected two hosts
   calibrated exactly 1kHz apart, and hvclock_to_hz() could wrap on
   absurd user-supplied mul/shift.
 • The -EBUSY case was unreachable, and GET returned from inside the
   seqcount read section.

Elsewhere:
 • kvm_vm_ioctl_set_clock() wrapped if the host clock had legally been
   set to within moments of the 1970 epoch.
 • clang couldn't see that guest_now was always initialized in
   kvm_xen_start_timer() on 32-bit builds (kernel test robot³).
 • Comments and commit messages overclaimed in places, the
   kvm_update_master_clock tracepoint still said "offsetmatched", the
   tools/ uapi header mirror had drifted, and api.rst didn't document the
   new KVM_SET_TSC_KHZ behaviour.
 • Selftests skipped on any errno rather than just -ENODATA, could pass
   on a buggy kernel under adverse scheduling, lost a whole frequency's
   coverage when hardware scaling wasn't engaged, and carried a third
   private copy of the pvclock arithmetic.

¹ https://lore.kernel.org/all/20260826213303.914988-1-seanjc@google.com
² https://lore.kernel.org/all/20261105154955.2525419-1-dwmw2@infradead.org
³ https://lore.kernel.org/all/202611072152.FL5QBzjH-lkp@intel.com


David Woodhouse (21):
  KVM: x86: Improve synchronization in kvm_synchronize_tsc()
  KVM: x86: Kill last_tsc_{nsec,write,offset} fields
  KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
  KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
  KVM: x86: Factor out kvm_use_master_clock()
  KVM: x86: Avoid gratuitous global clock updates
  KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
  KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
  KVM: x86: Cache host vclock_mode for masterclock eligibility checks
  KVM: x86: Remove pvclock_gtod_data and private timekeeping code
  KVM: x86: Activate master clock from kvm_arch_init_vm()
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

 Documentation/virt/kvm/api.rst                |  61 ++
 Documentation/virt/kvm/devices/vcpu.rst       | 137 ++-
 Documentation/virt/kvm/locking.rst            |   2 +-
 MAINTAINERS                                   |   4 +-
 arch/x86/include/asm/kvm_host.h               |  14 +-
 arch/x86/include/uapi/asm/kvm.h               |   7 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h |  27 +-
 arch/x86/kvm/msrs.c                           |  28 +-
 arch/x86/kvm/trace.h                          |  12 +-
 arch/x86/kvm/x86.c                            | 957 ++++++++++++++----
 arch/x86/kvm/x86.h                            |   2 +-
 arch/x86/kvm/xen.c                            |  48 +-
 include/uapi/linux/kvm.h                      |   4 +
 scripts/xen-hypercalls.sh                     |   2 +-
 tools/arch/x86/include/asm/pvclock-abi.h      |  27 +-
 tools/arch/x86/include/uapi/asm/kvm.h         |   6 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +
 .../selftests/kvm/include/x86/processor.h     |  50 +
 .../kvm/x86/masterclock_offset_test.c         | 203 ++++
 .../kvm/x86/pvclock_migration_test.c          | 521 ++++++++++
 .../testing/selftests/kvm/x86/pvclock_test.c  | 518 ++++++++++
 .../selftests/kvm/x86/tsc_user_set_test.c     | 153 +++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c | 271 +++++
 .../selftests/kvm/x86/xen_migration_test.c    | 222 ++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  31 +-
 25 files changed, 3010 insertions(+), 303 deletions(-)
 rename arch/x86/include/{ => uapi}/asm/pvclock-abi.h (82%)
 create mode 100644 tools/testing/selftests/kvm/x86/masterclock_offset_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_migration_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tsc_user_set_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_migration_test.c


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.43.0

