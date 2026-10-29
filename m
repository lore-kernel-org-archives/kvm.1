Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301641;
	b=eVzsE994pQYJegUHM4BH5pUtTVs/4YXyqCXoH+iOyy6V9WWwYgKn97AbCcjTqduh/kVJ
	 YSzyaPWoO2PHay+I0+VAo8UEDg5jNLkpzLS5bIXCjAwjMMmDwZxsalvyF6fQ/42uaSJ4I
	 yi78BlO0gIzfue0yxRhTmL3tK63BBogAVuLT/d60LleRgfIdmsVhxXXl5zzG8aMly7907
	 GD275sQQVUCO8WnHzoljLr3riKjFLy4VCzYxRMTvU8E+B3IhLAfzFd5k/ekM2gJcjSbk5
	 N+cFJtAylsjpURwKHt5BTHoqMAlRHeW/YQZL7ExTWNSE87qYGH1ligtypg2Te1dlthA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
	b=5eruOlt03nUFBtyljJb+Gjxzgxu+Tvu9zRBWNe1rkch0GKEevlaAGBqUNU3mohrShynS
	 KkbuIF0wRkOcUE9zF5W4X2nqfgKIX0dwg7bPuYSmT/CuVog4p30UJY6IbSIH4RJeb6KOg
	 5VG/dvqUcjDG22E8pRs1O7Y5z6MAXVpMAn5Unf6TE5aejIFUPKU1ikZN5CDaZJQMUFORx
	 or1845ot3ZECyF0WwDoiir1TSLpI/KYCZC7H2z4rMZ1xrcFunvjKlYFcRXYrb+VALcowa
	 m5WMmRoeDKbwk6TPzLqmJksZspfXJJAOsWvq979iYO4lFWEJ5m4I9OG9QGbMAhDVI2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEgQ5Ebs;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86333606A337
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86333606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEgQ5Ebs
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b09e07e149so22355087b3.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301641; x=1793906441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
        b=TEgQ5Ebs2QXPP4igGJnoTaxhZKp07UcjkF2eZiy6XE3wWw6gnMngFPJuvVcQbDAH8V
         P/DE71rVaQBQa1D5LUEGpq2+WFKZQ6M0M2q1fXBbwi7XVU3pzNLeZHS67nixJOwETAZu
         oj0tIY4zS8iyWTRnsksxo9pe+SWWpQ31JINLG+WHMqYOq3z0l1O8GYpbG8rD79B24m8i
         NqrLRlnbtTZIMRuwogmOsUAtq07CId2qcqO5dt8VqLF4NrAF+4usXpLBN1UGVc44BVpn
         gOpOg98yIOQFo4I4fhxj/zZM6JGaIRN8x4UMhs31Derlm1NTDINN/eAgWTj1qrovOoV+
         z0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301641; x=1793906441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
        b=EwlQtKZPNbvpJP99aVkFmv/IecKuWN9VKGcq1GQJKoJmdq8b9rhjAPTTXhErwjcP82
         H4TFdOnlZ+eyrhqSd+4646et7QD5yKQzyaZ4kzeWzg8IITw1eqwq2ZLascaMp4cvhX+C
         RSQsnZ78dOsLFwCSSv60HoSoD6QgXlpfONT0WLOWxxrN0tXUAiFu2AjVpNPobIAZuFJI
         Uyi6cVv9V8rxhOmPWbrdKqxbhuouch6YPtRXY1UkH6WJ9EB4Bp4eklNBgL6DW6dO31S1
         BkN5Jd/hZaD6i7LJJcJalEGU76HGZBnXHC06EUEAe5al0Xtn1Dtr4vdNDGGzRLVVmrI8
         /uOA==
X-Forwarded-Encrypted: i=1; AKwUvBxP6vVDwOXVK4pajrYDlT2R1pRYq7K9rrcf/ocs6ghKUeoEP0P3J26iz+f266bdOFyXlN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS/YEeVcv/3zr5/OSo6OW/wdbQMw7usHotNsKVLKRP00aiOxUx
	Z5OvNaTJ/A0pFCF+dVCpwX2Iq8TqW8Iefd0EvtZE9L6R+ZXsGjWZaM3d
X-Gm-Gg: AYBFou2iWbBTsF7xTcr+3ccn54c9//3qiAIZPAoY69ObtE8cxcDR3fWxfWIaXN3QkJg
	qOF8W0O0KWxRaCW1BYANbUPLQI0TgVidFr8mh0m49ieajkGO5HLM4fzaomIanxuR9HAWNeaqpIT
	Z13m/ekKoC0H/cZXisawkfU6XQNiGXvXMim+CDNJOchhwx0Qc3hhf4oaaGerlYud9rPlMHcml03
	IsGlFN3BVmlt9lXzF/y77Qz6947B/71h4Xs65qc4+Z+t6CjSAvF+GJlVNgAk8iYlo1agvuvXLiw
	MJQBxSIJ0X0qK0XGjf0awMXeeBx+Nc+4O+/Gk5+R0qdN9apLO8eDHfwb+GdbgDpxAecaKkxSab+
	rIu49eONtV9JsMpjUgnGx4jpESBQfA/PkRX+9BGhbpEdDtQ/Yt2fQ1DdUnk/1twlqPz9mremhM9
	yRAar2VwEaj+xWqohf5lNM2pCkdBAin3b877sprGdctAAnVehfSAOYBh7cGm/n6+oFqwmtPtATy
	fC8tLRvxeP+14WP5zPYhx2run0ZXE2lyC2K1WPrDgFD0o6qQvamU4gJkOHV9dXYJrvQJ1Rw/On1
	yylnMAwAlfrm7feYCd3XrBYIQrgx
X-Received: by 2002:a05:690c:6602:b0:8b0:a957:80a2 with SMTP id 00721157ae682-8b1b5cc61f9mr38215067b3.41.1793301640787;
        Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b4ab040asm750707b3.14.2026.10.29.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 3/5] PCI: Add pcie_capability_user_read_{word,dword}()
Date: Thu, 29 Oct 2026 12:20:27 -0700
Message-ID: <20261029192032.1325629-4-thepacketgeek@gmail.com>
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

pcie_capability_read_word() and pcie_capability_read_dword() use the
kernel config accessors which don't check block_cfg_access, so they
can't be used for reads on behalf of userspace that should wait for a
reset (or other pci_cfg_access_lock() holder) to finish.

Add pcie_capability_user_read_word() and
pcie_capability_user_read_dword() helpers, which provide the same function
using the user config accessors.

These are for use within the PCI core, so they are declared in
drivers/pci/pci.h and not exported.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/access.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 18a206bb2a94..ff5a16236758 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -490,6 +490,56 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 }
 EXPORT_SYMBOL(pcie_capability_read_dword);
 
+/*
+ * Same as pcie_capability_read_{word,dword}(), but using the user config
+ * accessors.  Returns 0 on success, negative values indicate error.
+ */
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 1)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_word(dev, pci_pcie_cap(dev) + pos,
+						val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 3)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_dword(dev, pci_pcie_cap(dev) + pos,
+						 val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 {
 	if (pos & 1)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..7c5a2ebc5706 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -128,6 +128,8 @@ extern struct mutex pci_rescan_remove_lock;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val);
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val);
 
 /* Standard Capability finder */
 /**
-- 
2.53.0-Meta

