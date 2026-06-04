Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE60317177
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585645; cv=none; b=i/K8j1CfIVifDPQQIKuw2NPlWIo7eZCMp9QwNe7KZi8p/c5G4xIEBiUqJhQDKgdwtdL3sArPhMJHAHg2Jzn4YxM94cSqy7pZ+vr8WGn+C0YJWeiDIOojITe4jeVrVNm+WdZC96gnTYn/u7TU2d/wRW2IDkQFBhCwc48VWrdvT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585645; c=relaxed/simple;
	bh=cqs9K7t4GQhb0P+3IHmoEk0x+onZANKdAYdq39+2FfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCp0dtDNRszT0HVQoNba2WTAJJlqMUelGLZZeRE6jFefriNTBUy2jSK8btNcSEmX24Dc5fmgMXFWC31dWrdjVKxvGDWD+UbXI7tyAEKK7W0yydRBk4e5Zm0EFWx40PfasM+uC9uGaJwLaV/KVWJcz3QiY75TujmxvNnzm+ExcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKMnJwAq; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKMnJwAq"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b5dfde3cso433963a34.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585643; x=1781190443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=qKMnJwAqGdYyLElS5TwFfq0J3TlGClv7mwJKArb+YORdMO0cYKa8JLrvG6W1iJSWf6
         Zb3wUjDMqOsb9wwq347E2SQEgdm30Y0SmkmmSwS8STeWmp0i2v3ldeWO2S0ur2nrHHwi
         /xVVR67jvveKS3thKAvRgMTAnH4WmRkYOh+oDRyiN6RTW5ZhAUs4F16N5vFt6Up1mzHe
         xc9pXXQBzUIC3nTH+j+wU0E7BLewfMMMUidnFIkUYH2TK2s9IaS2zu3kgpYrykIiD7Qj
         I/+Y5kbPj9HxXn6U5wWK9mlnl/H2wwgZWqm0Fu2J2/h8EhAn/J35aMT1GVLxNgZhquHB
         bcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585643; x=1781190443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=gUSxHWpB7EqQPmC2bHHNr5oxXTDBybEFpAkc94qJ6Xn2IGlwloe8lNlehTxZ/Mzvj3
         gBgugWRwAq3Nv16P7mltXfEWvMClWzaIT5EOHCA2bv8yDwt5va4z1HAvvg1t/uO3TgiD
         b2i6z55eOnyzNOKnmX3AkJ6EluwEsYupflKyLJ5ahaTt8WTSBQebiSgv3CvYaI6CLn3C
         hBToPo6N3LqP5qTtSL9Tu55sF8jJWWoginm18pBD0tMQIbhenaFxHpoJZ1hGyKySDe9G
         6c2R2Vpe0Ficf/eZLcMPx6YbWdOmSuyj8OaSxG59yaL7cpGn5d/VdQEgtCtpCjniKahv
         ZUPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NaHgdEEcnGTJJg7Ozd/YSwBRSW1wYrGFIHeiwQjI/uAOd0r+EtvBw90t67McEc/12juo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXVupEcUEYvEuPDU/LSF+CHWxf4Mfh1ZXuS2yL72uYUWxSz9o
	mUgQAzQQ8ES6+oK+908KTl95BoSttSUwca/0pTMm5tMjF64rvoCxkAXRvQ1Nog==
X-Gm-Gg: Acq92OGctCpoMilxKKByTCEg1fuffEXWWUDoJLXahsL/EddKw/wwgVvwsBCkinqLwyV
	Fn4DI5cFhnE1W8hKHZtSu46at7YgxkJJ8MOOmwOEXTvOfKWb0y5tNXxbumWCOXtqelKy0g7Ad/q
	Yfc+PUX1v9+l54kE4oTV2nz/bTvHHGQ5KLX6Q7J9spoW9iCouUBFxdZznwLc5x5VbbUFM0eMG/c
	lhI6F/cbvOTDYA4nVcCKcRDyr65wbkLHCm+jSL/JN0EyFh6iuG4mpqc7PEycbpAGWvjJLRlr6sf
	NBfhUtnCrZ+bhPn58g60P42SlcFm5mhRvemcnvmMPwAeb/seaJyet8kWY/KtwszO+qEXYGqdbS4
	NFygZXFzVWUUjnvsoYuZLnkR/S0JP9U3rZxPuo0sRp10Zib//URN93BdjNccyMx0w72kgNW1SuI
	8Y/hRG9xk9rXxgdeqhJyMX2lPTIroHW+0WeBsKOOc=
X-Received: by 2002:a17:902:be03:b0:2bf:13b0:f8ed with SMTP id d9443c01a7336-2c163a28b4dmr55201165ad.3.1780585322733;
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm64224585ad.82.2026.06.04.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
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
Subject: [RFC 05/12] PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:46 -0700
Message-ID: <20260604150153.3619662-6-dimitri.daskalakis1@gmail.com>
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
 arch/s390/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..5e6f600bf60b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -611,7 +611,7 @@ int pcibios_device_add(struct pci_dev *pdev)
 
 	/* The pdev has a reference to the zdev via its bus */
 	zpci_zdev_get(zdev);
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		pdev->no_vf_scan = 1;
 
 	zpci_map_resources(pdev);
-- 
2.52.0

