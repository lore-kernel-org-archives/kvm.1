Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1349739E;
	Mon, 28 Sep 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590267; cv=fail; b=bkLzUhOtzZA/LnuDJXcAo9M9QgxYWwJHK5I7N9cSQCzl4UrEcd8x3S5zHLpPKbZAEkxie/03MTA8cjyulpzKewoeR2IHpQuTj9OKmQxY/J8R/4i1j224cNcTN/jVHzkiDFQRgnAONUvZsPjJdLNhWxYxkGAaZr0FsuBrCiEFe64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590267; c=relaxed/simple;
	bh=/oeYUcuriQ0FG/ogE84IzZwaFI7IMQwSxJlZ6k2aeig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=menH6WxKJKGivu+wucTPSvowd8dIoCAOykH/Ym9TEXP1rRFR6NldIEMNJV6OXbScZN5Ic+MbMxDp6Mf0pD7Jqt5cSPgyYnqdemNXwEEVqcNg8ZCJnGgzXOYmm5yrQYBmpygVPTYOp9p57ArkEULqvVFLWS5qcEytRDy0JXffpj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc8K9Qzy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc8K9Qzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590264; x=1822126264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/oeYUcuriQ0FG/ogE84IzZwaFI7IMQwSxJlZ6k2aeig=;
  b=Kc8K9Qzyc5KNKmRBGnGdnMOj4gnuaFubUxq2h1Okth1ss12LqQgT88Uc
   nRm3VSkzFXX1KN1XbZsd0J3hFTVafIwM78w3cEgw7NeSHbnErZDs6FYUv
   nNjqgCt7kg/tpJSMRrhW7mxobN1z3GKuqPDmnmaNu596AVcjetcPWAWg7
   1HoaTsCO5ibtYXdvEQllkIfQdydllCq9uSd3oHpDEKY53M9ctEd1BC+i5
   7oOV+xkEyAtqOuzyw1ZhAcRh3/TQFRmvurfv+WzWql5enA92G20cE8PIP
   5D2EYLg4H+NZjDZPQwbyuFUba0VgnXjTkcyQa1uLLpOdfAbMgk0QELstM
   w==;
X-CSE-ConnectionGUID: kzYGFeggTvu4CrlVseB3zw==
X-CSE-MsgGUID: FtHYU2U6Qp+QU7hoHshVQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101944050"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101944050"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:03 -0700
X-CSE-ConnectionGUID: 43gyFm7YTlqSW9GF6JvVIQ==
X-CSE-MsgGUID: NW6QS/6XTAGzxf+fO0TAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274524268"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:11:03 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdZGx36GDos6WHa9EgbDBt5FuL+Q7/ZclZYpmbAzWx5ZZFKIi5UrY9psJH3psKsQSllWKXrWHcAnpskIY4IprLHKMXZbNhdBBuM7SuG9nzcuLkXXx8lQ36YZJNTl7DbYwEK5e45lnuRf5N4frtZUgiHkZd7zY0THwlXJCViBC53U9xxH2c6138yMn1ByjXluUQZ9fkJmOndB7WoHmlE+ogjUuO2ttp9qnehhO61Sex3DaZrAKflsIyda+3boyPD2s0tSPHFzkXBh48v1d+dMzTK0vzJONGTo80YiFx5B4mRtRMFGdCOjOIM6yH8dvloMi452naaH6G+gmKWbqVQFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE84EfFf/iPTTrguuFqektvdfKERGTzOdKuP8Nd4quo=;
 b=AH+IWE0OpzA8X2+WcsPpygyM7oqpIx8Y1G632kWBpckpQk+d00A54kx8FcWqjK7tfkwMGt7awJHVhazoQH/7uf+uRPh/nSYQve7eNCBeUHLvfzgGPgggzdrIYmd+JwiEhdBo0DoxfxlYFY/rHa5SpdvO+y+6QKnrxZWXQaiLDVYZggsmeSUp47CN9zXX9gBHP2HVS9eqXFKkvg5ejzdYR2VBhDE3oxu27li2H6uPn4mllaA1lJB/EusFZmWdB9CClsJmHvZwK3QR39Q8RwZq4xVelvumea0hY9nzShw/uX24o4Du1V1Up2DwGepJnzMfcEOyBFIhj7am7uDn40k5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:11:01 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:11:01 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH v5 3/6] virt: tdx-guest: Calculate the Quote buffer size safely
