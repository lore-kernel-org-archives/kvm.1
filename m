Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793893121;
	b=C6F7FB1SD0wBRTHxwoqW9v+Ws55l6VAYgzOpP765zJI3MaL6+QxSGmDUz4NZPejLJ4+G
	 we6pDiMH8QyESPdaUbSlJDsV96ARtI7gTyXFfkHOJYUI6uSe7JqR1le5CJKmK8sotfKWQ
	 SgupyZlXYoJ99HxQj6EScw2cSycl7CUE12BjAS2NBvSlwgkrEIeEwOTSFlW+KjQXgRSJg
	 uTRwJG90J+TQPucJuhk/nNOmoKRVj1XDirYrk+O0TySKzgNDam/pZvhg5od6+8tTa8CMT
	 1uLBTB1syW8W/wcJZjv5b5A+5Kq55MzEH8jQ9oJKA+2IucI9XZOVYLG0GKgdCLcAA4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893121;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=wamt4JxB4xfW8cMdUElDzeXh87t7Lk4GBxEj92PJDG0=;
	b=INRQzVIga7noQ5wzaV6hdJnwBA1/qaptOkjgnYttfqUKIJw2Z59klZAlJYEJD0z58+3A
	 dBWh1ez40e56vOeMpwExTqdh/4j1UYnZFebFONva2J4K9VI81Um4wJXBybuDlftRiSNNc
	 xuIHMr5QDUSbsskqR3qajZ/TUsrypFk/C5sz73kS7VB6GU588U5Cp3UDjnQIWEXjTEYkD
	 JTmqOrPVmh0C1JbIoeB3wSIvmYGqJFXvHpaBjSIn/i+IbH6U39a7z9lJ49nYZUjoZ/YVl
	 M8wCFJux6xy714vw8fwYhOAiLLnL1In/K4PV29/mmDK1QzWQIAYuy04GRnrXainhQuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WWQfDoOp;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB6606EEA7
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BB6606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WWQfDoOp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793893121; x=1825429121;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lS92lPvCPExlngT+v+yBJpl4KqO3Hi6GsgQ4Z0NhOjc=;
  b=WWQfDoOppepMLV/11aDRwzDjU3yVNxd0GXunzgfavDM3T7GlmW3bjFVV
   jD29aO2KClpZlzIt1yJSf1MhZsWlQ78I+F4m3+1KN3OtPkKcujhLex+wk
   6g+WWEqZZlD5Vd7kLke8oGdYiQFCYZ8pFvo3a5DUdLbXX3Ccef14+Yaoh
   Cu2masA1Mr39HtAhWb5ZN3dsTFbfTsgC5mI0QZ73WwLsKFNmZUYG6qSMU
   FYsOFMx3wTDOSPogwf94g899oczgJ9IoLfZ9pj/8ugwF+Eg6yKjO9zvTK
   zBOMbnWp+fMDjfu9qpXpX6EB5FbpMQh1KsY10SdIWT1V9gizAY3c9qwtg
   g==;
X-CSE-ConnectionGUID: dH1e21DgSiy9/jfUX1rqlw==
X-CSE-MsgGUID: pvXp0+B6RXmYnlxsC2Z2BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2719667"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2719667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:41 -0800
X-CSE-ConnectionGUID: NBMnyEUtQiWFEI9YPt3zaw==
X-CSE-MsgGUID: lfKrwOF1TJ6EFpTqbgDobA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7062150"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:39 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 07:38:39 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRMeJ7cDFBN3+hve3iMcaWUw9SyaCxjX4YNkCPHZ1lw1c4oVgwxhSFby247ySsGUNJf5aDwAsMLvlJdEeoMc5aqKY/IA57KPHK567cBF1ZFIsF/iF1+MAAS66HSKhDv0g9Jpa4H3DfVLP9cAArJsH58ktyFN4QxUhEA/v46ljnyYgyJy/UiLGS2I4mrAc2wdar9tebe9CEuUV/jlJXIVhyWd5B0NZpUAzFhMf04FYWP1ulvZ8Ncsnqf8rDdl4R2wonk8QQRxtnnuCUSObi9gP/xsqClDm/6mgk8IfVVssI19JYwBAhmKTXJTONEoKh9h6Q1Tau/zqikWFiIloAKa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wamt4JxB4xfW8cMdUElDzeXh87t7Lk4GBxEj92PJDG0=;
 b=xDy1sh64j8MWI+Xqn/cQvms9JMbO80h1zyJBnV/+BI6DXr3m302e/7IVdhYyEkpvI3pbQWULptn8HH0bw93zRUwkE5n3nMc2X+N8uB8MDXKoIRe8sKYkesFS+g/Ov+rKIJttNvC+D0nsJeuDLH9FhUYDmD1hLD0BjOxY56UaK3vZGe50xFXUliUtbraN15EK904u+ZRhYJQVW/l608iBU4JWx1BH79IGdEtqcv9gcPBuDTzaB6mr9M5Zf0YYRXQueX3+OL9axQ40DOyg7ohogr1i8mrR8w1TgQVYDNuQbuDO/EtchsIHFUJSF3oJqIR7aNq+uOlWx6zxwCL74w02Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:37:53 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:37:53 +0000
