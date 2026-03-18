Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635162E0938;
	Wed, 18 Mar 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852573; cv=fail; b=hahpsIgqrwtgrejFGMzFQ9rL4LeO6eGqmfkYFAleeRTMPhEjTwNWPoW6IoC3M0dvymD7y+hAX9N4d0t1jpzYsRzXMRARDC+o7VpW5Ucr/plKN7adckpo/1BNCUvvHWDkp/8p3gY2ZdbYLtZwO9iGZtxx/Ri6ZtqebLL2tqnAEu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852573; c=relaxed/simple;
	bh=aNepxhbTS0Ph31jtV1i2XsvfHmW59iH3pog7M7l6yE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnilG8XaI7e/0w5FDHwfHnZzceCQRNnmkPULfoPmrvCxxfnV2wUXCCWJp3rOq1vcbgsPHb1XGQh1FA3pbO/Pn8eQ4YakGyL4eYs83uV3IbEWFgk6Rk2sYiWalaGyXnqrtxhKOw1ezxBd3xxw1LbiZuAYohYwgCyI1BP+/RvNspE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkjb66p7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkjb66p7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773852573; x=1805388573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aNepxhbTS0Ph31jtV1i2XsvfHmW59iH3pog7M7l6yE0=;
  b=fkjb66p74d3MQnNBVPuKfTzQ48G9jGU4KFvOgprDl8IzcFM35rFpC4LH
   MZVLHF9XouVNSVo6srGJ4wWiJLekmV99T4ITyXfveURTPGevIDNn2bfqS
   xl93eWscaQ1sfmhWfAcrBRvjsaUlaDVMzLIRKCCn6mMo/Hb4lO38QkFYq
   OIKQT/ANcbTP9o7PmwZnfNka2qc+vjbTvw8euMZg+hlcJhlwI2AmreL57
   Wuc1Dvv9ef9rYa/y1nj8Sqxf0hdDHKnVwQ9bhH2IxTIzy3PA11LdMQHRs
   a0+fGNKh6ByZ989+ZAvYwJUqSQbhMQqKt7LFdtHfUSxWaTZ5eGHW2F+wW
   g==;
X-CSE-ConnectionGUID: laLpve9SRVyvVRM2r+sBig==
X-CSE-MsgGUID: 0hi+KVuRQBuATR/l+JUj+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="97523108"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="97523108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:49:32 -0700
X-CSE-ConnectionGUID: 3LA99dH2T/KmU7KetXRfqw==
X-CSE-MsgGUID: TSvfppNOTT2R3nES9Y3I4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227634096"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:49:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:49:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 09:49:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQc+qVG/iUMDhw88mSoIJ+L73SLXxYtO7VMVELNOKhZ/cC/FJyLq9QkSJG4wsA/qW1HZqH0LOU2wycjuylkSd/+fl1fpq/DDF905riTHZz5lxSAebcxpFGqNOwQZtDa4JVSZXdrhUgEIDFX7+kBi/vcFfvU42tn0ind7eqFUKnSm/fOoSlb26BKf/igz0FBwbSrP9wj/DZRJjO4Iq8Tv084TUMiQtazLviiyPMYItt5ROis6iGXpX2x1xaTrydS60zr5hlC575VHQNU2GH26926qxfxd5+c113kGDqLFPO4wUCpqJRTwyHr9q27VJcL+PbnvkTJtT5q8sAf64FiXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s02gZRrbMlukIi8w9QopOmfaTe85Tw1WJ/wkr+eeh4w=;
 b=SXfyvbNK+FwzHRo3OUvTC6YmNeEdB+hyDpVygz0wsGoz4bMKRqiqH754WsSBfO9mCbI/FmAiz1G2VIEzEspwuUNQ71UkV+dv8MTuQgzpQR0N1Tqn/CyxWWVj5QtabKVj8OwBhy9Hb/vSYv9BDP60HDuTVKr41WAVu9Pqui+T7G/sq+OZ0KXc+dETCtzYOCdg6i1Wn41lF1NghbHdJZ2z8X64czP4SgHCkh1NaSuT3JLePzQe8nu4xlwZBv2X+YoROaSXnZVaguEYb2fs+U52vuIEunv3r6oD+68nnnQqCh7iejue4ThgBekJU7wYFCGAB2KQZHaqRyidyL9ZwpqYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:49:27 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 16:49:27 +0000
