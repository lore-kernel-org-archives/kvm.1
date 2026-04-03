Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB8390C9A;
	Fri,  3 Apr 2026 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259895; cv=fail; b=SL7lr+eIb2yQXmzt5EWmmNcufhJIAwrPKFrvGqw0pR0cBu9OfGNRZywsMhwfVwJwovf+DpVkvwPn3dw2vEsRQoaQ04zZIARIvt+LfSJLwFlanBz8LqBXDji03CFv+WMq3fXLkdxExwa8tFP2OaNv2GpxgswnmkHEV3bRwwhHUQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259895; c=relaxed/simple;
	bh=9JpPmJcqnUEH5kLf4QOMQg2Kxo7vH/e/am2pPGbU2kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9vZGJcT3OpoKjRDCViHOVaFTkZJHcLyiFhJFFsLiVI0u8lhM9ZbJYn4RINt5saNFSy5/vjHR/2wnmYuNEWLuAx0a0DpE7N6uJgkbeinxNDM0SkHFQEMhVHzSwW5ynaqZuIG+vJ3GEWlyh5JKnnoP5qgUoQAcNgeMw7dzpSpWrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eiIppbhk; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiIppbhk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1NtrWuxln9/4j9MVnLUo1lcdfHe8W+m2Nr8/suxWtZziTQFX+OZ6KHEf9UnDR9nPrapSxvh9VaZExFtUBEge/u5JAEcbu+ok6OUfGE0v73IT63xP+sVFeTvi5rvnI8V2GRvnAAY6w4NDeavpeXs+aa7BLD25dKwGGvI7/F0GIApviagjHh7Rb+8RZMA7kVUWO1PPuSrEkKlDZlSxIAiqq5fipNZJAbeWhkuWtbcAz35rd6kx49h5CCu31JM2fSjhFrVaNGpai0lVXJWBRjYk7KqBYgn6lFoToKOtN9K3Ni9QcOS5EkmU9hm9ZIMP/QzUEeFMceBcLZYR5zQADGGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15hSr+SkcuyY1x8UUqw3MD5I8+qQl7bkKNw8nabm6iE=;
 b=bC+dOVqiahd7A1cG+B6zBnBt71/6bPSXatWcuUQ5X8xilIFQ8qg9hFIThCOdj4byFDF7WeD9sDTRrs0ppkuM92h5qAqkW3XuvODm/CTW8MPIgXCrRKv7CuA/eJ4qBf67Y0xWtX8ZSCDg2Z7h4YA/Y7VWiT/XzY8Fr0O0lbKo0MkCkOh7FcfoXHG0EAKuXnI6q6jCNdek4r0/0i21yxBIdy4QAUelvCm7GeRaAI3PUtMz6EB8O8JsIqiTZuxxqvOhO1Pr9QN3znTvZtfVmyNtgLgDkjSU86mYuD00+c13DJ0UN0mqSCIxaJ13cLtQOs4MNs47HPE+mqYr9zg7YD5UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15hSr+SkcuyY1x8UUqw3MD5I8+qQl7bkKNw8nabm6iE=;
 b=eiIppbhkpccQxUHHUTx/zE5AVMLsbcTa6Ljn0k38KapgbyUwX3UOoB9K+xMuDZDvAPBuLdqo3fTx2G9CfdS0cwHux189vSa7MKC/HRlkoKrdFGmBvortbUZ9P417kNzKFY/EIxS4oyzyYotxslsGR6I9UL190WKDcS+aAXJQfJqqb+AXWaH1iqEJQnn4Pb5wXgcGLkpcxkStEXlSUmJOCBbdKdtOoLYVvnQLDWLV3rGK5ZExYD/Yq5+GncnZ9TI9Fw42W9ZPF1tptUA19/kxPo5sckM/iMIBtMYODpeFgdSpbp2SiK8ZEYILEtSmotwoLAHLAYLNuDfQPTOkgScD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH0PR12MB7078.namprd12.prod.outlook.com
 (2603:10b6:510:21d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:44:49 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 23:44:49 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/4] selftests/vfio: Add generic PCI command register helpers
