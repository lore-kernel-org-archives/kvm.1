Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9A42E00A;
	Thu, 30 Jul 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415142; cv=fail; b=aCs/javHVr9phzyGQj91JYiGmebLcsFoyjA9b55BWalDVl97z989exPIIfb6kn7iUsAtR8uDQ4KoPexPeQ8ClrJw1diqmgnYuzNEzNdes6djZKJGspjfX95qgOp49mf4pWQZ5di3yfpz0CDOVkt4+GV6rEPRecbnkZlo1CBfF68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415142; c=relaxed/simple;
	bh=pKkkOR0685MppIZP+Vmhrj9aCXL+GoG8reC7PJnIxCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PKbu3TKXkjlYsnJJszPkJ96kCgPpYL/n0SQjokX2vtgoShM0CyJzx5VxxB2zW3Rs9jR8X5kvuN5wu0+eRFPrYRDhJgbZFz0RpNq3PMyxrlqEKtuheNvKh7Trb01wlEhCTKzl/2hJk2VfcaFexVAt4kwNfWxAk9StuUGoiqB3jcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8oeLNDw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8oeLNDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785415140; x=1816951140;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pKkkOR0685MppIZP+Vmhrj9aCXL+GoG8reC7PJnIxCc=;
  b=W8oeLNDwnH32c7OmK1AL3Q7FSWysYwqyhn2h4qAwlZZy6S0ssvFmWEzO
   efTfPttLapFsQ74wtPMc7gGoOOuXCbmKWQdlDfObzkczbHFtJjutXF0PL
   78YEuBe3qDUwNDr45iCO9TXVydPC72aJFXFEUDd8Cx5t0x5bSD9zFhdxk
   R81K2zJOImMoTmDAqfjYDqotOryFItpLNSfQlb9LBkBuKlJuEWVmmvibA
   bc19LmmgP8MHpGxYTj9k7rnIyRoA6ZGqTMvNhv3xW5u7Qm7EsqDdrt8Uu
   Anyr6J6gNXtwvK4OfkcmBYGdvRdBQmifiqqJme1H27BXTmlMFbib1/UqI
   Q==;
X-CSE-ConnectionGUID: lcJY8SoFTym+h2CLVrbL4w==
X-CSE-MsgGUID: 82GhVOimRKGHmMh1JOxChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103438346"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103438346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 05:38:59 -0700
X-CSE-ConnectionGUID: 1ToCL/jHTRiqZD0lyOBtkQ==
X-CSE-MsgGUID: rFfxa80cRa2m93NG00mH1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="262236261"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 05:38:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 05:38:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 05:38:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 05:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbLs6oI1DDk2TPnyxbAGoacvR0ZL/nNhOSc0/Zl4huBapiqVi45ZcTcpfojtuFBUeldhikzraRc1vNiADmf1fv5JLyvUBYKe/aQafZFmQQBIJC8PnLvzfdZwJblNVpo4ptV46VkGLFbu4E/MJY7dC7e/re88l7z2BYqdGS83rqZY70OKf6qGYcYo3EhO+pjQV50zwNdjdjY283Ki2h8DpjGeTXmP2cIeoql/UWiIypxWzftl4oI0o0ph7VfeVkSF2dEiSHuADpJmvF5FDgbu3tHH7k2RZm2th7xHx6nT3Ez+Z78TiPfZGxvwZUul35Q/Lr7ufuF3YJmGphx+bQoDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbQsFHiyRQL2HH2sU+Hqg5zQ1BOmniZlKoSVV1NLJ2Y=;
 b=OqJSp2nFMsnM5dsQIzW6kFogofxyhszo2DnUxEqIuHmWEEKxUowmuqRUsbhlGrTWs9c0lYSdGQU022/3M5Yw9I+lmtt+gi9QeDfSWMObOjzn1HtJy3IBGlflEgLlXAUQTMMfKkJvXMs2qD5Ems5UHggrX/mdYXvMMvopQXMJe9Klt8+6BFhEa2OGRCSAkxhbOhAUo1yXHtLOyxTNl4ZhzC+oOOV82CFhM0s5si3dyTu81BFmhIOP73P0jwv0oM8DLApr15Kf7x4mTJNvghdpFPhLE2cPS8TgtUWd0qlCNBEKmYphWCgJIrT/6cEUJrkVqnnDSE/FK8BuMOvVLCr60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 12:38:55 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 12:38:55 +0000
