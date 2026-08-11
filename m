Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED01A262D;
	Tue, 11 Aug 2026 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408293; cv=none; b=Dnn35AVuSMhdBmgxUpuTd9xGaGEWRDCXb99das5w6Wpg8BqEeXwza3PnHEsdWEuEAocApCT7igNSkFI6Z6dBLgNHNrOGkXIQg0xUxSSUjuBbfkDS5RS5BPSqeKXBVyvWd9UZoiuxZH+BsAXmqLymeiwiMov/NiEARLFA0d8rObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408293; c=relaxed/simple;
	bh=vD/1xyD4x0O+SOaF7e3FAXKzc62XgRJ2Pm15YNdeUDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns3h3wGaPD49NaQIMXl6Ha1Gi8eqxuWcoO7tPVL33qWUx6vWx763fkwcmqPWLe/QpVl5dTvw6e6LdqPKCplhnrDpBbHmWCYKb1rvfhVvD/FcZ9jF4fnXXVfGsEGNcd/0EBvESHUxVNteMeawh6UhOOjzFEY/PGqoGklxNJ3n4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LAPelJQ7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LAPelJQ7"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5704D20B7168;
	Mon, 10 Aug 2026 17:31:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5704D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786408268;
	bh=RjeJfiki2yJGR4FsvTJyiKdSy893l2hl2iMbxJm+DTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAPelJQ7ZiUtnLa/gRYc9ydIaH57mkjhHjT+tO1gmQKTpJJr11REbSSoxEntXDomq
	 K7MAJlCQzdxQfcv+gbTlxoM2PeDWckWlxU0Xf3j6Senl6YqAbx+6OHQneFZSNePjAj
	 VtYj86lvbCqtXskFWCjZlAV5T0549Z5dvDNrJ1MA=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] kvm: uapi: reserve VM-plane and VBS hypercall numbers
Date: Mon, 10 Aug 2026 17:31:11 -0700
Message-ID: <20260811003114.30107-2-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811003114.30107-1-snambakam@linux.microsoft.com>
References: <20260811003114.30107-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reserve the paravirt hypercall numbers used by the KVM VM-planes and VBS
(Virtualization-Based Security) host support:

  13  KVM_HC_VM_PLANES_CONFIG    configure plane memory (serviced by the VMM)
  14  KVM_HC_VM_PLANES_ACTIVATE  create+activate a plane vCPU (serviced by VMM)
  15  KVM_HC_VBS_VTL_CALL        normal plane -> secure plane
  16  KVM_HC_VBS_VTL_RETURN      secure plane -> normal plane

This patch only reserves the numbers; the handlers are added separately.
---
 include/uapi/linux/kvm_para.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 960c7e93d1a9..08b52d25ca17 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -30,6 +30,10 @@
 #define KVM_HC_SEND_IPI		10
 #define KVM_HC_SCHED_YIELD		11
 #define KVM_HC_MAP_GPA_RANGE		12
+#define KVM_HC_VM_PLANES_CONFIG		13
+#define KVM_HC_VM_PLANES_ACTIVATE	14
+#define KVM_HC_VBS_VTL_CALL		15
+#define KVM_HC_VBS_VTL_RETURN		16
 
 /*
  * hypercalls use architecture specific
-- 
2.55.0

