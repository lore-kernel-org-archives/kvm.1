Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069E31AF1B;
	Thu,  2 Apr 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111541; cv=none; b=Bx87vuPs6Kj+9B9/MvviGYsPNChbrHHMNXnwpO61KN3uI8LTxKYczIDH5pe7VP+fsX8nsdN+f7w16JFlaC5fKouNTGAGkLYcvWRVM4C2LZhjWNZZhXVXyaBm+2/J7p4OLegnFsxC8TCkH0UgLWENRglLDr//ydpeS0Vrkj/F8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111541; c=relaxed/simple;
	bh=fr2AGC4DAtRDRQoO7qlnwxMNcELWQ3TmgBcgjqT5wAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKfXwHmmnqym6JGNmDQCVEAqA9blGzQEEJA18WoszEz7XxTiML6zDB0MhpemlWE08PYoZhBgOCm5Ye4rE/WU7cqMTESXYph00IN+pU5dGOtraBJUCbg2z9Y+efbJPjB539cnxv/P4kaSj9+CgWTnY7i4Hp3/nh18pm/6g3cbF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4nHLy5A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4nHLy5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775111540; x=1806647540;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fr2AGC4DAtRDRQoO7qlnwxMNcELWQ3TmgBcgjqT5wAQ=;
  b=L4nHLy5AcIJUxTee2OEbCNH4HLD6xeQDe+rpX1lQv5lvnG/Al2FoYjki
   U4G12xif2v+4qp+syG04coCS6NxXLrnvSnL32p1hiGKq8agCB1CL25kaj
   qAhilgsygahFJOUkP1XwHOc19dNXK76KjzQBiVcTQiRMk98wXJR/DeLt6
   vlk2VSEHRSb7A7iiFr9P/veJGiSoA0L0GwoiyrNxDpsYCQncMhM68jp4d
   IjIoNS4jJ2A8tYSjvVgvkWhLFnL44wwJf2ac+prwHroQ1s3j96JPs2zdI
   Edztt38OMcmRi9Gb1H4DllVod8oNUkJe5EDCkDFWoHotTwWrlv376R9oD
   Q==;
X-CSE-ConnectionGUID: C6F4xyMGRQefJMR/AV/EWQ==
X-CSE-MsgGUID: rtB8QDufS8Snc8z+EndXLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75884377"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75884377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:19 -0700
X-CSE-ConnectionGUID: to4XrwE1SS27pFHYDmCpMg==
X-CSE-MsgGUID: H7ysO7guRKu096s7W4HKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="222042380"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.223.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:17 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 02 Apr 2026 00:32:02 -0600
Subject: [PATCH v3 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fuller_tdx_kexec_support-v3-2-34438d7094bf@intel.com>
References: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
In-Reply-To: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=tQJ89P+w7vtSKyTW13SidV3e91okmzzHzGpQV5uA2V0=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJnneAv+Vhg8f3bxio3Ln7sJz5OeOlzYutfiGM80s+Wuy
 3//8ufp6yhlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEZvIx/GZ1fF6xbxPbdpZX
 lbrWCqmrEg/ceP0zt+/M3Gh13g1Rp7sYGU4oqHq/CWoL/BjtuevWI76lq5ruHv45YcuTnQ93RW3
 fWMEMAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

KVM tries to take care of some required cache flushing earlier in the
kexec path in order to be kind to some long standing races that can occur
later in the operation. Until recently, VMXOFF was handled within KVM.
Since VMX being enabled is required to make a SEAMCALL, it had the best
per-cpu scoped operation to plug the flushing into. So it is kicked off
from there.

This early kexec cache flushing in KVM happens via a syscore shutdown
callback. Now that VMX enablement control has moved to arch/x86, which has
grown its own syscore shutdown callback, it no longer make sense for it to
live in KVM. It fits better with the TDX enablement managing code.

In addition, future changes will add a SEAMCALL that happens immediately
before VMXOFF, which means the cache flush in KVM will be too late to
flush the cache before the last SEAMCALL. So move it to the newly added TDX
arch/x86 syscore shutdown handler.

Since tdx_cpu_flush_cache_for_kexec() is no longer needed by KVM, make it
static and remove the export. Since it is also not part of an operation
spread across disparate components, remove the redundant comments and
verbose naming.

In the existing KVM based code, CPU offline also funnels through
tdx_cpu_flush_cache_for_kexec(). Add an explicit WBINVD in
tdx_offline_cpu() as well, even though it may be redundant with WBINVD
done elsewhere during CPU offline (e.g. hlt_play_dead()). This avoids
relying on fragile code ordering for cache coherency safety.

[Vishal: add explicit WBINVD in tdx_offline_cpu()]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tdx.h  |  6 ------
 arch/x86/kvm/vmx/tdx.c      | 10 ----------
 arch/x86/virt/vmx/tdx/tdx.c | 46 ++++++++++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a149740b24e8..bf83a974a0d5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -226,11 +226,5 @@ static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
-#ifdef CONFIG_KEXEC_CORE
-void tdx_cpu_flush_cache_for_kexec(void);
-#else
-static inline void tdx_cpu_flush_cache_for_kexec(void) { }
-#endif
-
 #endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b7264b533feb..50a5cfdbd33e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -440,16 +440,6 @@ void tdx_disable_virtualization_cpu(void)
 		tdx_flush_vp(&arg);
 	}
 	local_irq_restore(flags);
