Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173099;
	b=Tk89kmmz6EZkZRhN8LxmJ4ZCZ5QCMvtakRtO8VBAKilSuHn+hc1Lhp9vypGtdQ/CPTpL
	 ZZyFbMluZO3RUnMZVC3Q7R0GClE+QLwaBQK4gZB1+bVZKKXL9feoBvtoy9Hz9gUO0yFJW
	 GOKb/WvQM1lKlf+Fb2idnW3xmSSYyPX+LgAxA5GvSoCFsXi8D6xLiC1KOzYJTAgtmYfEK
	 1csn2SfHq93LwWCdkw7gtv7lPVZRGqfEFm2eO8GrzHPXJQjSl5bvWhL0x7mPE+g+NVsFN
	 sAojuvJfj07iWQvsjs6Oyqk3IsiuibJma2mIOSNrMJWUNHgjds2K7c85IBqI1TpU2Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=BrQVyBHIuUO7xP+jIZyBG0K3XbPFocXeq1/nJ8yUgN0=;
	b=U8txCv2Oti/+wJQfWeUIsfy3IJIoSIaDn2DBM8BfEPYwmpSOHqE1VtFtuWhHtdCfH+00
	 sv4eyI0p/xlk76Jqd294wYAVGpCO4pVtdpO8GiN+qcx3hpdXb4/AizrvO9OJsTraEe390
	 T/l4j/O7xhLnJeynBycENTqN+tesM4ZVsq7wrOG1C0pEvU46aNpuMRwujT8Scu7Neo/fr
	 I+QIJQtGGovJa7QwzZ92b+2LnXn0zqppAlNzQxyKxJE3+S5edsQMxlmLB5UcRZvgAATcv
	 ZiHL++wZipN+pyEuwinXfvacYyH4ND4BOfl7T3Hg/m+IxiVJ6o4DbJZKTfkPmJXDP1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="GZ/q4eXy";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE760A2623
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFBE760A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GZ/q4eXy
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso4192565e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173097; x=1795777897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrQVyBHIuUO7xP+jIZyBG0K3XbPFocXeq1/nJ8yUgN0=;
        b=GZ/q4eXyHFJZLz4Tvlsx7M3Y2erHYzViZj4OHZrbcZu2PgWkushAt3//jgsnavlMbt
         HB3yWfQstVLwLHZeuw3duM74b2zucyxlvbs4aXU2Db+ziC4LeATZ532XcSFNG9WuQCL3
         UtpSvVuMk8DQKjkWewx/fjDjw285NYYnuK7s//+gn4TTOQcvW1n66sv05wbWVyaKtXww
         Ht6nOb7g2JUqDwQgTQzTptTAihPyArsIJ102Xyjf3tAfKQFTTK5B/f5hsfUOTg1W6KAh
         f0habJSIVTCMRzoJuNr7YUkXVE7RRDNcRvxrsMo3OgxsAiJfz/7UYZoAdRLiIPNXHKlD
         WhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173097; x=1795777897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrQVyBHIuUO7xP+jIZyBG0K3XbPFocXeq1/nJ8yUgN0=;
        b=Lyd6jmjDO/5rsB37SsHhB6fWBWYeaAHysAk5dUv6D2c3fOBB4eMlFDs7ZfSqHINWyG
         be5JaAMmVSMYRw6A7nxCS4Q+NsX8b8GAlWyiQW08s/FmE3OYKTNmMdnnNlbGunzsPr+F
         PGk2siSoIIj9Wo6EGeVecd7wqlliv0/t+skspXx8ZZXK/Pby/5fTF0YniAnMWpCtc9ZK
         YVbJfgdm5v0QPLy/+Lr2qK1F50GrSfxNGlIOs9I96Damuj/1aQmSQltO73Ta26z5Cgz4
         0k1zTe8XPPl/o5pPnpM1Qies/3cdFfTjItBn1m+SKTG0iYWFFlMGbCk0o6GFjXlRIFQd
         bPLg==
X-Forwarded-Encrypted: i=1; AL+hErGe+QpTiDPd2TG/f+v59+jyxpLx7Y6NuaodMj4P+q4v2/IKXHFPKioworse+YoDW9Q378w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YDOJPXzIVvUTgvHbHVraoKm/qy5PYi+7od1rY6Po00CRyNSdp
	iRa55e0d96nAIWzchFB7UarJmD+xRbsRckvO1sXudSYol3BdLJK2oS82Twec04/15No=
