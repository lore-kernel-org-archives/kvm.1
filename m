Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4513BF691
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284070; cv=fail; b=myKhMPaN13dApPz1JfkbrGTvUGOT2OCgY7NgQDHOFpkIgxV8/mVV3ZK1i/azH8v2YaDnFVdUb3WTiB6+EHY2Ef9Eb6sxFgY7wtS8zeL/IBvou3lBWEEORKt4Zc7JArcKxJ8do3xJV3NA5oo9FubnCWz5T62VwoOKqaIzCjyRPGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284070; c=relaxed/simple;
	bh=Ol0ndd2vnQ/j4ONCP47p87kd+Sh94/3llAQzq5uOlvs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nka4+yQ2mZMjNwoGhRQR4Yt+q0FmPBVjeJtFj3PxjOaPh/XPOVvq9sufkQpRoZy4FBEEhDhz06h6/p5Qn+ljL9RifE0VJTEpZTtJD59ZsOC/5AzTBwcH/hSV5scimsjsISGEy6CtiQEfLPdcmrR/iZiOC7VRTwtlm4+ni7b2IQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZe4AxqX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZe4AxqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774284069; x=1805820069;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ol0ndd2vnQ/j4ONCP47p87kd+Sh94/3llAQzq5uOlvs=;
  b=aZe4AxqXYfY/ywx/86xiR3tT/2B4bsn75xwZ01p53RjgB7QnghXVS+nA
   d/TWTMOkF9Qwf1iAafrRruRjO6ADdBgBOktQ/0EvHP13blLwnS2fmEK9S
   JlJidKwnS34rT3JHWFR9cjTf0Hz4EMFEZwd7Pk/iV/FAwMTjskGoRdlky
   b3ngsgmQR98LODbJA8bdK4658+CzOM/Dr6Y1ZAqK/VFpU+tYALPzD6Hqy
   G1rasFz7Vh3JojGBFJP5Fna13oTgMGnkbEKGyRvREPJmh2djfCaNJg5TI
   +eR+xDuBlex31c7cQxQRiZ7rZypPKViNGNUjFHjCqi20lKh8vXJ4toSd9
   A==;
X-CSE-ConnectionGUID: TLjjyZaeSVuyUGqON3JhlA==
X-CSE-MsgGUID: LtCFnNBDSXaxwqAgoqDNZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92666032"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="92666032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 09:41:09 -0700
X-CSE-ConnectionGUID: Qz1+zej6RDKWtNnHW0oauw==
X-CSE-MsgGUID: u478VZwHSoK5POsaqDgTdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="254564232"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 09:41:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 09:41:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 09:41:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 09:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA2q5kBeHKG9kTWldagpu8JmxrnFEP64Kc9KOHE0LKqT4KVtHTAScQiDYehJEIYW1kWUlvwEsz2KVS+MOrhkY8dr5wsbTYxeweikV5vbPDeFbEDQvmwkLucrAnv2xjEub7udheeWxGvRJuBuyk+5dI0Z+aWozfMlMbHL8++2ZCCLIRaZJislJQGHTawpf6xaBOsc8TmfO5//fZgbkIxi2PBYUboU5Izn2CN1CBFOGgqidIFfOAvLzuZmgtOrw0ug2NxR3tjObySPIziOwcY4aQrr9VqzMQzIRJZbRXN/+ovgJKPwTiC5RXQyHhzLwW0LW1b55NcFZhC4Em66ZB3iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZPzet0+TXk1Y65uMgZcwhCDcXEGKI67R1E4w/SIftE=;
 b=I7NEhtgqq+FREEKNAs7f0A0wnnM6mqyZifmYtV236OrnrdMgd2PkMZxhQEIfGraVRN/LbtznIVPrWYWdOc/Q1gDr3mX02g8BWAxBTAggI7ko0Dsq0anvRAiQGdFyUFS8NYGfoHmoY1ZPHydcd/U9AjrF2EcUyTj+lEblwX60U8CIKlb+mt6KtHPkkR7iEvkb3fV33hfAErH6q6YUYMrETN2pSa2lTT9g08PcE1bQlCYqQ8RnNfa8YTfuSjmetEYZoJN82Awx0uLd/Saz7uyTrIwxb3A2+eHcI2NgYEqk7kCyNg27ymMoBHTbS+by7Sy2frZLZhUrpgLyuykm9cWuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by SJ5PPF162366726.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::813) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Mon, 23 Mar
 2026 16:41:03 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 16:41:03 +0000
