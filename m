Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3329B228;
	Mon, 23 Mar 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285240; cv=fail; b=cWpFwPRWdMihXY3Wmk7KD8qKe2UZHNA2ifwzXqlLrrNnWrHYbJC5mvNvBQmu2e/A+k9FjV/biIfm2xE1CvBn2SJGP0AIjljqYDx1ptIhiM3B146C639UPsinSd5WWBLO8125aVDvDSF2qT4lyZru0nkEL45BeMmjYOVHOW1nXhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285240; c=relaxed/simple;
	bh=ab7IWwhLs9g9VnBXNXusZz0s/XXZsRzfZ8q3h+t1NuE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D1j+RBn+fwM1SLZHTv7tAs5yGfIiWM7URGTj4ULXnfV5fZpaXNnDDJ8JrCTx8sAcoQ6FA+dQofnjCB30Y7r/dPYbdN+NLKCbSS3AR4GcogzpIaGepa8BiHVHW6kSMHCPFgM2F1292tjDzQc1vFnHCDJ9makqYqRLgHFTbeMbppE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivkS3+j7; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivkS3+j7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw+1YxkhH90m9mkeRDBEMR82ujCxF9NJMpwIaAOqWV/4oXJlPFtWZwuDm4H6lkrVltCUP/uP0ChuBVTMW51sMsMo8T0bcvTHfk2vE0DITQPyzuRDTQ6+FDlrQrd6ma8WmdJ2dViplokSTDPDWmbQWbk2mQuWdk8OW/t3JODeOwhq3UV1mgmcIQezqX8jtoUdLXkGHVU9HKGZ1cN+5jKg4TyY+aKkZQJ77sEmIjxf0f3V3ugqrFUuI848Z+dmKM3RFAR6FHMBb3zrt/cVKvGeNDhaT8tgggipnLrtaP+XxqVc+HhIQMf9525ivomromnM46RIXksAz5qn8Vxe1VAEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30T5vUIZOtaM1x4GHKn97Shq0e6+bv7pyqk/c0OYpxY=;
 b=iJ2VFFGDLIoEjF+cpG2rJPZvUg8PheJWz42JPGSBppOaGErhumbKUrgS8cP6PDqNdi+29Ej9FUyTPOv7ueWV6BX/6kcKwQNtqVr37yRq507suwp8w+FOmWDgwgMyg4/S72sbDaNF4adpp1KH2x/CrNMjnYQP1cZ78typqkH+gsKrGqR9rarx/6Cz6cVMyeN/BTN3vTyv9kDEx2RWIazwYvAXG/+bq/KMKPy6/pOZulX+3yitcnYFl7R5fQEscQapOPBPIcYzs47zCxGTtv7fWn4+PEgwFgd3ZKgNWBZpi4FDXwXy/1RKCfT6XGcRaSUxF9HsWfNR0XGM/uQCaJs8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30T5vUIZOtaM1x4GHKn97Shq0e6+bv7pyqk/c0OYpxY=;
 b=ivkS3+j7ohU3x4HhPBrZz8vG2CqBcNa8WiNngKQcKJLbotu8f3DYIzkJAYmmO/VOq4Ul4bknk8Gtiiz67vnWR6inkkRWvAJ5Cx4+w1+aw3g+2TEr+Sl/G+f6CogzquzEqWCe1FmsgO0lQTgb/irUbylatJwRQErBSQf3Kb40aXU+UBKzAJyldTpNET9yDz5kGVuzj9eDbF+MPEFd/etfhJg1z5w7EhhrSWTMYvkZ8Cm15sw4XLnxXCSvNW3WyGg4cz541iVSk7KiUFg7bQZgm83OEO3aN/VJ16Qj8nUd0tH3HvXKk0gSu9EYSEUm3/EmPgokFz/fm7rzcBkxJWCpbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:00:35 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:00:35 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Yury Norov <yury.norov@gmail.com>,
	David Howells <dhowells@redhat.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: Yury Norov <ynorov@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] lib: count_zeros: unify count_{leading,trailing}_zeros()
