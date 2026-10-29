Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301644;
	b=JHTkOpOpjgyDVRWRYYQGwL+Z+79+Nj/m/rVy0WuFonzTPIqZ2M1tRupoaWQcViCwdvIE
	 jjsztHURfaElr1HMg5bUTFShPne4Vrv19/j/Ivi5Ducfy88F4IsaSw/e/wYNAZDx55t4J
	 DURJSby/cAlzuDtKvSUpYmoG3TG5rs9UeB8Rd+8DuwBQoshufeJT5O/LJ/Uf0VsXl6ZW5
	 j5bmJZPdG4MVUZQgY1zeFnG3NKjk3eS7uUcbr4Re3dtHfCK9WjBgKteWaOiWC+9zdc7cs
	 pJsCp1CXUPlIqUAlXRhfDSWJt13pGxsUZc56AO5LbXXsEGMdYiJv4NQNKAXiTiyOlog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
	b=BHS5n4c1vPHg3O6u2OIuaV2/W3mygFqMCTWpUkMS07UgcyJIP1MPqJ8G61v5vUJ7BRc8
	 qAYxx+JdQvZBp+itUuAM6wIZnaVbtj3h6Sw47kOFk81f9RN1WS0Ienm+hPwiJIWrE8zDn
	 RZ+4MHOEqfnxeOwXYzHFhkFGp0krEQefy9ikX99fiKDEah1eOzC9cJk+ZytC0sTb12kmc
	 lD70ygc1xP8PmZD2UdRCI1kGx2FtyoU0D20h7Tm+iEsB9a41qkJtayGEaR/Ht4VspNCt8
	 fd0EoY4hsUTFupUsO7jI8HqzewEdGV4FuWzMVsfSguJyeZV1QwAEkUreFlEX3IpaMsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsNs9LwW;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92553606A337
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92553606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsNs9LwW
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6798eb0d13fso2675568d50.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301643; x=1793906443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
        b=lsNs9LwWwBdIbm2FihFgxoP/fMqkuzDz9ocenyA/JzEWYK52Q6R0nyMw6B8yNQSkKR
         YRbMh3bDBWU5FpLF7oWl1GQA2SJne/g46o0VLzbEJtiflvIG21gn/+8AW75Sc48Clgcl
         XfP5O7A/S9UCLq1iUkNOzYvWp+N9tCxZZpoKNEiQF+cJaFDsNa3n424jLMynJrL+M5pG
         x//bVIyWx7WOm8wjKG0Dd0lYrzIWWRuXHTpmfKEa94d55KBXu/HOv9aSL1DL8vmpSL77
         hZSjAEO0lYcQfhXNArbWuG4XqrtHR2FTpa+sFcOggOw7W5GcHezrsvAII+H6gvVYVyGN
         NS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301643; x=1793906443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
        b=n0qua1vFW/dzus21Mj9oRPXkRTaSNMQmMl4wiMsOD0x+rVn4X5A2dTaM1BxipXwiVV
         LFIEz1cgwP2KMg8YVd7ZWk96GStDO/pGWu4srT5WAbznu6Y0cM2acFN0PCq1RumdUGDp
         Aap3tylnxvmqSwXFSul3hdKRsJ32/hJyvYNMZfR9WeZy7WWjc9cy1ZmEJs+A4VN54tOu
         yuIq0BIDLf1WyQQ57yeN8MFjMWA32CPT9vdbDzWLdnrx13aGete17lTP1R6APiIdYtaZ
         QnE11jd4k/KHzsXa9Gw5v3AVx01Ysj+q4SU3ESQy/9cofvcWTZXM53x/wDfF8BM5BTqx
         GyMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwAr+xgBU8oX5X08Fngp2xCfbTod9btI5M5fU8K4lFVEudoeKSuMMOsHaMDz+Zugk7n48=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrwvSblfw+5BtpwpC2NriDGt7WwXIR9mObwjm16Cj2dI/Vk+LZ
	+UPo/mx8vwwU/S86Z2wsBNlbXFBrFYBptHgZs1+ka5cmQ+YAbGWuNqj/K5bZgg==
X-Gm-Gg: AYBFou09gc0c0j1H2oM+xOhfUNp7SHanwhB1qHuzlCa/QUuaNd3QcpNC/33LcbUuXrI
	lpCkrzmQVEeZZzZJF4kDbpKBfB2r+Xr5Dmfw/5JWVLDpzQ3k+IFyQ6H9325eLb4tOR/deoX0iHJ
	J06G3mXsZwTEDPZjlz6d9dI3IbtGZHYs6COgvyntiGwv1Y44Kkd/sSG4GmEBImulFW3D5+kbknV
	GHEe+USBeSorelOBQ8Ho35Te081JmAMqAsMDJProZjUOk4UZEC7xjJZx7+3z/72W+xK3SP/BAc0
	H+eV8LKGvz0s3BlKGa3IIm2wRrYG58WwrqqJkcEVGTNvHLF8sMEg1qvYS0lyBgCIdUHoO6Zs/cj
	OnclvFoafZVsa8f1dWkpNTQ3cgwBtxCaAZcUfxXSRlT/aPdnd7rhmsjoUDzGTFJ8bA6utr9NJUz
	5NNk48z8JDC4367DiyWAXj5wGD4W20h35tGbxGWZ7kxTulcU9e4uyUyJu/GVk/cdG4WrOwjOiHf
	3M+RizBIN9SGg6d0xeKk8ytLyn7fPEWr8zF+Go+ggwcMmx0mZfZBb55qYLnQsidhTtHZEeEyHQs
	MxXBAv8rlKcTM3OTIfXv5UI2T8eW
X-Received: by 2002:a05:690e:4812:b0:679:9eb4:45fb with SMTP id 956f58d0204a3-67ba502320emr24880d50.133.1793301642649;
        Thu, 29 Oct 2026 12:20:42 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba3a97758sm147801d50.23.2026.10.29.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:42 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 4/5] PCI/sysfs: Use user config accessors for link attributes
Date: Thu, 29 Oct 2026 12:20:28 -0700
Message-ID: <20261029192032.1325629-5-thepacketgeek@gmail.com>
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

max_link_width, current_link_speed and current_link_width read the PCIe
Link Capabilities and Link Status registers with the kernel config
accessors. Those don't check block_cfg_access so a read that races
with a reset goes to the device mid-reset and can fail or return a bogus
value.

Use pcie_capability_user_read_{word,dword}() instead so the read waits for
any pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish. For
max_link_width, this means inlining the pcie_get_width_cap() logic
instead of creating an additional helper with this single calling location.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b37a285d717d..a272f8583a8f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -208,14 +208,16 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t ret;
+	u32 lnkcap;
 
 	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
 	pci_config_pm_runtime_get(pdev);
-	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pcie_capability_user_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap);
 	pci_config_pm_runtime_put(pdev);
 
-	return ret;
+	return sysfs_emit(buf, "%u\n", lnkcap ?
+			  FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap) :
+			  PCIE_LNK_WIDTH_UNKNOWN);
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -228,7 +230,8 @@ static ssize_t current_link_speed_show(struct device *dev,
 	enum pci_bus_speed speed;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	err = pcie_capability_user_read_word(pci_dev, PCI_EXP_LNKSTA,
+					     &linkstat);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
@@ -248,7 +251,8 @@ static ssize_t current_link_width_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	err = pcie_capability_user_read_word(pci_dev, PCI_EXP_LNKSTA,
+					     &linkstat);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
-- 
2.53.0-Meta

