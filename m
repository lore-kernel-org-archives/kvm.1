Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175734888F;
	Tue,  3 Mar 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498075; cv=none; b=H2cdDByskqiolu+g25c/xAVhXztkua+OMiYkXc3l8rx3ZHChvOCcDWMv1URf9hjXQSo+oZ5BL4bVVBCCyHn9ZHD75oQxAgAWTRp8GOWK12zP8SBKntoEP/iIxB24HWutgQ1GPio42aia5u2xvU3EL1nTFjMUQoZrin1uEkDt25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498075; c=relaxed/simple;
	bh=VkfpgkqyrVASRWFgTqoJ+zrG9g4hxcm1sZ6qMUOlIw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwWrLtdqYOlMyAu3Tyf9INSdvy00DsToFv7fSyLX/GdsEBBul2OG3xYsB3ethMqsqXr98kZwRluauj99sfbUiV+nWlAyW4GcF/I4aCfbaVMUAMJUE1NAfeNtIFmd3BquPaxFbQJdA6a6OuT4xJdy8zOwQ1m/2EyFw0svQmNCZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPQ5YqMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPQ5YqMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634CBC2BC9E;
	Tue,  3 Mar 2026 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498075;
	bh=VkfpgkqyrVASRWFgTqoJ+zrG9g4hxcm1sZ6qMUOlIw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPQ5YqMq5kAVWLctOu4C7K/9R6VbenvpgTnHxVjVcCXBuLdifNOCQwq0Dz70sjp87
	 76jWeuT1xJmIkDo19oeYOcdnMBmKdql00vk3KYSyxoOCMgChxGbiyDHBhHCunSCBVx
	 GHxIZS9/ZnltXRhX1ur8dzOjJAWbNSOqPU1eUDo4aSRR1jHI85lG4bhu5I4tsAJ0dC
	 Cc5BngjJ4kvBvxjT76/3EhXQjrxNsfDuOQq6G6AChQ7AizNTPJvoAmTkDcpLLzjJKi
	 McT+SE1I9b0B+N813G3P32lPOkPokc7aKJpsFYDwKmXuw03aG8YkaFBxiPQznebnqq
	 cxOhn0ICQvkGg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 10/26] KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
Date: Tue,  3 Mar 2026 00:34:04 +0000
Message-ID: <20260303003421.2185681-11-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the APM, GIF is set to 0 on any #VMEXIT, including
an #VMEXIT(INVALID) due to failed consistency checks. Clear GIF on
consistency check failures.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bb2cec5fd0434..04ccab887c5ec 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1036,6 +1036,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
+		svm_set_gif(svm, false);
 		goto out;
 	}
 
-- 
2.53.0.473.g4a7958ca14-goog

