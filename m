Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301645;
	b=t7UGRV7GTtKL8DzVdfkpWM0rfmy/gDPWWLYZ7pEciPokJievp+tSt3NywFlAHCVruTjf
	 NzDrGTgc6YqDoOFxS7K74OmxM4ldSBoYqfua5gUSPXiUymsx8M4P7izECWi+Aix59Jpwj
	 /mMs2Nq8OOGi1y8w1oFBRp8GRVJM9akJ3I1dpDjk2N8g3+r6q7bkxzE/mqmG3SoJ2mgSE
	 6gbTis5F+wjjJnW7HqPciEBHmwXbPN77owI/gqF+3SbCwqKYvNJyskyhN13j1gpovmpO2
	 BfW+ii+BXwwYprJ+BaxrfFYpfWshM5ALOp9BmSJsVadWOmA2kMEOPpxVZwZarCVnTqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
	b=aGA6h+RulAYjgMZuz+NI+Mog+jt447Dxjf5rlQ8pzXIHTNnFFAseQa4KrOn1WQsQFI5F
	 ZvposVmre7UxYyHCmAq+M2cnv+WAkuVNuci2DcuZw/VS72ofISZIcAE7n3Wp+KICAIbXz
	 ahfjFNVHFFkIuDiqdROb2J9s/HaMraDC2+aEZ6RppEgH3ZMWgpJNLtZt05kaWVzoj692A
	 B5LwfTgEmQ/v118LcUMR8nrllJYT8814bQHFi4TueAtJqkceAd2vlTkNpdrF6gRzSZqa2
	 nKblUYZtulJkWqVBX308olVMeTi1QmYnMQnneAMoDhw0JKSlWpT2PuGZP97+O+obgMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDWZIvNJ;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221B60A260B
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1221B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDWZIvNJ
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679e86015e2so1258941d50.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301644; x=1793906444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
        b=MDWZIvNJXJWfGggaqa/rEVWLESYuOYbys+QrQUN+FoJraiHlv/rY3p4v6OS5Lz3SI4
         v6gfHBwX2bPLwBwh7s16+VXCYDhyi+c+Gl5iWhtqXDLrAG6s3sY70j1iFCrjQosGL7Ih
         6CQlzkYLaxeD3l9hcUkSp3+BQEFfNMUIN7oCspPNwmB8sm4VKD+FIFH7WuEkazfBl1Aw
         rH0vRBihDifw18jfKYgh31PYfFSG9PFzUeqAN00d5nL0iKOOQyIL1q+Nqoj1s9h2JNbv
         RI1ovIG5lkEH8PJ8ei7PQEy68PCP1LOVRhv1ExlMaOnYgCZDWnXZ9p8qVAuSj+cMxcif
         fByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301644; x=1793906444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
        b=UvCsbm3Jw6z8Zidgoa87gx5cUcTE3J+xcediEHi9NACj4FMKm1cctzJRzshfomWwOK
         cCztSsRima+GDO22GPqgH2PV8a73E0U/nVBBMyo25gBWQE5MYaZu3pQrsjWn6MJf7lb8
         AIlRZzP5wAvg0vZw2/quo8BhcT+U0ncxvoihmsCh4ZYmEbVZASchdK+udGM2HN5riMMK
         SK+B8PJoVtDc2seVmif3jFJZQv/A7nhOjQ+O9TSjPTXb6HEV9/agO0MyH9ZmVABqufk5
         swJBexkiJnbRv6A/+vc2MidVU5g9zJpRa9H1naa4d7lTLUjVvOjbkTkBUbOYSiDuqRsI
         MFWw==
X-Forwarded-Encrypted: i=1; AKwUvBxNt9dViTjAXz6IfjQJ/Ai0kO+ms377ynz8Vp7g9FeLezf2Z33GwCY+/v5czlnASuVuo6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0+ae6Z8FsflFLWwl0QkDrYqFWZv+eERYc/BEjyamd+zII2+JT
	C2zC+eH2QKbNchq5Ag/FNxST0ZnDXBp9eBfUhh34IIjpVyZB49MKejhEEuS9Gg==
