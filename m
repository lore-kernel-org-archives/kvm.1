Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADC481FCE;
	Wed, 29 Jul 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328229; cv=fail; b=fRJLF/dnS0FWxnY2V/y2Agjg9RQs5Hqnqoeb2PSBU7LPDoAX+X74yV8G3UXXmUUS05avMq3x3UnI3DlJ2t5+RA7eZB8q2L54owmlT8zr6kBOwLRWTpbTKuUErDSCwNZ27RPuTVIsmLYaMnfFKlZ6oDQRmPYguEGW0csOGvgqW78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328229; c=relaxed/simple;
	bh=1kxB1a1phCuBoeSFd073Zm51c4X3VsG7T8xpCKZAwq0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UKCwG4c53vy3K/2uCW6h0I/j1Q60siR90H1QuNilS5VgOZch5hoMAKwU7CYyG8SBrAmL7hZmdhjc1vcKiI2Zt5Y3tKzSpUrLorExItBuh4/23uZV1O82TNVdidSclZ+DcNhih6BKGz1D0M5fMX9V5mHd0CNLQHvgVlfu7WppCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drcxyKw2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drcxyKw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785328224; x=1816864224;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1kxB1a1phCuBoeSFd073Zm51c4X3VsG7T8xpCKZAwq0=;
  b=drcxyKw2kgmb6hJM3OjwltIroCXar12V1vpymseUh8GgORYYDAUEG83j
   MGD7CEQeMVOhaqfymk5I4fLs5RUCeU6aXRKMig3HUf/0xLIbXBlIvx5QG
   gfrcE8GHfju+/1fos/yZfOQwj3Z+3Lci63rZFp55xRWROV/GVfouI7VA9
   LWqiGA3EoKUfE93UQc6/pu+eXkqJzYmq8NKNgeKG6Ydq4K78KChJ3HT5+
   QZAW6EJeubD4JSkYd+ar4/vz5BvvY1j6Y6PxDzGSVlo0Ta6RjyCYmGdHN
   u3pVQgaqk/IEpo9OtMT+SAoXHvN9KlWa0OZayfyOJDrPA9klW005jT/Ny
   w==;
X-CSE-ConnectionGUID: aF63NNjNTGWZWlmoWuK5zw==
X-CSE-MsgGUID: BNCt7oVtRZC3AZG7gew13A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88471297"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="88471297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:22 -0700
X-CSE-ConnectionGUID: ujHQsninR++fUPkds01AGw==
X-CSE-MsgGUID: oacUwibcTLC6ufJk7oUfOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256668819"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:30:21 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t23krOttvd4ub581KECob50t6XKJGVdZ1APd9S+0M2NvkOwjeBQcNtjqlCmL9RCM2Qht6IHIdHG8yetu/66SZonBZKrgJH8LM+TfvRJb0/5/vVJUKNgvyjaNr1xEXLjQpCvDbQvM/SjToNr82oqA3smsadxosTGSkFkmFK+WWIxx7E3paclEWKDetkaDSnposZCR7rnxOQUy/CR7u5aAEsVnPMMu+Mzu8uy9ozO8ZlCKzqOmkvPW99i4iCJ/HqTh4eSnsUROXb7GcjSm0XQZhkBUkt+WPTS2JJXSnfnPTMo8KWwh9asQUV8Ow8zPfYOrjzGZJbg5lO0ZIYhGrP0t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V6nItg0umny6ItLo52sKL39Y1fUAn1txqfCv437QQk=;
 b=nOmxHlNakcStawMtZ2mCQLlq7SjJag8agpMWoWO7H0E63L9TFq1QctlPA3XcymiewP3OvImCy09ocNKuUttS6Y/yX/WK9IjExAlDDxbXJhqMtVxKjcrYHs3dZBdvwUvJ3MNtoHxiXGW33Z+DrXvhZI4tI9MbHHuHiQmxRspfM4NQFLFg6dFGT8Sivq8SRVgRDLMvGIKTbs7xt9eHU/LBudxP1Ff6VKIgN4wXinIMKw02GbRK/s+1fB2HFjsY06CmWGphwC3ZP91nC2DSs2hBGTcUkKLl3cPPMeiPIuzFNVuMyN14+q0+1IlE2Ut4xyiNaof3juyV/1DzulxRV9Ewdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:30:09 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:30:09 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Date: Wed, 29 Jul 2026 05:29:30 -0700
