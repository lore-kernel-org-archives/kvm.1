Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A54F7997
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059445; cv=none; b=lCdgd4m3Bah+98YXt2oD79mp/oiW35fNI+n7tDZCeuW4EekIFA+8YyC5NxzHHY1pROWwZk8ckMMy/TYt6Zs+/qhZhCVgp2daHiEKrwnYT+xQ84RWSuTo+cyKeRVyrCH3oWdhRDmZSJaQV5dxpG46Q87qjdCsHTt3JAStiak3ZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059445; c=relaxed/simple;
	bh=KyczVRw6DQ4Q2CF9U3rOeviso8DvMN7GdliVgfbvQQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+iOCWYhUU3MC3VRep1f+gIMviBdfNMFP4Ry+7GNxIVQuZ2j5DZ0Ya/j/jrkcoNGIw5lNn5C0IUdUfT6ti8wZPgOe5/ZHNbeaR8KJkIPwdJ3ScF5VqOIX5lhIn1ByWsdsiLEs63xULCHPOymgKf0EQIbb1IC74cWXqf1udvOu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBvaHWQj; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBvaHWQj"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84842381150so4349610b3a.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059443; x=1786664243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NcgEnPBxyGviYS1Y0BEogKtyt4exk2sJiTd88Re19eg=;
        b=nBvaHWQjRUJBELDkGEpYOwrVRgx+Tj2Eac82OmyG0INkWqnxm6f2wA16yysVOtQOTb
         OYeJmwk4L8ZjbZ+c63zCfcx8uLF+xDAiSFodANwvuQCSIk3TC7OrdXBnTWlbyYYvVnRT
         ajL2oyhgK+HpHDh9OUNSo86Q/KzGl0stk1PIu2lyBsVnu9Ty+/IyliYDbwfAq6zchBqK
         aMSUzT0wngvsJdkJwQNKUGSOd6VpehY0mja6b4HXizQpz1BnxtHXRVzjV7aaX2ij5Ymv
         ykppzBHqwNRF8Z5zy6iJfvnDGajEi1xT2aYhjWDDxZpt2XDf211ui97uRYXmdNuSZhHK
         D0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059443; x=1786664243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NcgEnPBxyGviYS1Y0BEogKtyt4exk2sJiTd88Re19eg=;
        b=fBl1NUxppMU0llmiXoahERofFC/NYQYvyBPLXaHRp0EyE38Zw0bPZ0zqjcMHfgAIot
         gzt0dzh2M1EKh0XBwdUkMd8RGhZio7Ep3uv5FLFrlODpLBvssiXMkEVIWAj03nDLNIOf
         QQb46s2q3kafkcVQSeagjYMg+LAqA0G5wvkrk18kzbDPGTuWy2mJzd7XBZLxOdI5lbpK
         e+xWyUnTvHOklCVc4uGe+R0dGtxXHEW02EX5/7HObby5wO2ZsqGZ4EMtonTUcv7FR1m9
         vxE3D8AABH4Dn6gSA6KT5fh4CW8OWaScDk3aYYMyOANYasyhcNNB2l/T0Y6ZmyMgH2V+
         pFYA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4/p7FXdAKvhaJ1bD7Sj5Qu3ykOeRDJmmrkrOHA5cHU7ANuuqcVmplOcIj3ul48Z8zNog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXPG/g4zrXSGruttkKHL24MYpyCRQVh/1rqpGphFhfJbkSBxM
	fIQXPF1jNliGN9wZgwn/mSV5ISwvtStYdg2IVYNYpEyq7vwh/zbosrzQGnVsB9Il61+CTQ/sra3
	lYMNFTw==
X-Received: from pfbcw11.prod.google.com ([2002:a05:6a00:450b:b0:848:51a7:e8bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2999:b0:848:67ca:bfd
 with SMTP id d2e1a72fcca58-84f2dff1913mr22778991b3a.16.1786059442569; Thu, 06
 Aug 2026 16:37:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:04 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-48-seanjc@google.com>
Subject: [PATCH v6 47/51] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fcf331ffd874..c0e4485484f2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.55.0.679.g6767b8d81c-goog

