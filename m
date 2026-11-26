Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660251;
	b=VI/TN/fUSjHi6h56Pvzaenb6eIjbYjaA7Pr8F++9/tr9tFfRNoER4nB3y+3PAucecGhc
	 z5GHVnK9wwRRZqG6xSrBW3v/QMoBtOShU5//F38z5vjYqo6TxumqFmqIDBZKynNYQhELs
	 My74lvwRnM4E6DcXy7QAT0ZPZLew17ne7BMYnKGRId9PAwWz7pPI7fT9TNNtwVZMKt2sW
	 5UjgiMMcmaP+QRV98tiJTsrurH/dYRNW7X5QcSErHuQ1ca1Mswimmy1adveVWLkXWsh8s
	 TXM/owRkMkzVJfwpLrCDbN8dywsNf126pqs58x9N0ACz/jDaPMKioM9cubFF0u08WyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CX5vZojkBiFMxb2L5ex2Oi1lHJ1gKjpCBFk5eLD6wqI=;
	b=m3fgh3WDghyGw1D9WyccAIVXkBZ++R4AY+m4FLNyzS7hh+Y8viPJbqekd1nK6GppeHbu
	 0ffrk6/beIB5RmSuQxP5VBwNvXjWK4D4y/6GG2aO8A1I0yx19gJhEQKtyV+FQ52gF/15e
	 ChkffArbHRvo7pCauVFSOj7nEF7q9ARe9VvgzFU21I0vUUQNHGzNwQ65tO7kbL9S+oumM
	 WWVb2vqPW1t6d7Fvns183AVN2+m+ankmJCZPx+sa7deZ0oU6kN8mBeYkg+aG87Bjgxd+C
	 RvYywRCZFCyAYnpvmtUB10rb0Xnx8N6o6J6R/RxKb6EmUiO2Ab3RSTmmmggULdrPGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RTLAHo4q;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA60606A329;
	Thu, 26 Nov 2026 02:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA60606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RTLAHo4q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795660251; x=1827196251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvQxt9L7d51NtEGJRRvuICCUJGnbulcXPO/HzifxsWk=;
  b=RTLAHo4qBot0XtUyKzH3UmIeqpmz+rRX9R8p50sIL+LLFrmx+rbem/Ek
   eFf7iA3DvQQqyvr2BUpalfPDVtHu2mf9+jf3wMuWFW5X997/O4Ug7VGLh
   1vtmGLaO8enIunFwXQoJxbkOLlGRLn6xZE14LgO5bvwDc5thAySd7AsmF
   I2weBe8P7uiR9SbpkhzIGUTIB5kRJJCxhfeztyESH3W88jiEqxdiF1gT6
   wrAqrss16FLwn40xwco/N/cbwuljL9AD0dhH4D7gYYX2mURtwMn2SbM7d
   ggG1otRnV+wGVnbDqLcIR3EJmEFZTW3OIGhU/fmfqghVKL9l+r/NH6txo
   A==;
X-CSE-ConnectionGUID: hFQCFmN6RLyUsFK9fbHuUg==
X-CSE-MsgGUID: zd1K9TpiTMywmHHtYFGlRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4642528"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4642528"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:30:49 -0800
X-CSE-ConnectionGUID: KzALS9PoSTGakz61MISFRg==
X-CSE-MsgGUID: b8JHV9N+Tp2prbzAa9kG9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12044179"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 18:30:49 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Jon Kohler <jon@nutanix.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] KVM: VMX: Treat partial support of an entry/exit pair as inconsistent
Date: Wed, 25 Nov 2026 18:27:42 -0800
Message-ID: <20261126022743.4082392-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126022743.4082392-1-sohil.mehta@intel.com>
References: <20261126022743.4082392-1-sohil.mehta@intel.com>
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

The VM-entry/VM-exit pair check only requires one of a pair's exit
controls to be supported along with the entry control. That is fine
while every pair has a single exit control.

However, a feature can have multiple exit controls paired with a single
entry control. For example, PAT and EFER each have two exit controls,
but KVM doesn't use their save controls. In future, FRED will use both:
its state is loaded on VM-entry, and both saved and restored on VM-exit.

If hardware supports only one of those exit controls, the existing check
passes and the feature would be enabled with part of its state left
unswitched. Require all of a pair's controls to be supported, or none of
them. The existing pairs are unaffected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v1:
 - New patch. It addresses a gap Sashiko found in v10 patch 2:
   https://lore.kernel.org/all/20260911220046.1A4A91F000FF@smtp.kernel.org/
 - Doesn't include a fixes tag because all existing pairs have a single
   exit control.
---
 arch/x86/kvm/vmx/vmx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3752a86c3fca..d35bad8b29a7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2716,6 +2716,11 @@ static u64 adjust_vmx_controls64(u64 ctl_opt, u32 msr)
 	return  ctl_opt & allowed;
 }
 
+/*
+ * A pair may consist of one entry control and several exit controls. It
+ * is consistent only if all of its controls are supported, or none of them
+ * are.
+ */
 #define vmx_check_entry_exit_pairs(pairs, entry_controls, exit_controls)	\
 ({										\
 	int i, r = 0;								\
@@ -2727,7 +2732,8 @@ static u64 adjust_vmx_controls64(u64 ctl_opt, u32 msr)
 		typeof(entry_controls) n_ctrl = pairs[i].entry_control;		\
 		typeof(exit_controls) x_ctrl = pairs[i].exit_control;		\
 										\
-		if (!(entry_controls & n_ctrl) == !(exit_controls & x_ctrl))	\
+		if ((exit_controls & x_ctrl) ==					\
+		    ((entry_controls & n_ctrl) ? x_ctrl : 0))			\
 			continue;						\
 										\
 		pr_warn_once("Inconsistent VM-Entry/VM-Exit pair, "		\
-- 
2.43.0