X-Gm-Gg: AYBFou3AKiiaju0s3daRKxM6sKHgaQ2X8i9j+7iIiUPizG6EFKmKpb1/Dke0gmtT/2F
	2ZuCm9OK1Fncle1DswAh0rOofsP4d2txs9pMl5ST+wGXXpNkY6xWPnsDm4/WKWuII6x+sQbHLOb
	DBEJFfI2cp9Oe+wylXj5CoWWQLT9mH+iiJLw53YoLPPRQsxL7yeT7J7aUCul3Q18tkrhMJ6MytR
	gTQlzPasP2Ts9DXwnaEOtoHN7kRj8ad6ZRR8A1/efIe7SR6B2cMR75VlwUqAJXTAL36Cc4nbiSp
	q83WG5piMukEAWXUyXD+oDHYJRX6YfPOkKPB2nOuU/5mn3FkxbvwsHkJzfqwjLrBPOSKdjNoy+B
	ZyYDWnAad6YTsFMMjwg3LLavwEHVvaE9OjNSUhmX1RpSE/3yqwAoW1S8YfHMUOGSI+w75f1Bk6p
	ezDglC/yWNLoZCgEIVJYeJtm0mHytC6GyjmGpO7Ckr+7TfqG/sq/oB9yzATpUt6AenORNzp+BAK
	MHNoMT9tOACCBOc174ViohXIixbeu23JqOyZeG2BXiH3Z9RDTlazJPhOmMyZhKbp0ajZtI+Xa7Q
	+6IREsycLkrDomfcK4a9YDP4rGV1
X-Received: by 2002:a05:690e:400b:b0:679:b274:8998 with SMTP id 956f58d0204a3-67a8d6366e5mr2701592d50.47.1793301644142;
        Thu, 29 Oct 2026 12:20:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba3a15d42sm151406d50.14.2026.10.29.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:43 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 5/5] PCI/sysfs: Use user config accessors for serial_number
Date: Thu, 29 Oct 2026 12:20:29 -0700
Message-ID: <20261029192032.1325629-6-thepacketgeek@gmail.com>
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

serial_number_show() reads the device serial number with pci_get_dsn(),
which uses the kernel config accessors which don't check
block_cfg_access, so a read that races with a reset goes to the device
mid-reset and can fail with -EIO or report an all-ones serial number.

Do the capability walk and DSN reads with the user config accessors
instead, as the "config" attribute does, so each access waits for any
pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish.
Also wrap the reads in pci_config_pm_runtime_{get,put}() like the other
attributes that read config space.

A reset can still start between two accesses, but the next access just
waits for it to finish, and the DSN capability is unchanged by a reset.

Add a check that both DSN reads are successful, unlike pci_get_dsn(),
and fail with -EIO instead of reporting an all-ones serial number if
the device is disconnected between the capability walk and the reads.

Unlike pci_find_ext_capability(), the walk doesn't check dev->cfg_size
first. serial_number is only visible if pci_get_dsn() found the DSN
capability when the device was added, and cfg_size is final by then.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
---
 drivers/pci/pci-sysfs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a272f8583a8f..c2a5f53affc1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -696,14 +696,25 @@ static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u64 dsn;
+	u32 lo = 0, hi = 0;
 	u8 bytes[8];
+	int pos, ret = -EIO;
 
-	dsn = pci_get_dsn(pci_dev);
-	if (!dsn)
+	pci_config_pm_runtime_get(pci_dev);
+	pos = PCI_FIND_NEXT_EXT_CAP(pci_user_read_config, 0,
+				    PCI_EXT_CAP_ID_DSN, NULL, pci_dev);
+	if (pos) {
+		ret = pci_user_read_config_dword(pci_dev, pos + 4, &lo);
+		if (!ret)
+			ret = pci_user_read_config_dword(pci_dev, pos + 8,
+							 &hi);
+	}
+	pci_config_pm_runtime_put(pci_dev);
+
+	if (ret || !(lo | hi))
 		return -EIO;
 
-	put_unaligned_be64(dsn, bytes);
+	put_unaligned_be64(((u64)hi << 32) | lo, bytes);
 	return sysfs_emit(buf, "%8phD\n", bytes);
 }
 static DEVICE_ATTR_ADMIN_RO(serial_number);
-- 
2.53.0-Meta