Message-ID: <20260729122939.1340412-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 640059f7-3873-45f3-3241-08deed6d20bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VGgLd/XJISefAry3oXeAtxtSmakjSWINmv537ye7JQWYJCkU+PIhW9stoT/xt3C45nGmosbvAUOouux2G4GS18AEeNH4qh06AR+UwmSVyuSl1N7otCi1iDU67Shd47gTQuwiLfJ0dn/HEBQ+QxZPNoaT7Y2ScwK4MDPv2tLW80/apOF6Xsox84l9QR9hCwAXgL0RgNMupZ5cInSKnE1kFLlif6kF/rCzRMlF7CdVE9WBoLB7gYIvbuWeGAnSfy2CNoxSPxNoUudDDr6XU770fQvED1C7BIwMDFTg2TYz33K4I0Wk9WvwYlWCxCJ1ZA01j/86+86LBRPmKMYjuX5kOxiHhEYbY9Um331cz7WRtPCeocBWN5v8aVQB884MSg//bhfBuu/Q0VF811GyY6nvf9OzolrF39+b033iT6+IE50hp2fsmYdUZy+FtdnnX1Dj6JWpKZHtogcMUZVZsJeM8ZlIqFNoLo7PabwH9l14fw3ZEKWyFVH5606MPsqF9wVai47Df0BZ/anAF+7AhNKIVyHZ10nVC59WMwY30AK6jTldxwFHG660FBaPMzo9aGYb7am/z6GQ8g7czHtdhASfPrLMZtUYyxMJZ0/YpMwbzg8pvYVGEnUqA+Crdi774QNX5vlJNoJCu84MJd9QIA2JY6Vuxv5q2pBRrWHOq5cjI/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmzGe8TNZt7TAOgOFWmZrt2fUWI0xAWlOL4G3CXZbeGun9CV9aKeAIUlgGd3?=
 =?us-ascii?Q?YKDwsPhcXGO+oNYPAGwDXPVUxYQuhBT5GjCbnH/QFCTz2JdPWrsh7+ayJ3p6?=
 =?us-ascii?Q?YChWWDDlV+LFneKqM06QfyrZ2rl+Ktj6G60F0K4gko9MGDiiw4MrjdHfwHBt?=
 =?us-ascii?Q?/K1eDGAkolUCsaEKy4MhDndBdc1M5RdeIy0BnL+do2G/zYRz8e3kQaedUGKp?=
 =?us-ascii?Q?LXPNDezOnwgsAZacoxWa5SymK6zUHeOzproumwAJ0JaSwtq6r+hiEODNM2SS?=
 =?us-ascii?Q?s2mPWjW2WFE7STNFt5Sa2nlkBYYw89e7bLT1IWjgcJaATog85KwH5TOdT2g5?=
 =?us-ascii?Q?xwXHC8xcxdMKUt9nWrcvATmgl4gTSUF696vO9WwyOgUxxhJmS+8DqBt2ru5Y?=
 =?us-ascii?Q?Lhdqwr9he7ladFdxC7kr5vXRa8PjYsLgplK2O8K/eG/PMVyl8L+sTy/cvyiu?=
 =?us-ascii?Q?A0mqy5knOfhKVHLn8zXunk55ItbcLCSpylJaPOZwGLUaCPP3vGX17xip3x3l?=
 =?us-ascii?Q?4/flu7X9paMVCkhTgJOE71ADVoNzBqQcR2yKgAyAA8lq4sidyE32LY6mCGLX?=
 =?us-ascii?Q?Rj0lsg1krtyi3HwJuDPWP2f+0raZFqvKSWj/OJQmH0DMLkHL9/6Cug1WvuSH?=
 =?us-ascii?Q?VPk/p2oW11/o4x2myKRiG+qDSx78waAN+qln1HyeQiMG3W9HiKIN0RmUhdgE?=
 =?us-ascii?Q?ZPwkT9qQ3JGjkmbiE/Vif2VrUINuk5AFXezwyWVjcpvzQ6+jLAooqxZPW6E5?=
 =?us-ascii?Q?saZQxdEydZ46GzwK23+Dgo8wR0+v9cyxIk3PbEZFztWgu5qJleEY7gKTVp37?=
 =?us-ascii?Q?hTCMYUzT0d3mtIPZbmuPsJnI2v+HnmMouawWzQaasLprN8Q/xAaq04z/oMab?=
 =?us-ascii?Q?C93l+cMjLTjeTlqxrSs9fVx+X8JYbcgIUAYpd7XjfMxrTA7NyikUsUGNv3N1?=
 =?us-ascii?Q?BpwOBcyoPD7RHPJsLLEzUvG+SkjlJ6VcFK04IonnfN5BUkEYYoe7th1vZll6?=
 =?us-ascii?Q?1IRqY6OkXqairdVZqLH1I7zBYH85pRtvDVbA2ZIIHn2zQ2o64vQJ2Fq4ugML?=
 =?us-ascii?Q?XZZmldloh7R0sMgJbmkOR2uZa85YJjDazZgu3FxsZfc9VIw7c86OutEk02OK?=
 =?us-ascii?Q?zvdf92YPoNz7mjstcX7xyvfmKk+AsCzrOMXqZVyATAEZX3CwFMwR3k2GqOEq?=
 =?us-ascii?Q?hwozPAJHlO+2CRpi+3ngsIUxnqw9kjPg1NLW5ovOwWHtwHQkTtxi5PC0GiMo?=
 =?us-ascii?Q?VCpAKxmcXFeszB3qmEwOtg8i5jIgRJRMRDuiMn3oaEHoiuIo9wRIdZQ77xd3?=
 =?us-ascii?Q?UA/A3SiDScFFm2+UDQtV6yWPPv+dgx1JY50aOYTSBc+H9ozPtX1LgJ5GvEJw?=
 =?us-ascii?Q?/O+Rq95l8e+0GxlEuHLgy5fyi7fVxmyfF4VZteK/8hDjkr34zqLyrOi0UKwl?=
 =?us-ascii?Q?XW8Y9kLuxVOZ1Rbqk8ChyScMLshJ4HE2J46iA0g/EYiL9JS8PB/cG3HAhCo7?=
 =?us-ascii?Q?Gg6kaWQc7RGXED/vRDAaUsmxI2Q+Z0+be1s8qZsUMgjhrOveMSqCRFYm9dLW?=
 =?us-ascii?Q?MH5nXe79iXZAiD1qy7BTwX88VtAopb2joMlVA602AsUnp7VNwcTHXxg7fILA?=
 =?us-ascii?Q?A7RiIO0jgCyX3cnTfB/sPMvTGjMEiyo5H6DOBmtXZx1USBkortCE+Jcxdt2l?=
 =?us-ascii?Q?aUgzt6bBAvxec16oG9pS0NI9zcUZUp5PHv23dGqp3wxps9HoXtDXxlKHwNvH?=
 =?us-ascii?Q?hoFKo7Qmnw=3D=3D?=
