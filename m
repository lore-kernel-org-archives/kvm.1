Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED6351C35;
	Thu,  3 Sep 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475536; cv=fail; b=pwJmxpi0Ze1QW/49HmxM86Sakpd7IDsqqUnotC0rClmzh6TzZEwtm2V/noeg4twR5nwZ64Pe+UryccvcnMG38otnOAYBi5KNHrpmSSb6GGqOA8YW3f0Br52dGtAyZ5GxJHKa8pj4Z65xmplvDHeGPXnnW7ZzGvKHD/Dzi9u9Ajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475536; c=relaxed/simple;
	bh=TJROQEMTMR7xomaYo90PaJ2c7zwq9wrnWd5Hru6XYoE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UR2z67KDL2PHOIOQoJFoasukKK1HXeP8Hv4xxAdoymzOHsJabNvK191wFG3+45EopY3r2AXvaCXjFFBBT56i0hVDxtczz1avSjLp5JDstegvzPK7Ud4IyBmU4k6gVQZKa9f2kLxqASP3+gRj1mnlBzq2txMCGqe/uKTaUZr5LOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWyMOjNc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWyMOjNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788475534; x=1820011534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TJROQEMTMR7xomaYo90PaJ2c7zwq9wrnWd5Hru6XYoE=;
  b=OWyMOjNcjZ4qqYT15sc8QguVK+3fnlAXzyeuVmg/pB7nAAsTYqsga+sY
   uID9RfKgMSc6YGClaFqgbshpm+ztzL4Bn0NqNxeRNWsHDZSG3LX7YCGnT
   aAvtoDUM09W6Bx7uoWABQYeen1I14ybNuo5T5xZbnpq07xnyff97pIw8o
   5jW66iTa9SXypNCwWa+wn0oHXP+vtq05oF36G7IZ38bYALzqErgY/Bm1v
   Qj05tICUPcwtrNxqTGVWbiluWxEtaMTVaCCPIr70ukE5qilHy3Vj1x3LY
   SLTJNy+HMJnsY0uajvqiOs30VsjfGUxAYT6qcy6NU2Vb0/yRuvwhcmIf9
   g==;
X-CSE-ConnectionGUID: ypzRv4ITQEOvSM/Er08C4g==
X-CSE-MsgGUID: 2f4/rh3GRKufg45VFzyA0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89097479"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89097479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 15:45:31 -0700
X-CSE-ConnectionGUID: aYxr9wycTrSSFDGenfJXTQ==
X-CSE-MsgGUID: WUyi0lMzScCcTjwotU9NpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269849909"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 15:45:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 15:45:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 15:45:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 15:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQQCxJB6bpIAbkKsEfMhnpehG1Zx6sMTTLrFmwrbBOZFeNpPLCQYn+DTqLDgwaSnX1ypFA1AGvqAJK9XuDmCoPx8nCclqJrCj5zQ6wRV5PefgVtpC+taAnYfJLHYs1w5L8dBFo+OWUDRINuZJMbJxIPjrZ8qQwctQ8Nss9MyvdrOnOpQGhXfZM6s8tglV/Ssr35Imw99OKfrd+FZ0qRRMzFoTzVJFZ1jPTrajrOzRObXKG6KsfHlmWqS468aA71ZbKH39HvN+TMQlkVLQ9WUNp0b/uLEmVMrSYL/a5iGfCsmqOZ2VxMZusb2uPyVzg8/FSV7oAgSDEFxTbmvniOYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO1cqaeT+UmaCzcoMxEzQRSQi6jsNc6Lg5g98ld9V4k=;
 b=VRCgZO+MxV5bKiYKHnOpW3GPgY4Wf8R8CEb2Q5qmQGBYQMuqgZCh0wVh8E31r74XIhPgBbuxU4ea2/2Al2eBL0Mn5Qxm5rio+Xe+BBGRKa9A3NkJJ011G4zCqa4KlnMoC5JMYD3+ywvBj2PdnnUkBcGTymnOHf38Bx8bsgWAUL+gxBa3/I66nkKeAB8VhY1m/9U2e+H4DLJHmxC6tdGbumkzUvClSrlMfe0EQZDS45mlBecPg8jGod+/8ZJATKmkUAO/PM6h2QjuLz0AQwJvBfd/eoxaGPkzQ2vDsjrc03MFsc4o8QbzIVle8ft+rNv0sQJuM8yv1xvjiTTHnhbW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by LV2PR11MB518990.namprd11.prod.outlook.com
 (2603:10b6:408:412::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 22:45:29 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 22:45:28 +0000
Date: Thu, 3 Sep 2026 15:45:26 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 1/4] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <apn4huJpZiZU0r8y@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-2-peter.fang@intel.com>
 <apkN7wfZprnIQiaL@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apkN7wfZprnIQiaL@tlindgre-MOBL1>
