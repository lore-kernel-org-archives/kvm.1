Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FA53C3B1;
	Thu, 15 Oct 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077427; cv=fail; b=pxQtY55R8amEZr1FfyzndrvbEdlu7sZIapjhAyRVEtOHpODdYxWJpmR+/0FzmzjeC2NKk1i06RFNS0kndnnO/5EjGOiuSAjJsv0Z3hrB8g1G4JOftQlfvArrpVO2WDsZ5w7ERa3+dtnh2+bVXXUtxjbOMgyJeEQzNH/auD10eK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077427; c=relaxed/simple;
	bh=qZO30+YJi+EVicSASe+llfRPsrSIS45sc+isy8OU5Q8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPlxw1dcJjXXBKxnw7wYoziozXdG450r9HXhXmFVnuPhETnwAFuoYP1GBv0JClZhhCy0w/gIYxtaCszQWauxUmD2LnxrmSVMAbMDk1tYZA/FQe2WTIP8Vs+hej3vJ8w8shnzgt482uWmW6kGbLXdMXF6x+6aHW2iiZid37gfcqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGxfpISL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGxfpISL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792077425; x=1823613425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZO30+YJi+EVicSASe+llfRPsrSIS45sc+isy8OU5Q8=;
  b=fGxfpISL7GVu6uOtBj1l6BVtq13iNgPXJ4lxiqRLW83YiTejNyBIclD2
   AMtU0mQBXWgbhWF/aUhZcHPJq3Y/9WboRLXoHEvaQtEai9iFw8gU0e+M4
   cSoScXofoV/ZjfGLH+R/fwR5PiUPOfHeV/xL0Le6Hg6qY/svZgch+EwmH
   1uGRXUDdZHSL/YGXERXFfLWf6elMlHjFYWmwzLmvImdMj67DS1M+lzrLq
   eVm8HT/eQkEJSvxEnjpwFh+KGKpAq/19NLKHqS5YWZGa8XJBCPmAn+glu
   ZX8x41/YvPFLI2+8Zcq/8C9dWCpzuH5ZagSKV9dtVaXWhN8JL5OB2Ht9C
   w==;
X-CSE-ConnectionGUID: otLaKFUhTuOSdxzHuM0P3Q==
X-CSE-MsgGUID: +7dP0py4SAuy33Owl9Uxpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="862026"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="862026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:17:04 -0700
X-CSE-ConnectionGUID: ln96/HzGRcCayWRJ0Rbrag==
X-CSE-MsgGUID: XClm7FqvROOs2cLpJwexsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1790186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:17:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:17:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:17:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3rRbOVJgIhO8H3TTcYFwcgwAvvcTUlrIxVgQvlzqmLuZX29BeusVd6zJnAQeanoZ037m1UI9xpWEURlcIKCiuzzJNMI4wm6716qzJLM10jtU8OR0F3Q8WYjk6O2XSYzMmUsubrds2IHg5w9xaVt2fA4zwmu5E6tIPJF2cYFWGtZc196PtjVUNRnnf75clgq5wA0td7BuxNjFFS7mUIkhBSpmB9HxPXrR/2WaCn3d+Omlxn26MIi+821MRXtJJ35u9Eu83oYnE+0WHve1idMG8TbJVCPibJVg4ZFGVaWq3akFcqJsmTzQ+HRkFFN7YgcXx/oIUmEyx+5sije6ZrSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNl1TjHIBwf5WDwYojzZv6PzYZN+HnZzMC5ZVYOdL6Y=;
 b=q5t8BIRZDeg1opcjuaXEPvt43FOSW/sxXb5TMcrbtohalZGNgV+u9MsjhLs7Q063n6oSzAqI0WCXqeAFfIUb//QIJsrzB1nRhMtNwjiXtQJTo3tYRvHA4YpUkz2VVYaP/Z+xQ1bEE959t6iB8KnhCxzRNKeK4XVqW3K1bZHKMblHlgKT4zP+COjz/i2Enq4r3ZFSrTjzThJgKg5mGJ6uHLhqfnMtt9dfhXE4g+AgNKKWckTL3NxzawOTxkTzxk9Wp/omiGBbCByyvjO9dGbIwXFVbpbo4eCLEE8Gsy2GOsYERGOAWjJ2pZsCZ1akYD0XU5tDW5ZzqGHqg983QmWJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by LV4PPFFFA7CE81D.namprd11.prod.outlook.com (2603:10b6:40f:fc02::22f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 15:16:54 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:16:54 +0000
