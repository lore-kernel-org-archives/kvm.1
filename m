Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD12366060
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252068; cv=pass; b=UNFwi3vedbThspriWwGkPCsMVWRkD47y4dwgqmXfECnzMGYoVz+nqwh9aGwA6Tu0JkvFrWCKPVLvusMYRPCxDJjZLL/Y4Na4DFSm9YCoQqpxhw7P5NyvJSLRceVpTWnls2cUSJrDEAYCWgQCVEkP6v2h3jQPLK2zZ2oN0bCt0aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252068; c=relaxed/simple;
	bh=ZwxsUlKLeq2XCDUSYDQjA5UQAE6sdpH1wCsnek4ISMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZa4tjJp7+5jAg9WJlTpi0KB8ELJ3OvyaznzctGhuUmBF+DfqBAVyUK+DoYt5Ojrxsd/vzR/ClbrHXlx1PzCmIdxg/W20w+dTPFfYTnc4pBsMuzzlhv77gomPalFy49oWc8S6nh8kj/Brke1eCGqt3i2SLZJckrmemRV55b4W08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HejDSdH6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpAkoOhH; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HejDSdH6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpAkoOhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781252062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipQcVU0/4/ewMCxEUT6HV9VBuDWDPIsgTxvrCcSBXxM=;
	b=HejDSdH6unuXO/VzTCI68HC4seI5giZsL3/FoDa+Iu6BQ9RTsfLam2/NtH7s46rwCy7ovx
	2eTw9cmIn/OeZ3bik+N4poEMd8t8HjWrrKASN5Uv+9bkmiDyi13zYHfsoB3M8p2oBELoI8
	WswxjBbXIk5AsHWiWkNM5peaZELraaQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-sUJWJkfcOqubwWDuDefpnA-1; Fri, 12 Jun 2026 04:14:18 -0400
X-MC-Unique: sUJWJkfcOqubwWDuDefpnA-1
X-Mimecast-MFC-AGG-ID: sUJWJkfcOqubwWDuDefpnA_1781252056
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso401843f8f.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252056; cv=none;
        d=google.com; s=arc-20240605;
        b=hRveiJ9AQNVtLJ9eCYvCQN6f8W8Na5yiRF80BPXhlYzgpjWU9a28GAyqd5VqJtfghu
         BN26+omuTSl8HGZcxsRwlW7pR6UxSgVFaStvF+ZMU4H3ULRCpYOeSmnM8dM4ckrNr4Kn
         i9j7Quem/74y4ftVV1joPlNM5dZ/NmR4wa7WwNDAU/9IZTclwKlBvaYCwIeJSmHiBoiS
         5xs/S69r/y787sV52AJwhMTDATjMrBzFCwWtbfpkbLUOfEoNOVuQi8hYXB5fNHWqxjiJ
         pxsv1kOjd4gVT7dCp0FGf2lsUQp7kg2vXE3QJWdg8Yr5auxAc6DtHarQn5iJxeSnXVkO
         qAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ipQcVU0/4/ewMCxEUT6HV9VBuDWDPIsgTxvrCcSBXxM=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=lJNa+r77kofvd+XGFE+7pjpfpwsO3tNexoEyAmGDOzINGvKe2oKVPkPDT7f1xZJRYY
         aqcc0PoKX9BH2fqamnmR6iV0F1SODe11pT9rkTiZ+i0ddPKTGdu6mYHo8IaRHrEQfiKZ
         pJ8SUGK5fW/K8G4YQ67O//+jLWIqT7K/kkqAkftk7+uAI+DTWDsQEWbJPELJUgBHkdsy
         5U4HiW232HGqRgm8/wWzqxZ53ut0K97ih0mpwMNevermDa8XWcg3Gf9OOGdLtQ0L1VmB
         9wX1H/t8PMZFuKLwCP2D1rzZGRUiH/LsLmz5RtDLakhEFSC9PDaHex+COfVpUWjuaCpT
         7dmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781252056; x=1781856856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipQcVU0/4/ewMCxEUT6HV9VBuDWDPIsgTxvrCcSBXxM=;
        b=KpAkoOhHkxF6uvQGQIdZSLjis+7WTc9+RTFHUKZby1IXVhGNN+9l1oEEUr0clpJ3k3
         oaL83CiyJw8EcoL21Vx1sjbHJU7anWmFXWMp+bnJDMOp4lJrduCLgUibYJf5MkUOZM20
         nsScOO0DEan6REVnDuJtEH40Ih5+kK/bwEooqO8Jboz+rAKrVA0bfCITvvtKFN3AtaTi
         smdGW46H9Y5jFdQLG2/SVZ7e6CT0wcD/fng//YovlKQmt/ksZF6w06GJhVSI7sMTDJoS
         b8EO74qTksJm/eeImfsDfsLQ7oUyL4kD8fAxPtdFq3Kz58uSypshI1v0klWe8uh22oIf
         r5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252056; x=1781856856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipQcVU0/4/ewMCxEUT6HV9VBuDWDPIsgTxvrCcSBXxM=;
        b=pog5ewe+5o87NgPwDjjF1eLf+EOLUdzGoOJgENeVTgPz+9U9gts3kmm1mRXtw6GdTw
         69cO673Q56SUGg0LZ9iptmGvYFaylOd2cHYc1vCL5MQx3s4hYUVEMlz/tk+QqoAfWXha
         OlkZ5kaOPI1JgMF0SCouZB2zG+tMiQZCt0HQRz6I9unApHken4fuDoXP1iGoaS4yJGE1
         KkoH80NZIclAty0z3ljIq5fdyPAS2TfMzcqFC71JfLUVd01kskXG0Vm4d7djC2vLKCdl
         a44iuXtHp+jMBDS4523arTVnnP7QgGT77opAJoAUkgr6drdhqnHJvPpZqlWGywkvxy0X
         cSNg==
