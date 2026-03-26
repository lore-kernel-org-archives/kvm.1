Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210B275B15;
	Thu, 26 Mar 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515176; cv=fail; b=qco0nqBfQEzc9wSfkjqcRZY2Zue7gj5Tie9RlSIhMBETuIeHocJXYdCyGOcrjJw6Eol7ng2ctamsoiesEqAM3AWnSWygYB4XQ9tQj0MYNQGrFvpDXU2q56bxvfSlCtqW74R4l18sFXv9ifreZgn244d4HkdWe+l6jhEgZ7ZWC5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515176; c=relaxed/simple;
	bh=o3U9oYc7TF04fnIIMGPpCH4od9Jn4Emuc7xUaxS7BQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pjNdCLC/pdZ6Yb379PowLUrS+2YKKT+7mOZWMk4NP4o5damkmBfVPruV9etgmmN5OG+lTDxKdSUzCCOMXtO80pugDOv0qlIEc2hCI+V66uvljOYw5+bumXgiCkXc2gvOFmwtDBf8wnwWi0rZrsQEJscZSlkmUSqmkrAH3v++0n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxapP31Z; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxapP31Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774515174; x=1806051174;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o3U9oYc7TF04fnIIMGPpCH4od9Jn4Emuc7xUaxS7BQo=;
  b=MxapP31ZRGU/UlWUIQVxg3FqMCU4gqIWn0IMAOeaphqmwTzHLUKGDuUK
   K0UOyX1kjxxErjZhhoVXL5+qXzsWbMZfum/w2YmjMgRGlGMYUTZ8ZC5LL
   iQQeT44ulCD7UVqVK+6nUeebLjTdRN9v3SF82Z0hWWrqaChe1tBVihcEH
   QRQIZKB2QqK+EhZG7KIMiuMqkUCB+PtqJwsqx68iUaA9Bxf+7LzeJYHTn
   phFk46AhhxYte8lXtDfegH/msyeoymkeygENeTo+dQOJAmyt1HLsV1xHJ
   IBeEQZdmyw+jaXA6afqUTJXHukr8GzoxG7TjcnR4D559try8sJmtbAC1W
   Q==;
X-CSE-ConnectionGUID: HBFJnVrdQaejXnicuxb/LA==
X-CSE-MsgGUID: SdLLEGnPS9adzytUh/A+jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="79166252"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="79166252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:52:54 -0700
X-CSE-ConnectionGUID: jk8rAj9VTPaKe8M+8XUQbw==
X-CSE-MsgGUID: lIEWaMPXS1CI7LrWsVGy9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229397383"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:52:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 01:52:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 01:52:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 01:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZDJTRxbU8WozS9Wh2fQskYdMMdsxxs1nRjolIpftedyF01xNIA3r/incxtRUJAqgaOZY3q3q09fQL0qL0oVYxJQkkcnmpn873DTEZBJh9j86Iwh1u68OO04HGSa6hjIyIg7fQRwFWcOaMVNXETgr74mB1sjZ08DuAJWE4CCk+Jwytpwq1SgfdABljA8tKxqlPCIFkh8TnJIx5HVVi0CLw6A02tyfgcRI6EcIzDsKl1FjKT+4uVYKj51JiiixZoFjuNWezzG4HruVmBJGEg1nSLwpvKm5xAYeEhT6Ziq0fP2vFPAYEV2eYdmkxCn+4HovWOoKBULTqhzasAZniC6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+h8fumXX8yzlG9TJ5XyR4aSuUY+dHZTzDlvweQ4jQg=;
 b=JcevcfmSHnfuFVE1dyf9o7yj6sfBg6rC6Z5CtNdbhuS09QqsbAbKenvr4IGy3+zIcpbaE/Rjx6tF+HJw+W4ze+O1HoZv+al9xEkXznXqBH590evfT2kRDWOed0jSgdM/EEEIJYSUzeVLVpoRYIkIMhYb8YlD94CArwpJI8C+XrdqnWcjIdqgK5Ntxhx9sdZwhyKDRP8e6F8S14MyRtCCLTGueUsLhSDuXIVJPdmKBC4ZtiMYjBQp6/uvAcqtiqpPmr/90b0Vf5/xL39WPERV0lcfL2YxqdkxnqI/lV8nbBt8rH580QRUTgZQGqsV9KUBV82vVd48C2amcRlFbo6X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 08:52:47 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 08:52:47 +0000
