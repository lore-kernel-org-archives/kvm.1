Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608869;
	b=XwXzqWyqzrcDr/ZQWNQXcab3zRQWgy/gxnFkGkMhlsyH8EWFJVN3QMFOudY5FVgLP4xW
	 QErOhTSkVGCAdprXzwWVweEFHworGjfLpTNqVj6Rsu7MmE6cevAIj28se4tUAAEgQZ46v
	 hreLKm//SDnF7nqv/BOHH2Rx7CJnczUMW6d8OTxTGXz1I7kIqS8pvYHgGgWn0D/xt3dWs
	 xF27o8yPSrCyhsAdGfRipPjiiO8LosSRaqHB61st3K2iEFyrO1i8pBvpd3R7Vbe2VPly7
	 SsnMhWRBU6UmsFWJjdKPNJdQkct2mbCEZqvZQNT0L4qJOgKEOqRv5PqSq4PHzPLoeRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608869;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1XS4TBX22Wq7DrXyVbXbZ/vfmb44cbmb6rjqZjGyhBs=;
	b=nIczbfc9/QkYvjQ4l/3CQ9bM3+u/udpVOEKwWXUn77uOU0iEHPaLwFw/8lM40Nv3Qlo+
	 COqLb9tby+moXd8gm/PKr+wJWWWAXDZgzrHReWVwE3jPrqZoam7nwlZzkVerwTSiYoZFV
	 KZPTtb+bVEZp/p16ZTMTAmKl4I2Cb4tDC/08We/HnJLubQzDnbs/0Ek3bKkVRy7Ltie9d
	 oR8b8Cvur/RJblABg2/6bw6uofjsR593G3QMXYLkMLFkMfyV7HcfFrH6sNol9iVpb63MH
	 N9y99I4t05DHYJDeybkB7NyfsFoqwwdU7b9awyAzUP78RghsoGfgaZLENIYq3mSiZiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TbA823So;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=M316m5yT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DA606A323;
	Wed, 25 Nov 2026 12:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27DA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TbA823So;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=M316m5yT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795608864; x=1827144864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z3CEGbvNVc02DmiONH5jl9Bsglkp/Q+3WiK1mi/zEWM=;
  b=TbA823SocqVk3jNZbJfAP9wx1Al3vnsPojp80jNNDm5aLdp68owCqi9w
   dTWQT5TxowQpVy4D4q1yWwpaG1BMPgVD+qPHaOT/S7iecKx8qKiOLhfTh
   GVbBE3OBnDJU54wIQxij4GTmikAXqc5hO8sll+cbK/PGWTLdTq3araI1/
   E8sUhkVIOZ5+R40pmwLm8HOKTwI2if35/Y0NGvWp+1Hy80te5yGS5vns2
   V/T8Heg9p2Zmscn7wfG65BIVPqEfBX15D2e6UUTBolSt0x1h2Uz31XyQa
   oJQPeXQ5k6XQ+LZAQCN3NczKGp9ich7vnvZyA81A/aHdMXFTaFu/LVLug
   g==;
