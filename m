Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B84A8A13;
	Mon, 28 Sep 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595166; cv=fail; b=eccw6HAh5eD7yM/bVwdbzc5t9YT7WoRF1BStc4nD5DMm813+inweI3dE+O22twVduUcDeaPkbfdzoiPfQBGcqJUUHLbU+taMF1ccE1kCAjb3nYbo/eseqrl4eju4GUoDNqlFuFcdAk6yP4mQfJeF/A7UqHcOXBRu5+o2KPOGS0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595166; c=relaxed/simple;
	bh=XenCRvhRb2d6m4vh8EoFixTTf8sYDt2QVUPh6Eh831k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GGZZbMhEdXOYlRCo0zijUynJMZXVam+sA/CN0NtqJIyqAZcV8+XwMZtTRhiIkltUT4QK3+39H54/PqZ9ba3CYOrp5CyMlZFJynEs9Iak15k4gPyFwmKssLFavx857IbDaWOrsaKsMj+tmyDQHV6NG4sz8t0yxF8G2Aa5zuJkldM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWknQT5Q; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWknQT5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790595164; x=1822131164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XenCRvhRb2d6m4vh8EoFixTTf8sYDt2QVUPh6Eh831k=;
  b=kWknQT5QECDpIpGIBep4OlUIt0fXryuHst4xJQTYzQE8piN88aGmtO/n
   VTaqp/U0uE62B1ys3YVuzoWINyB2wkfJV7fqlkc6yTh/jtng8ajTBo5sk
   DL28FWP1191Cx8sQrL8MxYKFBCBD7SK9aTxaLuU2akyev4oR5nHH2isNx
   1X8Z8dFIGeACg1OdBU0mdFAIolEjaKGYbxp8I3VXPXdvyfHqAzeLAbPxE
   ZhXVi0pU/jEIJI0e/cJRy6jme1ZPG71O+mDK9D6qfEJIY560xES5pVhsU
   jW5Sd4aakaf/53YVXVcq8B2zOV5g13OAEo8BXLz3G4wZmP3fvnpOg8WkD
   A==;
