Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703572;
	b=pohbekAkjRC7uJAoiVFBHCSYSBd5g5rVWN+uuuKPIPAlAs8NCfoY9KUSiqJuA/bWTA56
	 DDkn/XU+cetIjH0GqxMFqMJ/S7zttUoqa6A7Nrt0hXBXd/XDymbDKzzaKPcm2vaVJO9jY
	 397ZLn7Ar7s6fTboxGz9D/4x/Xa8CyCp8DpBn5/0d+c69zbzhzsV5kl1XMsDE7Xpa/3BM
	 m0uWpvzT6esLb6EyFRvRzwf4y0w/vktD5POCGq66E7zXAzxCX5M6hofWbPD+LD7lUNokh
	 TdcQqV6VO/1KdybghcSDeW5qYbWSIVAFt8WvI443ldwpX/iIVxOELJnGC67atf/H/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:Subject:Content-Language:From:
	 Content-Type:Content-Transfer-Encoding;
	bh=WlgiEtRkCWU1xhIvVqFoxfWbh/BoRWRPi2HkiGC3rys=;
	b=aLInU529RppN8DPl9gdPnQCGE2ScjqXyNY1IhjZySxlFqvFduLahcKyqCrGTnhuLZ9v5
	 LGI0r+EqpcANQjS7ufsqa5Be1B9SB9WIl+VT2gyAxSgnbyfh5gc/5h0TWIL8uF5xGOlJb
	 o+S4UpKpRvu3qo3Q0+ZqPJxwa0rlDak31kFeTEzexxJI4rbgCODEfL856vdEc5cY75+VJ
	 +wbwAuprz5FowgNjYgjNp6uKJB+zm2nwakcAEDptNezkEGajJqTJ5iPmDMBEW9mjNMzz+
	 WWVKYKhnYrpeEYd5NJPOCzQ5pzXDpWmEimETNhRs6e3QSwgJZ9AiIWeCKv7Sfzr51NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="gYKwrl/E";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00494606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00494606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gYKwrl/E
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso2264775e9.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792703570; x=1793308370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WlgiEtRkCWU1xhIvVqFoxfWbh/BoRWRPi2HkiGC3rys=;
        b=gYKwrl/ErmcNRW+Hl0rekl2IV6ZRmuefESzcXd3YOq03fOomKOOzEoNNsvHEywHKpJ
         AC3Dtx9LO2kt/Ll5QxP2+2WzNyyi/YAx3SUeHmykDQKijM6G+Kgh7NNoErk8CVBGHv9f
         WKtyYp+bPbzTo4aJD5GvSzE2NjXXjDt9f0XxDFIAA6GarSqIXAGnNXGQmMTn3hXtj6oQ
         mVCSluKc+Cz4sBYDojw0EksdaI/d2h6Yt6/Fd4Lnvpt3Ekn/pHfjIyUy8tWOLZkZtYSl
         RlOTZNjNDE3AMbu1Y0ptsw+YWQOs6V1MhBg737Itg9JlWIiapJDrUjTHNNTNk7ebLvSU
         4b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703570; x=1793308370;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlgiEtRkCWU1xhIvVqFoxfWbh/BoRWRPi2HkiGC3rys=;
        b=rtBdf5MpSpgydBSC8/7oYcSKxLoE+06m1OQKQiopmPOJ7i+tvvfhBiGZFGrD6F8IwN
         GHTzla4FdWnwb7oYqVyGzwQ9YxeIneLuXBGTw30erzXnj2drwdZsQ5jbzvfVofuVE8L3
         feo5uxLEwHtDrW3P012860QolaQR08QxPwbkpy68MimxDIbnh/RqCvgd/H65+SE6I2/D
         NJlV7FKJSAmsX7liITGqCsfN9p3lIz7otb80X5PpFR+NlaXw8YFoPwl1BPVBFnKm7Mjj
         MJpyh5D3A3fj3jlZ51hFGT/fSFXHf/sr/cSP2fL6H5IZpJizP7zVed6xE9o5upHyL3Zt
         OCXw==
X-Gm-Message-State: AFq9FYL5Vxf81yacCN2a510JxmdPhFS/MSf6l4EObewElmGeWvGC7yBf
	jBuWWvNFhwMN/nGR6zrHahMartoI7GQYcupxuvUNuTE956QfGRMA0BgekgU57TU7
X-Gm-Gg: AYBFou2BK3lqa5GFVXTyHVrR6IUtIMj0USsTJcEDiOj3bfbeYmKsvvmPcgewPXubaUD
	Mg55WDY9fML9MG39BXkrWfGPrcUJLRFIbnl+oRaV2z+2eIAc5FEZnQDOyBMxA0g4ZYMFYRjeJ4v
	V0vmZEHsz2LTAbHMP9ZgAiP6KQsKAKFOTI8scEPZOSsPK1pm21kl8Y6DbQXGV+TCPt7TuC+qgGx
	dh9OoMcIwo0Ed0pZCG42AogfRJJu6suVS88pgKnKlZda0zO0D5mxBsEpDM2jXtrkvqVEvXPkcf+
	GpgyF5yKN43VZByUFxT4FiCB4PCndl7ldm+Y02DznMyyrsNJZCQf9pUnMB2vP3xyjS7Cx1Qi0f1
	JRHjiTSP/FrpmiPpANPpZT232ZGhRY2M96jQdyTvxhwnlYetUMtrSStghuykUuK8ApJNP3Ss7sX
	T1bg26Fx7kVdOJ/TN3LkzRItED1MYMtbdiE0IWS4fEIuZCXjg5H0zUsRC2TR0bTYJ470EtHns/t
	teefW0Xp6xJv/O7/s+oxhDw2+6248PoShBw1mThqoTTJQ2CZS2cZ23A8kZVDGeVdMwmSQ15f3hx
	NbTwdcbdUdcBO0fJFE7VXsxO5l2tY208hG/kk0L9MK/CPIluMrXRnKSvEeboXYv6sZ9Yg1MheOA
	Rp7K/VtTgyTyThBMyNP2X9jcWQfcvRFU/QbF1
