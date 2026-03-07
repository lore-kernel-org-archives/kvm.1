Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBE1A8F84;
	Sat,  7 Mar 2026 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846188; cv=none; b=geXsm9gB1nUjVr7kSLOreSo0Q4lL0Miidw+l4kvK85PM1Auv96oz405L7vTly+GkpWvTS6aCxubM03cVk+rzzZsCmeN9WttOCKDHJz++bTZDTDV9jArDO/PRANLwynVakKVORG7rvnfhaW3cHCzqtRTF1XWnsH8kBJBB1A31QlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846188; c=relaxed/simple;
	bh=iF52xwsJ/9bxt5Cd+3PxtZ6ceKFFgh+xNY6B6S1jiHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXlefQwR48m27ghyAMa83/dapbV3ntotBZI8yveQtVnV2lNFgwNYARmMOEqAkW1J4AGFL3e6zUOWukX+MUnBLYndYxhGfQcW9KXyMb3StYHBSMQRyqsh2VoiUvEfCX3k2gA6apf0Qx0nmTwoW3x22CPU+Xtk3JmZGgSBOcigwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4HxlZfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4HxlZfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B2C4CEF7;
	Sat,  7 Mar 2026 01:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846188;
	bh=iF52xwsJ/9bxt5Cd+3PxtZ6ceKFFgh+xNY6B6S1jiHs=;
	h=From:To:Cc:Subject:Date:From;
	b=h4HxlZfqwMIZPqFJY6IEAnkHkMTjtNsLwgDeD6zBFM0VpGRgE/4yR1z0EwS2puvfl
	 hvjwoS55T+DCFrGbmQpKWGeImTpCy1E+3AGtD0OEGGf92PJ7lbLgi2l61C1QWNTIj/
	 czD2vCaaE7DIwXrFN8z4HHE0eWH9plaXJhGINOr5JEEHD7udDHKjQCuk3RSGzgbQJx
	 u3RR4l/aW3S7bOBnBlqybWo4SJmnnnaYnWP9j1PzswloiOkowrg+fLf+4/Ot3+x8kA
	 7lI7A0YNWaG5GPjnLhqYdNyjQsmQh8lv9QkwQiN5KaXA2Wntv4qasS/ZBxaSMnZGbZ
	 DvcIvPUv3S3Ow==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Venkatesh Srinivas <venkateshs@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 0/3] KVM: SVM: Advertise TCE to userspace
Date: Sat,  7 Mar 2026 01:16:16 +0000
Message-ID: <20260307011619.2324234-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise TCE to userspace, allowing guests to set EFER.TCE, potentially
gaining some performance. Patchees 1 & 2 are prep work suggested by
Sean.

v1: https://lore.kernel.org/kvm/20260306002327.1225504-1-yosry@kernel.org/

Venkatesh Srinivas (1):
  KVM: SVM: Advertise Translation Cache Extensions to userspace

Yosry Ahmed (2):
  KVM: x86: Move some EFER bits enablement to common code
  KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks

 arch/x86/kvm/cpuid.c   |  1 +
 arch/x86/kvm/svm/svm.c |  7 -------
 arch/x86/kvm/vmx/vmx.c |  4 ----
 arch/x86/kvm/x86.c     | 20 ++++++++++++++++++++
 4 files changed, 21 insertions(+), 11 deletions(-)


base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

