Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793060128;
	b=RXqtfaAiLS2BARl6Z0uESzHGHgwEdyH69M+78c8j1eEdRi875RPkHbCsrWWN0hJDSu19
	 3RAYwXRVdaztXBLqw+BlPFQPtSYn17LzDvaTUa9T8nhw6ODtLs0fZH4+1HWxTMzlDdXdr
	 975rngRgXkBpDME4BlQe6EQNsjqlLdbPHfq3RBUm+gK1BZJGQvlDGK82PX82jGPTwsIyy
	 uHP99++S2CfOW+vCM+lbLly7Gai8unqQnJZkH0ksJTM1t3Xd2UYrE02UutbSYpLaasTfQ
	 hLf0dbmBEZzXHZ+Vc8GcMYHSyd/EgD8KY07fw5pdyf2uPZBVVNUZC1Eb2MEIQzaX9kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=JNDxxWqr6bxgSrkAsUvt3GDhib0NETDVLDoPvFVVAUM=;
	b=O675uTdaU49dNQJ893/jkVh5DwdQQMm0kMcqtoY+UwuhJlgxFUPG6ne2hSH65pQM9eP3
	 0uUALRmes3KiNoVc8PQXF2V1qSAemAWB/WL/dXOhbnoE3cZdwFfzcWuVqSfg/06cZe1Ir
	 2TKahwo02Eq6mbnqnLj3dkR3Slk3la1tv8QbHdqJsL+OOraenwZVrINb1ugYlJ4Hcj8AT
	 Fk7vw6hfzBDHpSawzBC6RQLi7C8zISc691Mn9w0kH+s6JnzEFaXqoPVyUGNIj1YmW5IAc
	 OKA9jDB/bUhcRo9P2e2cR5G3OrJCtROqfEa2OwTCiyq+zoYqm0JkgcBVP+WTu/DF87Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1gqqCum;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A834606A320;
	Tue, 27 Oct 2026 00:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A834606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1gqqCum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793060127; x=1824596127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mY/M0Pdx+8+1pbJ4nz9Wgt4pNkjHyuhfj8n/Z9iK/g=;
  b=j1gqqCumKLOPrBhaEoh0O9SO0lcwlxW68ojxasC7gIpKmypRKXiPIMm7
   J2EgSE9tMAQawZE3wyzM/QlWfMrUP1cVnJr46Xt8daKji08xJzsM9q1NJ
   kuGSefrB1+BytkwVJaIxfgJbtUOXq/PcJqfdNzHDv2s9mBt5oyIvkMkCK
   umMgC/mRSYSLbFoi1M379EsBRiDxozGCdCZ0xLPahmxx+GDat58d7Nn+L
   BFoIUhq2PhiwLrM18v99eF/99HWqYRbnoSqxMG2JsmdiCGXG4YagQUiHK
   9iNHYIAdY9uA4abXXdDB+TFMRmVUhNpAlDmP8/gvR8f6gO3ea243HGvcG
   A==;
X-CSE-ConnectionGUID: QcuI4+NDRm+RipbFibQcoQ==
X-CSE-MsgGUID: WJXc+iBPR7KfBftSZyl6Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1635960"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1635960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:15:26 -0700
X-CSE-ConnectionGUID: Bs/5boKVSoCHPaUPDcT+oA==
X-CSE-MsgGUID: d7EIGOE1TOmL4+gIY1FPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4751231"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:15:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 17:15:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 17:15:24 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 17:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3sibfAs+XlIHZmyekWubFZNO5fREEyGfKmkBdNW1dISfpJ3lmRzLI0PStFAAJoCLbxBXK2X2QeN4U09zVCXVv6twySfUUUGtOjfuo7dv1CD23OLZ8nBrMVM35xdcFD/GDuIGNUNdC8WTRIeHV9ys+ypZXGV4fsWMtizA+X4PRBD0M5U2qx749NesWvtrnhQ5SLkdppceuTtY3+XgwqiL5Pydi8C95OgHZ9tMyx4KQcyDpF+1DiByHWRh7dXhEprRs3WuZKLkQFBUvqDAAnAqvQEg0ykcq1sI6HMO45zRmRl26xrMk/At9LVDp+HenO9UDi/SwqlfnYLRv2p3LVxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNDxxWqr6bxgSrkAsUvt3GDhib0NETDVLDoPvFVVAUM=;
 b=H31peeSzgQAAPy0a5plhAwf4e7dLFzm49cY9F4KnkbM1anJYWVRg7gtSNYysvN5nlc/GEtvj3StNLSuJskQe72VbXoqjHquH9H3IbX4izlc/L1WKvi2VGX7E3n28ldXIHE4BNxhiZkA0Bk1p8p2MmUn9tfeKhmMSJe3U79ibdBwgCCEzfCilQjXrefjwlgP9nYGYHcoEEPjj0T3RSBBW+CzjxpV/wJPyKnQJALefeCTnJ0Y0r9sSEyozVXuDYchhQkRL20uBpCNaWGjag4TyzK9JbeEnLl1w1gsuCj0aD0YvacWISQQG0FkjZhxjtbGgpAEFqQLCoJaD+qN5UCAj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 00:15:18 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 00:15:17 +0000
