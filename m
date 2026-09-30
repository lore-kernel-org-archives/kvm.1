Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A548CD7F;
	Wed, 30 Sep 2026 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764702; cv=fail; b=pEGcXczzhf6LTsSitDsYM1g1nN9v8UKnTe2TCcSkTPrGQxebylfiTVP83RwD/YR/TqaIr9CD/yqgRbOC03OcY0lkJ7BYYnfwzx8VJ48i51TWols7Spas88nr9lTj/9H/VhWgk1NyfdxWUDL5NGsV7MEM0DCH+4ZN16OCpGPmdGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764702; c=relaxed/simple;
	bh=ezs0wHRmGCTWKTIOlIQKqm7fFtLS5UGn7c+MgKFaSX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Au3g36o8aZ4kxL4LOikBV+lk9HGu4LfOUqfe8FqHP6Vo5Pk/EGHYa+gfFafeD8cSm6cwdYA9FWzj1LkawD8twLRSikDdaUcnRVU/JoPSM7UFjH10iJOolRAD9K3RTq2crt7cJ+EmcJ0v2ErCeBK46jnnsl7HwPcfm90tdou/F4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHsch3Eq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHsch3Eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764699; x=1822300699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ezs0wHRmGCTWKTIOlIQKqm7fFtLS5UGn7c+MgKFaSX4=;
  b=BHsch3Eq28SAtVt8jLqeYhn8GLkjyxQG0HbLeymWtZLrz3J1v84ZZWBM
   kNWgKInFd45ncqPPNI9tUO2jaXnf/skSkiCLyPgKJMy7fbgowXaKa0dvT
   tn6cMP9t9NLIsMakVDvVOm74X3wOdapUqM7Lt+GTogKTdGWB/qWRYZhI1
   lYhFpJkJx2h5NWuKq6z3fhz44v1/fxCuScYHSU6lnZzm+Rki1qtWy3Svi
   eVCIW9UVsIkJsMN5j74aCDwODqZJNn74HIaQdK3NRV3CwitVknKh7cuvx
   syGDwGqKQtaTjw3ZNuthV45Cg1ZJWQaa/T9GsODLsas7PlfDCPG8+jDaU
   g==;
