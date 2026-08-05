Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4B42CB0D;
	Wed,  5 Aug 2026 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927827; cv=none; b=QcZ4rKpj6EB09np2oIhj90QxlN6V+ZVwQ3agnz0JbBWwiaZOmnuHn57656VtbwIEX4qRNXqccfV9FJ8LnTULpkzjAXf+6KymacgbK9f4Lcg6LdmNV3I1wrPVSVm1I46e/FWjy9+5Ku7SjrfV3F1aeEtvnZtS/UG7fhnJEU/IUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927827; c=relaxed/simple;
	bh=HDJF478nIMab/5S+MkniuOJL93na06AXHZuDa3J6vus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSLx/m44mEVtJkqgjVn/KE5MmcIeM7MVPlaLBPhjGrhtaC6quGHMcxWm/fpsA0GifwQKTevDuS9Us9X0VbeWY83ooTTf/0V6sFB6PudcSITqnffCEN0s6zjTJWCDo9ABfA5FFLCCrvZyPFdMQJ9CcMO0nQKxFpnUmKBIqYAnvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QbNx3Bbf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QbNx3Bbf"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B71C20B7169;
	Wed,  5 Aug 2026 04:03:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B71C20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927803;
	bh=27M/0RuBaS/3dfbGI7oEaAvgunuUxuFl5l+1w3bLmH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbNx3BbfgQ2uB0omiXEwGDP2Gx+INUeioNpiadyLyLcvMRcSDlRJtAuT0dO0M3Y5w
	 sEQPjbxHMAF1LyKYDquyBAa14NjXfKWf7MFVuigdD/4BhTUj58Quh1wc6RPkk8v3jN
	 oFIrRxpM/kbik0fF+AQsIm4CQh25j0W3I/3PMVB4=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/42] Fix compile error
Date: Wed,  5 Aug 2026 04:02:45 -0700
Message-ID: <20260805110324.25067-4-snambakam@linux.microsoft.com>
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
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 03e1ce935799..ee1d606e3314 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -417,7 +417,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		kvm_clear_cpu_l1tf_flush_l1d();
 	}
 
-	vcpu->stat.l1d_flush++;
+	vcpu->stat->l1d_flush++;
 
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		native_wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
-- 
2.55.0

