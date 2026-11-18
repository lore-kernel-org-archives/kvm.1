Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024696;
	b=bfvNqcGwyb7d8X+iZbhHHoudS8FJ2wSw0yWMiZHSCAabS2hxPGzw//TkXmNjt11jc30j
	 zq4FjIi+bub6jMBe9pL7y7f0nkiQTBa74d/vjJY9sAJmyseKtyO3JwV9U1ScAJ0bS8DLv
	 gv/8DuojXQwKs+GSCcIxQz6W/x2ZEjFIWBuwJeisQ1S3Pe9CH25JtU56hWIwresrFRf1w
	 mm0uOQrSJvdnF/702cKUgE48q8Mg7uUD2cIc1HQVl+Uuwv7ns6k1vI1TF4OfTpWucKgf9
	 JWxzLCx+1bbEYrqOlWt3bbQD9VUBKIAEgHjE0rgAB+lldgxF+xekX268L+ucddXz9cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024696;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ptB7HBBIXmODENruQ/1q8o5lWV2aQFT5cwp/uxamfAM=;
	b=rd1Xfw2cYQ/jo533nlY42Kf6c6QBTnvQ2ZG0xbrfQeSqxI0sk8vzUpgsgKZSrZfS9VAB
	 yBRE4MAYKXI+rEXzEgo+aKghqZHgi/ooG81fP60Hp5fK5Zq4vSso+mAK38Nh0U5u/nSo/
	 9xcHdezZqvqoH+GiZipqeFLP9wDrCYdyVGojjpRqIwMgvw0ELGJ+uzHXVvNibWvXyVWBk
	 ippsstp1bcOZLyCqtzvWV7hN/vKXu9EeIlJXGeDorJcX+bdzkjN85qTsD+9aFQt3TzX+E
	 tuGfHWTe0J0mZiZS/nfjgSqAGCrSyHFCZpOcZNqfyM+xjCY7oMa7vqH7XY92rOdhPmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l4QwO42Y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA5606A32A
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BA5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l4QwO42Y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12D41477;
	Wed, 18 Nov 2026 09:58:12 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDB63F632;
	Wed, 18 Nov 2026 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024695; bh=N8bg3ar1PWVMdyOQLfF0aNd7/iiEv1kXMmOX+0mXlJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4QwO42YLmlTvxNmdIxzCJJZ9htVn58cQfoy51LMXpa6YoFNDIW7HPlFZ/0iQyNt8
	 iI44r520nHMMorA9hVeeeMZVJhhqXM/7O0nmLaf/3EnlhK4dJIFswS/KbugeOB4ldd
	 NSSGKb25Wu4j62dcO7tVePI8FELh6uivaYOT2W4A=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 02/23] arm64: Close the ITS descriptor when setup fails
Date: Wed, 18 Nov 2026 17:57:34 +0000
Message-Id: <20261118175755.1946977-3-sascha.bischoff@arm.com>
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

gic__create_its_frame() closes the device fd if the address attribute
is unavailable, but returns without closing it if setting the address
or initialising the ITS fails. Route all errors after device creation
through the same close path.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arm64/gic.c b/arm64/gic.c
index debb0381..f8371f50 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -124,17 +124,22 @@ static int gic__create_its_frame(struct kvm *kvm, u64 its_frame_addr)
 	}
 
 	err = ioctl(its_device.fd, KVM_HAS_DEVICE_ATTR, &its_attr);
-	if (err) {
-		close(its_device.fd);
-		its_device.fd = -1;
-		return err;
-	}
+	if (err)
+		goto out_close;
 
 	err = ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_attr);
 	if (err)
-		return err;
+		goto out_close;
 
-	return ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_init_attr);
+	err = ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_init_attr);
+	if (err)
+		goto out_close;
+
+	return 0;
+
+out_close:
+	close(its_device.fd);
+	return err;
 }
 
 static int gic__create_msi_frame(struct kvm *kvm, enum irqchip_type type,
-- 
2.34.1

