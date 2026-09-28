Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915C3B7776;
	Mon, 28 Sep 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586593; cv=none; b=Gq00Q2f5WQn0kXkTkeCSBIhHDePy9/P1+sQ6Ob/tzwCV6rrBlIRPVwErQBRwlG2c7BSc877H2WS0kRmpx/3ncr3ubR4sN2c+qqIDIAbPAo4N3uIlINhjtobGMYPguSUD7rlIQYHiaZ/ofTwR6X4CWg73TiHkgDysOinNYJMlTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586593; c=relaxed/simple;
	bh=P2sa0Vps4EqQqHHu3WNhLTSJKChchQeJKOg6ephX9QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5pERb5en/5QrTbvqkGMuTBjvI1m8cVrkdy29/hjv4ZuvIx0M5esZoBAlNBGiNFbo6B+UIHsR+g//Ar4NdJKKxbb+8MphkQAP5PDczarIZ1PPTGoPjPLI1DjRBW1GQUhjBZH6vJmuXNhc3eIuBfU+EtLYeGI2Zmzj+9Hd/qyy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i85yfcug; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i85yfcug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586591; x=1822122591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2sa0Vps4EqQqHHu3WNhLTSJKChchQeJKOg6ephX9QU=;
  b=i85yfcugybDX7nuxTrnaFj5F4Rj4mtPLgFcCKubyfIw/RiRCgQYRhxtZ
   /bnw+ZFC0gPH4GWThQQa27w12OsamRd+TzoNJjfsf8lQwdn8NRuz9Jnb4
   aA8IpmceQ0rIYkiK4sxfuxB/JyjlyKQgY+vvrCmquLVg2oZN+cMSQ+QUZ
   n8pzrSWEfRaRwUz9nhRTY18tqGhpyZyqCExxZ0Ak58rxnWIOcTJX/3088
   vMEq6Wubw5u0rNVXwwofdS8tVeuA1qRKnqOUeBeQTG+cLvdcP0VfJ8Y9W
   mo8H7gI/c3Kdcq3OrrmV0uh+pAKEk4iUU+LaHLpNv+Ue9tMlKkpo7wQ+s
   w==;
X-CSE-ConnectionGUID: rxXcSGOkSz+p/EQqyRSfSA==
X-CSE-MsgGUID: AcNbM9JXTtytVQIPsg6qoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90184581"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90184581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:50 -0700
X-CSE-ConnectionGUID: ThjlGFXYTkyS4Pd3dj0ggQ==
X-CSE-MsgGUID: eOuhlCEHTyeXwaKu7o5aRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301280037"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:44 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	tabba@google.com,
	ackerleytng@google.com,
	michael.roth@amd.com,
	david@kernel.org,
	vannapurve@google.com,
	sagis@google.com,
	vbabka@suse.cz,
	thomas.lendacky@amd.com,
	nik.borisov@suse.com,
	pgonda@google.com,
	fan.du@intel.com,
	jun.miao@intel.com,
	francescolavra.fl@gmail.com,
	jgross@suse.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	chao.p.peng@intel.com,
	chao.gao@intel.com,
	farrah.chen@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v4 03/17] KVM: TDX: Reset private huge pages after S-EPT page removal
Date: Mon, 28 Sep 2026 17:08:45 +0800
Message-ID: <20260928090845.15518-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260928090729.15468-1-yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Resetting" TDX pages is a workaround for the TDX_PW_MCE erratum. Once a
leaf SPTE can map to a huge page in the S-EPT, the entire huge physical
range, rather than just the first 4KB, needs to be reset before the host
can reuse it.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 410c149bf776..11792a490330 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1865,7 +1865,7 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return -EIO;
 
-	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
+	tdx_quirk_reset_paddr(PFN_PHYS(pfn), KVM_HPAGE_SIZE(level));
 	tdx_pamt_put(pfn, level);
 	return 0;
 }
-- 
2.43.2

