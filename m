Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793893118;
	b=Dyg0qA6HLNW2BcX1VhqF/3xnn8WOvXvgQUNeZbl0IEqC77BaD5XzwJ/M9Al8txWR+9MR
	 jEvtjNAjnvg8MFxsBE3c0UmK40davaYgT18bwkpV6Zimujx8Y+RTA/+9ZelGpRhjC2eWO
	 C9krTIB4BJoCN1kChByPl/+5DrqVewuiPCfH+GN8HYFuIHiaPBQu8IE0XHCIjuoggEY/v
	 jvmRLTcOym2TOr6q9dKrpS/G5ISfhXMhVSO6HGEBoO4UcKf5EgV+HDeUWQu9CCU/I3KIN
	 2bjLEzYgXBHsTxsKN5iXgrDwv/vIwxddTD6keqmIRV5UjirQd25XvI7WoGM9/0A5nPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893118;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=QKky/4QQXLMX7u9I3ZY7h6lZkXiFHu/0q6oYhAIw1uk=;
	b=4VjMM3WGMf0Z15QoKR2H/ECYTrBp2xXTjhIhrSRXMsdpcTfhEiwrIAwQfO5yBtAbP6OR
	 TQhFtwWm+uXPOtplLGRd1lAzkA/gC0RmvCQQEwQTBnFpMojS4aGUAFCxU6oKeObiVA6pK
	 Izr1Nnav5OwhXXjSo+s7TftwAVR6ap0x4XqyZ1HjNeV+aitZ4quBePviOKPwYO+t5CBzd
	 1lYsRWRAOaw6PUb5jOAd/f3D8EPtgGGkA4FvLhTP3OJubPTQ1oN7/9MZIpgK9H3flrYoB
	 6fYtA/X7T0J1LH6f+UFhberRwLEwDAI+sFdGGBGbCgzNxz9MnLHaYOcYdYsGFasteNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="AD72jqL/";
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2E606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA2E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AD72jqL/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793893117; x=1825429117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OPJHIy774vSA+MPM+EQdXZ5VHQRsIBr+/iV0ZDxMdOE=;
  b=AD72jqL/puJHYxjbv6qWdb6LELSTo5SgjeMxJGpGNXH4w0fQQOEeK0js
   9xMnNPbOHr1qziJ5wfNa/a2J+0vwFjRvkoKtMfACCi3pk21P2OWQDVNhT
   PXSU8VUlGXCnBuUN/R5RUtU2C3UdGy5dlUFQX9bBhiiKk+392AiSmoMp4
   k4pfMfCJBU0YBqQfT4sU4ugUnpUqw22wQp0B0MrKMtMq11lM3Gs+kD5xH
   1ky4rvhHl/QWojQ4DrPSXNNWrM2gumcOLc9mpEGjPNtQHU96iw8HjJcyp
   25e6NCiT+pjSNazE3rBObhg8xMVCe0jVWzWyMftwz7QpJRVHuXHo9MKjW
   g==;
X-CSE-ConnectionGUID: gwLy5CIyTLW3DxDA6qtItQ==
X-CSE-MsgGUID: zkHAjIqNR1OihBJzCwk2Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2719653"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2719653"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:36 -0800
X-CSE-ConnectionGUID: 57e+K2QCSYqRkTsaUEOIVg==
X-CSE-MsgGUID: V+WWQSldTzyrzpezW0Q4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7062119"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 07:38:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMB2vEK/73nFrNIgCcOP2HswiIdj/wqj7FTtFbB6LTYeMhbB36xRq1mkfP6ymLnJ7xn1i9vlW3EafpsBA0LLdITz+qlpcTVzqJVMntabHvs/ZAsJ6erqaS0IAT2sXYcamZCQ2GjfJnugdfxR1em/zv7HlguEFeBFbVs7zZIvhaB+8mpSkLRQ/MbHUVJhcWH1QhU7qnmsXRzGVbIkrvlyIHOdgUOoWZXR52M3kXqYcyXgSD4vCdRoW4QV9cl5Ud4vxgC0LSlhhfTG2C9MuCLhSHl/YYXvEq3onlKPFyAiTHObp0GQKB8/FyskuUBErdAdc0oMRrdy74Uy6y4dwpRasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKky/4QQXLMX7u9I3ZY7h6lZkXiFHu/0q6oYhAIw1uk=;
 b=lbgGlaheqhWSuMT6Osn1wsN4I1IqZuwWR1lZO3PMywa+dzkLFAXo+GqeASSGpcA27xzhUwIvohJBzGTlVGuVyH8nXDx1AM34rczAj7nplGzc6qiHtykLtSevkcFAo6yzWGXnoSIjSMb1U6mNbK0WZHvez1eFjRA+LZjfoQiqS6Hj/PlqCDbDZb1NUJm/TPLZf2U/HaUi5zfdYsTcDqmPqpX4MKwP5uzEoav1tNnvvv2VJtWNceAR1YhHkYEu4JnmaKijKGlYeWN4FMLbVGudDzfP9ltCcTNEqbwhFPahfag55XsiNdevQqGkKQM6BcAJbtvrKWyol0d1RgAKWSv+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:38:05 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:38:05 +0000
