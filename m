Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893808;
	b=1LZNgRtSoYCSURbzQ3FfOTS1ewQAMNmKGAz0fPm8PJ+E+K8gNDEXcehpELwrwPFbipBp
	 vSnBDlJs8ZHRFDM8H2oEaletWj4X2LJ4ufcFqerN78vAQpkAN3yupTKtZ4q0d4JNQwVvF
	 nroOXwX+/ChoYqAE7iNkmfYKRjeLcy5Cjsg3qV6LmiRP5NJUM26a4rfDmIQOLk04hBJ/I
	 gBjVTeU0yXnWheB4DONl4qHFT37Y++a5GDK7taHcqmtwb7NVI4TFNxMPywVxtiWLSk33B
	 tIPFdHoGCTKY6zFlz7Tshh/na/0oozEUGqtNq+aipVV9HwAK84JWAoEfnyLd0F8rTIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893808;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=IE4nklCY6MqcWE84DEdzahJjtNtoxYrOmz7d/xAWpjA=;
	b=ZICGjoeR2BehVtVTnD+2k+S6NVO0PQ1bBPyfDuyNHkIWdINicDYPXBbmU7v9aFtNMHJI
	 PT6H2q+5CsuC5SDsRpj2LBSiwaj02M3R0fEFGavce72FxC/sMfvZGw5xTyCegrrrAmN/y
	 D9X2WPM+AlnPqUQQrEFfbZ+f+CDDgk20kSxzEvQijBocsJqNXxJRpej8cguejbNAe0rav
	 vXUIobRbBeYuzeQfZbTW1VudWLQPMhWHdcrWyZMO80JYj6RoCeCAxnt/sYF3zlyJpsKyu
	 Uar3+ZHRFu12FM7K6hhBaSPZCxsay8BYA6QkfWqp47PSZhWrsww0b3bUvlMhcSnBiVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LT46+Cb6;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F260A6F7C;
	Thu,  5 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20F260A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LT46+Cb6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IE4nklCY6MqcWE84DEdzahJjtNtoxYrOmz7d/xAWpjA=; b=LT46+Cb6CZUVUDRuVm1F3DlLGg
	+H39EuzmNT3t35kf3L3pI++omhytgemqpp4ZkEKGoBN+IpNwZ++ZZW+Az6Y55+ksELJr3xpcxx3OO
	+MTghaWpcuMos4bM57OOB8AWXtEkgWnUhhghZNcmCcAllZ/P1ddUehsvV9Qo7Qv2MJkp2kefF3gzL
	WNeNsaGg1YjKNFN3viPuKG/PQ49gOrtycLthxRgv0uchHv/Xdnd2WAu3ii+0pgprKezu7FqYubQAG
	kcW5Tfm8RrQ94VYXcGl8tcwbbt2JfkpAJgSxtvdKUXv54YKBB7eQjvrdPruU5JD96THu77RkGsOJ0
	usSpbCPw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzit-00000009aoe-2vPJ;
	Thu, 05 Nov 2026 15:49:55 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOzit-0000000Aayj-1mx0;
	Thu, 05 Nov 2026 15:49:55 +0000
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
Subject: [PATCH v11 00/23] KVM: x86: Cleaning up the KVM clock mess, part 2
Date: Thu,  5 Nov 2026 07:49:31 -0800
Message-ID: <20261105154955.2525419-1-dwmw2@infradead.org>
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

This is the second half of the KVM clock series which has been churning
since about 2024. The first half¹ is upstream as of 7.4-rc1 (yay!).
This is the remainder — the masterclock overhaul, and new API for
fixing migration.

The KVM clock is defined, in the sane case, as a simple arithmetic
function of the guest TSC. The masterclock patches stop KVM from
breaking that definition gratuitously: TSC synchronization no longer
depends on wallclock-sampling heuristics where exact matching will do,
vCPUs with matching frequency but offset TSCs no longer disable the
master clock, and clock updates stop perturbing a perfectly good
reference point for no reason.

The uAPI half then lets userspace preserve the TSC→kvmclock
relationship precisely across migration and live update, instead of
clamping to a UTC reference with KVM_SET_CLOCK and giving the guest an
additional discontinuity: KVM_[GS]ET_CLOCK_GUEST transfers the actual
pvclock information, and KVM_VCPU_TSC_SCALE exposes the precise TSC
frequency and scaling. Selftests prove the lot, including a simulated
live migration which preserves the clock relationship to the limits of
arithmetic precision.

Tree: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kvmclock11

