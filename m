Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA23563E1;
	Mon, 10 Aug 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343782; cv=fail; b=kUJm02GxYklcq4mCUw2HIJhLs90VEQyj+Su3C4CRsbms1t/XN17CktuL6drDHgVbwvJJkmJ6QP8ZSsgqBCXR6/3uApaijm1q/o8FccqnTVIpA/Kl8S30cKIFLUepv2K0WgzclKkSEurj+KF4fsSRQToULmB51hdPq00jw3xaw1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343782; c=relaxed/simple;
	bh=faBsPVlVRwVhpvvoKQjEuFhV2MuZcWm1RAxUV9K/fCE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oSB1W8jdDFcm+AtDxqlPmv6cilFNm0BLfsSsu/3g7DSQJXO42j+mYApXCLQeW8P6/3m1/qJeNib5O0GAActyQ/XLhM3faCX4vOHXsRpkJcrut/J0DpVceCIES/JB6hPnMqkB5hPlhjoeBokatQP9tN1TA4g6JXjJ+YeHmKQDMV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWuige/k; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWuige/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786343781; x=1817879781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=faBsPVlVRwVhpvvoKQjEuFhV2MuZcWm1RAxUV9K/fCE=;
  b=kWuige/kpKMjQdyKAIvxq9V2IheJxbeFGrcaV5Xmgb7izdM1SVABtBoy
   AFPrUKlgjHoCreVsaQEH/40gkNpZcjs6DVpXNQFa1K+yZClL5R/QgzkcE
   bKQcqHx53Y3+Jc9CdhPIbk+/PwsoON2JsR3ajk3EsyEW7tXfSNPgfHjwy
   MLQmx98amK3QNjDqnGD/IHaM9QbFfmTukKaUIJW2R+5b3if3zwqMgx9Oa
   iD/FzBxOL6ztLfbiOV+BACHiUgY/oJYI6tqqsYuN5k+CUfTQQFsLEayhW
   d1OI6mORbQKcYYgu+rtYwIDen2n8b5pVClzMf+1VM3d2hL9srPPNhU9CT
   Q==;
X-CSE-ConnectionGUID: ED8YToUETgmDyRoQOU0hGw==
X-CSE-MsgGUID: ogYyAceMQUaOZ6aja6lOUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90732774"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="90732774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:36:21 -0700
X-CSE-ConnectionGUID: suB7QzrwQmyWBworVOX1ag==
X-CSE-MsgGUID: NEqsjAlKToCS2HJc6+Pc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="261660095"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:36:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:35:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 23:35:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob/041otd0iG1jY0IlWqM5n0qNK4h5IGlmexHz+PKmLbO+WeoMJ/j6WdD6FXpfBFGSKS82jEIrSZ8PE/AgvuPsZI0xu2vtmGarg7fvpv/pBZF9Di12CtPUePUOuB0Gc5nBOcMq07yl1MN+BDwQvAUFC1lhwI7OeEAs9YNTZf9jGp4eHnfqvan2bkdyZqYA1nyh/6KZLchHBfy+lfriAxyPlW6KAE+C+ifF3DYnFaFJ64cTLGXAfLE4LbUMQ4lE6YMO9m7uMGjjyoZFjNLKZc3g1fmCMO9fAcKueY3dIBeIrnez2Nd3KNdYOgp6Fk8Ai5BEENPveS388TOQd3R5vOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwzz9bgnZ25c0zcC8NZakzQyjcuXFQA55qwKbhnCChA=;
 b=OrIxsqSoW3UQj8aGkIqFny6Hk5mdZ7RoMKS+snuhbS7Gy3wZPqsluxqLrUv645HJLw/BUXAYTLkxlxlPpShAAFpbS8sNWcyGktq6s+SxYVCKOaB9XbaKQWM7pmVSaCmPrBxF+pA7EjhG+DuYiwtdH2r+GDhC5JEPktuVkwNEVnRPnuWOOqUjXcs88EMJX0UZCXkHvq1ylzUOM00Hn1TFHFTBJbJSpQ8ZEB/YSbRRhC5ghlq/GPuQJ1v8PlOHPMStAuQEMM1lK4W/D1G7XcbftuBLLiTFvxGMgKP48X5g83qewgaqKMResdHIyiBhja25ptjpnPEY136H1ce2QfaNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:35:41 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:35:41 +0000
Date: Mon, 10 Aug 2026 14:35:27 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata
 field IDs
