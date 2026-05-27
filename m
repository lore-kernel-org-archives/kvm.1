Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C545106F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905448; cv=none; b=ZILVedesNKCxQvKs7Ema4SRSeXyjBbhsmC6VrCjfzKFfWcGu+raBE5eQy/yinZjMe2TPj6sGqtSpiLnGULbV6a7ZAoVf7xMLyAt4AUZ1U6FGEK4p0CPl/Oo4gVyrPmITXgzLy6IQNwfuwWr+UVs0y9pivdzbHjxyx5x5CkLum9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905448; c=relaxed/simple;
	bh=rK3eMqXvlmkE4Pjt2r2+sASWJ8/3DjEyjimgFLFp95E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JD3MD6d8jmM1txHe+tDqEP3Y9/Wk/DtcDUPqkoQuvj/xz57SjAXO/tLfxVPNH158PWCUnYsgTbwFi+t9R2RZU2guhPROAhZsfyJpcvOI7cHz5e5hgWsg4pIl07s811VF+lMGTTMk6M4DeKrmQlEFcoMmRkCRDl4kc59789hB7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrX/+Xe9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrX/+Xe9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828ab3b033so15044529a12.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905447; x=1780510247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBJ6gsmL3hW3M8POWfjl7CfZ6yCqSQxL6g0RLzRHs1A=;
        b=DrX/+Xe9JwlElf/7eI69a9i0eCl3Mq34ZbpbhMtxtw5IiO3wYT3rtVdXepHpLIpMH7
         V0G9+NMhgRFh/nVoyRTrLdHHLK6NQEuv6M271Z0F3jso1G4DpS0+iU4kSQnBjIfg93ex
         QTkHw/f6J9AEuIrhDoT5kOqNVjt/IarI/M6S19tikCv2H0B87u8mMJwM/stqWlsi89TC
         PVyV4jFU/r4c9/r7GKU42ySTxpiwvEZwG5o0FEfNHbRvueUAbH3sKsyBjI0BIOp2YcTU
         rJsAYMteNVBmtx2yqcZD3gXbSf6kjn/gbEkdoLES0kvs0x59tXIQy4bUGwZ9Q9RIsTkz
         jczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905447; x=1780510247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBJ6gsmL3hW3M8POWfjl7CfZ6yCqSQxL6g0RLzRHs1A=;
        b=QGeGs2SehHspppPBBXxJTgOVXh3zlz+9myhXr1dV/69M6xsjOY52lvQUj/JwgxRHtW
         wzld2+RXxy7ItLkSDPZNmodxH222d+NdRM2JmK0Z3iUYZPsilNw5Lr4vl0SYC0BM7ass
         bDsnv7IFXYnW+ZC9dpddF5+A3wKzQNSxzkySZ6Ei8rsZ2AQAE/Rm0dIAitEtgbWUEfK/
         NHOCg0GceVBPN5AbSALy+alvfMw/94/9Z/dJupubXSE+Mw2oEwWKcDbBYtw6khpVBuha
         +KFONeeUEH2qcYLWbYA9PMO9W2vD2KiLL7C6aZrT3NvpeMah4Qkwk3SGFiGNHTNP2/l8
         yg9w==
X-Gm-Message-State: AOJu0YwK/UbNffSqzkKFTpZP4IA20IxhgsRsCKHQIf2C1y7Wj8w6ujLK
	OrfVt6ZjTn9EdmMp9aKlymQ5gee21XqRHNtiPRjlyUahz+EMTF7MygDxzsXQngJ+5cGv7tGgvBG
	2nf69Ew==
X-Received: from pge23.prod.google.com ([2002:a05:6a02:2d17:b0:c82:7a06:d5f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c89b:b0:3a1:f82e:b009
 with SMTP id adf61e73a8af0-3b328d15f2emr25290340637.18.1779905446430; Wed, 27
 May 2026 11:10:46 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:06 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990537895.4122831.14390256221703933313.b4-ty@google.com>
Subject: Re: [PATCH v3 00/10] KVM: x86: Improve #DB handling in the emulator
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 15 May 2026 15:26:28 -0700, Sean Christopherson wrote:
> Hou's series of fixes and cleanups related to #DB handling in the emulator.
> 
> v3:
>  - Fix the GUEST_PENDING_DBG_EXCEPTIONS.BS consistency check issue by
>    stuffing the VMCS during injection, not during emulation.
>  - Drop a prep that is no longer necessary.
>  - Massage a few shortlogs/changelogs.
>  - Fix the selftest that takes an IRQ in the STI-shadow after IRET.
>  - Fix an intermediate bug where kvm_queue_exception_e() was being used
>    instead of kvm_queue_exception_p().
> 
> [...]

Applied to kvm-x86 misc, thanks!

[01/10] KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
        https://github.com/kvm-x86/linux/commit/c5bad4fa2d5d
[02/10] KVM: x86: Capture "struct x86_exception" in inject_emulated_exception()
        https://github.com/kvm-x86/linux/commit/17afe9b750f2
[03/10] KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction emulation
        https://github.com/kvm-x86/linux/commit/dfc1c4687e9c
[04/10] KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when emulating MOV DR (in emulator)
        https://github.com/kvm-x86/linux/commit/51543660c521
[05/10] KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking for code breakpoints in emulation
        https://github.com/kvm-x86/linux/commit/00b6520669bc
[06/10] KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into kvm_inject_emulated_db()
        https://github.com/kvm-x86/linux/commit/6d79302b0834
[07/10] KVM: x86: Drop kvm_vcpu_do_singlestep() now that it's been gutted
        https://github.com/kvm-x86/linux/commit/a1e7aeb1be11
[08/10] KVM: selftests: Add all (known) EFLAGS bit definitions
        https://github.com/kvm-x86/linux/commit/35c08038cbdc
[09/10] KVM: selftests: Verify guest debug DR7.GD checking during instruction emulation
        https://github.com/kvm-x86/linux/commit/063a22451fd9
[10/10] KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS Consistency Check
        https://github.com/kvm-x86/linux/commit/b8284279b732

--
https://github.com/kvm-x86/linux/tree/next
