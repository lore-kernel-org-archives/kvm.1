Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED24BB5BB
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270998; cv=none; b=rj3TfMN8mtbA2IHpWiw2RkmM2OwPcT0deWkpRJrlCRyrUFfXUrbW0fhx7Xxd/wUCTkUAywd6V5Camf/MFfA3uLcCeSO7mQT/nVXe+i6akIQgqgnWBePO20ulMIP3BOyg097VqhagmvrGNUoHLqNmX/mFj4+7FR3qFrm/bq8bqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270998; c=relaxed/simple;
	bh=dPoD2KWcJdBMoqLmCayL0dkgGb1iTFvhuDn+uK1Rbmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N6QdccY1hFN8g5SvYTKIRjosaeKGSwiPoSLZPQOOZWbIFWsTaKdGnjHHGzvT3+dxEhLytV4cTf57eS+kv6Gus/FSGdXvNapvIZ3j3Qq7UAbzdqcyA2BSXNXIhXLNV7fhpTuFxaWaK/Jz+0JSkE2EQLD1jjCQCm7q9ddOlDTG7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EU8Ov6Z7; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EU8Ov6Z7"
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-809f1af7992so32922a34.3
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270994; x=1790875794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UB2VMD+EAaxdax2pXXlz1H3xk/sziSl+ovTL17nQcA=;
        b=EU8Ov6Z75sR8iDCSGvFyuaaGAbHJELDc1BhhbNWJ3zAAG/VEs1h75AF2jecQfpSY3B
         t0Y4Q8H8B5DK1WFB7i6sri4pD5D1dl7rwcDmerSTTNlFA77LGJ9Zw1exzGZpuBkijOGR
         tFdvW4IkerZwaxPOZkotdpS54xE1k+HyucmyhA03aSNORRFYG2oqMXeNW70U7fzsmGuy
         W4NtzZ+13e2gvKS/UgdETOJddXKJUnypX9YOoGksdvlL7wIoqVpHg6YE+hMRF1lJpZvD
         5QoGYyGYDIRfQD/jWVY1YfJmk/F5dlocLvR6XwY7h88BsJnVMWxSOsvqtZNrHBlsOzmF
         kO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270994; x=1790875794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UB2VMD+EAaxdax2pXXlz1H3xk/sziSl+ovTL17nQcA=;
        b=vlqSz3LphQwmKunaJvqrlX/3FF7AFOTfHK1MDDn3p8PZ6ytJzrsMxk2lI5TF93Gj6e
         s+0Fl/8WEdR5qKmtbUhZqjTbAvfE0nw0irM30YAdiNdk6Sx6ebzny33VEauw4yOwwYAC
         BffCb4UtSE/nPh76sI25OLBn8ieGH7tpFHJ1CI1m80eNzo44q9ut643g2Q8J4rZ+evZt
         rmgvPCxfbMnqZ+M22QN2tGoJ0OGa2XH43x27MPg8InhGm6S2ePWGr0iKIHhGMO5eJTSF
         /QnrM/EogNBCF+/i2OTQsREu/U4KnXUjHwqTrQgw/biRpCMRbBVOez2eTVVw7FeQzvPU
         EK5Q==
X-Gm-Message-State: AFuF++llQVZjjVCChu7qLK28W0h9uY1nzbqc0enLSOEsmo0LUnFFLINd
	agxxFvk7UZzFO8Qp4jqZp4ceqeQD0f4Jq8KrBhekTEjThj0DElUlDGHXX7+ebo25uhWkuSIizFX
	3JAtyJloOwJCSuiPAyCNsmMuv3nJ2ZrCzTt4+/By8A9EHAerhvM+cv/LO0xvJwhieQft31aUyHc
	xD3YHwQL8WtCpmy9ATBCuaGwB9InNsxymUxtiJmil3q8qbg9RAnm3oAZ7vebo=
X-Received: from ilbel26-n2.prod.google.com ([2002:a05:6e02:501a:20b0:50b:1d1a:8453])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:199d:b0:4d6:90f4:48af with SMTP id 5614622812f47-4d72e966ec8mr3960018b6e.49.1790270993044;
 Thu, 24 Sep 2026 10:29:53 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:21 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-16-coltonlewis@google.com>
Subject: [PATCH v9 15/22] KVM: arm64: Allow kvm_vcpu_pmu_resync_el0() to
 resync filters in process context
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, kvm_vcpu_pmu_resync_el0() only scheduled
KVM_REQ_RESYNC_PMU_EL0 when called from interrupt context (such as an
IPI reprogramming host perf events). When perf_pmu_resched_update() is
invoked synchronously from process context during vCPU load/put to
reschedule host events around guest-reserved counters,
armv8pmu_enable_event() calls kvm_set_pmu_events() and
kvm_vcpu_pmu_resync_el0() in process context.

Update kvm_vcpu_pmu_resync_el0() to call kvm_vcpu_pmu_restore_guest()
directly when not in interrupt context so that newly rescheduled host
perf events have their EL0 exclusion filters applied immediately.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 6f60f86fad387..a8214ab52fcb5 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -213,14 +213,17 @@ void kvm_vcpu_pmu_resync_el0(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	if (!has_vhe() || !in_interrupt())
+	if (!has_vhe())
 		return;
 
 	vcpu = kvm_get_running_vcpu();
 	if (!vcpu)
 		return;
 
-	kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	if (in_interrupt())
+		kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	else
+		kvm_vcpu_pmu_restore_guest(vcpu);
 }
 
 void kvm_host_pmu_init(struct arm_pmu *pmu)
-- 
2.56.0.rc1.310.g51773c2048-goog

