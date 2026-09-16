Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F853E0B;
	Wed, 16 Sep 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517582; cv=fail; b=ZaPg+BoR/xOEBIsnPrgAMRosz5iD/PPtv8DoisPo/VKqZOgz9m0HeSDpsELmlbPQqEkaqlpzCDlqa0fKZK7ypbv5r7+mUhtdJqAOjuWdFDr7Iv9dldx2RBgxjNauGBVwIi/lDd020cCB9cBASPdkV6gYimeodmsH81jZ+wU+MZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517582; c=relaxed/simple;
	bh=QPO5NEx0cfdEWv/8nm2swEnSLDrPD9XN9rYbWdf/ER8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBKNpfRpJ8r5cWvT7acsaewvisEQnYgGRuqwlSi1BKnQz7WlGUOFecFJK04VBz63ofGXpdRb28IacTw9WUvOQ/qKfIQSX9x39wDAwW/CMpGwyOv1xjebf95+sptFJHDn4k29vCsApKZMqxAdPCZMOzfGBdjKSz29nJ5WerM+sY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQK85fgb; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQK85fgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789517581; x=1821053581;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QPO5NEx0cfdEWv/8nm2swEnSLDrPD9XN9rYbWdf/ER8=;
  b=eQK85fgboOCkhvoLtNuT/Y2GoB/Bi0TRLtxaMXfCt03eDd2w4pgHTQ94
   7FFp68/EQIUNjJ4FH8tfpEMXrco8z0VMgkuGyMhwUFbBZtFAySSr16vjB
   nKwmF+XCAXNMHFxDE3Rh3hrUQRTG9JMxbijetunxnKCSaz9U55FcxaaA7
   Phj+S4Lu/gPxkitAMjtUYGBIWU89KrLKBD6y7blcT3XTaJccLRuulBzHR
   uX27YhbiAStCd6vp7mQcuD1+cwQrfxZiXN18MDvfEZllzma/7d8gwKOcH
   RxZo3upPoHcxBs/tEAViXtfzh3MP9NIZyOHBlMNkhOlMFrkw0u1x1hfHQ
   g==;