Date: Thu, 26 Mar 2026 16:52:30 +0800
From: Chao Gao <chao.gao@intel.com>
To: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <x86@kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Borislav Petkov
	<bp@alien8.de>, Clark Williams <clrkwllms@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v6 00/22] Runtime TDX module update support
Message-ID: <acTzzi2vuqga1P1d@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ0PR11MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 83133220-c97e-4c1b-1316-08de8b150d62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: TsnOZEdN5ueGB/YXeIJnxpCu2pbksEJip6+FRcHBhy/tu4wAqKI2MyaOcCoXGd554aDYZEg5FkytEPxCVvaOs9BR/mXfC/tGJ/0Vpyb15R7AAqcD0JrzzYXA55VoVeQ3fpbKU58OvbjdhhNiWgl+8h9kObX6rj3sXoEfoYz1YshJz2Ib3/ajHJgGWcwlNMyuZDnZMNzAo0tTprUHod4jdwLB6icfsIGcJGW1G582QqkeulEKOV7/ZHSHNI/AZ3r8WZqTL2QChfV6yETGn1XwmN1so5DPVWxJuEA5tZ/9yuosbC+itldolFn1H3/vBe5wrnil3eD5i7MuDH3sBgWfo1FO3WsBk+MjRdc+DTQGJRwIbJtEUDsRiuovN9YzZFiwvwEmBRme8sHvs+IyGQnmhC1ZjQzxWlS30FkSDFFA+bKCOv+rEWVuy/k+8vpFtEzC6L8NyLrV4V1mwx/4iw5RXW4czLo9riLHPyfxqf+BafPRz2tsz8Jwymczs6kS8aaqobcDwBX57Pyp4QsqGUjLUm3js2TANpixcwKAVQzYQ3G1vOkK/mm59CYgRqCHIRqqmhjKzlXy5nOdg3Kj2YYNCSG1nUSgBBOv3hMZhEvyU/QhZ9QQLprdoBZW5uwxDwjr46MCuytW80kKnxmrkYeSxOvfrWi/6sLA+ZU9cl5o3x0d1LTTC34PwQHA6BS2g70f8ltE0zEOTYHhiMlp876PY0LdH9cy02fvMDIba7n+f20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JaIR1fG1+ZX8/z7e5SvTXPdmclRfsWbQDNw6+rrQoHuO+uuGDARZGgvjzW?=
 =?iso-8859-1?Q?dGR93n5Q02S4zCf2I3pomcuqP2Hbo4I2Yan9bNRLX8yCf5S5JAaNoiXb3V?=
 =?iso-8859-1?Q?AGX9ZSGfLm1PLjzhbdFI8k9VOm/wPUtER6GE0nRXuY8DtEElvVi3xUAvgX?=
 =?iso-8859-1?Q?sQKKcBgplI7lglx9TKifpHT3lWjkGICBv+alwu9KV0VPegIigt+gik1yaf?=
 =?iso-8859-1?Q?8WJpQooEg0YIb1ryZ5l+RQaud80dKZViYYt4B/G/byp6Z9UiywleNsOO09?=
 =?iso-8859-1?Q?zvb7eQaNekoHUuWosOdlnfgHdtB3+ha2LZipLH1w9U9KhaRAahcyiWXn0+?=
 =?iso-8859-1?Q?nbFu+KRZTBlXmH7pxRnJ44KBE4f1Rco+2N2IcKXbTTK3fmu+aSpJicGKSg?=
 =?iso-8859-1?Q?cX4LRtZNsdjJ92gDOEddLJ9KEb5hnKDbraFchByBxbKljXaHIZG+8KOSLJ?=
 =?iso-8859-1?Q?ZS+gpwNOp4HxLCbOKrgcAaDM02vj3rvU5fbzMMr8a370zDnW0O2+e+5H2e?=
 =?iso-8859-1?Q?+yYxFc2z1OxARPOZGmHB/12D92nZKVpO1bY7Mtx//5736mcuo0+o5lStjA?=
 =?iso-8859-1?Q?3mqTPms9irviMQxNF4RnurMnAuK1nBOvxiYm7APDxL3f/vtcN9DHoyqRlc?=
 =?iso-8859-1?Q?vGS8/WXfWKKFdxrGNmxb4U2XwFZMyWjadfxJ20d0Tzlxj5DGzbQBiOnD/p?=
 =?iso-8859-1?Q?Nu9SAQ9x4y/C104etSmWo1saOxRLPl2ywXODI8EaN9m1tm+z959wNIQmfm?=
 =?iso-8859-1?Q?GRL1rf/eZCad6ntTtg7eM1K5kQ0W27lJtCiozDdadf0c/6NtuwwOfKkkOa?=
 =?iso-8859-1?Q?dU/t2GqlaOJWJxfNDeJTrVQracbu/fbM/d8C5rHkqAH8DmBJb+pKNQGzT7?=
 =?iso-8859-1?Q?Zv8yILcD4KCGBMNsOGeSK6bDioiYDieKgOOSZzNe1wmCTbBArcWm152q4j?=
 =?iso-8859-1?Q?5zReUs/gKBCccLz/I3yuBEsyaYzd3cWDu7ZQTqCrcGa6UPUN9nRodkpe7v?=
 =?iso-8859-1?Q?5zdoL1s82pSfafcNCahnp9NQcWHV+DkRCeSspzK09Pk3qtqwHhhxHACZne?=
 =?iso-8859-1?Q?uTnjDvSCshVd9dlaSUlyPsCSwM4VvHiTR4LVrFiocClVvDWUt/Eqj66T0m?=
 =?iso-8859-1?Q?BBlGB9FcFCp0t5nCpmy1Y3cght5BSlb9HlVaLaPqU8Jakg/+ndY0JU6sM7?=
 =?iso-8859-1?Q?xMIIkUDp5vocDXlR+H+XunsTNdlHXdvJQvVKWFmKtaC6S8uFVRS9VRxBip?=
 =?iso-8859-1?Q?Q6scUBGnqgFRj0xjnYPka6vcWfXSe7djM4pzX+bvqHS0zXcLLfIeskrvF4?=
 =?iso-8859-1?Q?HXlNfpEal8MKlhwm+v1PsHJZcKo3uaVKxggcptzMrSCR+o2P+12ePCci8m?=
 =?iso-8859-1?Q?Jg+MOnZAZSDUAd8MpeSi24ZsxmR8X3oPFB88OoYfUdQyTBPt5dRE7q9iwk?=
 =?iso-8859-1?Q?1lkC0gUhv0oZ8EbUFHFEbgPIwqqjxOsgXXZRSYrI7GI7amYxnlo6wpWVxR?=
 =?iso-8859-1?Q?9Fl2XBHt20L0XaW+DSFdEohDgTMFz+l1vNIa06z9ronaJLTKtWuJ1AL0MW?=
 =?iso-8859-1?Q?GbE9PnWMnLSwEPuvLlYXJKkS0lernzQd/+kyz/9PcDL43uCPj+wh4fcTn/?=
 =?iso-8859-1?Q?y4CtqJHURu8ieBA1d+FMoZ2IufZFc2JCtQyoIj1hOFG5GurHNrGQCasdAp?=
 =?iso-8859-1?Q?kg3urFjf/TfNxa5tM9nMaL890HL/6XWVli75oYl/X1ICiSMPtAXtCg+L53?=
 =?iso-8859-1?Q?Tc3wNrRyqaqgp9l+j6wdXWw2WIfl7DEBYRKmS3C2P2dRJjyfqC0gJYyPeD?=
 =?iso-8859-1?Q?XgCNTu03rg=3D=3D?=