Message-ID: <1ecd023d-2bd4-4a94-b315-65b9d140030f@intel.com>
Date: Wed, 18 Mar 2026 09:49:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
CC: Nikunj A Dadhania <nikunj@amd.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<hpa@zytor.com>, <xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <chang.seok.bae@intel.com>, <jon.grimm@amd.com>
References: <20260318075654.1792916-1-nikunj@amd.com>
 <20260318075654.1792916-2-nikunj@amd.com>
 <d3140cf6-e61a-40a5-8153-300d5fe07954@intel.com>
 <20260318153918.GBabrHJjRA6T2crJbK@fat_crate.local>
 <09fd1a56-71bc-4fd0-8d07-724ca1c830f6@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <09fd1a56-71bc-4fd0-8d07-724ca1c830f6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ2PR11MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d7f6fb-5ced-4028-f4c1-08de850e514d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Dq8Qhv7b7FcQkwp1ud/k2HGXqDw8y/8b9glo1WXBwlzudJu///K3mlN7zzYiDRu4GRE7UD+CU0I4zVexuD6EC/W5vSzYvWKXAq1KLWM7RQoQvgShFj/AVJ9wMZOEpq0Hx3u+0YUdZgM/O5SCBboQZv+NbP2uqZoaeuFzhiLFnwnA/ckfBcaX84hmyaNRPsTo5/P6xZIPD7OXQcLyiFGqzv7cJulHnj7yXmHHA6y91MS6Gui9jL2JYkQzdlAafz2uZGGeGn4PX/hE6z6vN4/sQZNQbFRpuAxn6jYJ4r+Coimxfs4nCCUWm/MEEV1+LftItgmQwws/aQK32NlmvCGMaXweRkGWLwuqYi5lCGaXDT14P5TJ15k5325khYc2+HXyIbXh3kkE8bAWtdL5g+eDNEhBVQIVIm/zAw/qYjIq6R5rapMRUn5ZwezbwOaMQeSsHkmCOxZ8nycL7vJFtEa2ucMtPQK2Kc0aJe9syCulnGmuF97oN5r6nAFoQKceqWXd2AVOlUKyd0o8FKfHj7e0ZzaYHSa/Ya7cE280jkLTPm52MbOwsnTQspJCpZr+d7SRQZ4e2cVQDRtsRIBp+caztlGelSYeqZN7XdoB/3SXTUWiqh8Akip+xg8xKpk7hqyjwRLeMnv6vUToBZ1TERTCQNR/3eVReI57/s2ukg/0V3mx5u3aHWRtrVaC+2XnMVSYe4LTj5urheEW7qiyIn8mafGyoJvfN18WAtbXNuoYY2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlplZUFwdVd2TE5GYkV6Z1FXMEd5Sm5Wd1VCVDRscCtwVFNoZVUyM1loWkYx?=
 =?utf-8?B?N0h0Uk9JRFR2MVBXMXhHZTBveUFkRGtSZkRBTWhKU2owYVRTNjZsZWF6OExx?=
 =?utf-8?B?VkcvL1hIZnFnYXVOYjZWRFVVcmt1RzZFMEZlbGVZS0padHJPcDVsb3dCcFRJ?=
 =?utf-8?B?S3daUWEzajZWYk1DOUt5TmEvMGlrNVo3YzM1ZHRzMlYza1dmSWNMTkRJTEVH?=
 =?utf-8?B?Q1lOMlplSUljbnkxYjN2SG56SFA2NEx3RTRBbm5PdzJEMFlyb1cwMDJZaFA0?=
 =?utf-8?B?NSt3eXFVcUJRNTBOdGVJNTZzWkk0SlBSMCtDb012aitSSTMwck9jREYyR2dM?=
 =?utf-8?B?ZlkxUDc5M2IxSTlxWnRFdzc5Q3NMVFRqcWNjTlFkUUtGNHloMlNwbmxKamg1?=
 =?utf-8?B?OGRVNjA3bmFSdm5SbmljOU1CQTBLdWhLODNESy93aDhoc2pnd1FJTnh2VDd5?=
 =?utf-8?B?NVl0V2MyU2UzVUFBU1FGS3AwbXlWMndTQ0tGblA5S1FoRVROSlp1RzZoUWRh?=
 =?utf-8?B?NVkrT211UXl5RTJGOTRZMXpXV0JRWGx5TTlQa2lINzZILzI4bktzb21Bblp1?=
 =?utf-8?B?eWZCZjZhWXVGS3NYeDNDWTZPNWpZelVoQlJTVVFZT3hkYTFldHVQNDZhQkIr?=
 =?utf-8?B?WlpzRStqeUxBWHhUU3dKK1pYdUJMRHFGN0w4TEVpekk0c3liczZhZVZaZDJI?=
 =?utf-8?B?YjFXVTJKZlZ2QnMvZkl3WGJkRmtydXYrUmt4bzVtcG0rZ0ZQaGNmSVZrUEY5?=
 =?utf-8?B?cXVzbDFVeGJMbUVRbWc3TGpQWTBVWU01MlhUbEJsSDhxREU2dzYvcVVpSFRW?=
 =?utf-8?B?a2ltNHRWUlUvanMrZURKZkM5YkZYcjJhQk5XR2NsQmhRVmJ5SFlPRmRqamJQ?=
 =?utf-8?B?N283aTdTSGg2ZElDVVF1STJDa0dheHlUL3J0L1Y5MjlSSWI4UzFxdHl3aHJj?=
 =?utf-8?B?T1ExV2xrUmFya2hpMERLR1NlZXVxc3YxUUt6eFErdHc1dTV2L2t2TjYyNkEw?=
 =?utf-8?B?L1AwR3U5ODRvWmJqK0JONm9UWHI1K1N3b2V5ZFBRa2ZuNmp3VC83OG1SWlJO?=
 =?utf-8?B?S1dVTmU3Z1g4S2IrNXEwbkN5djh5c2RLbCswdUxpT2ZiUmhWN1kyK0FqaEpx?=
 =?utf-8?B?end1K0tucDZFNXppdEpmanA4Q3dOSS9TVkNMWktXSkw0dXphL1lmdGorQWpi?=
 =?utf-8?B?dWhsODRQTW5vaHlhc1RKNmtkNVZlMWR3d3Zlb3hzUTd2R3JzTy9PaUg4VWxh?=
 =?utf-8?B?OHlhaFF0MzdZamcvblNlM0FMcmJpeW5icVA5M3RxWFFwbnFDSTUrb1IrRmhH?=
 =?utf-8?B?TkVnVHAxWElvTHlIQm1vUU53L0p4RlNUd29QaGZNNTJXazJNamZtWDBsU01R?=
 =?utf-8?B?SjNYYUdVaWRrbDRrTXBpQlFDUEZmNVdDMUdzeHp6ek50WWVMOFkwaTRleWJU?=
 =?utf-8?B?Rkx3RlYrQXpEUWFVSWZFVWZMNjJ6YTFsRnA3K3l6WDRmVUxLUkszbU5kWUVY?=
 =?utf-8?B?eXBYWjFsUEFWRGVVbE1reXNRaXZnS0RLcmxNWG5LMHBURUtVbU4zS3hnR2Ew?=
 =?utf-8?B?U1lSTkZaVEVlQ25JK21qWThRMmFLZ2IybGlLOXowQTIveE94dWpxYnZWQll6?=
 =?utf-8?B?ZkJ6cmNVMm9KVkV0WHZlMFlybWhEb2YvaU1vUklzMzZZZnp6Q251UmdoVXhV?=
 =?utf-8?B?RE15VU5hRlVLWjdwWWlEYjdSUlJwSDJROGxCNWJ2VEJOcjdpcDR3YUVBRW9r?=
 =?utf-8?B?UUllMW5WWUFkaFdVeFF5cmI5ZnF1S29kZ2p2T3FQc3ErY3N4Yy9TYjliV1NM?=
 =?utf-8?B?VEpKUjdpWkNqSUdKZGFxWlRwU0dld25FZHNRanRJSWsza1FCbFJWR1c5Z29B?=
 =?utf-8?B?bytVQlVGRDZzNGt0WUk5WGtweitkTk56Zk9yaWJzRlVKK1EwVEFjd0lIbjhu?=
 =?utf-8?B?V1VVN1UvMW5nRWw1NEw3ejlPLzhXM2djQkE1aDBQeVgyd0Z3T1N3aEJPMXkr?=
 =?utf-8?B?TGdUZlFLV3oyWGZoRGQ2d0R5MngveHh6TEhLcTE4U09EWjczQ1lvbm42T2pR?=
 =?utf-8?B?SzI1aXdrRFY1bGFUZDl0cmF3Y2hWZ0M4bEViT21Fc0FWYzhlUVNHMzVEV2I5?=
 =?utf-8?B?WWFjT2R4YmN5Qm1KTHF6aGIxa3EvNzAyWjJlSitwZ0s3VnNyVHVLRC9oTGxt?=
 =?utf-8?B?Q29VTFFyaDZQeUtxR2VJSkNmZlVFWjZCZG0wM0dPUk8vb3FSNnF5aDRhQXpJ?=
 =?utf-8?B?dmV6SlhNR0tlN3BxZGtJVG1yRGpjWFpiNVkyd2g2ZzdZNmJuR3lWZWhKWWZI?=
 =?utf-8?B?aWhDRUp0Y1plL21pRGhRWFBmTUVmL1lQc0ZVaGNranZtWC9UUWVkdz09?=