X-CSE-ConnectionGUID: obKDnVWPRuGRp0W0JBRIzQ==
X-CSE-MsgGUID: ZPUpJqIKTnaWfmwIW+seVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89909828"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89909828"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:13:00 -0700
X-CSE-ConnectionGUID: CJ2ST30gTayI9sgJnYlT7g==
X-CSE-MsgGUID: 0muZ9b/4TVCgpwrJnr+fIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="266956314"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:13:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:12:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:12:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WG5ODR83fQKJ/S/o1Gd8Weq4LUr8RL6k44IObr9twpxyjmv0EQ8Wpf1511cMmG//nPZd5gPfxkwr2dQgMQBU2AIi/uU3kZmK5aWtxe2dgl+crQbbeN2uzDq4dLhs303F++AsP3KSLqteFC9F4SYD0Zg3Ys2zkk2QGL2U1e+ztfSdisIDrjCMuhsMms+6k7SEhvMfX9RHvQPdaV0ATVnnBNQv6MeSOR7rAzSNHnIqQJH9o+nS760bBHlaIOeE47pqhImm5o2yNbaddaDdm84U6fYWgljHrVhh6Q+kCTpW1xXEvuAB8cBxIs1QvhUdmI79Od8SJBNzPGVeSTcsp7vkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obNWjsLYIMM5NTTMlo/G9Ev4sMVINgD2f4RLaOFmqmM=;
 b=YBxjCC0vN/+AC3fmhKW3qahtw5eMSw9QulAu0ocomz0cnIc68a0rLXbGQd4jz2DZkN7uE3HvALBjUxVNN/LFCoed3ND7wT5xB12NDuHixvRVS7Y6OStdLTPFBmZhVWjguyngwKy6ak37ZNzO7AswGs+2hgFpePUcJv2EcRFT2NIgjXuY5R39U/PLn3h1CJu6TvyP3H4cqPif67EknARWNewQIoHg31NPYQPW8zibhYFVZEao7582psf+IoNIc9PY/7YDFgOUelBl2AUJBhMsiOayZvm2qOykF5GTMzzpwBx2WWBEbGsKzjRpSWRacQoSuZ3lDp7go63mDxj5anFaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by DS4PPF900531A26.namprd11.prod.outlook.com (2603:10b6:f:fc02::3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 00:12:48 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 00:12:48 +0000
Message-ID: <f4fdef08-fdf0-4af8-bf59-07c48625b282@intel.com>
Date: Tue, 15 Sep 2026 17:12:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Binbin Wu
	<binbin.wu@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Kishen Maloor
	<kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
 <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
 <c5076e4a-0335-4ed1-8049-a3ddf486ea03@intel.com>
 <aqlQgQgnLDf2CHqx@google.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <aqlQgQgnLDf2CHqx@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|DS4PPF900531A26:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bfda2c-07c1-4a34-ae31-08df13873d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|4143699003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Mr41T7pHSwGg6N9uzTj/ZeP1KdtdsdDj3U6AuaMESKwpEyRjaY43oFALx9DUA7zb0rt/VWqXef8y9xXPn/RdqxOoGWXKV7fbuXROd9vM+mDITfeG8onkP4U/InnKL2hygnC1dOsIq/SsfQ0R1zoGgoJ1o5LiUUkdjn/vIODOqZNA9bOOMxS7e4nH8zWoiCZZPaYXrL77Vhye+orQVsnsfXm4tCX+7Y7psxcezSLqJgfwAYKtLeoL4p3al7L1U48av1F2P/za3M5DgFec1k8tCT6nIZg2M7SX2WK0vBLQjGlC4RT48llG4CTZXLoBC+6KPpfCHC956l9qadxJwJyq3CUAotipLkS+HN3Qonn2EP/Zx1hGoZVmv5nkKDNMF3XXfbHreod2iwuMr6q+0hPOAsmNG0BdQeUXBRqIdQBWvpBcpuw5+blFmeg91txNWMF3zK1/Pk6HUIOFSZZeT/sLLDcEUeMMXeehiaf3wQqUtF/XklI0m15Y4Defqp92irDqDdog0FNq5lMSDacs6K0CvaZABZACyo8fKYqXrGCHwIpsofnT49DsL0pIlFEE+S1wVYgK2rmzM8Wmby479JezX1/nfZAKCePcAqhS300fpFufvxOl1p3I4NdIphf4iROGIbRJg2wVg+gf7HlO7fL915xgIK/+EFX68tz+9NTH3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NHcGh2dHhhL1VwSVlPQlVvcElRdWdobXhNNU4xTjZOQ0hicUg2amI5S0ZE?=
 =?utf-8?B?VlJTRUhGR1luTUJWNkhiek55Tis3cmowV3FxMHVVRklIMTVaYjR1MTI5ekt5?=
 =?utf-8?B?NmkxNGl6d1dnK3FIRGR3eFdYczdLaW5yVERoZVVmUnZiWThoWWVCNWhTenoy?=
 =?utf-8?B?U013RndWUklUazdYbXduWGtlUUpDOGUrMkZUblN2TWJHOEk2NDF5NytsRWM1?=
 =?utf-8?B?bEZhUnkzWGJWbXZxZXFoQ2tjUStYQTI1TkRiNkVnbllqYkhVeWhzR1lyODNv?=
 =?utf-8?B?dVFNM3hVL1UrenJRZ3RkUk1ZYndTTmY2SXAvK0lsZVRWMk5YZFBBK2VSSHBS?=
 =?utf-8?B?RlB5QUhRVEhEQUFDaFY4TEt5Ukg2dnYyNWhqM2J0TW1HNG9VaTJ5ckZNcWlU?=
 =?utf-8?B?bVBuMWhMM1FISGMvL1p4a1RhZE5LcE4zSVVoUTltdEdTZGJ2T0FWdFZzTHVL?=
 =?utf-8?B?TnRtUS9GaWcyOGl5UlBDM1QxMnY5Qmg2ZzlSbks0aDFWRXZnV1owelova0xL?=
 =?utf-8?B?bTBxc0pEbjBacEhoWWFoK01INGd5eENLSGZac3c4eldPVE92bXlybitmVVgv?=
 =?utf-8?B?bUJQVlI5UlZaOEo0blVVeEVRZFNaSWQ2TzRtNW1nSmxoM0RwbXcwNFgwRjFM?=
 =?utf-8?B?UFc1dHd0dHYzeTlBeFUxUEV1WmVNYy9leXMvUit4enhzeUxXdlJYZ1VtWnRu?=
 =?utf-8?B?cXhaK0s2dUZmbGNwUzNOWXFLSXVGWXgyUTByekJSTmtvb2dIZXlCcGdHWVc4?=
 =?utf-8?B?OFc0MmRyNHNvUkJXSXhVQi85U3ZhWkY0YVRlbWhpanB4eEhaaXM0R25NTEZ0?=
 =?utf-8?B?SmQ4dnhGNUpPQUN1SVpFeWJ6dUdadXV1QThVd3ljMERpbGpISWllT1ZEZXdv?=
 =?utf-8?B?a0JvamJNSHQ4MEJHWi9KM0s5Q3Z4YkNaWFJ0MjNET2hNcE1HazM2V1VnYzdO?=
 =?utf-8?B?YXhBciszUHlGeVNhelNtZzhRa1pORnVSSHZwMGkrd253S3lIckVOZ1BWdGVG?=
 =?utf-8?B?OElOS0htKzBCRFpSMFhTMjZFMXQyc2JXSzl1dHEySzJ3UVQ3VUYvNGRHeUtG?=
 =?utf-8?B?aXVTbzMrbWhEZXBUb1VJc3hmNXVWK1IydVpYSmlZakRFZEtqbnFaV0F2RVJ2?=
 =?utf-8?B?dmc0Z3F4blJweDJYSVBPRmtKWmcweldmWXlsMEF2N1ZqOHFRVDdWRHV4QlFp?=
 =?utf-8?B?VGd5Wno5Z3lZTlRUc2MyV3pycHZXSUhlVEcxRFB5OHhSMmk5aFlORXFzZUlo?=
 =?utf-8?B?cXJTb1JDbjFZTzJpbm11Qlp1SENXdFlPU1hLeGVmTkVXazZSZkhKS2VZM1NY?=
 =?utf-8?B?TDNOay8xcVN5RHNrK2plbVhtZGFMa1lzQzM1YlZhaXYrYWJVQUxoR3dkNXY0?=
 =?utf-8?B?bkQrSUFTSkE2OHNzYU9wUktwZ3hCZ1pMcEcyNlVvWkpCamtDWXZqWDArcytM?=
 =?utf-8?B?NDdTSGsrQ0RzU01DLy93cndzdkorODlnTjd5U2c5cHBTVCs0ZUV5aHlyMFhG?=
 =?utf-8?B?QVpxTVBJdHVaNk44WGIyaGthZmNFRmFzUlJ6bWlGZEdvaU5MMk5yOXA0cG8x?=
 =?utf-8?B?amVBN1hxdEhLME9TZitLQktQelhJbkFDQjZuMzlzTmNuWkRvemhndlFRNlFY?=
 =?utf-8?B?aFF0SG41T09DQzk4U0dQRnRxbGhHOVQ0dXlEOHBSd2NvS2t3ZytaMmhuQnNC?=
 =?utf-8?B?bFRJNXU2VWQyK0dlTVdXTGhXMGVyM1RhQW94MXY4MzlBYml5WGxUaXJ3QkhC?=
 =?utf-8?B?OEFka2dpY1JmK1JpTW44NEU2cGQ0eFozWndWa1pwSFY2VnZrY05zZVM2VU81?=
 =?utf-8?B?TElHd2lLN3lpVmlidlIrcEJWcW5OckRhUmp4MWJiRzJFOEJpaVRJYjI2Yi81?=
 =?utf-8?B?dzZ5VmtXcUcxNHRScy83UHhFYWQ1NkhDSGFvaXllMDZJNnBDNEQ4Q0tRN3dh?=
 =?utf-8?B?S0pJcUFnczNKaVBvazVUOWJHYlhDZ0tOV3hSOXhHMjlOL2FTUjRGTG91WjQx?=
 =?utf-8?B?T05qVGxtN1JmNmZEQkhlajdUaHkyWmg5YW9CTHR5OWtDMXhwRDZzdzBNTlln?=
 =?utf-8?B?ckVGbkpYcEVYYmRjNWs0RUF6Y1BHaklFYUNzUXNmOEJOZFlSeGs2c09aT0Rh?=
 =?utf-8?B?ckMxWGxMZnlmSjNxTGZqUVd2d0hOcVBxQi9RYmg1M3JzdXBMWWhyVEhmbnd1?=
 =?utf-8?B?UDJId1Y1VWkyT2JmcUNhbGN1empNZHloZ3BBekVyWGd2eUY3ams5UmFkMEVn?=
 =?utf-8?B?TzJSNFV5NnN0NGR6ZkIyQVZPbHgrZHBWdTlYTDErNVdka0hTUzA5Mm5xckow?=
 =?utf-8?B?NDRPQTdJcW9xazlpaUd6cFF0UXRaZWl5YUwvTDF6OTN2OFJVcDF1UT09?=
X-Exchange-RoutingPolicyChecked: hcHHoDLbwnykuFIjJJ5TlHWOEFtQeVFWheB1z/5scelo7lo9jqg3L4/BoOK5J3jxK/BG5c/31DpyZ+ZYJElKjw8veRBKpwcGgNL+duxtBU/W7TrYeCyK2qkfRfNLDAWk4UXx5Bz9IZSGxqLb/af+9fZGhgsmENhyLyWaT2KA/61F65k6PCeOB37qXYJpwRLS4osQZL0C025V8YVg3Ryt6mrTisTGYcYdU5lXY5IQEolSgRLDZ2s6a1yYDcsh9SRLSqMjKas+f5gX51h7w/dCEaZ1Kf4T2hYp+GgptaZAvqYXT3JaX5ozJNrZ0TNaAx1/RgzF4sl71uR7jvMPY7KHhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bfda2c-07c1-4a34-ae31-08df13873d66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:12:48.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzOOThBrCOsv53L/pfzuPYrrv1ALH05ThpBiZh/hVFBDwrrcTzMguxGbed93c0ynsfNASPl8xAN5S1Oo2LG3MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF900531A26
X-OriginatorOrg: intel.com

On 9/15/2026 7:04 AM, Sean Christopherson wrote:
> That said, I love Sohil's idea of adding a function comment.  Someting along the
> lines of "The basic flow is this: <example>, but the actual behavior is far more
> subtle due to many exceptions and edge cases".

Great, how about this?


> /*
>  * Check if an access violates LASS purely based on bit 63 of the linear address
>  * and whether the access targets the "wrong" half of the address space. The
>  * basic flow is straightforward:
>  *
>  *	if (exempt from LASS)
>  *		no violation;
>  *	else if (user access)
>  *		violation when address is in the supervisor half;
>  *	else
>  *		violation when address is in the user half;
>  *
>  * but the actual behavior is far more subtle due to the many exceptions and
>  * edge cases. For example, the implementation depends on which accesses are
>  * exempt, what constitutes a user access, and how supervisor data accesses
>  * differ from instruction fetches.
>  */
> bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
> 			   unsigned int size, unsigned int flags)



Sean, other than this, do you want to see any big change in the series?

The sashiko complains are false-positives. There are a couple of nits to
be addressed, and I need to change Binbin's SoBs into Reviewed-bys.
Otherwise, I think the series (1-5) is getting ready to be picked up.

