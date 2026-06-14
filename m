Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E9175A87;
	Sun, 14 Jun 2026 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420675; cv=fail; b=kkFowXsCMGCcyaNDBYsKpAz3F+sODYB+p3qh6SVmVN280r1AHLNfo9i3TqxJ1MyJIbWhBil9hEoY5ICRfKXA7FilX+MJohr8nQ4UxvkEFMqu2jJP5nmTxVwJErgkCPOmqnPX1jqUU2s3dyVzCHa9fkQomejtXOCRTlotOPOizo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420675; c=relaxed/simple;
	bh=XpHhWugiOTUood8FiAtrrE9wuTJW2NvqzqE2BjLuWyc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKZ6s8DcL43QDOWrDcLAIDGOq8GhQ6cHKOdB0bCX0PXUS9P0sR8JAcnmQi9+2schxgFPvCRTY2J6i87MqJHB0M9iOQEggMbO0MXJaEAR4VBRagoCOhFhpzC6mLHYdwy7xzzU+c8A36LholGZkBAiGnZTBU/fYa49XnCALnf9H/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMz9Guvw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMz9Guvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781420674; x=1812956674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XpHhWugiOTUood8FiAtrrE9wuTJW2NvqzqE2BjLuWyc=;
  b=ZMz9Guvw52ZI7+C5NZW6cAJ+pGJhllJot/OhN2kYtwwu+oGqyEXaJv2y
   3wzbUVlIJAJQwwAZrxbk3gqaNH2Q1rY7mj0VP5EN8wa/TXxJhWO0N/RAZ
   20I0W0REYCKQBDGMJT4bwHFR56SE2YvEFNH0BJKUfz/OC1t0nkykWm1QD
   NPbCA8uO559gOB49O0+Q6wzJkrRI+Cw4k/QOm110UiJvhfj3r3OewL/Tp
   GPJDWEDtpgjy09PIIfypH6BI3dwUm0WWLjHAo+1G9JgMpo52F9LybdRRC
   D2YETSUVWagr2bCFAHY5vj6dsufl0n/TRJAoTOvyWbpXFyDMyDQujoEGi
   w==;
X-CSE-ConnectionGUID: GAlU5NdETWuvRfSJlsXt0w==
X-CSE-MsgGUID: /8bOAY6NRLKo4aDoX1ciZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82258103"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="82258103"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:04:34 -0700
X-CSE-ConnectionGUID: k5mwUYDCSbiqVSb7PNZGKQ==
X-CSE-MsgGUID: aT8ylGMIRsmzuySi4Zqpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="246081349"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:04:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:04:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:04:32 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJq05u39rJq00Ns9RYU4LKpJDtMfoojpCBjT0gq4G2l2O09OxPlUg179jwZ9N0HaxszYiKaEaVjfwqnwlw6P6dPb5WVA1MDfBt++fcyR5FxHYTUxncZYdOnhu0MlhfVb9VCw2onBVA0n8OdZ/eDwFI+qdnO7XnQsOd54WztBPOhhZwKMU/pzuxDE8rdfSpj1z+SJmD1AdfCe1gcFBG8S1KLndldkNaZroNjjQABlpJq9qZF0d1Hwjv7UssackF388NYzpt7jA4SLpZfbQ7ERciHi7wk89leUfKD2xhMRPe4XKUOeKwfXZeuwF27ORIhJLpquUg42gANL7XZoSygjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgSGsbSrpkNX9gHszV7Omm1iFmeA9dhBmRe9+MfM6U0=;
 b=jaxrTjedCYJVfBG8Y7hGRosZBL7Sbg2KBznpxh6oHhM+pIPXSjIqQJCxu8CZlLn7g5Gf2sLhpRJM6bSJIMA6OPQnRdLOJxO2r0SdiZE8tmDbCH5Baor2h+6k5YV/zymbc39p65fzqWn5KFdrSBFZFMJTOGiCbym+SJpatagbFACrLWmDMmStmRlFWYoRnKCMGrhonQdiyVUlJ9GYzer58po5SqEXPonirHT5gySFuwTMmKkctUl6OS9ytec6etg+3lyq3WD4IhQNL6xBdRKFTCvaJAzw6nyQ6XjVoLimC0eQb75Q4r+VLH5BHsyKUY6bc55F7A6UmLAtkBCn1i/vEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 07:04:21 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:04:21 +0000