X-Received: by 2002:a05:600c:8b38:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a211cbaf90mr3986765e9.20.1792703570283;
        Thu, 22 Oct 2026 14:12:50 -0700 (PDT)
Received: from [172.16.56.234] ([87.190.40.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b899ccsm9084735e9.3.2026.10.22.14.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:12:49 -0700 (PDT)
Message-ID: <bce8e397-6d8c-4816-b147-4830abafeaa9@gmail.com>
Date: Thu, 22 Oct 2026 23:12:49 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Subject: [BUG] KVM: nVMX: emulating SMSW/LMSW/POPF/PUSHF for L2 injects a
 spurious #UD (vmx_check_intercept default)
Content-Language: en-US
From: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Reporting a nested-emulation fidelity bug (correctness / KVM-vs-hardware and
VMX-vs-SVM differential; not memory-safety). It appears to be the same class
the stalled series "KVM: nVMX: Synthesize nested VM-Exit for supported
emulation intercepts" / "Consolidate missing X86EMUL_INTERCEPTED logic in L2
emulation" (v2, Jan 2025) set out to fix, which has not landed; v7.3-rc6 
still
carries the stub. Sending a concrete, reproduced list of the reachable
instructions in case it helps revive that work, and a minimal stop-gap.

The defect
----------
The x86 instruction emulator has no notion of L1 vs L2; all nested-intercept
fidelity is delegated to vmx_check_intercept() 
(arch/x86/kvm/vmx/vmx.c:8190),
which is a partial stub ending in:

	/* TODO: check more intercepts... */
	default:
		return X86EMUL_UNHANDLEABLE;		/* vmx.c:8272-8274 */

For an instruction VMX does NOT actually intercept, the architecturally 
correct
answer is X86EMUL_CONTINUE (let it execute), not UNHANDLEABLE. SMSW and 
LMSW are
decoded with an intercept hook (emulate.c, II() -> ctxt->intercept =
x86_intercept_smsw/_lmsw) and the hook is consulted whenever 
check_intercepts is
set, which x86.c sets precisely for L2:

	r = x86_emulate_insn(ctxt, is_guest_mode(vcpu) && ...);	/* x86.c */

So for L2, SMSW reaches vmx_check_intercept() -> default -> UNHANDLEABLE 
before
em_smsw runs. UNHANDLEABLE becomes EMULATION_FAILED, 
handle_emulation_failure()
queues #UD unconditionally, and the CPL0/userspace-exit escape hatch is 
gated on
!is_guest_mode, so L2 is resumed with a spurious #UD pending. For L1
(is_guest_mode false) check_intercepts is false, em_smsw runs, and the
instruction completes. SMSW merely reads CR0[15:0] and has no VMX intercept
control, so #UD is architecturally impossible here.

Reachability: L0 only runs its emulator on an L2 instruction that faults 
to it,
i.e. a memory operand resolving to an MMIO/unbacked GPA, which L1 
controls via
EPT12. No privilege beyond running a nested guest.

Reachable instructions (reproduced, fresh VM per arm)
-----------------------------------------------------
Confirmed at runtime on BOTH vendors (Intel 7.3-rc3, AMD 7.3-rc2):

   SMSW   #UD on VMX,     clean on SVM   (II SrcNone|DstMem|Mov)
   LMSW   #UD on VMX,     clean on SVM   (II SrcMem16|Mov|Priv; also has 
a real
                                          selective-CR0 intercept to honour)
   POPF   #UD on VMX,     clean on SVM   (II ImplicitOps|Stack)
   PUSHF  hang on VMX,    clean on SVM   (store re-faults the injected 
#UD until
                                          the watchdog), clean on SVM
   IRET   fails on BOTH   -> EXCLUDED (vendor-neutral emulator 
limitation, not
                                       this bug)

The VMX-vs-SVM split is the root cause made visible: svm_check_intercept()
initialises ret = X86EMUL_CONTINUE and returns it for anything the 
nested VMCB
does not actively intercept (svm.c:4852), whereas vmx_check_intercept()'s
default returns UNHANDLEABLE.

Suggested fix
-------------
The general fix is the stalled series (synthesize a nested VM-exit for
emulated-but-intercepted instructions; CONTINUE otherwise). As a minimal
stop-gap, add cases to vmx_check_intercept(): SMSW -> X86EMUL_CONTINUE (no
intercept exists); LMSW -> evaluate the nested CR0-load/selective-CR0 
intercept
and either reflect a nested VM-exit or CONTINUE; PUSHF/POPF -> CONTINUE 
(no VMX
control). SVM already models all of these.

Reproducer: an EPT12-override harness points one L2 instruction's memory 
operand
at an unbacked (MMIO) GPA and runs it; a MOV control through the same 
fault path
emulates cleanly, isolating the instruction as the sole variable. Happy 
to share
it or test patches.

Thanks,
Amirmohammad