Date: Mon, 23 Mar 2026 13:00:32 -0400
Message-ID: <20260323170032.109858-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:408:f6::11) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 56271343-798e-41ae-4f92-08de88fdb34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nh9WiFI1xL8Ezfhudzt2ONa+qFjMClY+Lf8RG63OvmkDDmN2dajGO1NcSyqW3TKJsrrHAe53VjoLqWiaKvTiK+0Ns3XO4J+zbL/7bXOXuZgpEwRVAas7qVxhBmgcihdy4Yv8SK7q2yOzZXyQg8MGV7TFYEXc6h/6j8DLMP0MZw476ixQtjOBT7nkG8x3zgKTHkBgKXBisPULWZIT09o1xs5D6Nanka77czeX5qG322atUkNpNYX4D8TTeJynC1WP21rBtU0QznzvXwysoKP2ImqTKlABoOXv9f3a13sA8eLOi8i4ptbfDRKCGwmC+XzWKUzBG+wRzNDCNFYoLYBXt2EdGeXb+6t8bOiCiZUzg+OtCGjDeibjxxagYRc+Hpfu2+Bzhn+4HYdLZ/xWUmKTvERoVbDGNyMcO/VKpp596htxaxxrEhMOpgsmSo3jFbBlApg+yZK/xe0FHbYZ1zsoW8sC5Cd3goCNEQon5OZfyuh/oLqNZZyz1JKSrOtzabOXTuGMiNLC1n5ytD2Gfhl7XECl9iHrcjWrVpRbqZudRYFqrHDSjl66VLSR8qalXl3Hg4i9XGAaXyLj/OpfVnCImOYRQ71HVadbOOU8XtJAF8IXd0StiU+jsi4BaobEDRnjt+WpNIeuu+8+C3U10dk89HFb2xCKJUpCNU8Li8uwr5FOlff9YxF+t8dgSprknk/gRVrM/ss5U0P5rPaKQsGr69speu4guOOU6uL+lOny0flF7F6cGFtHes7yC0b+S+xNMWWZMOMZRVNLWLtuVHWQUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GrTrIUgbiXcFwlRZ4LzViDVRgv9M7fs598RFPKXd+tgbK4L6pcP7iEfFB5M?=
 =?us-ascii?Q?2g8UVOZ8wMBtIt76GLhjlMRhdkr7td8rw3R3eO+VqbO0cIKruEiAp1EbRucO?=
 =?us-ascii?Q?dacbeUWOLVf/1TQ30MrQx8r58uoD25ooq45/nwD9BNa+JqmvhGMXtEst5viZ?=
 =?us-ascii?Q?tinR2tufEHa0/Mn6M4Ot2pl7IYw6fF+bKXMbScilC+l0REl3qPUJdZQK6sfJ?=
 =?us-ascii?Q?JulYSQwLSBweuhRwIGp1Fe3qKo6RpRqtioXJWr2Z3QgzAWLqlQCQxnDsjqPp?=
 =?us-ascii?Q?/p4SQd2zjKaQxt2+BFwTufGr7oix3+OiwuMu+XauE5dUKs9qiy7QdgzLaz7f?=
 =?us-ascii?Q?KIta7xINdMYejEQ4pq4C4tfwR1ujP5TJTDpp3xE9PWN88+LF5fl5uo0++7za?=
 =?us-ascii?Q?SWuai87W+Zcpl+E3j+rY7QQGiob+ANBYVnJWaP+bYbMCga8UJBwmMpc1+5s5?=
 =?us-ascii?Q?oICcAw2kz14emVNSZPYuWo2vk4fwSGexjvexgdvEShDV1MYLGxgla1nyC1O3?=
 =?us-ascii?Q?I/yy7KYLRSqlOYOLYgwqM1FY2Bs8U3fQA2Srvegl/5ViBv2XDqcTeQeqZ9pR?=
 =?us-ascii?Q?UboSlzdfhyHL02wd3Qh/d4ZuvioNJ4hbHVVq0g7F5VpLlMrzI9t0obYY6iSh?=
 =?us-ascii?Q?lGbb7WZgITtOWOxoglmlOL/2PWcbU4LcE0u82DPZG6fTv87tHDPsbkPz8aSd?=
 =?us-ascii?Q?8wtJg6FUYYRmH3hfIwdnkJ5krWZNAKfQCT9bvBC/vuwjX1P++fUXvN/rBujw?=
 =?us-ascii?Q?UlySIp/RDvHM0X6EUSXGfYlVZenZwR8A8B2ioUVQWmSF2/sEtkXi1BHHt1Ay?=
 =?us-ascii?Q?MRdCZTgzE3+yduBmCyS79nGv/AqHlVkUn9IBSQj/P0kt8RE3hOqKX+pQCRXH?=
 =?us-ascii?Q?8fH/pY4T9Xz5FtxrKa7kavU/Fji2JO4JLEWq9D0BWJHms5BMexk0qPqgAtKt?=
 =?us-ascii?Q?dDOrjIr6ZDecmUJlcoYdNWitfnrIMmEOUrYAoBYu/nyG/lwAq8HbfSqwQ7Bv?=
 =?us-ascii?Q?b7hZ1gJRVTTqF24xIpFjRCFB+HlP0cn8FguKz4clc2ODKyhKDFRpt4WTxg+H?=
 =?us-ascii?Q?hltNoTG6gJqU+nF/NwgSOPSRoHwLD7XIpwz+ylbnyJPE/5BaZqCzVUpeLuvf?=
 =?us-ascii?Q?CsTXVgWd0EPpH2rmpswF7la46uRjyhNHEBf+ubyZkk7HqDfXdYinbRrcORbv?=
 =?us-ascii?Q?r/c+ObV8DpL1u/tkpb07AsgX/Xo9S8jvfIqyDnazCMI7dgQTSm91LHIGD67a?=
 =?us-ascii?Q?RKPa/jqwFAafbquXy7mX7K5r+pvYv1J5WqYBFHtyxZvbCjVvSSJExxGjKc44?=
 =?us-ascii?Q?brbC/ndOyUsABDeK2awFaUhm49oOl5vhisFSi5P658qMIeqSC9/y3Zc1NQ7B?=
 =?us-ascii?Q?TAbOg/+PbjhODGOJEVZziydAgEkTLGzl3m1he3JYykWHrwef/8opipw0uqeu?=
 =?us-ascii?Q?vVmyRrITwk1zuekQ/o2Y48i35pyiNtF4otS7lHUD1yW9qHGWK3LgtMcXRoxL?=
 =?us-ascii?Q?xxlFy/eEPCzmBXYthCWKN3l5POig39DBGfWeqdUo+g4w/J6rue6NATHFnzUt?=
 =?us-ascii?Q?91sUSOzHQjp62fDSYI68GL3v4uEnTDGJS7DJ6uCn2O89Bq55TRRjSd2Q4oA5?=
 =?us-ascii?Q?KN6OH29K2Mzy1Vx9i7XY2x5yrPKhoeivxiLRvPOTd3cESVod2z+y1psKyoBt?=
 =?us-ascii?Q?RXe0KIn7PhidW4ItZ/+Zn8lK4EsbIUfqM0QVUh+j1EPiVNT2MZLAsi8+Z2h5?=
 =?us-ascii?Q?LavJjN2N2sMqNXyJXhSW9pK5YEM1XV7NLWM5eWmu2xOAkm5/GQnq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56271343-798e-41ae-4f92-08de88fdb34c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:00:35.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NDYq6ZFr/OCrEAoOe3tvFgGK9YmjhySniO2TGkAMl0RoKxucAoIEgJjE0RNEr9MFVRIFW5XvGQd6RvUiEzHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

