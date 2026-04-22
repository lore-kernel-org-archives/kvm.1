Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E63E6DCB;
	Wed, 22 Apr 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861960; cv=none; b=MZZ6bKt0h4qCNOPzmJwJTpspFQt8kLOkskdA9o1hJRek6mW2X4mm3qs9gMwLMFeG6Ga7ULaBfQPBkxsiNhpK/1EmgSaWbPL0rVp4wksX3w7BL30RjLaJfcNJhSBOuVjiK5c1Q20wOxdUi4RQ6DpScD1sTRGCOUY40RgbkAxJlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861960; c=relaxed/simple;
	bh=AeRYKHaYb7gUgMTBBnt0z16R/9ZmP47LowXSmF6UL8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn6Nt6oJcH0hthxhSODL+U29FpEUOgCTyqAVL3ng9jfvDi8lMSF5NyDGJO/XM7AxHoK0zHo/KF8egWCDcjvnaO1YKFJuOn8+MVV1zZOt26VE2NrL3YCh4MQqKHebuH1IZtFpO5Uq6KuGX0jlrUfOL5jFMOll7w4IIN4BCoB8Y+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg/wVty3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg/wVty3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776861959; x=1808397959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeRYKHaYb7gUgMTBBnt0z16R/9ZmP47LowXSmF6UL8g=;
  b=lg/wVty3Eh1Z2FOqlYtzEEY8okkV7QOxwULrc2AmhHZUdodc4+omJUEW
   Sn37hZz2WCR0sos4Tc+XgM3Cd4KLHNB6eFfpcAT4Y8eN1RBjlDR3SHVdW
   iqArdmJM/7ekalwAg6X7r4NfzlLumbO7XiDho/POKM1vCDABmtistWT0F
   p78cextscT8yKulIl5Y1fz4OeiKAK9tmIYfT+JJaa0QEnXQoili6DZaQy
   BczIMJT7FdQyw0TC7VwukeFdXk+RiHPUOun477sxV3DsGYKyJHoGGii0H
   RMzVJeI8sVHwpRnDDHYUeQol27hgG5+5riiXH6dMBvT5D3W4mh4efL2FP
   A==;
X-CSE-ConnectionGUID: tOT/q406Q/ahnUqmBzrs2Q==
X-CSE-MsgGUID: 8dT2Pl8eRvyweMKMG4Hjfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89280526"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89280526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:45:58 -0700
X-CSE-ConnectionGUID: TMe572xdTmiKUp7BI6CKyg==
X-CSE-MsgGUID: PtHnWHEGRZu0Ex4IMvRn/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="262737152"
Received: from pste-spr-rvp-01.sclab.intel.com (HELO spr01.sclab.intel.com) ([10.102.60.130])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2026 05:45:56 -0700
From: "Nowicki, Robert" <robert.nowicki@intel.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	seanjc@google.com,
	vishal.l.verma@intel.com,
	pbonzini@redhat.com,
	robert.nowicki@intel.com,
	Igor.Swierszcz@intel.com
Subject: [PATCH] x86/tdx, KVM: fix HKID leak when kexec is initiated with active TDs
Date: Wed, 22 Apr 2026 14:45:36 +0200
Message-ID: <20260422124536.53756-1-robert.nowicki@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When kexec is initiated while TDs are running, vCPU threads can be
mid-TDH.VP.ENTER on other CPUs when tdx_shutdown() fires. The TDX
module rejects TDH.MNG.VPFLUSHDONE for a VP in RUNNING state, leaving
the HKID in a leaked state:

  kvm_intel: tdh_mng_vpflushdone() failed. HKID 33 is leaked.

Fix this by introducing a quiescing flag set at the start of
tdx_shutdown(). KVM's tdx_vcpu_run() checks the flag and returns
EXIT_FASTPATH_NONE before attempting TDH.VP.ENTER. After setting the
flag, tdx_shutdown() calls on_each_cpu(tdx_seam_sync) with wait=1 to
ensure any CPU currently inside TDH.VP.ENTER has exited SEAM before
tdx_sys_disable() is called.

Fixes: 58171ae22e11 ("x86/tdx: Disable the TDX module during kexec and kdump")
Signed-off-by: Nowicki, Robert <robert.nowicki@intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/kvm/vmx/tdx.c      |  3 +++
 arch/x86/virt/vmx/tdx/tdx.c | 12 ++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a0a4a15142fc..68a87bdbca9a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -173,6 +173,7 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
 }
 
 void tdx_sys_disable(void);
+bool tdx_kexec_quiescing(void);
 
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
@@ -206,6 +207,7 @@ static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
 static inline void tdx_sys_disable(void) { }
+static inline bool tdx_kexec_quiescing(void) { return false; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 50a5cfdbd33e..2d658db7700d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1053,6 +1053,9 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	struct vcpu_vt *vt = to_vt(vcpu);
 
+	if (unlikely(tdx_kexec_quiescing()))
+		return EXIT_FASTPATH_NONE;
+
 	/*
 	 * WARN if KVM wants to force an immediate exit, as the TDX module does
 	 * not guarantee entry into the guest, i.e. it's possible for KVM to
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index aaf22a87717a..71c7e4fadda3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -236,6 +236,16 @@ static void tdx_cpu_flush_cache(void)
 	this_cpu_write(cache_state_incoherent, false);
 }
 
+
+static atomic_t tdx_shutdown_in_progress = ATOMIC_INIT(0);
+
+bool tdx_kexec_quiescing(void)
+{
+	return atomic_read(&tdx_shutdown_in_progress);
+}
+EXPORT_SYMBOL_GPL(tdx_kexec_quiescing);
+
+static void tdx_seam_sync(void *ign) { }
 static void tdx_shutdown_cpu(void *ign)
 {
 	/*
@@ -252,6 +262,8 @@ static void tdx_shutdown_cpu(void *ign)
 
 static void tdx_shutdown(void *ign)
 {
+	atomic_set(&tdx_shutdown_in_progress, 1);
+	on_each_cpu(tdx_seam_sync, NULL, 1);
 	tdx_sys_disable();
 	on_each_cpu(tdx_shutdown_cpu, NULL, 1);
 }
-- 
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

