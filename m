Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B274E7809
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609122; cv=none; b=FXSe5+3WZKj6XbPQ04H4CTp8zKi8t9QKYmIpLtd4fn+1hG/tVU5Or8UZd7LW+9QET5taxDNH6Emg23XneVht+Lo6J6yZyfJkIx44Z5eanHWoY19LEoB87Vp0YPSH5kJJ5tGZdka5YbdrmBSoSCVo3Vrn5ptzCaZfzbeq8rCSj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609122; c=relaxed/simple;
	bh=r5HnM/f7PTKF6og9shC2Jz8ilToiTnP5/ASxGy5XQl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0zBSyaccDJdTs0wfeX8R0iWDuWTK5YtN/V/L075Lqs/wGGIC0jIOPLBouQhXFEeGfYiY2cyReBvA/+yw7uY4PL8Viq96PfrUNJe1ji6+R0SB9qaeevRtdKlokezpNt/Pe98IcdSGXYBuHnIksllQ49Nk019ic1xEfPs7mDMGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C22PW6Xq; arc=none smtp.client-ip=95.215.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C22PW6Xq"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r5HnM/f7PTKF6og9shC2Jz8ilToiTnP5/ASxGy5XQl4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609116; v=1; x=1791213916;
 b=C22PW6XqCIRs0//3bUHkcGxbUm4bkd3GsRJ5ZjGIIQeOHa92bYMu+AghvRXY3EfTapnh7fV1
 KwZGEgBCuwa9W/IP8yVWgv/Rm4qBZloRZCt5ac6LX2+u1/eV6qW95la7v7nJ2733k2g5FDmWEqN
 HlGBzchtf3VyeOl0DldU3ht4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63cb18f08da356ba;
	Mon, 28 Sep 2026 15:25:12 +0000
X-Mizu-Trace-ID: 63cb18f08da356ba
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <jingzhangos@google.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/10] KVM: arm64: Don't WARN on SMCCC filter reserved range allocation failure
Date: Mon, 28 Sep 2026 16:24:58 +0100
Message-Id: <20260928152507.2116110-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928152507.2116110-1-fuad.tabba@linux.dev>
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first time userspace sets an SMCCC filter, kvm_smccc_set_filter()
inserts the reserved architecture ranges into the maple tree and WARNs
if that fails. The tree is empty and config_lock is held, so the only
way it can fail is -ENOMEM. The allocation is GFP_KERNEL_ACCOUNT, so a
memory cgroup limit is enough to hit the WARN from userspace.

The WARN goes back to when the ranges were inserted at VM creation and
the error was dropped. Since commit d34b76489ea0c ("KVM: arm64: Only
insert reserved ranges when SMCCC filter is used") the tree is emptied
on failure and the error reaches userspace. Drop the WARN.

Fixes: d34b76489ea0c ("KVM: arm64: Only insert reserved ranges when SMCCC filter is used")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260829055809.29AD31F000E9@smtp.kernel.org/
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hypercalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index b11b8821c9fbc..210a496733d0e 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -197,7 +197,7 @@ static int kvm_smccc_set_filter(struct kvm *kvm, struct kvm_smccc_filter __user
 
 	if (!kvm_smccc_filter_configured(kvm)) {
 		r = kvm_smccc_filter_insert_reserved(kvm);
-		if (WARN_ON_ONCE(r))
+		if (r)
 			goto out_unlock;
 	}
 
-- 
2.39.5

