Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655268;
	b=RKOiObUZlnmobnHaj+qFepTt97f6q/IUOpFTCu6U98tx5Mk0EfVw0AailsSo9sqKiDUg
	 Y/7qpe0TW61i9IKG40B7PQoZMs1E/0ie5m+FGCDG+aYTWjh0/WUYRoSpBUxLSLDztkd7J
	 QvmXGg1kQJnRZAgDdEs3ZlFNUUGfoEck1JbTm6SXT9nOBioz8dTCI6txGuapW8Z8sCp4f
	 VMqO1arO9zKusweSXkmJUUBtcrK8+eBPKTVkaECT5cLQcoRXYUc7OUz4cYiYPXlejJr+T
	 ajA2Rdy7+ST5ctx4fZT5mp83pMKDAFyG3rVjTZM/PegXH+2eC0lZHL1YQch1S5jqFEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655268;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7arVPQFINgfmvaThkX4cGwxR9rvbSIVuD6b/IWXSj8=;
	b=srsa5rOwk+bo8Nbq0LrTzyHcqP/yjUOTQw46wtPh0xnzq01taUKcZjsf4wha5ea8b2Kc
	 ODdkkvdY6y8pyqFBbywx3gaZvbTg4UreAa5r336m+JGyFq4IVnsS4ZLTyfv2xssDoqv6r
	 IU1McJ0nRK1sblSfQwk1KAbDhm7ZJ6gPNJF3pQnLtgRStyfw5oUjlSb7zWlmwtJgM+hxf
	 Q9k0jld67ZafK/yejI2gX1/mPyVZeaoz0yxvJvAXjLmCsCdCUGD64/JS7Qgz2VCBq90AZ
	 i0vbwE2ookXqQFEOxbgIRGbnlSXOG1qjEsmlD7iz6vd6TLOylo49yKm3wlwGYDxZQcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bZm1XxQC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C46606A32C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C46606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bZm1XxQC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11051595;
	Mon,  2 Nov 2026 13:34:23 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1C63F673;
	Mon,  2 Nov 2026 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655266; bh=2CrNkn059Py+6JSBmj/RbmhlCO93bsgfPfqoA1+/+pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZm1XxQCwNEfB27ntjEZ51HFJsKMrNkhlQildTW+IbngNWLhOFZhKY48jdv+dqTRE
	 0eQAh17oloQN1ExPrVbJclq7N1/opTTVa3CkPCHZrbflHs2vGT3jbiBacWF94/Us+J
	 Vh+Ue09skqp+VYjwNBFb2sUCzsIqSP55rruJeOdM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 01/23] arm64: Propagate IRQ routing initialisation errors
Date: Mon,  2 Nov 2026 21:33:51 +0000
Message-Id: <20261102213413.4136118-2-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102213413.4136118-1-sascha.bischoff@arm.com>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
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

