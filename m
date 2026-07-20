Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9111CA9;
	Mon, 20 Jul 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575408; cv=none; b=Vo1DjfaeegqtxoP8mwzA0AF2yi4Ef6pYV5rIOcs95mvO4dYiYDRslwvwopX1gBkHf7iAURjbg1MC2HMP3Tz5jF+C4q/sd9h0TqRPgoENccweD27Ln8+q19V30l4ExIKP3xulEpPxToYTj5pU+OM+UpMOEm6IgYHOadsvsc2DvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575408; c=relaxed/simple;
	bh=TRiuguRItySlbPwizpn4GkO3Y71fhOai1puU1Gy/cPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtz8LS7SmdI8KNIhoR8ndlBkIsikJCxOMCup6AFBmIRSXUcW1IM2zDDUusRT9wTYIQaqBCzPWfEAUoUgmV17w9IXD3jRSWDOt9oL52owhOelNFZ7YneBY0WjmRXvIYoOOFAPVE8zJqhJHJ0O30q4aamDgTK3h45LRLc+Ds3LLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=LsXC0ANg; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="LsXC0ANg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784575406; x=1816111406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=681Fg1jCYGiji9zRKTB13CAIrE4XW3H7E19a8j8GXK8=;
  b=LsXC0ANgrJ+TRbrIzpXf4eWdkYV1AkuoYRScwnGUTd7YnM1JuaUC6NjJ
   GsUTC3qx78GQUkhf29JJOLUdGsIrmEcoNZdWZwiY6VL/+Pywu4mIM6ep5
   4VO15L+btrPhEKBjjONf740nVEqftwuHH2Ro/gzLGhiOqMjE0FaqEElSv
   bGvGbnsvZFOjM6Vxbi7OWHlX1zO1B6VQdB8VtJcqtkZhRcT1mNK6lcyLk
   m7+x7AAQYQKDW/FE+ibymqeH7668glFUG6RDV51Qaw5IORoCml1nySJbS
   0vc0h1M8jjhVZ7nP+f6wxIuNr8efe7ErI+Hk5t5E+1GPvC05HcoV0WTbM
   A==;
X-CSE-ConnectionGUID: NmMV7hu+ToWNw6AKQN6MdA==
X-CSE-MsgGUID: lkwUfObZQwOhSsRcQJmpLg==
X-IronPort-AV: E=Sophos;i="6.25,175,1779148800"; 
   d="scan'208";a="23883343"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 19:23:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6756]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.147:2525] with esmtp (Farcaster)
 id f4c73529-93c6-44c4-ae18-9bb2ae75b162; Mon, 20 Jul 2026 19:23:23 +0000 (UTC)
X-Farcaster-Flow-ID: f4c73529-93c6-44c4-ae18-9bb2ae75b162
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 20 Jul 2026 19:23:23 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 20 Jul 2026
 19:23:21 +0000
From: Luka Absandze <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Alexander
 Graf" <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Luka Absandze
	<absandze@amazon.de>
Subject: [RFC PATCH 2/2] KVM: Documentation: Document KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING
Date: Mon, 20 Jul 2026 19:22:21 +0000
Message-ID: <20260720192221.72912-3-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720192221.72912-1-absandze@amazon.de>
References: <20260720192221.72912-1-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Describe the new VM-scoped capability: its parameter (a bitmask of
PERF_COUNT_HW_* event IDs), the value returned by KVM_CHECK_EXTENSION
(the set of events that can be disabled), the accuracy trade-off, and
why an emulated-vPMU host wants it.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
 Documentation/virt/kvm/api.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a5f9ee92f43e..231a5ba7567c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8949,6 +8949,38 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING
+------------------------------------------
+
+:Architectures: x86
+:Type: vm
+:Parameters: args[0] - bitmask of PERF_COUNT_HW_* event IDs
+:Returns: 0 on success; -EINVAL if args[0] contains an unsupported event or
+          if the VM already has vCPUs.
+
+By default, KVM software-accounts instructions it emulates against a guest
+PMU counter programmed for retired instructions (PERF_COUNT_HW_INSTRUCTIONS)
+or retired branches (PERF_COUNT_HW_BRANCH_INSTRUCTIONS), by walking the vPMU
+counters and requesting a counter reprogram on the next VM-entry. On hosts
+with an emulated vPMU this reprogram is expensive and, under some workloads,
+inflates timer-interrupt handling enough to trigger guest CSD lockups.
+
+This capability lets userspace disable that software accounting for the given
+events. Setting a bit for an event ID makes KVM skip the accounting for that
+event: instructions KVM emulates in host context go uncounted. Hardware-
+executed guest instructions are still counted by the backing perf_event, and
+its overflow/PMI path is unaffected.
+
+The capability only affects the emulated (perf-based) vPMU. A mediated vPMU
+does not incur the reprogram cost and increments the guest counter directly,
+so accounting is never skipped for it regardless of this setting.
+
+This can only be invoked on a VM prior to the creation of vCPUs; attempting to
+set it once any vCPU exists returns -EINVAL.
+
+KVM_CHECK_EXTENSION returns the bitmask of event IDs that can be disabled.
+args[0] must be a subset of that mask.
+
 8. Other capabilities.
 ======================
 
-- 
2.47.3