X-Exchange-RoutingPolicyChecked: J5GAETryak1pKHUK6mNpeL1D6/l928NsLWdnQM5KSDd4r+UOHuG4dOjTec6NCo9xEDpw8sYyYraky0e0jSAe/DXzO5KPMkvrI953/91IsCPw+BMKdYGPMs9DDgsjXtTCX31BOdCiI9lzIXnovMwacyZ29httmvx9hwh1WC094cborLr59xiR+P0bCq6Dm+wAN91PL4JGVpa5lLDJYyIprAeNItE8pJBNvh+OHYJaDFKnK0eho2YUbpOSnWQX9HyLM4ZqniiWAZcd7Rn+e295clMN7DQ1cBzthqWE6e14jjjYrJNr2ILXzbRcQyCeG9h4zpWj06Ha2NSCEw/ypGi1dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 640059f7-3873-45f3-3241-08deed6d20bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:30:09.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI/jQ9zUoUqtU7DBnWLIoNS9BomoLUkFLg5g1CUEBHHkUgCJfqFIC9a22ZHC/as7tjr2lcnKrZJtKGcARViAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

Hi,

A new TDX module ABI provides the maximum attestation report size. This
series changes the TDX guest driver's report buffer size from a fixed
constant to that queried value. So effectively:

  s/FIXED_BUF_SIZE/queried_buf_size/g