X-Exchange-RoutingPolicyChecked: aVc3Pqffl87i92wCusY8XrFYTU3CTmem2JHb7rkdPZ4pUGTTkD6lUaz9DRqkExIuPWyl1yuCDdBLMYZv41Yitvnvd1JF5/zpiwOGLxDsCf8clUwwtRREgVog1gGx1l8UE4VavjIjsf4P0iq8qVilOCD67oKEURCgwUNjp3i8yP8HSI3lFBwlu9lRFCgY+vgM0v5iYgPzKfAO4M5H871zPv9q8KYT3oPa3nzktDvjMgN/CxC0gYKfUirfFTPaOPWVTJrW4cbPJDBO4HvBNrQVO92OliiMfDiGKHaCCfRZ0R/T+CssPUsayFp8RfmeAA0QYVs90fFGlVLGleWXDZHaEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d7f6fb-5ced-4028-f4c1-08de850e514d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:49:27.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmVMyJUKhMNXuwhlwEFKGDy9d8QDSBc1blnI5UhljhCzJ6J09FwNW9shUwEAfS+4BGFi9Ax0XkYjAnz0zq6ziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

On 3/18/2026 8:53 AM, Dave Hansen wrote:
> On 3/18/26 08:39, Borislav Petkov wrote:
>> On Wed, Mar 18, 2026 at 06:54:46AM -0700, Sohil Mehta wrote:
>>> It would be more accurate to say ".. before any exceptions that uses
>>> paranoid_entry() can occur.."
>>>
>>> I think early exceptions such #VC can still occur and the
>>> bringup_idt_table is set up to handle those.
>> I really don't understand what the splitting of hairs is supposed to bring
>> here?!
>>
>> The commit message is more than clear and overly detailed - I even thought of
>> shortening it because it went too long...
> 
> Yeah, while Sohil's suggested addition is technically correct, the
> suggestion is a _bit_ too detailed for my taste. I'm OK leaving it like
> Nikunj's original version.


Sorry about the churn.

While reviewing the patch, I was trying to understand the difference
between the early exception handlers and the one setup by
cpu_init_exception_handling() on BSP and APs. It caught my attention
that the code comment said, "Enable the feature (FSGSBASE) before any
exceptions occur."

I got a bit carried away with the technicalities!
