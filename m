Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804C303A0D;
	Sat, 17 Oct 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197232; cv=none; b=LVG5peI1jRMZflpg3pgOgZC1DkdCfbVisgNp+8rXo8snKrzKqorjgBfWjU3gb6yEfJRzusG2y5B4KsTRqSP9VHyusC/QuTFG0gNBogVTaiBx1cGFys6pQxVbViMYPLBfg7lWqEj3CW2DxAGdS7mocWJe1/m8tQAcsR019tMfh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197232; c=relaxed/simple;
	bh=zSTWZ4CW2D+GfrZjEwRQQk3khk9T1sEHPnXMvTZG0vQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJw5xnD6OKGizKceEdojaQ92EZEB0rlKhBQ03Lx4FlyYQiF51tfBzwdXDLqsfvtNmV7fH4OdGUhVzRSA2cvKDy/WIVmbXD8/nzbCCENHoSOl8lt+f2REKTKDfGcaA94bJ7JxFfPgbq0buyin0/lqUiJodWjEFlxHkq/r1XvK3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=mDuw8xeo; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="mDuw8xeo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PSMamqooMg61vJdbSpJlmucu4wryIKpU8Ww25uB+4NE=; b=mDuw8xeooVdR1/o4XMUq7ez1e+
	bEdggBiA63Wd0Rm/5wzGejzwpaUoThXiKhOiJyYT5rzVVxxfdMhVFuyIVRuevKIQHeF9On/+zL6w4
	urvdRXOx6sQlD6G/k+XVJdjDSXzX5qrz7i/YFBJ5WJxvl34nFkVMc4R1SLUjntFm5xxnc96c+n6Iu
	KT5XfA5mW8vRqLxQqRg8gwrZRmWTbhUsL5ASz8BTnGK89Z6Kk6qjkqTALSmW6Zt4SwvjkSbyqVzaI
	DSjAuCpi/2n5OP0OQzWFSkpaZOvcTQWpKpDt6kYzkmgEVZOtSr97ys65n+A/Vc+bOUuxUQtFneJ9Q
	nLhy9Xgg==;
Received: from mailer.gwdg.de ([134.76.10.26]:56451)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjM-00B5eW-0b;
	Sat, 17 Oct 2026 01:52:55 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjK-000D3R-2Y;
	Sat, 17 Oct 2026 01:52:54 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 01:52:52 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] KVM: nVMX: emulating SMSW/LMSW/POPF/PUSHF for L2 injects a spurious #UD (vmx_check_intercept default)
Date: Sat, 17 Oct 2026 01:52:19 +0200
Message-ID: <20261016235221.33726-3-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-sub-01.um.gwdg.de (10.108.142.54) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

Reporting a nested-emulation fidelity bug (correctness / KVM-vs-hardware and
VMX-vs-SVM differential; not memory-safety). It appears to be the same class
the stalled series "KVM: nVMX: Synthesize nested VM-Exit for supported
emulation intercepts" / "Consolidate missing X86EMUL_INTERCEPTED logic in L2
emulation" (v2, Jan 2025) set out to fix, which has not landed; v7.3-rc6 still
carries the stub. Sending a concrete, reproduced list of the reachable
instructions in case it helps revive that work, and a minimal stop-gap.

The defect
----------
The x86 instruction emulator has no notion of L1 vs L2; all nested-intercept
fidelity is delegated to vmx_check_intercept() (arch/x86/kvm/vmx/vmx.c:8190),
which is a partial stub ending in:

	/* TODO: check more intercepts... */
	default:
		return X86EMUL_UNHANDLEABLE;		/* vmx.c:8272-8274 */

For an instruction VMX does NOT actually intercept, the architecturally correct
answer is X86EMUL_CONTINUE (let it execute), not UNHANDLEABLE. SMSW and LMSW are
decoded with an intercept hook (emulate.c, II() -> ctxt->intercept =
x86_intercept_smsw/_lmsw) and the hook is consulted whenever check_intercepts is
set, which x86.c sets precisely for L2:

	r = x86_emulate_insn(ctxt, is_guest_mode(vcpu) && ...);	/* x86.c */

So for L2, SMSW reaches vmx_check_intercept() -> default -> UNHANDLEABLE before
em_smsw runs. UNHANDLEABLE becomes EMULATION_FAILED, handle_emulation_failure()
queues #UD unconditionally, and the CPL0/userspace-exit escape hatch is gated on
!is_guest_mode, so L2 is resumed with a spurious #UD pending. For L1
(is_guest_mode false) check_intercepts is false, em_smsw runs, and the
instruction completes. SMSW merely reads CR0[15:0] and has no VMX intercept
control, so #UD is architecturally impossible here.

Reachability: L0 only runs its emulator on an L2 instruction that faults to it,
i.e. a memory operand resolving to an MMIO/unbacked GPA, which L1 controls via
EPT12. No privilege beyond running a nested guest.

Reachable instructions (reproduced, fresh VM per arm)
-----------------------------------------------------
Confirmed at runtime on BOTH vendors (Intel 7.3-rc3, AMD 7.3-rc2):

  SMSW   #UD on VMX,     clean on SVM   (II SrcNone|DstMem|Mov)
  LMSW   #UD on VMX,     clean on SVM   (II SrcMem16|Mov|Priv; also has a real
                                         selective-CR0 intercept to honour)
  POPF   #UD on VMX,     clean on SVM   (II ImplicitOps|Stack)
  PUSHF  hang on VMX,    clean on SVM   (store re-faults the injected #UD until
                                         the watchdog), clean on SVM
  IRET   fails on BOTH   -> EXCLUDED (vendor-neutral emulator limitation, not
                                      this bug)

The VMX-vs-SVM split is the root cause made visible: svm_check_intercept()
initialises ret = X86EMUL_CONTINUE and returns it for anything the nested VMCB
does not actively intercept (svm.c:4852), whereas vmx_check_intercept()'s
default returns UNHANDLEABLE.

Suggested fix
-------------
The general fix is the stalled series (synthesize a nested VM-exit for
emulated-but-intercepted instructions; CONTINUE otherwise). As a minimal
stop-gap, add cases to vmx_check_intercept(): SMSW -> X86EMUL_CONTINUE (no
intercept exists); LMSW -> evaluate the nested CR0-load/selective-CR0 intercept
and either reflect a nested VM-exit or CONTINUE; PUSHF/POPF -> CONTINUE (no VMX
control). SVM already models all of these.

Reproducer: an EPT12-override harness points one L2 instruction's memory operand
at an unbacked (MMIO) GPA and runs it; a MOV control through the same fault path
emulates cleanly, isolating the instruction as the sole variable. Happy to share
it or test patches.

Thanks,
Amirmohammad

