Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF25315793
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684351; cv=none; b=XsZTj8Swy5V7CZDHLCV5d7ZP5B4ZQUZReUA0nCMxoVZKibvXIbU7elGAK3gVmxn1ds4Te+ta1gRf28hQVpZ/tvmuav2SH40cnxc1h/tRoX/wAklwal7Q+k+Lz4ycvaBo0RBHQ5OVOYr0iUVCTLjscmXH9EKq6wtLRtTACs1F8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684351; c=relaxed/simple;
	bh=oC28JPutlh64bOfTBIc5LOvWBgilhOZUlAbzggwicNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZJUd2PZMibSCsV9dzAC8arLTIo4ykjUwVpTNqLh4p6eVQCSwrxLguJAKgDkZsBth/U2yI/HYUS5w8/e4VTpAeNIqLrXbGNjl/PCKRM6Hnz52a5e3ysPtxH8u5kVmzEl2KTc4eVU/KgXcrNCFsLnff5GkbFBt3xR3sMxFEnjs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR+jtSNS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR+jtSNS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso23825995ad.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684349; x=1781289149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls6ruD7N4CAjfMSAnAXlbnGflD1cFz7i5n4IhCKZF6M=;
        b=XR+jtSNSBmN1EnsXqi0fHdSBQiddd6owEkVU1kedIQd13lpUOidG5hzOXFrmkGMRWh
         n3IbGL/8hNU+tPc6hNc9FJbjrzmygs2e27a/3dbpqTsZjhklyGExCbkqBkJA9aLR8gvt
         LKYiGyt+0ZDM3CPvTgiiX92in+BbgYpGxELIj50lj+Z8cAsUf9mu4aVlk72vQ34g69U4
         Kas1ht2DQQ4ZPiW+T6hENcBZCN5Sc3xYvtI03R90illIyDsBUKyGM7HoojTarY3o21fx
         RscI3MAtwZ7SbH6CiJqH3cHd/ZKminXVXnsN9l2XPjwp0GkNOQMtJmNcvgTz5ALSzGAk
         ZCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684349; x=1781289149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls6ruD7N4CAjfMSAnAXlbnGflD1cFz7i5n4IhCKZF6M=;
        b=alvKORm2xY+jL3pVU4gsWcWpl3l4WUPTaHYuz/UhTyeIGTcfHOuyV3Tx0JWQjtssg+
         cEnmAEjMdYggNjddikDaf6PJt2LXUMpmY7K7TCpzMTUcdBQXkFB4gbcbGCxD5yMtVED4
         igbITNSuhot7bsHcq/p71+8H2htomPJP3JdDSk52+QHO7O9FHXtFJG/GsPnIPstjm+tq
         lIGyX5vRbsbgWM0L6NOIWzKGdlpqy+khxkyl+YFu3RRymwETdG6Or5L0c8J9NjFedmWJ
         D+EIPEI9TRugDO7Aw4UZM/MqkB967yKNeAcX/JHNF42lNyVYhbeE1kmGN6TWIX7hZi9A
         7xXg==
X-Gm-Message-State: AOJu0Yys4JJukuJAU/CqTozWsEzHSbJJjPvGguw/o8CeLDBLuDAneohf
	z/NxGdMF8gaSM7vG4E0wCQ0XodWPp8/RH+dw+3RMnbSxZSfChEbOWPzPCaiRKqW4nMmvpYwHiyQ
	TwnRr2A==
X-Received: from plba13.prod.google.com ([2002:a17:903:100d:b0:2bf:106:cced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b46:b0:2b2:5314:e96a
 with SMTP id d9443c01a7336-2c1e80fc534mr49566675ad.34.1780684349289; Fri, 05
 Jun 2026 11:32:29 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:47 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068415433.2235944.8637145698851556293.b4-ty@google.com>
Subject: Re: [PATCH v3 00/40] KVM: x86: GPR accessors and x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 29 May 2026 15:21:43 -0700, Sean Christopherson wrote:
> The first half of this series adds proper, explicit "raw" versions of
> kvm_<reg>_{read,write}(), along with "e" versions (for hardcoded 32-bit
> accesses), and converts the existing kvm_<reg>_{read,write}() APIs into
> mode-aware variants.
> 
> At the end of that journey, introduce regs.{c,h} to avoid moving _more_ code
> into x86.h, especially since the resulting code split would be super arbitrary.
> 
> [...]

Applied the cleanups, and two one-off patches, to kvm-x86 misc.  I'll send a v4
for the code reshuffling, targeting 7.3.

[01/40] KVM: SVM: Truncate INVLPGA address in compatibility mode
        https://github.com/kvm-x86/linux/commit/42a842f3f6b9
[02/40] KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hypercall
        https://github.com/kvm-x86/linux/commit/09912b8ad22f
[03/40] KVM: x86/xen: Don't truncate RAX when handling hypercall from protected guest
        https://github.com/kvm-x86/linux/commit/9377016c2f9e
[04/40] KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode
        https://github.com/kvm-x86/linux/commit/f43caad54cc0
[05/40] KVM: x86: Trace hypercall register *after* truncating values for 32-bit
        https://github.com/kvm-x86/linux/commit/16b5d193b212
[06/40] KVM: x86: Rename kvm_cache_regs.h => regs.h
        https://github.com/kvm-x86/linux/commit/ece08316ca21
[07/40] KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
        https://github.com/kvm-x86/linux/commit/ed8a7b89c504
[08/40] KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
        https://github.com/kvm-x86/linux/commit/fc40b1254c32
[09/40] KVM: x86: Drop non-raw kvm_<reg>_write() helpers
        https://github.com/kvm-x86/linux/commit/308851c2d6f8
[10/40] KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
        https://github.com/kvm-x86/linux/commit/a7e6e09b27ca
[11/40] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode"
        https://github.com/kvm-x86/linux/commit/b6a0fdf2bbf0
[12/40] KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels
        https://github.com/kvm-x86/linux/commit/879fffc09474
[13/40] KVM: x86: Move update_cr8_intercept() to lapic.c
        https://github.com/kvm-x86/linux/commit/c7722e5e1dae
[14/40] KVM: x86: Move async #PF helpers to x86.h (as inlines)
        https://github.com/kvm-x86/linux/commit/bc87aec39399

...

[17/40] KVM: x86: Drop defunct vcpu_tsc_khz() declaration
        https://github.com/kvm-x86/linux/commit/e688ca78589d

...

[29/40] KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
        https://github.com/kvm-x86/linux/commit/5fd25aacdf89

--
https://github.com/kvm-x86/linux/tree/next
