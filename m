Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922913F39CE;
	Fri, 15 May 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882671; cv=fail; b=ZLQU82Sh+AZHY8/f4L2g4AEcgD1B2JenGtWFq6mWuWOFaVeW5Yh/edaoAUPDMZm7ZDG4zHJhDWTnbdg1Hnl64WIxxRXRg1oiA9Dq4nMLGUCC6UGZzB61o62JwRs7O3LvZNLwBKCyNYZr75ziEjStsMOi70x0n6Dg7BoDOCZ3NqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882671; c=relaxed/simple;
	bh=NiO/MFWJWv2lHQoTkqJrkMphEHc1TCyLQ9wIGVot+5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6stCwupnRMd1mXY2xbT84WQhRIJ1XPqluoUJi4jQ3sJDkfeMfMJmTWen7rMdsFogVzO68DWFfG9fhj8k2DDsOuYBrpeQCMy5o1BHKKbFfk1w/JMpERUWJgdHv6AdZEtWl0+jRN1UPIsV5VDgPNrrWHoBTew6nIEyltQxFZuWY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTInXoHd; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTInXoHd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEh05FjJn5XykMET2oIBq26HYwh4SZkDjtkcWgvUThJXcyOkcdmX3jjgxncFHDxKLQ/aW9jm+4FXI4Zpkx0870lf69EDUooApicE4fWcu+7wZeWc0v1Ew8dLTQyO7LGlbcxWWJmN9aOutZfGi5nsXCAPgTGqgtRaMzkzLZN+ZcbRaNNrN6qh5kUKfBi+JehS8nYndbI0ZruxNMwBdPVF+W6CjmgvibZMV4t7rlZSF0Z+IR5SDxLD2+LBPJHNSnav3gkwsAUdiBb11OfgHW+2zv2zW/bbbAkpEhO8BGMg04sHMbh4j2AGQUmEEYBeGWl8YDCpjBhGyjxoc5KuSQ28Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYmlaTkuh2BTsw3bSvjZJXfcbCbIJZbzoO+sF4KeLWw=;
 b=nS/gtw43OvQJ5iO26tC8Jq2e8YfxPJo3ykwIbBclJx5ig6FmvLpSHO0dGzlDKziWAs9bWbEaqi/Vi6NWCvyWJK/06hRphCTrREIrB8c4MhiCFOvN2BXJCDSH3rlLo3I/ekH0BnzBYfOSy1d6XN/lLzhCZ889jOyDVyaRmiy692ihLVcjDq43N2GjWfBW38IzQJOh4rOWR+siOX3sl42FwAc5mTJNiaAdH3pG4RAFEgl7D8Oc8ACPk3smigSZmkKPDWdh8KFij1s/MJkvUCkZAy85y2v85OfD+V4I2YNkTvIxyy3tk5bQVLwDx+THhIQsT+ZG3sbKcTSt+85tEzFrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYmlaTkuh2BTsw3bSvjZJXfcbCbIJZbzoO+sF4KeLWw=;
 b=pTInXoHdxK36cj6AVeXkfmJAK9Tt/NplTP674YTd0pDPZYqbGyMLfvC6i6y4LZNBtPWqrbpHBQ5H5JKwQ6RITrYpVAJuXJIgwiM6jnPvhnkToPTSHWLpNwuf6AJIjW1AveqrlwEWiA6JjtL57zzMfnA47o1LxBX7UlsD6VzB1PrBOYNVBB1vmkKv1HHPUQq/0N+nofXUKsFBws0bn/GlYOKDg7p/VoVnMX6pEer44YIl0GqBF7HLlTnEJ4+Egq8V7q0DvtFXlaeBEJbn2cDB/goTuUc07RPrhwdWsEtpXkYE6VHbMqg4KWxk2bSJEOUYVtiZPPwznRG1uyJWUnT8Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:08 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:08 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6/8] selftests/vfio: Add vfio_pci_irq_reenable() helper
