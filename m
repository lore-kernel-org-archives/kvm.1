Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11D36DA00;
	Sat,  9 May 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366929; cv=none; b=H1VRVHGlwpkZbZmeiMbtC6z4BAbwiSRPiXnMTvGuelISeAPbeA46w0mBzwnCAmB9gu2qNHvJ8ixkGA0x2lNVNWfRELoXLsGBMam/PJiTxNPLlQBny/lVSi0gRGn6XDeY9E7Gcd/2Jc7/gUIW/SPYbLCbnsDX3vF8/gXUYNIVqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366929; c=relaxed/simple;
	bh=nZGGnZrkBG71bIPOKbQtq+NJgXRCDUnr2A3hT2LiE3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZK4k0AXcfczHSfrMuOGCJbfi/2j0DBTk9u+DNfNcfCQYhK2/WlZXMWGlTJhI9BBIlwFASb47Ij12kbRwEFsiiPBGjuUs/4o7nCoCmsrKaibx4ASw1Z9+vYa1NQKC0e1WdPudXcvnbQ21hmWCUePsWiiomSVO2PPTbtNP97UIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BpdCMag+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BpdCMag+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=Rlefrv035dE/A4ZfqxoNxpMximz7sVxUML4oSeehurg=; b=BpdCMag+qQeRQ5HUSztZ5825NR
	CwsTyPlVzrIaUi3MD2Pgs7SkvujS/dAokWA6r0Uea/18K0TZbpMa+C1GC+RQlvY0ZYeA3V0RLgLyH
	p84QoHNsDoHOem2wktR9d4GMZ4ZXX4ztZGHkA1B2w/VbuGQwNcW4Mp0D5Gi7Vhk5jbzcpmAiPdeOu
	AxF8VicBNW8EGM7sV+t5BG+wftPQ6ysKcPuc12W/1jcsihSjGgIiHhma2EKG3q+C8LRMLwHtaGaiH
	454cyuN/RcRhYiF83g1XnCoTGkyuFg3UanYe4rklrxhs9DBPoMmVvUToHOkIEJ/RUQMiq/LdRh6py
	hcsFWZkw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzB-0RLs;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhHp-297o;
	Sat, 09 May 2026 23:48:26 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 09/30] KVM: x86: WARN if kvm_get_walltime_and_clockread() fails unexpectedly
Date: Sat,  9 May 2026 23:46:35 +0100
Message-ID: <20260509224824.3264567-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The master clock depends on the pvclock being based on TSC, so the only
way kvm_get_walltime_and_clockread() can fail when use_master_clock is
true is if the clocksource changed and use_master_clock is stale, in
which case a seqcount retry should be pending.

Add a WARN_ON_ONCE if the seqcount has not been invalidated, to catch
any case where the failure is genuinely unexpected.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1e1834533e98..ccdfd3fa3402 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3474,7 +3474,8 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 		local_tsc_khz = get_cpu_tsc_khz();
 
 		if (local_tsc_khz &&
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
+		    !kvm_get_walltime_and_clockread(&ts, &host_tsc) &&
+		    WARN_ON_ONCE(!read_seqcount_retry(&ka->pvclock_sc, seq)))
 			local_tsc_khz = 0; /* Fall back to old method */
 
 		put_cpu();
-- 
2.51.0