Date: Mon, 23 Mar 2026 17:40:59 +0100
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: =?utf-8?B?UGnDs3Jrb3dza2ks?= Piotr <piotr.piorkowski@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <kvm@vger.kernel.org>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>
Subject: Re: [PATCH v2 1/2] drm/xe/pf: Add FLR_PREPARE state to VF control
 flow
Message-ID: <acFs3bwEkiynDkJZ@nostramo>
References: <20260309152449.910636-1-piotr.piorkowski@intel.com>
 <20260309152449.910636-2-piotr.piorkowski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309152449.910636-2-piotr.piorkowski@intel.com>
X-ClientProxiedBy: VIYP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::9) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|SJ5PPF162366726:EE_
X-MS-Office365-Filtering-Correlation-Id: e603a9bb-0572-46dc-2803-08de88faf8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: AGVHy3QuAoLBazA7HOcrlcQqUZ8xEE+iG1MUSJT/EdhOu51JmVw/JjBX7R7VDZAoA+RQ5faw+1oRn30l+iEFA0wXXEZ+HuRa5tIACNY0Vv8c7wYdUZmu4MYrseoQ8K2IKNcjlr/aCeLbOQOGnSzUq/2pKxjrlz21kVvhxlUJ8TahfBbeb/bSPY7PSmlZREpPAD06PNML8mV6UrFyBnbeepd0izxgpF993kt5WMCyrV8kngSFEdlf4ZfCJVa25rZHn+AH9ZHo8aEP+TiZBKOS0gBlgrPvbXNB1wC8yi4ijYLMnQzwAM9GbiMwBo3YKqoBqSY+47DdK1+ODYxIMToA9EtoUno/ldz9likweVqCZoOsNGM6QEc+qgEZtQtrvQsWbVlJR4JBNbDkCHLyCEUuP8SHVcJpfS4c+orsRJ2Cm3NUEJmNQytQVuger3XcwminzTRfwMZYFh7Echs6fLpqcSgwkQyvvw9wCHwm1IXpqZD1m8nAwvGN1Alg+xvFW34J99ZcxOPLsNiVg+2uJmp+BACc7opQloObDKFlMgSEIqBo9pSLVUuPTCe0UP1jAzwiTMdoK0AjyzlMVEmjEZEJngqoizd+GakJs6FZWLWeCaxddqu0QI8x46giVNvVT/l1hYJE+bLE4QxC6FNYabRhOLpWHk/96GZM2r9EwXCj4L+Qh3UP7PIGl4Fq3twD9/r/8VV0TE/IfPdGAS8+oG/BmFRghHstcehvYUrVfpQtTow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09ORzErK256aks5M0xreWlyVm9zTU9zSEdoSXZiU0psWkRPbk04VVNoRE8x?=
 =?utf-8?B?NklFclpTVVFIMkJObDVsK0VCSXg3WStqMnNaNkxkTmErWEU2Q2Eyb3NHNUR3?=
 =?utf-8?B?TmRWenpYQ2c5M1J3dGpJK2dZZm1TRFVBSlN4RFNlTFk4S0JxakdNTEpHKzV2?=
 =?utf-8?B?ZitkanUrNlUrVk9hMXVEMm11R2QxMTQvcjBnUWk0ZGtIWDJmU0ZDN2JFTlFx?=
 =?utf-8?B?ZW9uM1h0cVhDTHkwUTk2eENCcyswTlcyYkhSRURzZTVLeFk1dU9zVlNUM1kz?=
 =?utf-8?B?M1pHaFlsR1VSb2JtZXlwQzI3Y21DSEs4TEdRU0dnRDNCbWlqTEloMzFqVFFD?=
 =?utf-8?B?dUpSN1J4ZjJSMWtQNjRNd0NrK3BjMW5TZjBsWmRxMkVEdGVZTGhUU2NDZ1Z1?=
 =?utf-8?B?VC9BVzhkcE42TTdZR3pFak9sMEEvSUN2WkFiVnk3L1htZlFQRVJ2VUNvbWlS?=
 =?utf-8?B?YVVKR0FCZVZRVklLVkpGdmFjamFESnBTQ3Bwa1VybC9UUTV3bzFMazNnd1BR?=
 =?utf-8?B?UEhMUk5wcndkM284ZjZuSkVHbmdsdHlGYkdxT0RTWGVCOWljdDM3aUxoR0RF?=
 =?utf-8?B?bE0xN1VzUDNHTEc2a1l1QjA1RjZPQW45N3AxaEN0amlvYzFHVEYxL0t3ZnUy?=
 =?utf-8?B?d0NuUGdpcE9SVmYxRzA2YnUyYlRUSkpOQmRGamREcmNTK3AyalVhYzlhTUhD?=
 =?utf-8?B?aEhoMTBWTUxZMDZBY1cvZ3lvZkk2YldCWmw5VC9VcnRDY0M2SkFaeXV0aGVi?=
 =?utf-8?B?aTIzYkNOS3JVNkJFOW1rNlBKdDY0RjBkQnRLYWNxV25FTTVvS29vQkYzSC83?=
 =?utf-8?B?SmwxbEZta2IxTkw5VFRJL3gzcjFwODR3SzlQb1JObkk5VDVwdmRSRnk3SGpj?=
 =?utf-8?B?Q2hvZ1ZyWjhlN2g5VUUrWE12UnV3VlJLWkdyemJ2d1NGS0hvVFdZN2xaWHFy?=
 =?utf-8?B?VFVHcW85bktrQmdEOXIxQU5WczNvLzhVNnpSWExOZGJDQzJjbTRqTFY2M05v?=
 =?utf-8?B?R0c0NC9HYUZmc3hQT1crYi9KcUN0Nkdzc2lTMXRIYzh4aVhycUhCelRFWkls?=
 =?utf-8?B?RG5mSnA1VEFrd0pZZ05ybXBlSVZ4VkFDN2xZOW96QWRtanhnaGp4b0lXVkFK?=
 =?utf-8?B?UjBXZWxlWGMyeU90S0lEdkprKzQ0NGVFenV5K1V5UGVraEtueVRORXdyQm1D?=
 =?utf-8?B?KzM5U2poTTBsMDNNWGFlbVJ4V1dRZ2ZtNlRYQU5zM2JwLzhEc2FWTytjS2px?=
 =?utf-8?B?NFllbk92TWR5VWw0aWV6WTVnOEs1TzFxUUlnVXhzK2NXTzFDanFBc2NSa3o0?=
 =?utf-8?B?dG5INnRtNXE0d3JndnhlbkpmVC9Na21ucjd5TmlDbWJkZVdad2pSUnpVVk9I?=
 =?utf-8?B?NUZveE1BWVFSbkJTelVrVmxvaTZNMnZCNmd5R0xwOE4vVnd5dVlJazI4RGh0?=
 =?utf-8?B?cDhHcTFNeWtMZ1NCK3FTSDNsTDR1MjZrN1F1REFDampqMW15VjBQQVdCZ3lW?=
 =?utf-8?B?OTY1b3ppZ2xDamU3RFNvN2NkeVlJa3pqUEgvSytweE4yMit2TUlTWjI2U25v?=
 =?utf-8?B?QkRTOFo2VlhHK3ZITVhPUXJaWG9Ucjk2cDRxaVVlQTVUTzVBaGY2QWttam53?=
 =?utf-8?B?SWNZdEo1ajYxdUhGQmNPd3BEYVFYS3B3QmYzR25qQzRqdkFTSWZrYUtNNWpO?=
 =?utf-8?B?U0I4d3JHM0JMeGNqQUNUdHloZG9OdmlMTFNjbEtoWURPNS9GL25hcm5BMkNh?=
 =?utf-8?B?dGU3L3NuOXpxY1h1L1gwOVBQRWhzSC9iaTJGaVE2OXlhbkQxanQyZjRoZWhK?=
 =?utf-8?B?SHJxdWsvVzFQdzRFdCtBU3hIb3pJOTZkTjJDOXFPV3dGUVllZWs2cUFabk1Z?=
 =?utf-8?B?RERQN3RXcXhYcG9KM0hZVmVrSlZZbnJubEVaUmUvWDZ5R1RydDBzdlc0ZTVF?=
 =?utf-8?B?MG1QYlBEcnVhOUtNMVlMNVZPTHZrVnU2eWJzSWE3dmd4L0hVVktyc3pKQVd2?=
 =?utf-8?B?K3J3UDJJWnA1eEtEaGd1UmVMcUJyNGpwSUFQbmE5QzR3eUpidmdBejdub0ZB?=
 =?utf-8?B?NHJOZWVJSnNlbjJ4SXdmdnlkNGFYMUZ6anRQVnVSdDJEdU9qejZ2ZngyWk1X?=
 =?utf-8?B?a1lkNkR2N29wODBMYnVOTmlDeEIyazlOaHpOb2RUUGwxbEl1SVhIM0tWbjhq?=
 =?utf-8?B?d1lUeTBESURIdGE5NVFyQVR2UHVPWmpSM04zNWpIQy90ZzR6S2pqN0J3Y0Q0?=
 =?utf-8?B?SFZOVDZxTUhxY0tMZk5xS2ZQL29tK2VFMGJraGU4TGgrY2JRYlo1SVN6MUtw?=
 =?utf-8?B?TWtHTkVRME5RdVF6eDRzVkw3dGdtNGVDMVA2RmxIaXpiSFhnVzdDOE9oT2hI?=
 =?utf-8?Q?nHpfAypUQiM92jCk=3D?=
