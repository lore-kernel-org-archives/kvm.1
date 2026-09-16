Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC543F6C58;
	Wed, 16 Sep 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544488; cv=fail; b=itmAlimX/9NOswbwgwQv/JYoGCWoEqNwo+Tc/c3pAldc480j8GR+NGRtMEZdT7pSmFIQeN4AqZlfXZ6/5FVXN/sbZDBbvFJkFpbmJ9mKRRId9xS8uJMtu1MHhk5mqvj5UXjVxedYw2D2scYYn4vjKnOutq6fuBNSMGNQO+gypCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544488; c=relaxed/simple;
	bh=hKxeboa2PmRacinq6j7U+wSG1SppGzP8UfgK+DmttmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqmDvd9MuRaYww+QJWX9u4MmZs6tPcpbBOD5jxt9ZMjRBZWXK/x2M+De1i32BaHVy7CxqkMQyPPeSr2o0Ja0XKfamqVjV3N4/wHdKCFqpmmJ/4svZpWKTgzujfohenYINWeuJtmfG84Qv1yD7AC6mv/OCKk9FxhZF8NDJhHRm34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzrI7s23; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzrI7s23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789544475; x=1821080475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hKxeboa2PmRacinq6j7U+wSG1SppGzP8UfgK+DmttmA=;
  b=kzrI7s23sguXzEsFYNO33rBmWPIZNFo2GnmafpskCGJ6D2Dcnetp1tsP
   K1DphLghk2CwMZyyWwQkG0TKai2eHEsPrz+NXMRs8wauyNc21WxjHxAQB
   ORvxzLVF2uatfiGjwjcksa8uheAd7Z2kl/zOR7BXpGNdC3vPxBRXOoeKs
   h5QbI5imxQ3t17lWCIeyF0Op9DGikDMd70JUKFEQKfVEgTXbV4ZqUxikV
   mwhnl/CseKlz9oNsaz/ochNFZwmC+fRMLa/LLia6PQmk79kXJrsVXrnsa
   yQzX96w3A7DFReI4xtVBEXQzz305GqxIOr6WTd1p2Ma1hjb7edEv6+pBJ
   g==;
X-CSE-ConnectionGUID: Gh/HyG1+QqiV89Aav/B/SA==
X-CSE-MsgGUID: c3BOuFNYSTuFHqSDgblU7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89855693"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89855693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:41:12 -0700
X-CSE-ConnectionGUID: kx/iEBSASZmhccBnUuMnaA==
X-CSE-MsgGUID: 2PC75ikQSB6YP1LNLwCy8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277007071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:41:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 00:41:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 00:41:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 00:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBiWHXlEnZCZ0O7xM4JUYvdXaT34e2oU7QJ69JXZ3wzrWJ5h34TBx7ghP7QkZahngDf67smQsLhwDKV937I31RQQlKaPfxTahoTU9xe881DqCQBzN8qjvkCaabafKXe7deuHnteE0IvU5IsTB7h8jcpa3TleiAcJIEGaZomyi4ylOErMrNqCwVfbyeX9fJkn7P5yAFjoSN7UxdIq4mQvgt8rHpxJXKoKPX+M1GPOuVX0S3czCQ8te6+OrwzuoiEKCM/OsWkCJX6iKfe1ryiKaTN7rqDWKfixjqgpXZpg5q81mUybM4vzu4H1O5gIee/r9Qb5+3MZjF6h+mCNPN7ryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOT9K75TVbLQDOpzQrGSfFblmJqUhl0XYK5Eyd4AkRA=;
 b=Jdlzoqc2nk6KFhWwSQpHhFR2KUQ6X0oX9LiF7Jn98Z7ZQC7dvN4cWIYtiIXqDHvykgR5dLz6b91woDJqa8Wf3vnsLaWJoqN/gZfDdFwYAKDFENPlPb4TTBBEGWNCpnISfJ0QOFLInVGYnu3+LL2D0lp4Nk32K3hch0nCmjhnxKbTbJo9CskUOAGk2TuiSVmbZ2afrTgqCqXR1lfhzaotcRx6FLxsYiCxQTMIBWJkZDFX+Nt+6acUl9dXO4XjcxY+qaIxuJMplM0pz+A7Dmqq99cwZWaKKbeq3pbHAZk+AJyAMMQXEkOQsoqKkOiNkJJCqBBWksAdjWmZZCMprKv0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 07:41:03 +0000