Date: Sun, 14 Jun 2026 00:04:20 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 05/15] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Message-ID: <20260614070420.GB3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-6-yilun.xu@linux.intel.com>
 <0f4ee112-59c6-49b0-8d0b-886f32ec410a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f4ee112-59c6-49b0-8d0b-886f32ec410a@intel.com>
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|IA0PR11MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4bb558-bdd5-4b30-ab4b-08dec9e328f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yNI9iLGqgGOXP8TOrm2vM++nk7eXjkBNjxoIJzGrJLTIiqpcsvJqrd2+mGjZTDktKxhddjtqmVj04UU1cWJnVn3ldBEofnlnIB8aikI3drGwNwDMU2h2+nIvMW4UcyOaWbJb35n6qn5gUqzj9ZxY4khniTfPctzcZPnK+EWZTONwBCDuKdO5qPaYjWSthteWNTs7fDdMeK11iZzab7B1/QT6G9x/Z4OI1aSj/uY3M67DoflTidfAQk2DAknqVPQw0+X/ul9cf3Gh8RI9R9uDtu7FkYHD/EC9+yNwV++BSezcP3JeptKfm+HyrghrAtzax5DZLb2nTN0MOmXEU4E4fGsBkhhRUxxvXBeV+BXWNpxxy4K6NyRqejLBGHOOyvWlZOfBDr2cg0eiivcuAIgzurUNwSarsVma2jYpD5G80jrt7Oo2pVXPIvetpER7/w47J4C2O9AN8KLArKtlP+86mt1vrh5uZv1oPLHUuUEvJiuPzxld/9ZxxTnMOBKwGej0K1c47CrdEoD8ZV1ilWEtuZ8CW+1yRrj1gZeJy5lPYopC6Otc9h3FGJLrrQJxh5HuGmo3E7+bSexa8OMspH017e3bFfROcAEjYp3A5k6ldXw7pjJD/qpdzIOH5MP0v629Hcj8Pws+vWf0GnITT/eRwRbwRhQmD3wMRUf7qx75W+fW4SUYwEpaP4/qI1blPFX/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/SirZjb/2sQDgNWRUlD6ACQa86L23VH1/0EkhoDMhfU0boNXqwxpfjIizRH?=
 =?us-ascii?Q?mm83wrw+HCslHVEF89QvEFzVoog06NcSQ25ZlugQLet9fGHzK9GDk8NoBCiQ?=
 =?us-ascii?Q?FDfNvP4rQs3K7lNWc9ZeDfCnpKSVHWixGVmNSXosh9R2AV4OaneusCFCxsQb?=
 =?us-ascii?Q?D0BxTBs7Pc5HOBgO06DlWzbVaLtxkEAGhJ2cBD+ONWL5vIZtyW2ZMjL/Lczv?=
 =?us-ascii?Q?XUqyFHvbwXpvdj68E6veLQ2vCAa53l4Qb3OY/AbEuFVLtbki70wdLf+lt8JA?=
 =?us-ascii?Q?kxqfxkjrDRfkqpmJrqoEI1x/L0MLzsHFkzaJaV2QHmST9iE4a4WCD4SXGopq?=
 =?us-ascii?Q?3sJmhhDg0Flp1hHbcB5MgYueu6Hewew/d99N4kdlTEXv+9gP4q9E1/n9Gqem?=
 =?us-ascii?Q?xbWVFe/cUHr1wxJhrSghG6EgLfgrXb+NdZG0Y2wvmMbegfdLgacuBdHkTglT?=
 =?us-ascii?Q?eGcpxSbEfsYql7K5niTcIwDkqr/+4+2PHUF83jVxxXaD11X43iimVHEGQukQ?=
 =?us-ascii?Q?KBCs2wenYeEWuAqUjslDkSTjj+XPOX8YFM1Ae6aHC+fOhdApRYCfc+At3GaX?=
 =?us-ascii?Q?C0Abw/szsuonDkyfw/lpHDkZrEyJE6EsV24oc47rd1ObsfLdRC0n5B+uAzMM?=
 =?us-ascii?Q?S06YugkGetALhut4okxZDqhc3CgbYZjH655y3IYG9WY+44KpZat3CvSOKAL8?=
 =?us-ascii?Q?sbtq+mxzKW/b0EeotQJ8SfNa/UykkVbP40vSjLx2syIC/odIjEEMbSsTChup?=
 =?us-ascii?Q?yILTLGq4o43Mhgzn8fMTTTlrpxeULn7eC+hlb7i8WXScVGir/cwfELsUoLou?=
 =?us-ascii?Q?7Hd1RG3aM3RZyEwG4ZWaGTiOjYxLZKsRdELEpYPTTf84uXX6LsT+gBDJXD9X?=
 =?us-ascii?Q?xsuDQ7vEtOazYBq5i7fCANEv1zG74aScg1CaIp5Xw6sDQsZ9lGanyP/K9MSa?=
 =?us-ascii?Q?BN8j6YTBBGkFY/IjGRoVWS0JmoqPp9SQQQYHnETqX0XkHeTnxOdbwL21Fgcq?=
 =?us-ascii?Q?+FTMkmCPAiKsEvm/yTHlP1QWtoJsoebxP8J+mjKJDrjHowZhMF3vK8CPYhoq?=
 =?us-ascii?Q?hs2UHmZugOkMcXXGnFTZn5bhlRE4m4VOXDQTYPFNlR/chBwCZSwuO/t6WhtS?=
 =?us-ascii?Q?eyRl9Z5sFm1xYRfTQ8Ng+xUrIkj7501xE1dSabBWDu80Z2oK+LovudMENM3P?=
 =?us-ascii?Q?cPLrIcwE4colO2yj4SkgQxuSHAJhCTsq4QgVFlhtNBo4S8eSj9FV9Uc+SQVG?=
 =?us-ascii?Q?5DQEEr6e1GoAMmV/a+joX5ZHM1tv211xVKlL75+M0YOp9tyMJ4w33Kl1QA6Y?=
 =?us-ascii?Q?Qdj6Sg2/aC0jdR9bed7shmx1pMIxO4kLWadIcsWr9ASmd9qzpVj01c25rrgS?=
 =?us-ascii?Q?XuGk2btL6MXq90QKcBxziwSn6GhhPnbKBF5+vtKWWcyXbgdKvwDGGa+J8+HP?=
 =?us-ascii?Q?BHKRWJGEf6NB0SLTuSJE+K0S0qiLyAoa36akM1shadzFQMcb5f7v0RgJAIL1?=
 =?us-ascii?Q?JJahfIhSrVRhjuiXfbKB5xN0QVoTbkgWRPH7HGOHvR4/9ZAMAngT4yAp28h7?=
 =?us-ascii?Q?y9y9aH3G+SFEn39Y5H86G5tVlWjgzS260CsWk1YMump7ceWvYMOn7EVVClu3?=
 =?us-ascii?Q?fAY5Ljxzs29jL7V3tpXpg5sAoYOj7tWdylammh3r7s3vmnbeDwjXm1Sq0I1R?=
 =?us-ascii?Q?iqjKqgrQo8Wu+OfviG5UhvY8Umhe9IG76DrDrDniXfzfH/S2GVnHjJebPSkk?=
 =?us-ascii?Q?g2aBVj/hSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: dqGn/XUu/kNbLadqb3H1r1bxFxJNIzlYa5UCWDun8oKEBri3OigPZOjMkIZEvhXCJOJShkQ2BPS80+s61C9YMrWcS/PnGVh2WTpS3Z9tOT5A2oCL3HVQG3TuF8jPxUrgGrpg0XVrJ0g+5KJiVqSZuGRQSyleKvtGGBD4j3KXYpR81LlVEz8oYSfItKNz0wH0RcddKzL0J0EhhcRfwQKU9kezDI2JQ0pSROJOSOFXmqm7sTCC4GgEAji8qg2jsom13Yj6KpQaquTLSSIJQaXGKUXwcXlKQLnsxlJVpJL5oQW6gDKus4SCuUqgFZxywjYpHb+xeTIA7DAujlfI7AbuMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4bb558-bdd5-4b30-ab4b-08dec9e328f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:04:21.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WmBtGiYrEAVhs5egmhFeLWjFPnluvpCmA2VTU7kV9960TzT3iZXgKyeGqb6l8+QRoeDmWfXK5QMUiL9X1uDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 07:21:17PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Move the tdx_tdr_pa() in preparation for upcoming changes to use them
> 
> them -> it

Ack. Thanks for catching this.

> 