Date: Fri, 15 May 2026 16:03:13 -0600
Message-ID: <20260515220330.565792-7-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260515220330.565792-1-alex.williamson@nvidia.com>
References: <20260515220330.565792-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:930:44::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1319ada4-a9d0-4730-3fbe-08deb2cde378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ZfLZ6KKp0wX/9Q8wOl7E5t2o9SZReGozkg5cs83e/79C9bHK/IqpH955f3vHd7LDoGzb+CVHRgma2ATkYvjQvna2P6JEa7L7XN+55SwVcqJQI8CctO4VI6d+p18egzRCqmUkgRkcEWk5+e4l1SvU3YhTImZJhgHXuchgRwPDxjb031JH4imPpNbQHmXKyeOCVw++jXM4GUciaqAotNDLgyDIj6dyLV9nHoaQjQ2GMMNqP+CF5fsw8qEDTDfdbQ8Q2H86+sj+feAp/UV3R5TcXzZi1qQbSIDMJ0bwStzfaEKfcMyHJwdR2KiNBCIU8NDyZIH6Hx1Ba6xyriOSNujZW4QUojokW9FohRPbzsNwIABAaucqnouVUJgH1rNH5xmQc5ZNd22APWdmiLECUeuKiWVfDZCMX7sHO1qm0bh0rb76M5CDrqBkmH/2OZHn17KW17vKS287xK4M+gFRXHlb8+OeTf7MHcpk35YOq6B2chyz5vkkhywxHhSBkyToo0effo1ouumeAvWHIRqdp1WlawwBirRNDSUOJr+VwaUPOih6qP4j/ioIB8JINAGDtJ30MsTVFFPIUgHyMBzhOSzPkgTolECJsIcJaVX1nQK0cd2utQmt6vuT4fW8h2p14pCrP0nrdCOY8QfitBUIrKSzjkWkl1iUc6GmqDg3W+OP6PeZGqoTCxTN+fB2YO7QEQD6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiTBcNfCHQzGhD7jZSPvHDXfn0dqYvLd8qsWB0z3drMqEXREiFLAEb4RtTm/?=
 =?us-ascii?Q?LQu+FOSwJlvOhU6LtM3554crIY2nKceoCJ+1g9QzBuAOsElQrISrQGrthbVA?=
 =?us-ascii?Q?tKqe93SiLmq+06+v1u/1YeyDI1pvawNGvJ4VIYk7UOH81m3vwbXRyqUTn7q0?=
 =?us-ascii?Q?lAOcrWFRxiM/+EYpcia96fQf6zrw9ZaPrm7CMNxp4YVwCI55Aj47UDsJAb5P?=
 =?us-ascii?Q?T7N71k96aoya1hzlUrPqVrJwBXSt7b8IXCsna0M792oCAAuV31ea7c1MX8ty?=
 =?us-ascii?Q?Bwrpie41oJ0B+pefbiVZHEmtZ2KxGjUdFADcf+Bd6iAS7t6rZZdRe709OEEB?=
 =?us-ascii?Q?kR52B/GciJsezm/gxG+mAxu674i+04YNJ0f4TJTxO9bitgVEDpc175KJH41e?=
 =?us-ascii?Q?wXt8VDdwKXs7l+TrFkPHwI2pG/TegcqNHBaGdgXYAr13yOzExs7BM/toq76f?=
 =?us-ascii?Q?AZmRL9i7GCIaWO/dJLeNufwk1vuKENBH5fPL/uVVuwSHCOn3RryAt5XB6peu?=
 =?us-ascii?Q?CqLnssXvZHZJCjF5lh/r6L2GetChPzOnYfPPFp8y1bxoDAGjMmjHDQZjxr18?=
 =?us-ascii?Q?8Kj3iMx8kjcGCCvoPSRHWhanYZ6xL+/RZ7UGNs2eOqaLuDjUTlvt8RAdmFho?=
 =?us-ascii?Q?AW15brBtO8LKDev04qhDCU6imm8LuXLRma4sy+7/nDf+qYn5pZNOMExJufV5?=
 =?us-ascii?Q?/p0pq5ShQaq8MVJooolr67m3STu5OUJhs73dJ8zi3WTJ0sJUjgS0iHg5YYoA?=
 =?us-ascii?Q?IAH65FXWcT3P48Bt0aWCbmwO4MMZ2gptYBKfnZx0K/1+gilMoz/Thw3h88UD?=
 =?us-ascii?Q?yC3aDs3xu35EV57/wGsIQ5cFI/WvlmBhJ7WH/F1Ik1jrRGYg4WVbuWMrzM6+?=
 =?us-ascii?Q?llPOK2/5r0O2C2Oj20VQgQQh/qVLZ5GxhBdbqxPpyBF5QjPtMj8/6BbZBjDL?=
 =?us-ascii?Q?IynbyKUs3eQh3sB+5PgJF8AWThij8jUiBboyDLvO8cocIXV3zVM7SD83e+hQ?=
 =?us-ascii?Q?zRhO4eyIvZlwjyTnQ9ss+96uSEi6V428Nc1v7eu5C2wphU68Fpko0YdCDrPH?=
 =?us-ascii?Q?gDJYPSwcsXL/CDJeV3U432Bzzj/T4h/TCFym4t3r0gq1NtyTemZ08kp9kj4o?=
 =?us-ascii?Q?xX+0I2zHQvWFwpxHDAaCMfSz40Tq1SqNzQzNzsCWLQzQm9etVxRaYSb1pVvs?=
 =?us-ascii?Q?srpJjR7xi4auONxVX7+ZhA0BxXKh3xqFl56QVTQS50izqphFOGfjnFgYBdMK?=
 =?us-ascii?Q?kzlRFfovNWvxddyDr2KOt4GmWBPxVWoKG/kVgjZ4HrTvpwxNJ1rc9+857muJ?=
 =?us-ascii?Q?91jXC0es3LoMK+gaZBaCdaz/rfwNqUOYf9nIV+ZTdhYKtfmx3+SkIqz6Od68?=
 =?us-ascii?Q?NkQUFknj4bDrK7gugmawUEX8d3dH5+HtqyWSLsCh4IEZ0JRWuZX+bJRgMmox?=
 =?us-ascii?Q?Fgg3Mf0Ctx0r3g9Uu2ScvxhvGqMVONLgkGdGnG+ut3hRGRIch/u5H2hHKozX?=
 =?us-ascii?Q?EntOCj0/luliHnDHObxiJ5Is0ZkY8si1volL12yuMgvIzx8sFk4MQZJieqfe?=
 =?us-ascii?Q?g6BaoId7xWcFe8uSkF/WgZ8nNaJ8NfMR+ZipjbY8ZXbKDrqGlqZlg1SFw/Hc?=
 =?us-ascii?Q?brtqmwUeQXSKLbZRDvMB6l9XGJ3JS74yxssMlxjMmUveIC5J2zO88aVx/gDn?=
 =?us-ascii?Q?wz1KxNx21TUcHzB4hrvybxTKfjuVwvEvVVsJIRVjtrFt3JCon3a897SxCls0?=
 =?us-ascii?Q?AXT2YeWwkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1319ada4-a9d0-4730-3fbe-08deb2cde378
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:08.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 639N2gJTaustlU67d7CINpM0xw2PX2jcIdS2et25/FPJnmJZLBCsmRfBfMdgUx0uvsQQO2FsE4OkyvOSWVrmfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