X-Gm-Gg: AYBFou0BJICHTrts2ycyxerWYbnkGhSPoB309ObUqQEHVrjULVIqHbn5z5mxGQ32/uv
	QUfsUTs2uf2HkHknlG/Y1f28pcJttFV551xmP3Aj1VAVrlJYC6unAOM/jjjVzVuFhC6ze9WCQ51
	x3VF76uO/tW2JYryR8TxmcqZK/i3t48KNzGpin6709lc7dZ+9k35Bp9yzmxxvAyGPdR28rhd6p3
	63UE8jRLl0t4BD6wkK2yrGdKfcflGmZhgfVYeDKfa7rbbxOl4PfW+ZujY5Ptq93nozNUUjbz6Il
	CXzDqB0P5EyLLhfqbHG+7k8r4s6GwMDOTB+Xjxmw8nDxYojuVA/hARlxnKAGFVoNYJvzKMT72A7
	HdnofVL8ULVm6/CDuw38k7RY4G5XybZ7WdpknWMaIydLsTMahwphaHAbUZuaMlWT9TgfcpbZ5UU
	tP6zKlqCqCB+Su3xtSuaw/VKPu4k2Uz0hPFGDGmb5hdEE/hmf1TeCtGY2V0+kToS1JtSxy00ZrT
	HSJ/5BLlaZmKZQE0HGIngs/i1ytx/y8tV1GwJYfY9fua6IfIfkG0uN72DBcTPnFVZzoFl149VCD
	3W4Yw0Hf2C0ozfZGTZjZkmvQNWQa7crzZrr+T8CUxEUcEwLp8BdiNMsVrFxNcB7bljUoBOPhIZR
	mN4wp49Bsktak8mfe
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4bb88785d2fmr60593795e9.0.1795173097042;
        Fri, 20 Nov 2026 03:11:37 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6ae2dd55sm4879298f8f.30.2026.11.20.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:36 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
	Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Mostafa Saleh <smostafa@google.com>,
	kvm@vger.kernel.org,
	qat-linux@intel.com,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 03/10] vfio: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:04 +0100
Message-ID:  <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8510; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=dPonNBvfNN+Y+hasN6N76yOjaxrJAf2jDLwOrEk6e/k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrPnhdElrJ48htsRj41CZ+RoGPpi+e192BgN eO3/kW3mk+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAqzwAKCRCPgPtYfRL+ TnjtB/9BLbv75MudDVdJQ8yRIH6+8dkN6QGQbvEfeg6obW4wlHuTcmSV0TmcUSHjkZQrML3iXQM oDWxhADtzWGqYWKO0YZX7gXc6lon9nCzctov+ts9qBiLvjYE3SV7cmvY5wWCfrcjRhVq0/vMutM pYeBSSc3jsM3D40slB3SocXaU9mypo0g8CLTogcjhX0kXLaFQNukgo5HBMShJVh25mPLrclntjO 3MT2SGus1yL1yjuLT752ICOBUloat7K1ow7xpM7tis/G8ywOxrVA6LlY/2x+RYTpn0XECnUl/Ss OPflWzM2+BqCA8nJIJ8ye7pB36UGAAVLkOp4Cv8dW16Dk+4F
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex@shazbot.org>

Driver overrides are the standard mechanism for binding vfio drivers
to devices.  With the introduction of the support_driver_override flag
in the core driver struct, it's now required for drivers to declare
themselves as driver_override compatible, otherwise driver_override
bindings will be denied or generate a kernel taint.

