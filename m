Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B42F8EAC
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585323; cv=none; b=dTm2Dgn1i8CtcUf7KuJhCFhD5DYBtLDdndCRlubS2Uo44yIw0pvmY0ORVjf65nQPRrcGxpW+dm8UenzeSBfJQdLgcerpslMCoeGkXkirSbM/kAr30P8Il+awvUNV3O1ZCboFIKXW1tK2kc+rVuqhlRZlTigIGWpuhDBEuphnJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585323; c=relaxed/simple;
	bh=lmjqe+wz2MLmpS3qsZR8wvfKLvk3gZM+AULrTz1+wsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHV5MDC+bBivrXwxVmeitvZmHlcDFeQ17ZJoQKTnLd35mezpnRFg9SrSZ82iHHtYDgs8F8G4rCz7edJgKk2/kYCDOUfmerUPO+jq+urmd0pkLX9T2MMW/ZwTJuaWmDuVgMVEf4PPZM3ti49ON257w4DO7Fi/02T4ID8UTJTyl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA4Ry5ci; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA4Ry5ci"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842264dde84so1014638b3a.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585321; x=1781190121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=XA4Ry5ciTsxosLc4NggAo2/LVj83bLmwFT8IiJgILcLqY/MMpeQ5QT9BPLFzeJsdzr
         KORDK7r1iMjwe3MF2c8S1TXip5PiWsQN7CpgOpOKkUiEeKLf4S9OzfyqqjJlsN0C4wiq
         qL/AlH5yD1vUBHHCZJrf2wE3J4i0r6G6cUv16bR22y7xJmvmewOyJf3HWxQd6vX0NQoW
         nv2cqM6RQgjKI/fUHAEC15Po1YtKzNff7rjHckN74xDVhVmITG2Mp8MGyE85zFHJUh9b
         4h/Ced+ztJqMc8Qdp0y5TO28L5hTnzrLQc+VONN32yKEez2tQ+SHY/S4WB7JvcyRlAuy
         DPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585321; x=1781190121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=U5NwAnsUC1lR3GGpcx7bNioDhrDvxypxIOJo+glPWk5TnHCHQ0dedY4GRsJ8MPCRv2
         AbLvbAHk2qBMr755BGMsRzzI92tQtTV2Nk+gMW+msxjmPVEY04/ecvaoX6Ofpm0ITJ75
         UVSgbE8CTWLCPlbdAqsnmpzvg1GU7GywaWFnecFE5B66Nqns+hsgWzvWn5tD7F6k66tK
         nYQOh17Xntb7uVWgL2Keq17x+sH3bqR35S6CSQhovYYfL3ismQCoJ8umUlSow7KN04xH
         sQJGmDgw+7CrABEt3tWhLEZLuMxBr6MMz1Dj7hgAsDpSpUkIJexSC0npOO4YmKxyW32x
         qDOg==
X-Forwarded-Encrypted: i=1; AFNElJ8PP9fztiW1knEekKz4SHdSuOye3ZpKA3QWGFHYQs/AFCPnysrqf0Zq5rB5C3yNV8lVFKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkAdTwNMwEnWHx84/cAJlTLfh1w7dLAzKQj3b5IoZixtQ3BQg
	91BCAIn99wFPJozPtShyzSTLWWvtLUpUBvOQCswAN8gNt343r2PPQtNx
X-Gm-Gg: Acq92OGI/lUowKz2MIhLM3csvCDbpzoNPC4sJ1q6Y3P77rYASn7tUydvMaTm46abh0f
	o6zsUdxP4+FMRpFX1Xw/lSEWRuVgcbK+60TYjW94jIvMdXpHincfD2bH9L+aavyVPvjS/vzs9nF
	5re6kF7AgyqmJKiK4CEtg9vqn/nLnjbgMoDUvGshHIbTX0zvYAU6jTkeKPxMzB1fJZccyNuEf6w
	97WAI7m1NJjIhHA1nG3wbITw0mFwwaG8C27TEEnVSsxmCwAEFmMOb1JyN+QpQXzWTVuwLs7v80O
	iC21/MRmGUfDwLj4plb0dUyAQPx1FtI8Oq5nmm7mFar29zaOUAGwlyv5/M1kwLdN6e8ecqhd2x3
	w8dCnaUDworUaBH2QCVOLk24cJhUqkNIStizWSXOvK6t3wqZM8W81YXFA6txSi0iEYUVVEbKiIr
	amuBe78g1CIz8W6IBzXPr4BPBvrDCcrjK8BRx8LA==
X-Received: by 2002:a05:6a00:6c8d:b0:842:47f7:5f1 with SMTP id d2e1a72fcca58-8429b73c68cmr3210028b3a.28.1780585319505;
        Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm6223764b3a.33.2026.06.04.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 03/12] PCI: Convert pci.h to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:44 -0700
Message-ID: <20260604150153.3619662-4-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..73b913bcb87a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -954,7 +954,7 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->vf_rebar_cap;
-- 
2.52.0

