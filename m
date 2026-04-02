Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F6372ECC;
	Thu,  2 Apr 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111543; cv=none; b=QCQoVMv4n0CmMs7gkr0zemRRHt1Fpldu7avEYhWccDpzgysOFNZfLfqu1a1a1KBjAY++v/fPW5sUl/7YdDhshDoeJyICsOISSHNYl4ZZOXPo6ja03AW8Cg9TF5rrWl9C7QWfEpm1LT61Ahny/+LC3dPkghZ/pcenq+kqbQDQFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111543; c=relaxed/simple;
	bh=v4RCp3DgZwg8fGD7TLVSrb+Thlquly9ZhJsd1ten7VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKppfVg2rsz6k3hoPLc3kaB5Ic4hOYBSk4eKii256XQC6R5qzWUqmDPyMymoaRyXWIwmH8CP19voUSl3UgihTTeM/6RPUX1vqrq7LPjxJxExMgyDg+A3dUYUDez6gLwGX6FvZEKwngGhalX6xfqE36+YPYrgc+0DzJ10o1kqzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmRJPZga; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmRJPZga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775111542; x=1806647542;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v4RCp3DgZwg8fGD7TLVSrb+Thlquly9ZhJsd1ten7VU=;
  b=dmRJPZgacbj0osqniiwk4nP27rGsuZ0KhueRgJgbZQVY28RdCMijdbqP
   jgog34wu+fYiD+pjFrkm7sPBIycKABa9jD8XVoXmImYQPUG8P4AcNGewR
   ulVguYIm3KzQR6z2YVqYzP147VzAhknX/6jBwrKRmnsvuMtUu3A2pSbYn
   Za92QG1FYW8Fw4SDKSLvWF5NnQRoviWq64FNq/P15tc3z+CnrJ6L6gvV6
   8Xxi/d7OcaJ2zb4TnEZd9Lwp0q1tFr8VR+lQi6/VLhodHokk3+1bCu4eX
   tbYgPv3f+Uv8jJAUEW4w51GbelUqNoAwgOOye1ZH+fPNn5y1hR3O2o3Wd
   w==;
X-CSE-ConnectionGUID: 6ZvrQzVDQQqjscvihK3FzA==
X-CSE-MsgGUID: p7mSd284SkmyJWND8Ikgcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75884399"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75884399"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:20 -0700
X-CSE-ConnectionGUID: 0qbgdqQHTNOnsukidh3Pgw==
X-CSE-MsgGUID: cX5hRaTERj+ylDVSspsfAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="222042389"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.223.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 02 Apr 2026 00:32:05 -0600
Subject: [PATCH v3 5/5] x86/virt/tdx: Remove kexec docs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fuller_tdx_kexec_support-v3-5-34438d7094bf@intel.com>
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
 Kai Huang <kai.huang@intel.com>
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=1Dl/GZsjCRJsUxH+cy4bLVKZfjRWEh+bCymAu8RNUM0=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJnneAs6Pi20KT51sSVtatV2XobCA8tbC8JS3LhCPmmuS
 NfcdlOqo5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABMxM2JkOL38kd+85yvl9jSU
 Gs7yn2u3/fVax8MzD52bfmbKHeEWnkRGht1v8/+HnVfiPqzOvd72TtUa97yy2z/1Q8Uenomdf9a
 ulRcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Recent changes have removed the hard limitations for using kexec and
TDX together. So remove the section in the TDX docs.

Users on partial write erratums will need an updated TDX module to
handle the rare edge cases. The docs do not currently provide any
guidance on recommended TDX module versions, so don't keep a whole
section around to document this interaction.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 Documentation/arch/x86/tdx.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index ff6b110291bc..1a3b5bac1021 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -138,13 +138,6 @@ If the platform has such erratum, the kernel prints additional message in
 machine check handler to tell user the machine check may be caused by
 kernel bug on TDX private memory.
 
-Kexec
-~~~~~~~
-
-Currently kexec doesn't work on the TDX platforms with the aforementioned
-erratum.  It fails when loading the kexec kernel image.  Otherwise it
-works normally.
-
 Interaction vs S3 and deeper states
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

-- 
2.53.0

