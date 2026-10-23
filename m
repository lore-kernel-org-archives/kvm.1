Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775701;
	b=aRGmeS0qW0fI2NRGwHqbmGQRxeY5+gFjjdmneOh/bG/4+qsAJIMgCYeDrpZlDmYIi7rM
	 6gsWngZPpmcw1hd53cy17LOYrqJOn3AtMjqJ3y3w2+yTuybw4+GVhRHf0qEpU9fpTu5pt
	 mGTK5dD/MC2UzqbD9Y7c1Vu3ga0Okh41+1gB15uNm/4Lq2xaMpS/bMC3j6EwlnkWccvqz
	 UYjLTinwzdDdhiek9EPzpiCWKMmNT7QJT/oKvZu8cARU89qCnxE5XO1+ZBupFKjeFNoJo
	 YPE7aBwiRt3gWO3wLNzD7qOmTGa+BEGQpcA7oTEEGn7Z+JK4koz4YAT3nqwEQJbRZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775701;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=PSMamqooMg61vJdbSpJlmucu4wryIKpU8Ww25uB+4NE=;
	b=KjCKduEHAPzbUyYVGQrnGstC5i4vgcYgSPguYwlKC2G9pcFw9h19zL3xR0xjmh9gNLkk
	 iFKkfI1NIqdvw6kRBeSRi+47RIvqBzwKfmFGq9pL7YriSxooWg+TtwlOEJKlN7baz5uKO
	 LOtJCQ9N2besHLXz2Q2pDVDL/SSEvJ5yzoajeyUdXWM0+RwHeV7AZB9DCcbVtjOVmsx4g
	 /g1pXJJ55HH9roUoLvV94rlY4Hk21hNfGaCFhT+G056Wf493hqMuIvZbA1cUtLAHdAzSP
	 Cvxt2JUaTqxDf3mFNpsIxNOel1BfGAHMzoktvp/Jz2a7H/ARFSTxskU2VbCajuPOMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=lAF6D+1e;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1A606A31D;
	Fri, 23 Oct 2026 17:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E1A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=lAF6D+1e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PSMamqooMg61vJdbSpJlmucu4wryIKpU8Ww25uB+4NE=; b=lAF6D+1eIMQMDK5xtoOirYs3Xw
	fnsaRK/4k8CgyAF+mWPoVW42D2xFP0mj2lODUkyvkQSV8IQJbsnLaGdulCUUMd8cy16NEoS3zuHHD
	U2b/tZgH+ghUSqn/+u2UwkyqBrESTFLan99gsJeVuvDWOWBY7qVwOHNutI1wk5Qa15U2Kz5mcez4V
	IHZgty3sTJOWSCFtaPBJmyF+C99BMwdEmTOdByzePUgN938n1xZb5qlnc/0rfSrQcH+MAkmQF6fSZ
	cQJFwBX7JRR8vh5YqVc0ZFpq5QYTIlbIjL6AjFcul95Ni0XXrthQtKATPI+Lqa5TB0apdbeqje7vx
	j79wvD1w==;
Received: from mailer.gwdg.de ([134.76.10.26]:59957)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIr4-00Emxv-3C;
	Fri, 23 Oct 2026 19:14:58 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIr4-000MM1-1p;
	Fri, 23 Oct 2026 19:14:58 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 19:14:57 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>
Subject: [BUG] KVM: nVMX: emulating SMSW/LMSW/POPF/PUSHF for L2 injects a spurious #UD (vmx_check_intercept default)
Date: Fri, 23 Oct 2026 19:14:37 +0200
Message-ID: <20261023171437.637799-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-SUB-05.um.gwdg.de (10.108.142.70) To
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

