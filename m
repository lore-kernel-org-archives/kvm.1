Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A904397933;
	Mon, 10 Aug 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344223; cv=fail; b=DYeQ67Hq1wjHwrMDQ/zwg6/LbY3AhTGwVT3GXm379EAJEzMlq+7kY0bzh5EVL6f+crZI2YCeutBsEV32xfNaZouh+5GU6hciCpBHQ9NY5Q1iRR4ASsSbEOX/INLgTgI0lA2ejYoBeUSezHhGFm2FbIhgZH9aMVcESUlKDPQPh2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344223; c=relaxed/simple;
	bh=Z8pJDuFxO+x80ur8jxbAUygB+B+9BaKGa9jxM54JN8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKz1cz8z4+hRW/8QIkZrG1sd5tQzvbdiP+HcaZKDNgmElLTFnamExrqKaDGTPpO6S4IemITA1Gr+BZ8UJpxxcxcbVSWN56Av3TOgBiijFCu14ahvE6NpocWufGuc8YJMsjSCcNrwMupXfl9bA/p6P/R/fUB5lXUiWQv8E7UyaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQuyTotv; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQuyTotv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786344222; x=1817880222;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z8pJDuFxO+x80ur8jxbAUygB+B+9BaKGa9jxM54JN8I=;
  b=GQuyTotvx+uyJA1fhSsu4Kv3TB9aSlRT4SJMBWXVLF4dog7K+b5DH7Er
   dUDS57BqD6xGv4yVuhdY8uIobRkdJuDN392D7wTHSXFxTsT4jcBdI/RKQ
   kJESO2i+56Op8oO/0jkfIr7hQF3GJ8ywUug319a+faduRZPJ9OW+9mqxB
   HkP41J2T5yzNGnZ/AeoTWwUUHtx2AzMH5rF7z1dV/FzK/wgvEiCiK70dx
   nJIEevITilz8mjUB0cYHYPh8SaZHqnQRGrOaLPPbqi9Y2aRwk5B02vXpy
   mLaqbUTruEyebyli8jszsBR1ycXT9SgiY+WJqXUoso7jOaohn8s6V9Mc2
   Q==;
X-CSE-ConnectionGUID: QSae98owRj2kxj0bkZ/H9Q==
X-CSE-MsgGUID: xMT0Mh2lSpOP112bf1AnkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="74385646"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="74385646"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:43:41 -0700
X-CSE-ConnectionGUID: Qdi0QwyKT8efk6sR5D5Lnw==
X-CSE-MsgGUID: pVOVX8I4SMu9VahN2uhgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259094400"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:43:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:43:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 23:43:40 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESLxuKHn9idWGyRhD1P2p2gs2dMEz7E8WVEfkH3C181TsFY1aQB2+d9V1Msu/hx1VgKDXXLfdkVtDCwSl34TkI28Jm6RK7GamCexchcl4H7d+N/eVBM/vvLsv2HxQiWhkX8iqv5g31raCP/NL2eZEJluRtb4h1mxYnlSG39H/Ca5npbfQcso2IAeu+zLRzd/y9RFQp+zAD+N+Yb9XDt17T9yHSwyqEd1szRa5cJOdX50edXGVGK+PXrn7eilbQDCQGkSHpe0Fa/7q2/7xIpJbr4MaDhGcgOJiGkNsEKybi+H4SE5m85srNPQV1BJLAN/eHnQv7C1fvIWsF+WNfzJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLg2TYZqgkgHmPkI6w7am64hkzVbXmR23lcjt2vWE7w=;
 b=Z3sJZWduYcWe/LkY3aDZGCz2mTOyH2F4MtmXjLzDKrumT38kEcfk1OYWs2PHn40YqF2FZ8/Bfu+m5x9Wfl77URjBJ7xbdu63ahf6ZUN2kM9cHniV8enrQzCylBM+vFsVV5fYorCJIlpPBxnY27W+ygN8wq8Njj7QmcVDRjMJKrh3yBNzc7J/uw603ItsKnliJWDngnkxQtYq4VD5oN/hFDZebOWGPsVwCbrZnu1miSD+oXHEcSFzAqfPKikDsAR2dG2EmGcYIFsQyt6oT3QthRx3dZzj4lQ82t+8twMdiwsp+BA0bbGwzNnySIrfJtSmPswADjcownvndcvrckWB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:43:38 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:43:38 +0000
Date: Mon, 10 Aug 2026 14:43:28 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global
 metadata reader
Message-ID: <anlzEJrnulnUtMaG@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-4-chao.gao@intel.com>
 <5e0cfa980d9fe53545362acb81e44e8a653301f7.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e0cfa980d9fe53545362acb81e44e8a653301f7.camel@intel.com>