X-ClientProxiedBy: BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::12) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|LV2PR11MB518990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac9a159-b45b-411d-67a4-08df0a0d0d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: cAxZVhengIFniZ141KbcEwKwbiQYU69Hp1CD93AglmrYJjg4x70QRUf0gIsn6Whs50LwgB2MNrplR5b8qxuIYw1lSR/hc05ebnvOcyhRtC5Wlqp2brp3QqklF2ze9Cte1U8gWU7221/Ui0DNfYo9aLdA4UfiHf4kk+RGIfJ4pi+1FAknqPEp9JkevoRZ1ETTeW0BUBmaUOQSMuSlvzxeXtBrjBzoS3mOfprWFfqyWu2YUmWQSJC17d1Ldxav/NQdw2yHdxb+u4sD2Hetwh7IkaXQMbhJLajcXcO+q92bbpew0W7aX+1jCZZTWeDFe4GmcG/1rYlFoh1jRKUzRTuVUDW4zD9SujRzxwXMlsYwJJGn4R1zG2HKkY4rhPNAxLukP/3lejQvxxaLSvKQMMdJtOCY7vze37wx0mUQahFMw+8nEX5AhLaD7V+gpNhfhvzXfgoogRC+/1jYXiohJPO2/HEZKE9XKXBOkqaJFSP2W65hQP2DH7TuXrDl32LeYQy2HR87sxmMt2mOtoO0/AUyYMCnH+qNi5a/KqysgboPC1ITRNHiT0uketlhu99oLFGuSZaAnVOov1Pw1eUOWa1S8Jr4KMVFH6epXeQs1JlMRNtqDd4MUOhIfQdwDWiM1/PmmZmD9vTEmZsGIfsW+b3csIg99Gt13cqb0nxzxfTecTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/um24AXLP+/pnvYnWSccXFuVFiO+7Jih3UHgJs+25TUR5S3GOCyOJVZ9FYO?=
 =?us-ascii?Q?WrbkH7vzB+7HaKmwO28iNMEt2n6EgxEo20DJZhyYUyYr2iV1Fn6G+M5zj5fx?=
 =?us-ascii?Q?eLKkAkuhAgItFcNa2kB1bAM822M2VKBcrgknPr7UPec2coeXNMIwWAMDJdwo?=
 =?us-ascii?Q?8vR5RgZ92Q39Izx9u/EGQbggiVwL1xSrpIBK+wQkji3zmjfbJm3QwqG/YZ7k?=
 =?us-ascii?Q?EUJQPtZm6jxkDF3jmDyoSz1j6jOL9A3wCpnrrijZWLKK/p1xTSWQzG4OLxjH?=
 =?us-ascii?Q?VW17ZwvP6mtlMUmC8E0x0KJEn7h0JLhlX/8WHvJeDBjJFc4v73Sa/N6jhuTE?=
 =?us-ascii?Q?cEXHBlCJTNfiokNkWoThCIF3PQEZp51sjCABzkeNeBoCDaxZ4UvjSQSmvQQg?=
 =?us-ascii?Q?dwu0c8i/I59S1oRByhtS47xJa+g5IARTBLG6pg2A4OFuHuykNyjqkgWrj1iM?=
 =?us-ascii?Q?cYxNGk8bg2qLFCLBDSeJpleUATu08aGEV/KIMZKkpoaPy6ifMzCDiDBXmTs5?=
 =?us-ascii?Q?h4/l53/Q1F7PWyt2XFI7/PEYbMCS1mUIH8TRDHGj2DluJTEd8PW7QMvRnviU?=
 =?us-ascii?Q?kyck3jm1xfPgV6ramNUn9ZRGwZisH83MCRFslWqMu0lVJ42vgdIvAANxNBZP?=
 =?us-ascii?Q?EvL0HkpW9J18idAF3O4KGyftUdW83//SZahJeQwm+b+WlaD6+lJIl3LPZ9Bd?=
 =?us-ascii?Q?YsAvUZVZGatArtWMPgQ4Td8p5BiqIv7LoHCZIVoz9pl5WSYp6jSFZ19cgzqw?=
 =?us-ascii?Q?epqb9VfLTQM7li9LHwU9wNMox1AzIdlV4WL53ows8v6rCE2DTLVf/6k/cK60?=
 =?us-ascii?Q?XQBNBl8OeVANDBTmY3VnZ2eEP4t5a+zi5FtXKi4IF4VZYAVbV4cgn4Ic/a7a?=
 =?us-ascii?Q?y2tK0KCTgYlKA7vvSKqlexGGrAjsyPR5d5z2wBOZ1XRw3+WDFLE24FLn9X/u?=
 =?us-ascii?Q?EwAwGngIRN+bWhGzBGH642ypnaIfqxvCJVqDxgqkh6EPX1r4KoJ4OZ3Y8U5p?=
 =?us-ascii?Q?gUaEp/r8P5ADEuGlZJ88WObRVCEpWcG3Q7VKXKCKhCeEXZbNExKxVrnuRSNk?=
 =?us-ascii?Q?VgCy7/kui2IggP7lCfdjGRBy0jNeKu5gu4vAs08/0YRQdvMNNjJeF0ft/nUg?=
 =?us-ascii?Q?Be37aAnanyQGMRS9RW3n26dV7DLSJCZ8vGAVQxDwsnd8snGIW9/SVmno7fFU?=
 =?us-ascii?Q?uFeBdKQi6KRPAOc8twlElpAjgLOprT+BQvhUso+zjs2eYH+9p0lxmk0JhvrT?=
 =?us-ascii?Q?P4dh04Vch+hXRgHAbN9UaJ3pzBsbaVCOrCSYPGTtpbZ1QErlexKjKRILH7s2?=
 =?us-ascii?Q?3at+r2yKuPOlD8zb91gdgOQQoDuiWQDj3kjUDqRyCt5Qm7GdLUOVsohrm4bv?=
 =?us-ascii?Q?xKLKv0nDyCljD9pZ37GtUj4iZcNyrPtOWT3d68hrbJ8NhfdwvBwAy0AXa+eH?=
 =?us-ascii?Q?GE2L23mqV4Kqcl8DXDn01HSs0avous7Fnf2kmupeHh65G9IYYhMnZ5MC70si?=
 =?us-ascii?Q?TWtZvtbd/lG/yp1y5DLZU42nfCjG6bgaQ4x35md2S0nrSMH1vjyPiNLPtLO8?=
 =?us-ascii?Q?JCfmEZxPDpn6QrXVEWEOrBQ1PwUPN7KPs41EZUmZGIXGA5SAO2Q4rc/azVNu?=
 =?us-ascii?Q?wjNv6fMMXPc51WOnb8/1odG+H9wH2dF9bpDghk33isIRMxenZg3+WTGRA27w?=
 =?us-ascii?Q?DTdXgHRqBj3pCKXFIje1QzYvJq0zjJxVhlbYdpCjiEK6D5kIKOIl6fjMCnO/?=
 =?us-ascii?Q?Gi24TFe2RA=3D=3D?=
