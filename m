Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729653DA5B2;
	Wed, 27 May 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925645; cv=none; b=lfJoKJSnLjs+lYNNDfTRCgs+LxCZdye5UE07yTILuYqloCehx0J4sqCoS6SHaVvVzQTedB8vgaMZDMudW854w9T59M36XcgE4gA+OWMaGpNdQbOKp7lQic3Lf9Ygmq7q/ShDqq1a+SJjnQ2j8qlW8Rz5m7PGh7Nrwdx8uUZ+Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925645; c=relaxed/simple;
	bh=/FJ/pHWRgLiuSDRymygjv3hpBEpE82SbBkGfJgNq6pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPi3MGaIPwrfWCVMzlIqbsf4A9prDZH+5cVj8JETqUzuG1RQIV+Eesw65dfW/X58Y3sWW4NXL7bYs2dxhGy3jd9WYS3UE6MWqfUe6vyrH3syiOXvFa9ZAaX8dxiCRgtn79L42wIi5jsFfS8r/YRorPPGTvplu/VbR4kJS9wLSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZbn4nU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZbn4nU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65F1F000E9;
	Wed, 27 May 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925644;
	bh=jwzvNaDhgxzGSMGoezFqYQOSgXb6nd5oUPgLydEYQFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jZbn4nU1G6XdC/6AERLGYW4R5i1ELcIYVPPxDB5dDTH6vDFsHoYEdwZAjqSExJdZs
	 Kucae8vJgbsd63T9Q3NCrwG7FErZvkriy1OaEzvnXZc6w+wRHB7dFCUvgRkY61Esau
	 NNBD10oK9HpGWm/snq+XtbQn/MlwRq215dTim35gi/kHPT/5EBCysuFae4DZn+5mHi
	 8YUlQNk0AF9G7cwybe02P2K7QEhO/4aoxC6n2xV9gOk6IOsfUC9ob4iwUC8EzfYFkx
	 hx8jor3aP7OTKPXaC9wzJXOoLO21BSeZDoSIPSZyD0RWQA+mjYYIc06vtED4TI7EEa
	 glk1kwpICSE1w==
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
Subject: [PATCH v7 08/17] KVM: x86/pmu: Check mediated PMU counter enablement before event filters
Date: Wed, 27 May 2026 23:47:02 +0000
Message-ID: <20260527234711.4175166-9-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
References: <20260527234711.4175166-1-yosry@kernel.org>
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
2.54.0.794.g4f17f83d09-goog

