Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFC4314A0
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927878; cv=none; b=m8yo8HC4dJOnRzW9HsUFM2IeQAakT6yguId55E03a4D5+Eg+Z/qaBiA0iuXV2JcRvMdfGweq2ZEVJhZ9D1YzfxE79yC9/04oshUjtMzlxSGxBmT2JtTTkQT8ViuDEiwvQ2uXsB43YWyDP7aF2UeVMfyNS/dvIt9S9fSzl3epY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927878; c=relaxed/simple;
	bh=8A5Fzebf7tetJDn/LR15q34AsFn1VorDMgd47KfW0IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX55FI8u5/M47LZMGwlAj7LVYPKhWeqdmmjOMuZn43vkTAcnBDboQVcQO4Bi+IA0YE1lZ6F0HTzF+2bo693aduQoDm6hBpD1v4yESpLcOY57/Tba5nO79pHfRLWM00QMlrSjRQM5Ms0eONHM1surBZQzy+lAXq5BbJSk6kYnYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YqpS+TH0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YqpS+TH0"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A2E620B716C;
	Wed,  5 Aug 2026 04:04:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A2E620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927856;
	bh=LWWPECdd7trZNFf94dG6xpNIuU8Yn0i5MN5bN/aqB+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqpS+TH0f7HQDBtfEPknq2m0RL4xbBCPp3NfCUWeskp1Uk9flxxrsRfE4rHK1WtdV
	 qOFYQIyjytZLj+H0g6pCFdjrt+xF7kF0+omOptH5UTIvLAeTAN3xTX46YrjgnWBSIl
	 ZjOhk3+bKxiLnqAK9tVX5PhSIYcSYepe8i7G65uw=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 3/5] linux-headers: sync kvm_para.h VBS VTL hypercalls
Date: Wed,  5 Aug 2026 04:04:30 -0700
Message-ID: <20260805110432.25167-4-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Import the two new VBS secure-plane hypercall numbers from the kernel
UAPI: KVM_HC_VBS_VTL_RETURN (16) and KVM_HC_VBS_SET_MEM_ATTRS (17).

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
(cherry picked from commit 92f71c68c2eb42588694ac23fb4a6a8ef8dfa12b)
---
 include/standard-headers/linux/kvm_para.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
index ad19aac9d0..def451c43c 100644
--- a/include/standard-headers/linux/kvm_para.h
+++ b/include/standard-headers/linux/kvm_para.h
@@ -33,6 +33,8 @@
 #define KVM_HC_VM_PLANES_CONFIG		13
 #define KVM_HC_VM_PLANES_ACTIVATE	14
 #define KVM_HC_VBS_VTL_CALL		15
+#define KVM_HC_VBS_VTL_RETURN		16
+#define KVM_HC_VBS_SET_MEM_ATTRS	17
 
 /*
  * hypercalls use architecture specific
-- 
2.55.0