From: =?UTF-8?q?Pi=C3=B3rkowski=2C=20Piotr?= <piotr.piorkowski@intel.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>
Subject: [RFC PATCH 0/4] vfio/pci: Allow hiding BAR ranges from the VFIO user
Date: Thu, 5 Nov 2026 16:37:34 +0100
Message-ID: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::28) To PH8PR11MB8039.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5af13c9d-4c6e-4030-02f8-08df3b52c1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|6133799003|56012099006|5023799004|11063799006|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tyas3D4gP/KyG5QJ4wL5725hmjKIgpgXPHD2ruGxUoyV+eI3YGYHDeX1H4BqxgPfwXJ4EJR0ilsNEN69X00fZoNMhrVd5JNbjotzqkDfURli2GXGirWpXg48DpBqnSAhYxDpBrUvuRj0UnUJVVLYf3a4l4JXpvZV9g5Cqg6kOGBaNtpaUqlIwF+kH3ybNDWCJUPZyG0jnloNzvTbFcmRtENDH4DtUujskvjZSZig85s5O/wvXEFwwGt8M2O2TKQIiRFydp+d3xJWvHlOp/IqJ6aYSajsYMEBYREJrvmhzethr+GKjhTyTQ3v2TVqbQ3plFWjxvgqLHupU3cmnC0ONGgUTqa4dOVNO/hAaZ1g+N/PebXlMHnmDu6Sf4Ize2ZhoMj8MJTBThbfJMjWklGSUg6FC89qhTro4XtPPGLt3YFtiIws2ndNSYwRECB1APBPb9t1pv/hBJHR3aDYSocIZUaAK7TOEh35y2clZSKKaS3I0rhienWfkd4UvNfY93BYxQMlapyMASPpoeg01aOFTEoU1/9sEhsRJVHrPo/5LGukjwM6ivp4YCgGhr/nEKaI0gamS2HBtP4uNxsaPqUyNUWnG1gkqxF90wTKqgVOLaxd32vX0ojKQ/vm5bWx8zTumPOogXBbjaluerriPzBrFZqcUovwSCun3iOXAAf+1L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRqM3dsdnZhQnc4VDIyZnIrUVk0V2xvRmMwenBqQkxIdWVqVVAvSHh0RGhy?=
 =?utf-8?B?azVZRWIvbmVVUzV5UHlWd01zWnFzSndKY0w2UTlzT1dFcGNZUld6VWtNS1Vt?=
 =?utf-8?B?S0FaV0hqQWtqSjF4d0lQQzg3cHExdDVqVytyOWhOdlhaZ295M0luWStaOFly?=
 =?utf-8?B?V3lQSXRveTUrL3J5aW15dlVXTDNBaEdyTGxrV1djd0F2dEJuam00MFJkYUQ1?=
 =?utf-8?B?MHZMV3R2VGNzV3FnMnF1OWVsNWRyMEhxdUcxTTFVdU0rY1p5cFlJN1Q3M2t6?=
 =?utf-8?B?U0RkeUM5MlpiRkZnMnowQWt5N2NOYWs3TWc2eVJHOXRBRHdMdVVzSEpNWTdE?=
 =?utf-8?B?ME45SGJ5SnRkbTFxMml2S3JnUitCdkIxbVFOWmVhMU9PNVRrQTZYdG1pQXYw?=
 =?utf-8?B?OVdDTENyVXJzNDQ3WVAvSTBtcWJEUUlpT2I1dGcxWlg1QWErQnBCWm5xQXgr?=
 =?utf-8?B?ZmREWkZwc2ViMHN6Y1lEMHVlUTA5L25VTnhRZ0JjQkh6dWU5UnlJVDBYU0JC?=
 =?utf-8?B?dFp3U08yMVcxQzNlNUN1bEZJTk5nWmRwNEVVL0JJeWtLWDBuNndiaXhYUlJG?=
 =?utf-8?B?NXZIVTVDamNiK2Q5Slg2cHoyQ1MxQXVncXNIc2JZSGV6ejN0U2FER250aWVJ?=
 =?utf-8?B?WG1HY1RQVEpoaklTQlFBdi9kdjdkSUU3eUVrU2M3R1dhUmVQZnJWQ1ArSVBv?=
 =?utf-8?B?aWNFanBWc0hxaWIyN0FEVkw2ek9GamxSWFkxd2FsQUsrc2dkSGFtUnBPMUdi?=
 =?utf-8?B?ZEhDd1E0ODVCcExDa3RqU2hPN0hhWkhaYSsyUmloYkpvQUk5aW9IbzZ2ZFlO?=
 =?utf-8?B?dVhxbm9tSW9qNUFBV2xvM2tmd1NXVXZuVVZrdExVbi95R244MHduUk5MSFpH?=
 =?utf-8?B?S2NhbW9CTG9Jck12UWdCZ3BldTlaL1pJczJPMUl6RDhqYjJ0aVJid3krRDRU?=
 =?utf-8?B?ZnBLUjFYQktIZWx6bXRQUThxYmJmRFFRSXpWN0tTYW5vbFE1ZGFrN01JZUVj?=
 =?utf-8?B?T2k4cDNJTHAvZG1qNnFqQVRXQi8rRlQ1Z0NMWk43R3MwQ003akludnlZa3FM?=
 =?utf-8?B?aFpyUEpvVDRXSitxWm44OEZGTnZwb3V5MmFDZ1VnVkx1R3JTd01JTmViRUcy?=
 =?utf-8?B?ajhBWkNndlFRd2cvTnl1RjIzbWlhZkhZV3NJT1p5aEhtMHlYZnhDandJd1BL?=
 =?utf-8?B?bTI1UVplbEJjVnhHM2ZPVUxHOUE1RVNtcVJxU3U1SVFwd0c3VUFES0Z2azNL?=
 =?utf-8?B?Nm9WNEtKQTJwNzZjV09HKzh0UUw1Q2FMU2pzMDZSNWd1c0xCN1EzNklqcVFi?=
 =?utf-8?B?TXpRTjVxZ1pMWGFJZmVjNU12UVdtRkRLN20vMk1icm85MnkvNTZ1ano4VWZE?=
 =?utf-8?B?dVZpOXlTRlhtY3VBWHZFdGJ2cHBKcmNOU3h6NkphRnh3aENFRkt0TGFzQVZu?=
 =?utf-8?B?SGFYVjFub0UxNmdjTjE5T1VCNWJvV2RqUGprQzNwd2gzbGhmN3o5NUdiM1g1?=
 =?utf-8?B?TnYrblFhd0FBbTBsaFVETFZSOENxa3lhbXRVaklpZDBkaXk1Q2FaVlYyZkdk?=
 =?utf-8?B?NjU0aU5FeHFvRlRsQXpvL1VDMnZiMmRpUU5kMXRrZHlSOXVOdzR2WDFPSUlP?=
 =?utf-8?B?OFBVY3NsV0RYczNwM3F4UlVmUFRCRzFlVUpTMyt1b1pFMVRIWWI1eVZBS1lm?=
 =?utf-8?B?L2RxY2ZRZTMwc21ZWU1Ua2ZFUjZTUm96RW1kYWMyMG5RVEVLRExKeGs1eFB5?=
 =?utf-8?B?dzE1UDRBZ0V6ellQOXp6TUp2bVNNMnMyVlBSZXlKZWRvSHRUcXlSYlFydW80?=
 =?utf-8?B?RjdtMkhEUEJQM2xXVGF3cURPazloOHFqeUszRFd3eFlYZVZ6ek45TzRmZTRF?=
 =?utf-8?B?Rmg4ZWdBNjJqZ3hxb0NDYTBCTm9ZZVAySWE0SXNjbVY1b3hIT3R3YURHS1VE?=
 =?utf-8?B?RWZHcFlqbWI2Y0tZeVRzRndzUmpyTkRhVE1nRFNGMzU3S0ptWEd6ZktBN21x?=
 =?utf-8?B?UThIRFVMVi91NCtNN0VzUFR2UzhHVERiZWVLdVZBK0w5Y0IycnBUMTFMQWVk?=
 =?utf-8?B?bUpFTC9ZY0dZdGd2ZzFxSmtLb21iTWZQbDJmQ3cxVmVzK3FHQ3hYS2xQOFpt?=
 =?utf-8?B?L1UzMTJwMkJQeXVMYTgxbDRrM0xPd0ZjWlkybVZ6MktLKy8wYktsY1JRWWZX?=
 =?utf-8?B?LytRSEZ1VFNtaWtWZFk0cDAxYnRQQjNtYVNJL1E4UnNmYk5JZDJSRnpibUpl?=
 =?utf-8?B?R3FqTmxRK2FpdzE3dFUweUJqNVpoTWRVRVpxT2RwZ1o0aHk0bi9YS1U4d2Z4?=
 =?utf-8?B?NUVWQklnbDhyZXB3WkoxQXFoY0ZJMnMwWXgrUGZOOXI0WFRjb0hIZFVnSE5y?=
 =?utf-8?Q?zAehHliH91o1v/Lk=3D?=