Set the support_driver_override flag on the driver struct across all
vfio drivers.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/vfio/cdx/main.c                        | 1 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c              | 1 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 ++-
 drivers/vfio/pci/ism/main.c                    | 3 ++-
 drivers/vfio/pci/mlx5/main.c                   | 3 ++-
 drivers/vfio/pci/nvgrace-gpu/main.c            | 3 ++-
 drivers/vfio/pci/pds/pci_drv.c                 | 3 ++-
 drivers/vfio/pci/qat/main.c                    | 3 ++-
 drivers/vfio/pci/vfio_pci.c                    | 3 ++-
 drivers/vfio/pci/virtio/main.c                 | 3 ++-
 drivers/vfio/pci/xe/main.c                     | 3 ++-
 drivers/vfio/platform/vfio_amba.c              | 1 +
 drivers/vfio/platform/vfio_platform.c          | 1 +
 13 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index 28dc8c825600..fb7679bf92fd 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -358,6 +358,7 @@ static struct cdx_driver vfio_cdx_driver = {
 	.match_id_table	= vfio_cdx_table,
 	.driver	= {
 		.name	= "vfio-cdx",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 15b05b8c0c90..1603f81e0257 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -597,6 +597,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
 	.remove		= vfio_fsl_mc_remove,
 	.driver	= {
 		.name	= "vfio-fsl-mc",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index c82c59246a3f..5c56aff8db01 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1737,7 +1737,8 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
 	.id_table = hisi_acc_vfio_pci_table,
 	.probe = hisi_acc_vfio_pci_probe,
 	.remove = hisi_acc_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops) },
+	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &hisi_acc_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
index cce3bdf1f070..263b377e87c4 100644
--- a/drivers/vfio/pci/ism/main.c
+++ b/drivers/vfio/pci/ism/main.c
@@ -399,7 +399,8 @@ static struct pci_driver ism_vfio_pci_driver = {
 	.id_table = ism_device_table,
 	.probe = ism_vfio_pci_probe,
 	.remove = ism_vfio_pci_remove,
-	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops) },
+	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &ism_vfio_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 18a6d224b1fd..63c89e461be8 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -1451,7 +1451,8 @@ static struct pci_driver mlx5vf_pci_driver = {
 	.id_table = mlx5vf_pci_table,
 	.probe = mlx5vf_pci_probe,
 	.remove = mlx5vf_pci_remove,
-	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops) },
+	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &mlx5vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 5ddec340b73b..946da32c61ff 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -1438,7 +1438,8 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
 	.id_table = nvgrace_gpu_vfio_pci_table,
 	.probe = nvgrace_gpu_probe,
 	.remove = nvgrace_gpu_remove,
-	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops) },
+	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index cf7e33d4d17b..1fcef987f1b0 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -184,7 +184,8 @@ static struct pci_driver pds_vfio_pci_driver = {
 	.id_table = pds_vfio_pci_table,
 	.probe = pds_vfio_pci_probe,
 	.remove = pds_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops) },
+	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &pds_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index 69448fa57df4..8a616f9b6494 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -695,7 +695,8 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
 	.id_table = qat_vf_vfio_pci_table,
 	.probe = qat_vf_vfio_pci_probe,
 	.remove = qat_vf_vfio_pci_remove,
-	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops) },
+	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &qat_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe91..fde2c3fc88eb 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -260,7 +260,8 @@ static struct pci_driver vfio_pci_driver = {
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
 	.err_handler		= &vfio_pci_err_handlers,
-	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops) },
+	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops),
+			    .support_driver_override = true },
 	.driver_managed_dma	= true,
 };
 
diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
index 123ff5193812..1e02a8fd4a61 100644
--- a/drivers/vfio/pci/virtio/main.c
+++ b/drivers/vfio/pci/virtio/main.c
@@ -222,7 +222,8 @@ static struct pci_driver virtiovf_pci_driver = {
 	.id_table = virtiovf_pci_table,
 	.probe = virtiovf_pci_probe,
 	.remove = virtiovf_pci_remove,
-	.driver = { .pm = pm_ptr(&virtiovf_pm_ops) },
+	.driver = { .pm = pm_ptr(&virtiovf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &virtiovf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 7dab3e024aa8..e0ab61f604de 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -592,7 +592,8 @@ static struct pci_driver xe_vfio_pci_driver = {
 	.id_table = xe_vfio_pci_table,
 	.probe = xe_vfio_pci_probe,
 	.remove = xe_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops) },
+	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &xe_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index fa754f203b2d..2c87caf1b7f7 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -137,6 +137,7 @@ static struct amba_driver vfio_amba_driver = {
 	.id_table = vfio_amba_ids,
 	.drv = {
 		.name = "vfio-amba",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index a4d3ace3e02d..93d06032cdde 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -116,6 +116,7 @@ static struct platform_driver vfio_platform_driver = {
 	.remove		= vfio_platform_remove,
 	.driver	= {
 		.name	= "vfio-platform",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
-- 
2.56.0.rc1

