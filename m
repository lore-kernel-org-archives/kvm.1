Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0D3845B7;
	Tue, 21 Apr 2026 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741459; cv=fail; b=nFQBNIi9wXTIJYcswSaS6Nad9ZSxMvpJHKn8a8QObD95BAkT2R3Vz9nPiFksY8uJxELdcDXnlD81Lee3e+odRHJWN/Egn2ptsJBHPm8LchanvwowN3i+32xpJx8+7LgFCMdvvg/VLkjATveiCvNtvwqVzBkR7GFn7Z38BdgUV6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741459; c=relaxed/simple;
	bh=IY2SpDGjFV/HQxENAiojbkIAv0Rz/HRJFbNjgs6Kis0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HEfmPpQZgRVa6xaDHQjR1rP/O98lNrTSSRuHQ/X+5pg1dus8v9St3u/2boBbUNbMkFLI9tp4f4wkCRrzk1bO6O4ywMUjVfuIA4M29WvcJIgymKBTPd+zu0uknT90dfvctskc4hNRb8yYgoM4QnBNY9nC1OeDf6peoK17qGfwUjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8cgiDnZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8cgiDnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776741457; x=1808277457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IY2SpDGjFV/HQxENAiojbkIAv0Rz/HRJFbNjgs6Kis0=;
  b=g8cgiDnZ2CBQYbQ+pQ3orQer/77csRP7vqKZUKiwPx2m6WL/g/c3Yib5
   FF8arO95YAh1g27ixf89zxZiyLbGG1L34ObeeBB3MMQkgwiDEPliuX5IH
   V5c9b90HnVSUs/iRwCK0d3WGBoFBzuhZUCysLvnPyRmPOBdtLNt4ynk9R
   OzlVm9mzBuVMPGIwK+EcZsl8FE40VEsk+U9VMFv6NRN6hQ0k7tN31f6dJ
   IuBj+whvlFyj2hJBCQxMRDjSe8b5O8fKrFr060hikLgmLigfk7ARLN8eg
   u4mnYE6vFfhXCNeMTL1ZeyDjHAh4NkYmiFQhCwKat/nqcxNA4T/kOToL8
   A==;
