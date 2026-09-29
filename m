Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DD51AEC7
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687057; cv=none; b=Tzs1Yvuyjr6g6QK3kHm9jasLTlguz/fM1AvXiXQ1Fnne6Yk5n4K/thHurvF+Up4CdO2YcoWrZcqJhGPG5unasomOPQsxwpIatreV3q5IEmcBiWlR7wqyDbsRDRlzXKaASqw07CTv6k8YTIOsgpr8CNd2RAb7SYr7UdZ9SY3iMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687057; c=relaxed/simple;
	bh=iXQtKYVzI1WcinZxgHLLFl0aaU/3XJVMW6gmub25IYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKHQpcb01MV0ZhSL76r/Zu3knAB6nzsnQmVAKeXL9xkVTP/UEgqeKrIb8dJKpYNXjV/MoLzvJ4SVXELypaXbgiWOaRpOZHdHEjUhry3i9a2BjCQK49B8n08GLXIHLpFUVun6ZAkvZFbruZCmSLbJNg4qcslvOXCzg2nuQE7Ny1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckgUOkz9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckgUOkz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790687056; x=1822223056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXQtKYVzI1WcinZxgHLLFl0aaU/3XJVMW6gmub25IYQ=;
  b=ckgUOkz9GgS4bW79RaQADtBpMP4B62BczfHSz0Ui6yzlU76sRLjdD12l
   j/1URRUwRcHQ0qF5VdSnn+MAJOTp7Z1R3I86fDyhqbeBBTYfpAVxwAEIB
   n/qKKINEI0A8ieWjKPYDSLFCqvpvSAWmzx4Wsna2A2XhQDy2WTuHJffOV
   Tvd0BcJOu+WIydX0mhpkd0kaVFyb65ZVFxi8tNtZEKhvp+5meiRl+oRxT
   ppRq0OTttGPEoGGeUO3Hc8cqdfwKXA6KOH0npm5In20DytsimiHYsK008
   d9WQ6Vec90IXvLHtReHRL7hwE0P76MCboeDN2jQCV88oXITneNb7B2nb0
   w==;
X-CSE-ConnectionGUID: AY/DApLTQ5GdhGWcz4nbvQ==
X-CSE-MsgGUID: Ir64oVBJSPWkQm/qtaj9rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108894095"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="108894095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:04:15 -0700
X-CSE-ConnectionGUID: ua/E4rUMQ7ukdCDierlkvg==
X-CSE-MsgGUID: 77tnNh9sQYeMbDfpcMnvTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275397821"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa009.jf.intel.com with ESMTP; 29 Sep 2026 06:04:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [kvm-unit-tests PATCH v2 2/2] x86/run: Use separate "-accel" option to configure the accelerator
Date: Tue, 29 Sep 2026 20:24:34 +0000
Message-ID: <20260929202434.174501-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929202434.174501-1-xiaoyao.li@intel.com>
References: <20260929202434.174501-1-xiaoyao.li@intel.com>
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
2.53.0

