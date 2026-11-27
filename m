Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798921;
	b=IyoHXK4retxLO0Ba3uXJUOu1bTWpg0puHRA3+HOC/PqrDsg+YmICWlno4aNmuTmvyg1s
	 ok8l9cVBSq0YycGlbIV3Jvq38z2khfpsXmR+aGr4UHBbcPzgConxxfhjPtMRn80G9z2K2
	 F6BWIqr1fQSaX4bbgMFDrtkGqH+2f++mCUq2z9QLpjdJI2Fhlq7HxCLBMSmSrSUwBSTTB
	 Mcm7X8je11euZmyt1nPDlN/NFO1GZw7HPq8B63P8nv9P5FsrT/dyWcOJMgSpCrFQxsjBC
	 mP8ENBkCiEeLFPIBTHj279gXPdWqe6BlaXzmfgvPPvvta9Edhwz7KwH/2trRYilVIeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ptB7HBBIXmODENruQ/1q8o5lWV2aQFT5cwp/uxamfAM=;
	b=lps1sCsRf+4ti222y66rlY/PPOP5mGUWF7klC5BzxCBCdoChQOzWSCIYW2PjcClccUzo
	 ymVsDLUgOoMVK+DcAq096ZqQKNiXhciArPJ9gLTqeBw8aTrf5VrYL5Nawl56I9H7nBoFN
	 830uiXGI6aYVSlxwsVK+NpZFo3yDVnlo4Tl3wlgPDdr10KOUiK16FCvFPbt3hT+RGlOfl
	 g1W0dMJeQM9IzSga3eoXfjSEfF+J9Qfo4RSRNhw/HIcK9y7LkREC7+sL4fjbDIQHAqZ5T
	 lNu33FhVmqqWUYwJiJTo1GUC6YnbfwUrILDNRcUSZusnb1ZlUDZcGfXAAJeSYizGRfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDaf4GUm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19BE606A32A
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19BE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDaf4GUm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F1391758;
	Fri, 27 Nov 2026 09:01:57 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5C83F632;
	Fri, 27 Nov 2026 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798920; bh=N8bg3ar1PWVMdyOQLfF0aNd7/iiEv1kXMmOX+0mXlJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDaf4GUmZfSAKrRsO0ibyHGrkRdCXO7UimBxygPjjPsVbRStow+qL3JHM+nw9HxWJ
	 4Vk80hiHyIQQfX2nIck6XmM3qkP+bsHKeDNZgWt0E9uOEyma4Pz/sDCjN0+EjKAh4w
	 IkgDvSx6hUDp2cTzKMt5AG9NqciBfg/cxxI13MyY=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 02/23] arm64: Close the ITS descriptor when setup fails
Date: Fri, 27 Nov 2026 17:01:24 +0000
Message-Id: <20261127170145.4138182-3-sascha.bischoff@arm.com>
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