Message-ID: <0082b675-5749-410c-9fec-9ce9b23b2498@intel.com>
Date: Mon, 26 Oct 2026 17:15:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1792627082.git.babu.moger@amd.com>
 <1a8f3900e9e14ec19f5f7204fd64716eb0aa8427.1792627082.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1a8f3900e9e14ec19f5f7204fd64716eb0aa8427.1792627082.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::21) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CYYPR11MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2795c90c-3fb5-4a46-e006-08df33bf6172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|18092099006|261026140227099003|3023799007|56012099006|11063799006|4143699003|5023799004|261021121427099003|261021123027099003|261022075727099003|10067099003|261022113327099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 0a9u3BIShWLfqvHwbj1Kn2/x1UGZBfOjeRaQT2hg6mvUa9wjFbNSNQLiyHwAUfNtlZA8EFc9YbZHBxLr7Zk7Gm5YQ1hUpIzj/TD6vSPRm/HuKlqPX48FElyk1lVYKAQEvTUr0tG7RBTfs6ZLEnv3rLlFNs4WqkSyeWS1IZZQRYdvDtfo/k2i5GMDaWKBUalnbznLHeq+HbBn8QBna9pgaQ5TvwxfyJN4ARmVRro7qFY78fCy5F9IofHut1a/5cMzfAFUCGHHA5oQMQ/VvY71sIwRbO8F7u1lAA66YdSY6UxOiZrXvdXtHM7oVikRUyy5ctrrUDhn31T59y+duHxmt0aq7cuAaeMYEHUtkei+KwYittrSc0rkRfZU+I3RCuhS0xm17WhPaP1zxv1lS8tSL+HP6DpqJfRIYwTPovHEAOkK3bCv0zABwomkQdV5JYgSl28O6tshXYAyU6H1Jc1laYCByHo5VPEPHtbyat7nwLSRhOI77eak2DNKiMX67VsvF+zyM1PbvZvMKm6yuKO55KrkbyKxykSbXBm3CQtGFLhcsAYef6vWjnIogp2SELdX2o7Nj7Gwepju9ytwJfPFZvPTFqwZA36sESNc4hdNCD0LlKmfCqn+96fFpebH0bLAx0Wj1EPZAVXCxJI8nO7e0pQcj8wNyU/4ukwtDpXvq/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(18092099006)(261026140227099003)(3023799007)(56012099006)(11063799006)(4143699003)(5023799004)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(261022113327099003)(261009223027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkV0RDJtYzR0UG5wTU1xaTY1c0RuWWg3dDFtMCtuTzg4WW1YYUh1SGdyWXJt?=
 =?utf-8?B?bWhoWU52NktKbEVUYm9BcUc3M1dLM3o4T2tNa0JIdzVRVXd2Z1N1VnhReUpj?=
 =?utf-8?B?eTE2TGJBMXhSM1oyRXBmVkg2ZGdKQmREd2tYZ05yV3lGTmlvWDZkTi9sMVpL?=
 =?utf-8?B?RitxUEo3TkhWZEY3M3B0Nk1HMmVaY1ZLZWZTOTlWamtHOERnNmRQSzIrU2pS?=
 =?utf-8?B?ekYxc1VhWjkrUHFzNG11MlBPQTU5VkpLalhCUHlCcE9OSkJBMnhwVW9OZFZU?=
 =?utf-8?B?K2ZubG1ZU1MzeE0vUkhadUlhK2krOFgzQU1WTG1Xd2UyRDZIR0owU3RIbmdk?=
 =?utf-8?B?cUFlenJWdUhtdTlRUHNXTHVnWmdDZHAyVmdXRUpiYzI3YURHUnBDK2pVSkFr?=
 =?utf-8?B?Z1lDN0t4YW5JNlhvL05oM3FUc1RiOCs1ZVBQakhXaTJZdk5tVzE4QmZ0TUNM?=
 =?utf-8?B?MkQyWmpsNUQ2TWJ2U0NMREdLOHhEa0htbmxabnd5UmZ2eE1RMS9wZ0JlT3pi?=
 =?utf-8?B?ekhZeXZ0MSsyREhVNlhOWDRQVkVHcE9GVGVyWGdnOFdJeERwdWtrc3FnU3RO?=
 =?utf-8?B?UnVJZjlKTkJXWHJXMUF1M3RNaVZPOERybUhNWlZ4TXNPU1dDYUpjQnM4S3Na?=
 =?utf-8?B?aUNINGxsa2o5UUJtY0Q4UFpONUdnTkkvUHQxVDZham1na0ZQOEZHZlVVRzRt?=
 =?utf-8?B?TGZXeC9XMzFNUVRBeEpJSzBiRlZ2NC9XMTBHZVhsL2JidUFYWXBVd2hrbDQv?=
 =?utf-8?B?Y3pQOXRXeWVaMWw4VnhqWHQ5Y2hJbEtsUktNT092OHQ5RmViYXUxamovOTk0?=
 =?utf-8?B?NFBWYmdJYmxvMnRvZG9mTGZLaEtuM05SU1hmcFh6eWhTUFkzbzFJbXdORy82?=
 =?utf-8?B?eWtxcVcwMnZFNnNwUjNkT3lmbDAxdHU4ZmdUaTg4dk9Na3k3OTRBbC85bW96?=
 =?utf-8?B?RlNEbkx4bG55RGxaeGkrL0NRbGhWNGNSVmcyS2FXMjkyb2JZeVVGMTJGQnow?=
 =?utf-8?B?MGVyVlkvd2UxVmpLS0VvSFRFZk82cU9NV1g2MHhmNkYxdHBubXZBRDJGT1cz?=
 =?utf-8?B?L0NOSHJMSXpzZnhXQk1uTTJzRHJCYkJ3R21ISXRPRUZFNDdZbThybzdSV2hy?=
 =?utf-8?B?VU9WaUtIL1VSRTd0QWw0dHFWYklkd3pqa3JzT2wxQWFzcmFYazY4NmtoRXdC?=
 =?utf-8?B?WmkzMjJJWGY2ancyQUFTSERWdFNQOTNLNE5QSnlOSEM0TkZJZ2FHMDJMemVR?=
 =?utf-8?B?TlFkYmtObmZSVjhabForTGVZWEJnUDhNdW9LMWxCS0xDaWJpNDE0OVg2Q2lT?=
 =?utf-8?B?Z3ZJTmkwUWl3dyt3V2dRbHFqYlJTZm1WNkl1N2ZnVnptNjN5aHpmVXc0Mjl4?=
 =?utf-8?B?cjBUdjRCeTd0NmRXK2xlUHA2a2ZJc3FacENNNWk1ZkJTYk5UVDlZK3oyNFB4?=
 =?utf-8?B?d0NMUVVFMkZZcXA2K0I4WXBWVnI4UWdwLytUUVJnQzhyRkJwaXdVcmNKWEFQ?=
 =?utf-8?B?NVQ2amk0U3JwVEtmL01ZU2NuQkc2V3FTY3pCL01uRDR5WjZNSUh0UWdRdEFC?=
 =?utf-8?B?elhlOUw4M3RyOGh4YnZ0cnAyUjJnRnV5WDZaL0JYa01qY3NNNVFDdkVoVjNE?=
 =?utf-8?B?c3dGUDM5TXMrNnA4OVZLNkh3dEFSS2I3OXFrYWpGbUdPYXY2Ti9MUWMyNVNs?=
 =?utf-8?B?QVZ6bnIxcDRlSjhvdTBVNXdQQjUvM1RFdkw0OGpxTFJiQTdMNmV0YW9RSmdC?=
 =?utf-8?B?OWxuY0FtWW5hZUI3QmlMelZVU3duMG1US1dnZG9JMzFJbERISjliUm1CNjBm?=
 =?utf-8?B?S01tcTRhV3lHdGFpUUVYNFZvN2oyR1M3VzdlNW15SXo5MnN4MDA0OVFGSTRZ?=
 =?utf-8?B?TTM2Y2QzOUU0bWhSOGN4U3BZVUtzV1VvdklCbXFpdy9xTWx3OWFFSllHN1g3?=
 =?utf-8?B?RE9UMjNnSGZVNUlwZ0VFT3l5YW85cHhwR2RaMXlGbjJ3SHkvejdLaVI0YzhB?=
 =?utf-8?B?TUJuTDkvOGZ3NHl0N0RWRWl3RDVZNnpaNmVNcGV1alhMQ0Q2V2hXbHpJcGRn?=
 =?utf-8?B?OHVrcEZyWDl5Q0dJNmE5dVJpTEFTNlJLdjRwTFVPT2tmTnNST3lzUDZjdHZY?=
 =?utf-8?B?akJrdnRsNVNEcXRjcTlkTmhTZy83ODZkdFYrK1FIellacUQ0TS9SOGJsK2JX?=
 =?utf-8?B?OFJ0alo5MG9TVVphQW9JbkRHeHl1aEhVc0NsNHI1Umk3SytzUjdCTFpVV2o1?=
 =?utf-8?B?NEVzejVpODg0VTJFdzBFN1JvcjQ2YXRpQkZQVjhPVEd4bEdMSXVFT05xSnZU?=
 =?utf-8?B?WmwvajNzTzlRVlhmLyszMlk5SEl4V1RKcnhTd3grLzRNalNuUitHeVlaVXk4?=
 =?utf-8?Q?jYFynbf7N4PBF5NQ=3D?=
X-Exchange-RoutingPolicyChecked: XPzdkEEOuA2nfz9NliH1saLhhfwWO+Kk/KSKSgi2WNTQu8HbeHXeQYpxhS9hT4FZPGSNb6yfsaTcvSNXjz7jcwK6xqy0cnyCy45eq8Fgrb2uJvveOTL8qfO6lv327CCH+E73/Cd2yN81Y/c7+vBt1zAiUBRPUmXtGydjJcGxVCvZE+7rRpqXXoBvBfixoN6j32CHRTjDglB+Hsvth1lp60QtPvrEfQYF5tLA883xAWxQmugfaBDCQx3Lm5wWA5mDaCyME1npiPT8iQj8qkvcDCpJ9ahttdO0QBFeLojJ6k8DETgrzmHjYMz91IV7Zu1XuzgaQCHiINctFEI3TZoDNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795c90c-3fb5-4a46-e006-08df33bf6172
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 00:15:17.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txk/VonrOAMexZp4J+zCEeg3tkBtStPQAtKjo+kyjIqWSX3IWzbrFwglZl2XmvkO6GkUC2Hy9Il8uSAQ9A2B1IMtALpaBo5S7RUwGhzfJjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8308
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/26 4:58 PM, Babu Moger wrote:
> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
> It is intended for deployments that need to manage counter assignment
> on platforms where the number of monitoring groups exceeds the available
> hardware counters. Hardware counters are scarce on these platforms, so
> mbm_event mode suits workflows that monitor a subset of groups at a time
> and rotate assignments as needed.
> 
> resctrl enables the mbm_event mode by default on hardware that supports

nit: "resctrl enables" -> "x86 resctrl enables" to highlight this is not the
resctrl filesystem behavior but the x86 arch driver behavior, which is different
from the MPAM driver. 

> it. This breaks the pqos tool [1], which assumes the historical default
> mode. It creates 16 or more monitoring groups and uses two counters per
> group. On a platform with 32 counters per domain, that exhausts the
> mbm_event counters pool, causing additional groups to read "Unassigned".
> pqos interprets a non-numeric event read as zero bandwidth and reports 0
> MB/s for those groups:
> 
>   $sudo pqos -m all:0-4
>   CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>      0        0.69         16k       192.0         0.0         0.0
>      1        0.40          3k         0.0         0.0         0.0
>      2        0.44          1k        64.0         0.0         0.0
>      3        0.39          1k        64.0         0.0         0.0
>      4        0.43          1k         0.0         0.0         0.0
> 
> Leave mbm_assign_mode in default mode during initialization. Default mode
> uses one counter per monitoring group. On existing AMD platforms, the
> default active counters pool is 64 and may be larger on newer hardware.
> The active counters pool is the number of counters that the hardware can
> actively track in default mode.
> 
> Deployments within the active counters pool receive accurate bandwidth
> measurements in the default mode. Users can create more monitoring groups
> (for example, 4096 on current hardware) than there are active counters in
> the pool. Beyond that pool, readings may be misleading or report as
> "Unavailable", with no user-visible indication.
> 
> Default mode is still limited once the number of monitoring groups exceeds
> that active counters pool. After hardware re-allocates a counter, a read
> may return "Unavailable". pqos still treats "Unavailable" as zero.
> Successive reads can be a count, "Unavailable", then another count. pqos
> treats those jumps as wraparound and can report an inconsistent rate:
> 
>   $sudo pqos -m all:0-4
>   CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>   0        0.76         60k        32.0         0.0         0.0
>   1        0.45          1k        32.0         0.0         0.0
>   2        1.57        107k        64.0         0.0 17592186044184.9
>   3        1.62        276k      4928.0         3.2         0.5
> 
> Users that need stable measurements beyond the active counters pool should
> use mbm_event mode and rotate assignments as needed. Enable it with:
> 
>   $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

nit: "$echo mbm_event" -> "# echo mbm_event"

> 
> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
> Closes: https://github.com/intel/intel-cmt-cat/issues/311
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://github.com/intel/intel-cmt-cat # [1]
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 101 ++++++++++++++++----------
>  arch/x86/kernel/cpu/resctrl/monitor.c |   1 -
>  2 files changed, 63 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index b52795e03303..fc3ced99e3b7 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -354,8 +354,8 @@ with the following files:
>  	::
>  
>  	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> -	  [mbm_event]
> -	  default
> +	  [default]
> +	  mbm_event
>  
>  	"mbm_event":
>  
> @@ -373,20 +373,35 @@ with the following files:
>  	Moving to mbm_event counter assignment mode requires users to assign the counters
>  	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
>  
> -	The mode is beneficial for AMD platforms that support more CTRL_MON
> -	and MON groups than available hardware counters. By default, this
> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
> -	Monitoring Counters) capability, ensuring counters remain assigned even
> -	when the corresponding RMID is not actively used by any processor.
> +	It is intended for deployments that need to manage counter assignment on
> +	platforms where the number of monitoring groups exceeds the available
> +	hardware counters. Hardware counters are scarce on these platforms, so
> +	mbm_event mode suits workflows that monitor a subset of groups at a time and
> +	rotate assignments as needed. The mbm_event mode ensures counters remain
> +	assigned even when the corresponding RMID is not actively monitored.