X-Exchange-RoutingPolicyChecked: CN7MNznFnbmY7eARDfmoxSBcfK2g500RteplgrAUNSboB2o4II67axy9+0IHKEwoD12NidnpNI4QsKcSi8vF6U5nDRK9ohLorR3POiFgh/Eb+8Rj8tFkb142HYveQ56wN58IPgp2LxQ8gUSfB56wB1X1Kt5igD84lAavLFe1wtGyMrq7O7vEYOong5kqV/xQkaZq5gF1ydVt1TG0gLWgi8P6Fuzji/Pr7lMBzTETdN3s3F2DcvG4KYtEeOXhL3A/+vT4f91ZEzbUsx3Gq2Rq0Xa4nSwbj3TRn+E8mehSfqt/WhQD3414m0zgG6Ywb2cAW7O9A1+x1tNc6dTKeCK9rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af13c9d-4c6e-4030-02f8-08df3b52c1a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:37:53.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmipuH6nvYLwNWOqHpX5C1NS9qMJlLwbhNzN5fbxiXzWFZu766MmItL89SfpnO7qhaMM9Aff8D6CExOH38493HGWtqwDifu0uZmzcLbdH/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

Some devices have BAR ranges which shouldn't be exposed to the VFIO
user, but vfio-pci exposes the memory BARs as a whole, apart from the
MSI-X table.