From: =?UTF-8?q?Pi=C3=B3rkowski=2C=20Piotr?= <piotr.piorkowski@intel.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>
Subject: [RFC PATCH 3/4] vfio/pci: Allow configuring hidden BAR ranges through configfs
Date: Thu, 5 Nov 2026 16:37:37 +0100
Message-ID: <20261105153738.1938345-4-piotr.piorkowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) To PH8PR11MB8039.namprd11.prod.outlook.com
 (2603:10b6:510:25f::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8039:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1bfb7f-758a-4b3d-d0dd-08df3b52c886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|6133799003|22082099003|56012099006|5023799004|11063799006|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: yOU780nOB4+2rJteoryKS9xB18qwu9HEFMMeT4yQaTMJ2tNjwQ9Iw+qfjwXtVb5zUCR19ZFp7W2Qo+QJViXLl/8A/oFwpAxq43SesYX1EBh/oDT+6U9Y+slyxYo1jB0PPC/kl0ixM/PmmMAiNobOhpNaDfu0kxKLJlhLq8Vprj3a4vD65ZDJ9l0jvxE7pdourwUWAgIPor8OerHkbx7FJGwv2EcO6UdYcPnpD/LA3tkUGiO4i5Fq+IRYrlCaXwrrQ1fg5h6aIFjtlHMRwz998BDIU0QwKtbdV7JvoZuLC5nuPWneRZ7QhchkLoNJT87mOn6bFnDpuTDcDkohm2H/zDBJNiFFZ+OVpptFBrgiX6cYbEsD8e6k53oJ0uCG57aGriVwbsDoVlpwGTrYc2jsx7FDQ4jBO0h8Iqi5pj63lHj/jpIPIeIrNYcG88lsMwbw2iaEYlf5yfiFh3XDlJDG3MLh5DkQoT8EWrWbCukSHWnLX2FF315G/2MYoReI3hadHwfh5GGSJOZiqE4Mj3jdU7p3F16HHYwl+ZOgh1gVfM90jOpDr3b8KQCALrXW3hi7nIkejy+jG8Pj1RDLFk47075YSaQ9xc/S667kfJx/HK6TcPZq0IkCGiiHqVlgMsqcb6zvb7em4PaxC8F0PIS9jyWuSl2D4nW2eBqOhiOSgFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(6133799003)(22082099003)(56012099006)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtjY0laMEpnSG1zbFYxcHhlRWplNlY0THhQOGV0Uldzd3o1WURacjcrMjcv?=
 =?utf-8?B?a3RGNS9DVENJVWdjTnZaZEdPcndSaWpCTUFHMVZINHF2bXhtVHVWTnpPYTZk?=
 =?utf-8?B?UGp4NERRUmkreU5nOFRSWGlSdXc3eWVibng4QmZPNnArYUpsSzFndWdzdWZT?=
 =?utf-8?B?eEs3aGtJSkhQZ0wzTG1SU045NjVaUWt1NHg2MTByWlBjMmJxRnR0aVViMUkz?=
 =?utf-8?B?MzlUT1ZYekk5Z1lmMFZPQ0JocEdMdEZjclUxWmk0anU4TFZlK2VwM3VRZC81?=
 =?utf-8?B?SEtkNS9sUFJhUk5sUHNNTHRtbDkxYndoWTNxcnBkazdWSzFKS1RZa0piK1dZ?=
 =?utf-8?B?TEc2MG90UDBTeFM1Y2R3azRsdE9hZUNRSkVuRW55bjBNTDdockUwOEhzWGNo?=
 =?utf-8?B?M2lzOXBYa0U3Ny9nOGpaUFRBTHgzdFpGd1RVMlFhRlB3UlRaR1ltNERaSnNP?=
 =?utf-8?B?UVFXUkJTeVlaL3A4N0FZaU9hUlBqRlZQaDFiZVJHTUczVU9DNk5OejQxV1dW?=
 =?utf-8?B?bVdDR2ZENnNDdTRnVmF0SjBraTU2RHppdzRIbWN3ejFQUzBPSUUvTlp6NFBt?=
 =?utf-8?B?bnp0NXBWQWJJM3h6d1RVZEJhb2ZCejdiSGZkVmN0blpOVVQ3M1g3ZGc5Yi84?=
 =?utf-8?B?RDRBQVQ3K0FNenNQUm5DR1NNUStpZzAyRjlhS3RiL2l2YnFUUEFtYVJUVkRH?=
 =?utf-8?B?OGtNRVF4d3I4WFcvVitiV0E2SHRyNm4xbURKV0lrdzRWaTVlelBiODFkMnZG?=
 =?utf-8?B?MHlJZ2wxR3YxaGliak8rUk5wbVVXWTViYWtZUGMwTS9HWFN6V1J1Z2tpSjZV?=
 =?utf-8?B?MGVGV1lZQlZTSVRFMmJNTHYwOFRGUkZTVEpqb3hCLzR5Y0h5MzJ5WHZmZjJG?=
 =?utf-8?B?c1RUOVJZNWtReVVTc2lhbjB6YVpRbVFaV1FsdkZuZHI2cW9zd3grOXpjNzF4?=
 =?utf-8?B?c3pmTzlVbHpzcTVYZWZodTV5YnF5OERwYUI4Z1RhSkZSbUpGc0U3ZGFaRUJ3?=
 =?utf-8?B?czNNNk5qTDlPamN5NEY3RDA2ejU2WjdEMVBXeEZYczhhcXJKUjJDSXdqaVAy?=
 =?utf-8?B?THFZNVpuUWJ2Q2pBVnNuTFBndktWOXVNOXVKbUV2cVRFSXRYVW5RY1FGcGhI?=
 =?utf-8?B?Wk1FdmxyMEpTWXc5R09vWUFIdXp5M1VFa1R5bXdMcGdyUXNma3BXaDNjOGxl?=
 =?utf-8?B?Qzlzak92WkpvL3JiQnZsMWlTemtrVXFVOEd3bHB0em9mb3ViM0pLL2JvRUI1?=
 =?utf-8?B?UytTRGFBR3dRMTFZcHBoWjFIYmRWL1NoWnFzWW5Uc1dyb09CV3RPMVZla0tL?=
 =?utf-8?B?Uy96ZEx1MW5NdWdydm1vTjg0OFp2MGpRQUZUTDBYaXhGZzlNS2FKQm5KTVRn?=
 =?utf-8?B?UVN3RVNKR1h5SUY4Rm85c0JtNGJVbWdidlRnLzFEZWQ0cllnd0JPaDdGTk00?=
 =?utf-8?B?TlVyb0NtMXNEd0d0NVdQbzBIYTdPYzVYbGk2TDRjWEZCQ1FpRTBKcGVpRkxE?=
 =?utf-8?B?R09IaHExREptWFB5VXZkWHREOWdpbE1LSlFjU3lJVDFzNm4rWkh3RWJocGlx?=
 =?utf-8?B?ai81VDQ5MHZVMklFOGFNenpmUUpEN3luR2E2VDZKSjBrMGdCREROV0UrcVhj?=
 =?utf-8?B?WjFuL3hFK2hRUmJDN2ZEdGloV3RFNjBZbjdLMTRQV1FGam9vaTFCS3BjZ3M4?=
 =?utf-8?B?S1JrejZvNUtqNVZGMzJERGxtVnY2ZnFhZCtPMkJzbzRKd1U1enNlT1pMWlBH?=
 =?utf-8?B?cHplSnZyV3FUMUU1ZElaS0YzNFlINTNRSVlPeTJVak4rTExFemdVcjFRWStK?=
 =?utf-8?B?ZnNRMENBdzZ3ZmkzSFI2bHR0VUJyVk5zUzV3c05ZNjNpUEwySnVvQWxNcVI2?=
 =?utf-8?B?SDEvSVVxMDkwQXc1SHU1SmN1S09LQ0tqTitEakFqdXhMa0ZHMzFCSm1jdDln?=
 =?utf-8?B?TU9FZ0RTd2J4OEFoLzU0eFhYM29oazU4SmpsRTR3ZDVjR1c4VXlsTmQ3L2Ru?=
 =?utf-8?B?ZUhGQmh0c1hvbnhGdzN2b2pOVGdPNXhRWUpyNzN4bHllWFVxbE9NTnNPR3dy?=
 =?utf-8?B?c2NlNi9hQVpXZVBXY09oeXZsQ244cnQvY2IvZWxwSEg4RVFCS2UzWGpETmxB?=
 =?utf-8?B?S1lpYTdkdDQ0UGFEUHZjaWsyVDQ1T3gvb2F5dGVRZmVwR0RmRlFIRndCb1VB?=
 =?utf-8?B?RDdYeTIwVzdFTEM5YUEwT0tvSEJuZldkelVwUzlUa0QxeXAzbzNlYk1VVHlT?=
 =?utf-8?B?TzR3c2lWUWJQbkk0NFJaNCtmRllCeGlTbzliMk0xaEpVeHdPM2RLM1BQV0Fn?=
 =?utf-8?B?UzRzcDBzd2RHNGZ0Nzd1QzhSaTYzb2E0QXRZUCtRQjBJQlFEWnI1b2psb1Ew?=
 =?utf-8?Q?KqHzTe2EBKMs3Ywc=3D?=
X-Exchange-RoutingPolicyChecked: E2SH/t8MSH34sp/LA95kg+4UAX3R3UDn/NyHulKV63FJVk9alUo+Iw3Vt0IBEeB1M0Idj7NkeuKxr60hKLQndrPIQMZkonks10PcN4YKOVBoJUbG4kJ4h1aYFOwt3s8FUkPHC3kvWGaOrh5X0sLzR9IiTdIk0YGWGmNDscQ6diHeNqDThGuzGu94I7rlb3tMFbEW4TvJnzuFvKDHZcLW+jfoztWbeC7MmKWpsUOuy0nhTm5f0Wnxc7w4Cdh85z6gnum+zlvTYIRnjPFK7RX5MJjh/VyQW1ul5BuPK2RKGcx2NkAmoQRh9izZB9jIle0EDSacdu9Mwm+1idZIazIUcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1bfb7f-758a-4b3d-d0dd-08df3b52c886
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:38:04.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bOekXjYVoFjQFFD+joZltcfp403pI0IeIVesvI5OLwKVMIOC7R3f34gSU5JUCKqz78U2EFwnmR0rnCREekuszw0TBQemQUB+p0jqCwgIEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

Let the host administrator hide BAR ranges through
/sys/kernel/config/vfio-pci/<device>/. The ranges are applied when the
device is bound, on top of the ones hidden by the driver.

The configuration is locked while the device is bound, so it always
matches what is actually hidden. Any change fails with -EBUSY until the
device is unbound.

If ranges are configured but the driver can't hide them, binding fails
instead of silently exposing them. vfio-pci opts in.

The configfs interface is optional, behind CONFIG_VFIO_PCI_CONFIGFS.

Cc: Alex Williamson <alex@shazbot.org>
Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
---
 Documentation/ABI/testing/configfs-vfio-pci   |  49 +++
 drivers/vfio/pci/Kconfig                      |  13 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |   1 +
 drivers/vfio/pci/vfio_pci_configfs.c          | 312 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c              |  20 +-
 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c |  50 ++-
 drivers/vfio/pci/vfio_pci_priv.h              |  36 ++
 include/linux/vfio_pci_core.h                 |   4 +
 9 files changed, 472 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-vfio-pci
 create mode 100644 drivers/vfio/pci/vfio_pci_configfs.c

diff --git a/Documentation/ABI/testing/configfs-vfio-pci b/Documentation/ABI/testing/configfs-vfio-pci
new file mode 100644
index 0000000000000..fe565cb88f2c8
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-vfio-pci
@@ -0,0 +1,49 @@
+What:		/sys/kernel/config/vfio-pci/<device>/
+Date:		November 2026
+Contact:	kvm@vger.kernel.org
+Description:
+		Configuration of a PCI device applied when it is bound to
+		vfio-pci or to a vfio-pci variant driver. The directory name
+		is the canonical name of the PCI device, as in
+		/sys/bus/pci/devices/, e.g. 0000:03:00.1. It can be created
+		before the device exists, e.g. for a VF before SR-IOV is
+		enabled. The configuration is applied when the device is
+		bound and can't change until it is unbound: creating and
+		removing the directory and writing hide_bar_range and
+		unhide_bar_range fail with EBUSY while the device is bound.
+		Available if CONFIG_VFIO_PCI_CONFIGFS is enabled.
+
+What:		/sys/kernel/config/vfio-pci/<device>/hide_bar_range
+Date:		November 2026
+Contact:	kvm@vger.kernel.org
+Description:
+		(WO) Adds a range of a memory BAR to hide from the VFIO user,
+		written as "<bar>:<offset>:<size>", where <bar> is the decimal
+		BAR index and <offset> and <size> are hexadecimal values with
+		an optional 0x prefix. The range must not overlap the ranges
+		already added, at most 16 ranges can be added. The accesses
+		crossing the boundaries of the range are split, so it should
+		match the access granularity of the device, e.g. its register
+		width. Whether the range fits into a memory BAR of the device
+		is checked when the device is bound, which fails if it
+		doesn't. Binding also fails if the driver of the device
+		accesses its memory BARs in ways which can't hide the ranges,
+		e.g. a vfio-pci variant driver with its own BAR accesses. The
+		ranges are merged with the ones hidden by the driver of the
+		device, see
+		/sys/.../<device>/vfio-dev/vfioX/hidden_bar_ranges.
+
+What:		/sys/kernel/config/vfio-pci/<device>/unhide_bar_range
+Date:		November 2026
+Contact:	kvm@vger.kernel.org
+Description:
+		(WO) Removes a range added through hide_bar_range, written in
+		the same format, which must match the added range exactly.
+
+What:		/sys/kernel/config/vfio-pci/<device>/hidden_bar_ranges
+Date:		November 2026
+Contact:	kvm@vger.kernel.org
+Description:
+		(RO) Lists the ranges added through hide_bar_range, one per
+		line as "<bar>:<offset>:<size>", with <offset> and <size>
+		prefixed with 0x.
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185ec..78793b9ea50e3 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -7,6 +7,19 @@ config VFIO_PCI_CORE
 	select VFIO_VIRQFD
 	select IRQ_BYPASS_MANAGER
 
+config VFIO_PCI_CONFIGFS
+	bool "VFIO PCI configuration through configfs"
+	depends on VFIO_PCI_CORE
+	select CONFIGFS_FS
+	help
+	  Let the host administrator configure PCI devices before they are
+	  bound to vfio-pci or to a vfio-pci variant driver, through
+	  /sys/kernel/config/vfio-pci/<device>/. The configuration allows
+	  hiding BAR ranges of a device from the VFIO user, in addition to
+	  the ones hidden by its driver.
+
+	  If you don't know what to do here, say N.
+
 config VFIO_PCI_INTX
 	def_bool y if !S390
 	depends on VFIO_PCI_CORE
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index be3bf15505c3b..51026d23beb02 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -4,6 +4,7 @@ vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_con
 		   vfio_pci_hidden_bar_ranges.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
+vfio-pci-core-$(CONFIG_VFIO_PCI_CONFIGFS) += vfio_pci_configfs.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe912..18a2f9e0f6dc4 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -188,6 +188,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_set_drvdata(&pdev->dev, vdev);
 	vdev->pci_ops = &vfio_pci_dev_ops;
+	vdev->hidden_ranges_supported = true;
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
 		goto out_put_vdev;
diff --git a/drivers/vfio/pci/vfio_pci_configfs.c b/drivers/vfio/pci/vfio_pci_configfs.c
new file mode 100644
index 0000000000000..39de90ac23411
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_configfs.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO PCI configuration through configfs
+ *
+ * The host administrator can hide BAR ranges of a device, in addition to the
+ * ones hidden by its driver, through /sys/kernel/config/vfio-pci/<device>/.
+ */
+
+#include <linux/configfs.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "vfio_pci_priv.h"
+
+/*
+ * Parse a "<bar>:<offset>:<size>" range, where the BAR index is decimal and
+ * the offset and the size are hexadecimal, with an optional 0x prefix.
+ */
+static int vfio_pci_parse_bar_range(const char *str,
+				    struct vfio_pci_bar_range *range)
+{
+	char *buf __free(kfree) = kstrdup(str, GFP_KERNEL);
+	char *cur, *bar, *offset;
+
+	if (!buf)
+		return -ENOMEM;
+
+	cur = strim(buf);
+	bar = strsep(&cur, ":");
+	offset = strsep(&cur, ":");
+
+	if (!cur || kstrtouint(bar, 10, &range->bar) ||
+	    kstrtou64(offset, 16, &range->offset) ||
+	    kstrtou64(cur, 16, &range->size))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Ranges hidden when a device is registered, configured in a configfs
+ * directory named after the PCI device, which can be created before the
+ * device exists, e.g. for a VF before SR-IOV is enabled. The configuration
+ * can't change while the device is bound, so that it always matches the
+ * ranges hidden on a bound device.
+ */
+struct vfio_pci_configfs_device {
+	struct config_group group;
+	/* protects the ranges and bound */
+	struct mutex lock;
+	struct vfio_pci_bar_range hidden_ranges[VFIO_PCI_MAX_HIDDEN_BAR_RANGES];
+	unsigned int num_hidden_ranges;
+	/* the device is bound and pins the directory */
+	bool bound;
+};
+
+/* the devices bound to a VFIO driver, protected by the subsystem su_mutex */
+static LIST_HEAD(vfio_pci_configfs_bound);
+
+static struct vfio_pci_configfs_device *
+to_vfio_pci_configfs_device(struct config_item *item)
+{
+	return container_of(to_config_group(item),
+			    struct vfio_pci_configfs_device, group);
+}
+
+static ssize_t vfio_pci_configfs_hidden_bar_ranges_show(struct config_item *item,
+							char *page)
+{
+	struct vfio_pci_configfs_device *cfg = to_vfio_pci_configfs_device(item);
+
+	guard(mutex)(&cfg->lock);
+
+	return vfio_pci_show_bar_ranges(cfg->hidden_ranges,
+					cfg->num_hidden_ranges, page);
+}
+
+static ssize_t vfio_pci_configfs_store_bar_range(struct config_item *item,
+						 const char *page, size_t len,
+						 bool hide)
+{
+	struct vfio_pci_configfs_device *cfg = to_vfio_pci_configfs_device(item);
+	struct vfio_pci_bar_range range;
+	int ret;
+
+	ret = vfio_pci_parse_bar_range(page, &range);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&cfg->lock);
+
+	if (cfg->bound)
+		return -EBUSY;
+
+	if (hide)
+		ret = vfio_pci_add_bar_range(cfg->hidden_ranges,
+					     &cfg->num_hidden_ranges, &range);
+	else
+		ret = vfio_pci_del_bar_range(cfg->hidden_ranges,
+					     &cfg->num_hidden_ranges, &range);
+
+	return ret ?: len;
+}
+
+static ssize_t vfio_pci_configfs_hide_bar_range_store(struct config_item *item,
+						      const char *page, size_t len)
+{
+	return vfio_pci_configfs_store_bar_range(item, page, len, true);
+}
+
+static ssize_t vfio_pci_configfs_unhide_bar_range_store(struct config_item *item,
+							const char *page, size_t len)
+{
+	return vfio_pci_configfs_store_bar_range(item, page, len, false);
+}
+
+CONFIGFS_ATTR_RO(vfio_pci_configfs_, hidden_bar_ranges);
+CONFIGFS_ATTR_WO(vfio_pci_configfs_, hide_bar_range);
+CONFIGFS_ATTR_WO(vfio_pci_configfs_, unhide_bar_range);
+
+static struct configfs_attribute *vfio_pci_configfs_device_attrs[] = {
+	&vfio_pci_configfs_attr_hidden_bar_ranges,
+	&vfio_pci_configfs_attr_hide_bar_range,
+	&vfio_pci_configfs_attr_unhide_bar_range,
+	NULL
+};
+
+static void vfio_pci_configfs_device_release(struct config_item *item)
+{
+	struct vfio_pci_configfs_device *cfg = to_vfio_pci_configfs_device(item);
+
+	mutex_destroy(&cfg->lock);
+	kfree(cfg);
+}
+
+static struct configfs_item_operations vfio_pci_configfs_device_item_ops = {
+	.release = vfio_pci_configfs_device_release,
+};
+
+static const struct config_item_type vfio_pci_configfs_device_type = {
+	.ct_item_ops = &vfio_pci_configfs_device_item_ops,
+	.ct_attrs = vfio_pci_configfs_device_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+/* only the canonical name, as returned by pci_name(), is looked up */
+static int vfio_pci_configfs_check_name(const char *name)
+{
+	unsigned int domain, bus, slot, function;
+	char canonical[sizeof("ffffffff:ff:1f.7")];
+
+	if (sscanf(name, "%x:%x:%x.%x", &domain, &bus, &slot, &function) != 4 ||
+	    bus > 0xff || slot > 0x1f || function > 7)
+		return -EINVAL;
+
+	scnprintf(canonical, sizeof(canonical), "%04x:%02x:%02x.%u",
+		  domain, bus, slot, function);
+
+	return strcmp(name, canonical) ? -EINVAL : 0;
+}
+
+static struct config_group *vfio_pci_configfs_make_group(struct config_group *group,
+							 const char *name)
+{
+	struct vfio_pci_configfs_device *cfg;
+	struct vfio_pci_core_device *vdev;
+	int ret;
+
+	ret = vfio_pci_configfs_check_name(name);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(vdev, &vfio_pci_configfs_bound, configfs_node) {
+		if (!strcmp(pci_name(vdev->pdev), name))
+			return ERR_PTR(-EBUSY);
+	}
+
+	cfg = kzalloc_obj(*cfg);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&cfg->lock);
+	config_group_init_type_name(&cfg->group, name,
+				    &vfio_pci_configfs_device_type);
+
+	return &cfg->group;
+}
+
+static struct configfs_group_operations vfio_pci_configfs_group_ops = {
+	.make_group = vfio_pci_configfs_make_group,
+};
+
+static const struct config_item_type vfio_pci_configfs_type = {
+	.ct_group_ops = &vfio_pci_configfs_group_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct configfs_subsystem vfio_pci_configfs = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "vfio-pci",
+			.ci_type = &vfio_pci_configfs_type,
+		},
+	},
+};
+
+/*
+ * Hide the ranges configured for the device being bound and keep the
+ * configuration from changing, including the creation and removal of the
+ * directory, until it is unbound.
+ */
+int vfio_pci_configfs_bind(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_configfs_device *cfg;
+	struct config_item *item;
+	int ret;
+
+	scoped_guard(mutex, &vfio_pci_configfs.su_mutex) {
+		item = config_group_find_item(&vfio_pci_configfs.su_group,
+					      pci_name(vdev->pdev));
+		list_add(&vdev->configfs_node, &vfio_pci_configfs_bound);
+	}
+	if (!item)
+		return 0;
+
+	cfg = to_vfio_pci_configfs_device(item);
+
+	ret = configfs_depend_item(&vfio_pci_configfs, item);
+	if (ret) {
+		pci_err(vdev->pdev, "configfs directory being created or removed (%pe)\n",
+			ERR_PTR(ret));
+		ret = -EBUSY;
+		goto out_unbind;
+	}
+
+	scoped_guard(mutex, &cfg->lock) {
+		if (cfg->num_hidden_ranges && !vdev->hidden_ranges_supported) {
+			pci_err(vdev->pdev, "%s doesn't support hiding the BAR ranges configured through configfs\n",
+				vdev->vdev.ops->name);
+			ret = -EOPNOTSUPP;
+		} else {
+			ret = __vfio_pci_hide_bar_ranges(vdev, cfg->hidden_ranges,
+							 cfg->num_hidden_ranges,
+							 "configfs");
+		}
+		cfg->bound = !ret;
+	}
+	if (ret) {
+		configfs_undepend_item(item);
+		goto out_unbind;
+	}
+
+	config_item_put(item);
+
+	return 0;
+
+out_unbind:
+	config_item_put(item);
+	scoped_guard(mutex, &vfio_pci_configfs.su_mutex)
+		list_del(&vdev->configfs_node);
+
+	return ret;
+}
+
+void vfio_pci_configfs_unbind(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_configfs_device *cfg;
+	struct config_item *item;
+	bool pinned;
+
+	scoped_guard(mutex, &vfio_pci_configfs.su_mutex) {
+		list_del(&vdev->configfs_node);
+		item = config_group_find_item(&vfio_pci_configfs.su_group,
+					      pci_name(vdev->pdev));
+	}
+	if (!item)
+		return;
+
+	cfg = to_vfio_pci_configfs_device(item);
+
+	scoped_guard(mutex, &cfg->lock) {
+		pinned = cfg->bound;
+		cfg->bound = false;
+	}
+	if (pinned)
+		configfs_undepend_item(item);
+
+	config_item_put(item);
+}
+
+int vfio_pci_configfs_init(void)
+{
+	int ret;
+
+	config_group_init(&vfio_pci_configfs.su_group);
+	mutex_init(&vfio_pci_configfs.su_mutex);
+
+	ret = configfs_register_subsystem(&vfio_pci_configfs);
+	if (ret)
+		mutex_destroy(&vfio_pci_configfs.su_mutex);
+
+	return ret;
+}
+
+void vfio_pci_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&vfio_pci_configfs);
+	mutex_destroy(&vfio_pci_configfs.su_mutex);
+}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index cd6cb3d829b51..e32428a07583f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2275,6 +2275,10 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_vf;
 