An assigned counter implies that the RMID,event is monitored. Considering this, the last
sentence appears to have a contradication:
	The mbm_event mode ensures counters remain assigned even when the
	corresponding RMID is _not_ actively _monitored_.

Should "monitored" rather be "used"? This would read:
	The mbm_event mode ensures counters remain assigned even when the
	corresponding RMID is not actively used.
  >  	"default":
>  
>  	In default mode, resctrl assumes there is a hardware counter for each
> -	event within every CTRL_MON and MON group. On AMD platforms, it is
> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
> -	events between reads resulting from hardware re-allocating counters. This can
> -	result in misleading values or display "Unavailable" if no counter is assigned
> -	to the event.
> +	event within every CTRL_MON and MON group. This mode is enabled by default.

Please drop "This mode is enabled by default." since this is general documentation and
this is not true for MPAM.

> +
> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
> +	counters, hardware dynamically shares a smaller pool of counters among
> +	RMIDs. One counter from this pool is used per monitoring group and counts
> +	every MBM event of that group's RMID. The size of the pool is not
> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
> +	much larger. For example, 64 counters in this pool monitor 64 groups.
> +	Newer hardware may provide a larger pool.
> +
> +	While the number of monitoring groups does not exceed that pool, a counter
> +	stays attached to each RMID and readings remain accurate. Creating more
> +	groups than the pool can cause hardware to re-allocate those counters
> +	between successive reads of an event. Bandwidth values may then be
> +	misleading, or a read may return "Unavailable" if no counter is allocated
> +	to the RMID. There is no user-visible indication when this begins.
> +	Users who need stable readings beyond that pool should switch to mbm_event
> +	mode, if supported, and assign counters to the groups of interest
> +	(rotating assignments as needed).