X-Exchange-RoutingPolicyChecked: Lp6TMf5MByyVap8w43wXk7DIqyuGDbVITGxT4pScq9Cy88MC0rdQnXeKmG31oy/Tr5cOT9bons2VDAhd2Gw743PZxLSwPDvLuUC4oUdYsk0ogWU95CbXUdivrUDPav/b9JDzW/pqSerSE5+IjidbXhF5jGkshSXDjr9QPfOLJu2sQHBR+msyKu6xGM0MxINfAVd7ZF10jG04E2nPPjXeaA3jKPLQ9+j8VS0ex6Zao3ZaF4XDnEzZ36PglTRBOjCP/zwOVjqKLR0q2lxdt3BjL9juXFoxfA7r1Mnesb1v5nnU1rD3gbgc90kw0PlIxXqp7+AAODzBOLyo7ivMgzEYoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e603a9bb-0572-46dc-2803-08de88faf8c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:41:03.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2K4LMVYht0UVHp8JDFqyP1jJNnIvIlZGL/CWDt2vtTxN8iXnYbzHz/zBaM2Ko42/Wr/aUEQ6o1xXzSU2cR+kulp4FX8+xJ36KAUi7PN8uoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com

On Mon, Mar 09, 2026 at 04:24:48PM +0100, Piórkowski, Piotr wrote:
> From: Piotr Piórkowski <piotr.piorkowski@intel.com>
> 
> Our xe-vfio-pci component relies on the confirmation from the PF
> that VF FLR processing has finished, but due to the notification
> latency on the HW/FW side, PF might be unaware yet of the already
> triggered VF FLR.
> 
> Update VF state machine with new FLR_PREPARE state that indicate
> imminent VF FLR notification and treat that as a begin of the FLR
> sequence. Also introduce function that xe-vfio-pci should call to
> guarantee correct synchronization.
> 
> v2: move PREPARE into WIP, update commit msg (Michal)
> 
> Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Co-developed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>

