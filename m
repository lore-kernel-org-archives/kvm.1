Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13EE1E8342;
	Fri, 17 Apr 2026 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403767; cv=fail; b=QJS0HcNoCxpCi2MTPKKcoC515MpG3Fq632fEo5Uw0KSIi0Uoe3W5gqlTmXL7BkuZNgbH59vdXKs5pFsIfRUfdmiqohSB2T3sENMEqpJBYFTwRPay/XPzDU9bnYZl0gDPchv/kmpW9RGcTLbE0lnnI0TlRcepESdEQsWKPNAV3D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403767; c=relaxed/simple;
	bh=9qf+ikOZtpS4WWMokqrxFHODP4ekQNJbbXW2WrWFYkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FCEtF0TeEoZ2Tpip1cHe8wtWHVX9h4iGjTb/3xNUWFEP67bcdrh37NLTv4ykKrizHnCyKHIQitsECahAy9iqS4aGYk1scJNMipH/D16FWfgkXNNoZcJAmpxw1B7kZP5zVcln3fftHY7+SZe97Xqe+ZjuxjGRhjhs4TgaiPqDr2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds46flo2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds46flo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776403765; x=1807939765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9qf+ikOZtpS4WWMokqrxFHODP4ekQNJbbXW2WrWFYkY=;
  b=ds46flo2iHYd6C3ft2AXbowEWvihF1pc/LVi4bxNMx5RKyiK4FkOUQfK
   +bbOpv6SUHGIxOCxNM3ks50LS0tRF81tR6kwV2DdfnhJfvlI6z5/2ts/G
   sGAACxBWy0T9hLN9d76+9+GNX3seRpl6wTuvGxQn1rh15BpMwzQE97ocH
   0l1TDGegjcl7oY1lTbkbbkjqww1OKzCT031I/ZE/KgTa0uEWtNzyts6sS
   ABLVVIUfl8JT+52aV/e15IGhilRDOuTfPCK+RIE6UN/gt6HpJTvQgvllz
   +qaVg9QzFxRn11WDtNLQLxrB7XJhzdtufyBLxIWoXL57dhRJmDJZYY49c
   A==;
X-CSE-ConnectionGUID: /IsidoXLS/W6Xj3t4FImTQ==
X-CSE-MsgGUID: BX/BAjh8Sg2u6Nfyayg4yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77595143"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77595143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:29:25 -0700
X-CSE-ConnectionGUID: 0V0486z9TrOZkPO7JCFrbQ==
X-CSE-MsgGUID: oCwz8oj+ROGbwitZJ5mspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226256082"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:29:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 22:29:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 22:29:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 22:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWMT2+H4UCO3KCbq8S8zgi0ntY3LqW2TMlP9H2zAoy1rJh8DB+nFYcz5kYRzUvw/vISeCL3BlX4FDpTh2E+LktcCUuVY9UhMgAw0e+GwLPUrGY/HDdORgkQSVSknM/PGapo2M+LMKa6Br2DXuuKbpXRT62wW8UhCZQoJSWqMef4Qlv7i9lx/jWUywW7t/S7W+JhzOJtKwwwL3bTLJ165adiDOKJge8oCINu0ay2mM1diP5xFxnKpcpTSYttWPky6mVr0lkRPouB/yiJ/acI5PoMMTyg9uWkH85t0sMldTUkwdwP//QWJBfb2UK6CrTPwFK7O6keL/Ln2QVkgk8w7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+4EqM27wFUDAOS5uiewx/ltz1Q+ildSFB7W1s2lagI=;
 b=GBQ40IB7IeRyItyAqQr33f9ZuHxTB11Pjd+f4PFhzbq2boYMOhlniLsugXtGLn6TF5fZORwyj4edtHN0Xmqt1aSB1kt3cdv23sA/vs/64LH7ZriVOcansqZ18Yzc+ZxhxAhge6K31C8zXKp4bWfOl8H0cpOPad82DPsr96Rn0DEWZ6R5c3XVvzHAD/VM0yvBvWLG4q3eftHxsLtm+wxwSrkyHzt8JIK53nnGMVeQsJkbLQejWP6WaxB5FWhqgNrm2gMM2vY+fC8fuNf5OOuNjhIGZ7gwuUUQnpm4E7bkCgCXcNBtG46Q//inEmuHAbMDcmkEnFhlGk3RWfaWkP4Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7607.namprd11.prod.outlook.com (2603:10b6:510:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 05:29:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 05:29:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Matt Evans <mattev@meta.com>, Alex Williamson <alex@shazbot.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH] vfio/pci: Clean up DMABUFs before disabling function