X-ClientProxiedBy: KUZPR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::13) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e054ea3-2f3e-4ad0-6204-08def6aab543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dkBh4RnJFjnfTA1WyUSo09AeZx6eIKhbBPF0ZHJuGgsTxfJMWg9FnTnzfId1yI6ttm/0s/ieIuMqZR+9jM4i4OTNYoADUAq5ukdLpfGykAmkqkGAU7v5dhibfmoMnXeVH88Odm7JlAZyKrDl0lnVvWHQIoLYaJTc72R9vMq7GDTSVbFqvf7X13bbjIMTXd7b3pmnOc2Y6AdkizJbG/C9iw68ajzALH+Erv/Gvjip0pm3UJlXp+eJW4NBU3/FCMEorKWTzP3wdSrY0a5DOWW//WUazCwNxvtXFc9PGnLdx1C4bemzar4xX5eL55FAjBZf104u6k1Ef7ASf3om4aJx+zr/7h5t6jQc1krNTqnLGn8TDoWUJkw6dKWUy2jjgAiEYKwdL6fO6/+mrNeBg0/rvQ7duOsuyR4q1Fdm5oVaklsfILk91ii4psSdTg9RJqVdnZX8L7lwMJWYXwjz/uBhpmgvD5TrQXKHqCHtFgYkiMuOMpMarnrC5/FYIwlKaKPMDyZTz23M2NPdeFxQIrZxmswFwIA+RMXRB1d0a3Qv6Cw5j8T1zT/j+8BtHT+3qLl2T5qlqSiTrlZyD+OpFs534GicDGmq6mdHKNlHlT3IbcPMxBuHwYs0fyvy9ahyaj+s7hlgTQe/eZL71tZy1PWldA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kJKy4KRPNn1It9vpAYMynCuy2KQOsEuxlDeiUUWoUlt9L7AJGXVs6hTtlQ?=
 =?iso-8859-1?Q?7Nb+kHTWcj9ZkCmcUdD8KmOaTKA9Y58ShRgBcsQ3qtYim/xZMx8AOB9pHk?=
 =?iso-8859-1?Q?9EdsCmBxC0Ovjxy4bEWbje3/5C1kYNoFwQm0n0vwR3ZPHlv94QgesKDqCG?=
 =?iso-8859-1?Q?J0cEUbzzr7fCcLEEZk5WHPND8s98hQHCHRjU9erBWIMS5jtNcmGm8VyjMK?=
 =?iso-8859-1?Q?YfdscWAG/T3qJRdctPxBFnuH9ELi5WpoajxIy8N/0t7z+EUp/xbRUBXovt?=
 =?iso-8859-1?Q?u/JoTGhg93su3AoqrZxGWivVMZwXsQoBS2L1BdPjonszpxWjFbdD3430R2?=
 =?iso-8859-1?Q?9enEM6xGyeeS1ALAbdVaH1pcbsCuf3hF5b7VkuKhlxecL11utmv9HPOhCm?=
 =?iso-8859-1?Q?PsXB/LdJyDfnJO8uuoLUI8oJMOjjSNSBeRl1OzNiAg1qs+HBgixq2gHJvA?=
 =?iso-8859-1?Q?j8fZo6qyGIr6mqJUbdedDstHoLxLiMoGmRB/UdY41pxFC0/wDq2rqFxy25?=
 =?iso-8859-1?Q?0+aP7gpBj/QRp4DjQR522KNke6E1cU7BeN3BR4JJdeomoCz5Sk2zqUXlwy?=
 =?iso-8859-1?Q?D5Iv9T378mPCoexpnqHjpfKjoSlH6gkEHxGk7TyUeDMri2DNueb2t2bWg6?=
 =?iso-8859-1?Q?+6ZaBsRQ9h1IJM+8veTnxaVNWriM5+Sk4S4eQ2nGAhCBcTQjEdh4dcMov5?=
 =?iso-8859-1?Q?O9GuJ5+fFf+VQt1Ind0PHg8lSb2eCEgRCQYUSjgiFNYp6CNbCHGjz9WZA7?=
 =?iso-8859-1?Q?aBE+gXmDyHSv+FtnCkTGVTVBHtjLWBFwUWlLWkx+8c5WDTjhgHl5bWSo0u?=
 =?iso-8859-1?Q?9dxeHhxjnBr10gDLod5i8nhOWLD+MZ3+CmxuC1x1hDot7cChyrlUOxp++/?=
 =?iso-8859-1?Q?+ps84hfGC0pOGw/KMHfX5s2vQTAgTUFZb6NV6T9Xd5sk0iLYzJF6Qiw1+j?=
 =?iso-8859-1?Q?6Wt0tOu4KqY+uTGzx42OAE7HKCAlTieXtlH3cGvP+S2PIZ3G3C6++luR+n?=
 =?iso-8859-1?Q?PtX9SOhk+oYgmLqEtBjNaRb87r3tVWIZXIeuw6h/QwPkVdzi3JplLwsfgU?=
 =?iso-8859-1?Q?mH/NwXVPCRcYR6C4JMEJizufSXeXVh8+G90LpdtIlDqpjcrS3ib8cIduQc?=
 =?iso-8859-1?Q?9XezBtvEFUE+O1e5g4b0+9bti/VWBx+edNC/1S9cv1y0QPdQ4hrVKExi8O?=
 =?iso-8859-1?Q?wDnnP6CPqTlFG3Z8Uq+OE1ZzT7nA8/UpaCSBmnKiKzbpx40CPsgEy/TzY8?=
 =?iso-8859-1?Q?3Wd+ZztDkf7lLjZVfom4aVIbFAt6Bl4Z7Z0UOV0fGUnqmPlLCt4n9cTVP0?=
 =?iso-8859-1?Q?572LJ49oCKoziIT09RoLvTo+Z6TbsTy1EHOd3e+5/YQueLKTgwaV4GJAD3?=
 =?iso-8859-1?Q?SNXjanRbFd4CKYto0k1xZPOT74YhwlkjTYobpNw4LGT6YpMZv7pCg+aA5D?=
 =?iso-8859-1?Q?SqDjzXHCzHSCwUDo6nhJ8CX7mUHcR/CJCp5bL79S0ZzmsVNwuM2NiSw5ne?=
 =?iso-8859-1?Q?8L7iynUbNs7VQxA2ilnfmH/XbfT9pBDr1KPk6A42MHCzy7eL/ZZAfeKoQQ?=
 =?iso-8859-1?Q?3UifwqvuFSRD+8WfbD2fB6xBDlIh7biaMmZLuETPe+nGcKQ1zGGwrc1Unl?=
 =?iso-8859-1?Q?9XenpP1rf3ilOtJLBJ3d+qRmOpkNpWfTQZcihKjvkE/iO6us/PUHmdm5MA?=
 =?iso-8859-1?Q?TSuu5/U4Dio6gGMKlOg3dXCPklXijS77SeYQAyp3oZGr7a+ppvLb4Y86jg?=
 =?iso-8859-1?Q?V3c9gWbTFxf0EmKzGmM7bcCODsmL199D07u+JW4LuV13YmMjsohy6GODlI?=
 =?iso-8859-1?Q?gfgAv8ns5w=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZVs2+efCPbqv2DAvLrrZp8wfcU+siM1J+iD89aC6tLKlERA2pvjwVTA011/sBS+evq6RyYuj85kPxaQBJOxuyQQpgOVORGdV0tlAZcOAGnVe0Q8Hu/2IIYe+jdhjNqdFG9kKm0Ep7yD1eUX/pPrOuZaTWeBs5x1UO1tR6mx/+/OFfG+zGI+uetoE1sSdvZagiUQ0vIwp9v4podoqJoO0xUKbZulWWpkZqIQYmWhe7NUIyiXOuYMVNiCQtYK0KH8wPPOMngkixsqL/TS3W56wCDkpnxu12uCn9kjPjIV18ozZCMeFYo8dw/f3Etqenc61Ls3IZF8CiGnLygFtCRqEPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e054ea3-2f3e-4ad0-6204-08def6aab543
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:43:38.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhIw9Za7g6KcTkmN8scQlQwHteHOhRFcqkvYe0LZoLMraizzf+w1ilvug4nJvbbM7ViUDB6xuLiDsIKG433fPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 01:48:11AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-08-04 at 04:29 -0700, Chao Gao wrote:
>> +/*
>> + * Mapping between a TDX global metadata field and the C member that
>> + * holds its value. Use TD_SYSINFO_MAP() to populate entries.
>> + */
>> +struct tdx_sys_field {
>> +	u64 field_id;
>> +	u16 offset;
>> +	u8  size;
>
>We are supposed to be able to extract the size from the field id too. We could
>leave the bits out of the field id and have it constructed on the fly, or we
>could do a static assert based on the size matching between field id size and
>struct size. It depends on how we want to have the field ids defines I guess.

Patch 8 does exactly that -- it pulls the element size from bits 33:32
of the field ID and static-asserts it against sizeof the destination
C member.
