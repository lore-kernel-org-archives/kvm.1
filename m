Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674484;
	b=MEn9/WwtQxcasOzb01aNi6xVWgT+uu0CUpOHx8OfZWt/BMW42bHfHD0dzQ1CrrRF/X9n
	 nWNBskZaB+r/TIh2rw009rAHBU2xp0Uur27o2tjjMf0zZ6/AAKymaAwkUrqV3ehglW9YC
	 /iWyuK/RMOYpmMWTH4tYEwDGGi/DL2VUvxM5zJeFkm1vxeAYoSFCFYizzoN9NDivBv9ML
	 t7JkECc2G/vHuDSnkqkZEYO3eZ1+W5juO/UaHyyWs9lXbk9udKp9HTAyc+5UHd0+CYVp4
	 2kl7KQDwzkvaiueh2ukSeFlGLT0pGrONeKlMQSbf4XUKWSurDMbmhCwl8BfKQFaLH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674484;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SL/9BqwXQ1smjQ8E6Msd4QxEECfasLYq3RnEmyX4hN0=;
	b=JS6tnq2eKJCmLuuqp7t1EhKEaOFqGmvUCpf2lgSbQrgJKBXQCZxusgkRfXG9yY3FtLv9
	 Y/W6hZqN7BEVAJtyoUIfAb6I7JIdLLmKYz8QMGYRPJD2skCS2abnbfrGkkkG4losq+bjB
	 o+/aTvYBHKpGBlcNDrA5NKEq9yxJCuoU4/nEqa/FEQjXL4lMEOrpUWxoKRtzHl7SGgMNr
	 GaUYgFp03K4JsNB9RhjaqQKPYpNIWkO8kwjB5hgoc70XE4S6EswltHodtoxKmsWvnmyxY
	 TILzxWNC1PYHuuQZUJAXjPy6eGW9wXtihBfdIks6BJ8dAPLLyh1YQAdeEdWRIsCuy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyRJ+UHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A9606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyRJ+UHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374751F000EE;
	Thu, 26 Nov 2026 06:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674483;
	bh=SL/9BqwXQ1smjQ8E6Msd4QxEECfasLYq3RnEmyX4hN0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CyRJ+UHfrujoYV1CnhdY6I82mdVm7GMuGABjjdFrVW2p7cEixoFmO8FtRd6RxZMls
	 qRfAv5ibdP6uCbDkWVlwy2x/wJoYj6N6z2mfvUq3r25fCxqoG6G+/MaV7Daaz8y9m+
	 Dn3q6C2E2fy/AezCPmWxUhPvNeq062hwKixExIRxDqHleURQPOFjjO8RxcMRs5v/ca
	 goCfOxlo+86tNvAXpbqUlQOAOOZqEY5Gbw7AXEqgbo5tUQkqq29+mHTPZjZ5n0UI0D
	 epu8rhcD3K3Il8h1kH0kwkYbtXyNJnZdsbFTa95KuBn/uCZIttd2YqcD13hTF7biTk
	 3L61IpB1ER12w==
Message-ID: <sashiko-outbox-234852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] KVM: x86: Add support for cmpxchg16b emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261126060515.2198-3-sarunkod@amd.com>
References: <20261126060515.2198-1-sarunkod@amd.com>
 <20261126060515.2198-3-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:28:02 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: x86: em_cmpxchg8b() returns X86EMUL_UNHANDLEABLE instead
  of #UD
- [Medium] KVM: x86: em_cmpxchg8b() checks CPUID after destination
  memory read
--

commit 98ac1f736784d209fed9239b44c3756356d76e28
Author: Sairaj Kodilkar <sarunkod@amd.com>

KVM: x86: Add support for cmpxchg16b emulation

This commit adds 128-bit CMPXCHG16B emulation support to em_cmpxchg8b()
and emulator_cmpxchg_emulated(), and checks guest CPUID for
X86_FEATURE_CX8 and X86_FEATURE_CX16 before emulating CMPXCHG8B and
CMPXCHG16B.

[Severity: High]
In arch/x86/kvm/emulate.c, em_cmpxchg8b() returns X86EMUL_UNHANDLEABLE
when ctxt->ops->guest_has_cmpxchg8b(ctxt) or
ctxt->ops->guest_has_cmpxchg16b(ctxt) returns false. Should this call
emulate_ud(ctxt) instead, like em_rdpid() and em_movbe() do?

Returning X86EMUL_UNHANDLEABLE translates to EMULATION_FAILED without
queuing UD_VECTOR. Because group9 marks em_cmpxchg8b with PageTable, a
write to a shadow-protected page table calls
kvm_unprotect_and_retry_on_failure(), unprotecting the GFN and re-entering
the guest to execute the withheld instruction natively on the host CPU.
For non-page-table accesses such as MMIO, handle_emulation_failure() exits
to userspace with KVM_EXIT_INTERNAL_ERROR when running at L1 CPL 0 or when
exit_on_emulation_error is enabled, rather than injecting #UD into the
guest.

[Severity: Medium]
Also in arch/x86/kvm/emulate.c, does checking guest_has_cmpxchg8b() and
guest_has_cmpxchg16b() inside em_cmpxchg8b() perform the CPUID check too
late?

In x86_emulate_insn(), because ctxt->dst.type is OP_MEM and Mov is not
set, segmented_read() linearizes, validates, and reads the 8-byte or
16-byte destination operand before calling ctxt->execute(ctxt). If CX8 or
CX16 is withheld in guest CPUID, executing CMPXCHG8B or CMPXCHG16B on an
MMIO address exits to userspace with KVM_EXIT_MMIO to perform the read
before checking CPUID, and an unaligned 16-byte address or unmapped page
injects #GP(0) or #PF instead of #UD. Checking the feature in a
check_perm callback (with CheckPerm) would ensure #UD is raised before
any destination memory access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060515.2198=
-2-sarunkod@amd.com?part=3D2
