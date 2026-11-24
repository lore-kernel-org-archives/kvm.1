Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521496;
	b=1QMmjdoZmQCahvsNCkuTDgpb/HJVcJ7Yu5/vae59IcD/BMrUDygIqniPhM58ZiUuIalZ
	 avBb9wbBZ7Zh3QXZJ4kx9ku3/tYYE67EA0jIvDjt4QpOifCE3s7x4DkkrHO/7EfyCsPyV
	 PeKK0WASByA6NRIuQoHeOtKC1eQC7r83KhTHE6i0tA8+jJKi3eGKtYjXiD+4BvXabgaSj
	 U5Zxu4jZPeC5FJX5K9f17arMYevQQEPiUt8uCPxe6+/KRslJfgpXUpHh03xGxtgg1Rcas
	 XhZOtEtVE5UuZGbfM+vptb/4G/A6odOABTTab/FHClAe2+CkF3tgM02GJ9F2JNg7KwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521496;
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
	bh=W+tzXrNYyYGMUn5AjzkQx2ISGDVV/6s+feLXY7lGZ9Y=;
	b=HZfjpN9h7IRGkEIEZPAkno+unW36cC+nSszjfvvHizOPH/TyFey0QJ/2KUKlUceb21zQ
	 o7nf2GiVVRvRwlEvJNHvX6PvHEMIe3qN1k9mYpPcsyyjh5q+Eb7F0VWgSm5Nh/ApqpjRU
	 C+C6mVx501iG3bjB4ZYs2dNa7duhh8hRBeCfMW/3lLrW0Y/8IGo/VoD4GnYz5x/57hkw8
	 TL7+/gFyRv9836BlSknyIVrN44V4jrDh8AE2hD7p0FS2654wZJDwP3a/+AWpLxT25A8Yg
	 cJvJau6Inn5igP5oC3S0pVvFDmy4DJw1BKi4uOuTLjWKj6vY3ghyV1Nph3xqG4Uecgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZeNL6/EH";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OhMiWh7q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74B606A31E;
	Tue, 24 Nov 2026 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE74B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZeNL6/EH;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OhMiWh7q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795521496; x=1827057496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PIgIS1UGQqO3rHhas0StMS5KVtb39gB+8Ne39Lx5cpk=;
  b=ZeNL6/EH2bYNeHXPqfU/Zy6DIVi3PO1hAL/7R9pgdI6oOIlLEfFtA8SG
   4ZFqj9RvZ4i7sfX+ahsnd1HXxYjMhNVUJmnd2TR3ExYtylfOWoor5WyiR
   urk1s+QC1/BkX5Sjb/zLHCzYJuQf9OoFga7U0vxUDxakQNm2Oq0A+UEZ2
   /fBT4twQKvwST9hQVsyPHxQ30rC/WIqZMSsOix5JT6pSEfe0XcYMcZl3G
   B4ctnQenGXvNGPohFi5dtBeMGh1EOngw7Wg/1dE8F4FVEJY4X1Grm91EE
   7JoOs3F7FqPleDu4zyFWlm4Rzn3vVza6I8/W5wQasX6GWZFwoyFhxLG4Q
   A==;