Above are two AMD architecture specific paragraphs inserted in the middle of generic
documentation. On top of that, the second paragraph does not have any architecture
specific "markers" and this could be confused as being generic.

Could this be re-organized to seperate the generic and arch specific documentation?
This could be done similar to how the io_alloc documentation used "See architecture
specific notes below." text. The two AMD specific paragraphs can then be linked.

For example (changes on top of this patch),
---8<---
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index fc3ced99e3b7..f33c06612a77 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -350,7 +350,7 @@ with the following files:
 "mbm_assign_mode":
 	The supported counter assignment modes. The enclosed brackets indicate which mode
 	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
-	is changed.
+	is changed. See architecture specific notes below.
 	::
 
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
@@ -383,25 +383,7 @@ with the following files:
 	"default":
 
 	In default mode, resctrl assumes there is a hardware counter for each
-	event within every CTRL_MON and MON group. This mode is enabled by default.
-
-	On AMD platforms that support more CTRL_MON and MON groups than hardware
-	counters, hardware dynamically shares a smaller pool of counters among
-	RMIDs. One counter from this pool is used per monitoring group and counts
-	every MBM event of that group's RMID. The size of the pool is not
-	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
-	much larger. For example, 64 counters in this pool monitor 64 groups.
-	Newer hardware may provide a larger pool.
-
-	While the number of monitoring groups does not exceed that pool, a counter
-	stays attached to each RMID and readings remain accurate. Creating more
-	groups than the pool can cause hardware to re-allocate those counters
-	between successive reads of an event. Bandwidth values may then be
-	misleading, or a read may return "Unavailable" if no counter is allocated
-	to the RMID. There is no user-visible indication when this begins.
-	Users who need stable readings beyond that pool should switch to mbm_event
-	mode, if supported, and assign counters to the groups of interest
-	(rotating assignments as needed).
+	event within every CTRL_MON and MON group.
 
 	* To enable "mbm_event" counter assignment mode:
 	  ::
