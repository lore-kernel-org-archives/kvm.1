Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61203497B73;
	Fri, 11 Sep 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163007; cv=none; b=WiuUY4S8PcaDvnZDY5SJeSw2gWcDqvZopxC7sBctZnCO4T0H/M7rgffoYZCJ28IYjBMb4YaCgtjmKhR1ZR2NmuM7y0753ZmuyRqwZm4x36caRhaqwtFXobtLuD2D+FfJUgvmsDMR71PFTvQ8ALVpzQ8kWz0+YshAFOLKzQTsA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163007; c=relaxed/simple;
	bh=qBPhaYL2eGX6F2cOv/irJ12oCM1yADz+gsM+AZjtzgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT+fay4ZzWvNdXzbentf1dlYWtn2HUissGSVcoYjC4Vo1ODk8+M24q9IZ3kqhiNLgontuSBbcLhCbjjUtqXQkNPPl6FAF9HKolpSqoUUOfDuBZfFTMvS9Lje9QCNuthG/TXdnhSW/5Y/SYQqvbAyLwPOgjpWWXW2O3vBnOGWLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+uig2S+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+uig2S+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163007; x=1820699007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qBPhaYL2eGX6F2cOv/irJ12oCM1yADz+gsM+AZjtzgI=;
  b=d+uig2S+Ka+1zlFcEB5HkIIqBQuRhGZ5eyXL/R+xcGrrDZTFVCz+5LC+
   P0PAXaXaqov7HRk9sK/Xf2v5Kz/KvVk3TRDl47yPJL2wcYGUTWwx/VS+v
   Ietnp4k79Bkf671y9JffWNa1bEdKV6kFiCUA2mVEZC//RqMLJmDEn925Q
   99sVmB1QmQdPM9pBh+wZsXXmTo9y3/0RdkklLIZv0dvh3XaWIaBrXAr+a
   UeDd6rUgJQ3ZiHoash/+8w8MEs77+NcRJPmP962cWapAHO/3v96d2c41Q
   AviwOgapv6frjb0J8P+81IXmT8gmnNQHCNrCqfaXMdvUyBjRGyWNxE+KI
   A==;
X-CSE-ConnectionGUID: jC/7S4gtT4iT/CIyeAAXBA==
X-CSE-MsgGUID: XkArfR/iToaBkcpVOD8zSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572891"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572891"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:43:26 -0700
X-CSE-ConnectionGUID: tpv0T0VbS6u+iEi5b0S7pg==
X-CSE-MsgGUID: 4/IXgPddSYSdHTELRhhzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004289"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:43:25 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 23/28] KVM: nVMX: Shadow ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA fields
Date: Fri, 11 Sep 2026 14:36:53 -0700
Message-ID: <20260911213659.2025974-24-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA to the list of shadowed
VMCS fields.

Shadowing these fields allows the L1 hypervisor to access them without
triggering a VM-exit to L0, optimizing performance for nested
virtualization workloads that frequently query or inject event data.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Split out of "KVM: nVMX: Guard SHADOW_FIELD_R[OW] macros with VMX
   feature checks" (Sean).
---
 arch/x86/kvm/vmx/vmcs_shadow_fields.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmcs_shadow_fields.h b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
index 67e821c2be6d..bdd56f3ca6c3 100644
--- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
+++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
@@ -74,6 +74,10 @@ SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
 /* 64-bit */
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA, original_event_data)
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA_HIGH, original_event_data)
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA, injected_event_data)
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA_HIGH, injected_event_data)
 #endif
 
 #undef SHADOW_FIELD_RO
-- 
2.43.0