X-Exchange-RoutingPolicyChecked: mPkWwfx6X0QPLB0e+hhhtyjjZNdVty78i0qLr3ndnLERIQRtgNGObH0re9sy56UJl7H7kjsSUVrHFlnACliBG1oPjKffybviTs/rFp0luQFFRqmSkD4o7qai2rxGyB4cFgya8wu3QZDB/K0eNmK5/BB4mjPpTzfWm7zI2m5UqHNTw2/MmdSGAsl5ptwmd2aEx3fosKuxBCRgU2av0C6ljJRck6iCXVrZUCOD149Tdu2q8wqKiuFDojaattjUHi9G9m50hLwYSR9DPLMndlLmszkmlWudW++Jy9Wn/iISyS9M7NsxcNvd5oBVXhxIn7aA4S/Yv/ub3UpLTjtdoHO7ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83133220-c97e-4c1b-1316-08de8b150d62
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:52:46.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB1EplpeGLIuPjPDiVMATM8i+OGXHzqzRMSNUNDSPilmdOj1mq80wYNZP3mf0gt8/EUoat8Jav7CT480Qn2KiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com

On Thu, Mar 26, 2026 at 01:43:51AM -0700, Chao Gao wrote:
>Hi Reviewers,
>
>Please review patches 6 and 17; others already have 2+ RB tags.
>
>Patch 6 was reworked to use is_visible() for attribute visibility (which is
>the standard practice), so previous RB tags were dropped. Patch 17 has
>fewer reviews so far and needs another look.
>
>I believe this series is quite mature and also self-contained (no impact to
>the rest of kernel unless an update is triggered through the dedicated
>sysfs ABIs). I'm hoping it can be merged for 7.1.
>
>Changelog:
>v5->v6:

