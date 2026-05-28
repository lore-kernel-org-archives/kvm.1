Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29F277C9E
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953481; cv=none; b=DLJeWSlYRq96PFmxyBnfgxMnjl3I3lYuetbxY3T+aFstp8yPD6VE/m3uHeyJbvmeuDOFRP1efR+2rQye/GWTxXP85arzWI74kFDsa9a49F6kvuDoNk9F+oIlGtfPMHydmFgtEU7w2FRZeZBLGAEWWZIfjFH0WpkhMCXQMlZ4k+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953481; c=relaxed/simple;
	bh=1RJjBOLneQL99bQk0fekuC01F3RhLTQwg1/a0a0K6cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC47muMwkkZXDGk/6oLXH/W6cOFXZIt/JRS7VYVHrUY4LYXA90nGSiHOe+ekPr7zwg9iNiEAFtNmaIMybzi2MebmU2qy5TEMKK5HKWA5uo+0hjXlVlPVO/W1eE2hYP+ykdSA4Jk/NiULPuHOiJeRwpP8J0iTxMWbvJz+PUQgvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLq2K3VQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLq2K3VQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779953480; x=1811489480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1RJjBOLneQL99bQk0fekuC01F3RhLTQwg1/a0a0K6cE=;
  b=PLq2K3VQhAryv7UdE/aKdzTq2dGypXZTCvM9rUrylItQgtq10m280MlO
   8+3VitYp+lzgO5NhC8puB6NynAbYEJcxEc0F26DNv+FTT9vW5/YOhwSQo
   5kxRjZryUXSDnZjn9vk+BEOmmSecReYsSGeOdMMnsJOG156OSYQbEB8I+
   6uo3UK+qeoM5oT5zMeG6fVcUrWU5SLS8h23Fv61YZIjKKprkWiXsPPOiQ
   MHymJ62XSgEaXeM2a7u//74dXc1BrqHoMqwI8zEaX0nUpWjx6XfCek2FO
   p4MXW8HKYHyNupdAdlQG0UAz8lnL4C5G56C5BBT032SIacnJK15+ufDqa
   Q==;
X-CSE-ConnectionGUID: StrxOC+FQRiRzTUN0NmoiQ==
X-CSE-MsgGUID: Rz3GSM0ESv2xdQItl+Ph9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80978706"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80978706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 00:31:20 -0700
X-CSE-ConnectionGUID: pXN7SoeISoKeBmE4xg2jeQ==
X-CSE-MsgGUID: k7g44lBKRdKYujZAlMBD+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="280586095"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
  by orviesa001.jf.intel.com with ESMTP; 28 May 2026 00:31:19 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to configure the accelerator
Date: Thu, 28 May 2026 15:17:12 +0800
Message-ID: <20260528071712.1407929-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configuring accelerator via machine's "accel" property, it cannot
pass additional ACCEL_PROPS. For example, it hits following error when
configuring KVM with "notify-vmexit":

  # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
  #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found

Switch to use separate "-accel" option to configure the accelerator.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 x86/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/run b/x86/run
index dd38f14c871f..a68d469dd1b8 100755
--- a/x86/run
+++ b/x86/run
@@ -43,7 +43,7 @@ fi
 pit="-global kvm-pit.lost_tick_policy=discard"
 
 command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
-command+=" -machine accel=$ACCEL$ACCEL_PROPS"
+command+=" -accel $ACCEL$ACCEL_PROPS"
 if [ "${CONFIG_EFI}" != y ]; then
 	command+=" -kernel"
 fi
-- 
2.43.0

