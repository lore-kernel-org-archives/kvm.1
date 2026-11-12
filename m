Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516231;
	b=RkavoUIdyPIwX1kyiptOg1VQK4W7comLA1RdqKleMSQOJECQercDd5DVXgABNnizoL6S
	 rdqwCAisVtqVSwHCW1dzPYJhioYkspotp+PLTZTQ2hE6235Y1Bbf0tvdiIaQr3P8cahIl
	 Oqug6q7TMf/ze2jEJIxHVxj/e0c9T9lLorU5XaOjxzSbEuSTlwA6cVJiHC1vRSDdVCHbF
	 qVHIc5V6q10ex9DYQKM9Yd0ym75zIBF1+KHAB8qg8avYhzdZcnXCcuwrIa6MXpvG/KQzE
	 Y5XfU5frqz19fhrX9cSJa2VpWs2QpcQnC65Gt2Svg4o3gYROCoK5wcwsumhD8yY5JPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nRMqHtE2F08aAVx2XZ9DJ00VJW/b5A6T2uU3fUPe6Og=;
	b=XSgl3kFMD3uRaJEfShtWHumwpGAE+HY/cLmZImeuh4pRACO+SM+e4MErs5azw27gLa6d
	 uKyxaot7wmRh1Yy6mAIlG/AyxZ82BRMXMV/zOYLapv+TJ4YXgmldoz7F3DGAjVpKuTayq
	 1Df96KrN2zDu+yVY1H/kepo3Ltjh0WX/Z0s5jqLfB4Lm348RgiZ2yJt1s4Ju9Xb6iX9Cg
	 KABnTm31JhlvN4ZdhMMJ60G2yspU85CCC/jLGEdN6CR0aMuuzqhYqMgVP+crPLU/HJjdJ
	 5Z0KkO5JB408VIuGW/GplIdLyVycU2asm6mIWqFVlDrzwYw+zgQ7Q1BUwf1/6ICfGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBZM2kyL;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2860A3834;
	Thu, 12 Nov 2026 20:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC2860A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBZM2kyL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516231; x=1826052231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jHJhpiqVnuNPTSxFcUKkmYPLgqVVP/LYG7XzOROljRA=;
  b=nBZM2kyLTUkeEU9/soZoS9JNnEVSW1/MdPnWvhQOFq95xYrfFfUdoczD
   7jLlt3eag1z7MEpA9Xfo6KOlbDMmcyI28ex/dUtgt6K/YJEQS8eH2Y0zq
   iaR+tSTXUHs7T1oQ6qMITYezqTLAYW8/W0a0WCyr9krTwuE0fNW3Pzscx
   r3gTbsyNt4oN80sSKakS67GanM7Bv34+vBy8aIA059uVsTY91WOip+Rif
   LeQIThtp121oFI5YJlg2eZjpsFsqQ4Pa4cGab41IVYfuAazbfdtjnup/c
   04jJOiMZRWDs9yN8DHgD+VnKuWN8jBepxizqbF8nNaFBg85P7oQ1WxE+g
   g==;
X-CSE-ConnectionGUID: lub4AngIRhibPiGWbukYbw==
X-CSE-MsgGUID: ePUsfDFRRiu6Lzq3puXWgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192300"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192300"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:51 -0800
X-CSE-ConnectionGUID: VCXF+8HQRO2eUoz6C6iGsA==
X-CSE-MsgGUID: U5bzPJ6YQ1mMIIKEaJaimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087922"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:51 -0800
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
Subject: [PATCH v4 15/21] KVM: x86/pmu: Clamp pmu->version to kvm_pmu_cap.version
Date: Thu, 12 Nov 2026 13:32:21 -0700
Message-ID: <20261112203227.289379-16-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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

KVM's policy of not policing guest CPUID allows userspace to configure
an arbitrary PMU version without KVM rejecting the ioctl or mutating
guest CPUID entries. As userspace is responsible for validating its
configuration against KVM_GET_SUPPORTED_CPUID, userspace is entitled to
"shoot itself in the foot" by presenting an unsupported virtual CPU
model.

Clamp pmu->version to kvm_pmu_cap.version so that KVM's internal state
tracks the effective PMU version that KVM supports, and avoid exposing
or emulating features that KVM does not support (such as MSRs gated on
higher PMU versions).

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- New patch. (Sean, Yosry)
---
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5eac64ba8832..0be9956810ae 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -574,7 +574,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	eax.full = entry->eax;
 	edx.full = entry->edx;
 
-	pmu->version = eax.split.version_id;
+	pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);
 	if (!pmu->version)
 		return;
 
-- 
2.56.1

