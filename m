Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6A2EC0B0;
	Wed,  6 May 2026 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032684; cv=none; b=CHkGH6F92cZYveRbM8PUYQYDJI3gSD27QgJ1d6VHhiCJ2/QYgNKJ3RGQOLm+JHMPwbUkZsQQIhBzERVSCYb3D2TPGHwxXWaRKiPNQAJklg0wbkrdMRLXHbWus1/eL5CFfj+zwawwQRlab+ObnHv6UbG+t7nwnxfdZiIeCz+uZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032684; c=relaxed/simple;
	bh=QSdeIVvdmKvVTB1W8EWGZfD3/JJ2ggJ/eyHVF66wpDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AygABAl7jp+sTc1DHq4LF8Kw/B2Pxc5kwm7fDXJNQD+a0UpuMAiqXkrFygoHZuZpHOK9dgIRzIYERw9bgb2rDz5zabr51VJeZEjImy2Quo41FbddwsW9HiIbjjSjcoEWbtYEgItUVbSeKc3m0jriZZkH+XFhTNJY2xsukADH72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx+7WnEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx+7WnEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74B6C2BCB4;
	Wed,  6 May 2026 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032684;
	bh=QSdeIVvdmKvVTB1W8EWGZfD3/JJ2ggJ/eyHVF66wpDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vx+7WnEcGUax3CMH3QK5KGjmadjfVqWtj2VCKNhqxI37NoY8UCusiZj5XRMRS9IWr
	 71vFDZTpqf+I2ACBcrcsVvKXWJTPiYzS2OkbZt1maEGFhk9NZwG4msz73QwlGgqBDY
	 k1zPR8zPKih04IHyvOhlYX5QGQ75K5cqUkLAsSIpICGnY9S/j4N0NcM0oQUVGLiFvW
	 wILXwwpt9nmjyChDzVHNrDyWWIPJYIg/m5JC+TB7ZHLwg/24dxt2n3K7szuOkIu95b
	 EHTXsTsLcg/0eKW9EzVrX9UJ6D2cys2BW9CCNM3ArUhf5Y6mSeHw3hkTvNFDpFI7+H
	 DCWuFW0j1eSvw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 07/16] KVM: x86/pmu: Check mediated PMU counter enablement before event filters
Date: Wed,  6 May 2026 01:57:23 +0000
Message-ID: <20260506015733.1671124-8-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the guest disables the counter (by clearing
ARCH_PERFMON_EVENTSEL_ENABLE), KVM still performs the PMU filter lookup,
even though it doesn't end up changing eventsel_hw.  Check if the
counter is enabled by the guest before doing the potentially expensive
PMU filter lookup.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index afbc731e72174..67dbbd4c73036 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -532,7 +532,7 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 
 static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 {
-	bool allowed = pmc_is_event_allowed(pmc);
+	bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
 	if (pmc_is_gp(pmc)) {
-- 
2.54.0.545.g6539524ca2-goog