The 'leading' helper returns BITS_PER_LONG if x == 0, while 'trailing'
one returns COUNT_TRAILING_ZEROS_0, which turns to be -1.

None of the current users explicitly check the returned value for
COUNT_TRAILING_ZEROS_0, except the loongarch, which tests implicitly
for the '>= 0'.

So, align count_trailing_zeros() with the count_leading_zeros(), and
simplify the loongarch handling.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
On top of bitmap-for-next.

 arch/loongarch/kvm/intc/eiointc.c | 4 ++--
 include/linux/count_zeros.h       | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index d2acb4d09e73..3b5268116727 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -16,7 +16,7 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 		ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
 		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 			ipnum = count_trailing_zeros(ipnum);
-			ipnum = (ipnum >= 0 && ipnum < 4) ? ipnum : 0;
+			ipnum = ipnum < 4 ? ipnum : 0;
 		}
 
 		cpuid = ((u8 *)s->coremap)[irq];
@@ -41,7 +41,7 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
 	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 		ipnum = count_trailing_zeros(ipnum);
-		ipnum = (ipnum >= 0 && ipnum < 4) ? ipnum : 0;
+		ipnum = ipnum < 4 ? ipnum : 0;
 	}
 
 	cpu = s->sw_coremap[irq];
diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
index 5034a30b5c7c..b72ba3faa036 100644
--- a/include/linux/count_zeros.h
+++ b/include/linux/count_zeros.h
@@ -10,8 +10,6 @@
 
 #include <asm/bitops.h>
 
-#define COUNT_TRAILING_ZEROS_0 (-1)
-
 /**
  * count_leading_zeros - Count the number of zeros from the MSB back
  * @x: The value
@@ -38,11 +36,11 @@ static inline int count_leading_zeros(unsigned long x)
  *
  * If the LSB of @x is set, the result is 0.
  * If only the MSB of @x is set, then the result is BITS_PER_LONG-1.
- * If @x is 0 then the result is COUNT_TRAILING_ZEROS_0.
+ * If @x is 0 then the result is BITS_PER_LONG.
  */
 static inline int count_trailing_zeros(unsigned long x)
 {
-	return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
+	return x ? __ffs(x) : BITS_PER_LONG;
 }
 
 #endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
-- 