X-CSE-ConnectionGUID: TdD3N/MRRvCOImRCT9AJ9g==
X-CSE-MsgGUID: OaTVJA+yROe3fkY1JeVzpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95225214"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="95225214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 20:17:36 -0700
X-CSE-ConnectionGUID: X34ONPPIS8aiB9KaZ2cTKg==
X-CSE-MsgGUID: juHqjvIzTCa3crGLnxdmzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="229231944"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 20:17:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 20:17:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 20:17:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 20:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3XPU5IYOGZDFx2drZUO1pVikhkCcnvT7eQ0n0jwhVesyo9cC9VfH9jbnhZqZAtFEY9BIy0I2Wf/rbfKqYMgagPjm6sHLcQUQCFyDxHlSy/p0ybWGB6KbmQ54lPtD2lVDyU99UrKwTiHO/QfaC4wmskmvC6lUC2ZYZcHi0dqPp9ljiPwVvfaKYzICZoEMUPw7oRvlTGzl8ksSeX5U//hLzBjSbkPSzBU0SGxaeujXrBlqj90MEGDjYMpyjCDDvaOxByet2Ucbyto9zTwm0Var4JrbEjzsA9yBlTCx1er2+sD68W249hM0SV4HLE+lFwXhX7tVP9yoDb1ArYdxt7VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyA2VDSydsp8ewxOqjwRjvJstA24zXRxFWjadPYB9XU=;
 b=Xu89NxrSOs9UB/OxaGjCdK9XWAqL7Sp+Z2QBuLEkErDnaEF+RRSLgk3mwoyvDvErs2h+EmyndHHaSJVrzdQ602kmUzpjMt+BETql6/gIxNkd77GLbEFnOm9XCzDyEgQeMou7F8b1VCbgw4rJNEZFpg/d++jzTj5HCqjHKKR/geoRhFFx9tBTrQnlcRyR/k0IqsIg5eYKOGIw1PWd2XHY6iDefgdOAEgI9UZX26ilJuIloAASG5NoCNs5MIiDOSwBUPyyQsz6KfxmR5AtjDTxtqERj8XGRgjuHk8SOYHLeZo2MA9sWbkfCqEbL07gc3z5x8W405FmpoCwDeMnCSdehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA3PR11MB9062.namprd11.prod.outlook.com (2603:10b6:208:577::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 03:17:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 03:17:24 +0000
Message-ID: <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
Date: Mon, 20 Apr 2026 20:17:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA3PR11MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 162f7a74-0aaf-425b-b114-08de9f5481dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v7EKY4FAchGKlg7H0Zwz2hqvdXOmts8uhn3jfsvA5lPnCQ3HgXoXHsFXwHEUC2P0M0dtz2Qw278pZaeZ4WaIuwdbhx0gIzSQiL31yWk1IiKrXTFqzeJDCWCyaNy+qQh7wyDSnIoyg4s08q45Vk3cWui700gg9hcDOgNCDUgPvp0njvjpw+ECGC/KuEfiVV2XJnrsxLcOoWCekeXvYApq9oxW7wdP7rcMyVNxMhW26eIQURtgD+kYZ64YngMhBlHvYxdm8doVo8zEaAc2LZLrIkYtFpezOzrALZ6A6fve8vJULgMIOvPCL/zwn0JDFsihc0DOQ4EouUcRFP3OEfJUio7/HMC2YJNLZ8F1s1WQqyAsbcjr+9+y+j/ORQjN65PAuIg02JRYPvLAEZ1UHbmkOUDDFEh4N4yvbNWAc4iG+aYPKhlWQaqRQqbiTUt1DDIToTEp5/ZoKQyjoHNw4rFtkAcX8upDMmbgXIDKgq2MHOl86qh1IjVNWBeV9HV6vGqIjWddNRKA2TLjZI4z9dQLRsPai972iOTATyAYRQebJbgCQYOR2TyGFxnltlYRv52sMGT/JATDh/gTP5VoUsYYwgGIXBovCTiezjo1gWnffdEqy08tVSJ2bkhdWKJDn5aySiOeELTswD/CJ6oUwo0XHz5yYgrqc29EBL6+ZErELanM+SqKOam146qT/9KLvi5e8XE1mENa80CNBFaIN+aaNs9n6hA6aEOkbYoNiCo7+jqzztZ28SLG/nipHA9dwCjH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpCbmNVekNNbkxGZjdXQlFwdlJxMWl4NVNlMklvbjJTMElkdXYxOFNna2x3?=
 =?utf-8?B?Yi9OZ0NIREovYXVIVkdmazhHUTh6YVhLcCtuUVhKMTNlQVdEcVh6blVubHhp?=
 =?utf-8?B?V0haOVFxR3IvWGNzNVI3RHpyMGQ3VUFZaGNtaDgrRk9KTU1hUENmci9rVyt4?=
 =?utf-8?B?Zy9iQTNlRzFSVmRVZzdOS3pCdzZNNDJqVmZQaG9nNkUvSkZsV0VSUDYvV2c5?=
 =?utf-8?B?aDlOOUIxdkpaN2hMZHZlQUtQQlhTSFlrdUxzSHhtc2ROVHVGaDlIdk12RVlS?=
 =?utf-8?B?RUoraitnaVdoY045dVk4bE41NEZlTE40MFlCSGVVR1NjQW0zQlFuVDlYOVlL?=
 =?utf-8?B?NDlKUnpBMVkvaUZnU2JvVHQrb2g5aklidGQ5M3ozZ3VWNkczS0tIRVdpZXk5?=
 =?utf-8?B?c0NvN3NHSE5qNDVXT3QwY3lUTTd2NDlqOXJPVDAxQ1o2T3psSlE4cWJVNmlH?=
 =?utf-8?B?aHR6TTF2bnIvWVJqTk8vYTZwTEFLZi9rV21aOEMrWVdQZG1QbW1uOTBNNno2?=
 =?utf-8?B?dE4xYVdFSGlmWTBURW51VkJGVVc5S1dYY0EyWTlBaGxlMm9TYTJJbitWZnhi?=
 =?utf-8?B?czJBOXVCTlU1dUh3UU1DUzN3UWRkcFZZUHhHU3haN1I1NE14MjlwQ3hveVlK?=
 =?utf-8?B?akxXU0RabStLc0tacVVBWVJBVmVLZW1LYytnVmZPbWlvd0w0QVBZYUt0Vlc2?=
 =?utf-8?B?ZGtUWU1YVmtQTmtiazUyOXNGWVo1K1F0TVY0bzhRM2M1Zkw5VDRRWUJ2YmNm?=
 =?utf-8?B?SmhEYTFvRlFkZmQ1TkpwRmp5NlNkWStKeTJ6M3dGb29vb2VlODErV29KUDRO?=
 =?utf-8?B?a0VCei9vQ1VLRGRNVUdGR2VJV1lyeDRXNlE1Z2N1SjI0aDVnM2Z3cG1nN0Z4?=
 =?utf-8?B?R05VZXBNUEpYbHNJOGxOQTNwdmVyTVVOWXFCWGlSbktpbHFzTWJyYXlvZEFv?=
 =?utf-8?B?YitwRmRkSUVtY1N6K3pPZVJFQitERG1oSDNkeUtET05pN2tDT2t5bnlXZDAv?=
 =?utf-8?B?VGo3bUFFa1dqTXByR3lYOEI3aGxnRUFsNHUzb3g5YlFRTjdMcVYzeEdqNjBC?=
 =?utf-8?B?Q29WY2s2MlA4djY3Mmk3bFJrcStHc1dPcjNDUXFIenVlaEV1YnhBQjR4OElW?=
 =?utf-8?B?b3diRzk5cVpZVy8zS3JCRllHRHNkK2lCcnloRzFVTUlXbWYxdStKdEZvTGVp?=
 =?utf-8?B?blBjc0NZVEVyMHR4cUh0SEdzQTAxYVRKb3VPLzUxVENNaXN3dFdCSFc4Vm1K?=
 =?utf-8?B?ajUya2pOSHBCbVNBeEdNeVNlN1N3c3NTcmF4b3FNSWFnRmU1ci9ZM2NaUGJN?=
 =?utf-8?B?dXk0L1FUVkZDMGdweHY0ajg4bDVtaHlEYVFIdzJmNXFWSE1lNmE5OFpVUU8v?=
 =?utf-8?B?djJYUUVvdkRibmx1bko4eXI1dytWR2NJWEp4djVhMDFaSm1wV3VadHBVcElp?=
 =?utf-8?B?WS9uMXBQS2Q5cnZBNndQQk5lSFJ4MFNDTnNNcHp4eUxPRmtpMjE1dEFsYlYy?=
 =?utf-8?B?VUFnMkhmQWlXS3BqM1pySkhNRnNYNGNRYmU0ck05ZFd3N3VKZE9EdFEvZzMz?=
 =?utf-8?B?dXFWVHM0UWk5NXRnR2E4TUw3U0pxUzcrbzF2YlM3QnpWTHBqaWk1MmdlSXBN?=
 =?utf-8?B?b0N6Ymc5QUxha0grTy9LV1Roa0x2RG80SFA0c0UvN0RpWkYyMmplRVdaemRT?=
 =?utf-8?B?UWZpS0VZai91RmJzMHRrUWxvQ1dJQVJKMDdtcVd6djFDMkJSVEVOWFJJOThL?=
 =?utf-8?B?QU5UZ2tCai83UUNHV2s4aVV3Ui84NU9wRld5OWtDcTVoTHlSL1loQVZGOWdx?=
 =?utf-8?B?WXZCUjRkS3RtSVRCRlMzcTJWSWtWUVg4MFpyNGxncDlyNTg5d21xVGsrcXJ6?=
 =?utf-8?B?SktQY1JwUFNmRTZSemJwZGxodUZtdzkzZnY2cW9lcXBHNWo5K3JjVUhvQ3li?=
 =?utf-8?B?VEdQQzQ4R2xsTnNjUHVSbFVFWGJpd2gvSFN3Qk9SY1psR3Y0cHdhY1RDcDVx?=
 =?utf-8?B?SFZwV3JxSzRaNHR3TUFFeUlBZ1V2ZE9ndHgvUi9hNk1kZzBzT1Mzc3gxR01P?=
 =?utf-8?B?c2ZoS24vM0M1b0xJV1c3VEEzU2lQdDJXYy9oanUraUFZZ1dYejRnVmZXb0pH?=
 =?utf-8?B?Y0NCaC9GZG1SVlJvdEw5YXFSZ1ExWXJDQnVaR013WUdrUW5KdlJ0ZFB3OGJ1?=
 =?utf-8?B?K2syNG53c3BFZ0VBYnFGdWxySTMvN3Ezb3I5YU1aeXlCdDBJQVVYeGJlUlkx?=
 =?utf-8?B?NHQ1VFNHVXhoWS9kQTFKWnhTWC9qcnpiRUxZRUdQZkNTUzNVT3MzN2hJR1Bj?=
 =?utf-8?B?VndmYnRqRndjNXV0MGVJRUpYb1dFcHpFd2JZd2NBRjgzNkkyT3c1VzJKbFlG?=
 =?utf-8?Q?reaCuUTR6OT9dvdk=3D?=
X-Exchange-RoutingPolicyChecked: Ygl9BEo0A0spPweXQ9sipOuDeqVbEdGe7kHyUPou3xaHGKE+TIHFTsIEOvN4XP5riWbc56hcPmWhRmH3nGnI457ziOJKcxCzn7+XrVkmwzAWzA+DM80N57Gus9poD7BzX54RBi0+2CmHF2g/bygM6+E02OVeAZYteb3kRpKsHFUxERsyIbSW8mSuBpXlZlvi02Z+fvLwUUPX8KNsEHyGoOCCzCFRk9sX3mGJk+oO14wD7zFBLOWtqLrS2dvF+STXz+icgFof4NnsaPnpp27XdlHP0dG6tHMMWb9oFRWj5jeJPjW4j6+6G/4e1QjvBQpgV6meG28FbnqpbexKA3k2Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 162f7a74-0aaf-425b-b114-08de9f5481dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:17:23.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXwGeT7WSTY42GeqR0+7eo6r3KEvQ3/ZFEA7zWFydu7mKPgQvA4Cqf8+rwqTOc136kWBVlncBrhHWtV/ZRn/bxt35fM5gA++cMp2oPxVdFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9062
X-OriginatorOrg: intel.com

Hi Babu,

On 4/20/26 5:40 PM, Moger, Babu wrote:
> 
> We already discussed moving back to the default group on every mode
> switch. Doing so here would once again cause extra MSR writes on
> each mode transition, which is undesirable.
> 

Needing to avoid extra MSR writes in resctrl is not so absolute. Consider, for
example, how resctrl initializes default allocations when a new resource group is
created. resctrl aims to initialize with sane defaults and the user is expected to
follow with desired allocations.

I am not against optimizing, I just want to be careful with such general statements.

Considering your proposal in https://lore.kernel.org/lkml/39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com/:

I do not think we should make info/kernel_mode read-only. If I understand correctly
doing so would accommodate AMD PLZA but it ignores the discussions on how resctrl could
support MPAM ... or do you perhaps have proposal on how MPAM can be supported when considering
your proposal? Even if you do not want to consider MPAM - what if the PLZA_PQR register's
scope becomes per-CPU in the next version of AMD PLZA?

The idea behind info/kernel_mode is that the active mode it identifies indicates which
configuration files exist to configure the active mode. Since the mode may not always
depend on global configuration, for which info/kernel_mode_assignment was created, but instead
rely on per-resource group files, I do not see how resctrl can build on a read-only
info/kernel_mode backed by a mode and group change via info/kernel_mode_assignment.
Specifically, MPAM support may not use info/kernel_mode_assignment at all.
Instead, MPAM may use something like described in https://lore.kernel.org/lkml/aYyxAPdTFejzsE42@e134344.arm.com/

Could we perhaps consider dropping info/kernel_mode_assignment entirely for
AMD PLZA's global allocations? Similar to what you suggest, the mode and
group assignment could be done via the info/kernel_mode file instead?

Thinking about this more since the CPUs allocation is global, these could *theoretically*
be included also (but see later).
This could mean that "kernel_mode_cpus" and "kernel_mode_cpus_list" could be dropped?
Although, this may complicate the interface since user space may want a convenient way
to modify just CPUs independently from needing to repeat the mode and group every time.

Consider, for example:

# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/;cpus_list=5-8" > info/kernel_mode

Having named fields (a) makes this extensible, (b) output does not need to be split among files,
and (c) "inherit_ctrl_and_mon" can continue to be supported.

The named fields could be made optional, if group is omitted then it will become the
default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
This may not be intuitive since a user may expect that not mentioning a field means
that the field is left untouched. Have you considered this scenario in your proposal?

As an alternative the group could be made a required field and "kernel_mode_cpus"/"kernel_mode_cpuslist"
can stay? This may be the simplest approach.

Output could still use [] to indicate the active mode that includes its properties.
I find to be more intuitive interface where output more closely matches input.

Reinette