X-Exchange-RoutingPolicyChecked: FKiAzaqyu6d2tBWK72tDxTobejyJvXUfpaHwgf9JNp+OL2sgOYhoFuCS+I7Z6CZ4hhwgFM5mMfZzEq+LLtWQdtYfBzhmC6Jr6HkVsGP3gPNsh+Uvg5tZwNmNnfgZkL+T/DPzKLDjTnkCBfw8axQqmb5p/f/1x2tVaFeCa6A8XC3z37Z+Wv7hnG1O72gmjrXBU8ZLzLUK/wSUVGZRCPEWdFO+MpIvEmdJJG+QNV13cbPKtA3NLuyyiJpHjYs/rubM69/WKY+BheJmSnGeDOYN8oZ3eMKsEEscoz/A+aeQCFNlPcEPLqf2VDB9vGNxECQhPIGxC0olWq3Jaw8HB1bD0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac9a159-b45b-411d-67a4-08df0a0d0d8d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 22:45:28.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS6Cx5zuOLQnJpV5FyfUWeBaoOrTeKJ0CJASyTQxm1+80RUfXtBQqdqaAig8FRAQhXp5eEakWUssdRRMU0AGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB518990
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 09:04:31AM +0300, Tony Lindgren wrote:
> On Wed, Jul 29, 2026 at 05:29:31AM -0700, Peter Fang wrote:
> > +/**
> > + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> > + *
> > + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> > + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
> > + * modules do not support this field and return an error.
> > + *
> > + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> > + */
> > +u32 tdx_get_max_quote_size(void)
> > +{
> > +	u64 val, ret;
> > +
> > +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> > +
> > +	return ret ? 0 : (u32)val;
> > +}
> 
> I think you can leave out the u32 cast above.
> 
> Other than that:
> 
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Thanks Tony! This was discussed previously [1] and Binbin pointed out
that this makes the field width more explicit:

[1] https://lore.kernel.org/all/20260714055421.GB3178326@pedri/