Date: Thu, 30 Jul 2026 20:38:46 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <isaku.yamahata@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
Message-ID: <amtF1vo8WdZU0OBf@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
 <aliWoldWX9/9tqNn@intel.com>
 <amlYsJzUurSeYlTm@intel.com>
 <CALMp9eSKEMotL19H4WxZN5iVfUxnDScpW0TqGLAEGSitG4AAbw@mail.gmail.com>
 <amnPFlSvI3k95uCV@intel.com>
 <CALMp9eSLLm_4K0c0ouRYTpqxGkiBcRShf2NO9JOS9ZP+Ws+H0w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSLLm_4K0c0ouRYTpqxGkiBcRShf2NO9JOS9ZP+Ws+H0w@mail.gmail.com>
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|SA1PR11MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: af42f0ea-73d5-4be0-b40d-08deee37848d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7W/RAyB0hGepZM0T4ktbLtn0NoAdCuJuKUY3y4oRMCoWq1j1ZF2bjnU6GAv1cSrc/ry/nz10szwMUTPf7DdiexVoSg0EfEtmKzGuVyxpEHZsqr0AqIwXFTi3c3UJIexUoym96sy5ZiGIewFyB+MOITsAnbbWXl9ARTGaRY5PqrbO4HPxI+fQhSXPSNlAubnB1nhcXqOCHUs02qbp3OVPuVHwtTk9hbVPUS7hwl2C+N40NbpeXjLYTt3XXemvfR9+zRKjzLg4weCaK5rUt+5ZW9fG+2hA75OeVO4ozli+c28/ERw7uqFIz1f61sw0Z8Ww2Lc1lInSBuYR8GYfnRQxV7E/YZIutgX3QWVZV23pCGkwYQvLgRcTZmsCwm3PrNN5cOhOqjNas6om5pMTo393Os2HiXkqjxzDpGBAvOrBXtx45MhTU9Be1tJUn+IqXiy8guDSphMomZjeuIedZQb48Rf980eKqpPXg4+2JPxWaeX/ZqbsH1A6JdATdvA/+cQyapkicpNmCsTEHbS3ETn8bLHri8nuJaFQWTrsYiLi7Xe524YCCwkbPAUpfu64HKUFwqgJ1FV7Jln/aFkZhGRyOd2ZmSpaBAHGT+Gio6bn9NObyBJni5YZYFl1Qa1aS19g/FJtA2kYIyyPBGWXkPJiqJqU+CQMM3vZXRpHfOjDTq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hBRFlIODVMWEk5TXJSM3MrMmp1Rm9HRk1ETHdJVlRVS3RFZ0tGcDlUblFS?=
 =?utf-8?B?WEJHamNROThhUFNpM3RrMGxLcS9ReDJyL3BVVCtwcURRbnFzMVJWcEpIRG13?=
 =?utf-8?B?N1J6Y1RKN1VVbWpucUh5V0JaTWo4SE1FQ1N6clVWVnR5em5oSlRGYmovd2Jm?=
 =?utf-8?B?c0VKZzdKTVVFNkdrdlJ6eHJCR0FQYlNzQWxGTFkwdktUY1h2QVFzVy83dVZN?=
 =?utf-8?B?NHJWY2tOMzg4K2NoM1N2Y2Jpbmo3WE81Wm0zbW1LWGpjZnBqN0VxK3ZpN045?=
 =?utf-8?B?UW9wMW9OQ2tWNzFaNk1maVYveVBSVXVxYXYxbkw0M2I5U1JBTnlyMUthNkFM?=
 =?utf-8?B?Y3R0UHl5c2ZjaFBUVkt5amduTTJ0M3RKcXJPZUZ6dUsweVZYemdQZ2Fnc25z?=
 =?utf-8?B?WXgyWmorZXNMV1E0RFJwcHdKTVdBc2VWUHNGd0FqTXNRb3NnWnBBekJ5dHNJ?=
 =?utf-8?B?NGt3dTJEVVVMeFYxRERjS010TFVQRElVVzJubGd2L1VIRVdMQ1dWZzZVOElW?=
 =?utf-8?B?em1BNThEOEloaWMwdDdYcDEwU2ZxZkZXSDNTVmJIa3dCa2RnTTQyRTlBTVVm?=
 =?utf-8?B?YUhKWkJrcGorV0dtbEZ6OTIvOWZPKzFZTG5saWxsdmVacG5peDBhVm0xVjI2?=
 =?utf-8?B?ZExObWdGbXk2VFF0Qy91ZEFEUnpLL1craWo5S0duQU5KTkRGbFpYcGVKME15?=
 =?utf-8?B?TE1RNTBHbWNJZWo1dmhEMVhGUEZ0T0l0YVdiRXh3dkdOd09GRDRvREorUFdH?=
 =?utf-8?B?ckFyZnhwaFFrZEFoMmRna3RYanFrYlA1RysxVDJqU3FNVHp5Q3pZMHpsVXJ0?=
 =?utf-8?B?TEV5NllTeHl1SGY0SGY2RGs1bHExZDZpOVBzcHphS1N0ZWhvektTdE1DaU5D?=
 =?utf-8?B?VDJxTlN3TUhoR1o4SjdSYjVnK2NBM1JQcy9qUEVDRWxPUXh5TUt0VkIzdjlk?=
 =?utf-8?B?cjBWWmxXdGMvU1FJQXVRejUrM1VaT0pLU3BnUU1DdVYyOFloKzVwelZPcVp3?=
 =?utf-8?B?WWI0bnpNQTY4MlBBb3Bvays2UXFuQ0dDOFJobjdHODBjaDFqbWNvaXFzUTZu?=
 =?utf-8?B?Rmk1MGdlTGxpaTBnRWhFcGZKZG91U2x5VEw5RWZTOEkzbzh1WW0vN2JQTHhY?=
 =?utf-8?B?WXhzRnVVYmluU05SMnBrZ0JWSmMyaC9jR0FybkdlUndtMzZ2YncxN0dGWGlt?=
 =?utf-8?B?SlN2YkZ5UGlqbURYRm1YUnh2OTlmcU9ocmYwNWIvN3lOeEJPSURDbll5bXRG?=
 =?utf-8?B?OHowY2tFTW0rTWhVL2E3V28wM0ZDR2ZweWF0YjBmNno3V0JKY0N2SFJ2OXRn?=
 =?utf-8?B?T3JCenkrUWQybDlxSFlDQ0gxVi9GM25VOXpWQ0I1RWo1RTczV0dRaGlhR29M?=
 =?utf-8?B?cFRDcUFXcmIyNytjcU93ZlZxbUNkelg1SHM3VW9OZjBWbGg2aXF5VjhOOENt?=
 =?utf-8?B?Z2F6L0NWQVVBb0hKUmtmVzNjTnhsRnlqcU5mdTZuZ1BoUTZkWXR3c1l4NnVN?=
 =?utf-8?B?WUdSbjRUWE1FZjZ1RTBQaVBWMGhNVFZFZkI1ZzJrN3lCNWh6SVJDY2wvYlVJ?=
 =?utf-8?B?QWlUMXdXRi9EMloreU9vZUZldkRVZnlxaktpREJ2SWxuL2pWNUhEbWFrK0dP?=
 =?utf-8?B?WnR6c2UrNDJtSWtxSlEyWXZEdzNFci9Md0gwd2I1SkxWYTdCbDJxQVk0Z243?=
 =?utf-8?B?WWpOVDJDS1pRemVabU1ocWdtQmhoS3hCSTNQdzlyODNqRUFHM1JiYzlnSmUx?=
 =?utf-8?B?bjlNLzlnUnIvOXR0NnZYTHhDcUhsRWxQLzFpTUd5TDJ6YkxsU3o5Rzk5K2Qy?=
 =?utf-8?B?WURJS2hKSnZpMnVFTzRMajlOY2l0M094Tm9ObFpLN1FkMTJneGRSQkIvZDZj?=
 =?utf-8?B?V21sTFAwTVUrbWNmRElIZ1FUWnN0dFlsM25obHVybHord1JBVzNKeGtMOEN5?=
 =?utf-8?B?SFpQQkw0QXRQTHh2OS9VMjd5SUhkUTFwbTRQTTR4UjI2Rm9qbEwxaDBnaGNm?=
 =?utf-8?B?ZXhINFQwQzVJdXFmdmo3aXdxeVg2bDNycTF1WWNMa3U2Wm1uNjdCNWN2azBx?=
 =?utf-8?B?dDdXUTdIekRra3EzYzVCaFFoSzlqN0pLRjlZTVo1ZU04d3FZZjdDNWhSMUZE?=
 =?utf-8?B?Q25jaXhtcDBqS2tQd0l4d0RpbjhvcGltWDVjQ0VlenlZOXMra3AydmJ1Wi93?=
 =?utf-8?B?T3dZdWg1emJ0UmFJVmxOMkZVcnRzeXIyWHN3UEhLdHpubEhsRUtZbHhIVFFY?=
 =?utf-8?B?MTlSRFhnTmM2dDVMR3NmMHpZOXhIRnBVWmRkbmZrQS81RDlIMUhzd1NCdGI1?=
 =?utf-8?B?M3Q0QjJlbm1nZnZQZmlQZW1iQUhxd3U2VFdwZ3YyZkJySGxGZFdPUT09?=