X-CSE-ConnectionGUID: /7Lxl7B+STaKlmVi6VC87w==
X-CSE-MsgGUID: jG/qwBzgQCWgEHNM7WUJcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107884844"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="107884844"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:15 -0700
X-CSE-ConnectionGUID: YkDoJGxuTHGdfByRBXdF9Q==
X-CSE-MsgGUID: 2TgSwZS2Rt+XiZYgE5Iptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="273445839"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:14 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd78W8PDnoGPleBqpLTb8Ad0oP/wC+ytTDK+uc1mdutYRfi3D46qRhH5cEEgQTmEKPdAXLsnHdhqVB0KVGCmWWVQdv+xhC7mU1CCJ+NTgX/HDkD9l+qG0IP6br45TXHTmpxx4oW/18vYoZqubgQJ6E0l5ukkozUwmfolhrUB7UbsUhkquAfIosLR7QnF9TeiQJN2kQmssfpvPYyJvRiBs2Ow0c10i5+KO3JuvC2koDyR1tv0ksC1BTx2/Ba0v2PQAJ16zDrkxD0oBBc0IPR0GJBXIDOuyprY0zg8YlMmXhkXoK13yGDARWxdhSnN4hANltcC9G200Tp7CEMdaoOFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlQEQKGniUp4MNgxW0ASiTqYcgqmtyWgAO0UInfmADA=;
 b=Xj5XxmEZeL3NKlneCZGXbz15O94TpJD6wc9iHXCKLL4Z+07ydV+x9oqxvrlf9MWDR5k8eCB2T7Ce2mN8jjncwOWHvy9KFYWHbH9fLgq8B/ODtXMyGDNcIDnlnsehv1IRf6/MACC4opUsg3+LwXptaDkcghNd8Imlb5iJzJ89YaWY+GZNGZjx6SxSmffGgK3CVlUYdGnXRb31bzsXcM2lkAkCk0unxRP08nFTvDvSiVDl2IZBs1R+jv2v2jzevs4yY5WoykqcX3dxcy0Dravx4mXTjusA0JW/k5qQVY5rq/M2Z3lUWrSee0Ksm57g+Rra2aoeWdRRYm1R5WqsQD32Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:12 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:12 +0000
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
Subject: [PATCH v6 3/6] virt: tdx-guest: Calculate the Quote buffer size safely
Date: Wed, 30 Sep 2026 03:30:52 -0700
Message-ID: <20260930103739.2851980-4-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930103739.2851980-1-peter.fang@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 319241f1-659a-40fd-ef41-08df1edeed5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3ajPWkp16B45c3aak7gzNqpDzJbeOxCPJn5PntA1DoDIBDnGbXRGy9xhcNdDGNMqhvYCjspNG4R/QaJFV+JCRQclCEBit03pqsBO8hOyRWHv8OgroZELjsYzlz8Cc6SCTcltmNrkvr/Z01m496DyYTfvhLaMiTFkvBTsWkBelFSSJwoJb1vMeLizb6EIaeGOgmv8/uR38FwTr1KlqpmQ4c90wFfeNn+J5Oq5yKLu/XMU0C9zxQ8OIKLvenrIIatHRcnBPaHuArfZJ5AnbTkhuwesqn1k2R5XFEk14/rB23FhZnuRpGQVk/gzI/LFOGTfddzx4M9OW48dmY1TfqVWs0KyP7kZcIorFUXvc8bIQhGbcu//Q7p8pEYvZuS0DYU/q4tA0/myO0YIZNrE3NkImR5P90w14dOMNPyJiJr1B9vH3DV694Mpx25Aal9Pv0W4KYlOxxfdQE9e7ntxEVycU1EDvXszfvoe9F77b1VnxKd3o1pdhVySuxERx95U7GZhcxtS0lKB7LYjk2B1yQVX0Y6H7v/CzZpbf4/Yzqk8iklQg2qk1QqdjBgeLeSTTx7oowBIOtTC+OuA9xoSMdqjWCgKkLe+I4xditzKhnLl9c0aHZ19/Fqj7SNctECHez9r3Pweeb2OEg0imy85t7B7CRIIH8vAW6l1jEUTnKSfqVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eH3wVlnzwUjYtnnQeZIc4wzr4LgnK/bTvC6v83UvmYWjpf4asI5iqgwc9pEU?=
 =?us-ascii?Q?TyeG3oRgBob9EnflbJopmXsCTAwkOUorfZzPjJHWP4eZ1SAaYkmZ4AIM3C94?=
 =?us-ascii?Q?uXV7Ugk0s6I6W/TJWk+SanrD+IWmVdNFwyp3sBacC7BpUl+9nVPnzNxsO6A2?=
 =?us-ascii?Q?ZBktFxg4g+u8bNMZbymV1ad8ARc4c+qhYS6LLSlH+dpeZTq8TwXzViwrO1zP?=
 =?us-ascii?Q?LxBhWC79Fjo1Yd0FPbs3F8FpPwR6GBovM5fa3y4ghpKp9y9auHAr0R91NuUq?=
 =?us-ascii?Q?kjSW8uTtLQAoKYnVehRAa7M7I0A5J2K/OiiARTalIPBxTHzDVSn0jy+N15j5?=
 =?us-ascii?Q?g0V5J184lAmy6evXvk+7yFqpGzv21IBceLDJ1r0WJjuElEux4fIKp/Qmq3Cy?=
 =?us-ascii?Q?ClmXatzlieor6e7IYV9RkXipnkzLWauDhX7ZCd86/95jsfnCBe0gJBz3/NhZ?=
 =?us-ascii?Q?vwiM/E4/dUB1Y4kNyoHWlmMsfcb30ECT3pUXJ5SBBtCJ2c1JxfjLUI3h0RHi?=
 =?us-ascii?Q?FKvkrCWfyqNI8xe4h8t1f0yUq2zipwXjmmW8sfB106QpYUFVX0TdWbuUq2SY?=
 =?us-ascii?Q?Xh8XgfEYglN7Jhl5rcOu7JqUFE/Buu1jD/iQG4zybTanVq8Sx+VXV2HqfI/w?=
 =?us-ascii?Q?moLw3XL+Cyc4357HQ846LKKszEjujNSgQZ51iGu+X0FgGGgptJkHqch1ouMO?=
 =?us-ascii?Q?rVCdPEe+fTQ96+ENeIY/GezMjPK+TgwdIfbIq6/6eR0SmN52WePHmoJuMTtO?=
 =?us-ascii?Q?Qm3z6CEcNKyQm8FoMgKafYxgJY8ayiM6I72zmJUmL/TH4tcCxV5glG7rem9u?=
 =?us-ascii?Q?FitzZgVrki2JHJa8tdSB0zC9lYBzr/nCTgHkEKaEkKqw2tvnrzbXJjAsODmf?=
 =?us-ascii?Q?Qy6I6UKVTUVtTAuosZJ1Esq90Gl0uzMACYd+c5TYT+z6BO5OL0jEICPtriMm?=
 =?us-ascii?Q?SYfRhJnhWMkxrXIrBitXMr76jzSFLd86r73iy2n3QfJCUK6YIl/74PnkUbDk?=
 =?us-ascii?Q?KR0Ml4ywfn5OE2h+pSHK0nuzFjtBtMLfRAzwNV43ZzYt8fE0m+Sd1hCVyXbK?=
 =?us-ascii?Q?E5f427OQRnrS8eMdCPqnAvgYeiTIz6GqEc51kztzw0RubpGgUIbMJihR/g0X?=
 =?us-ascii?Q?cwWB61whExyceJWNtJk+YWY0lavdpvfqWMWQD/5qMExYbvYpMpQ+1DjLMjMw?=
 =?us-ascii?Q?afm1NG0ki52YEv63emgMN3OhWGfEICrREYGKix7uKCmYR9Va2qY/H3PzYZrU?=
 =?us-ascii?Q?Za1ePBKiZTLaH6YsFDRhtCsCMDHae3WF9V4dGiOeMhwwXg2FRx/CwveSzAs/?=
 =?us-ascii?Q?jbWZPqw5/KcLf/AlMtB/fgUvkadlmXLKLzTalADNnQuWe7UkOadyKXAt5OR2?=
 =?us-ascii?Q?CII2I1t2dCy7SQPk7eAJiz3DKLnSgjpQ8hWvzMPkV10Uhj/wEua4HD3S8xCc?=
 =?us-ascii?Q?0LcGPaoag3WwqjGNvlQvAogbuNLzirvSrLOi2arzB1JQAKFTNqHmM6a7EILx?=
 =?us-ascii?Q?8amu6vFXGupPCrxSZcXTJ1RVKTab/fi687bU/AhBXnBj2f11L1aE+mHvL9Bt?=
 =?us-ascii?Q?z/5Bo7vjMbDF/WmOPyImi0TRhIi/k2FKvRzjaEVtvhty5DCAs4SmENreFbrs?=
 =?us-ascii?Q?SOZOv0pIwVZcj7xNyoGAVSHAYawZnL/jMixqxcq9nYktcucW2DNt4oeOyZTJ?=
 =?us-ascii?Q?t91jh+Jd6Ay9yr7xnjRZAy9JLr0MMbGURzz9OOsXdzHvyi32qchFIWh3vY5S?=
 =?us-ascii?Q?jpxASFfQ7g=3D=3D?=