Date: Mon, 28 Sep 2026 03:08:14 -0700
Message-ID: <20260928100913.2265687-4-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928100913.2265687-1-peter.fang@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS6PR11MB896703:EE_
X-MS-Office365-Filtering-Correlation-Id: 420b74cf-9c55-40a4-650a-08df1d48cc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z+yyUUDBE4FeD6EE3LJnBz7VKnxH/QHNaPAcuhA4mbqObEyL0o7x/219YexxSbCxiRkZAejDU6g9le/bnKONnyvy7Q8gddFmSt9C8Rag7b55uPUF1lefXnmPWosd9GdNfqr0SGUqpSf4Gylo8MK5ftqAVDPeA6DkMhtnsIkumG61DsD8AcAbGYqPZqihQ7aT8rtuZep6Z3OVa9TiIhST+ApxlkYYPrdzmTLKWCXEZ8GkOYlpXDxOtAW9Ww1VUD4ejJt4wJHp1QhwQ5AyAbH7urC3Z/1x0fkQwrB7/ZEX1jOLU9U6nahUzcg/4HBMKzkyGF5PLBbO3bcEp+DTiJ8KihukCePkTqz1Djyr9JoKO/IIs6lDrg5s6VCt5nJznoO2oPGdekUFHt1o8reVgbfxezWTw/8nADozrEnfASq+qLmqijT9ptWvJ2vqcRq8zzERbDBusJgmojcnGsZnwu6uGdehau8XEwTym3LrL6CwQBxqPKT1rpFTMlJPXzlTS4fG63X0lzwaraNVm1E/x0jKrxNXooRCmLTuIhb4jpKOBwkqTca49V399JU6gP/WLMvYB00i6ReldGmxBkIXXZZYxQyGt/yXU+qS6zmoUZuYZiQ9JE+Pc+3P8D1Wr8uDmfHwhh1dUfK7gS9dSsy/G4ZqDktpM7KIEWwYx+JbXEE1wZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RIstjriHVyTtzaBp9dCjW3qBssauP94CaVRH2jXOltkyu9c7cWE1B9Xo+nJ?=
 =?us-ascii?Q?yRaEAu44bmnzKgVj95jOzYq7MrGCbrGP4euUrdlB16/CuveUS7ZvlhKTsjc7?=
 =?us-ascii?Q?SDUdeXLUk9kEdhLmJDplNjWAUqenIAViE40ky6Q0zELSc7GEZ0VMAJ78AmUv?=
 =?us-ascii?Q?fvaqvdTb8kwByuNVK+5W0SWVX9UQ3U4dYYiFHJEuTKwgsk7aJpqwZlQVS1Hl?=
 =?us-ascii?Q?mQzrDfQzWNL5vtbe5XeOAc/1PpLlnDcxTGieyY8/W4epcaxoo/TZPgMskxa4?=
 =?us-ascii?Q?wFs8QeXpS6SeebH9JoIXnSD54oBLW8txzSbDZElATX460s6hTJssKuyW/1RC?=
 =?us-ascii?Q?2ARSkHYwTKpvwOEAFS6ogc51wPGr1N29RtOPU5m3IzMCkNS+wRPwvXD6+/dL?=
 =?us-ascii?Q?g+pbgt7DQ4abAOaY/zqrR4lA9v0kemVUXNhw+ceHprcRt2QCPk4BW2pcCxuR?=
 =?us-ascii?Q?N2bFj6D8JA+B+b2d4156qx4VSAIvudRJmd8OCG7rtnpUjQ3QqxokJEuQ1KY4?=
 =?us-ascii?Q?gKeCtDwmP2R7PNFfw757iv7r2WeixQa4L2diwD5C1EFx7jrgwLgHlM5UWd3F?=
 =?us-ascii?Q?LmJlzNpzh+CR5nz1HRf0F9Jla9mGvQb8DnJ0SaGsRkbP7EUcC3DJ5HLi/gwF?=
 =?us-ascii?Q?UvHXaPuJomGbGl+dW2lh1pGSHXwWqVqHJq037fyZSykx0JQLeMCltPSC7+2Y?=
 =?us-ascii?Q?GEc5S1XmnrpweqsDdPeX+Y73v/4C26s276UVfuovvrHt0dHG/TH1aKwI2ctt?=
 =?us-ascii?Q?jRTKrIwwiCdbccGzfhlb3yq/q0d3vkWvCXNIwar60gEcY7S8CybLD+rtU8Kq?=
 =?us-ascii?Q?fKDj/WmxSVsERrssDRAe19FTcIP+5rI0+2FzBm8VX4cm3s+/z6FfrxyzNp8F?=
 =?us-ascii?Q?1I1jxmJ/fvnGtJUCYGJgajgxJYyR0voGESkfAxnm8D9wlUSdmn4CVGQnzHHq?=
 =?us-ascii?Q?lUhRii6dx4ozX+lPWouV98l6yOVheW7Rh0whOwy/MdH9+cAQ+X+Z49uiecCc?=
 =?us-ascii?Q?6rfwrU+ErvBHeJEHejaVBnh7hc50eCi3AcAdq0WSXjjuCVhTp/Plo3ZG8WM7?=
 =?us-ascii?Q?BjUtrRcazV8OfQD+r8RXEPz2OV9M9X7EMg4VW4cL2ZH9Mu7qPdR5Do6Qifh/?=
 =?us-ascii?Q?pvnkxvbsZ/R7yAYYZ3PG94LbanEVRjUw6bLagIyGZgM9uMX6UctT9R66G2kf?=
 =?us-ascii?Q?ydnsjaHc57hZqu1H/Tn9AN+XIfZFsMXnokJKq+BHwDptgClp9KaKO2ddKrb9?=
 =?us-ascii?Q?4S6zONYmcacLpSn8HSzvds9dM/RQE9l/ua72w3Wu5llW93fhsI8mtpX7g0OK?=
 =?us-ascii?Q?J2BYkcSy/3WqyctFdKoNkMHDFkkvJPksBcJaPgvSAXnW4nPWtubRuPjaZwr/?=
 =?us-ascii?Q?FBOnvj3IeRbuHXZeA7QUvsNJrHIXPVL903YVO/xgsAg/UjBdtN3aTu/b7xi3?=
 =?us-ascii?Q?sHj8rbgj/8YoPX/pkRU/vntI5eNo8QHFKZmw0XBm6V0FTWXW3IhyI6ygpE+V?=
 =?us-ascii?Q?kPtL+AZD5z3fvPcG2Y23wGcV+pfyi4rSJLef5hWNDlklIaF6cKWrpTxMpUW7?=
 =?us-ascii?Q?ngcJByXI4r+WC4GRjpSitqfFI8gryugmg2vLmGjYn9Jb1iNgN0aKDr6Y4Rsq?=
 =?us-ascii?Q?xhgvPHGo5JihzLx9duLMzgrjl9W5c3wYGyD7sWeB/FZ+ZaUVt5F3B/USiGj1?=
 =?us-ascii?Q?FPwPLeh73zaCEnPUTGiGZA1CjSxV4DHhp+iDEfHLj6gOkMNUFK2ndrg1XKqd?=
 =?us-ascii?Q?8oIxRZOlfg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4S6/4IhivzNKWolcErRbxVSCrP+racXB5r4nUvdTehqJTYuZzufbw4WzJr7RwTVJHVWSL7O57MQsBxHxyygCvGxQxzrmYfdflOXYQOXJDv0mD5LTNDwPjtCkKM9Exm0V1W+iGosck82lcs9TakosWNcquH5iPCnUsbqWY+qjJ1Ws3VbCyLx8fC5gZrfZyJUXriwFlPMc1IRNhhcZVQRwvVxlX54JS6OlelStkdXCS2Hzrm2JUJV5S49LohRG+xfoSSKoA1bP+pqbzoIX0Bj2//hw0TcUyLKUP/atsHNDRvCOLD2Ohya5t67/a24Gbh/RxmSK2GiOAnr2QeVh746P+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 420b74cf-9c55-40a4-650a-08df1d48cc43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:11:01.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec90VI7eRN8jQlneLgIAqe3t9jhIialy6EVmi/omYhStvRkN6wFxts0TdE0BxY5+9ltSgoA2rK4C/v3n0AHNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
