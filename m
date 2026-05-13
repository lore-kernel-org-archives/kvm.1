Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE83CB8F5
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714057; cv=none; b=WoR4sa1rt8C45blchpEZRmyB3ns3XGXOf4huJDIMthIgYS//nL6ScLuFDd3Bhu3ZON3cjSM4SQEG0gvnYZJLQap9VmFI/pEEEvG3nzfrrW5Wv0LCeht/M+7ph9a285onyFb3cRudNvkdwrf/jJs2FC9qourTpuofIBit+WVEEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714057; c=relaxed/simple;
	bh=sa3MU5hP47nUdEGWyqAw1QOWRSRun/RHMRIVSWeqHIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I35VTMJ8E2GVlT8x8NCfVAB9jAvqsOMKdV3CNczAqzRkNn8w+FMM39UBcXRBL6jwakBNkV6+ZM1XFzjGM7JNnhtJWs/t93reQ58VrSt3u1sZ0z9JPU4/KTqJXX2pMUCHkIIP0kyOD6PbfirYkZqTL3uq70J4drZtSlfSIPTvQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyY0YC7v; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyY0YC7v"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36629e48023so7830974a91.2
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778714055; x=1779318855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZROrOwy5J7pzI1auvv9ygqqn1CxMDUVxMMwN7QUYwo=;
        b=EyY0YC7vSNmq8ALtwiwezfZ9xFheIpTvLlOk08vGUxMDTTAUP2OiroHad2jDaTKOTs
         20XNCCjQYXq4aVSAvq0SlQdb7DazS5SFBMwtXoI/qrdxoP/ed1ET4Qrh+cW1G6SszvQ0
         QA6uJgo9NJztNrnPpcPZBExV2qLmV/+XAGERG1a1MAKlvf2x9jRWEBF/fVkLDGGHRbN1
         v/LjVMAc02KcS/wIkQGKfKSXVNk94IKsY3uMBbrpdWjcCrA/2Lm9y6tX9SjLvyMvnkk8
         OxM39W9Ub6NT7HfwJaELfZAoYwq7OrCCL9Desq8u2zos4ByP5GCdyiMxE396QJfsibEy
         0GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714055; x=1779318855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZROrOwy5J7pzI1auvv9ygqqn1CxMDUVxMMwN7QUYwo=;
        b=eh2kLn177iiQE6A9KiVA91pqjmF1FfEHU779J1UslwPcELDdVBvdTzylFlNNgIhocA
         50CQ5a0Kvt6ezcKwpBNgD2gfX9zrP48vhY05KXJH2FU5aytwLSvaDBOE8eiegbC0HlRp
         cfpOszVMvSTKRCJ+ObJ3ze8fKGtqn+QmqwH7nImBgPHw1dGXVZ0NORmRIICwSb9FouFs
         97I204SHjRlXGasIggDLWFnqL55dKHt1C0z50uMoAjpKUQzAV6zY7kRD8t1lNo5SrLUt
         y404IxWUJ0nS7Lyp34cID7boUHxz7H/LlRCqrDVmdSWGpqgtXL7SfRWqGHN+r/KeHnY0
         6ftw==
X-Gm-Message-State: AOJu0Yx3MB7pCUsoaaTErDGBXHfLJCyKlOkw218aXVJI4HToVQC2FQ0d
	bOoKDj4SGVrTffxi8RB0UAOG/DrW5IX0TSI8v8ypwMLojnOTDAfR3TP5sVsA3u2fntYyBf82BQp
	G4lONrQ==
X-Received: from pfbfa8.prod.google.com ([2002:a05:6a00:2d08:b0:839:9ad:ee32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:3aa:c93b:6266
 with SMTP id adf61e73a8af0-3afaf61979amr5920299637.19.1778714054962; Wed, 13
 May 2026 16:14:14 -0700 (PDT)
Date: Wed, 13 May 2026 16:14:14 -0700
In-Reply-To: <e0df5d6812da0f508cdf697ac7627693199c8293.1766066076.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com> <e0df5d6812da0f508cdf697ac7627693199c8293.1766066076.git.houwenlong.hwl@antgroup.com>
Message-ID: <agUFxrpUhBRv54ZV@google.com>
Subject: Re: [PATCH v2 9/9] KVM: selftests: Verify 'BS' bit checking in
 pending debug exception state during VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 18, 2025, Hou Wenlong wrote:
> In the x86's debug_regs test, add a test case to cover the scenario
> where single-step with STI in VMX sets the 'BS' bit in pending debug
> exceptions state for #DB interception and instruction emulation in both
> cases.

...

> +static void guest_db_handler(struct ex_regs *regs)
> +{
> +	static int count;
> +	unsigned long target_rips[2] = {
> +		CAST_TO_RIP(fep_sti_start),
> +		CAST_TO_RIP(fep_sti_end),
> +	};
> +
> +	__GUEST_ASSERT(regs->rip == target_rips[count], "STI: unexpected rip 0x%lx (should be 0x%lx)",
> +		       regs->rip, target_rips[count]);
> +	regs->rflags &= ~X86_EFLAGS_TF;
> +	count++;
> +}
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	unsigned long target_rip = CAST_TO_RIP(fep_bd_start);
> +
> +	__GUEST_ASSERT(regs->rip == target_rip, "IRQ: unexpected rip 0x%lx (should be 0x%lx)",
> +		       regs->rip, target_rip);

This is wrong, and the test fails with your series applied verbatim.  The IRQ
will arrive at fep_sti_start, because RFLAGS.IF=0 from the CLI at the end of the
ss_start block, and remains that way across fep_bd_start.   And to make things
even more confusing, the IRQ arrives on the CLI even though it's in an STI shadow
due to #DBs not being subjected to _STI_ shadows on Intel, only to MOV-SS/POP-SS
shadows.  I.e. the #DB lands on CLI, pushes RFLAGS.IF=1 on the stack, and then
the subsequent IRET from guest_db_handler() fully unmasks IRQs, and voila.