X-CSE-ConnectionGUID: 9SJ+AtZYQZ+e8x7UoP/N3A==
X-CSE-MsgGUID: Lh7/yH2aRXeHMWgy2/Ftww==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4396656"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4396656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:58:16 -0800
X-CSE-ConnectionGUID: AmCmOETqQGOXyoNUySCthQ==
X-CSE-MsgGUID: rhp4fpuWQumhFxlVe/ZrwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11438270"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:58:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:58:14 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:58:14 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:58:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY7v2jgGCtNmabzRjM2tItVVH7eGPPc5mBOlcrk1I0WrlsaDRxbqsQ7LiuDuk5e/B1XL8G2p1mA/PS3RkQe/eu8wNQcmbtn/zANEfFUdBeahjwDeW9KmzCrnlfkdocL/PX37L/q0AqWUCeaf8zTYOT0YXUnbrY11OGfna7FFiR0e9WamaNqP5ot5B5gpzJD1tgmJNpDT0+3sRQ80pBAOogrFwJqDCPg/MMB6+Fc1jspvmGvV2O0YFkI9Bp0G3zunc8Ph3Xq0Sg7E5bBx28VjB9YS1L9BtBm2bbWODH680keuWDlRD0JZlwxzPm1siyBSlYt9H/3kN11Mjecm6hpNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+tzXrNYyYGMUn5AjzkQx2ISGDVV/6s+feLXY7lGZ9Y=;
 b=iVisBmcEgeJsp0BFyj1Dew6dnJHiC6m9UakE69gyhJIalUDPNmIHhqcsaq7A32vduTIH1QOxNdKBZgHe0cRrVq+PkMy3mUODhyfvQsmTCWoE+St1A82Y69mGc8HFF9No7zXvMRphrsxcwdiF0yISo1qsrW+A2jzLOw7xeRgPjcq1ktJAXOfV6cW10CCUY2o4WMyqHL4XHMyfSW4Q6p5AdP0LjknwO0PKqQ3kpYDxAp7yMX8v4U61wNcE1kDt9duWQitOkhm3kVgAMxxRuY3zq7IFAuEp5D3guBg58FdWgefhRNmjz+SqnnrJoZEWZG0R2e5OWf4ZcFy8RBMhrLE/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tzXrNYyYGMUn5AjzkQx2ISGDVV/6s+feLXY7lGZ9Y=;
 b=OhMiWh7qdrVS5Jxd1Z49JvzHKS9LvqGlBXWatw0oRtGaLgEIZubrr+wCZce+bWsbcW47QYrB9dquh4YUl7JuJHSYzTai98AcZpxl+RIs4FQbE0R3e8JC2zBrcQMlgeuf8P5/LsbAQtPSkYD8tv567BQ+1MgZhdl00RNUf5uZuDE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 11:58:04 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:58:04 +0000