X-OriginatorOrg: intel.com

struct tdx_quote_buf has a trailing flexible array member.
struct_size_t() calculates the size of this kind of struct safely. It
handles overflow, which helps since the Quote size comes from the host.

Use it to rewrite the bounds check logic, since

  "header_size + data_size > buf_size"

... is more readable than "data_size > buf_size - header_size".

This also prepares for a later change that needs the same
"header_size + data_size" calculation for the Quote buffer size.

AI was used to review code.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v5:
 - Rename TDX_QUOTE_BUF_LEN() to TDX_QUOTE_TOTAL_SIZE(). [Dave]
 - Add Kiryl's Reviewed-by.
v4:
 - No code changes.
 - Add Reviewed-by tags. [Sathya, Tony, Xiaoyao, Binbin]
v3:
 - Split out the use of struct_size_t() for buffer length from the v2
   "Allocate Quote buffer dynamically" patch to refactor first. [Dave]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 896eb0a09c4a..b30439584886 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -170,7 +170,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+#define TDX_QUOTE_TOTAL_SIZE(n)		struct_size_t(struct tdx_quote_buf, data, n)
 
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
@@ -314,7 +314,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (out_len > TDX_QUOTE_MAX_LEN)
+	if (TDX_QUOTE_TOTAL_SIZE(out_len) > GET_QUOTE_BUF_SIZE)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-- 
2.53.0