X-Exchange-RoutingPolicyChecked: QhwWSq0CBeGe5vcS1Ake0Iz5yEiZnPfTyHnvMhzUp1JFrk/kh1YhSWhp181jzPCjfN7Jt+ZLxLGXpgPU6iLTtJNsCKwHYnlEPDCYDQTHa++5qa7i6mtniLFVXHqPRtTbiYP77X6vK+ZKClSR2Ux2gayT6VRMhvZFXch0aV6OeVYfvZsKUHmsjLtlR5Oz2YBQiUu1NeRs1bK11odSw2lNeBfHwi8jd7ZNZB6zDL875ixKCMkq+wF+uvtalz5+ArEw+9K9z+5fvc0AVvurE7r6II44L/Tg8C2UxuBJEVs3n4HhLx2EvpcnxwW7ZCUA9HbfDKqd03liHaDp9P4KSyArWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 319241f1-659a-40fd-ef41-08df1edeed5e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:12.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXQy4s8Qtslr2n7txTpyCPVpu1w3uAzKeqcPIm/Q3Q43XCcyjhienKOi6JkjXIv+rpetoCkubSvcBVUeBKXocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

struct tdx_quote_buf has a trailing flexible array member.
struct_size() calculates the size of this kind of struct safely. It
handles overflow, which helps since the Quote size comes from the host.

Use it to rewrite the bounds check logic, since

  "header_size + data_size > buf_size"

... is more readable than "data_size > buf_size - header_size".

This also prepares for a later change that needs the same
"header_size + data_size" calculation for the Quote buffer size.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v6:
 - Use struct_size() directly, without the macro. [Dave]
v5:
 - Pick "size" over "len" in the macro name. [Dave]
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
 drivers/virt/coco/tdx-guest/tdx-guest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 83322cd7673a..77c63c3f820f 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -170,8 +170,6 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
-
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
  * @status: Status code of Quote request, filled by VMM.
@@ -313,7 +311,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (out_len > TDX_QUOTE_MAX_LEN)
+	if (struct_size(quote_buf, data, out_len) > GET_QUOTE_BUF_SIZE)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-- 
2.53.0

