Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B32580F2;
	Tue, 11 Aug 2026 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413182; cv=none; b=Xsxs6iYrQDKNpomTSpQLb0y7PSzjHAuRtcsLE0VdAa3yl2EURVJ06qhPQhNJcBo9nqSO1Gn6qEdvLNzAmZij9AQcc+542XPrr0IcTJNxgBZibdQjhCanDtIiDBXWcSRjPpKH9Ln16jF7HSmJJY/wUvVSL11jzl6nN7MI81sPT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413182; c=relaxed/simple;
	bh=z5KSzQQztbLFUsJjUyfDCuhUxbkHoDL2C0yRGoAy1ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agcAZn/DJNd/C4H+sLSK2n5Q0ufYHFZIRiH5evfCXVV12jG6t3lGzAWrAg0LtS8dNNaG3rjfLAsLmLJ4rdAHQbRVtcUaJ+qL5IW/FOnawI6K7smnBoDsyXEkr6DWX63IBueMrEdRjy6DS0w/bsSPbylVUFgdBuww6Eyp/dNnCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pfmFUfLC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pfmFUfLC"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA0B220B7168;
	Mon, 10 Aug 2026 18:52:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA0B220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413156;
	bh=rDc3QKOVYWs5lYCY9tzJ9FOVXximpBXicuIVrwI13E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfmFUfLCZ9E+tnFOWKH20Cs81dLF1xjnUY1rGLg8F2sbw/4OtaSUQ/dD33T5NtQe+
	 Bhkx0ngAr26avqXkhIdm60pgWumLYFrbEsbBax6+EAFlQhuPWNxuDyOuTKFUOlpnb1
	 tznjgKCegIcCDS7kRugCsgCrQkOn2pm9ukLRBqcs=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/8] KVM: x86: raise the default maximum planes to two
Date: Mon, 10 Aug 2026 18:52:36 -0700
Message-ID: <20260811015243.188486-2-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015243.188486-1-snambakam@linux.microsoft.com>
References: <20260811015243.188486-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default max-planes callback returns 1, which limits KVM_CAP_PLANES to a
single plane on VMX (and on SVM for non-SEV-SNP guests).  VBS needs a normal
plane (0) and one secure plane (1), so return 2 by default.  This is still
gated by irqchip=split in kvm_arch_max_planes().
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 35fbe0776a3e..29766c19c289 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -478,7 +478,8 @@ static unsigned int num_msr_based_features;
 
 unsigned kvm_x86_default_max_planes(struct kvm *kvm)
 {
-	return 1;
+	/* Support a normal plane (0) and one secure plane (1) for VBS. */
+	return 2;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_default_max_planes);
 
-- 
2.55.0

