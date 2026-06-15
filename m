Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986B3CFF49;
	Mon, 15 Jun 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550796; cv=fail; b=XQ6oXxYmXWH4jy58Jpu1zSibuv8ZZiPydSZwwUpi6uM9zqgCulUPzvgSGmWh7FDafPK3Es5PP54fvLM4QfMmeXKzCpeuTPtQKgeUfBUgplPs61RmyYtfZaPX4SDH0OXpZf9oNNelXQ4oWL9QKo3QXgUyrBXq9/1zn091XlpD0FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550796; c=relaxed/simple;
	bh=ATACjohhjeFBdyoT8XW0iWpoFtjrIMrhzalAH6C14u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlmYJM6eGKRdGhej3nvcykDPyZ/A0qCcOULeMsNhStUTV5p5N3nGmvDps3kfaZ3BVMAcBy+/z4lX7FubLGe80JmW/af/yvA2YhDavVYPWdZMu2JlXiRRtMGtoZ/qHqyA3SW3CyXVXGXsMSKfBAX7nEvH/aQko4LL060juxWdOq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYOudhbs; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYOudhbs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUQnJ+xvoWQWCheN3tpr+8Ka+iZgwoZbbO/9VLLyaWJRmTTo96GfjuEkpGV8d35qforJJo4HtSn1rOxAvZDt+HkfBjRVWgJTOWWsKh5cWoeeiFVHcHttEhuRcSS0PUK7SBIz5GDYGwtIrWRvwv7oszO40cV2SWEFyBpaZW9E3ib6iPdJuee1nHZf3oG2qyXybChHkeCQTLXQ9KKmBNTKUVnCzVjBis/BKWWwA6FVJLin0Sa9pslv/0/2iCnRbt+PSs9ZiQv+1aHTK44vNUT7rJwb1sM3Z91eoxdSQHaszhF2KJ1OHruWswQMPfZSreoe1ZURzFEJZgzk9WDyTfUamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzBK35lTG3oao6gIz4aiooVTOYJVhbuDx7DbrVb/+xI=;
 b=b1Qw/EkX8gZr4UaPKAg1Nid9tGIN57iY4EyV9WhgJn53iBK8dOVGDlukOSlICVvHv2VF8i1ndrXPtBBmeV3gRIjwkKol1vDY+nwqoGPJSqDhGvNBUMGhJVg/ICbVmiub8TMfxRtsg30iWn89xolQ8y+adNNk0E7BYAH2X154YY6fH5ccQQqtGYyzXR1TIuqBbtK/LOx32EQnutv/ikyaqsbJfAzHbBW0xBGGQVvvdVrnU3NA1aOtcIRF7ndovT5JwshIVWZvtL+YRPzyohHxSVNh31FOU7Qqpr5bd4Bju4CAGai8qMtGjpZcrJCQOqHLsf39cqcZQK26Jg//GHsAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzBK35lTG3oao6gIz4aiooVTOYJVhbuDx7DbrVb/+xI=;
 b=fYOudhbsHXnxNOasDwfyxxVD+3pRBSnz6sCr0Sp39nvLiEcOiLFC7siV4eSRYGclIOSmE65v3R8BvtQW7HluNVjcfvdpA0U6OlY7DpwwM5H7v9BjLp4+31sGhlfSVV58OGzttr0CEd5OqXJ4EKzcj2T3jFTCmhf/Pn1dMs3JHkNEFHTu3ri3H1b3oVVHlxZ6yk3x+piVNay95Qr/1N2NIuVnKFBugnbDUVTU8Lkwf5q4tDqR/tUONFY7L+FnnjPC+IY0KjEF2KNTqw8OFvPfUe19ywtTFnY+f8CoGfShep9oGZxvNpGbGMzk3ZW/ZsfXP8nLoYJ/xwmfzRMM5zDuRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:13:02 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:13:02 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: [PATCH v3 6/6] vfio/pci: Expose latched module parameter policy in debugfs