X-Exchange-RoutingPolicyChecked: ceSi9iLgbpnsQzCo83yev+wjhbiU+uz/AYGO+2jeKFKeixqsrDzyZK1tIQlyIg7rLByuOqyhWLwkB47/m8xLSVco2NFoeODgCXMoEmjqiHBSH4Nm3Ks0fAarPJimwAVqj/lb5qp71mqV6D5rDOhxJ+bfrYw8W1zxlsHErTjWi1JEaD1iE4KLoCw5WQ76fgFkx7RKL4sj/Og10lK18AioGKrv7lbqJEDnLMdJ4gURvGqZ/2J5QKFbumh/4V+Ub53OrQ2Cc6678YMNPj7wxzFpsj83pMZCzjrVyQERNf+mn0F/9TX/y+nqhxyIwuOeCdv+dLRSlhV6Jw9vaFpMnab0Tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: af42f0ea-73d5-4be0-b40d-08deee37848d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:38:54.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx7yT+7kvIVRbbidwNmAxV8puTo2JPdmcpEm4fJ5IJoFpa8evPDfivZYqoJ8B8545Y6hckmiSpiihmpc/rGiiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 10:39:11AM -0700, Jim Mattson wrote:
>On Wed, Jul 29, 2026 at 3:00 AM Chao Gao <chao.gao@intel.com> wrote:
>>
>> On Tue, Jul 28, 2026 at 11:05:59PM -0700, Jim Mattson wrote:
>> >On Tue, Jul 28, 2026 at 6:35 PM Chao Gao <chao.gao@intel.com> wrote:
>> >>
>> >> Hi Sean, Jim,
>> >>
>> >> Any thoughts on the approach of reusing hv_timer for APIC timer
>> >> virtualization?
>> >
>> >Last I heard, APIC timer virtualization was only available on E-cores,
>> >with no P-core intercept on the roadmap.
>>
>> It will be available on Coral Rapids as well, so it is relevant for
>> server.
>
>That's welcome news!