X-CSE-ConnectionGUID: q4cgh1bkSAu+GwXR9RuMgg==
X-CSE-MsgGUID: Kb8OyJgrTJGMG9BpjQR5Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4502285"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4502285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 04:12:35 -0800
X-CSE-ConnectionGUID: WkaRLdGuTMeO6leH6Vu04A==
X-CSE-MsgGUID: p/XTMLSURD6s2oSiI1XMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12066741"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 04:12:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 04:12:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 04:12:33 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 04:12:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btKDS6AqxyeqY+lm0GrmRIj0gtsAvx9JH4r1lQiPzmaDfT6m6+w/bal0k3j7q28USOy2sXXKaVvV8dRPulsjeLeua2je+nWRENG9IaoD/juGoQFvcPLnxRtg4B4MzgaDkuopG13RTzyl7gAESzMExMntjyTXHkeqWJA94D2+JNjRYdFyyNGS0oF2SW8+YwpPKgpjNt+YxuDg8jcnaJ2oJ1jMPTEg34j65tSVplDYlOJZHM4KaOWKtHRieLv4F5uo/IiO0pxCt1mtYfUGm+sVmkoogZ7VsWyKdg7y6s3qn5v+541bXpDB304aHC0Ql4z7viLZ3RuMxm1ZosgoKvlPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XS4TBX22Wq7DrXyVbXbZ/vfmb44cbmb6rjqZjGyhBs=;
 b=W7b61ObUATTxqBL3xwFdWexoTrYdYv/j7vz1kcmSrL2nLwfyI7hMMxttV9WGtv/h0qxKsfb2DjJEmynlIO3Y5JxsCi2R9PKwWo0whomlmeIeVc0iqHvMu+FoyctoffY4R/U2jB7+LCJbBVCzYjTKVbq4zSg6lcqTC5NFBrlk6jNzaPMkRuOEkYQxfgpWjf6SKiaE1zHYEa9a32mVlRKJ8Iqn3rCWF3CJR3EMVx//o3b3N+d5GvIMZeYRCjyqsPIKa2gxZngH0TlAuA1rqy0l5vzQn5pnxfEE/Fm7fwy1hD/WADmwSYzxbe7Q9a8laYlFytVXnGQlLNY6y4LN1DW2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XS4TBX22Wq7DrXyVbXbZ/vfmb44cbmb6rjqZjGyhBs=;
 b=M316m5yT54PFrZftXRAIwNhYtqc7j2IdYor+thkS1ekrS8kwRdKhV0mJSPYsbI6nhiuOOBtDsu9HCEbZ2SzMTOmCZWlXeVir4QM7d5bzmxJMHTQzEfxyZmlrI/J4N3ZgbU7yF1XWjdtS2A6+3H0BBKe1D4SHIlZ+vpZ11+04wJ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH8PR11MB9483.namprd11.prod.outlook.com (2603:10b6:610:2b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:12:31 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:12:31 +0000
Date: Wed, 25 Nov 2026 20:12:20 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian, Kevin"
	<kevin.tian@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Message-ID: <awbQpM4QlKTVQ0f8@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
 <20261116111037.3478844-4-chao.gao@intel.com>
 <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
 <awV7wYVv4D_Egns8@intel.com>
 <00efbba7a1b2c6e61cc36bf709718da978eec85c.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00efbba7a1b2c6e61cc36bf709718da978eec85c.camel@intel.com>
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH8PR11MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e52ddca-1bfc-4864-c96d-08df4aed611e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dOuRUCLvDoj+sHWHvrn/6cPIDUmmZEF6Zf1v15sa9lMPkiuDZ/pSOwH0CtdegKF7dmfTAxArfFKlNT/rrjaJjfvCiuyTFP1jj9jvLS8Li348hAoY64Pc4PJvSFOwnA3ofm/8SjPPYHGrJc6LFW06jgiHN44AqCv3sl2baf/6IuhJWvF7B0Zu1p5CAEZA1yv9UBGbQu2u8vrIvmB4xGb8iBXZVCIfoTowDMfQpls7sgfRXvMJ09KyaVEbaoGSDbby0S/8K3HZ4YDb680R8TAHtrCrzXmRYQ9iHOgVEX+8Lv+L2xPkdrPYnBmAyvjaVXAK7pFwH4iY5IbfB58ifVkYYeEmNd8ktHAKMcrwh+JCSvWS1vzrPYxew4PyE9MW3louElIAc4UUtfWhRogGvYeSAGnk3qRbylKJtoPzhNyB5vVQ0yPACXPKbcrLjexT4UjZFmnQBc7hmuS0D/sjbhxDh0Yl+WxFoaykw2aupTK0STki6nsSJmnvDoco2e9KFW7/mMzqFJuFNokbzo4ThvvKXwu3H+ujm4ucpiNf63tD8FYoFStSYKNRXj2ig64oej5+hvKFNTAkMceTeehtfAuMlT7J+H7b53N7EhU8HIlL9IZ1izaFo81zhudNvtV2bnbel9KjwXXBhNjd5BYj1nw9fzpzFF+1Ecu55PVCvHJSyUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6ObhVj4bCzrT17P/qqgmHFrfXnHf9TRFEXzN5wGsARr6Hgdx5VVKOS0Iziz?=
 =?us-ascii?Q?PGVaQ/XbUdE3ArkXb16sJy/toqYd1BDmFnPDeBNVNuYrWl0CC/yo1D4LR/p0?=
 =?us-ascii?Q?gFWpEj/l9Z0GPJKGpkxJTEbcbhSj2RQ0vQYrXEuOCjoudn0i99uon+pYbAHJ?=
 =?us-ascii?Q?MVB26N6Kb3Y27VN/i+yxdHOQtRk5oEIR/ZbCAWMbNN6yptpBBW9Zv7hhpOBG?=
 =?us-ascii?Q?adxulCIl1LD6bxl2I+3UrIPIfBPo/ePAnKmi7FvtSzA7shU35F8prSZe8zy2?=
 =?us-ascii?Q?ZnTbDKGCV+Oo8HsECiitHTlsbkEwdHSP/KcN/QyJQsgXqt0D8v+Pve5n3ecd?=
 =?us-ascii?Q?IScT1Jxmd3fKZWKtgrOVGr+qKegvO0HtD5jUwZOR8jT+3ujyHSLmI15wlZ4h?=
 =?us-ascii?Q?IXrDhBTJdq5+Uji9Ion5QKslTKCVi2oaOcCyM8tCbIGGsvSZ4xKOp/a77CQF?=
 =?us-ascii?Q?kp37KgD0jx3RF7yvyZSZ8DRuqBSaLPPNAqD7bXmr/KmAL/epzrwESrx/W2Li?=
 =?us-ascii?Q?FnEWqx8+PQilZBphoJcBH+PhV2duPyF6swP1MXuwiCBgWcYQ3v+S/wDt3LFx?=
 =?us-ascii?Q?VGwmjpdWympwBbt2+5kwlky0LBiFru6QsNeEQ6Wx3R+JBcQiM3f4P0ouzyTL?=
 =?us-ascii?Q?MN1ds7Oqa01GweyB9cc+4P1zMioQi/khAC4vfaYoH7ZvwVB3yJnn/Hh4idqj?=
 =?us-ascii?Q?Nu+wltKKOWnYUVqECGwdbSbZjuFJVZPrz8aUpo5NUQTGaNR0e5xoDLqd4wud?=
 =?us-ascii?Q?NWELm0BklMnHpgmx2eb+hHnQJsyBXxY8/kZxeqiTx/LKr8e4uGMSI7C80Dsm?=
 =?us-ascii?Q?OJ/ZBGg+6ey3T5xpnSLXuCPbYmgfelhdEjRsHXmSZHXPy+tvTnJLl08aPD2m?=
 =?us-ascii?Q?5AYAeS6Tmdzekyt5uXAFAVFG9IntoLgpU5ef1iYVv+qruS9Is1+yZNMwHs2p?=
 =?us-ascii?Q?UwLamXg61Pwf6RwCmuI0URL/h6XVm3V7/6O3W6g3X8oPj+m0AOnmGjRD52tC?=
 =?us-ascii?Q?nxO6n37qOVY4uBi7+TcTvFTj8jrZNUxeQR0TVzzX7WAbTxcUzZ0Ri0/DGuQL?=
 =?us-ascii?Q?HTDtFlf92LNhMXhCNhkaUytUE/rMRKNADwAZerUOc8QYBvfDdeexGYvC1zIq?=
 =?us-ascii?Q?J5IUXk9oAfe6SyesWDUZberau4xoG+JUSwFUK90C+rSK1nSI4GTRua2DLzTp?=
 =?us-ascii?Q?lnprF6kKYqTpWHg2dXssU7E45mFoy+p0PUmEO9rTj/OIdQmIntzxfrfFwnC7?=
 =?us-ascii?Q?UVY4+AJx0eFx6Jocck0nV/LpXSfU3gYuhRQUCsh7tN8d97MN4UJ/E5AufE6o?=
 =?us-ascii?Q?NhvuV3cJhSYhUcHY1raNPfkmrveZrfggqvMuXfeUA87PG0Ouqtuv1vPx/MNl?=
 =?us-ascii?Q?Eu0mwtUB6FhoLRBIyNZ97U0CYdFqpL6mKJ3p09uVScPGHWH9EYNWZ3lMTvSm?=
 =?us-ascii?Q?RoyChpSjhBRwEIpv3UKkFP/vi5DLNubruEP9OxUJgaq8YzvCmvLCz6PH8Y3X?=
 =?us-ascii?Q?WVy6jQyBuLABzAh/7AvFnJCaKCtSCvsQfVHIIR4SNMSW9ZE2NRii9HP1OlpD?=
 =?us-ascii?Q?+NWRCS4euDgbnFfTchtId1r7Flm+0npcScOPkBpaW1pVJ2mXQZOzFZOyQbiP?=
 =?us-ascii?Q?ngt+irtBV04UMJIMFh0hc9x3YWte9Pc6rKRaKJknPdcwwHJQKG/xP5g3pvxf?=
 =?us-ascii?Q?s7Pz0cH0CZy7G5mib3sB87iL7cYXi7q4y7zUNhGpo0xrYtBVHSij9NmamOuc?=
 =?us-ascii?Q?uPGPW8E+PA=3D=3D?=
X-Exchange-RoutingPolicyChecked: IKujw1cnBavnTBkDaF2DKevh0Z7/AHwogqOwMcwMv7XlBuZElkn2Rc1QIz1RoWgBS1NyhXJksfix8q+57X7glOrky5ZA8x5VKIRtvwX9iXbv//EOGPW9YGy2aCNfZ0SfcsG8fNa7+OrkgSXCbsQ87pips0d+GGPdkPNqFSotg18wRrLqLrrGZqhAXJ8b4Y4e3AQ4XnxuQb5Zj61xKjL9Xzx4OtjklIQ+5mPJIVFzw4OcADD+OShOB4VZbkRA30+XF3CVM8v/17wpjEiH2gSTxqnkcPu83+VlddnYCTIp4DBf69x6ueenJTDuoIBtKeVTqCb3C7cuXAnQxFEsLOLpSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e52ddca-1bfc-4864-c96d-08df4aed611e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:12:31.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWPVsyDTBGHz93cKdAUY6YrWO+SbgUvZMO0UBnrs1uMK9hC7oHaFEtRw3IdbSTCbj8XW9eXwJqYVW592/n7o/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9483
X-OriginatorOrg: intel.com

On Wed, Nov 25, 2026 at 06:02:02AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-11-24 at 19:57 +0800, Chao Gao wrote:
>> I am now leaning towards moving this code into PCI/DOE, even though
>> TDX would be its only user. Stripping and rebuilding the header is DOE
>> format handling, and the PCI/DOE core already has the definitions and
>> the code for it. A TSM driver should not need a second copy, no matter
>> how many users there are. That would also remove the duplicate
>> definitions above.
>
>Can you elaborate on your proposal? What exactly moves to DOE and how does it
>interop with the other DOE callers?

The header stripping and rebuilding moves to drivers/pci/doe.c, as a new
helper (e.g., pci_doe_raw()). struct pci_doe_header and struct
pci_doe_msg defined in this patch go away. This avoids a second definition
of the DOE format.

pci_doe_raw() is a wrapper around pci_doe(). The other callers still
use pci_doe() and are not affected.

I explored the idea with AI. It generated:

int pci_doe_raw(struct pci_doe_mb *doe_mb, const void *request,
		size_t request_sz, void *response, size_t response_sz)
{
	const __le32 *req_hdr = request;
	__le32 *resp_hdr = response;
	size_t hdr_sz = 2 * sizeof(__le32);
	size_t length;
	u32 hdr1;
	int rc;

	if (request_sz < hdr_sz || response_sz < hdr_sz)
		return -EINVAL;

	hdr1 = le32_to_cpu(req_hdr[0]);
	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
			   le32_to_cpu(req_hdr[1]));
	/* A value of 0x0 indicates max data object length */
	if (!length)
		length = PCI_DOE_MAX_LENGTH;
	if (length < 2 || length * sizeof(__le32) > request_sz)
		return -EINVAL;

	rc = pci_doe(doe_mb, FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, hdr1),
		     FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, hdr1),
		     request + hdr_sz, length * sizeof(__le32) - hdr_sz,
		     response + hdr_sz, response_sz - hdr_sz);
	if (rc < 0)
		return rc;

	/* pci_doe() has verified that the response has the same VID and Type */
	length = 2 + DIV_ROUND_UP(rc, sizeof(__le32));
	resp_hdr[0] = cpu_to_le32(hdr1 & (PCI_DOE_DATA_OBJECT_HEADER_1_VID |
					  PCI_DOE_DATA_OBJECT_HEADER_1_TYPE));
	resp_hdr[1] = cpu_to_le32(FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
					     length % PCI_DOE_MAX_LENGTH));

	return rc + hdr_sz;
}

tdx_spdm_msg_exchange() becomes:

static int tdx_spdm_msg_exchange(struct tdx_tsm_link *tlink)
{
	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
	int ret;

	ret = pci_doe_raw(tlink->pci.doe_mb,
			  page_address(tlink->out_msg), PAGE_SIZE,
			  page_address(tlink->in_msg), PAGE_SIZE);
	if (ret < 0) {
		pci_err(pdev, "spdm msg exchange fail %d\n", ret);
		return ret;
	}

	return 0;
}
