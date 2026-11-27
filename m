Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798917;
	b=V6lflquKd7QoQGT6CkIywOaG/Yk4prQz3rNkFBi/55Cyx5mxz9oeCmLoXv5Mg4ObU+GI
	 Zt5/IfBDWon2zD1SfPsJzOppJ4Rd5eAm1sNkkBfE7Bcf/U+mvjwat4fkt8/DUEmQ7TNR+
	 WNhfBo4cduOsmnnHD0omTlJjXUzsgAAFBreZRrypBVAEit65jvgUZgA5zvSjEEJVDAGmh
	 HaHwW0yygj+gpsWjCrVj82ofXVnhEnF2uBfQX0rzZTacnh5wQUX8PpJb6Vn6q+J3h/IR8
	 Jc4aEZtR3FKmj5+fRUytzhfa/pTXlZ6l5k+cdD/w8ytOQ7XfeCZ2wc9DvmcGlIX88pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798917;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7arVPQFINgfmvaThkX4cGwxR9rvbSIVuD6b/IWXSj8=;
	b=QRnm9fU55PEfwc+sLBInOTAC7o+9roVmo0gQqYR0K3dndU/8eeM7oGjcQsYg1ISAwCCT
	 GjlgyN5MpUD/hzsf6TDB0C60s/fDemrOdwkbo3tozVZLK4lWvQqFJuBYk8YpI9KcQZpPL
	 1+D3T/xi9lnM9+GSRQO3UcI4jq+PW6nQYdzGFvqr9oBielyvM+CYw5Ql7J12L6ph3c2hH
	 5bsq9DfC0lISUrC1nvdxUr2KI5TsCSCyQVtzXQ7oq9oLhTjVTWKo0UfB300HTrTy0bNso
	 WwHhS5/muwNii6Jhx6klxCJsbk+646wXqeBCdhysc4nRpUzeCmsh88o+WY2OVeUW5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="ud3C/80H";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE18606A326
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE18606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ud3C/80H
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C496169E;
	Fri, 27 Nov 2026 09:01:53 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D08E3F632;
	Fri, 27 Nov 2026 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798916; bh=2CrNkn059Py+6JSBmj/RbmhlCO93bsgfPfqoA1+/+pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ud3C/80H2+1gki93e+zQlhENeKJu4dfgXnRE1DcxFwVRJmf3THldzlZmiWCgBQAbn
	 +nhKoLGIXhgPi5G5K4BoTwx9HAlsmsyMQOvheftm2uZkp24YySPDIkza+5V+A7Xcey
	 bCLbucQhPXIBDyrkPZ1sGUQGoHVhi60YR0yC854Y=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 01/23] arm64: Propagate IRQ routing initialisation errors
Date: Fri, 27 Nov 2026 17:01:23 +0000
Message-Id: <20261127170145.4138182-2-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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