Selftest drivers that recover from a fault by issuing VFIO_DEVICE_RESET
need to re-arm device interrupts afterwards.  VFIO_DEVICE_RESET tears
down the kernel-side IRQ trigger so a subsequent VFIO_DEVICE_SET_IRQS
is required, but the user-side eventfds (and any fd cached in a test
fixture) are still valid and must be preserved.

vfio_pci_irq_enable() refuses to be called for vectors that already
have an eventfd (VFIO_ASSERT_LT), and vfio_pci_irq_disable() closes
all eventfds before resetting the trigger, so neither is suitable.

Add vfio_pci_irq_reenable(device, index, vector, count) which asserts
that the requested range has existing eventfds and re-issues
VFIO_DEVICE_SET_IRQS using them.  Signature mirrors vfio_pci_irq_enable().

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..a362e2b2bfda 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -68,6 +68,8 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
 static inline void fcntl_set_nonblock(int fd)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010..7b8394d0ac50 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -106,6 +106,28 @@ void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
 	vfio_pci_irq_set(device, index, 0, 0, NULL);
 }
 
+/*
+ * Re-issue VFIO_DEVICE_SET_IRQS for an already-enabled vector range using
+ * the existing eventfds.  Intended for drivers that need to re-arm device
+ * interrupts after a VFIO_DEVICE_RESET, which tears down the kernel-side
+ * IRQ trigger but leaves user-side eventfds intact.  Recreating the
+ * eventfds would invalidate any test-fixture cache of the fd, so this
+ * helper deliberately preserves them.
+ */
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count)
+{
+	int i;
+
+	check_supported_irq_index(index);
+
+	for (i = vector; i < vector + count; i++)
+		VFIO_ASSERT_GE(device->msi_eventfds[i], 0,
+			       "vector %d eventfd not allocated\n", i);
+
+	vfio_pci_irq_set(device, index, vector, count, device->msi_eventfds + vector);
+}
+
 static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 			     struct vfio_irq_info *irq_info)
 {
-- 
2.51.0