@@ -413,6 +395,24 @@ with the following files:
 
 	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
 
+	In default mode on AMD platforms that support more CTRL_MON and MON groups
+	than hardware counters, hardware dynamically shares a smaller pool of
+	counters among RMIDs. One counter from this pool is used per monitoring
+	group and counts every MBM event of that group's RMID. The size of the pool
+	is not enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may
+	be much larger. For example, 64 counters in this pool monitor 64 groups.
+	Newer hardware may provide a larger pool.
+
+	On such platforms, while the number of monitoring groups does not exceed
+	that pool, a counter stays attached to each RMID and readings remain
+	accurate. Creating more groups than the pool can cause hardware to
+	re-allocate those counters between successive reads of an event. Bandwidth
+	values may then be misleading, or a read may return "Unavailable" if no
+	counter is allocated to the RMID. There is no user-visible indication when
+	this begins. Users who need stable readings beyond that pool should switch
+	to mbm_event mode, if supported, and assign counters to the groups of
+	interest (rotating assignments as needed).
+
 "num_mbm_cntrs":
 	The maximum number of counters (total of available and assigned counters) in
 	each domain when the system supports mbm_event mode.
---8<---



>  
>  	* To enable "mbm_event" counter assignment mode:
>  	  ::
> @@ -1784,62 +1799,72 @@ View the llc occupancy snapshot::
>  Examples on working with mbm_assign_mode
>  ========================================
>  
> -a. Check if MBM counter assignment mode is supported.
> +a. Check if MBM counter assignment mode is supported. The boot mode is "default".

