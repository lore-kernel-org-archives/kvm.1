Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619648;
	b=ZlLfYm2/3v4lcgq/yz9CSVzKexGb5Tb0OGW6Z1i7IAevfifyjpem5YkMkj1G6QUyQo3V
	 FkMon4FA+Pl8H1YTY+dChN7GYjmCKzesIYsEOFNeHuqn22x6DBWvDzay7a9+sRa7MP2EG
	 +56HvnA5MqHECLLcHQJxtS1MqhWqEiIiSl8sxUzi9GIJfo8e2YSZ+DBB56KULJ5wW6PAO
	 8vv4XRusofH9nRmMvP0RLpZVdiHk98bZA0Y0yvIwIkrtpX2s9oxbISp5medcXGV6T0n25
	 ib/2iHYH2YorPUVFMKJsC4yDJ0gAKx0iQzs98vsgX8gtBEubu9Uio1zXKAR4II06r6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619648;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7arVPQFINgfmvaThkX4cGwxR9rvbSIVuD6b/IWXSj8=;
	b=0d80grSXfJflzksTFsvO1d2WBstKDNjNkjKhovMoJJOviHo2DBxATNFluzfivlfIv2ig
	 TrJHOLQpEnjGpcBvWBs7gct5PWFwgq2tfEbdJEYE8ihfoytAm/4yReYIMks0y2dNnmpQv
	 LlfZoDU8TjIwNpsa4lo2aJGLHXzYoclJm75St7XtWRnDYzOB7O5hYTTx2xh/OfDwivfid
	 4KZCnMHl/m4qKh3zXlQMiJkhgo0HUqofOb17HtZKYBWKvOYaq8bA516E7L3qQPAtksBSo
	 GjydHfqzSZJ5OoXcqTl11vVV2qRTTMWkjOINoOaSbyEpUA90yrGj7eGrZeCmzCWYb/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AnUamhRx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE2606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AnUamhRx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B9D339;
	Wed, 25 Nov 2026 07:14:04 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00EE3FA7A;
	Wed, 25 Nov 2026 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619646; bh=2CrNkn059Py+6JSBmj/RbmhlCO93bsgfPfqoA1+/+pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnUamhRxRm9nMXLMQzNCSwQeFxqX20SNxKKPQBqfTOAh1cLgchkaMgKasKYIvhPty
	 ovrATfFfJqu04Tj2nGnLNT6B8f0L3ziyrInbleaCTIn8pyuHmqBLXp0cvR2m+FYx9k
	 yiwf2/hKVoDGds7/RC8mdggZgDtN/B3qPo6qo9Sw=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 01/23] arm64: Propagate IRQ routing initialisation errors
Date: Wed, 25 Nov 2026 15:13:34 +0000
Message-Id: <20261125151356.2875108-2-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125151356.2875108-1-sascha.bischoff@arm.com>
References: <20261125151356.2875108-1-sascha.bischoff@arm.com>
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