Message-ID: <7d4770b8-779a-4c7a-b5cd-cd3739172a92@intel.com>
Date: Thu, 15 Oct 2026 08:16:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] fs/resctrl: Add interface to display kernel mode
 status
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|LV4PPFFFA7CE81D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd11af3-8cb3-4115-f415-08df2acf58af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|261009223027099003|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|6133799003|8126099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1a2j+JZDu17gfpgq8i29qORR15cRrxjoLib0APr7FVQOZcdd52PDHi+ec4ilZ0RTxUvjlc3Xr06XXoWWT6l3azcb+0DcOUQuu8nEX9vt5qaoMLgUp9SsEukSAij+I6/QlptRNq6FkG9Z16C8n2zYmoQcnMB/gqdmbh/nWCGVkrQpZy4m7m9PeyMfPc7dEOVz7YMBTBGBMlcBRkMC+q1I3xTmsO1M9UHcmSLR/uFUo5iyVKNf/i20GY9DlBofLwAy123F2P9C75uMZEQT+dIsN/Zn4oQRsuOGQv0CEHXexC2sWrM5nDAhGNAjUtvNLPrGyK9u051IOLLCn3eYfflOaOLbWgcy/612E2D/cObRD0H29wxMlK71lrEFVKpzchJshheKHwvXWqBL0HN6jMxqSJa4h5NsrIqecNYgCU8Eg4TFr1iwC2hJPTgcfYIObPJ8JPW/EUFK+pu4GUw0KljNHVzRHmIDqrUjBArL2jGbstQMLMFxt1dAnup135j4Tj82L8NgoBJA2CCxweZ9YHk52fSbId4CTa6w2be5+Bf9sMIBjeFscQzY+alTDJZRmGLRw9U3MJuCb7CV5x+Cb4GrFO/2b73YLutVfmY5i3ws916q+dWfpNNb3Gmy3CKRS5TbnYs9YWeUK/ZnJLbM2c3UrjtE56wcM9TGIdesw6IRgM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(261009223027099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(6133799003)(8126099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRTbGJ4ZVlBREtpald6T0RMSEdmTjRwVmlZRGdPeFdhR0dXODIwZ0hGUnRS?=
 =?utf-8?B?MkU3bmxvclNia0Y5VDduZ3BEeWswMG9zYm9IQXdkSi9neXRLci9tNTB6aHUz?=
 =?utf-8?B?Zm1pVVJodnRCNk01eFB1bjBQSHlBREJ4Q2UxalB2Mk1WTkc5KzUzWlB2UFVI?=
 =?utf-8?B?YnUvNi9keWRIV1NCY3NiZVhRSnRUUjZidWVKV3ZEN2VvV2N0WHkxS2lTT2U0?=
 =?utf-8?B?b1E5Q1krZnEzcDRkeE1yRVVMdEtWRGdwcG50R2ZtMHJRK2VPNWw1bkxvemdC?=
 =?utf-8?B?UkVZc2h5ZVlMU1VoeEs0UHpqSENicElFNlpqZjhtaGxaME5NaityTVVJbHNO?=
 =?utf-8?B?cFJ0dTNiYXkzTnNERnp5VFFNejBCOC9kdVNTUDJMS2N4cmgwZU9aZHdTQzZs?=
 =?utf-8?B?Q0lNSzNRclZnUEoySGd2dFVHWGUxakRwQ1lCR2N5aXpySGpXQU1mNi9UMTFo?=
 =?utf-8?B?KzY5YnE0SG1jNzJCMFc4dGdFTFV6QTllSWdHZkhyWEZ3eXo5R0dkbVg4eHo3?=
 =?utf-8?B?amFEOE9xc2NFZGxQYUVHRXRQNGxSZW1rNWdKM1FldmxRUmpjMHlxc29TV2ZW?=
 =?utf-8?B?RnJXcjVrb2dZNGNnczNQM3lZelgrY3pUbEhFT3lWTTdZV0tEVmp2MHFUNVhZ?=
 =?utf-8?B?dnprdVcrL2o5OFZZdmhuanRkNGVuT09DSDZ5SGZ1MFUvNVdLQVVTMUkrTjgx?=
 =?utf-8?B?UjhkazdicWJMSTVlQkE2TVY3UUtPZ1NFMkN2V2w5R2p6TVRNT0lpZ2EvOTkz?=
 =?utf-8?B?VlUwZVM3SklyVjR1WUpSMzFMeVhQZkt5aU5kTDdmZmtHZFJ5WDBZZlJIT0pU?=
 =?utf-8?B?WmZ6Ny9ZSEdHZkQvMkQ5YXp5UHZ2d3NuTDVUTGlQVWlDRi92ZlVUU3N0UnFJ?=
 =?utf-8?B?MFFPUVgrR0YwVFJlbHpLYnBibHoxcFdaT3FzeDJ2dzA5SlJScHdTZDd4UHhu?=
 =?utf-8?B?aHpGa2xYYjFiZTVyWkF4VHcrOWcyaTd1Sm5WaFFURHpLMWhEdUd0MDVPb0FY?=
 =?utf-8?B?ZEtwSWJ6UjdPakRkZlpLcjllRVhBdDlwMi9tVjl3c2g3L3lzSTY2UnUrZngy?=
 =?utf-8?B?L0JqMk50R0JreFl5RmQ2OHJ0eGRqRktOUFMwL0pSanVGYlRXR2ltUlNIRVYw?=
 =?utf-8?B?U2FYK3JvYXhTRk55OSthVWtFclRQYVQ0MFg3R1RZdU45SXpTUm45MVYyT3pt?=
 =?utf-8?B?WSszeklRMmJoaEdJTnRidS8waXNySjB5RCszMURkNG5SY2psMHd6a1hKS0xh?=
 =?utf-8?B?elJVNzlMVFZZTHNBdGJNU0s0blFMSklrQndIdC9TL2hqVFcycFJ0VTExNTdz?=
 =?utf-8?B?YVRlOU1pQVVoeG1GenhZQm12eVhKS3VLTGxDdFFJM2FCNUhxbEQ0cTBXd1U4?=
 =?utf-8?B?Sm44WXhQMkw2eFZCVk9WTm5idHBSeklOaTFKYmswQndEMWNuQVpCTDBOcEdI?=
 =?utf-8?B?MXFZYVN4T0h3eEw5SFUxTGRyNjBLOVA1V0dvTFFRWUJNcWtXU2F2eUlkU1h1?=
 =?utf-8?B?TndzWUlxTzg5NGJRS0RZWHJYS3o2ckc5bkdkdXZwWkNDODB4cU5WN3VNK2ZL?=
 =?utf-8?B?cUhWTWg5UXJrdmpLWUswMnhURWk5WVhZaFlMRmtUYUxlWVJrVW9wSXlCanpn?=
 =?utf-8?B?TWNnUDZMSTBCRGdnQUc0ckU1akEwa0lsWDJKdXNMQmZMNTN4d0o2ZDkyaWg3?=
 =?utf-8?B?Mk9lNDJxbzNCeG9rT2pVbGs0Kys4UFlCWERsN2lSNWc4K0JYS0UwWWtKSU1O?=
 =?utf-8?B?cHUxcWp1SHBRQ3RLTmlnc3JBOTllNU5VQXBjM1lNbEdyakk5Z1M0b0RpdXQ4?=
 =?utf-8?B?eldPTURZT1JKRDVRS2thMEd0U01qNlVsVXN0TU5KYWZ0dUhLcU0wY005aDJI?=
 =?utf-8?B?NlN4YkI4ZDhVd2RCL3ZDOFZxMG5PMkZxcFhSYWU5MmdvMXhya3MrUG1UaXVB?=
 =?utf-8?B?U0pac2VPRHFVMW51Ymd4b1Y5MytWTEJNbGNibmtlc3NLeUc2R2pFV214N2tE?=
 =?utf-8?B?NWg5L2ZJTk9ERXhmYWFwMzVzZUp0NnRIaEp2bXZlQm1rbFJzWGdGS2JiRGti?=
 =?utf-8?B?bDdZdUZKNmxqQmw2bmRiWFdjd2VhUWU5YW1TMWViL1d1TWRPczhxaXMycCtI?=
 =?utf-8?B?UnlkYlFabW0vWGIwZldHdjlrV01iVDYwZVY4WCtERjc5SXNnVlY3Nks1T1Nr?=
 =?utf-8?B?azVxV2JTckhRanBCM0xnd0dDT0FhKytML25aZ3F0bytmUERGcFl6Wm8vK1FD?=
 =?utf-8?B?dWtzWk5Sa05PbXB3clYrYkNKUDdtRkw2NTJva1lPZThKZDJ1MnhER1dCb1h5?=
 =?utf-8?B?dXl3NDRPWEVOa2NVaUVFTjhJQ2VsZ1ZaVktjKzd4WVYzNUhOVWlUTEtTOU9I?=
 =?utf-8?Q?CM5Tku/OJVomgM5I=3D?=
X-Exchange-RoutingPolicyChecked: dcKTUhs5hYdeJ29PFlnG8aelxd2gT1wm4MBaQ/08xwMAkDVI2YWsh+VD5yqTKbcs/Xg3U2k8ug8NQXyFPFlVIuBBs7syxBn+ndjdJ7acE2fGb0zurt56mYDY7uC9jz6aTOCSRr+Yf3azJVH6CehaOz5mUZz4Prlegrx37Thf/5BoeR7fCQDSTDDKv1DZlhIeD5TGGDIcjfz+OMDrck/s3a2zm9PrU010cm0CgJRS70NF6yB9ekTvyjhqFBZSUe+R76vnRAIih3ws0MxnSXghjZAsdXyffsYCLuYmj5+ZarJgf7pzLbw77R/iuzR+9t96iFqrHlezbEAQUBPlCp3Yow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd11af3-8cb3-4115-f415-08df2acf58af
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:16:54.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFXZC6p7UfD8zfK55XqyVO3JLmXlnjnBwTKoO1aG4bHj/zjbehIfmstRbDSRjOGQcWZIsb0NYaJ314uje5pJ6VvFIKk/O5UkRQbxGGmrJqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPFFFA7CE81D
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> Resctrl kernel modes control how allocation and monitoring associations

"allocation and monitoring associations" - unclear what this refers to at this point.

> are applied in kernel mode relative to user mode.
> 
> Add info/kernel_mode to expose the supported and active kernel modes via
> the resctrl filesystem. Supported modes are listed one per line, with the

(needs imperative)

> active mode enclosed in square brackets.
> 
> Document the interface in Documentation/filesystems/resctrl.rst.

Above sentence is not necessary, it is obvious from the patch.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst |  48 +++++++++++++
>  fs/resctrl/rdtgroup.c                 | 100 ++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 73bf89d0ac83..73ccbb9594f5 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -527,6 +527,54 @@ conveyed in the error returns from file operations. E.g.
>  	# cat info/last_cmd_status
>  	mask f7 has non-consecutive 1-bits
>  
> +"kernel_mode":
> +	In the top level of the "info" directory, "kernel_mode" lists the

Note that just above this addition the documentation reads: "Finally, in the
top level of the "info" directory there is a file named "last_cmd_status"."
This addition thus creates a contradiction by adding another file after the
"Finally". Could you please rework that portion of the documentation to
have an introduction for the files in the top level info directory and make
it clear how there are two files in this directory, similar to how the other
directories are documented?

> +	kernel modes supported by the system, one per line, with the active
> +	mode enclosed in square brackets. A kernel mode determines the
> +	allocation and monitoring associations when a task switches from

Would user space know what "allocation and monitoring associations" means?

> +	user mode to kernel mode.
> +
> +	Possible kernel modes are:
> +
> +	"inherit_user":
> +		Kernel mode work uses the allocation and monitoring associations
> +		of the user-space task on whose behalf it runs.
> +
> +	"global_enable_per_cpu":
> +		Kernel mode work uses the allocation and/or monitoring
> +		association of a backing CTRL_MON or MON group. The mode can
> +		be activated or deactivated per CPU. The line contains group=

Having a global "activate"/"deactivate" as well as a per CPU "activate"/"deactivate"
is confusing. The series switches between language here but I find other places
that refer to the global "activate"/"deactivate" and then per CPU "enable"/"disable"
to be easier to follow. Doing so will match the text of the "kmode_cpus" file that
reads "The association is enabled on CPUs added to the mask and disabled on CPUs
removed".

> +		and whichever of ctrl= and mon= the platform supports::
> +
> +		  global_enable_per_cpu:ctrl=<assign|inherit>;mon=<assign|inherit>;group=<CTRL_MON>/<MON>/
> +
> +		"ctrl":
> +			"assign" if kernel mode work uses the allocation
> +			association of the resource group named by "group",
> +			"inherit" if it uses the allocation association of
> +			the user-space task. Present only on systems that
> +			support allocation.

ok - this is already late in the series but this seems to make it clear that
"allocation association" means the portions of resources allocated to this group.
Thus the earlier " enum kmode_state - Control or monitoring association" is wrong?

> +		"mon":
> +			"assign" if kernel mode work uses the monitoring
> +			association of the resource group named by "group",
> +			"inherit" if it uses the monitoring association of
> +			the user-space task. Present only on systems that
> +			support monitoring.
> +		"group":
> +			Path of the resource group, relative to the resctrl
> +			mount point. A CTRL_MON group is shown as <CTRL_MON>//,

Shouldn't it just be <CTRL_MON>/ ?

> +			a MON group as <CTRL_MON>/<MON>/.
> +
> +		When the mode is not active, the parameters are the defaults
> +		used if it is activated without new values.

"parameters are the defaults" seems to conflate two things: (a) the
supported parameters, and (2) the default values of those supported
parameters.

> +
> +	Example of a system that supports allocation and monitoring, with
> +	default mode inherit_user::
> +
> +	  # cat info/kernel_mode
> +	  [inherit_user]
> +	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
> +
>  Resource alloc and monitor groups
>  =================================
>  
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 75b81d07a247..e82709d64a00 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -993,6 +993,99 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/* Names used in info/kernel_mode; indexed by enum resctrl_kernel_mode */
> +static const char * const resctrl_kmode_str[] = {
> +	[RESCTRL_INHERIT_USER]		= "inherit_user",
> +	[RESCTRL_GLOBAL_ENABLE_PER_CPU]	= "global_enable_per_cpu"
> +};
> +
> +static_assert(ARRAY_SIZE(resctrl_kmode_str) == RESCTRL_NUM_KERNEL_MODES);
> +
> +static const char *resctrl_kmode_state_str(enum kmode_state state)
> +{
> +	return state == KMODE_ASSIGN ? "assign" : "inherit";
> +}
> +
> +static void resctrl_kmode_group_path(struct rdtgroup *rdtgrp,
> +				     const char **ctrl, const char **mon)
> +{
> +	*ctrl = "";
> +	*mon = "";
> +
> +	if (rdtgrp->type == RDTMON_GROUP) {
> +		*ctrl = rdt_kn_name(rdtgrp->mon.parent->kn);
> +		*mon = rdt_kn_name(rdtgrp->kn);
> +	} else {
> +		*ctrl = rdt_kn_name(rdtgrp->kn);
> +	}
> +}
> +
> +/**
> + * resctrl_kernel_mode_show() - Display supported and active kernel modes
> + * @of:		kernfs open file
> + * @seq:	output seq_file
> + * @v:		unused
> + *
> + * Lists one line per mode and brackets the active mode. inherit_user
> + * has no parameters. global_enable_per_cpu prints ctrl= only when
> + * allocation is supported and mon= only when monitoring is supported,
> + * then group=.
> + *
> + * Return: 0 on success, or -ENOENT on error.
> + */
> +static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
> +				    struct seq_file *seq, void *v)
> +{
> +	const char *ctrl_grp, *mon_grp;
> +	enum resctrl_kernel_mode mode;
> +	bool active;
> +	char sep;
> +
> +	if (!info_kn_lock(of->kn))
> +		return -ENOENT;
> +
> +	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
> +		if (!test_bit(mode, resctrl_kmode.kmode_sup))
> +			continue;
> +
> +		active = resctrl_kmode.kmode_cur == mode;
> +
> +		seq_printf(seq, active ? "[%s" : "%s", resctrl_kmode_str[mode]);
> +
> +		if (mode == RESCTRL_GLOBAL_ENABLE_PER_CPU) {
> +			ctrl_grp = "";
> +			mon_grp = "";
> +			if (active) {
> +				if (resctrl_kmode.rdtgrp)
> +					resctrl_kmode_group_path(resctrl_kmode.rdtgrp,
> +								 &ctrl_grp, &mon_grp);
> +				else
> +					pr_warn("%s active without a resource group\n",
> +						resctrl_kmode_str[mode]);
> +			}
> +
> +			sep = ':';
> +			if (resctrl_arch_alloc_capable()) {
> +				seq_printf(seq, "%cctrl=%s", sep,
> +					   resctrl_kmode_state_str(resctrl_kmode.ctrl));
> +				sep = ';';
> +			}
> +			if (resctrl_arch_mon_capable()) {
> +				seq_printf(seq, "%cmon=%s", sep,
> +					   resctrl_kmode_state_str(resctrl_kmode.mon));
> +				sep = ';';
> +			}
> +			seq_printf(seq, "%cgroup=%s/%s/", sep, ctrl_grp, mon_grp);

Looks like this will print a monitoring group on a system that does not support
monitoring? I understand that the monitoring group will be the empty string in this
scenario but in resctrl that has meaning of "default monitoring group" so printing
this when monitoring is not supported is unexpected.

I also do not expect the monitoring group to be displayed if "mon=inherit" since
that presents a contradiction with stating that "monitoring group is inherited"
while printing a monitoring group.

> +		}
> +
> +		seq_puts(seq, active ? "]\n" : "\n");
> +	}
> +
> +	info_kn_unlock(of->kn);
> +
> +	return 0;
> +}
> +
>  void *rdt_kn_parent_priv(struct kernfs_node *kn)
>  {
>  	/*
> @@ -1978,6 +2071,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdt_last_cmd_status_show,
>  		.fflags		= RFTYPE_TOP_INFO,
>  	},
> +	{
> +		.name		= "kernel_mode",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_kernel_mode_show,
> +		.fflags		= RFTYPE_TOP_INFO,
> +	},
>  	{
>  		.name		= "mbm_assign_on_mkdir",
>  		.mode		= 0644,

Reinette