Message-ID: <anlxL9ube_5r2FSR@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-3-chao.gao@intel.com>
 <ba3a0c1b54770a069788adf0d9cca74bc15fe036.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba3a0c1b54770a069788adf0d9cca74bc15fe036.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::11) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 450c7959-9d08-467c-53f4-08def6a998ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fYUamCsNwNHsaLLHv2k29MWbDmNiUlJWeJGJqoPZ7tANxu/es/45jWLbcd+OMfSF4svIljBAVO9l3dgSsAeK0k6O6TtDI67yzpWmY9J4wjgOCRWM+6sxUyBgJ7XZRqy6eRSsD+pJyDGku1f8R6Pl6HzTaiaxFspgnfeQlrXNaYsarDIg/zgPUxPreFikFIaRkCABPgn5osJjRy+4xaNG1pfN2D+pYN/n+sTpBYipWFUaIvSi+cnrlws9wk7MpEu7tKe1rO6v38Ke6mPjCOcxqcO5gSFMm13mzAW0DOAsDH87vYee82ajtqyF0oWPeyc/Mm2h7/HYUg+9FMfugidR7thlLVEDwe/5h1GOvdbM3ok8XSrCPd59EtEeUDVCiS5mO1Ii2ZvuQ0I+OBYBwg4Xjl3ZHVfiGF7Kcfv4MJByz4pz+a803Ss2XOeI0LdhO6rqH6godtzy5QOnsIayx2GSlrQblbqB6yQEZvoIWkEvqtpIiyv9qXIZc4FaK5ERrgb5F8Ij4d3VqgjvN9SntHbolY1NrAGXww5fwT2hs4ZtVzvdHK7CfZmj7K/57dW6NICrSfP2cOjty/QTONQxglnu1RIYFv1BEyhUKvPH8uQ1CD0hnXsaXZ+9XLAhh0QM8H2MGEJvqW2EG7iAlfZocypXd9HFoCRUj0b77Xq/j27dKoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MiqToF/9CPX5c+Q6yLqYSe/I6+mNvFDwlXE/wKbzrRKtrvXppoPn3hXb/djn?=
 =?us-ascii?Q?h2v7xRthkHPefLaHyZrooxoOlKsFkPYKgbXRLoPssnVEkDBDUv7Okbyhdneg?=
 =?us-ascii?Q?8Tx7YhrgtzeLGiYI2CpRFS7SNg0NJAr8Ajnu6THRq7pNPjYTm+WzJC6b1zeK?=
 =?us-ascii?Q?g5eYIPjavcD0Ut01k2lgxyLAlZCsGh7JTK6lMVuunuHX3A5X8owWl94brihp?=
 =?us-ascii?Q?9rIC/ifvbgfx26At6HZcsM+nfncMEA5k3CYISZP7lVL5V/CRVphYkCRcGUfx?=
 =?us-ascii?Q?EU0gbLGc/g+4DWi7OISMBMO6ZaMTiD+Iq8ab+N8/UGZWI3WjrjUoTGJ2NG4n?=
 =?us-ascii?Q?OoKzP34iU6LfeGS4WoyOBwJDIoxc1yRVtuG4sPmFqpdooO2JPkWSE2zX37Fl?=
 =?us-ascii?Q?4x4nYYU5W+XoXMEwYXDC5FemFJvTGYsCdBfPdPpON6KYOLjhhKWTTIACDwVP?=
 =?us-ascii?Q?7bqUCCn8RkSgqAp9mteSKp/WhBezhWZ9jEy1zojDhH9uPF1r0ZOV5H6lwcLV?=
 =?us-ascii?Q?M9MJm7lxldwhcp/QOwO06GQQFZ3R6dWah7N3s9/agkIPLaJnQWvBYw6O9jiU?=
 =?us-ascii?Q?BBl+UZbL13/V7JuoUlcCS7IKWMCniumHx6/izA2RUklQgBAsFoE69yimgHTx?=
 =?us-ascii?Q?xZEwJyXVaU7ULzBrV3Yg/2NQB7EEiQK1NHZOdbhfopDv0O6cuYtFqbh2rDi9?=
 =?us-ascii?Q?vQy32EaPjQxhXH7sM7VMNhyDb4h3FWge3qfWKuFepsY9G7cAr2VGfVnRjxW+?=
 =?us-ascii?Q?7g6D6AN7a1L5Mbbsqr/1E0EGvnf4SnlFvC3nfJWbo2ukGfHJDAbXdI27neY3?=
 =?us-ascii?Q?9AhMy/AIRpVkiVN6e/aA7EELPrGi0tB8YK6iwJ1J1T7DI7yyNabzbjLB5bKD?=
 =?us-ascii?Q?RFFTDkhwscen+2+uyx17amNC64k4ZTWqUjB3/1ThawQsWz0TpW/Om3Vq7pYn?=
 =?us-ascii?Q?HBYii6Mx2h3Vy9Ypf2OChvRsfyFnSlX1vkTdWmfJkWedCfJy9xFn2ld9hWyO?=
 =?us-ascii?Q?ItJmfmzk6WZiNtb9ccj6TJJ3mnn2YZdDo6EnOqcV2CCFIZ8ffbkVzNNrO8pF?=
 =?us-ascii?Q?KylUfiYzoQbuJjU7D8jMo55bWQinmtPMDtTURtmUi9rYVW0S/sHaiecOsicu?=
 =?us-ascii?Q?qjZot7XQF6PkCyC6Z11Mq8y3PDJmdNVynHwGE+SVg+Mhjs8zM9pN9yqJvbMf?=
 =?us-ascii?Q?YReWVLVYG0fJJYHHF6xope7ZxHrNQtZxikuAgIB8DxIL6AvAINYq01KfRNsh?=
 =?us-ascii?Q?eOE0rIO7UBZ2k3etihqIr7qgVjyHtWTtiDoRqs/zwWr/FnREY6KPCOo5rE53?=
 =?us-ascii?Q?Ytd0a95rrLkJqY6xHryMVV+4JNPpc7rcvsnmmDi/c0nXOFRyuplPf0Cja02/?=
 =?us-ascii?Q?kjOB9H5jdQj9nweqRVBkeHayJa8drDOfo/2iHvh1O+UV8NEoWY1FbU4Qk4cb?=
 =?us-ascii?Q?akMiwinsZWvA7n/GIJG8SRBAa6yafhHo8c9BtK9BY/nErPD2OKhH/iSOZugp?=
 =?us-ascii?Q?m2x3jz0uz3Q7Fm/JSg1EuPD4NUWEzpsSdFV+lNcEzcJqFM1MAEygJxCBRpWG?=
 =?us-ascii?Q?w97xBp55PZKKskzQU6jC3o1/yUw2ILlXKsY81kkxuJaC7KnQEz7ehKdfdaVC?=
 =?us-ascii?Q?jEphuKkuhu+zcvBhgyJLG6pTupb1R6Ebn6ii7E7i9bdB0bo6caHKVNPRjJ+G?=
 =?us-ascii?Q?ZNbtR13SxEkhVbZGJWdNTkNijHp0luEtABBKO8HkHQ5XQ1Q87ulgNe+QEbFA?=
 =?us-ascii?Q?JdafW+ouIA=3D=3D?=
