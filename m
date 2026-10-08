Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B324BBEE;
	Thu,  8 Oct 2026 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418483; cv=none; b=NURzmpPYTvleHZjYLdfghSboF4bMVZTlidMjBw01KAhvtmG1/+ix54iGnu3yJLNCHEA7fQipj7PQhxvXpSyUkvUSYlFwi39y6C+fkxE/eqmUgyQkWfbZjpR4FMiZQcMhqdxFaioQlpuslrJpprvhMfTG/bdiEB46WgWHVdB0iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418483; c=relaxed/simple;
	bh=YeroitA1/JegonrnJYx8YZCinWa63k8z8pBps00ETH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta4O01wbP9ZU9UvgvANDAjLiK1QMfZseT7yycuRr0BL8p4VuEgl6Z1lpNwlTPqjS9bv3h0vZ7Spt7Xt1kD24BQ/NEL8ur9nTTw+DyrDsgfZsxAq4v5d1ctEjW1UAr9qE/lfmvcMyNOlhM5LBhCIV+cPGvwzebooxd1uzHzY8Hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT1NYxsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT1NYxsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FD21F00893;
	Thu,  8 Oct 2026 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418482;
	bh=ocab7tcK6OMc7PLf4A2HeCbK8v+i6HM9lAalvXD2dMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UT1NYxsz/RaklVgsc35qM+t7JyeW9crpKWQkxKDmqqvqWh4nLH5nhFtw7rU8HJn6D
	 BiUpHOqi4+ufj6FQ4EeYnEfOexkcfrqTVF5ZmwAPWIMfsBeHM2PlQU0A78YEc00gJa
	 Vs7rfOjvi3cj57eElKlwCUJ7IiqtAv8jePmxVrgpiqeLLl3MqqMoDfG6nXiBXklYhB
	 XYdsy07B/u0K+LhFftG9GMm7wLx2wvcAq9XLruNrTQ0JZY+RAvV3B4dt5MWSPMpzNY
	 o8jnCXOJperbZZUWw8gdfgkmNwnwa4HXHy30XgqLbfzFM9I3IAEWbpO4n8cLR2ZH/s
	 kYsxCjbxcDq9Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 07/29] KVM: SEV: Do ASID initialization at VMCB initialization
Date: Thu,  8 Oct 2026 00:14:03 +0000
Message-ID: <20261008001425.2458927-8-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-vCPU ASID does not change for SEV guests, so move the per-vCPU
(and per-VMCB) ASID initialization to sev_init_vmcb() to do it once,
instead of setting it before every VMRUN.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74c4555a32650..b58e3831b8f05 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3623,9 +3623,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
 		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
 
-	/* Assign the asid allocated with this SEV guest */
-	svm->asid = asid;
-
 	/*
 	 * Flush guest TLB:
 	 *
@@ -4889,6 +4886,10 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
 	clr_exception_intercept(svm, UD_VECTOR);
 
+	svm->asid = sev_get_asid(vcpu->kvm);
+	svm->vmcb->control.asid = svm->asid;
+	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+
 	/*
 	 * Don't intercept #GP for SEV guests, e.g. for the VMware backdoor, as
 	 * KVM can't decrypt guest memory to decode the faulting instruction.
-- 
2.56.0.360.g66cac248cb-goog