X-Gm-Message-State: AOJu0YxErlliggchZSFHeh+Z1zxryMd8jjJRgluzOjj2ZXRQoBhd4qmA
	v6sV0qUHQ8ewsKxIIQuJYFph6iVEmWG7gkj4fllA6JXY1VDYYexuMtaQ0y+sgiBfYaeRbwDhE/t
	LuAp4sZD7UzY+JbN2VmWHYAnNbYRB3LzGQQaJk3VsOwY1UBjxIlWfR+ND3cwMH0v0fLlIkezmAT
	A5gyqXHR45PyoOwdrExhCZMbQScf8SpNssjS9y
X-Gm-Gg: Acq92OGdsX3odq/wf0LzoZNj86yzqLNDNDeR080q5F7GLHQ1mCuwE5UAZ/BYY5HMaEp
	0qpp94G6MaoHNxOQXo1pRh/91/PZob/s/bUQeVcso4ZosNW1d3eDwr1eekJhRZqqnAFdlAK6XgH
	l5fxQGMcEkNq9KOXRxuf/d0LTspFF4cVYmIEytCkSaneKil9nm1bvpcD8zuYm/TYc9A26aWkkvj
	CI1FLtRhfm9jxAuC/1Zqr1EDqEJT82LrJX2xlOaAUQpRfEiKcbqNpBOAJyWeYLN93SLNQlay5It
	y1olUQ==
X-Received: by 2002:a05:6000:2912:b0:460:18cb:8f9e with SMTP id ffacd0b85a97d-4606da621cemr2636883f8f.12.1781252056100;
        Fri, 12 Jun 2026 01:14:16 -0700 (PDT)
X-Received: by 2002:a05:6000:2912:b0:460:18cb:8f9e with SMTP id
 ffacd0b85a97d-4606da621cemr2636815f8f.12.1781252055568; Fri, 12 Jun 2026
 01:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-4-seanjc@google.com>
In-Reply-To: <20260612004755.349925-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:14:02 +0200
X-Gm-Features: AVVi8CdhzmncR0bBpLgZmtykv3i7Nm4lIeRAIVCF-4HFWVPzNivHYD2LPNg241M
Message-ID: <CABgObfYm+fV19UZPEof8zYbJegink5NfT+5sfXAZPUaVyX7L0A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> By patch count, the register API cleanup dominates, but the most notable =
change
> here is the SNP and TDX hypercall return code handling from Vishal+Sagi. =
 To