...in the TDX guest driver.

Terminology
===========

A "TD Quote" is an attestation structure signed with a platform key. It
contains information about a TDX guest and the platform it's running on.

The "Quote buffer" in the TDX guest driver is a memory buffer shared
between the TDX guest and the host VMM to retrieve TD Quotes. It has a
header defined in the GHCI spec [1].

Device Identifier Composition Engine ("DICE") provides a framework for
layering attestation evidence. This replaces the SGX model of contacting
an Intel server to obtain a certificate.

Problem
=======

The fixed-size Quote buffer approach is not sustainable. As
cryptographic algorithms evolve, TD Quote sizes also grow. A previous
commit [2] increased the guest driver's fixed-size Quote buffer to 128
KB to accommodate DICE Quotes, but it may still be insufficient when
those Quotes use post-quantum cryptography (PQC). PQC certificate chains
are roughly 10x-15x larger than conventional ones, which can increase
Quote sizes significantly.

What's in this series
=====================

To avoid changing the driver whenever the Quote buffer becomes too
small, newer TDX modules report their maximum Quote size via a metadata
field. The guest driver uses this value for its Quote buffer when
available. Older TDX modules continue to use the 128 KB buffer.

Patches 2 and 3 refactor the existing fixed buffer handling. Patch 4
then makes the buffer size dynamic.

The "outblob" file in configfs-tsm no longer has a fixed maximum size.
The limit can now come from this new TDX module ABI.

Patch 1/4: Add a helper to read the QUOTE_MAX_SIZE metadata field.
Patch 2/4: Calculate the Quote buffer size with struct_size_t().
Patch 3/4: Store the Quote buffer size in a variable instead of a
           constant.
Patch 4/4: Allocate the Quote buffer using the queried size, when
           available.

AI use
======

I used Claude:claude-opus-4-8 to help edit this cover letter and the
changelogs, and to collect the review feedback on lore. The series also
underwent AI code review (Claude:claude-opus-4-7), but its comments were
limited to style suggestions.

v2: https://lore.kernel.org/all/20260717214349.4075994-1-peter.fang@intel.com/

Changes in v3:
 - Split the v2 "Allocate Quote buffer dynamically" patch to do the
   refactoring first, then make the buffer size dynamic. [Dave]
 - Improve patterns for readability. [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Add Binbin's Reviewed-by to patch 1.
 - Drop the Reviewed-by tags (Kiryl, Binbin) as the patch was reworked.

v1: https://lore.kernel.org/all/20260612110853.3188196-1-peter.fang@intel.com/

Changes in v2:
 - Collect Reviewed-by tags. [Kiryl, Xiaoyao, Binbin, Sathya]
 - Keep the explicit (u32) cast in tdx_get_max_quote_size(). [Binbin]
 - Calculate the Quote buffer size with struct_size_t(). [Kiryl, Binbin]
 - Add __GFP_NOWARN to the allocation since its size comes from the
   host. [sashiko]
 - Rename quote_data_size to quote_data_len. [Sathya]
 - Drop the Assisted-by tags, as AI was not used to write the code.

[1] Guest Hypervisor Communication Interface (GHCI) Specification,
    Version 1.5, Section "TDG.VP.VMCALL<GetQuote>"
[2] 43185067c6fd ("configfs-tsm-report: tdx_guest: Increase Quote buffer
    size to 128KB")

Kuppuswamy Sathyanarayanan (1):
  virt: tdx-guest: Allocate Quote buffer dynamically

Peter Fang (3):
  x86/tdx: Add helper to query maximum TD Quote size
  virt: tdx-guest: Calculate the Quote buffer size safely
  virt: tdx-guest: Use a variable to store the Quote buffer size

 arch/x86/coco/tdx/tdx.c                 | 19 ++++++++++
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  2 ++
 drivers/virt/coco/tdx-guest/tdx-guest.c | 46 ++++++++++++++++++-------
 4 files changed, 55 insertions(+), 13 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.53.0