X-CSE-ConnectionGUID: 3KPc+BdhSDqZ5eSb/qekKQ==
X-CSE-MsgGUID: J1DxL+yBQJ6sIFMkxxMV1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="108780639"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="108780639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:32:44 -0700
X-CSE-ConnectionGUID: XkjwBktGRfeEXHfabv+Cig==
X-CSE-MsgGUID: q++BxPaDR5WwNK/QcxgUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278395058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:32:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:32:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 04:32:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfIHFJnIXaLj1gFZki65j0hRgyF5fFdPO6GmvJ6mg2inU2+0BkuMdTPIQcpU1C3oWHSWS17Efy+sHBHWSbz9m4I3vyK3VtvdVY+w1PFff7RVdSFDaG3YEBNVXP1tQPmZHFXQZcgTkRz4MRQNYCvi27ZzKkw9wZdmdkknXUqaUZuy3mTEoxlhbafhEEtp/Hi16+7jViNZIvmHqh0iD7PGjMyKaJPFbVPVG7tOHBJT2kTos8vkoIpm8LnG1RXowP5epkM1nfK5P8up0dj9f4fpf/I8kemdCL4MhlXk64MggV1v08vecQCibaEgyS47eqpp6wDcQr7uDNmVkhoO0bqmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOa35spZpw4Fh0d1XPY2IkSOFqqG14Iub+meG7hSoNg=;
 b=pJwAehfEUIG74yEeBc+MHBHkYQ+qIAiuhKka3xvYp1tOn/dAqRRLznYNqbZf2rUTZBvYI34EuzQwMv8L0ipozpnQbnZsmYYFfeB1mfW0GLKgcHtvdsnO1Pdof993Ncx1XXMWwu553ec3wklZ79J8smenBVW7ydi3RBkvxwPEKaVrHAyicVJyodTQNcaKVB42vwWbH2u538X9FXV4lytPtbHZbrzUJvXbZr7QBV8GfvmWnuBrySSJQZ/VzO2ogKHhSuoslkss/vUk7dv0PzgaLoM9/Ury45Ww+iVMPLUUcwJxW02DD/cAP4z7mJSUX84+7S/ANAkwvdv0ZltL9p15Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS6PR11MB943645.namprd11.prod.outlook.com (2603:10b6:8:499::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:32:34 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:32:34 +0000
Date: Mon, 28 Sep 2026 19:32:21 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <arpQReaF8q8ENnhv@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-3-chao.gao@intel.com>
 <390fc4d56769f87d91949e900262640b52b505b7.camel@intel.com>
 <arS6D6KoPbqVBtPl@intel.com>
 <2042fa92-0b33-4ce2-a288-8eebda2b7305@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2042fa92-0b33-4ce2-a288-8eebda2b7305@intel.com>
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DS6PR11MB943645:EE_
X-MS-Office365-Filtering-Correlation-Id: 598e990b-3f38-47af-0b87-08df1d5430aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: svHi35fEuBMv97n1lyXiLP4T/zVZMVIDXBLkDXTKqvEONkR43H7pL7V+GTI+SkFroq7ZJUkdaGAn2/ms51+Y9Ee69KqqFYEqNapFue4ZBkK/QY+6Bwzpn7FzGAuZhMSJbpiL8y0EZRMA7U6CZzidqckVXnoOB4LmSjcIF18Q+mrOUEMOQia7he8uP1HKTuBYByEQyQpaEACmCQZCgl7FEa4akM/J2dmGJbhEwXzWcfGo8IeegjPFNZTQ1kYFB2ZNRzjLqgwDB8AkJiriwY3V8kyjONQMmLnIn2wik63cWCHzEyO/h7GIQDRZQ0xnLHrJXG5LIjJmNsdsX6vMG4wqVNMA4glPrKGyhGGy6dvmRL7OXyzOxHfyoZUfS+wYg0H85uEZ5vmwj+ZORwE4ymAhL1RoOT888SogRNVx+UOfQFNOMtzmePxRpzYkgXUpiYdWvnez46Gyl/jvg4ZoceEGH5uG+6LyrXmdPqdMR/25lo13EsNlSdNZDgjbDw5sZU3ylKaCMyN0Xpcg5xd/08C25Oew4AjpnFjACxz5dI0m7/jQUf04TxqdtqRlNbrNsyREFTzcSbbVw1cxS0lNN20A+CAZOqBo787shOT0oRYnHnBF4GeqGgQW11P3BgCCpkxpB5u43et6+A89Qd7Jvy0BKaU3ylgcivLS0/osYJgT68E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H+5rrZ7MD07kpg7fSi7lYscsCwiqCf+RMjeCm5giifKM5UG0g1bN+WSVUBi+?=
 =?us-ascii?Q?wvLmMk/1tt6gxMJ4o0p2YZtrjuYAReDao4GluLjfeE4JpUuFG7BsylM4adUA?=
 =?us-ascii?Q?GLDZyI9cgrEqHRli3OAAuT/0HoAJoQ2glEaj3UNuQQ7YPWdoW2TUInHVTILA?=
 =?us-ascii?Q?OCcRb1T24K8ptaFoy1llJrDNNjs1HhPSF9GSYt4UEkSlOi2Vp7gidsw6vXVk?=
 =?us-ascii?Q?elz67iLr8iEvl0L/S6ayIqQdmEtwiJRY+kb5aui5B8oYn20/iqsNM0hE7oU5?=
 =?us-ascii?Q?RrwYbHvY5T00PtMNLBVG2hVdrdvFcUApBNNAQMropP3Zz+rgZ1t0cH2XWMrd?=
 =?us-ascii?Q?p63+alP2VIZIg7WEQm9P8ERrjwMxquxcFJLjs0lRvmcYtcqAFCJZHgpEUT3G?=
 =?us-ascii?Q?4tJ4fdIipFLGU1+tmsf53dWLS1Gl3cuwRe2BUUMB68k2ZSQbMBAUmKsLBmwq?=
 =?us-ascii?Q?xW2Dae6m8Ks3d5+ZNsTvCOZjU4DTWzt23h69ii40K/kiYgz7p7NvMsMvEWKi?=
 =?us-ascii?Q?xjzxSLg8d3IfgBy9OQRLRo4T5oDTcNOv2MSBJWV/cxmsagvR4YZ6k/MVzUz9?=
 =?us-ascii?Q?WsVqI+JFtPNRgkRMp3K2H/SZfnB3zbmEd1RJRXXMt4evQqPWUAN5fX0vnAnu?=
 =?us-ascii?Q?4o+mrli0iLgxZBmoVQjB6CgFh41kBJ2bSrq062I8AwQnmZAg3TL5JQ0CMcpT?=
 =?us-ascii?Q?S0Dt0uJZ8UGC6e9dNx1HwwucwCcyQ32M68J08sVcSslU9yivl4E1Pma7DGIq?=
 =?us-ascii?Q?f82rfLDEmI4KCfZo4s97pDX92tzi53ysv9OTzwyDARERd88MWJU/73HSngOs?=
 =?us-ascii?Q?cML8Rk0Zv7rk7yxrSNpXZDHBV1f48kVvlKT5z6zfYkXAPqIlYmjQJa7sT//9?=
 =?us-ascii?Q?yQwksZpegkTNWZqtKw5kbpkit3n228xY7e851XGfoBS5wjOsXzezNmVktYBl?=
 =?us-ascii?Q?PDrSlGZp12R6sMXl2Hy3TuseUkONbkqnt0aZqIPYeOR4RJkJOXM0iEP9Qha1?=
 =?us-ascii?Q?fZpmDZMckTjRHM2qKpdvHTgLtPPfCM0yiQ95QIqDr/iphsPgTiFYsktA0UYX?=
 =?us-ascii?Q?oXqW4dSLjDQPKzLB/JVh6ce8Ve2CmvVLRaJ8ReyovT3UtRnkotuyQNsmjUr6?=
 =?us-ascii?Q?fSlBPWUrU0QoWzOIiJrPu5NDcumWdq4xpuKL7xhRSq+iqHq/ABMQWBno/eaI?=
 =?us-ascii?Q?DSDUzXIXTL4Ut+WbVQfhvULFRjpCQcflnMQz/kVBYjtPoKu7aB7h+50h8oFN?=
 =?us-ascii?Q?WZfuC6ddbHzTpVVYFxDKLYlnOxckm225rafIb9qljyavFsuYSBGIqxqCLXYs?=
 =?us-ascii?Q?RgZSonvNP4ux3B0nDYx10KrYqVu/rO8PbbHjCGTXSU3/sOMjJpp9p1oRzLAQ?=
 =?us-ascii?Q?g4SK++yYxpLk/X9OEMIKbUtRAqU1PByQEaXQ1URj8PwuPNjbt5B6Q4huyKEA?=
 =?us-ascii?Q?aLwWkdoyN2t/Qb++3L63VDuUzELYd03j8xaCMUJ/Ozggie5WkU+3XHebhFHh?=
 =?us-ascii?Q?UuLjNW2yoMq9xC7XHm0PqBXaCUijtaX3u2M7WZ443L4pOwdx2BVCfEDuezR5?=
 =?us-ascii?Q?knexgbmk88jXk8TCPCFw1zgTc28X2MhldCEUmSSBrU0Xi1Qm9OqRCzvvUrR0?=
 =?us-ascii?Q?SUk+5SWpAlYqtH/GbJRELtjt1zhXWKODLfUjAkZHwyb2AuWrGhKztIlVo/1y?=
 =?us-ascii?Q?rr4CblMdSljtn8s8E1+mNOKw9Hl910ogh4EgFz7jtTJw/5IjNBFV6PqRIzP4?=
 =?us-ascii?Q?Fvot1eZGBg=3D=3D?=
X-Exchange-RoutingPolicyChecked: XC0A4WkpdiFoSGW6fqNlh+4zsgIEBQqpUn4GtJkgz1PKvuR6UEjStTKflSn0VyqFP4Bvne0pI6i23cfCMvHpCqoBvl+K6hZ/CS1/V/+js0Xc8cv31W/5cKRB5I7dRBzqa/aj8Re0PSZkBNbqN3tQMP1mHFZ+6szRbWwHQz/0YRge44HZIoxWtALP3nqvruptrLfPdJpwqu3d6Z75uTDB5Ntpy66bb5BIMgy4xRPuMWiLn32S0Wgi5/xu/vnhFdne7AHfvThKAyHGbONIzBurPw2BCqKs7MuqvcEoFvts3is88xPbunDnPY38b103UKSdPjkXl6Z92KbjLO4EeFmY7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 598e990b-3f38-47af-0b87-08df1d5430aa
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:32:34.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRxgu4zi9m22BkC2Dw0A+6TlMkGxvx0qn4bcKmKDilYxOihGXyaWV73WAYMHFm4SWHlVNu7481Era2H7easxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB943645
X-OriginatorOrg: intel.com

On Thu, Sep 24, 2026 at 12:12:11PM -0700, Dave Hansen wrote:
>On 9/23/26 22:50, Chao Gao wrote:
>>>> +static int get_tdx_sys_info_version(struct tdx_sys_info_version *version)
>>>> +{
>>>> +	return read_sys_metadata_table(version_mappings, version);
>>>> +}
>>> I'm not sure we need all of these helpers that are each only called once?
>> I'd prefer to keep them, for a few reasons:
>> 
>> 1. This one is actually called twice: from get_tdx_sys_info() and from
>>    tdx_module_run_update().
>
>Neither has any real space constraints, I'll note.
>
>> 2. The helper name describes what is being read better than a bare
>>    read_sys_metadata_table() call.
>
>What part? that it comes from "sys_info" as opposed to it being
>"metadata". Meh. Why does it matter?
>
>> 3. Some helpers do more than read a table (see get_tdx_sys_info_td_conf()).
>>    Without per-class helpers, get_tdx_sys_info() would open-code
>>    read_sys_metadata_table() for some classes and call a helper for
>>    others, which looks inconsistent. With one helper per metadata class,
>>    every class is read the same way.
>
>I value lower levels of abstraction over naming consistency.
>
>Remove the helper, please.

Sure, will do.

Then I would go one step further and move the mapping table into
get_tdx_sys_info() too, so it sits next to its only use. Using the
"features" metadata class as an example:


static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
{
	static const struct field_mapping feature_mappings[] __initconst = {
		TDX_SYSINFO_MAP_FEATURES(TDX_FIELD_TDX_FEATURES0, tdx_features0),
	};
	int ret = 0;

	ret = ret ?: read_sys_metadata_table(version_mappings, &sysinfo->version);
	...
	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);


version_mappings[] will be the exception and stay at file scope because
tdx_module_run_update() reads it as well.

Let me know if you disagree.