Since v7² (the last time this half was posted):

 • Rebase onto part 1 as merged in 7.4-rc1.
 • KVM_GET_CLOCK_GUEST no longer writes guest memory; it computes the
   pvclock information directly from the master clock reference point,
   and returns -ENODATA when not in master clock mode. Invoking
   kvm_guest_time_update() from the GET path dirtied guest pages after
   the final dirty-log pass during live migration, which was unkind.
 • KVM_CAP_CLOCK_GUEST renumbered; 251 was taken in the meantime.
 • A TSC synchronization now clears the vCPU's pending backwards-TSC
   compensation, which is already folded into the matched offset it
   reuses; applying it again at the next vcpu_load doubled the delta.
 • Re-synchronizing the TSC after KVM_SET_TSC_KHZ joins the current
   generation for a vCPU which has never run (unless userspace already
   wrote its TSC), preserving the matched state of its siblings and
   with it PVCLOCK_TSC_STABLE_BIT; a vCPU whose scaling ratio differs
   from the generation's opens a new generation rather than inheriting
   an offset recorded in a different scaling domain.
 • The Hyper-V reenlightenment notifier invalidates the TSC page
   itself, now that the clock update consumes the pending masterclock
   requests which used to do it.
 • pvclock_migration_test now also covers vCPUs with mutually-offset
   TSCs: each vCPU's TSC is migrated individually, and a single
   KVM_SET_CLOCK_GUEST on vCPU0 restores the VM-wide clock.
 • New selftest: the first userspace TSC write is honoured exactly,
   rather than being snapped back by the 1-second slop heuristic.
 • Drop the open-coded fallback in kvm_xen_start_timer(); its excuse
   for not using get_kvmclock_ns() went away in part 1.
 • Use a single coherent time snapshot in kvm_vm_ioctl_set_clock()
   instead of sampling CLOCK_REALTIME and the kvmclock base separately.
 • Assorted hardening from pre-post review: KCSAN annotations for the
   benign lockless flag reads, documentation for -EINVAL and the
   same-vCPU requirement of KVM_[GS]ET_CLOCK_GUEST, and selftests that
   skip rather than fail on kernels and hosts without the prerequisites.

¹ https://lore.kernel.org/all/20260826213303.914988-1-seanjc@google.com
² https://lore.kernel.org/all/20260728144954.355376-1-dwmw2@infradead.org


David Woodhouse (20):
  KVM: x86: Improve synchronization in kvm_synchronize_tsc()
  KVM: x86: Kill last_tsc_{nsec,write,offset} fields
  KVM: x86: Replace nr_vcpus_matched_tsc count with
    all_vcpus_matched_tsc bool
  KVM: x86: Allow KVM master clock mode when TSCs are offset from each
    other
  KVM: x86: Factor out kvm_use_master_clock()
  KVM: x86: Avoid gratuitous global clock updates
  KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
  KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
  KVM: x86: Cache host vclock_mode for masterclock eligibility checks
  KVM: x86: Remove pvclock_gtod_data and private timekeeping code
  KVM: x86: Activate master clock from kvm_arch_init_vm()
  KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
  KVM: selftests: Add library helpers for clock and TSC-offset ioctls
  KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC
    migration
  KVM: selftests: Add master clock offset test
  KVM: selftests: Add Xen/generic CPUID timing leaf test
  KVM: selftests: Add Xen runstate migration test
  KVM: selftests: Test that the first user TSC write is honoured exactly
  KVM: x86/xen: Drop open-coded fallback clock read in
    kvm_xen_start_timer()
  KVM: x86: Use a single time snapshot in kvm_vm_ioctl_set_clock()

Jack Allister (3):
  UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
  KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
  KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                |  54 ++
 Documentation/virt/kvm/devices/vcpu.rst       | 130 +++-
 Documentation/virt/kvm/locking.rst            |   2 +-
 MAINTAINERS                                   |   4 +-
 arch/x86/include/asm/kvm_host.h               |  12 +-
 arch/x86/include/uapi/asm/kvm.h               |   7 +
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h |  27 +-
 arch/x86/kvm/msrs.c                           |  20 +-
 arch/x86/kvm/x86.c                            | 711 ++++++++++++++----
 arch/x86/kvm/x86.h                            |   2 +-
 arch/x86/kvm/xen.c                            |  40 +-
 include/uapi/linux/kvm.h                      |   4 +
 scripts/xen-hypercalls.sh                     |   2 +-
 tools/arch/x86/include/asm/pvclock-abi.h      |  27 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +
 .../selftests/kvm/include/x86/processor.h     |  50 ++
 .../kvm/x86/masterclock_offset_test.c         | 215 ++++++
 .../kvm/x86/pvclock_migration_test.c          | 520 +++++++++++++
 .../testing/selftests/kvm/x86/pvclock_test.c  | 447 +++++++++++
 .../selftests/kvm/x86/tsc_user_set_test.c     |  86 +++
 .../selftests/kvm/x86/xen_cpuid_timing_test.c | 273 +++++++
 .../selftests/kvm/x86/xen_migration_test.c    | 222 ++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  31 +-
 23 files changed, 2625 insertions(+), 267 deletions(-)
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

