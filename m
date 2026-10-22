Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792656120;
	b=fFNS2b/PCdkeggA3d37a/Wepdr2sxv1cOzs/uLHAF5OYgccA86tPh9P5NnGN7mjHOLM6
	 ccN8NCB/zYuPWnKpAx3RJbDjoYqK/VXHvbpVbiWQSPNhfINSbcnWVz49CmpM1IN6MzdeJ
	 4bigbPf90bQIFAdWnUjwuYdNPRoPb74f21sFrMIuy9F7te7tAIaGV/lns7YoeTNTp/Dfq
	 HPJ24QElZLERZRy6KvHTygcyeZkydx6zDzOAXdsoYs9US0uGS7YQnQ1MIBD8mRU1BnpLd
	 Tkjz3/Th17q9W3Kn9t8uC7UUbQcMakJnF0N8MAVstI1n8cLvvK0ocxyouLBxoDzGdnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656120;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=0ScqoWM7aQw1+h0fhqIKB9m8Kf/NX6NxME+C9Q7baW4=;
	b=okICoPbxzXOo0zB/vo07KNt9Z3vzLtz4szHw8aLLD+XpEvB92YVuJTdhpR093G4PtnwZ
	 TtWsmAk8AhxkbpWd7rW5ENNk9tDxDsEN8aAwFIcqvzQsyIiUXtQHbDfBGL0HxAJ+BapiW
	 9hlY36R7nPm0cfSX5UV3p8svzcAaQOvVAomzWvtc/h1vTkdWbvw9SrJk3FQHc9f5jzc4Z
	 m4okFqmsBKXFHNzE9Sud8G0XlRYbPGFlQ9TUbR4386U8/GxCZx45PeEPizBZh9sJytOzF
	 uYhOJGS+kAaOCfK3FFC1JRDQwFCaIcHFLl/kuLbYE1jN5k/qIaZghLxvs2Zl7yp+YzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BtavZuHV;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE51606A319;
	Thu, 22 Oct 2026 08:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE51606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BtavZuHV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792656119; x=1824192119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9+T0Hv9LiWgBICgyWfgcJez9lEp+JpTvGpauDnH1Ops=;
  b=BtavZuHVKOhNzGCvfC/j+HDtByUNkcFivCS1Kh+vTo1KZoLIuoFkpfsm
   TI9O7NuMlPNBVlcK/OWqEA/Kd44Gh9cMwJR0ldh2oJGuwix18eegrPUnG
   zQ58ARjxJy+b4q8dGGOvlcD8QTKA66Wt65fLyIFVnKrOmcGSBi1jaAd4p
   rdiKHCfaGyJWTswv83XiFngYi7o7rSflfH11wry4alB5WNKtwP2SM2vuA
   n20PlgwMIGf7q6BsAwRnKHYwwKX7TvXqXgBIWJsfNAFqhYXPY8S4NN2Jf
   mULvtSQ1S3bz7YHw1J+OEmJKIOSo7fVsZhPd+JcsKpLO0mJqgIqGQ80Yg
   g==;
X-CSE-ConnectionGUID: yblLcgx6Tou2vvrujMcVeg==
X-CSE-MsgGUID: 7P434klYR2a6uOKzU1iZ3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1283808"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1283808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:01:58 -0700
X-CSE-ConnectionGUID: GVqqPiw9RK2mk4XhYqRUBQ==
X-CSE-MsgGUID: pOf2AEj3RjG8yAvty0kQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3694697"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:01:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:01:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 01:01:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt/Y+mgDsvO8e13QfLV7Pu01nNT5MA1Bd5vMAjPrXZePfFZNWk2dVWzmuQY1kvvm6jGfpyO5A1JDdqR6ShQz7w4BBK1lwULRG+fMUtyKNS1Me0VPHPqoggaKn5aWC51WMsyuWKrfrcFfe40uLOJHKqDrLYes+2MkywkT5WwLvFBNmzYTianEGutL6AKij3j7Y+ENAyqbF8ku95JXCvFshEZZYBmNkIfhqg/HweJTiFAuGmgoX3CGatnIb9CWdkKEbFbICBHZF/AeGdKlllxZHpCEhcRKrRVR1+Dy86aSxgr3/dz/JjNhqINAdk1J+FC6lf+j+A60t+6yB+cgCVrQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ScqoWM7aQw1+h0fhqIKB9m8Kf/NX6NxME+C9Q7baW4=;
 b=eXYelQZ9VUCRJYHn2h/BbAEPAvRdlQCjwQeiCcyRMm6BZer2y/BRHOZR9ZayD2pteqILoY2RDIrv2KoFHZByv3UQUBW91QVxgpQuYNLiIPH3VZBT5+aD88jTXnqqs2gwlsELlM8YDEBXIUdC76Jh3YJ0lUCRGhMM6uTH0q75BVob+hRt4KVqlFepIgw++J8ggato/onLhzWxa49b2+5NbzNKWgQ0l7Z8yp2TblffyV21FJulaWhtRcb4z9Kae+bKDTTg8h4+oFkwhN0otl1GqqepANpsiAy7IdgE9Lvv21twk2yvieAB27/UmkC9W9GZrLOrYnGJRZRvv0cp1Awrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:01:49 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:01:44 +0000