Date: Mon, 15 Jun 2026 13:12:34 -0600
Message-ID: <20260615191241.688297-7-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c09fd1-5d1e-4aca-c636-08decb121e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	31Oe7gj6RhI9PdkmAP+JCl1nTclVNrgD/osQel2Lfid6uNPD9mPul0T8N07GAlUI+ODtySkdL5kqFCBEDuEfUj87onaunqHK6oakrk6EsDneKma8ujwA62/RTKE9/lU+4Wj8R6WqodG7vAnEmXH/7yNqR0+8GZisGXuWbBwfG2EJOI2DjPTEdX8cM/bpiv2GLf6exLWRbMaoYspFk/bLDgBtnSPpK0cBelDTxpFs2b92AL9O06MrTDOJOBdOEsGciwJGrcZgVfsNv0hFZyHhsMYv3sPCV+vkPb4V/FOKf26do3tdAR/U1y6JEfyxT2LkGRbtdaQonArn42oBqYWVd9BOIDbuEkQxVkyr3FfhzSTCOMVad9Wq4mAhIZFExUorSErSusxfLYOKMPnbw/FD4CP4EAmsLTR8+kS8JwcR+g1F/Rw14cjO1YrH5lE1zzebZnLuANRn3IWGxnU4UMiPqZrQQcfGWaQ8n4KEaghcOhNOBadKLWN2iuSOUCpirkNc8Ai6oLhZyoQFAyrImMtIqDEonFPYwGgZ8rqKIjeJDzco+Hnd9fgYOQz3uJiLAjN40I+0EqumT9pi3MkMQp1B1kRyH/KwyO6ZGMgW0sOFFBRz/c4kNm0m2NdHlIih1+Fv6G8gRIwcufO/Toil0VVhuHfCwGi0x6vEqxwIDWGXxeGF5PQIM31pz0O7oxi1dhHx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXhLazZ2V1hHd0FMMC9lZXhCbWIwTmpLYlZISkZpakx2T0RtVVpWR3VDU0tY?=
 =?utf-8?B?VlJUZEhVZ0M2SGlKeDZLak1yY3BpRXBHeHNNbmpneHB0ZjE3Mm9OYzRCUUk4?=
 =?utf-8?B?WUpvaWUvcnN0aFd1RWxBbHZHT2FEZitXNXlLUUFHVlhyOHFONENNSGJqUnU4?=
 =?utf-8?B?R29JYlljS3hTS01JK1Urd0poenFTWHBvaWExQ2N3N0RnWlZTRVZPT0JyTWp5?=
 =?utf-8?B?UTRXSk5hM1lGTkNMZFZ5VTViNEVpRU03U2NGaHovaldxVzJSMGtoUERHNmVP?=
 =?utf-8?B?MWgxNml3cGNPR2VycFF4bGRCWFV5V2FOUndqRmRhTjlidkNSaFhlV2JEaG1Q?=
 =?utf-8?B?Mm56eWI0Y292R0dqNGVaSUpsNmh4cWM1SzF5K05pLy9jTm1PTGV2RitCSnJH?=
 =?utf-8?B?SFdQYTZVRXJyRVdiT0hERi9xdlhkTi96K3BKSWRmN0dnQ1ZiT1p2dW9xNit1?=
 =?utf-8?B?WjE4TXprNUY0bnVCR0xNVWdoU2czc2FrSDMwc1R0bmhpNFptNkMwRnFSZEhE?=
 =?utf-8?B?dGJwWlhGc1hJVWorZXIyU2Y0Q2tVMjR0SUF2YU9nUWlhZi9lbEIrRTFHWWhk?=
 =?utf-8?B?R3g2akZEWDNhMXFXbUdzN0dIOTh1TkowUWFRU3BsYTNvajc4blJoVDRWRVk0?=
 =?utf-8?B?SHpTaEVwZFZmNGxWaW95WkdlSmx5TmRSL1FuRW5FTFhnN2VXQ2VUV2ZtTEMv?=
 =?utf-8?B?WC9mV0EyblVobDNJYmxKZm9ZMUFEQ1dXb0ROYUR1ZG14WGVxTGFCREFHMndO?=
 =?utf-8?B?RVRza1E3VWFNZ1hvc3J2NWhJZHR3eUhWdGZzTGU5Z2pSczFhOURaSzFoWWU0?=
 =?utf-8?B?bE5kS3FZcmRwRTZRTFN4NVI1bUxicWJERXZyS3IweWdGNnhxaHpQTi95TUZD?=
 =?utf-8?B?SXN4VTFBdTNuZER0QUlNMWRFVFdPVStkUWxrV2dySE1BM3pRTGhHcnlXei80?=
 =?utf-8?B?aEJQeVM2bmh5WTdvTW1aYXJrMWpNemVPVXRwdDZ1K3hpRnpjQVdJNjBUQWV4?=
 =?utf-8?B?M25DR2IwL1NsWDNBNlFMaFdiN0lHVmdTVTdTQ3ZMWEw5TDYvaER0UDdUajNu?=
 =?utf-8?B?cDRRNkhzdEVOVFFucjE0MkRreW1iSDhRcVdoRnNmQ2VYVndDaHVmWkRUVmRE?=
 =?utf-8?B?czBzTGVFbWtPVVZDbVl5OFBaRXhKY3F4MmZKMkJrRkxRL090NFpBMGh4V1Jx?=
 =?utf-8?B?OCthTlRpRVNyUjFxSVhkR00xV2cyd3JOcGp0UlA1aStjdE01b0VGV1JvQVM0?=
 =?utf-8?B?VXJ4ZCtBZkg3eWpBaHQvWVhlYjFWQXlRRGNQd3JudGJGUWk4NlNydWJJWURp?=
 =?utf-8?B?bWdaNEc4c0s3WStxem9haUVpUDMvTnVaRXRiMk1ZUlNrUkJjbGNaTmEwZzh6?=
 =?utf-8?B?Mm00Wlp2OG8xbW94V0lYSmtXV2R0U09QU3lxUFJ3RmlacHh5TXdJRnZwdWk4?=
 =?utf-8?B?d3RpZ01oU2g1aUVqeU82MU9sRlFlMXlUUTlPMkNZU2VQWXVRTVNYZGtPTDlQ?=
 =?utf-8?B?Y2t4YVF1QVFxSDJIdnA5SlU2WGdsZGRMR2RHcnlOR09seE1sWGJ5MXR0M0Z4?=
 =?utf-8?B?b2xLSjBOeGVVU01hcktIWTZCNy9jcWV5OXJJckRwejhRMURGbGNGeVAxMkRG?=
 =?utf-8?B?TWRVSit1LzZLWEcwblZoaHE1ejVhZFlmLzdzQ0kvUUtmMHVRVzNrMEJudmNo?=
 =?utf-8?B?TzY5NUJKam0rSk5DbDV1cWR0NmFkSFRxVE5jRGpiWlMrRmw2WmtsNGZxZE43?=
 =?utf-8?B?QVZraFJ1dmVDZ3h2cXR1SUpNTDJ6YjZiWUV0VjJFRmlINktQd1JoRThmT3lL?=
 =?utf-8?B?cEdiTjcvdUM5d0F6SDd1TEx3aHAxTDZreXdSOG1kYnQ4WUhZSEhrQnpMbE95?=
 =?utf-8?B?YnVzODQ1Y0lHQ2VsMkNIendEWm03K0NTa01jSmkrYmtDai9tU25YNmNTOXVq?=
 =?utf-8?B?cnhIRkJiQU9HT0Ivemc2aklvTWNUSDVXeFZyT25GbjA3OUh6Vjh2K2VFblRI?=
 =?utf-8?B?QmZ3SUFMemxwa0Y2QmpMZG4rQXVQMWM0V2Y3WHF6VTEyYU9DbXZDSHU0Nkkz?=
 =?utf-8?B?SmpySmZKQ1JIOTZJRVA0dUxEdmtYajRKMVdYUmdzSVZwYk1WdnlKdmdCZjBk?=
 =?utf-8?B?K011SlIyRW1FL3ZBYm5yaGhLRkxFdlJSSTFQYzJheldvVHdnUHQzQUpVV1Vz?=
 =?utf-8?B?dXYzTnV2VHpCc0xLbGN0ME1PbWt0NU1aMHk3S01ZTDk4NjJRRWlZWEd0c3NK?=
 =?utf-8?B?L0p2L0RiOFgrTXlWQzVsR0o3djBqU0I5cGJVb1hZaUZZSVQ5ZmRQU2ZlKzJ5?=
 =?utf-8?B?aUFENlQ3cm84ZzF6MDJCUDNBRllwYzUwWjBhTHJjN3dGeEV2MmN4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c09fd1-5d1e-4aca-c636-08decb121e58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:13:01.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/6nK5Z9rayIdKe/z+Bw6IIOTVWEiWSEXVkhsinXjixo+bohEdeGG+1FfR+jP1RRsCqGBlyAMVx4XN6o1/rltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