+	ret = vfio_pci_configfs_bind(vdev);
+	if (ret)
+		goto out_vga;
+
 	vfio_pci_probe_power_state(vdev);
 
 	/*
@@ -2310,6 +2314,8 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_configfs_unbind(vdev);
+out_vga:
 	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
@@ -2323,6 +2329,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 
 	vfio_unregister_group_dev(&vdev->vdev);
 
+	vfio_pci_configfs_unbind(vdev);
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
@@ -2667,14 +2674,25 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 
 static void vfio_pci_core_cleanup(void)
 {
+	vfio_pci_configfs_exit();
 	vfio_pci_uninit_perm_bits();
 	rcu_barrier();
 }
 
 static int __init vfio_pci_core_init(void)
 {
+	int ret;
+
 	/* Allocate shared config space permission data used by all devices */
-	return vfio_pci_init_perm_bits();
+	ret = vfio_pci_init_perm_bits();
+	if (ret)
+		return ret;
+
+	ret = vfio_pci_configfs_init();
+	if (ret)
+		vfio_pci_uninit_perm_bits();
+
+	return ret;
 }
 
 module_init(vfio_pci_core_init);
diff --git a/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c b/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
index 666820dc24080..dd8418aa81305 100644
--- a/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
+++ b/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
@@ -8,6 +8,10 @@
  * reads of them are filled with ones and writes to them are dropped, the
  * pages containing them are never mapped, and neither ioeventfds nor
  * dma-bufs may cover them.