Date: Thu, 22 Oct 2026 16:01:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <yilun.xu@linux.intel.com>,
	<tony.lindgren@linux.intel.com>, <rick.p.edgecombe@intel.com>,
	<nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Message-ID: <atnC3rF_1i92iX0U@intel.com>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-11-chao.gao@intel.com>
 <94be5e5e-808d-469e-bf72-e1d9b7c7c879@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94be5e5e-808d-469e-bf72-e1d9b7c7c879@linux.intel.com>
X-ClientProxiedBy: TY4P301CA0121.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::17) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: f070c392-870a-4d09-bb3c-08df3012b663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|6133799003|18002099003|10067099003|22082099003|261021121427099003|3023799007|5023799004|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EGcMjo6AmkdQVgcnY39K69Pq85knbvNUhGtQcLZHyEDPFcAww539jRpQOm9pKafiC0FTuaajktPSCF3cIz/lAc9ESsXabEyJZ9hWG8wKxQlzBkvftaozrqOGik0KkZGeTSDwDup/jfFRzD54sSl1/s33kySmcGdPGS4X3VdB5T5cYehENU8k2F1ZMefkDiUBlnxeBPpWfga67wuHSchUDrFPqUkIUyS6hnh1JLCsFbBAGyLRzE0HdIutXZxviJD1m9O0OvtHOo9VfmEg+mJxhG5iReuX80tfF5SIa3hGXNdnp//X4zheAOa1QZ8c/EHOC2Vaw+kpFFUcJsuljqJL6sXlvI2DWdz0cLMzGMjfvKqt4CQEWqVUYlqdUoU3mxdDOwwY1bwITU+8VVQgsDsn6MLDW23NzBtankH0TBCNtbz3gjHwWoPyIBKNjO2ExGqzfpMiPlfyz9CzzF3bKVhOZ7DvorzQj7xoHhiisK4xpH915TsPeBESd5awrtuZbVK/O/9BGm+WP+b0DGZcedcilTIRtrmWRYEGZ3tn4esJv/hyqxNfkV2+8QtQa/d9oOatbEVBtdb2qX2HYOUKbjVQtBNrCXy0LmKkIlgI4GiPTZOeCwO4WHNR1ymT/JFxf2J4CC5ubuPDE3iJLNNaWYiVHGuodSzaosnLH4PufdDag5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(6133799003)(18002099003)(10067099003)(22082099003)(261021121427099003)(3023799007)(5023799004)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObtAV+LgQdy9V12iZKMIrwhaM1dLaUxW99jlB3a7uL8lfgJ8GAH/TbfXhc1u?=
 =?us-ascii?Q?84yKix2ObcveqWBjsPjjzhzHXCLqEOSlShrUYOMtLL9DBPOdo18+6hxQhYUE?=
 =?us-ascii?Q?oEw88ZWzSFdGRycln5/hkaf9PsIxuXEwQRUKkurVGR//bCMzSqTTURu/qbaB?=
 =?us-ascii?Q?m4QDXs7suKizb1uypQIP2UNfJdayL7Q0SkFaEXKMU5TNa4mgk4sfO5/vQr5W?=
 =?us-ascii?Q?cSTwDgl5igdMKEiVGRcCX0dO5o+86tDJocbAA6weI6FfHLwXqBF9H98ZnlB3?=
 =?us-ascii?Q?KQnPvb5btlqGCi+W0bLLsuJFIOZvUUtVK6V2ajHYNpanUnXNi/m0ZFhcnvPh?=
 =?us-ascii?Q?fkQsUk3XUgPs+Yky56SJ3o4Iclw3+VTNtgeWilRfSWvjYPTWtwTSImGyxCSU?=
 =?us-ascii?Q?jELDj3IBbrQDS1R4L3kSkQ3+zW969GbAZTASZPqTP3K81D6wXSTkJm0UKEBp?=
 =?us-ascii?Q?XJG+VCaTUGWRo9afP3CDPW8woPD+MJFU8YDNt9795xegW2aZPndz8vfPhp2z?=
 =?us-ascii?Q?hHsZPm9PtDdbi6Ga6g8Th0MG4QhOhwpGJKV6QC4UdOp9FcHunSNkg5zpZShj?=
 =?us-ascii?Q?w53MVm8ym/3GWlxes2x+H3v363AGESIZbb/ieYyzPUafgAK9J3cEPcMwQ40a?=
 =?us-ascii?Q?Yo3z1k2WelCfOoryoMa4kO2x9bhupcpKYMJxY7i/Y+XEwoVTmSsj9fq2fVbg?=
 =?us-ascii?Q?xumHz79PPW9G2Zn+q3RnjRIh9Owe8T47mCXZ53lKX6O1fYuvFRET6LVNiBoH?=
 =?us-ascii?Q?VQqfxiUuYFddw7GJrGJuWn6E5fOa1Yx53/ZR2sUtGr5SAv0S1C6y/AF6Giya?=
 =?us-ascii?Q?3J2kn3hmXy5egBCd4ZR0QorkegTNjOezWe5ZxM9LEny8L7RT9zIuu3tTLafA?=
 =?us-ascii?Q?Va/YO807AL3h4zD+WrPmXu3dCDJ6u53UAI++RTB+lJqcilpCBpK4DfjLKa07?=
 =?us-ascii?Q?1UVz04BNvcHj8dQZ+k8j/iqfF9BChTLWFJX0RTZtUdOwsZchIFQOMlZ9oLiZ?=
 =?us-ascii?Q?7NjWiGksZNfJHKTuxW3rR5OE0otlIzCKVbm9Il270qxle8IbDWCzQHYtMe3m?=
 =?us-ascii?Q?I0VioL9MHmOmF+WFgj+7AAzzLKozgheHmIWi93w8cO6pZD2ychBQay9FT9Lt?=
 =?us-ascii?Q?729UxeRw32sAElkaOcFqYKJ9Q97AkmOhh2mg8Ua6NwRWkXPNm9PRGX4qANOM?=
 =?us-ascii?Q?LaAwwL2JTF+WY15SnHAxqFDJJOUlunjEXZp9uZ8SvUzEjcVn7I7rNPPGGiVk?=
 =?us-ascii?Q?7vAVB/1/vXEyy0FQpQH/wf1UiIdrqJqcfGQ7NpfCYmQk5QR+PUbJ+ObZFuT6?=
 =?us-ascii?Q?iZ9MISi7EWztFvcKF/RjNen/IDvvMini4auZ2ZysAUU7ZtbFsdPPXBH8ek+z?=
 =?us-ascii?Q?cYHifKkrG9Vkjkd+ASopukmMPAHwmumERr4/mnc7eK9sd44U75Dxa52FEVaP?=
 =?us-ascii?Q?XGM2akEvdYYXvdNsEvylxwaN2ah5fbdZYyhyn9A9Vme1JQDfY/tjIoSTsw2o?=
 =?us-ascii?Q?4ePsMcDfRR1vTEVFILP3tHGZxj5l69dz9sM37Hnb0KhlGxRlSHi6kc16ez+Z?=
 =?us-ascii?Q?PshNb+c7DTBXjSzvIyV+kNqmeMr4ejDAplWP/76llpDXXIMxSAokP5RXV4/D?=
 =?us-ascii?Q?62xtt7WVgrI63pueDtzVxZdQ4lFbS9gT+t48aMyyiIKdlB0IFm+OjNLMYyNa?=
 =?us-ascii?Q?Oe/rWXLdi1bunuTuUS1gEvQhHwq5v09t1IYGqnaksNeFTLLqdjbYGJ2JPnhz?=
 =?us-ascii?Q?fWUPBBm6Ww=3D=3D?=
