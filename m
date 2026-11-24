Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557205;
	b=F6yj+fH7DQ60HMXICNHiWnwFhwIDp3ufm5OBc2rIIecyh3mm7ywvJhOuW6qAcYFsmcR5
	 ZrA0aYoLX7VAokQO6c4JmupjSWk3OX2YD9KyTEYEXYDULWEW5A1TDW89pm5cnhyWhLULy
	 Y0YN7PMgDTbBYkSsF8Am5hsNyuW2drDgG5D84T6TLUqzzc3B2XvHXmex5w0obWlg9YDM7
	 GEHvndhx2GqV/qp9jZkeoBHQ/vsacvszV3xnUaP5IWyTTevPSf5+TYVcXbsYKfuu0jkOQ
	 zDHJ0uwqTs5hpCjok+dgV/IPhgpI5s05Vmq4tC/GzcVs2qTC+OI7kOF+g36V9wBgXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aXlabSfwlG6od/MfPPhNcq3Y0NUc2XEA70E96ZweIZo=;
	b=sWjMIOFZG8WkUCD0demepXXiCr6gxWhc4BH5Co71IxY0MDPITKmmsQahbwlP6ytGpwCN
	 Scf5vPV+DgKTNh0XDwn44s+0Lpwcuot6fk+FRtwYqI1Xr/1IdylAacEJIn5zPhl4bu0b7
	 2CmQ5fEqNpSO+PMDGq3qTTsTh8glZtZUDIxm7fvhmcTcrWA51YKjw2DyU+5s3ABKQ2wsH
	 3eqrCB53yqh2wIGOePI8p89zIPciijQpVjryW+AXNv3kZc3rydJ8ux16vERfbp4BlSVSK
	 +4fE75d4SUVMUBJSvm45n3d3aXvbieHpiToFtnsdzqO/VGd285wXq55kDIII3eC+ouQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zo4pb0jS;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C498606A686;
	Tue, 24 Nov 2026 21:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C498606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zo4pb0jS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557206; x=1827093206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1eKyLWRi1xIiI1gLfcXqg7LMZkM7UjC6uG1hPiWjwpM=;
  b=Zo4pb0jSMVd4yMivnMTAHI2X7/jnQen5IIbr87XdNw6lPW+ElAgENJl7
   0x4RwZxr41xjZGW8BZbYTZGnR+VSfstY8mmy5aBu7XuFU36tSHSx0yLO9
   yJ1epeRHEHbBMdJDI91eu9mEAz1DQLUyJ69MBRutTUmySTLbxnaFv8LCK
   ezeOQJV7a5G8TMgEdObMvIE24G0TqP+hCqJWN1l04bErsd/FAgxVf3gXQ
   120yIqK5k5aPxVn7ZysK7W/z5QHqsuevT+q8MkSbHWtRLLfLK6KuFaal3
   UVcNYWZXuOPYJMMuarGV9jZ5W02peEKbAXiNGvrtrcmJYl8DVtyC+yToh
   g==;
X-CSE-ConnectionGUID: RwvWfOvXT5CLvRaM74epVQ==
X-CSE-MsgGUID: eeUeWoJESV2wdiy5Dl7CSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4305993"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4305993"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:24 -0800
X-CSE-ConnectionGUID: aDXtY6A1RgCuxKfk1cm9qQ==
X-CSE-MsgGUID: iF1R44bhSLew8wrenOrbmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271902"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:23 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v10 04/18] perf/x86: Expose perf_capabilities to KVM
Date: Tue, 24 Nov 2026 14:38:47 -0700
Message-ID: <20261124213901.120572-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

perf already applies model-specific errata (e.g. RPL018 on RPL/MTL)
and sanitizes contradictory values (e.g. clearing pebs_baseline when
the PEBS format is < 4). Reading the MSR directly in KVM bypasses all
of that.

Add perf_capabilities to struct x86_pmu_capability, next to the
counter counts, bit widths and event masks it already exports, so
that KVM can use the validated value.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v10: New patch.
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..770ca960fa6e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3164,6 +3164,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
 	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
+	cap->perf_capabilities	= x86_pmu.intel_cap.capabilities;
 }
 EXPORT_SYMBOL_FOR_KVM(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ca630bc282fb..a68cb7c79d8b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -308,6 +308,7 @@ struct x86_pmu_capability {
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
 	unsigned int	mediated	:1;
+	u64		perf_capabilities;
 };
 
 /*
-- 
2.56.1