+ *
+ * The ranges are hidden by the driver of the device and the host
+ * administrator can hide more of them through configfs, see
+ * vfio_pci_configfs.c.
  */
 
 #include <linux/device.h>
@@ -54,9 +58,9 @@ static int vfio_pci_check_bar_range(const struct vfio_pci_bar_range *range)
 	return 0;
 }
 
-static int vfio_pci_add_bar_range(struct vfio_pci_bar_range *ranges,
-				  unsigned int *num,
-				  const struct vfio_pci_bar_range *range)
+int vfio_pci_add_bar_range(struct vfio_pci_bar_range *ranges,
+			   unsigned int *num,
+			   const struct vfio_pci_bar_range *range)
 {
 	unsigned int i;
 	int ret;
@@ -96,8 +100,8 @@ static void vfio_pci_remove_bar_range(struct vfio_pci_bar_range *ranges,
 	(*num)--;
 }
 
-static ssize_t vfio_pci_show_bar_ranges(const struct vfio_pci_bar_range *ranges,
-					unsigned int num, char *buf)
+ssize_t vfio_pci_show_bar_ranges(const struct vfio_pci_bar_range *ranges,
+				 unsigned int num, char *buf)
 {
 	unsigned int i;
 	ssize_t len = 0;
@@ -149,9 +153,9 @@ static int vfio_pci_hide_bar_range(struct vfio_pci_core_device *vdev,
 				      &vdev->num_hidden_ranges, &merged);
 }
 
-static int __vfio_pci_hide_bar_ranges(struct vfio_pci_core_device *vdev,
-				      const struct vfio_pci_bar_range *ranges,
-				      unsigned int num, const char *source)
+int __vfio_pci_hide_bar_ranges(struct vfio_pci_core_device *vdev,
+			       const struct vfio_pci_bar_range *ranges,
+			       unsigned int num, const char *source)
 {
 	unsigned int i;
 	int ret;
@@ -176,11 +180,13 @@ static int __vfio_pci_hide_bar_ranges(struct vfio_pci_core_device *vdev,
  * @num: number of entries in @ranges
  *
  * Must be called before vfio_pci_core_register_device(), so that the ranges
- * are hidden before the device can be opened. The ranges are hidden by the
- * accesses done through vfio-pci-core: region reads and writes, region infos,
- * mmaps, ioeventfds and dma-bufs. The driver must declare that it doesn't
- * access its memory BARs in any other way by setting
- * &vfio_pci_core_device.hidden_ranges_supported first.
+ * are hidden before the device can be opened. The ranges configured by the
+ * host administrator through configfs, if CONFIG_VFIO_PCI_CONFIGFS is enabled,
+ * are hidden by vfio_pci_core_register_device() after the ones of the driver.
+ * The ranges are hidden by the accesses done through vfio-pci-core: region
+ * reads and writes, region infos, mmaps, ioeventfds and dma-bufs. The driver
+ * must declare that it doesn't access its memory BARs in any other way by
+ * setting &vfio_pci_core_device.hidden_ranges_supported first.
  *
  * The accesses crossing the boundaries of a hidden range are split, so the
  * range should match the access granularity of the device, e.g. its register
@@ -287,3 +293,21 @@ const struct attribute_group *vfio_pci_hidden_bar_ranges_groups[] = {
 	&vfio_pci_hidden_bar_ranges_group,
 	NULL
 };
+
+int vfio_pci_del_bar_range(struct vfio_pci_bar_range *ranges,
+			   unsigned int *num,
+			   const struct vfio_pci_bar_range *range)
+{
+	unsigned int i;
+
+	for (i = 0; i < *num; i++) {
+		if (ranges[i].bar == range->bar &&
+		    ranges[i].offset == range->offset &&
+		    ranges[i].size == range->size) {
+			vfio_pci_remove_bar_range(ranges, num, i);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index a3d42a37176de..6632a0eccbe4d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -60,6 +60,42 @@ int vfio_pci_hidden_add_sparse_mmap(struct vfio_pci_core_device *vdev,
 				    struct vfio_region_info *info,
 				    struct vfio_info_cap *caps);
 extern const struct attribute_group *vfio_pci_hidden_bar_ranges_groups[];
+int vfio_pci_add_bar_range(struct vfio_pci_bar_range *ranges,
+			   unsigned int *num,
+			   const struct vfio_pci_bar_range *range);
+int vfio_pci_del_bar_range(struct vfio_pci_bar_range *ranges,
+			   unsigned int *num,
+			   const struct vfio_pci_bar_range *range);
+ssize_t vfio_pci_show_bar_ranges(const struct vfio_pci_bar_range *ranges,
+				 unsigned int num, char *buf);
+int __vfio_pci_hide_bar_ranges(struct vfio_pci_core_device *vdev,
+			       const struct vfio_pci_bar_range *ranges,
+			       unsigned int num, const char *source);
+
+#ifdef CONFIG_VFIO_PCI_CONFIGFS
+int vfio_pci_configfs_bind(struct vfio_pci_core_device *vdev);
+void vfio_pci_configfs_unbind(struct vfio_pci_core_device *vdev);
+int vfio_pci_configfs_init(void);
+void vfio_pci_configfs_exit(void);
+#else
+static inline int vfio_pci_configfs_bind(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+static inline void vfio_pci_configfs_unbind(struct vfio_pci_core_device *vdev)
+{
+}
+
+static inline int vfio_pci_configfs_init(void)
+{
+	return 0;
+}
+
+static inline void vfio_pci_configfs_exit(void)
+{
+}
+#endif
 
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 3745911fb2f1f..8bc5140958ce6 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -177,6 +177,10 @@ struct vfio_pci_core_device {
 	 * BAR ranges.
 	 */
 	bool			hidden_ranges_supported;
+#ifdef CONFIG_VFIO_PCI_CONFIGFS
+	/* in the list of the bound devices, whose configfs can't change */
+	struct list_head	configfs_node;
+#endif
 };
 
 enum vfio_pci_io_width {
-- 
2.34.1

