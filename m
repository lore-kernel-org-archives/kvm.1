Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9C3E6DC1;
	Mon, 23 Mar 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299565; cv=none; b=D5juuczVyeSe7voyoWRcl9a5dgEHeOoc6WYuxBkAF+v/Q9i0SW6PSXvrhhULBmtT3pFAMvMsrrOKSHT23MtUh6dE4+IGopZrBGr+mKhgZOEtrE0ubZDZ+o7dF/cIVX59NejgM8euJcQ1ug8CvVPFZ4S7Z5S6HXygzROy/o4PIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299565; c=relaxed/simple;
	bh=ubH8RVGF2so+/+/7VbZvSLjM9vlewAIadlM594QwK+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2op923e8sfYV4bhFyZiqRwjToC+Ic4+p/frcpdT1h5S7KujxwOYjo59a0bmoU3ZN25n+tT4rllf71CiDx2aFfzWAU6xDPPxpYL90R0c1Av/TC/QJkL77xQ/In63P7H1jz6RbollnOld1+F66kWp9fDALSLgDf/xrKDtZbntABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZtjijTZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZtjijTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299564; x=1805835564;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ubH8RVGF2so+/+/7VbZvSLjM9vlewAIadlM594QwK+M=;
  b=WZtjijTZf2NRBA2xR9zKUY9U+UBi0wGZnW3QJlNzLK1wgNVuU3LUdVws
   2jxXAwUKke1vo27FXTBVdXJ+lA9PjeU4HNJgt66V2R2tlSm5FHcLUta3T
   abLQq7aTjzQl8/Kj/DZxO0OdJ5r9ZDgxFk6GquVrKvPrW6b2ezqWx4Woo
   Eo2IuVOBc2aD9N6gWuxrq2Uj/lt0dFyem3o6zQvyHuRccBJXBcjjyfMYt
   CtCEuCca8jze8KMs0mhqKvYTdYkrPeM7J1GPRYFU/ISgjkHCg+nPcHlE4
   QJXvT1CLvMMO+do8XdcLLQ5GjUzKo2b/cH2vhBONnj3xNESfWiHEtvFwb
   g==;
X-CSE-ConnectionGUID: ED9UcQLuSImdHVXYZqrnHg==
X-CSE-MsgGUID: EX0Y0STIQj+44dNdEhLfcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74491145"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74491145"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:22 -0700
X-CSE-ConnectionGUID: HdZtdTYER86SMMZEokeEMw==
X-CSE-MsgGUID: Krm3cOcAS2G3njxUOMqI6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224156863"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.221.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:21 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 23 Mar 2026 14:59:05 -0600
Subject: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-8c19c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=pZWrnyf3cSew4qBVy0JtSlpvCZz6uFzhY0igFGY8cTM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJkHVy6bNcknOHaNZnbpiWM9GXHt+ifTDitJ9fWap2lPK
 GCyKl/cUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIl0H2JkmHk6WSCBM3H6GqMX
 fr36Ksc5IwPnX804k2o9IbnQNr7yLyPDlfqakEkp6YyX3n9N+BTVPs+1ZtvcqU5fLqYrnGJ3jJr
 CDQA=
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
tdx_cpu_flush_cache_for_kexec(). So the centralization to the arch/x86
syscore shutdown callback elides this CPU offline time behavior. However,
WBINVD is already generally done at CPU offline as matter of course. So
don't bother adding TDX specific logic for this, and rely on the normal
WBINVD to handle it.

Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 arch/x86/include/asm/tdx.h  |  6 ------
 arch/x86/kvm/vmx/tdx.c      | 10 ----------
 arch/x86/virt/vmx/tdx/tdx.c | 39 ++++++++++++++++++++-------------------
 3 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 2917b3451491..7674fc530090 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -205,11 +205,5 @@ static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
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
index cb9b3210ab71..0802d0fd18a4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -224,8 +224,28 @@ static int tdx_offline_cpu(unsigned int cpu)
 	return 0;
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
 static void tdx_shutdown_cpu(void *ign)
 {
+	/*
+	 * Flush cache now if kexec is possible: this is necessary to avoid
+	 * having dirty private memory cachelines when the new kernel boots,
+	 * but WBINVD is a relatively expensive operation and doing it during
+	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
+	 * now, since this is a safe moment and there is going to be no more
+	 * TDX activity on this CPU from this point on.
+	 */
+	tdx_cpu_flush_cache();
 	x86_virt_put_ref(X86_FEATURE_VMX);
 }
 
@@ -1920,22 +1940,3 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
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