> allow userspace to tell the guest to "retry", the changes interpret the r=
eturn
> code from userspace as an errno value, and explicitly recognize only EAGA=
IN and
> EINVAL.  All other errnos are now reserved.  This is a change in uABI, bu=
t as
> far as we know, it won't break any VMMs that support SNP or TDX
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.2
>
> for you to fetch changes up to 65aa483f32ec674f0506658329d43403cafe5eb0:
>
>   Documentation: KVM: Synchronize x86 VM types (2026-06-08 09:20:19 -0700=
)
>
> ----------------------------------------------------------------
> KVM misc x86 changes for 7.2
>
>  - Handle EXIT_FASTPATH_EXIT_USERSPACE in vendor code to ensure vendor co=
de
>    gets a chance to handle things like reaping the PML buffer.
>
>  - Ensure KVM's copy of CR0 and CR3 are up-to-date on SVM prior to invoki=
ng
>    fastpath handlers.
>
>  - Update KVM's view of PV async enabling if and only if the MSR write fu=
lly
>    succeeds.
>
>  - Fix a variety of issues where the emulator doesn't honor guest-debug s=
tate,
>    and clean up related code along the way.
>
>  - Synthesize EPT Violation and #NPF "error code" bits when injecting fau=
lts
>    into L1 that didn't originate in hardware (in which case the VMCS/VMCB
>    doesn't hold relevant information).
>
>  - Add support for virtualizing (well, emulating) AMD's flavor of CPL>0 C=
PUID
>    faulting.
>
>  - Clean up the GPR APIs so that KVM's use of "raw" is consistent, and fi=
x a
>    variety of minor bugs along the way.
>
>  - Fix an OOB memory access due to not checking the VP ID when handling a
>    Hyper-V PV TLB flush for L2.
>
>  - Fix a bug in the mediated PMU's handling of fixed counters that allowe=
d the
>    guest to bypass the PMU event filter.
>
>  - Allow userspace to return EAGAIN when handling SNP and TDX hypercalls,=
 so
>    the KVM can forward a "retry" status code to the guest, and reserve al=
l
>    unused error codes for future usage.
>
>  - Misc fixes and cleanups.
>
> ----------------------------------------------------------------

Pulled, thanks.

Paolo

> Carlos L=C3=B3pez (2):
>       KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
>       Documentation: KVM: Synchronize x86 VM types
>
> Ethan Yang (1):
>       KVM: x86: Don't leave APF half-enabled on bad APF data GPA
>
> Hou Wenlong (7):
>       KVM: x86: Capture "struct x86_exception" in inject_emulated_excepti=
on()
>       KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction e=
mulation
>       KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when emulating MOV DR (in em=
ulator)
>       KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking for code break=
points in emulation
>       KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into kvm_inject_emu=
lated_db()
>       KVM: selftests: Verify guest debug DR7.GD checking during instructi=
on emulation
>       KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS Consis=
tency Check
>
> Hyunwoo Kim (1):
>       KVM: x86: hyper-v: Bound the bank index when querying sparse banks
>
> Jim Mattson (4):
>       KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested V=
MX
>       KVM: x86: Remove supports_cpuid_fault() helper
>       KVM: x86: Virtualize AMD CPUID faulting
>       KVM: selftests: Update hwcr_msr_test for CPUID faulting bit
>
> Kai Huang (1):
>       KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion
>
> Kevin Cheng (4):
>       KVM: x86: Widen x86_exception's error_code to 64 bits
>       KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK=
 bits
