Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760F3DB960
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513565; cv=none; b=Pz6PKucL+PxfwJRRbzTNM/sE3N7wJx0O4lErdvy3kiUYzhHiH+fX97MgqGXlHyNj+uj9wJnrbhFseOc5qSgFjdthN1kiPHTQ6bF3XyZiQ6F8pM67j7uoG5tmgPccqCDi9xC73JyMj5/mgN0WTh1OuVKLTrL3zDUAZKfZbYJmUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513565; c=relaxed/simple;
	bh=kHZAdbLXwGzamsA5zqrdYPC8O6d1lPiriVT0T8y3Q54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBn7INMnhR5UZCaq+6z/XnefbJqWM+QraHQDg50xQ7wggpL+AOzIvgh8DtS3qpaIA7h0Hi/mjxbOc+jOFlA8ULkMp09Sxx/kh0YEo6cgooK/n27eE7RrZICfkpwywQ28/kpgTFGXFoORyabQzj1oDeWYOEL0IUNsYFAx0UnNWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixcp704a; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixcp704a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781513561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKsRpz1I0PRfQSc7rC4V93zNNuRaBw7cvpNExO+4siI=;
	b=ixcp704aMcx7Gllce9NGNoWaYWZVZBbHSTD55HPWckaZQMPcpE/L6vFuuPsWGtm6ViARjs
	oGLabsQXWj57Nzcf7Bxd8f+zM/VdrlT8kcIyKK5TnEKe/Zx8TrED5UmDnNVapN4IgRPUps
	tpcxetXmCpxrWNnr1vkkNF9BIHcF4iU=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] linux-headers: Add LoongArch PV TLB flush definitions
Date: Mon, 15 Jun 2026 16:52:13 +0800
Message-ID: <20260615085214.44526-2-cui.tao@linux.dev>
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
References: <20260615085214.44526-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Sync the LoongArch PV TLB flush definitions from the kernel:
KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH VM feature and KVM_FEATURE_PV_TLB_FLUSH
guest feature.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 linux-headers/asm-loongarch/kvm.h      | 1 +
 linux-headers/asm-loongarch/kvm_para.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index cd0b5c11ca..e4cd4bbf89 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -106,6 +106,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
 #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
 #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
+#define  KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH	11
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/linux-headers/asm-loongarch/kvm_para.h b/linux-headers/asm-loongarch/kvm_para.h
index 3fd87a096b..98494784ed 100644
--- a/linux-headers/asm-loongarch/kvm_para.h
+++ b/linux-headers/asm-loongarch/kvm_para.h
@@ -16,6 +16,7 @@
 #define  KVM_FEATURE_IPI		1
 #define  KVM_FEATURE_STEAL_TIME		2
 #define  KVM_FEATURE_PREEMPT		3
+#define  KVM_FEATURE_PV_TLB_FLUSH	4
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
 #define  KVM_FEATURE_USER_HCALL		25
-- 
2.43.0

