Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440607;
	b=oJuIR1XZKMuXuLRTN+DUtvEjJwNbrKXBTfYdKNrwE2iGhp7T8Xc1JeytQH2Rie8D7FPQ
	 yp6RZpWdcNu+ssbtzSy326glyDnaTly5cW5x3xG2jFkvm4sxqVxgE4LdhsP5voTHafjxO
	 PGp1MqLHNSLu6ZsIAN2vJhS1nPhrMG31ma4sA/24ntENPyafUIUdMGvZAhQ41ZrTBEXT1
	 kfgoIjuIaYd144yGx/jGVEEv4dpx2rDUyUydY2bR0M3xul1Izi/unG6jopewArs8s8B5p
	 wsAZviTaevbXMTl1e9IlYCd5oDKIc0vgRRNcSswx/9MLeTFHqChGv1c5c+o7o0SkNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440607;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=j3mJbUipG7teIjK/zO0RNtzSRCV/bGl/8Rxk9Uq3fU8=;
	b=rTBIRgzji9R4A29teMO5K8RKnY8OtBdId5dU9HgNKESZpHITBK/7NB/6bVMI4QarvBvM
	 sWAT+pt/sBawidiVoyqRbCRNP9f4k8BzDQzTNB5VtjZHkZs+XNWEZTW8c7kbzlwnX2ZxJ
	 QvXU0ocBPc0L8fViAHbALYDsKiYR2SdFSHEtlg7GsWnGNpzLWK5MjjAqmQ4ktUI3Ofjmz
	 eYo0dnnX57LRCMTnxpumUbKABv6OlAQ/9ZGqxFmE0oWNBynpbjjLsAi/AAQ1RBEGbvego
	 iTrRQfRcDlXbappX6CVDdRO/j6Og9aWPLWrHDOHoip31fFOZ2SSiV1RDOfvTHNBUS+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=NJcQcjk8;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264F606A31C;
	Sat, 31 Oct 2026 09:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2264F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=NJcQcjk8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j3mJbUipG7teIjK/zO0RNtzSRCV/bGl/8Rxk9Uq3fU8=; b=NJcQcjk8iHIhc+dC2kxaTsw3hc
	ohv9B90sMpGgDNmrSHnuT0HN3qeTE2Hd/ztql/oFSN03Ge73O+rwycqUhumzflJ3Exmn84kJdnn8g
	cCb5NVNhheUQnhdrAQgv2CC05+KqIJtnMs9hTrxG/Zj8qt2FB8PpPT+aifcz5+rsJgyOEcDDmNjZo
	SSeitO40rSClCzVa/zma9u4v1h3ct0vsS6fvIGqPXRqw9WD77gsmzrwO+ssgyiM/24RK56phpw3Pn
	M10PH5ePPm9flWFCxH2NqGM96Ud3FNoqMBCCEFakuVxrBqx50/Caw0ah4jEeuK+2dJWvPZb843/sB
	w3SvEjmQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:48267)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN5pL-001XaV-1N;
	Sat, 31 Oct 2026 10:56:43 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN5pL-000U3o-00;
	Sat, 31 Oct 2026 10:56:43 +0100
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 31 Oct
 2026 10:56:35 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <yosry@kernel.org>, <seanjc@google.com>
CC: <pbonzini@redhat.com>, <jmattson@google.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>,
	<amirmohammadeftekhar@gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02 on every nested VMRUN
Date: Sat, 31 Oct 2026 10:56:24 +0100
Message-ID: <20261031095624.212806-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <att-Epjatf5sw-ba@google.com>
References: <att-Epjatf5sw-ba@google.com>
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
X-ClientProxiedBy: MBX19-GWD-07.um.gwdg.de (10.108.142.60) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

On Fri, Oct 23, 2026, Yosry Ahmed wrote:
> Running the selftest under the probe on Zen 2/3/4/5, vmcb02 rows with both
> vls=1 and the VMLOAD/VMSAVE intercept set still exit 0x82/0x83, so the
> intercept is honored even with VLS enabled.
> Can you share a standalone reproducer?

Thanks for the cross-microarch data and for the script. You are right, and I
withdraw the intercept-drop claim. I reran this on a VLS-capable box
(Threadripper PRO 5965WX, Zen 3, kvm_amd vls=1) with your bpftrace unchanged,
and both your selftest and my own reproducer line up with your reading.

1. Your selftest reproduces your result here. Every VMRUN where vmcb02 carries
   both the VLS bit and the VMLOAD/VMSAVE intercept exits 0x82/0x83, the
   intercept wins:

   vmcb02[vls=1 vmld_icpt=1] vmcb12[vls=1 vmld_icpt=1]  VMLOAD -> 0x82
   vmcb02[vls=1 vmld_icpt=1] vmcb12[vls=1 vmld_icpt=1]  VMSAVE -> 0x83
   vmcb02[vls=1 vmld_icpt=0] (intercept clear)          VMLOAD virtualized, no 0x82/0x83

   So VLS virtualizes only when the intercept is clear; with both bits set the
   intercept is honored, exactly as you measured.

2. My reproducer does build the stale both-bits state, and it is still harmless.
   Tracing --step vls-stale on the same box:

   arm    vmcb12(vls,icpt)  vmcb02(vls,vmld_icpt)   entry_rip   exit
   clean  (0,1)             (0,1)                   0x1004000   0x82  VMLOAD intercepted
   run1   (1,0)             (1,0)                   0x100400a   0x72  VLS on, VMLOAD virtualized, RIP advances
   run2   (0,1)             (1,1)  <- stale VLS     0x100400f   0x72  resumes already on the CPUID

   run2's vmcb02 is the exact case my patch was about: the VLS bit is left set
   from run1 while KVM sets INTERCEPT_VMLOAD for run2. But its 0x72 is not a
   dropped intercept. run1 virtualized the VMLOAD and advanced L2's RIP to the
   CPUID, and my test runs run1 and run2 on one shared L2 context without
   resetting RIP, so run2 resumes past the VMLOAD and never re-executes it. The
   0x72 is that CPUID. Had VMLOAD actually run in run2 with both bits set, your
   selftest shows it would have exited 0x82. My earlier Zen 4 "repro" was the
   same RIP artifact, except that box could not enable VLS at all, so vmcb02
   never even carried the bit and I misread the CPUID as a virtualized VMLOAD.

So the stale bit is real in the code, but it does not drop the intercept: the
hardware honors the intercept over VLS, as you said. The E3 / cross-layer
framing was wrong and I withdraw it.

What survives is only the hygiene you and Sean already pointed at:
virt_ext/misc_ctl2's VLS bit is OR-set in nested_vmcb02_prepare_control() and
never cleared, while misc_ctl is reset from vmcb01 a few lines above. Worth
folding into Sean's cleanup (initialize misc_ctl2 = 0 and un-invert the check to
match nested_vmcb02_recalc_intercepts()), as hygiene, not a guest-reachable fix.
The forward WARN in my original patch was oriented wrong; drop it.

Sorry for the noise on the security angle, and thanks for pushing back with the
measurements.

Thanks,
Amirmohammad