-
-	/*
-	 * Flush cache now if kexec is possible: this is necessary to avoid
-	 * having dirty private memory cachelines when the new kernel boots,
-	 * but WBINVD is a relatively expensive operation and doing it during
-	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
-	 * now, since this is a safe moment and there is going to be no more
-	 * TDX activity on this CPU from this point on.
-	 */
-	tdx_cpu_flush_cache_for_kexec();
 }
 
 #define TDX_SEAMCALL_RETRIES 10000
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cb9b3210ab71..1b2d854ba664 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -184,6 +184,17 @@ static int tdx_online_cpu(unsigned int cpu)
 	return ret;
 }
 
+static void tdx_cpu_flush_cache(void)
+{
+	lockdep_assert_preemption_disabled();
+
+	if (!this_cpu_read(cache_state_incoherent))
+		return;
+
+	wbinvd();
+	this_cpu_write(cache_state_incoherent, false);
+}
+
 static int tdx_offline_cpu(unsigned int cpu)
 {
 	int i;
@@ -220,12 +231,28 @@ static int tdx_offline_cpu(unsigned int cpu)
 	return -EBUSY;
 
 done:
+	/*
+	 * Flush cache on the CPU going offline to ensure no dirty
+	 * cachelines of TDX private memory remain. This may be
+	 * redundant with WBINVD done elsewhere during CPU offline
+	 * (e.g. hlt_play_dead()), but do it explicitly for safety.
+	 */
+	tdx_cpu_flush_cache();
 	x86_virt_put_ref(X86_FEATURE_VMX);
 	return 0;
 }
 
 static void tdx_shutdown_cpu(void *ign)
 {
+	/*
+	 * Flush cache in preparation for kexec - this is necessary to avoid
+	 * having dirty private memory cachelines when the new kernel boots,
+	 * but WBINVD is a relatively expensive operation and doing it during
+	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
+	 * now, since this is a safe moment and there is going to be no more
+	 * TDX activity on this CPU from this point on.
+	 */
+	tdx_cpu_flush_cache();
 	x86_virt_put_ref(X86_FEATURE_VMX);
 }
 
@@ -1920,22 +1947,3 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
-
-#ifdef CONFIG_KEXEC_CORE
-void tdx_cpu_flush_cache_for_kexec(void)
-{
-	lockdep_assert_preemption_disabled();
-
-	if (!this_cpu_read(cache_state_incoherent))
-		return;
-
-	/*
-	 * Private memory cachelines need to be clean at the time of
-	 * kexec.  Write them back now, as the caller promises that
-	 * there should be no more SEAMCALLs on this CPU.
-	 */
-	wbinvd();
-	this_cpu_write(cache_state_incoherent, false);
-}
-EXPORT_SYMBOL_FOR_KVM(tdx_cpu_flush_cache_for_kexec);
-#endif

-- 
2.53.0