Same comment as earlier, please drop the "The boot mode is "default"." that
does not apply to MPAM.

>  ::
>  
> -  # mount -t resctrl resctrl /sys/fs/resctrl/

Since this drops the "mount" command. Should the final "unmount" step be dropped also?

> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  [default]
> +  mbm_event
> +
> +The "default" mode is enabled. "mbm_event" is supported but not enabled.
>  
> +b. Enable "mbm_event" mode. Switching the mbm_assign_mode may
> +reset all the MBM counters (and thus all MBM events) of all the resctrl groups.
> +::
> +
> +  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>    # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>    [mbm_event]
>    default
>  

The above changes could be merged together under a single step "a" that
will significantly reduce the churn when considering this is a stable patch.

> -The "mbm_event" mode is detected and enabled.
> -
> -b. Check how many assignable counters are supported.
> +c. Check how many assignable counters are supported.
>  ::
>  
>    # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>    0=32;1=32
>  
> -c. Check how many assignable counters are available for assignment in each domain.
> +d. Check how many assignable counters are available for assignment in each domain.
>  ::
>  
>    # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
> -  0=30;1=30
> +  0=32;1=32
>  
> -d. To list the default group's assign states.
> +e. To list the default group's assign states. Counters are not assigned
> +automatically. They are unassigned when the mode is switched to "mbm_event".