Thread-Topic: [PATCH] vfio/pci: Clean up DMABUFs before disabling function
Thread-Index: AQHczQRJfwk4k1ixNEibZH1dbi/Jq7XivCWw
Date: Fri, 17 Apr 2026 05:29:14 +0000
Message-ID: <BN9PR11MB52763A2961543394DBB718D48C202@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260415181752.1027604-1-mattev@meta.com>
In-Reply-To: <20260415181752.1027604-1-mattev@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7607:EE_
x-ms-office365-filtering-correlation-id: f724df3b-9d0f-44df-8c74-08de9c424335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: n0niKnBW3GhbF9+YmbYmbXX/JXR10jOvakdxa+V6zrCrsF8fFUPCy7Opoh3c3RtSwXk5R0y3ixdXmhRTJT7q6qMm7jlOa8GoXbHF2c5y1bkvwEC396xkvkA519Xbct4QoMEtGVcRLq7U0zldCK93dd2tGVmq8euPaNn6R+pyPR5dNXkwVwF79tSsjYkblcJ3jbAKoluKLQDKaV7+i1cOXOuoP2koypYrfp1gJkDPvM3i3+NHpU1FtHsH0fvN6UHYTDE+Y/5gd2eRLyi6R2eNaGvmA+CwRK7CAMMaheqZCbTbf4hniF8FA9hMWNm8OENo63MI9qNyLCcc1BJ/HXEyl4p+yAT5YoCsCpAtx1M+2xibhmLu1A/NfQ1Ckg4hhVylKPoD9NQlb7Z10NKZNnzEkrJiDWspDkcTB9cPiNlH591v/Ky7FaoxgUEzS120H6dWycA/lVWoRBbZNunHxMRAQONPjeIPWMR6DYYg7Hydvzn44Cr30iU812yKH/ejcFe7DIxEhqFN4TfBeaXf6hSMklMzpcuesXz+F7jhhHA4lv0tA/JIFJ71onJ0QNxxvcoS10WbYV2px3ZCR3eFAHarDEJbxkmnjVwogimD/FCWC+bA907yune5/bW83/5LRYqmG5QaVn0K6yCz3ZCOhpgCB5pEM1kzQ+tXu4IsWx6GCw7xjqPT0iNNzcGZoJiY7c2fo/UyoXXYaLzl1MSWWg3BiAAPmgKsNRfUq6u22CqUCkmGmXfusc988F1U/3WCpa3xBWoQWXPAuUJtJBpHFpl1TQEbijpD1/QTgM6Im5/dFb0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2CavLfYaCNnvhohUGD/eOa0T3Ks9xKHVppc0EIcLPRinZQni7uYdOksxkVfT?=
 =?us-ascii?Q?Io8CE6eBXRiUYi+vREcQZmIn+So7ZgeLgLLnmMoftK/UHYVHRrm8IQ2vcYWr?=
 =?us-ascii?Q?kpLYFddbv48GnpUG7YjH5PlQK57TUeovgo/WpEgpPFHUzQ2ykINPaBjtqLMk?=
 =?us-ascii?Q?mgac7BxwUK8eF/0URLdk/MKIeNLBpRMvRxbe6mCQvu+tHoRbJpytJfLIIEO4?=
 =?us-ascii?Q?R4A4Y+XRFFZyZ2VTKUsBWLP0XF/0UIvjP8tIiW5hkj6WngqQeRiLuypgRhQZ?=
 =?us-ascii?Q?tp25IztryrXr2F9/alKFGgpg1nO5lqH8yMCX63rsV37syMDvc8Zm9La5tcOn?=
 =?us-ascii?Q?cs20K9wVX3wEoGjEwcaatSJ6wmPXVZgMNUzm6kAXR3gj6XfmbCMOfWHXdubf?=
 =?us-ascii?Q?4rxpGe9R2TfEOk6wHf4o2Ano6xLNGHp+UBDnCf/JOH8KqgXTgLAgGVp1HImn?=
 =?us-ascii?Q?gci9Y0rJJTzEiqvbyblCnprTp7u4G/5VtwrwCLttka/NPrbixOiFRcMluv0s?=
 =?us-ascii?Q?C7QgV1EKc31JJKtOZdZm6KRTVx7jvdGYfJ9q1L16VEOrrwbTeTlI2bXalmHU?=
 =?us-ascii?Q?YypFOma4KyBz5zA8/UXzyKEylijwskhkQjdNvBkJM1clog8r8lXD2k5J1ZGK?=
 =?us-ascii?Q?6y3eo8rbbm52VTp4RNlYTOSMWv8W5Lv/K98UuTzRVC4G+tseCN4oRxAvePtJ?=
 =?us-ascii?Q?kWlIvKZTtYC/p/dSVaj6ZjJs3N++dboF5h7nLp6i3woYqd4QyWn7NLVaX7LV?=
 =?us-ascii?Q?1eaMXNVTpjaVEHDIfOn1S6fvZaHfPXz66di2cN7izt9Skq1X8Iwkt+NIDG/n?=
 =?us-ascii?Q?Sw5yi0ZS7XiTx7v2UqpLbzGD9IuXvKCO3ZmjEI6g1oqW4Gdo6cviV2oZlT4c?=
 =?us-ascii?Q?KCzHo0HIyZ3KhNLzX7taYVkz3YMrTMcLpyfQ98zSiEVXVNjYi2vDn4hWQyHP?=
 =?us-ascii?Q?p3DsquVAzScgdDj+U4ZOTJaxYMUlYcD9DRIzLtzWlHcAKpYLeXuhoCtfIo5b?=
 =?us-ascii?Q?jVpr5IEsc7H3kxuGdgmLwCFvnRkohHjFI0VEbNLf3R2cCUxD9YD49bEYzboq?=
 =?us-ascii?Q?SVtXTVoleuV8GiQaHGMLF4yhIr/kkqF2NGsMJbYv471v/TPJ/u/kqJaD66Qd?=
 =?us-ascii?Q?+859CTozoug1BRqhAGwj6nAZSNsppRJLYsjbhg2XjkfttwFeFRL2EtSYkplw?=
 =?us-ascii?Q?yeNQu6FvOdPdSWGUjqqrBr5kcwWtGmrtXLWmr41ZxU8xcPsj//m+gTEHo1yy?=
 =?us-ascii?Q?nBSEBpuHcOPRE3tFBNbSqnk8OPGaxPF+XEACRCrR7QqnTGqAjbdShyGzYlM/?=
 =?us-ascii?Q?AHwmB3C3ul8GsqgQL7G8cBIB1YAHcS3249ONz3YBfo7WubN6J1KtKAYvHRcg?=
 =?us-ascii?Q?w5HI2WvowOknQG3z/qchzlUaPSOBA3Dbv9x+tISsyjfi4gB4Y1NfuzMQ+DpN?=
 =?us-ascii?Q?q3pDNG0VKBdbGv5yvWoYrIEwZRZxv0a3YkhEMyz4hmUVd4ITwN9f81zP5BZI?=
 =?us-ascii?Q?RTd9hLDDNJX9J5Y8aWBoZKkrTVLpAwoVy7psGWmlGfgTLZtTHjHQU+683Ote?=
 =?us-ascii?Q?9Xn+bGcTn3QsTd6MrAg5b8W58e9ozufN6wzVyfVOsr1ZyoU+1FgZIAMcs16g?=
 =?us-ascii?Q?XP4KQ2mLGROrS4nDNX1sR7djHFdlHeFb9rhnsHZVjvOpbSsEPGhR6AxCSm5h?=
 =?us-ascii?Q?MpiQAmeCgv7ROcQrBMaMmQ2TLL/HuSeRkZDFaKrbJr6kiVjB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MOe+4swGEwMWcsWNF2akj0qFddyH69QkHZwkdwpvz16Lg3TPBRHiXag6yX2Pgz5PAzJM0jeArVK3ENc/qA1YMLsu44qysmewyJ0oqscdLYMpa3NA6mnq5XmhDeu9EMW6R9nq1I+i623JqEhm3mdl3bUHz9YwfmH7nIbwboKGHZrdEEQVA83H4e9w6h4hyfVgWN1c1CcF07Tojw/z638qWiG8dQwJO72iM+Vn1GaWqgWORtJfxLx2sZXpo00b6s2GCu3U3H2Ewk2QKPLcSXC7KqLz3zGgiMKht8D3KpDJsphY2X/L5sBzuELxNJbvhOqYADDDp1B5P3rONPW6mVzkpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f724df3b-9d0f-44df-8c74-08de9c424335
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 05:29:14.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjL1NHVCNs2suCGyoeT9kFTvQAyCn7qMQWoukAAmjYuH6spUl8WzzxfttcgTN0hVMtKjYWlnQDI/fpQnCX0bPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7607
X-OriginatorOrg: intel.com

> From: Matt Evans <mattev@meta.com>
> Sent: Thursday, April 16, 2026 2:18 AM
>=20
> On device shutdown, make vfio_pci_core_close_device() call
> vfio_pci_dma_buf_cleanup() before the function is disabled via
> vfio_pci_core_disable().  This ensures that all access via DMABUFs is
> revoked before the function's BARs become inaccessible.
>=20
> This fixes an issue where, if the function is disabled first, a tiny
> window exists in which the function's MSE is cleared and yet BARs
> could still be accessed via the DMABUF.  The resources would also be
> freed and up for grabs by a different driver.
>=20
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO
> regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
