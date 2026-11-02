Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655272;
	b=HkbjhIAv/dN9y0xx+tlM4iLggW18ZlUBXRvrK8jOgqu2Ecn2ff1j7sFudQx+N8ZD//Uo
	 Lhuz9gWIGPtu5lce9pwhus2tXOKm0OC5O1irR3xE/smV7nJa6JyKwNcd14xxBOwFxT/6k
	 BOltBk4uGVg8mQHJo0Rb5r+Eka3nnE77ySjamh91kcBIwLcgHmYpu2e6INx4VUf30XrV1
	 eZIsHjiVrjSmAw24PSkXnzRZnCcV0CUB6mJcIF/mdPR1ubt+JnerYeFqMb+rqDnN6Nidu
	 jm7zFT3kHHuzKuNHkk3uKNn0glAb4I6kKzTmTaL3QuQDIQtpxZcD+N2p/Hb+0V0UP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655272;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ptB7HBBIXmODENruQ/1q8o5lWV2aQFT5cwp/uxamfAM=;
	b=ITfpF9bwXENO8tadxmFJoc9SPamKYApt7DKTMMqepYxmG3ypBticZ+3TuWpzl8ZQr/BL
	 /JSybYYfkEGr7sIESoEnZRzeRS7YSoSwryeEgaSVyCO1wZhGPXkf6yhrhIuLh0XlA457Y
	 O+8owRCots/MK3DnI/iRnbFeGXzT9FkdQWpt9XCl+fzmDOmYkHar73PK9bFl350/uoMpL
	 d49ZLACgbQxvv3q8LSTPrN+/sT6+6B255xY4Oxo1GBlbfSCd7DYmO00wleYgYZb3OoVj/
	 2cRV75494rGuv2I7PA73kYPGmARZYzoksEjUAKDuo3EkQ8Yt6rodpR4cbaOSeL7E6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QbBkXnfW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53E606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C53E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QbBkXnfW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBF51595;
	Mon,  2 Nov 2026 13:34:27 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 892DB3F673;
	Mon,  2 Nov 2026 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655270; bh=N8bg3ar1PWVMdyOQLfF0aNd7/iiEv1kXMmOX+0mXlJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbBkXnfWSBXI5gKPh9UMdQlpnQGYg2rh1GhZu8aUeZqpVk2LfoSiPCSSXdnVRzpbD
	 CBiKBdHEAvQ5g0PdbbyZYQwLA6VslyKMBg7ouGMDpBl7+fnnKlgELGGtcMXQsnyklR
	 Bg9Yp/vhFX6L+PUWjgcYzYvqpVGQxw5RKo8rQ0J8=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 02/23] arm64: Close the ITS descriptor when setup fails
Date: Mon,  2 Nov 2026 21:33:52 +0000
Message-Id: <20261102213413.4136118-3-sascha.bischoff@arm.com>
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