>       KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLAT=
ED bits
>       KVM: selftests: Add nested page fault injection test
>
> Krzysztof Kozlowski (1):
>       MAINTAINERS: KVM: Include maintainer profile
>
> Li RongQing (3):
>       KVM: x86: Fix wrong return value type in guest_cpuid_has()
>       KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
>       KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_in=
direct()
>
> Sagi Shahar (1):
>       KVM: SEV: Restrict userspace return codes for KVM_HC_MAP_GPA_RANGE
>
> Sean Christopherson (28):
>       KVM: x86: Ensure vendor's exit handler runs before fastpath userspa=
ce exits
>       KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking fastpath han=
dler
>       KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_DELIVERY_AS_PF_V=
MEXIT
>       KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS
>       KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #=
DBs
>       KVM: x86: Drop kvm_vcpu_do_singlestep() now that it's been gutted
>       KVM: selftests: Add all (known) EFLAGS bit definitions
>       KVM: x86: Remove unused X86EMUL_MODE_HOST define
>       KVM: x86: Tell ->inject_page_fault() whether or a fault came from h=
ardware
>       KVM: x86: Consolidate CPUID fault handling for emulator and interce=
ption logic
>       KVM: SVM: Truncate INVLPGA address in compatibility mode
>       KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hyper=
call
>       KVM: x86/xen: Don't truncate RAX when handling hypercall from prote=
cted guest
>       KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of =
64-bit mode
>       KVM: x86: Trace hypercall register *after* truncating values for 32=
-bit
>       KVM: x86: Rename kvm_cache_regs.h =3D> regs.h
>       KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
>       KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpe=
rs
>       KVM: x86: Drop non-raw kvm_<reg>_write() helpers
>       KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
>       Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions out=
side of 64-bit mode"
>       KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kerne=
ls
>       KVM: x86: Move update_cr8_intercept() to lapic.c
>       KVM: x86: Move async #PF helpers to x86.h (as inlines)
>       KVM: x86: Drop defunct vcpu_tsc_khz() declaration
>       KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
>       KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_C=
TRL changes
>       KVM: selftests: Add regression test for mediated PMU fixed counter =
filter bug
>
> Vishal Annapurve (2):
>       KVM: x86: Treat KVM's virtual PMU as disabled for TDX VMs
>       KVM: TDX: Allow userspace to return errors to guest for MAPGPA
>
>  Documentation/virt/kvm/api.rst                     |   5 +
>  MAINTAINERS                                        |   1 +
>  arch/x86/include/asm/kvm_host.h                    |  27 +-
>  arch/x86/include/asm/msr-index.h                   |   1 +
>  arch/x86/kvm/cpuid.c                               |  21 +-
>  arch/x86/kvm/cpuid.h                               |  20 +-
>  arch/x86/kvm/debugfs.c                             |   2 +-
>  arch/x86/kvm/emulate.c                             |  22 +-
>  arch/x86/kvm/hyperv.c                              |  26 +-
>  arch/x86/kvm/hyperv.h                              |   4 +-
>  arch/x86/kvm/ioapic.c                              |   2 +-
>  arch/x86/kvm/irq.c                                 |   4 +
>  arch/x86/kvm/kvm_emulate.h                         |  17 +-
>  arch/x86/kvm/lapic.c                               |  28 +-
>  arch/x86/kvm/lapic.h                               |   1 +
>  arch/x86/kvm/mmu.h                                 |   2 +-
>  arch/x86/kvm/mmu/mmu.c                             |   2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h                     |  36 +-
>  arch/x86/kvm/{kvm_cache_regs.h =3D> regs.h}          | 198 +++++++++--
>  arch/x86/kvm/smm.c                                 |   2 +-
>  arch/x86/kvm/svm/nested.c                          |  46 ++-
>  arch/x86/kvm/svm/sev.c                             |  12 +-
>  arch/x86/kvm/svm/svm.c                             |  34 +-
>  arch/x86/kvm/svm/svm.h                             |   2 +-
>  arch/x86/kvm/vmx/nested.c                          |  39 ++-
>  arch/x86/kvm/vmx/nested.h                          |   2 +-
>  arch/x86/kvm/vmx/pmu_intel.c                       |  10 +-
>  arch/x86/kvm/vmx/sgx.c                             |   6 +-
>  arch/x86/kvm/vmx/tdx.c                             |  52 ++-
>  arch/x86/kvm/vmx/vmx.c                             |  40 ++-
>  arch/x86/kvm/vmx/vmx.h                             |   2 +-
>  arch/x86/kvm/x86.c                                 | 374 +++++++++------=
------
>  arch/x86/kvm/x86.h                                 | 134 ++------
>  arch/x86/kvm/xen.c                                 |  39 ++-
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  .../testing/selftests/kvm/include/x86/processor.h  |  29 +-
>  tools/testing/selftests/kvm/lib/x86/processor.c    |   2 +-
>  tools/testing/selftests/kvm/lib/x86/vmx.c          |   2 +-
>  tools/testing/selftests/kvm/x86/debug_regs.c       |  88 ++++-
>  tools/testing/selftests/kvm/x86/hwcr_msr_test.c    |   9 +-
>  .../selftests/kvm/x86/nested_tdp_fault_test.c      | 313 +++++++++++++++=
++
>  .../selftests/kvm/x86/pmu_event_filter_test.c      |   6 +
>  42 files changed, 1116 insertions(+), 547 deletions(-)
>  rename arch/x86/kvm/{kvm_cache_regs.h =3D> regs.h} (59%)
>  create mode 100644 tools/testing/selftests/kvm/x86/nested_tdp_fault_test=
.c
>

