Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABB3B27CA;
	Fri,  5 Jun 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669849; cv=none; b=e5rg0+wngbaJeB7nmUQqrb4qTfbEV/BNaCH3Lf6kAivzLRNrfxRdmLZxxykTLTcDpxuAvbSk8wiEoLMo0Yph6UF3mXYyvUbD/Q7niA29ICT7Bhd+ap436SfcXTCLNSEi1F1EX4ttrm+iSvVpR2NUzo2OnbEtSEiiTP/Vnn4oMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669849; c=relaxed/simple;
	bh=oFKMhS7eny/oOGI4sHVAwD1VRMmpiiMmYpfIyQ8rtfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jgu9CqkdTSkwdDy+j5GBUnQIf8YPTfsM+M4kvhnIYHhSa3VbLKLfuDpLLy90VP4UK9Wu/9WB+Tv5dD9yM5hV5CHXBsGfOiusrFFB5T6T348Nt7qQHYMU+zMf/+9Famn9GBFG1FzkeKFviFkOSbf43xwxN5dmNAmHothFZPPQI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=epBskAad; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epBskAad"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uuVOC0yF0VaZ/1GzTBocIPBr9MShTN6T3159VEo6S6g=; b=epBskAad1YtqVpR/rF4Ei2W7c9
	8irjeNa+8COXMjJU/PGrO0Xft6Ca+9gpWFZresyu7qbfVjyGMaM1Jw/xGmMXbBhvpRqOH1AyuPk2O
	TR2FI0D01H6LGXyCwlax8pnWTQZhfip5EKnPSjJ6tWerNaTxUbYrSXBdy0ZiiZ2dYj9PRSfpIG2UD
	U8p2dyY0Ja239995F8c1JsFT8279HAxI24gqijv+9/YJCsEnM6NHY28qn+wPUEroG8/YZml36X6rT
	4GjOZ6sTOhox1Vr3wid97nVnE+UnpQcnoB0KBttFEdzAVLoXAv6OkMgIOcFue+gC4IhToPT970jNR
	GA7VQsAA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848Y-203T;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013M-0jZU;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] KVM: x86/xen: Clean up 32-bit vs. 64-bit shared info mode handling
Date: Fri,  5 Jun 2026 15:17:25 +0100
Message-ID: <20260605143034.3603-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

This series addresses issues in KVM's Xen event channel delivery paths,
triggered by review of a patch from Hyunwoo Kim which fixed a TOCTOU
race in kvm_xen_set_evtchn_fast().

The first three patches are preparatory cleanups:
 • Rename the 'longmode' hypercall parameter to 'is_64bit' to
   distinguish it from the VM-wide shinfo mode.
 • Introduce kvm_xen_has_64bit_shinfo() with READ_ONCE() semantics.
 • Rename max_evtchn_port() to kvm_max_evtchn_port() in preparation
   for adding a variant that takes a latched bool.

Patches 4-5 fix TOCTOU races where kvm->arch.xen.long_mode is read 
multiple times without consistency. In practice these are harmless since 
the bitmaps are at the same offset in both layouts and corruption is 
limited to the guest's own shared_info page which doesn't get converted 
when switched between 32-bit and 64-bit anyway, but the fixes ensure 
internal consistency for any given invocation of the given function.

Patches 6-8 address a split-lock DoS vector identified by Sashiko: 
locked atomic operations on vcpu_info->evtchn_pending_sel can trigger
an #AC exception on hosts with split_lock_detect=fatal if the guest 
registers vcpu_info at a misaligned address. Patch 6 adds Xen-compatible 
alignment enforcement at registration time. Patches 7-8 switch to 32-bit 
locked operations which only require 4-byte alignment, handling the case 
where a 32-bit guest registers vcpu_info at a 4-byte-aligned address and 
later switches to 64-bit mode — which Xen supports, so so should KVM.

Based on v7.1-rc6.

(Sorry Sean, this conflicts with some stuff you have outstanding but
should probably go first?)

David Woodhouse (7):
      KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
      KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
      KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
      KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
      KVM: x86/xen: Enforce alignment of vcpu_info registration
      KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
      KVM: x86/xen: Use 32-bit locked ops in kvm_xen_inject_pending_events()

Hyunwoo Kim (1):
      KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()

 arch/x86/kvm/xen.c | 186 +++++++++++++++++++++++++++++++++++------------------
 arch/x86/kvm/xen.h |   5 ++
 2 files changed, 127 insertions(+), 64 deletions(-)