This series lets the host hide ranges of the memory BARs. Reads of a
hidden range return ones, writes to it are dropped, the pages containing
it are never mapped (a sparse mmap capability advertises the rest of the
BAR), and ioeventfds and dma-bufs covering it are rejected. The ranges
are fixed while the device is bound and listed in
/sys/.../vfio-dev/vfioX/hidden_bar_ranges.

The ranges can be hidden by the driver, with
vfio_pci_core_hide_bar_ranges(), and by the host administrator, through
configfs (CONFIG_VFIO_PCI_CONFIGFS). Only drivers which access their
BARs exclusively through vfio-pci-core can hide ranges; vfio-pci and
xe-vfio-pci declare it.

Patch 1 is a preparatory refactor, patch 2 adds the core mechanism,
patch 3 the configfs interface and patch 4 per-device-ID defaults in
xe-vfio-pci, with no ranges defined yet.

Sent as RFC for feedback on the approach and the interfaces.

Piotr Piórkowski (4):
  vfio/pci: Move the excluded range handling out of
    vfio_pci_core_do_io_rw()
  vfio/pci: Allow hiding BAR ranges from the VFIO user
  vfio/pci: Allow configuring hidden BAR ranges through configfs
  vfio/xe: Hide BAR ranges by default per device ID

 Documentation/ABI/testing/configfs-vfio-pci   |  49 +++
 .../ABI/testing/sysfs-devices-vfio-dev        |  13 +
 drivers/vfio/pci/Kconfig                      |  13 +
 drivers/vfio/pci/Makefile                     |   4 +-
 drivers/vfio/pci/nvgrace-gpu/main.c           |   4 +-
 drivers/vfio/pci/vfio_pci.c                   |   1 +
 drivers/vfio/pci/vfio_pci_configfs.c          | 312 +++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c              |  42 ++-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  11 +
 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c | 313 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  53 +++
 drivers/vfio/pci/vfio_pci_rdwr.c              | 156 +++++++--
 drivers/vfio/pci/xe/main.c                    |  60 +++-
 include/linux/vfio_pci_core.h                 |  36 +-
 14 files changed, 1009 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-vfio-pci
 create mode 100644 drivers/vfio/pci/vfio_pci_configfs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c

-- 
2.34.1

