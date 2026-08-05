Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893142AFB2;
	Wed,  5 Aug 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927823; cv=none; b=epqAlLk4sAjAE4GRAGcC2d56BP8mVvpzI23a98qamNXZncKS0qJrl2dswLQqS54Ey4bLiYl7sbhvJY0PSEvnSfgGcgV+mEDr/RKMbzg6U6PcvDmcNJvVgbKDlMZaiS3bYsnLlQoRCckUJtw4miPIlSM3FeAeCA6c4LtUNyao6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927823; c=relaxed/simple;
	bh=G2ucZGhu25RP2ebqVdqrXB2AEnPOxIw1b/0uzx4NuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrFpPI1B7wrPBpM/IVMM5/q0o+h92ldQfdbxRMfxGJKgUJD0/wFpW0dtmbFIFkgfNHXH+u7OZ7cA9b98nwcBdqaVyH+6ENWETFQM6FeL/oIz7y6GzRfu4KLeREqX5qk08Fgw5hn6tideQ7wZ9JJ0uoMXJiWAjXANVLcXYEekzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bM3kI5f3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bM3kI5f3"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6092320B716B;
	Wed,  5 Aug 2026 04:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6092320B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927801;
	bh=uoE2oQuYpg52deZOM9SASjntNtYyGWIXBhdOKD8iu3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM3kI5f3p1CK0Y2PpOX1FqfwO8P1dfLWg7uriIJeo/IGEVTKPh+n38kalb5B17XEU
	 fAnJnqzwhvAS9j/nD32LPbjeUDTHe0HuEL6iPnycbmGU5TWzKwfLNoFkQEcImuwpfy
	 JAoHoBnSd+I/S0kxKaa9LoDhBeRAM7TJKbNA2FEo=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 01/42] Fix merge issue - Remove duplicate definition for kvm_arch_has_irq_bypass
Date: Wed,  5 Aug 2026 04:02:43 -0700
Message-ID: <20260805110324.25067-2-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram Nambakam <snambakam@microsoft.com>

---
 arch/x86/include/asm/kvm_host.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 979d1749f176..b7d478dcc1a5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2603,11 +2603,6 @@ static inline bool kvm_arch_has_irq_bypass(void)
 	return enable_device_posted_irqs;
 }
 
-static inline bool kvm_arch_has_irq_bypass(void)
-{
-	return enable_device_posted_irqs;
-}
-
 int kvm_arch_nr_vcpu_planes(struct kvm *kvm);
 bool kvm_arch_planes_share_fpu(struct kvm *kvm);
 
-- 
2.55.0