Thanks for the feedback!

>
>I'm not a fan of the hv_timer approach. One major difference between
>the VMX preemption timer and the virtual TSC deadline MSR is that the
>VMX preemption timer has to be reprogrammed every time that KVM
>switches from hrtimer to hv_timer.

For the preemption timer value written to the VMCS, yes. But
hv_deadline_tsc (the absolute host TSC deadline, set in vmx_set_hv_timer())
doesn't necessarily need recomputation across hrtimer/hv_timer switches.

If this reprogram/recomputation cost matters, we can optimize the
block/unblock path for the preemption timer to avoid that, and then the
same optimization would apply naturally to APIC timer virtualization.

The idea is: don't call cancel_hv_timer() when switching to hrtimer and
don't call set_hv_timer() when switching back. cancel_hv_timer() can
be deferred to virtual interrupt injection time (alongside setting
tscdeadline to 0, which means disarming the timer architecturally).
I think this works for TSC-deadline and oneshot modes; periodic mode
needs more thought since the timer needs to be re-armed after each expiry.

>The virtual TSC deadline timer
>never needs reprogramming during normal operation.

>Another difference
>is that KVM should never inject a virtual local APIC timer interrupt
>when the virtual TSC deadline timer is in use. Even if the vCPU was
>blocked and the hrtimer fired to wake it up, KVM should just let the
>hardware deliver the virtual interrupt on the next VM-entry.

I agree this is the ideal behavior. But I don't see what's wrong with
KVM delivering the interrupt. 

IMO, letting hardware deliver the interrupt after block would require:

  1. We still need to mark the timer as pending to wake the vCPU from
     block. But to let hardware do the injection on VM-entry, we'd
     then need to consume the pending event without actually injecting
     the interrupt.

  2. Tweaking kvm_wait_lapic_expire(). The deadline was advanced when
     arming the hrtimer, so the vCPU wakes slightly before the actual
     deadline. Currently kvm_wait_lapic_expire() scans vIRR to decide
     whether to busy-wait until the deadline, but if we rely on
     hardware to deliver the interrupt, the vector won't be in vIRR
     and we'd need a different indicator.

Given this, I'd prefer to let KVM inject the interrupt for this specific
"hrtimer fired to wakeup" case — it works correctly as is and avoids the
additional complexity.

>
>I'd rather see TSC deadline timer virtualization implemented as a
>standalone APIC virtualization feature.
