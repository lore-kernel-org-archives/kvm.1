Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024692;
	b=d1QHwh5Wv4vuLFk0blaGEusv7NFOUrieVs7gaZoqw6eAXMdfif2G5Q3zOXGIUtpyf0Ab
	 Fu/Q4kXy+eRApVozwEYBJiPOkwuO7LJRhMMxEFj/1KK/4ysBbwudpJDUruOEo2vjfTF/d
	 WTCUMIntx1lv0LBffBDf/5SSoRRDb8WTXtg+K3AKT2OXXFqJkyQ0vjBeliIYzCRpElO7c
	 1Abh93UGOLz4Sy7shrcBewYkbFm9/92j1aQCLmOWBVi3Yw6NP3fDb+S315zUeLebjA2EH
	 w5GrSqCTDjPLkhwQV4/gKDnfbR353v/oCmCcHvhzyGweqUSKOg8DBHs/9Edj6DZaIDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024692;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7arVPQFINgfmvaThkX4cGwxR9rvbSIVuD6b/IWXSj8=;
	b=kSclw1Rns1pwrTAzCYiOlKh8Vg7a47lRb9xyjenoSRT8PPUzttHa4BErGSq3Q0GTPJPm
	 Qal0n3OKKRwpNSlZV+aJV/iHxWm3X+xDc3Waarrx3bnJs81A0pKHSoXblJBRYbYYcVKXi
	 +UNKsvOi+bM0vaNKOy3Golyprjk10u7URN6GxxdNA/JpSjwo+dc85lU1KBu1N7KmfS6wB
	 uL7oFTLDA+D20DLiuDV+qAsLWtEvTRlfCi1NzlhBb6Io1zJfo26m+rxzm1ywJJpK/sJs5
	 gm5/sTsWWanaP9il7l4s3A9VjgbCsC04bHHvY/tyjnopGeHQZTuyaO3EjpDFOetHXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L3ga3jST;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69D606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C69D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L3ga3jST
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF4A1477;
	Wed, 18 Nov 2026 09:58:08 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65E93F632;
	Wed, 18 Nov 2026 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024691; bh=2CrNkn059Py+6JSBmj/RbmhlCO93bsgfPfqoA1+/+pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3ga3jST8MbWpfXQahlu2WCYdeKKwayxwQIrtPuo+1ar1Rphwh8Q+WVhuIpMzQ7l+
	 siNRu+QtzTVCDFLzb06hcdlacrkljWooOp+0FNxJqcj9sHez3jy6FaZUm4r1t6bWJ3
	 /6rFe1Pmi43GuuLGdKCihYyUHqySOhQ0VpuQ3sOE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 01/23] arm64: Propagate IRQ routing initialisation errors
Date: Wed, 18 Nov 2026 17:57:33 +0000
Message-Id: <20261118175755.1946977-2-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118175755.1946977-1-sascha.bischoff@arm.com>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq__routing_init() can fail while allocating entries for the default
routing table. gic__init_gic() currently ignores that error and
continues with a partially populated table. Return the error before
the VGIC is marked as initialised.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index 1e400962..debb0381 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -344,7 +344,9 @@ static int gic__init_gic(struct kvm *kvm)
 		}
 	}
 
-	irq__routing_init(kvm);
+	ret = irq__routing_init(kvm);
+	if (ret)
+		return ret;
 
 	if (!ioctl(gic_fd, KVM_HAS_DEVICE_ATTR, &vgic_init_attr)) {
 		ret = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &vgic_init_attr);
-- 
2.34.1