Date: Tue, 24 Nov 2026 19:57:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Message-ID: <awV7wYVv4D_Egns8@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
 <20261116111037.3478844-4-chao.gao@intel.com>
 <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA1PR11MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: f58619b1-14a0-4002-dd56-08df4a223252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|261026121527099003|261022075727099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PA21zgngl3lhQerfbBqsTs4GtvIzb9SUyMqwOWGnfgaPcYh7i2iD5dhy/7C0JsGFmS96rjvK8wkiKirHaK4NhkktwGdnS+p5FpwxEmAUYrk8x29KmSLuCY6Eq/JoLfscTXqYP8IR8UYKlU47fLMuGpkayx3Wz81eDv+l5gedlCcNfWAkko7rKEHOURo4gllIknLvOHPZ9XdKC+C4FBgvp+QYg+RibJJ1Bqut4unYKQ/AfzrRo0467sO7h8uvyhs2WgMlgFI+fK8j2YR36+A6qEY4PX0fCN/NtakD41+wWPwZ3QEeg+gifNgaY5z3HkerTkko4O2JfGDmXt1zGNKuHrmLxNkTxaecEx9bgNrGB4tzA9mTkzrdoOLt81BrEgGQFb6hFSdNMZMW2iSc4ydRg99bKYAj1SIES2gYtUqrV//dnRwa5RN9Q3QdYhX7xwfI98JpCsUTwSuGunBe5jNa1YYuEpGRDrwWYk3Ucw02fqDO2Kxb7bPNYlqHu2T9yASOx+DoHRfbjjtfQiUIrGCrjJ2wOgv8ecepSRLpqRLTMMriWNJNWM51hnca9RyjETMSk/jKjFMJjaxb0QLU/MLX/ehTgl3FaSPIgzny6d2jnUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261022075727099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GW84FCmoXKuA7IV8Y+LkMxCiUHBZLnni62RSYDrEivQmqIl42edeKEyNKOFw?=
 =?us-ascii?Q?uqGZOVfHroALNYPYyYbYDLo6AdevtoWxlbNTs4DxOgxmpimefA7vJghPAT3s?=
 =?us-ascii?Q?YiA0pBnLg5d/86DncPHa3aGzBUKQcyDX0NRYGoWeOOmQsOUGYC81gYdaytsY?=
 =?us-ascii?Q?7fbXUz74yUiYR/4Bcyf1PpWcldvQ0aXZZyo9eoLZdwTHLFB5A7cxID+vQZ7u?=
 =?us-ascii?Q?HD84a/xwBf9l4OiraHqSymHc0uba9JpKm+mUi7GmtglPvTEmRarmRofFwtre?=
 =?us-ascii?Q?vt1XOmwm1cVM3/Y0GSIMyduUqmhIOb3ZWVDpa2AgOPhOMox2u8wWMZCz8Qw2?=
 =?us-ascii?Q?+STjskcyrLsm9hxlLgZa7j8ecGo+O0z/5AV6pXE+pBbZJL0Hl/Ih5uCsGf3x?=
 =?us-ascii?Q?f3jF38CybjK+zKKaNh2ATuGq7Wf+ZUxQTBppJbEhMmb+o3qKdtcbNs+7njtv?=
 =?us-ascii?Q?bUe73Fpmwak2S6yiDTNKRSAEZbnKasC5q8/ac71ZP5nZLxLG8Jw/4sXybjWk?=
 =?us-ascii?Q?KZKeMNhKuhRq8Y2fWBa5ho2gm0/OHX+Pq7KCkuWNLSw6NIfjuDa/ae4AhQnJ?=
 =?us-ascii?Q?45CC1bhBlHGvvjrCCt8gG8JpBfTNtEjdcofEEUSj/NRZ6dn1nt4Hs+tuE8RG?=
 =?us-ascii?Q?kDh5Ye9TD9qT+QrHKy9hZW3nHeCwkB+YyvHXfW3CffFVJjrG5yDe9fXsLBIX?=
 =?us-ascii?Q?8OftiWfpTgEOi5UYK1e/0axlc08EuP5C8iiXEv4Qzv60lYQuNgnBd1+Zw0g3?=
 =?us-ascii?Q?Gj1Rcq6D5PrpcY/b/SZUN0M8NnY4Yno69x0CdF1HRP/RmLFuj3dM7lwxSeSd?=
 =?us-ascii?Q?htF0DWJEcOlZbVubulEJ2TDmfu+c6hW49EZ0tXNolyA+m10ntlL73wurarJO?=
 =?us-ascii?Q?WJIfKSlDG8xhrsFUpeAqN6v9IQLJTuj1oahhCVhEFa+NrhVoU2/pdjjkSnfm?=
 =?us-ascii?Q?sZfmfZRJ8vHM+IvBRwiW1dbrRP++RkKsdsr9E0kFFhU8Bhs/SoT0mFWJBv6c?=
 =?us-ascii?Q?3JBQrTdMlHRSEP1ILc1y73zck2zQi2Zvu602UCBNML465yriFUDZ9K9MCSWg?=
 =?us-ascii?Q?HGLyS2gT7S37ucDTco6rLi8mhLrW1qZAwcpeshrw4HeLyTAL7c4zGy+LKp4B?=
 =?us-ascii?Q?k/1ZnlHAw0OW5Y06xE09z8FSgmbRcOmZeiV78VMjjDLD+YuqENtq6gKzwHtK?=
 =?us-ascii?Q?8CLmpxyPhwbWp98222c1nH2m3tqFAttdUkEh4jyOgNPHIYLZrT+qdenEoIdb?=
 =?us-ascii?Q?3yh9VgDftjGu/cWD/1t7T/siaXWn+z7egj9FwITyZDINJxMWXrXb4Ikjkpdh?=
 =?us-ascii?Q?p7j7JE9/2+SyZb7B0EY+mxvZqTHJjBolOh1DmKvF/sXT5UUKeZAxf2qxT3H1?=
 =?us-ascii?Q?Z/HQJNn+tPy8FxcGJGidJOfU6gzRxn7GMcWvqA9NATKpX6vE5rowy5tAgPxI?=
 =?us-ascii?Q?s9q2inBKpPy34R8lHRJltxaLvkhkw8QqtaMkj5PSEH2UqjPaqtwRlOQdQ48S?=
 =?us-ascii?Q?wXOw6oPzB15MeQF/mVTybZsBxSpPEbI/bWAmW6p02W1rcUaypBNVMTmX2twe?=
 =?us-ascii?Q?pMmAUfdL34VvLNzvRRMULW5sbX/QKkIwMRr5I2jEk5u504/4CmrFOWzsylay?=
 =?us-ascii?Q?BncJlbWzkJ1Bdexjg389Q3EDqx7GoCH73V5/eiNEVeJOpUpwhHdbpjZmNaPL?=
 =?us-ascii?Q?vWNWLWt9nzTgoCOrvLlKcHwauljai658WoDXxO3HLHSSiSJvwFgR2H5T9v6r?=
 =?us-ascii?Q?KUMHBDdqYg=3D=3D?=