Below is the diff between v5 and v6:

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index 97840db794c0..e1a2f3b2ea65 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -24,9 +24,8 @@ Description:	(RO) Report the number of remaining updates. TDX maintains a
		number is always zero if the P-SEAMLDR doesn't support updates.
 
		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
-		Interface Specification, Revision 343755-003, Chapter 3.3
-		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
-		information.
+		Interface Specification, Chapter "SEAMLDR_INFO" and Chapter
+		"SEAMLDR.INSTALL" for more information.
 
 What:		/sys/devices/faux/tdx_host/firmware/tdx_module
 Contact:	linux-coco@lists.linux.dev
@@ -58,14 +57,15 @@ Description:	(RO) See Documentation/ABI/testing/sysfs-class-firmware for
		baseline expectations for this file. The <ERROR> part in the
		<STATUS>:<ERROR> format can be:
 
-		   "device-busy": Compatibility checks failed.
+		   "device-busy": Conflicting operations are in progress, e.g., TD
+				  build or TD migration.
 
		   "read-write-error": Memory allocation failed.
 
-		   "hw-error": Cannot communicate with P-SEAMLDR or TDX module.
+		   "hw-error": Communication with P-SEAMLDR or TDX module failed
+			       or update limit exhausted.
 
		   "firmware-invalid": The provided TDX module update is invalid,
-		                       or the number of updates reached the limit,
				       or other unexpected errors occurred.
 
		"hw-error" or "firmware-invalid" may be fatal, causing all TDs
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 386097b2e01b..6351d2c21513 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -116,11 +116,6 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
-static inline bool tdx_supports_update_compatibility(const struct tdx_sys_info *sysinfo)
-{
-	return sysinfo->features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT;
-}
-
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 4e1ad06506cc..276330179783 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -51,7 +51,8 @@ static_assert(sizeof(struct seamldr_params) == 4096);
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
- * be made with interrupts disabled.
+ * be made with interrupts disabled, where plain spinlocks are prohibited in
+ * PREEMPT_RT kernels as they become sleeping locks.
  */
 static DEFINE_RAW_SPINLOCK(seamldr_lock);
 
