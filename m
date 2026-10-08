Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE323E358
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419783; cv=none; b=OhXLOb/nwG5IFoTd/A2sc6iRbZ/8r5NvZWRnv0UvRiziwv9ovqbOACRkuwo4olXUF7ReH1TBqE2VhsKZln+Jh5uHuJiS5OShzZkAI9sQ7QTrCI3vsvf6BbKUifFsiuekMfd2UiSEYHUN98D50w+DaztW3Ewpfp29ve70PAr0zzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419783; c=relaxed/simple;
	bh=aFx54mfCfv/zvmMBXZ0fWHhVs+p/NITVM9bTxmI+WZ0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HBEfuo8KTXkBpwDdlF37Jkl/o0K+T8/LO1GDWmFf0uOImdaZ2XVVySJEyhDNri1I7eEtaqZ7UICwmvR1UWT2H9Oxjha1Ze2bQqxetF0PwZUtuQs8LQNauVVufgeb4MgqpLGsdF6hzG7Gsp5EmEiQRma1Ev1DOORlRjk5kpPrY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7Km2Hxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7Km2Hxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E214E1F00893;
	Thu,  8 Oct 2026 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419782;
	bh=aFx54mfCfv/zvmMBXZ0fWHhVs+p/NITVM9bTxmI+WZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7Km2HxfXAzrJ/pcXvoEqgRGGQF1s13VdSOaP4CdyrTeTP0OisET47WFQytczisK8
	 3wChAZ9AlbKCGTqJeQWuyzQeJNhbqHz/xUWmzL7Wwc0TlLzJHV8oNd12TaLwPIrDka
	 r/i33fgL7L1hp2GSTMStPP+dPYQwYz9ZH0zEMH8NyLAI5NsEnzXM3RlHmujPT3J7ep
	 /ARXJckVx8+uej0Tt1s1X2eTRlXffRKRHLxHozaWefoJYB9igI0MyUZDBk/ZTo6BLg
	 hy7BJ8l8FIL9hf6U2GH/neC2cOWsDlFf4WmHxl53s4t0fPjRui9aOl6mPS6XWXnRMi
	 Cv4G+X40w51qw==
Message-ID: <sashiko-outbox-163476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/29] KVM: nSVM: Handle nested TLB flush requests
 through TLB_CONTROL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-22-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-22-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:36:21 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: nSVM: Failure to clear vmcb12->control.tlb_ctl on nested VMRU=
N causes sticky flushes
--

commit a1eb425c937534a8aa46b2b08b4187a40adeac38
Author: Yosry Ahmed <yosry@kernel.org>
Subject: KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL

This commit handles L1 requests to flush L2 TLBs using the TLB_CONTROL
field of VMCB12. It triggers ASID flushes and NPT syncs on nested VM-Enter
or VM-Exit depending on the type of flush requested.

[Severity: High]
According to the AMD APM Volume 2, Section 15.15.1, the VMRUN instruction
processes the TLB_CONTROL field of the VMCB and then clears it to zero.

Looking at the implementation in arch/x86/kvm/svm/nested.c, specifically
within nested_svm_entry_tlb_flush() at line 710, the new logic requests
KVM_REQ_MMU_SYNC_ALL_ROOTS and KVM_REQ_TLB_FLUSH_GUEST whenever
svm->nested.ctl.tlb_ctl is not TLB_CONTROL_DO_NOTHING.

However, it appears KVM never clears tlb_ctl to 0 in vmcb12 during the
nested entry sequence, nor during VM-Exit in
nested_svm_vmexit_update_vmcb12() at line 1582 where other
hardware-cleared fields like event_inj are reset.

Because KVM fails to emulate the hardware behavior of clearing the field,
will L1 hypervisors that rely on hardware to clear it unknowingly reuse
vmcb12 with tlb_ctl permanently stuck at a non-zero value?

If so, does this introduce a regression that traps the VM in a persistent
loop of heavy MMU root syncs and TLB flushes on every single subsequent
VMRUN, resulting in severe performance degradation for the nested VM?

Could we add a step to clear tlb_ctl in vmcb12 to prevent these sticky
flushes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D21