The nointxmask and disable_idle_d3 module parameters remain writable,
but vfio-pci now latches their values into each device at init.  Once a
device is registered, changing the module parameter only affects future
devices, leaving no direct way to confirm the effective policy for an
existing device.

Add a pci debugfs directory under the VFIO device debugfs root and
report the per-device nointxmask and disable_idle_d3 values.  These are
read-only debugfs views and use the same Y/N bool output convention as
the module parameters.

Read-only vfio-pci parameters, such as disable_vga, are not exposed here
because they cannot drift from the latched device value, therefore the
existing module parameter exposure via sysfs is sufficient.

Note that while only vfio-pci currently provides these options, the
implementation is in vfio-pci-core and therefore properly reflects the
device policy in the core, regardless of driver.

Assisted-by: OpenAI Codex:gpt-5
Cc: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 Documentation/ABI/testing/debugfs-vfio | 26 ++++++++++++
 drivers/vfio/pci/vfio_pci_core.c       | 59 ++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
index 70ec2d454686..ed2f29c3a9b4 100644
--- a/Documentation/ABI/testing/debugfs-vfio
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -29,3 +29,29 @@ Date:		Oct 2025
 KernelVersion:	6.18
 Contact:	Cédric Le Goater <clg@redhat.com>
 Description:	Read the migration features of the vfio device.