I think "Counters are not assigned automatically." contradict mbm_assign_on_mkdir
that is forced true on the switch. Can it just be dropped? That would just leave:

	e. To list the default group's assign states. Counters are unassigned when the mode is switched to "mbm_event".

>  ::
>  
>    # cat /sys/fs/resctrl/mbm_L3_assignments
> -  mbm_total_bytes:0=e;1=e
> -  mbm_local_bytes:0=e;1=e
> +  mbm_total_bytes:0=_;1=_
> +  mbm_local_bytes:0=_;1=_
>  
> -e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
> +f. To assign the counter associated with the mbm_total_bytes event on domain 0
> +in exclusive mode.
>  ::
>  
> -  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
> +  # echo "mbm_total_bytes:0=e" > /sys/fs/resctrl/mbm_L3_assignments
>    # cat /sys/fs/resctrl/mbm_L3_assignments
> -  mbm_total_bytes:0=_;1=e
> -  mbm_local_bytes:0=e;1=e
> +  mbm_total_bytes:0=e;1=_
> +  mbm_local_bytes:0=_;1=_
>  
> -f. To unassign the counter associated with the mbm_total_bytes event on all domains.
> +g. To unassign the counter associated with the mbm_total_bytes event on all domains.
>  ::
>  
>    # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
> -  # cat /sys/fs/resctrl/mbm_L3_assignment
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>    mbm_total_bytes:0=_;1=_
> -  mbm_local_bytes:0=e;1=e
> +  mbm_local_bytes:0=_;1=_
>  
> -g. To assign a counter associated with the mbm_total_bytes event on all domains in
> -exclusive mode.
> +h. To assign a counter associated with the mbm_total_bytes and mbm_local_bytes
> +events on all domains in exclusive mode.
>  ::
>  
>    # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
> +  # echo "mbm_local_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>    # cat /sys/fs/resctrl/mbm_L3_assignments
>    mbm_total_bytes:0=e;1=e
>    mbm_local_bytes:0=e;1=e
>  
> -h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
> +i. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>  no change in reading the events with the assignment.
>  ::

Could you please remind me if the first read after assignment returns
"Unavailable" or a valid count?

>  
> @@ -1852,7 +1877,7 @@ no change in reading the events with the assignment.
>    # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>    121212144
>  
> -i. Check the event configurations.
> +j. Check the event configurations.
>  ::
>  
>    # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> @@ -1862,7 +1887,7 @@ i. Check the event configurations.
>    # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>    local_reads,local_non_temporal_writes,local_reads_slow_memory
>  
> -j. Change the event configuration for mbm_local_bytes.
> +k. Change the event configuration for mbm_local_bytes.
>  ::
>  
>    # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
> @@ -1871,7 +1896,7 @@ j. Change the event configuration for mbm_local_bytes.
>    # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>    local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>  
> -k. Now read the local events again. The first read may come back with "Unavailable"
> +l. Now read the local events again. The first read may come back with "Unavailable"
>  status. The subsequent read of mbm_local_bytes will display the current value.
>  ::
>  
> @@ -1884,17 +1909,17 @@ status. The subsequent read of mbm_local_bytes will display the current value.
>    # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>    1566565
>  
> -l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
> +m. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
>  done using the following command. Note that switching the mbm_assign_mode may reset all
>  the MBM counters (and thus all MBM events) of all the resctrl groups.
>  ::
>  
>    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>    # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> -  mbm_event
>    [default]
> +  mbm_event
>  
> -m. Unmount the resctrl filesystem.
> +n. Unmount the resctrl filesystem.
>  ::
>  

As mentioned earlier this is now asymmetric after dropping the "mount" in the first step.
Should this unmount step be dropped now?

>    # umount /sys/fs/resctrl/
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5d0d3b18f9b8..a6a9090c4808 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
>  		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  		/* cntr_id is 12 bits and can only encode 4096 counters. */
>  		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
> -		hw_res->mbm_cntr_assign_enabled = true;
>  	}
>  
>  	r->mon_capable = true;

Reinette