X-Exchange-RoutingPolicyChecked: s9YLvtjo+GhN9m/U+HEtO//qoNIxvyCTy6J0us9Kl2U4XF6iIBj+vviXfwLzQ659io7Ul2TfDpu2/GHQ1uiDuu3gusOcoxWTCX1YHENXJ/vdn3050NG/J5MO+6U42VZrFjAgverdeEKkatk6wBuUq15MLeRpZ9DopYnLbR0i40umfpl8sBV/hIrXqZ0vvmP3LTeKRdV0LSLZEYmOpvh4cgfxJOcjlJoWUMlKIvHqpYUJxikcc+fKmcx+fuI5J5e3P0DzyDylYtZsZwzDF5aNLDpOcZ6dRJxVTsYZrweXYjYxaMfdbtOCKsCkhnDi6t6+gLzAcAiwnr5+xrrYt62zzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f070c392-870a-4d09-bb3c-08df3012b663
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:01:44.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyMHtpKLzmFQhPcCkQxkUcgdvR3isWACgp940KGeLOCa1vtG3FYfOczvFauuHUkDzMIAko5A+CWG9o1dh1ps1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 07:10:36PM +0800, Binbin Wu wrote:
>On 10/12/2026 5:47 PM, Chao Gao wrote:
>> The TDX module reports its capabilities and limits as a set of metadata
>> fields, each identified by a field ID, and TDH.SYS.RD reads one field by
>> its ID. TDH.SYS.RD returns the value as a u64, but metadata fields are not
>> all 64 bits wide. A field ID therefore encodes the field's size into
>> bits 33:32.
>> 
>> The kernel mirrors these fields in C structures, and each member's size
>> must match the size encoded in the field ID. FIELD_MAP() stores the member
>> size and uses it to decide how many bytes to copy from the value returned
>> by TDH.SYS.RD. The size in the field ID is never consulted, so any mismatch
>> goes unnoticed. Declaring a u32 member for a 64-bit field, for example,
>> would silently store only its low 4 bytes.
>> 
>> Add a build-time check that the size encoded in each field ID matches the
>> size of the corresponding C structure member. A wrongly typed member then
>> fails the build with no runtime cost.
>> 
>> BUILD_BUG_ON() cannot be used in a structure initializer, so use
>> BUILD_BUG_ON_ZERO() and add its zero result to the .size initializer. This
>> performs the build-time check without changing the stored size.
>> 
>> An alternative would be to leave the size bits out of the field ID
>> definitions and construct the IDs from the member sizes, which makes a
>> mismatch impossible. But the TDX module ABI definitions list the full field
>> IDs, and definitions with the size bits stripped would match nothing in the
>> docs, making them harder to verify. Keep the IDs exactly as documented and
>> check the size they encode against the C type instead.
>> 
>> AI was used under supervision to review code and workshop logs. It
>> suggested moving the size check into its own macro to keep the .size line
>> short. Rick also used AI to write TDX_FIELD_SIZE_CODE(), which converts a
>> member size to the size encoding in the field ID.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>
>Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks!