+
+What:		/sys/kernel/debug/vfio/<device>/pci
+Date:		June 2026
+KernelVersion:	7.2
+Contact:	Alex Williamson <alex.williamson@nvidia.com>
+Description:	This debugfs file directory is used for debugging
+		VFIO PCI devices.
+
+What:		/sys/kernel/debug/vfio/<device>/pci/nointxmask
+Date:		June 2026
+KernelVersion:	7.2
+Contact:	Alex Williamson <alex.williamson@nvidia.com>
+Description:	Read the nointxmask policy latched for this device.  This
+		policy governs whether the device may use PCI 2.3 style
+		INTx masking when supported, reporting a value of "N", or
+		requires APIC level INTx masking, reporting a value of "Y".
+
+What:		/sys/kernel/debug/vfio/<device>/pci/disable_idle_d3
+Date:		June 2026
+KernelVersion:	7.2
+Contact:	Alex Williamson <alex.williamson@nvidia.com>
+Description:	Read the disable_idle_d3 policy latched for this device.  This
+		policy governs whether the device PM runtime usage count is
+		kept elevated while the device is bound to the driver and
+		unused, reporting a value of "Y", or decremented to allow the
+		device to enter a low power state, reporting a value of "N".
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index db36d903dcd4..3f11a9624b9c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/aperture.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
@@ -29,6 +30,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommufd.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/seq_file.h>
 #if IS_ENABLED(CONFIG_EEH)
 #include <asm/eeh.h>
 #endif
@@ -97,6 +99,60 @@ static inline bool vfio_vga_disabled(struct vfio_pci_core_device *vdev)
 #endif
 }
 
+#ifdef CONFIG_VFIO_DEBUGFS
+static struct vfio_pci_core_device *
+vfio_pci_core_debugfs_private(struct seq_file *seq)
+{
+	struct device *dev = seq->private;
+	struct vfio_device *core_vdev = container_of(dev, struct vfio_device,
+						     device);
+
+	return container_of(core_vdev, struct vfio_pci_core_device, vdev);
+}
+
+static int vfio_pci_core_debugfs_nointxmask(struct seq_file *seq, void *data)
+{
+	struct vfio_pci_core_device *vdev = vfio_pci_core_debugfs_private(seq);
+
+	seq_puts(seq, vdev->nointxmask ? "Y\n" : "N\n");
+	return 0;
+}
+
+static int vfio_pci_core_debugfs_disable_idle_d3(struct seq_file *seq,
+						 void *data)
+{
+	struct vfio_pci_core_device *vdev = vfio_pci_core_debugfs_private(seq);
+
+	seq_puts(seq, vdev->disable_idle_d3 ? "Y\n" : "N\n");
+	return 0;
+}
+
+/*
+ * disable_idle_d3 and nointxmask are writable module parameters latched
+ * per device at init, so a device's effective value can differ from the
+ * current parameter setting.  Expose the per-device (read-only) values
+ * here for visibility; read-only parameters can't drift and are omitted.
+ */
+static void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
+{
+	struct device *dev = &vdev->vdev.device;
+	struct dentry *pci_dir;
+
+	if (IS_ERR_OR_NULL(vdev->vdev.debug_root))
+		return;
+
+	pci_dir = debugfs_create_dir("pci", vdev->vdev.debug_root);
+	debugfs_create_devm_seqfile(dev, "nointxmask", pci_dir,
+				    vfio_pci_core_debugfs_nointxmask);
+	debugfs_create_devm_seqfile(dev, "disable_idle_d3", pci_dir,
+				    vfio_pci_core_debugfs_disable_idle_d3);
+}
+#else
+static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
+{
+}
+#endif /* CONFIG_VFIO_DEBUGFS */
+
 /*
  * Our VGA arbiter participation is limited since we don't know anything
  * about the device itself.  However, if the device is the only VGA device
@@ -2242,6 +2298,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	ret = vfio_register_group_dev(&vdev->vdev);
 	if (ret)
 		goto out_power;
+
+	vfio_pci_core_debugfs_init(vdev);
+
 	return 0;
 
 out_power:
-- 
2.53.0