Received: from SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5]) by SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 07:41:03 +0000
Date: Wed, 16 Sep 2026 15:40:51 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <artem.bityutskiy@linux.intel.com>,
	<kvm@vger.kernel.org>, <nik.borisov@suse.com>
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <aqpIAxQ6C71bEqFm@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915102658.713079-5-yilun.xu@linux.intel.com>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To SA1PR11MB8375.namprd11.prod.outlook.com
 (2603:10b6:806:38b::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8375:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc5651e-e899-4c7c-8160-08df13c5dc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|6133799003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jXSATZZ2Q8+wpRebcotz5DtcxTcqsnfkv7qM8br9pO7jXYjPuYxURXPEg3VVwV/0KaFMeYzUPAwTGbBF9h7fY5A2Xdj1t4WY9xu+lCNs3OhjKY6KHQdKIdNZfB6YFazwIqJEuE1jJ66Gp1TTkMnOdSx0kv7UnWGXO0d3lKe5nMx0wScouEXXUVXKW6Hnj9Dq/vvP6Mfq5yeAh/UIVQhaS/EKnEskQXS89jMA6b2qqiE6x1vmuZcl29wLPN7SIUsQy10r9mkgAp59m78jKsyG3NLfU0yzed9vMtlSxCMCre3wnJjth7Bgj7DTiqR+AYLxhuh7snBseHGiSZtaVUtPJjz1HvhdbCymNXs8jYqA1Kz8I9dXZIV5XzQpGg7ld3dNbLBIchnbmef4JQTbEpw6zr4cCySt5CXYuCR958jwDa6PKV7wNGoDegcsFY8QKBsb5dlBRk0M9nlW9OyP0hpJTNK+mz5nv6m11Ewxj7r5Z7kaF/v4h3J34KIXs9tl5xQjv8d7GyMhHbinumedOk3z4LKtXmJHIlX6CCM8haqFdyXpqSoUx3KrA4KKe/o2zmNHjFcIw80/a+rwwc0pnbn6/DXPquSBBfRb2Cipt8ULVLxztb1qRmsNKg/O3BSo7ZtRqI9jF8sVJyq383KkiTIgAiOd4CCuyuOi0F3bfm+My4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWWy8RHXEuH+dHN0NplxoQlRtYPl8ZA7XFUTwjnUwU5s8uEhrPnbZ+TRhsBP?=
 =?us-ascii?Q?jC7DPA9LqoNQ2TZupf8nAIA+61NQ/ccYvIcFHcztu0QsX/GGLuyT7hGTACLn?=
 =?us-ascii?Q?n8NgghzZ61ZUvJ1Dl/DIMcIoJvVWWQLoU0Ap82lC3uX2NbXmIJmc5OV9OrVS?=
 =?us-ascii?Q?1huAjOhYzrT2/o6wePv7Reo4LXcR0YH3Wo5BkZfSQdx1gnUgpL9J/wKcb8DX?=
 =?us-ascii?Q?rgZNPMpvRy0DUz+hIz6x04ifTmDiPQJ+CaKHeY/wJnl/DyaciB6ApDxfLzdk?=
 =?us-ascii?Q?OTfJPAxop1hvuYzC2FwgqS2cBL2MIgE2ALiIcO78rJqqbnLedHzLm/K0EQ60?=
 =?us-ascii?Q?aZ3YaNNmyAbVBxx0r0rxuUgrWHktL0lt89j+D4gaCA0bZHthjXqz+nIlD9eS?=
 =?us-ascii?Q?+tTXX7IE+16dUkU8ZtasWLa0Lxkkc5WqytMrDe9yc8Ct8sJcPy5jS/mt/Dw5?=
 =?us-ascii?Q?nIbxD0FavyHKnhm8/uj5z+9DpFZWlRqsC4QXA9/MZCqsIixk9WtgKYCIqddI?=
 =?us-ascii?Q?GCyCBYVHJF591/GOIbhgR3Coqjq3PS9xN3kNqvT+xG8ggjYw5L+t2qe2fgdE?=
 =?us-ascii?Q?+DfjwYIKytO3mRJ0cqMENjGOc4G/Qle627ULhzsm/KJ99HgfUb/mfzXogZ2L?=
 =?us-ascii?Q?sPauFtJar79wQpW8eKpPfXlfU+fItQV8YWdSD2rDeRbC3/PF3ctW7JqF9Aci?=
 =?us-ascii?Q?kcijhEnB3csv3k8RfIz9JJm/fcu9O4cH1W8jZEHWlnncrQ1hG7bILyKrpj9m?=
 =?us-ascii?Q?VkkHmdtsvb5ff5/Ifypv5xbvCayvdDVgBVx/+C4Vs3oY00FZY5OZSzdub800?=
 =?us-ascii?Q?0wnyUovBIPgI5hmoyKY/0mCYS76geaiTER/Eajohwu8LBYz4ZZdZrtcHcJWa?=
 =?us-ascii?Q?K3k1tAtSqaIop8KNJM/AEc6k06EALf5BwjLw6MPNxQVc/MP7jXTPjiQ9xw3I?=
 =?us-ascii?Q?Ox/FxipYjhlZKy21O4TRVTi7nZZqsugZ0uRAX62vONC5/uCxYR449yiNrMP3?=
 =?us-ascii?Q?IuCF3clM5yCT6MgIziK/i8huqcReB0+HKfWN8lSwtaee1HeHEVWWa+ByQLyy?=
 =?us-ascii?Q?1k4oL05djC5ucK5mFD6hKbDbJyb7dqm7LmOKfr/OOLajJ6b91iKZ8tT1cXLi?=
 =?us-ascii?Q?fVstO7p0bMI4VbPx3C4cvZqdOQAb8wByvkJKREzYEbwjunfnWuwyY5NNmwFU?=
 =?us-ascii?Q?yzI/0RgQg8DXP9HSq/dC8z3CH4n6yEJ4I6hGusApObcvIWV90/0OBPdZVgNq?=
 =?us-ascii?Q?SXebdA4EuxrwGTf1WQAU+CxUKPXYRdJRu9F1EcZzg8/46+DUnhkNCzudik8H?=
 =?us-ascii?Q?IHT75ns1zyGtonOQwcXtVCVS5nB2bbNIoHGxWd9Gy7HB0jFNYTYY2bfmJHa4?=
 =?us-ascii?Q?BI+f0akxuXlGXhsRRSnFwhw63T4Wkkin6/+nYyuhl48+EYuuBMf2m6/JtWg6?=
 =?us-ascii?Q?ykSmEy4m+mGKnxcU09HeXRfO2stWaANoeCYxyFZvjd+X38f2/5h6fcBkmBPP?=
 =?us-ascii?Q?Rj4Gae+syjzx9hHJrOlVb3gVCjZuql7U1RwVYENWuzLT98CgOjNmat2mh6BE?=
 =?us-ascii?Q?GqAL0vH99d0Lp2p0Bj7Wp9Wh2Q559m6fmZfUAKM9l2iaNVDWYS89Wab4XzII?=
 =?us-ascii?Q?5JdQaOBLY92aAAWp4+QgVIJkJLAaQ3N/2V0khHZGmTsCS7LwIFI5n+tbG7Qq?=
 =?us-ascii?Q?FJnsV1yo3+J21x/eO5cWWpKopXZVakFQhbmnc40RpA3WuiVMfYkyt7APIyUP?=
 =?us-ascii?Q?iIst5BloKA=3D=3D?=
X-Exchange-RoutingPolicyChecked: WWzvyIP1zk+NKJDXQvWry67X19oxfcvYtzX+ZKkA90qt8f9lzSYRIDAuOoEil/WtitBb1T9bITfduTT+i9tcU8jHj0wf3GZvSXNKhE2c0fBCKYKCQV7NmjGwzVMxPUZ1VpX2bkMQYyqbC12rcHWTzz/yMfK+zVSjOthCD+Z94nKrsIX9foKNcZrIdUkj0d8XpnYj8Fq0i3bTw/HDL1vKZhJa6UF8OYxUXx27DwVfOJGwwOYsb3R7dVtCORsaSL5q4tb99oP1WtPrVDGWa9wAHRJViy9We9ZVJK0vxvSWeUp536yoSx/F9HUvcYHxpf/ErIgCg51wsXsNkN7Ne5GnrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc5651e-e899-4c7c-8160-08df13c5dc20
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:41:03.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVPpxNc+chsGttGq+65KmkZvxjJlE6NsyvgJ5DaydlcmtNtX5q5f/Qvh/cP+0nh+JDCUXKItdwaBi/rdkoqsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

>+static __init int tdx_ext_mem_setup(void)
>+{
>+	unsigned int required_pages = tdx_sysinfo.ext.memory_pool_required_pages;
>+	struct tdx_hpa_list *hpa_list;
>+	unsigned int added_pages;
>+	struct page *page;
>+	int ret;
>+
>+	/*
>+	 * TDX module uses the metadata memory_pool_required_pages to indicate
>+	 * how much memory is still needed. This value decreases each time
>+	 * memory is added via TDH.EXT.MEM.ADD.
>+	 *
>+	 * On first time initialization, a value of 0 before any memory is
>+	 * added is unusual. But host makes no assumptions. Skip the memory
>+	 * setup and let subsequent steps catch any actual errors.
>+	 */

The fact that the value decreases on each TDH.EXT.MEM.ADD is not relevant
here.

Also, calling 0 "unusual" does not help the reader. It is either a valid
value the kernel needs to handle, or an invalid one the kernel can assert
on.

How about:
	
	/*
	 * The TDX module may require no memory at all. Skip the memory
	 * setup in that case.
	 */

>+	if (!required_pages)
>+		return 0;