X-Exchange-RoutingPolicyChecked: g+/+YSgABX1k76drU+SyFAoobWQyyFmKkamltvH8cvupxmC+EVvbGpR+h5dpwKCUnL1U6GmB25Wpid1qBd9RWPTmuD+xo73TiG2so20eN7PJGiOZp0RBQp6UgB0igOBQiZ65Y5PzgEk1BW9AqKLtWUI68XTz49jO9stRL7QnpspHP+FzZUIpBugGgC6NFSVd1YFdki/WgSeU9EV4gGgGmKGOTviLqPhoEEGeNJV68g0qgKeQs1Uu1fiGgTy5eyNZu9DWVFLjlnGZPGNbZ2EQ6lFers/gbKNDZoPS4Y8uF9YVJyiyrTEqX/C9Ho8UQnUUboDBmTbCrP54ipsiYapX/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f58619b1-14a0-4002-dd56-08df4a223252
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:58:04.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loXksFvNVNKGEMTchaVKAh9/ZGq6luIMT3UC73Sv/gc+SvWBDKwgEtrfPG0widNETrUWYMx+8LjP1ByQtz04Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com

On Tue, Nov 24, 2026 at 08:02:08AM +0800, Edgecombe, Rick P wrote:
>On Mon, 2026-11-16 at 03:10 -0800, Chao Gao wrote:
>> +struct pci_doe_header {
>> +	u16 vendor;
>> +	u8 type;
>> +	u8 rsvd0;
>> +	u32 length: 18; /* in DWORDs */
>> +	u32 rsvd1: 14;
>> +} __packed;
>> +
>> +struct pci_doe_msg {
>> +	struct pci_doe_header header;
>> +	u8 payload[];
>> +} __packed;
>
>You mentioned DOE rebuilds the header. It looks like it doesn't have structs
>like these because it uses FIELD_PREP with masks. So then we just have duplicate
>definitions of the format. Ugh.

Yes. The earlier version [1] used the masks, and I found all the
le32_to_cpu() and FIELD_PREP() hard to read. I would prefer to keep
the structs as long as this code stays in the TDX-TSM driver.

>Yea, this is just really unfortunate like you pointed in the coverletter. We
>unwrap the header using all of this gunk to pass it through and then rebuild the
>header on the other side.

I am now leaning towards moving this code into PCI/DOE, even though
TDX would be its only user. Stripping and rebuilding the header is DOE
format handling, and the PCI/DOE core already has the definitions and
the code for it. A TSM driver should not need a second copy, no matter
how many users there are. That would also remove the duplicate
definitions above.

>> +	void *resp_payload_addr	= resp->payload;
>> +	void *req_payload_addr	= req->payload;
>
>resp_payload_addr, and req_payload_addr seem unnecessary. It's not any shorter
>in the function over casing to (void *).

Sure, will do.

[1]: https://lore.kernel.org/all/20260327160132.2946114-25-yilun.xu@linux.intel.com/
