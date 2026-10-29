Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301641;
	b=YkEa02O8djmbtOuijbEDvDMxFBRMvqtotV52Pt6o87s1T81xXhlGZwQiKrO53UgoMXf8
	 H2FaCtix9A8Pl195Q31462Y7TA94N1myLMtcexUFBrbH+DIBoEnQqjwkYkA2vQlgbSqGg
	 L70auchcbDCU05vz2tDvBl+mW56YN3OHN6ZzwR3GOJSSQxIZzYjqAz0DWMcpBj/MlyaGt
	 OZlMMA5maQSgBK1L3yegScxli+vWQ4vZvLDsRHANOTLdeI0qT1yOO8QerZkn0yn2cBdxB
	 CeMTgO07iPKbS1AHXnboJOBbpaP2XBmkyEa9AdL3DRq3C5+FKetPrUPCKYM1r0I0o3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
	b=VBLmqsWH793n3SMQhxjr9uE8Np+OwKnwc+rcUyvTk4dhaI53EPFknwvQ+PZhFb5t+G94
	 jtsnvZ8a5gK4q1prnsOGe66r85KDENNX+PJyUAlWvNXKE68PDkSWeFcO+f45s6moUPx1L
	 I1tIbMSof6US1i/+hB0tFpqqDrbccV3ZO9UaENde1eCzvaZhr9w5w/46QEavb0k9PUZ7q
	 a/9h+R2r4XpOXxprnrQ6ZAAvfG7nNhWYg0HMrqh006iijCPq/wD8L6po0OgLx/oa3SZE0
	 W9dMeQvnG8H0rfSmyfUImooUk3TOHeFDNah6JX2mk/sxhW02nDaCpaQMk5PeTuHIp0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x97OqItx;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC3606A332
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FC3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x97OqItx
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67a2efec15cso1104617d50.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301640; x=1793906440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
        b=x97OqItxM0zTlU1SeqXVC4Vhbt/CfmrDOfg8uezTolPAJeuA8wroLbnXN26YCMiQBF
         Suk3OxZmp4X6FdOJfB38LR+WlWTiA4P8eRG7/ZyQmArInsG0aKLJ0GyM7qTaPc3vJuCq
         7Sonh1b5Gu7zlAHMta36NDBL+DmVu4X9QNZ/f9uVFY/K23cQk9+SxzvPbTlBN1RJ/axZ
         Fr6h/4LXhVC6uJb1ovaP56MOa1RoUHMzfuEo54lEDclSiNC3VPaRE+23cqVGRkvR1rAQ
         iyISuOthySarKzuajCYAggn5Ee7exS7sD6LEiQePbozzygzvfiQ2xd7KjRbzMCvszWxM
         sFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301640; x=1793906440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
        b=nXs8SVoZ1AGJ+9je2SsPAPxrrSsCrtOUB6T+FQ2q9+Tnx+81GXyQh0ln+HSURd8ZZy
         BeGxmZEJADgmDAnz5T8D5+x4OBrwgT/vF+u1Iw2E9qncqs43rrQTpzVNnNxWj/l7loTW
         3GaMbDX2rGdiDp7URGsLNVNRfkXef4ndBoeVPPSeMbZ7BDcA/DZqCGRcFMvNv5TBvgKR
         Z2FcctZMtPuHEoyjJaKxJLXB8588g7G/u7LFkxXvWsu3e3WGqwgTeQWg/ymEnTIYTEAr
         lst2emScV9MhbnJunjlB5QBmlb76GYVbuZLn6SgHSgING4kPfWEpBeYrS1meCRrajSfT
         PWOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsRebAlKiAcV1+BfYcv909uWyEfHQzEmLV039O9u/c5fhcQQwAIar8YiYq6qze1BLW4dk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZo6jJxOA3GnIS6mbfikBtXuFxWik59tr7KWExgja83ynXh4Nl
	zAfWybG4dxsJghhCmTgU/jvbge/+ng1K/wQxqssGoShMQejFUacZyIXe
X-Gm-Gg: AYBFou2SvCIoI9bdpRqZ8R6JgU4ZBH65dafbxTivptsRknO8k4Ii0p7NBnQuRu2ASkM
	pzmqCCbfQAVGDPJE8S085ePZOyLkflHTt63E/uCLisQ+2X8HBPExc6KPjhJ7bma+Bx7JN4BU+T0
	zudmc9vgVpBvrIivxWeXS2RkIM6y6kfdX0wMiA6clIUKb6qfNh76Rnw4fd4ik/0JXLmmUVL/emL
	kJsIvqWk0+9rIcD+aWvI4CMThM1hHN2MTglq71Dv0H+MvQAA+yDVPgfwFQVaet75WOt/aqyl7Tl
	HvOKVc0UizX5OO3Czbwlq3HQuUMeSpg0DyfKNsdFUBcwnvYxJrHt+W84gCOhwXRGN2EyWOyQQLl
	Y9l2UfAQ7kBst8gOrXW1AN8eQzeTEhdoUtW9aDNz2jz+/U4SBZI3boRZVgm6JfK0LFVkBZUb+w7
	tOKqNnlawe9/WnHaziw9qVbbyOqrKK9Yt9eX8sdRavNTAztommA1TGCZbw7tQue4rdncHi4byK4
	C9Toj22Jn6jcZGH+Q1dPPT7n2SqsRogolvipHQqHSWptISf20QOKCCM3O3iUCVqrwF67SgyrB3k
	59wkrtmQBd2XcLJTpBpfaMnHm7jW
X-Received: by 2002:a05:690e:4594:20b0:679:97d1:439e with SMTP id 956f58d0204a3-67ba4cc2978mr56192d50.2.1793301639027;
        Thu, 29 Oct 2026 12:20:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba36dfbf9sm166228d50.2.2026.10.29.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:38 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 2/5] PCI/sysfs: Use user config accessors for bus number attributes
Date: Thu, 29 Oct 2026 12:20:26 -0700
Message-ID: <20261029192032.1325629-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
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

secondary_bus_number and subordinate_bus_number read config space with
pci_read_config_byte(). The kernel config accessors don't check
block_cfg_access, so a read that races with a reset goes to the device
mid-reset and can fail or return a bogus bus number.

Use pci_user_read_config_byte() instead, as the "config" attribute does,
so the read waits for any pci_cfg_access_lock() holder (e.g.
pci_reset_function()) to finish.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..b37a285d717d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -267,7 +267,7 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	err = pci_user_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
@@ -286,7 +286,7 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	err = pci_user_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
-- 
2.53.0-Meta