Thanks,
-Michał

> ---
>  drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c   | 78 +++++++++++++++----
>  drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h   |  1 +
>  .../gpu/drm/xe/xe_gt_sriov_pf_control_types.h |  2 +
>  drivers/gpu/drm/xe/xe_sriov_pf_control.c      | 24 ++++++
>  drivers/gpu/drm/xe/xe_sriov_pf_control.h      |  1 +
>  drivers/gpu/drm/xe/xe_sriov_vfio.c            |  1 +
>  include/drm/intel/xe_sriov_vfio.h             | 11 +++
>  7 files changed, 102 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
> index 5cb705c7ee7a..058585f063a9 100644
> --- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
> +++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
> @@ -171,6 +171,7 @@ static const char *control_bit_to_string(enum xe_gt_sriov_control_bits bit)
>  	case XE_GT_SRIOV_STATE_##_X: return #_X
>  	CASE2STR(WIP);
>  	CASE2STR(FLR_WIP);
> +	CASE2STR(FLR_PREPARE);
>  	CASE2STR(FLR_SEND_START);
>  	CASE2STR(FLR_WAIT_GUC);
>  	CASE2STR(FLR_GUC_DONE);
> @@ -1486,11 +1487,15 @@ int xe_gt_sriov_pf_control_stop_vf(struct xe_gt *gt, unsigned int vfid)
>   * The VF FLR state machine looks like::
>   *
>   *	 (READY,PAUSED,STOPPED)<------------<--------------o
> - *	    |                                               \
> - *	   flr                                               \
> - *	    |                                                 \
> - *	....V..........................FLR_WIP...........      \
> - *	:    \                                          :       \
> + *	    |             |                                 \
> + *	   flr           prepare                             \
> + *	    |             |                                   \
> + *	....V.............V............FLR_WIP...........      \
> + *	:   |             |                             :       \
> + *	:   |    FLR_PREPARE                            :        |
> + *	:   |    /                                      :        |
> + *	:   \   flr                                     :        |
> + *	:    \ /                                        :        |
>   *	:     \   o----<----busy                        :        |
>   *	:      \ /            /                         :        |
>   *	:       FLR_SEND_START---failed----->-----------o--->(FLR_FAILED)<---o
> @@ -1539,20 +1544,28 @@ static void pf_enter_vf_flr_send_start(struct xe_gt *gt, unsigned int vfid)
>  	pf_queue_vf(gt, vfid);
>  }
>  
> -static void pf_enter_vf_flr_wip(struct xe_gt *gt, unsigned int vfid)
> +static bool pf_exit_vf_flr_prepare(struct xe_gt *gt, unsigned int vfid)
>  {
> -	if (!pf_enter_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_WIP)) {
> -		xe_gt_sriov_dbg(gt, "VF%u FLR is already in progress\n", vfid);
> -		return;
> -	}
> +	if (!pf_exit_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_PREPARE))
> +		return false;
>  
> -	pf_enter_vf_wip(gt, vfid);
>  	pf_enter_vf_flr_send_start(gt, vfid);
> +	return true;
> +}
> +
> +static bool pf_enter_vf_flr_wip(struct xe_gt *gt, unsigned int vfid)
> +{
> +	if (!pf_enter_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_WIP))
> +		return false;
> +
> +	pf_enter_vf_wip(gt, vfid);
> +	return true;
>  }
>  
>  static void pf_exit_vf_flr_wip(struct xe_gt *gt, unsigned int vfid)
>  {
>  	if (pf_exit_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_WIP)) {
> +		pf_escape_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_PREPARE);
>  		pf_escape_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_SEND_FINISH);
>  		pf_escape_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_RESET_MMIO);
>  		pf_escape_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_RESET_DATA);
> @@ -1760,21 +1773,54 @@ static void pf_enter_vf_flr_guc_done(struct xe_gt *gt, unsigned int vfid)
>  }
>  
>  /**
> - * xe_gt_sriov_pf_control_trigger_flr - Start a VF FLR sequence.
> + * xe_gt_sriov_pf_control_prepare_flr() - Notify PF that VF FLR request was issued.
>   * @gt: the &xe_gt
>   * @vfid: the VF identifier
>   *
> + * This is an optional early notification path used to mark pending FLR before
> + * the GuC notifies the PF with a FLR event.
> + *
>   * This function is for PF only.
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -int xe_gt_sriov_pf_control_trigger_flr(struct xe_gt *gt, unsigned int vfid)
> +int xe_gt_sriov_pf_control_prepare_flr(struct xe_gt *gt, unsigned int vfid)
>  {
> -	pf_enter_vf_flr_wip(gt, vfid);
> +	if (!pf_enter_vf_flr_wip(gt, vfid))
> +		return -EALREADY;
>  
> +	pf_enter_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_PREPARE);
>  	return 0;
>  }
>  
> +static int pf_begin_vf_flr(struct xe_gt *gt, unsigned int vfid)
> +{
> +	if (pf_enter_vf_flr_wip(gt, vfid)) {
> +		pf_enter_vf_flr_send_start(gt, vfid);
> +		return 0;
> +	}
> +
> +	if (pf_exit_vf_flr_prepare(gt, vfid))
> +		return 0;
> +
> +	xe_gt_sriov_dbg(gt, "VF%u FLR is already in progress\n", vfid);
> +	return -EALREADY;
> +}
> +
> +/**
> + * xe_gt_sriov_pf_control_trigger_flr - Start a VF FLR sequence.
> + * @gt: the &xe_gt
> + * @vfid: the VF identifier
> + *
> + * This function is for PF only.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int xe_gt_sriov_pf_control_trigger_flr(struct xe_gt *gt, unsigned int vfid)
> +{
> +	return pf_begin_vf_flr(gt, vfid);
> +}
> +
>  /**
>   * xe_gt_sriov_pf_control_sync_flr() - Synchronize on the VF FLR checkpoint.
>   * @gt: the &xe_gt
> @@ -1879,9 +1925,9 @@ static void pf_handle_vf_flr(struct xe_gt *gt, u32 vfid)
>  
>  	if (needs_dispatch_flr(xe)) {
>  		for_each_gt(gtit, xe, gtid)
> -			pf_enter_vf_flr_wip(gtit, vfid);
> +			pf_begin_vf_flr(gtit, vfid);
>  	} else {
> -		pf_enter_vf_flr_wip(gt, vfid);
> +		pf_begin_vf_flr(gt, vfid);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h
> index c36c8767f3ad..23182a5c5fb8 100644
> --- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h
> +++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.h
> @@ -27,6 +27,7 @@ int xe_gt_sriov_pf_control_process_restore_data(struct xe_gt *gt, unsigned int v
>  int xe_gt_sriov_pf_control_trigger_restore_vf(struct xe_gt *gt, unsigned int vfid);
>  int xe_gt_sriov_pf_control_finish_restore_vf(struct xe_gt *gt, unsigned int vfid);
>  int xe_gt_sriov_pf_control_stop_vf(struct xe_gt *gt, unsigned int vfid);
> +int xe_gt_sriov_pf_control_prepare_flr(struct xe_gt *gt, unsigned int vfid);
>  int xe_gt_sriov_pf_control_trigger_flr(struct xe_gt *gt, unsigned int vfid);
>  int xe_gt_sriov_pf_control_sync_flr(struct xe_gt *gt, unsigned int vfid, bool sync);
>  int xe_gt_sriov_pf_control_wait_flr(struct xe_gt *gt, unsigned int vfid);
> diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control_types.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control_types.h
> index 6027ba05a7f2..e78c59e08adf 100644
> --- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control_types.h
> +++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control_types.h
> @@ -15,6 +15,7 @@
>   *
>   * @XE_GT_SRIOV_STATE_WIP: indicates that some operations are in progress.
>   * @XE_GT_SRIOV_STATE_FLR_WIP: indicates that a VF FLR is in progress.
> + * @XE_GT_SRIOV_STATE_FLR_PREPARE: indicates that the PF received early VF FLR prepare notification.
>   * @XE_GT_SRIOV_STATE_FLR_SEND_START: indicates that the PF wants to send a FLR START command.
>   * @XE_GT_SRIOV_STATE_FLR_WAIT_GUC: indicates that the PF awaits for a response from the GuC.
>   * @XE_GT_SRIOV_STATE_FLR_GUC_DONE: indicates that the PF has received a response from the GuC.
> @@ -56,6 +57,7 @@ enum xe_gt_sriov_control_bits {
>  	XE_GT_SRIOV_STATE_WIP = 1,
>  
>  	XE_GT_SRIOV_STATE_FLR_WIP,
> +	XE_GT_SRIOV_STATE_FLR_PREPARE,
>  	XE_GT_SRIOV_STATE_FLR_SEND_START,
>  	XE_GT_SRIOV_STATE_FLR_WAIT_GUC,
>  	XE_GT_SRIOV_STATE_FLR_GUC_DONE,
> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf_control.c b/drivers/gpu/drm/xe/xe_sriov_pf_control.c
> index ed4b9820b06e..15b4341d7f12 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_pf_control.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_pf_control.c
> @@ -123,6 +123,30 @@ int xe_sriov_pf_control_reset_vf(struct xe_device *xe, unsigned int vfid)
>  	return result;
>  }
>  
> +/**
> + * xe_sriov_pf_control_prepare_flr() - Notify PF that VF FLR prepare has started.
> + * @xe: the &xe_device
> + * @vfid: the VF identifier
> + *
> + * This function is for PF only.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int xe_sriov_pf_control_prepare_flr(struct xe_device *xe, unsigned int vfid)
> +{
> +	struct xe_gt *gt;
> +	unsigned int id;
> +	int result = 0;
> +	int err;
> +
> +	for_each_gt(gt, xe, id) {
> +		err = xe_gt_sriov_pf_control_prepare_flr(gt, vfid);
> +		result = result ? -EUCLEAN : err;
> +	}
> +
> +	return result;
> +}
> +
>  /**
>   * xe_sriov_pf_control_wait_flr() - Wait for a VF reset (FLR) to complete.
>   * @xe: the &xe_device
> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf_control.h b/drivers/gpu/drm/xe/xe_sriov_pf_control.h
> index ef9f219b2109..74981a67db88 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_pf_control.h
> +++ b/drivers/gpu/drm/xe/xe_sriov_pf_control.h
> @@ -12,6 +12,7 @@ int xe_sriov_pf_control_pause_vf(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_resume_vf(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_stop_vf(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_reset_vf(struct xe_device *xe, unsigned int vfid);
> +int xe_sriov_pf_control_prepare_flr(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_wait_flr(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_sync_flr(struct xe_device *xe, unsigned int vfid);
>  int xe_sriov_pf_control_trigger_save_vf(struct xe_device *xe, unsigned int vfid);
> diff --git a/drivers/gpu/drm/xe/xe_sriov_vfio.c b/drivers/gpu/drm/xe/xe_sriov_vfio.c
> index 3da81af97b8b..00f96b0976d1 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_vfio.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_vfio.c
> @@ -42,6 +42,7 @@ _type xe_sriov_vfio_##_func(struct xe_device *xe, unsigned int vfid)		\
>  EXPORT_SYMBOL_FOR_MODULES(xe_sriov_vfio_##_func, "xe-vfio-pci")
>  
>  DEFINE_XE_SRIOV_VFIO_FUNCTION(int, wait_flr_done, control_wait_flr);
> +DEFINE_XE_SRIOV_VFIO_FUNCTION(int, flr_prepare, control_prepare_flr);
>  DEFINE_XE_SRIOV_VFIO_FUNCTION(int, suspend_device, control_pause_vf);
>  DEFINE_XE_SRIOV_VFIO_FUNCTION(int, resume_device, control_resume_vf);
>  DEFINE_XE_SRIOV_VFIO_FUNCTION(int, stop_copy_enter, control_trigger_save_vf);
> diff --git a/include/drm/intel/xe_sriov_vfio.h b/include/drm/intel/xe_sriov_vfio.h
> index e9814e8149fd..27c224a70e6f 100644
> --- a/include/drm/intel/xe_sriov_vfio.h
> +++ b/include/drm/intel/xe_sriov_vfio.h
> @@ -27,6 +27,17 @@ struct xe_device *xe_sriov_vfio_get_pf(struct pci_dev *pdev);
>   */
>  bool xe_sriov_vfio_migration_supported(struct xe_device *xe);
>  
> +/**
> + * xe_sriov_vfio_flr_prepare() - Notify PF that VF FLR prepare has started.
> + * @xe: the PF &xe_device obtained by calling xe_sriov_vfio_get_pf()
> + * @vfid: the VF identifier (can't be 0)
> + *
> + * This function marks VF FLR as pending before PF receives GuC FLR event.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int xe_sriov_vfio_flr_prepare(struct xe_device *xe, unsigned int vfid);
> +
>  /**
>   * xe_sriov_vfio_wait_flr_done() - Wait for VF FLR completion.
>   * @xe: the PF &xe_device obtained by calling xe_sriov_vfio_get_pf()
> -- 
> 2.34.1
> 