@@ -73,6 +74,13 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static int seamldr_install(const struct seamldr_params *params)
+{
+	struct tdx_module_args args = { .rcx = __pa(params) };
+
+	return seamldr_call(P_SEAMLDR_INSTALL, &args);
+}
+
 static void free_seamldr_params(struct seamldr_params *params)
 {
	free_page((unsigned long)params);
@@ -109,8 +117,9 @@ static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned
	ptr = sig;
	for (i = 0; i < sig_size / SZ_4K; i++) {
		/*
-		 * Don't assume @sig is page-aligned although it is 4KB-aligned.
-		 * Always add the in-page offset to get the physical address.
+		 * @sig is 4KB-aligned, but that does not imply PAGE_SIZE
+		 * alignment when PAGE_SIZE != SZ_4K. Always include the
+		 * in-page offset.
		 */
		params->sigstruct_pa[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
					  ((unsigned long)ptr & ~PAGE_MASK);
@@ -136,6 +145,10 @@ static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned
  * Note this structure differs from the reference above: the two variable-length
  * fields "@sigstruct" and "@module" are represented as a single "@data" field
  * here and split programmatically using the offset_of_module value.
+ *
+ * Note @offset_of_module is relative to the start of struct tdx_blob, not
+ * @data, and @length is the total length of the blob, not the length of
+ * @data.
  */
 struct tdx_blob {
	u16	version;
@@ -196,7 +209,7 @@ enum module_update_state {
 static struct {
	enum module_update_state state;
	int thread_ack;
-	int failed;
+	bool failed;
	/*
	 * Protect update_data. Raw spinlock as it will be acquired from
	 * interrupt-disabled contexts.
@@ -234,7 +247,6 @@ static void print_update_failure_message(void)
 static int do_seamldr_install_module(void *seamldr_params)
 {
	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
-	struct tdx_module_args args = {};
	int cpu = smp_processor_id();
	bool primary;
	int ret = 0;
@@ -254,8 +266,7 @@ static int do_seamldr_install_module(void *seamldr_params)
					ret = tdx_module_shutdown();
				break;
			case MODULE_UPDATE_CPU_INSTALL:
-				args.rcx = __pa(seamldr_params);
-				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
+				ret = seamldr_install(seamldr_params);
				break;
			case MODULE_UPDATE_CPU_INIT:
				ret = tdx_cpu_enable();
@@ -269,8 +280,7 @@ static int do_seamldr_install_module(void *seamldr_params)
			}
 
			if (ret) {
-				scoped_guard(raw_spinlock, &update_data.lock)
-					update_data.failed++;
+				WRITE_ONCE(update_data.failed, true);
				if (curstate > MODULE_UPDATE_SHUTDOWN)
					print_update_failure_message();
			} else {
@@ -314,7 +324,7 @@ int seamldr_install_module(const u8 *data, u32 size)
	if (IS_ERR(params))
		return PTR_ERR(params);
 
-	update_data.failed = 0;
+	update_data.failed = false;
	set_target_state(MODULE_UPDATE_START + 1);
	ret = stop_machine(do_seamldr_install_module, params, cpu_online_mask);
	if (ret)
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b76b8c393425..3f4221098b78 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1194,7 +1194,7 @@ int tdx_module_shutdown(void)
	 */
	args.rcx = tdx_sysinfo.handoff.module_hv;
 
-	if (tdx_supports_update_compatibility(&tdx_sysinfo))
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)
		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
 
	ret = seamcall(TDH_SYS_SHUTDOWN, &args);
@@ -1214,11 +1214,12 @@ int tdx_module_shutdown(void)
	sysinit_ret = 0;
 
	/*
-	 * By reaching here CPUHP is disabled and all present CPUs
-	 * are online. It's safe to just loop all online CPUs and
-	 * reset the per-cpu flag.
+	 * Since the TDX module is shut down and gone, mark all CPUs
+	 * (including offlined ones) as uninitialied. This is called in
+	 * stop_machine() (where CPU hotplug is disabled), preventing
+	 * races with other tdx_lp_initialized accesses.
	 */
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
		per_cpu(tdx_lp_initialized, cpu) = false;
	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index d6a4fa8deb5e..1b6f9b80b197 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -102,13 +102,15 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
 
 static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
 {
-	int ret = 0;
+	int ret;
	u64 val;
 
-	if (!ret && !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
-		sysinfo_handoff->module_hv = val;
+	ret = read_sys_metadata_field(0x8900000100000000, &val);
+	if (ret)
+		return ret;
 
-	return ret;
+	sysinfo_handoff->module_hv = val;
+	return 0;
 }
 
 static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 8cf3cc99024a..f236119c2748 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -21,6 +21,12 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+/*
+ * TDX module and P-SEAMLDR version convention: "major.minor.update"
+ * (e.g., "1.5.08") with zero-padded two-digit update field.
+ */
+#define TDX_VERSION_FMT "%u.%u.%02u"
+
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
			    char *buf)
 {
@@ -32,9 +38,9 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 
	ver = &tdx_sysinfo->version;
 
-	return sysfs_emit(buf, "%u.%u.%02u\n", ver->major_version,
-					       ver->minor_version,
-					       ver->update_version);
+	return sysfs_emit(buf, TDX_VERSION_FMT"\n", ver->major_version,
+						    ver->minor_version,
+						    ver->update_version);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -42,7 +48,10 @@ static struct attribute *tdx_host_attrs[] = {
	&dev_attr_version.attr,
	NULL,
 };
-ATTRIBUTE_GROUPS(tdx_host);
+
+static const struct attribute_group tdx_host_group = {
+	.attrs = tdx_host_attrs,
+};
 
 static ssize_t seamldr_version_show(struct device *dev, struct device_attribute *attr,
				    char *buf)
@@ -54,9 +63,9 @@ static ssize_t seamldr_version_show(struct device *dev, struct device_attribute
	if (ret)
		return ret;
 
-	return sysfs_emit(buf, "%u.%u.%02u\n", info.major_version,
-					       info.minor_version,
-					       info.update_version);
+	return sysfs_emit(buf, TDX_VERSION_FMT"\n", info.major_version,
+						    info.minor_version,
+						    info.update_version);
 }
 
 static ssize_t num_remaining_updates_show(struct device *dev,
@@ -90,9 +99,41 @@ static struct attribute *seamldr_attrs[] = {
	NULL,
 };
 
+static bool can_expose_seamldr(void)
+{
+	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
+
+	if (!sysinfo)
+		return false;
+
+	/*
+	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
+	 * the current VMCS, which breaks KVM. Verify the erratum is not
+	 * present before exposing P-SEAMLDR features.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+		return false;
+
+	return tdx_supports_runtime_update(sysinfo);
+}
+
+static bool seamldr_group_visible(struct kobject *kobj)
+{
+	return can_expose_seamldr();
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(seamldr);
+
 static const struct attribute_group seamldr_group = {
	.name = "seamldr",
	.attrs = seamldr_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(seamldr),
+};
+
+static const struct attribute_group *tdx_host_groups[] = {
+	&tdx_host_group,
+	&seamldr_group,
+	NULL,
 };
 
 static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
@@ -122,8 +163,6 @@ static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
		return FW_UPLOAD_ERR_BUSY;
	case -EIO:
		return FW_UPLOAD_ERR_HW_ERROR;
-	case -ENOSPC:
-		return FW_UPLOAD_ERR_WEAROUT;
	case -ENOMEM:
		return FW_UPLOAD_ERR_RW_ERROR;
	default:
@@ -164,22 +203,9 @@ static void seamldr_deinit(void *tdx_fwl)
 
 static int seamldr_init(struct device *dev)
 {
-	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
	struct fw_upload *tdx_fwl;
-	int ret;
-
-	if (WARN_ON_ONCE(!tdx_sysinfo))
-		return -EIO;
 
-	if (!tdx_supports_runtime_update(tdx_sysinfo))
-		return 0;
-
-	/*
-	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
-	 * the current VMCS, which breaks KVM. Verify the erratum is not
-	 * present before exposing P-SEAMLDR features.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+	if (!can_expose_seamldr())
		return 0;
 
	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
@@ -187,11 +213,7 @@ static int seamldr_init(struct device *dev)
	if (IS_ERR(tdx_fwl))
		return PTR_ERR(tdx_fwl);
 
-	ret = devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
-	if (ret)
-		return ret;
-
-	return devm_device_add_group(dev, &seamldr_group);
+	return devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
 }
 
 static int tdx_host_probe(struct faux_device *fdev)