X-Exchange-RoutingPolicyChecked: p3+e+DqE7scciDpwCwqUCE0bPM9arKuumwqIUP+mxQ3iwqDSGK08pFTyUeXgKaD0i4Wjd9dGo0gOsfkVkEBVa+OMAVNLiqCoHdEHE5f+ij3jRQCyQTM103wEZf09xfzvTFIzEtxGsbLuFBO1+DYgo8xXnJiTsuuw8TgkThwGwp24cRVOUl7b8L8oV/Wkp1mHs2UOthBLaqJvFAqqSb8Jugm5yKsisTdf9Zfvyd/vb2fQ/Khqj/A3gvv4CD4R04OCNg//3kkk/nSleFI6aGPfYMm1GUaCs350JEXBNFCWR4kdkacQygkEzsFH/6B35nf/VOLDiLIecFOWD7YtgHh/lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 450c7959-9d08-467c-53f4-08def6a998ee
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:35:41.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsUgj63xZwG/lMMmChLr3PwG31qyqUPjfU2R0WrrVZBng0JKG8Rr3u0isR4WoZ0OJ8ILN9fBwwWo1UWJVHzI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 01:10:54AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-08-04 at 04:29 -0700, Chao Gao wrote:
>> +/*
>> + * Global Scope Metadata field IDs.
>> + *
>> + * See "Global-Scope (TDX Module) Metadata" in the Intel TDX Module ABI
>> + * spec.
>> + *
>> + * A field ID is a 64-bit value that encodes the metadata "Class"
>> + * (which Linux mirrors in 'struct tdx_sys_info' sub-structures),
>> + * the element size, and a per-class field index. Each ID below
>> + * is paired with the C member that holds its value.
>> + */
>
>I wonder about having a macro to construct these. See "Table 3.55: MD_FIELD_ID
>(Metadata Field Identifier / Sequence Header) Definition" in the TDX ABI spec
>for the meaning of the bits set in these defines.
>
>But I'd also think it would nice to have an easy way to cross reference the
>fields between kernel and TDX docs. We could probably consider adjustments to
>the docs as part of the solution for that. Of if the macro makes that cross
>reference harder, then not do it.

I'd rather keep the plain literals.  "global_metadata.pdf" [1] lists each
field name next to its ID, so cross-referencing is already easy.  Macros that
construct the IDs would make that harder.

[1]: https://www.intel.com/content/www/us/en/content-details/865803/abi-definitions-for-intel-tdx.html