Date: Fri,  3 Apr 2026 16:44:42 -0700
Message-ID: <20260403234444.350867-3-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403234444.350867-1-rubind@nvidia.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c006755-b4a8-45a7-dc36-08de91dafe63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8USozuzGjqU/rZ3Am1mcU1gbj9oSj7s3xF/n7oUdC/jVKuz/HTn35Gfz0+Q+7aYiWawqfkgmuEyf6pNVFRF80lT54AIUr8K+NhuxEU5trL51rmnSMNnLaZKJMN+wsYXoQnOqof3vtSypWy09YLiZgOb+/dYiVu8Pn/bXV30vlXZUqUUXLbGHNvuhpRNohVtEjLgH4qP5xa1X0bWNX7QHqXFZbRshxda6663mMleDGeQ/jFGZ8HtHgq99bx+ZIVGXErY5OjsQZJTESfeMXWzlcOH43YwwAiujezU7XaEw2bUhspaKWqx+v7CaFHwtTv6Np6lImATK1T55w9ta6Sh6H0qQTkqMRhvLHaP+9+bSPB9D7PwuCaZQQ6fRdUf4Org1REGYPNOQ0b4RDsHzQfaaI/mC7IgMLkdxOTnU/qDHvswAAJowCJST+95k1dpEMr9Rt6g60y/0JbttZSGIojakx265Occw8VHF29hrJPNM03r7aQ5XolntKX/y8W057ZsdzIwH4j8r9VmrW3WKXsVgt/0+Ksp9oXK1SwEMJ4/7YjD2wN/6SYSMrOup3PVdMHO5FfM6SuiHOkbSUMU5g+o2mwjXGWRxDn2RlhArqy0Wlo9D+qMavpQr9fP8tvtz7QoVGTudc6h0Apwxl3new3u/MaCVJ67MzXX42v+daX0SW9l3Ke1776PWGj/GFFyjgegTjg0KSLDwVQ7C4LFMiqKLYTfHfBBawF50fmgek8PzzRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTp4uV6HXsijih0z2lhO4cr2j7F4/GQPX7JSUVYn8IkG4OjfQ4tR35lBHCkH?=
 =?us-ascii?Q?Bw6r0xIIkn13ItBzfGYFFsIBzWaaItlvF/N2MhlqJrD+dJuY7yXp91jtUhg9?=
 =?us-ascii?Q?97a/YPWU9Tj2fBHeqOh7tTHPSUPaN0hIUM3wghybBBQDqrt8a/Alew+K8B96?=
 =?us-ascii?Q?w4abk+uhSPe/4k1NR991Ms3Q1qGVF37KhoLaLUMUcgGBRj+r2cBa2qHXnncr?=
 =?us-ascii?Q?JqATMV941agbzdhSceG/ukkItxCenA1echcF1X9HtBR04Xk3/lX1nTFogwuQ?=
 =?us-ascii?Q?F5Mn/nvq47OujgfV0H/TtRtpUZXcNldOJKqtsPxplOkgqbnTCHMq2haa+niW?=
 =?us-ascii?Q?qs4qeuO1WLJmUdBJ0BozA96Uhh3zIe1oiEhK2xIUPsf+S0TEa6XhLWEFn5dF?=
 =?us-ascii?Q?C0Qx9V2ur/Vr7es5rULTmPEdrYcBAAlIMB1Am0c/D5TZIgXsiI1i+IuaY2oW?=
 =?us-ascii?Q?MKcJhLNhyCJJDrrAok4B3JCI8Q/DkuK2iJbfvvKIhyYc/k2S0/aXCzMjC5dJ?=
 =?us-ascii?Q?Yv9qahPwLoiRH7k39uuQ7cwtYBMxk4xpamrT8+e6+PGX4Xk/YKyjD0qDYRZ1?=
 =?us-ascii?Q?gWzOfiSujn4RKRvLkqkULP9w73kI8rnwv44h6EdOwfJfAg52mYa5NJFtWjju?=
 =?us-ascii?Q?TaxKjKq7frVowLKmVAqju1V7ZIPbJGhiR3zbXV1d47d59T/j5WuP6u7qZ7Eb?=
 =?us-ascii?Q?+iPY0m9C/J/kejC0dMobj2sOIIAMSXbZ48l85Bqr77xcdaEwWyUNReDXkXJo?=
 =?us-ascii?Q?fvsEYvCvIm7wWdYfHfLPB7yHwXougFzfClEtmJpewQUwdoMkyMSQv6+ioxzl?=
 =?us-ascii?Q?FiTKneS5114VnsR0h+aS4Pb4sDIc9ZUE8ymHICdmQo4jlm595zCKX5nkLQHT?=
 =?us-ascii?Q?qHeossTd1xnJMhzxcBYiiDwBHH4SOAOXdeLY9vtQU5d9bDEGnlfZcSBdbWyA?=
 =?us-ascii?Q?KE58fKVgrpDoURuvudP7k3AEqxOpCik/5mpa7oK407iZ31nb3/jYD8rqao8m?=
 =?us-ascii?Q?dqUa8po5JpJ5jv6Vw0iIQv5CN3J8WKJHxF8cjjyo9SmwqVdKQ6rxUFIgMxQJ?=
 =?us-ascii?Q?2mfP8CqQCEdLZfabt2Rcs+hBqhRyng7L/ITdDoxeu6YcP0mKBGRTJHykTuUH?=
 =?us-ascii?Q?W28Ra1zh/GIcqHroN8+aD9feL8q2dvmCYQamGyuRpDcZOOjxRNSO5VaUAmXF?=
 =?us-ascii?Q?6TT9xLwj+lLEGTT9IVSNk36NYj61MCdlavFe1EdoActjGNxiSdsM3CpwD/7N?=
 =?us-ascii?Q?w1vApeCBh9QPIXijkdsKtneQQA2zVuBqQj/tpq1+/8+2Hp31hfZ/b6UuUi8Q?=
 =?us-ascii?Q?sDTss57smIlZG/NfzRwlip2lcbNUIwY7u2EGQcqMUihmnxzfc84rQXa8MUrK?=
 =?us-ascii?Q?/sceG4aaUguwMUredMng4RM1tQX1rJ0d3idI8ZGcSd5sK1QWkZdMHySmt5Zs?=
 =?us-ascii?Q?QISy8MuaeZTdpOvIl9IFkBP0t8ACYAddTL+VUmeImqcagT9t+lhjroGgF73r?=
 =?us-ascii?Q?22ko/JlSNmFvNJjEP20JJRyOItyOmLPONkKNCW1bUnYHMZPvmws3VZEaz/nK?=
 =?us-ascii?Q?/ZT7gzeoiRsKLhzp4/Lca7IwC5mt0z6y4ddJTkBj8VwKy0SFGQ4fw4IlYHYY?=
 =?us-ascii?Q?IC/a7Tw+HbV4YX6anjZZLk38yAP86ckmRGOT4iU3+hgMB4eXbaB37OyaCu7c?=
 =?us-ascii?Q?caFJJ/oG+jqTsIGhSAi2pYPbi0upNr6EJovgafgGhfEFPpZGMowvy+XcVqR2?=
 =?us-ascii?Q?W0J1FvX3ew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c006755-b4a8-45a7-dc36-08de91dafe63
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:44:49.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj7Lo+PGmWDl4tz0qVg+UzEn6DZgen514CsG8X4HhyQQdebHFGm/+ErZvOSevThz4AJhN6Oq/a9xBMwnJLCqHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write macros
for PCI_COMMAND in vfio_pci_device.h.

Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..e5e290eed510 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -65,6 +65,16 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+#define vfio_pci_cmd_set(_device, _bits) do {				\
+	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
+	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd | (_bits));\
+} while (0)
+
+#define vfio_pci_cmd_clear(_device, _bits) do {				\
+	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
+	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd & ~(_bits));\
+} while (0)
+
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
-- 
2.43.0