>> +/*
>> + * The size encoded in the field ID and the size of the destination C
>> + * member must agree.
>> + */
>> +#define TDX_FIELD_SIZE_CHECK(_field, _type, _member)		\
>> +	BUILD_BUG_ON_ZERO(((_field) & TDX_FIELD_SIZE_MASK) !=	\
>> +		TDX_FIELD_SIZE_CODE(sizeof_field(_type, _member)))
>> +
>>  #define __FIELD_MAP(_field, _type, _member)			\
>>  {								\
>>  	.field_id	= _field,				\
>>  	.offset		= offsetof(_type, _member),		\
>> -	.size		= sizeof_field(_type, _member),		\
>> +	.size		= sizeof_field(_type, _member) +	\
>> +			  TDX_FIELD_SIZE_CHECK(			\
>> +				_field, _type, _member),	\
>>  }
>>  
>
>Nit:
>
>This doesn't cover the TDX_FIELD_CPUID_CONFIG_LEAVES and
>TDX_FIELD_CPUID_CONFIG_VALUES.

Yes.

>
>Not sure it's worth to add static_assert() in get_tdx_sys_info_td_conf(). But if
>not, maybe it can be mentioned it in the changelog.

I'll add checks in get_tdx_sys_info_td_conf():

	(void)TDX_FIELD_SIZE_CHECK(TDX_FIELD_CPUID_CONFIG_LEAVES,
				   struct tdx_sys_info_td_conf,
				   cpuid_config_leaves[0]);

	(void)TDX_FIELD_SIZE_CHECK(TDX_FIELD_CPUID_CONFIG_VALUES,
				   struct tdx_sys_info_td_conf,
				   cpuid_config_values[0][0]);


TDX_FIELD_SIZE_CHECK() uses BUILD_BUG_ON_ZERO() so it can be used in
structure initializers. The (void) casts avoid unused-value warnings
when used as standalone statements.
