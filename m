Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614636;
	b=5gPJiO/1f3BIpFalYHxc0J9+jYLZMET/VORMCCaqidSCdcewYE6WluBE6kCJOk225HZ4
	 5V3torGzSp63n2HkVYmCCLOPvpOBNCdk7LDFi/lC8uZ+oilXlLXaY8jjpV8IiBC+aXCXp
	 MeHoaiABW9rElSIJKzLkNClA8dRP9HfwvSHgn4lFNhH32FgiHWJF7npXjSM6sg7zZa/el
	 XvrDneLIEAIoKJP1ZdNyOk0h6Y5+wDk0+H+3gZxEyN+OKXf9GG6vS4jnRUGwnxd1WagnH
	 Eg6c343evUv6UVIPvqb4YXZlW55fK6xMI0D+1vYhS4pSJ9Lc5BYyeLBQfKvGRN1ounw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614636;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=hQYoRSDUpQyOPGFDZVMho/fLsZ1oNcYCSXble9FBDw8=;
	b=CFFV2HKuc/5PO43HRLpr4t9f2aup4vBh5gSPxvbnykaCJfxtjPVA1u6n9dpJCwDZiYrG
	 a5YqIFaDq1T4Rs5m4+mYIW3CA3Y2qV1/RY1exFaQwSUapCLg0D4YAvJ8GVn8SrlhfQxpU
	 oJc4l/qR40QP6s+z6iKaYNswEnqLpiuSBKemjg5SP/DaCPesiK00Un5rapzoEtAOz/0t5
	 rr64NBsolQlOJe3j3IyDur+8eK6G7h/YCDGjI7f+GOdpD+v+U/6VrsRM5LkPbgIc1gETd
	 4yBDT2hGluLAmh8vm0vKHDcC+WpY+0bbFz8HW40NrpM5n06aYH3FPd31n4Qrbg+oFGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=D0TvtNfR;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DC606A32D;
	Wed, 25 Nov 2026 13:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71DC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=D0TvtNfR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hQYoRSDUpQyOPGFDZVMho/fLsZ1oNcYCSXble9FBDw8=; b=D0TvtNfRCsS5bJErvC1ADcgH+G
	lo7LWJeVFqwupz6FdIvqobXXroqMmTzFKq6Pd7m9iNGzrO23QVo/WYfah8lhp0PxVcoSRxgtG+ojs
	n229eOa+OJFvwYeJ2v4Wj7mqvK8g9PTTuugBIgingfzcrFceIY931RE9aXSNsmKYoGQ56QzBIJaR3
	Q+0RqXui1nRZ93gHwKNJqScL2zujiKjRh9AHr3n9b07jzYPz1MtkeG5RxHvqXk8fMqB8TNBqcdbFP
	bDbodCQKOCYifnEqyD9tpXfmYcpm1gCUuYiKpOxn2cqU4c3s04V5eotldygTUyQvoSkZjsbeFFneK
	aRnRvviA==;
Received: from mailer.gwdg.de ([134.76.10.26]:50437)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xWDOM-00CDhK-01;
	Wed, 25 Nov 2026 14:50:34 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xWDOL-00024m-31;
	Wed, 25 Nov 2026 14:50:34 +0100
Received: from localhost.localdomain (10.250.9.200) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.57; Wed, 25 Nov
 2026 14:50:33 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>, <amirmohammadeftekhar@gmail.com>,
	<jmattson@google.com>
Subject: [BUG] KVM: nVMX: SIPI delivered into a wait-for-SIPI L2 when INIT and SIPI are both pending (no SIPI VM-Exit to L1)
Date: Wed, 25 Nov 2026 14:50:26 +0100
Message-ID: <20261125135026.62723-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
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
X-ClientProxiedBy: MBX19-SUB-06.um.gwdg.de (10.108.142.71) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

When an L2 vCPU is in the wait-for-SIPI (WFS) activity state and both an
INIT and a SIPI are pending, KVM can deliver the SIPI into L2 instead of
generating the SIPI VM-Exit to L1.  Per the SDM, a SIPI that arrives while
a logical processor is in wait-for-SIPI causes a VM exit directly; for a
nested guest that is exit reason 4 (SIPI_SIGNAL) to L1.  INIT, in
contrast, is blocked in WFS and must not cause an exit.

The three pieces are each correct in isolation and wrong together:

1. vmx_check_nested_events() handles INIT first and returns 0 without
   looking at SIPI.  For an L2 in WFS it clears KVM_APIC_INIT (correctly
   with no VM-exit, since mp_state == KVM_MP_STATE_INIT_RECEIVED) and
   returns; the KVM_APIC_SIPI branch only runs on a later call.

2. kvm_apic_accept_events() calls kvm_check_nested_events() once and then
   processes INIT and SIPI itself.  In guest mode it still delivers the
   SIPI via kvm_x86_call(vcpu_deliver_sipi_vector) while the vCPU is in
   guest mode: that writes CS.selector = vector << 8, CS.base =
   vector << 12 and RIP = 0 into vmcs02 and sets the vCPU RUNNABLE.

3. The common path hides this.  vcpu_block() calls
   kvm_check_nested_events() right before kvm_apic_accept_events(), so the
   first call consumes the INIT and the call inside
   kvm_apic_accept_events() turns the remaining SIPI into the correct
   VM-exit.  Callers that reach kvm_apic_accept_events() without that
   preceding re-check are exposed.

Confirmed trigger: KVM_GET_MP_STATE on the WFS vCPU while INIT and SIPI
are latched.  It calls kvm_apic_accept_events() directly, the INIT is
cleared with no exit, and the SIPI is delivered into L2.  There is also an
in-kernel two-sender race in vcpu_block() when INIT and SIPI land between
its own kvm_check_nested_events() and the one inside
kvm_apic_accept_events().

Effect: L1 never receives the architecturally guaranteed SIPI VM-Exit.
L2 is made runnable at vector<<8:0 in whatever mode L1 left it in (only CS
selector/base and RIP are rewritten), so an L1 hypervisor that relies on
SIPI exits to start its APs is bypassed and L2 starts the AP itself.  With
unrestricted guest off in vmcs12 the rewritten CS can also make L2 state
invalid and lead to a nested triple-fault exit to L1.

Reproduced on an Intel host and, in a nested KASAN L1, on mainline
(7.3.0-rc3) and on 6.1.74.  Controls: a SIPI-only arm and a vCPU left
blocked in KVM_RUN both take the correct SIPI_SIGNAL VM-exit.  The
INIT-then-SIPI arm shows deliver_sipi with hflags guest_mode=1 and no
nested exit, and KVM_GET_NESTED_STATE afterwards shows GUEST_MODE=1 with
vmcs12 rip=0 cs_sel=0 (it was rip=0x200040 cs_sel=0x8 act=3).  No warning,
BUG or KASAN in either kernel.

I have not attached a fix because the right place to close this is not
obvious to me: either kvm_apic_accept_events() should not deliver an INIT
or SIPI while the vCPU is in guest mode and should instead force the
nested-events path, or vmx_check_nested_events() should prefer a pending
SIPI over the INIT for a WFS L2.  I am happy to send a tested patch and a
selftest once the preferred direction is clear.

The guest-mode check in kvm_apic_accept_events() was added by 1c96dcceaeb3
to force a VM-exit before incorrectly injecting an INIT or SIPI into a
guest; the early return after the WFS INIT branch in bf0cd88ce363 breaks
that intent when INIT and SIPI are both pending.

Fixes: bf0cd88ce363 ("KVM: x86: emulate wait-for-SIPI and SIPI-VMExit")
