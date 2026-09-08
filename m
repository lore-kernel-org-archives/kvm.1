Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980BC534479;
	Tue,  8 Sep 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876025; cv=fail; b=KqcygOjABKUP0ut60erR8Tl4Skf3lEBL6PH642R4aWcJIXtR244RknWeo0ATQBMl/UetZ9odkM8vA2ZGPRuaJndDvna3mklOIlCqo8Ioq3Fxskvm2gVc6/nd0Pqsw0SwD/thQVNiPFwXPH/kNgBSPGaE+W5dXjmx2hzFcjOfZT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876025; c=relaxed/simple;
	bh=waIpQmoq5R6jA5xLKOAzBdBp8AVQJeDaJnKQNm8YfmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8cCv4E917kLvM1T+Nqys1OeYdWg063Qv0iGH7d3Dp6LJvgPGe+OE4mKxL9YNjNHRTEuM3rRmH4FYHC8N1Y3RB8csrvrlysMI+zFFlKEYZ7455pjsX7xJWJWGFxoPFUQMl5c0UOpv+YaFsekWC4iU+vbzamoIuia9X/ijecSUSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsPZeIUa; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsPZeIUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB4HPNJeZCSZwCEi8rWaazcFCGc3JaLFRjmQV+AvquKIzpwjusTwkDW7Ulb5VfaQLnboP1AbWEZ6oAQ1ffJFFjvuvoqTjxHaRFkHG1MhOQZexPryTauc6FvbmpWUhsokkxjJNAuh3qxRJ4/72jQ3zKe0R//SrKNOcdZusPioSZh5YKrTmcICzOMS2ga+KHfbQk1iUiAj2s+zgpOZBP/lD0Q6ZKpN8riELYK/FJMiLK0Fw2y7MHlU4QYX1k1uQY9KPSUvaKHu+DO3cg8ZXiR63Z4u4r00hV0b9uZ4dl9V/XaIIDI444FMbgNWGptl/x2PBh+I8AkNmaHYHeN3RR/riw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+3mAT781mGIvB+1fiA3UdLXL7Miso7We4dTW9K3CEM=;
 b=ww10BkKjErsfHa1QBL6jwZpZSReDH/G4y+iSb9Boe5LPR0W+ypS2qOl/J79+0AKkCqMoH9MUoYcL+vd5G89zqlh7J2HJEE9jADdA4AGyXaEw9uaa3O8ehdRkgq/gJ5xKesyd7tzjl9Gd53p7DL822chS91yms6hxrWHORIUEVJ8CasgM0Qaw3fn0yqU3eO9C6oYXexaoxyet2xHy34du16oSW/RHng+WYCUGOpoeHtzkKntInIURbov+IRtMngJfBq43cYpampECTzGEuxoEKnc1uAJuEiY+RZmk9d7SMqkcTuEBvvHQVw7JdeYRFf7n81yhDo0eBN85ipcdJBz1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+3mAT781mGIvB+1fiA3UdLXL7Miso7We4dTW9K3CEM=;
 b=LsPZeIUaA8svkhaZw+S8E2Uv4BArWhwqSpEJM19RYiaRyWGf5J4WWOQV0vbdUiMHlHFkN5OlDyn4W1/NXHxUcPzfdPSNdw2P29olU5h/6g5gVJUlLX54NCKnEMBm67o/aSXOFZweZJFIzKjnRdX8OYFT26Np1wURn3febAVwVlKGVrnKNkB1FhVi6XkAbdN50pMPevsNz1k7dmzGhBYJcPuWy+gEs6Fv8qhtT3iruVaM9FTptHIICWX0yD35QgruvQnom/LALWoaYlzPqC9PKdaFXg01tjWwcjNaIEm4RYyE8RwwXAJ6o6wDo4tZFC8V70UZTMNMYndRs6q2pYMxXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by GV2PR04MB11959.eurprd04.prod.outlook.com
 (2603:10a6:150:2f1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 14:00:08 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 14:00:08 +0000
Date: Tue, 8 Sep 2026 17:00:05 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v3] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Message-ID: <advmj7drj6kfokjqoy47p4rrcq2c6ungrt422vyi7aqxubtsel@os3ba72l6pqk>
References: <20260903092912.444-1-suruurism@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903092912.444-1-suruurism@gmail.com>
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|GV2PR04MB11959:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b0e023-f2ac-4f6d-d587-08df0db17e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tH95O3YnQc2cZYIkDv1OV3ByZK7gFkAnG+/5IT0yAhWLpUPSgQPfcPbaUtB7zmgdvXKJrtubN8ERGpF0w9IGFh6dbmaKxQWIx+MxV+2H/dh0g/DMqJsLHIXGKMgYJd2+dA51voQui6COYUitKZYQkSuYMwR5ei8G4q4p/Vq/3UUunakehW9wnd+R1vNHa3OhlSiYrv12WpOvRMxpkBQvkbtfk87yjxYSspyjlAb7QGmaNYUViuk8Zx1Grx6bJluTT2inHnXi/7KDYNCuMtiNJie/RyZ2FHRIYTh+W0ZqxPKBPTGC54/huammHqu1cR1Aly4T242mKuUEv+bhbw79iPDFeJJcZsVDMYhXmaZc2pnNigFX5C1YvCbcpgbc8wMwV1CSgUmhnc9AVSs0pTeYjb5tCi/a7QfVbvvkygNpbvbProR4jh3jhJhfbodpapHPpUWbuyCAB1L2/eukt1HmMCL3oH1DVwt2yW6dDvUMdjMiRGJOwGbaFNPdDvuOZ67QFY9Jtth/ja2/4shi5XbWCqmpqcWl+1DFJPN0lUP28zMuhGleYWEucgl9xaIQyN+2Vc4tJXv1mLo++K2wU4H/3pBv3CM/1Nry7v+K2kH24I6XwEy0gspzBH7VWqjLNQlZV4W7cBpt9zFl79DhwECuZo0jWeesh5lkCGfhys51EAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdv+Sa9NsWuMabOEsAXyNz1Vs6i9wCvtXc9ZipYAixllXEZNfWKIymk9+qAl?=
 =?us-ascii?Q?RNEAO7vaIaXpydLQolc1VE6yAb+mAjZZ+W8rddxtKuljrE66WnV0byfDGuFX?=
 =?us-ascii?Q?IbDNNkaTrnekYerMROE4C+Rq/xzuQcoUNu/lCU5X3i1vC0Zyr2dIwaKjMlRU?=
 =?us-ascii?Q?gTjsrZQ7quMvgA3NJqRXVkisdig9oElptgyIQa7RIVsikx6eFjul+xAYhk7e?=
 =?us-ascii?Q?XkgyL1Z9dr7IBubdtcz85R1jZTOgyQjh0C6jNxmcDQhQ3yhI0nuWu/N3Nq8X?=
 =?us-ascii?Q?DdE06pzfcriRb5J0cfexHCbLXRTEJTL+D1K+zf1jomI8Fwt3+lV5lhGfzM6D?=
 =?us-ascii?Q?gtc8a+Y5u0af1yHHYa3P4u1r+cjeOQ54Xb6P1aEn9MKM2DE5O2tfhRVU9PFW?=
 =?us-ascii?Q?tom2gqFnvmakfZG24rgpNizn0f6iLZQH8LkUbNgShZLDHVLq7A9vJXsCPUDi?=
 =?us-ascii?Q?C7Qr7jxyPLbPIPQX8niMS0h+tZ2eWijqMhlLomXjcAyod79pnHsMpoUe0pa9?=
 =?us-ascii?Q?Z1bp3QABND2ULUQ+tqdAPT84g9okfVvkOqi/c2KCr86dEl1HpI5bMBsdGarE?=
 =?us-ascii?Q?Ld1C/PZMb4011xP6oj4d7BfDqdt6U1DB+lPLg1gg71YpnCLW5baRB5yOJsck?=
 =?us-ascii?Q?b6ja/2+OGxWKOHSlkiE6ynJlGNRkJeUzvZIQjzZcm+OT+b7kLH5jjMLETgJz?=
 =?us-ascii?Q?kqesvIa8hAGxSWd9LEWX311rTyzwjS5H0gewiwg5jb+q2ggHM0GOdNH24ebU?=
 =?us-ascii?Q?aZ4cgIDstx63HO6FZMQ7wF/TomhSTzjrq0SPbxn1BrNWHpxsAT97gJJOuMvO?=
 =?us-ascii?Q?RDDQoMzFpy6r4nXD17aQtXS3TNIdw8qO26qYhClXNIDIsUA5SnnWDXm+Z+TF?=
 =?us-ascii?Q?2o7LyANEfXzHiPnfAH52S2RnbGb6l6dB0+PApNLyzoXJ/UHh9/sShiJ5gYNE?=
 =?us-ascii?Q?wNbwzweENt0t82yueBXinG4YAmqppQammJrG44dnwEJULkB3+ol7QukwRcWL?=
 =?us-ascii?Q?iKu0o8lD2vAVVFcC4FWVFRxYXWrES5BYqgf0LfFeikgWVvqPHSEppN2pPoiy?=
 =?us-ascii?Q?dBT+U5FAUCgeO/mpxX5UABIqPUh5/90KDKz7lAfo6fsH75YvKLpHFrg4FB9r?=
 =?us-ascii?Q?tdZuWoIGrtLDfhAXZ4fWqtYPqS1TL49aS+dJgm7Lb2N/zmtFuzE1IeZRt0Do?=
 =?us-ascii?Q?byRw12liz0EaAbPmywG0EBndNIJt/jOKU5uQLduU7pGN+j69Bs1xRDZ3x/ho?=
 =?us-ascii?Q?XtTcWBK3XNUzFVZcCaBt7pXyVgYbQUirxq1nWd1oU4u4bvEXD7iAVypK8L0Y?=
 =?us-ascii?Q?hAYZcH/U0dT4FXDVMKCA8qhGOzqchuwagbI2PSJys72yX/LOIXUNnzmn8BdW?=
 =?us-ascii?Q?a6FtNSInlrDSlyDi70dJ4tAajtOd+3Kb9xM5FJbHYh0SlpOuMrAzBi9p3JPD?=
 =?us-ascii?Q?/1HuUDHrBnALISssekeB+pOXT5V7HQYi1D/ybex3qTlZfWH5715eL4mF9UPj?=
 =?us-ascii?Q?Z13Vn6LGmR8GcZkDITc4EAxicVLLepDCZHRUFgeF8HQu6WMo9kNYZlYZTjbH?=
 =?us-ascii?Q?bMbzPyCygUcLHPVdbFiZOaHVuPzO4OOIn9xUPfvJCsKwraBk7U9kACbOpCaT?=
 =?us-ascii?Q?fWO/ZpEyM1CiflQJd6zWiThoSAQY6e4Itw0IpFsH9dligmX3nRqZ/wM0oc+4?=
 =?us-ascii?Q?PSblN04Kf46HDOfINoUVn2nXCncYWiSmY+sD4p507sFgs7z/dTbZeN3CAdAh?=
 =?us-ascii?Q?ptDCIelRhw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b0e023-f2ac-4f6d-d587-08df0db17e2d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:00:08.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uQlPPvHM2NIiiyOTr16MaS22QqMjbG09jqXUbpqhxZsBpvJUvW9QHGgCXpDv5MEFBm14sWnTIu4vtLHj3BCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11959

On Thu, Sep 03, 2026 at 12:29:12PM +0300, Abdifatah Suruur wrote:
> vfio_fsl_mc_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect().
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
> drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
> prevent read-only mappings from becoming writable").
> 
> Note this is defensive hardening: the fsl-mc bus publishes all device
> regions with the WRITE flag set, so no device can currently reach the
> read-only path.  The guard costs nothing and keeps the mmap() interface
> honest if a read-only region ever appears.
> 
> Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!


