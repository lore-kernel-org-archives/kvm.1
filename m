Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734531327D;
	Mon, 20 Apr 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728111; cv=fail; b=Omh9AbSV7lX2CpZW+ZuQgLHxpY5e9K8T6B+IXS3srG5yFkXVmOj41UMMV0bRvpfBo3rvzc84uoh/6fCxqNM1S26uLjxzFcqz+JiYXhOiFXxuhxlfDMOrzBiX2icDyxJI8j++BukEqAxnbuQeOGZrsxWk8BslU7ybsR9dO/3SArI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728111; c=relaxed/simple;
	bh=twJiCUzRRUmZUXod4n+8SOV8xcNvTvTZ1syY57usY9c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RjEaCnn2OBp24CPaoAGr0NGBZ5YQhoNQIbVt9O/5fL6vK2/JJfNVBVWZDR/hst/oo0RqNNWj/XiFo+AeaYyTdqsx8fuKr15T6cPXjYurpUlor7xiCSwdHm2dqCQTogvLyqQkP+S+k+uCbvFcJ9cgN0ANfYOLnNbtshqW4VWRapg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUQgFsTY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUQgFsTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776728110; x=1808264110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=twJiCUzRRUmZUXod4n+8SOV8xcNvTvTZ1syY57usY9c=;
  b=GUQgFsTY3HezV/WcGFy5UumiqIf5gMeAWKIO4+ME9VHvDW3ujSubgrBv
   qB61jYERl93ZfAKtO2O1Zn7GNS00MmogEJ1w42OBXPxAGhl80rf5k6Zhy
   BAKVJRSKpXu1tnH9oWazDePU7k1vxaNNshDkSBU9ylTsPjLR4LtV9lRk+
   7TanPP5Ir/Wvy/k/elLAN5R3e8YVv5h6AZTqIhm0spU+qIlO1Hxt4Gk7L
   V162p/CLjTtERkyFdKTSBq06LSPU6oWM8hxaCq7cscy2eC/Q+6sPCgCK+
   sK3SwxR5TRctMh3pw6cm+G8W0ZokFqYOqwAZBh5NG2H1iYV5aRTeAXKKp
   w==;
X-CSE-ConnectionGUID: OMBoFMB+ScS/x5oRy3juAw==
X-CSE-MsgGUID: 2Dmzaa2CQaKxEAFzo7GF9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89123528"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="89123528"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 16:34:25 -0700
X-CSE-ConnectionGUID: JK32nRetTn268VnXk0ludQ==
X-CSE-MsgGUID: CEiPnAMxS86jY9EmoZxP7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="230988172"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 16:34:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:34:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 16:34:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIRfH6O99ZhURJ0f7e15aMSUWrJTYKtNbzW7tB/zxLoYYVL1rWwm9VVcEjRLaYo3mMjexz+6l0IEXHtyIvGg7auYdCt+Y49vSK3f7lZu38hyK2QYxhVkVVw7mc/+iGKi0T6tLXAz+rZIcDHF/z2/JSCaceuLB6URAb+WjViIlzt2ML+4twQwDdPi7ZZD1QWNjhPah8/N+oUP+BkAFIFr4ch8vywDiOwyh5EtU6NG+MOwKtmYKnMKlreYEQUbhJMOWQeaKA/q7FtJrIk8qkhqDv3EYXnV7j3CpTdYckg4zoC6l7kKdFHcQr2fVmnlpheRZ9Dj7kzLW6Grl8+MrAcROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spTcw3ghozzJrH9SqYTvpIbtxp82ucYFakFPrwOptRU=;
 b=Nz90jLzYgQlqrYKUUhXLkJf0+NY3DZr4LdhLMT1wjBub8oR0y+lugtn7mNsZojXp5uS4vDfglscsSyx0LBG4iFDihuyIchnVCqnJxQu9iaLCMGZA9pWd/QCOQqzBdTr61ybh8+yVzzI9YPfyvcJVnhBPoxYMDKpXwWsNb8zIaKokX7tsxX1dkV8HIYy1VsCySWSJaSBajOVb1tqJCaLxY/RPQ3e5mWuYP80jYuTEEhr6OiRDONw0b9Lb+c3XwNI+BNLKHcplR5IenOJV5lzt3L+YSNHQqF4+bLMbAB1doewjJx0Phx482e+6f4yV3GVraFkeBjhRi6CrJ3gUsSLlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7892.namprd11.prod.outlook.com (2603:10b6:208:3fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 23:34:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 23:34:14 +0000
Message-ID: <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
Date: Mon, 20 Apr 2026 16:34:09 -0700
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
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: d86348f2-27d3-4410-6fab-08de9f3554cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /SVMtkFqav5rCahwkiTLgVdi9iXaYf6D5bIDpLyaXpMtlf36KqN557gtWfWkOgxZssS+iY4h96PUZmioYcOfH5GyMSqNe/zo+gp5BOmBjgPReBJ3L7fMlMg4TNEuvHeK/l8GbCpFUnnwrGsge0w5HtZrAEY1MEfNDN9eZjTp4BI8LJDMyAMAjf23HzaXcz0OGrSqvTRdB36TrGBaJCnkQzZt9ln6qUt/M6fyPTfpD71DGxNhOTvPCeIH/G6NVKdQXMrhJJK1nlmP6qKH0mbC6OtJQRkpDbc9a6Qn9xCsRK6flzRH5ZE53kzcnqrgaeykOCXKKZEr14skcPJt3MtxmkC0qtMqEpo0AdBdZeCciiV/2UnxDjZU4fDL/CeAm6NRBdC8OV/AQ03r4QovwHdpsZb6BxU/PBasX+aeWNYiRB1I/wYFN2/xO2DWa6/9Sd198AcpeDkkfHVxdcoTbhXaSkxNqtHNaKU1n8GXuaxk76nCpdmtyWK5mPGFC/GCk9DgQDrBCJiDdhnW64U3a2m6oQMxd9eLUN9Yr0QTzogtX1BRY/hQcLw1nBKoAH5NVbsjAXV5I0hWTN1RsoUua4+ON0NC0XMvmoRDVOj/aWN8CaELwQfRJ5NqKSu7Ai+eP0RgiwS01fOL3FvMqwLNC7rpaoe4Pkj8XLm2O53Rs1bdNs43Gwbp5PymM8Sg9HtKP8z/6g/NYsgEzEDOph2B6DYKaICYxIcWsi8FRPMRoeT/3Go=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVV2ak0zUUpaZ0Y5dDg4eFRvck5NbTdLdk10d2g1MDE1NFJsZUR2dkJtVS9y?=
 =?utf-8?B?Zm5UMjBXS0JJOWJIWFpnT0xEZ2JzbUpVZk9MMFl1SmNxUTllcjdwcm1idWFK?=
 =?utf-8?B?RG9uTU82eVUrc2RqU2xRWXBtUDdITVVIWHc4cmlZSGhtV0RldEV2SllMSjFJ?=
 =?utf-8?B?SkFvUGJkMW5ZZTBkNVlrM2M0amd6c0hBRXowSitxejg0WWc0UUhFdjFqaFNW?=
 =?utf-8?B?T0NNVFdWSTMzS2RJNzhqelJ0VThvQjRlQ28vVWp0SDg0RmJBUnVVeE1SNTM5?=
 =?utf-8?B?VmpXa0I0T2ZJQVV0cG5pNGE3SVJNNmdwdnk2K0NaQjRVb3QxYUR6dmVrZmlw?=
 =?utf-8?B?eHlPSlVralN4NDExNllwa2JmUmwvaFFWdFNoc0t5cHVSNisrWjB2WjBsdlJk?=
 =?utf-8?B?Y1pUUVBZM0RWL2N3Tkc0VG1TWDczSjU5OVVtWlVPV0V6cXlUUnprQVROamdL?=
 =?utf-8?B?TFlTVFJXVDQrVWkxQ0xPN2U3bVgvNVFVQjRkWCtXVndUSlVvQUFXU2ZscGtO?=
 =?utf-8?B?WUl3blJyRDVtWXZmcGdLUVg1OFVYdEwwV3IyaVZVZk4vMWhEN0ljQmxPK2VR?=
 =?utf-8?B?UndzZU8zZEJoczRnWnhEaldBdWM0aTlqbDRpQmM4bzF1SnhyM1p5MXB2dGl0?=
 =?utf-8?B?cngzQ0YwRkt0NXB0QnNTT0FzOWM5SEpJVUIwVEVSTUpBSFVhOG5xSEd3YVor?=
 =?utf-8?B?b1BtK3pWOWRYZ2xUMTV6a3Ivd3JIU3pkMkgySDF5Z2Vnc2UyTnFhc2JBTml5?=
 =?utf-8?B?WTZobzRWb1QwT2MvN1RxcHhrY0x4QzZKdzg5ZmVvaEIzTjcwc3RzUFdCcEhi?=
 =?utf-8?B?V1lhaGwralVuZDlFeUpjS1RYMUwydXliWjVDa21QZCtaQU1KdU54aHNIaWlh?=
 =?utf-8?B?QktoV0VmK3ljK1BrN0RlR081ZzRnZlhKL0JBRm5oRVR6b0ZIaHBkOW5BcFg2?=
 =?utf-8?B?VXNjdERsZjFoNUg0UXpRb0Jxa2NyNHRrWVAxOEU3RzlsODlvKzVJYzJTalVF?=
 =?utf-8?B?TUVORTlYRzNQK0FUVnoxK3pCdkVDMFpzTzlxdzRvM3JPOXdzeUxCSHByMnZy?=
 =?utf-8?B?eWZRMzJWbFpZampoWVV3TE5OUkJRQlBFMXMrcks2MGpmS1p2SnF5WEk0bnpO?=
 =?utf-8?B?K3JMcjRhSTVxalJHam4zNUxBS0dvTXFqdmx3aDlNNjBoL2FqUTc4aDRFTnQ5?=
 =?utf-8?B?bjZwOWsrRUxSY2tUeDFaQ3ROMjFXdTlZSW15T0FDLzJucGlUR2JFeEh3Rklp?=
 =?utf-8?B?S1BDM2djSlJ4YndyZjZsUFdwdWIwa2QzRlowTTl6b2x2NmJ4UzJtUEYxdllo?=
 =?utf-8?B?VkFuWVJ3b01XRDhRSGg2cXdqVkpFeERxRStJbXV5d2VQTFNtMGpXUTdiRmFo?=
 =?utf-8?B?QUlURzdSbFFzeGNiYUhnWW1ncC9TdnpnVCt1clpPejBIR2xpZ2lJQkM1ellu?=
 =?utf-8?B?K3NZK3l1a2hwZUh4M0loM2laYWJDdnNReEVId1k2S1ZJaHNQc0NpaFI4OC9E?=
 =?utf-8?B?QXMzVFJaQzAwV2tiKy80clIxY0VGUkNIeUF2YUpMNkphazRJNWEveGNCVlJp?=
 =?utf-8?B?aHlGOVhmVDllbGxSaCtvRGVXN0ZFZERkNExHblJ3VC9VMzRlWUZ4S0d4UEVw?=
 =?utf-8?B?S1NKOUlsYURxUVQxSGdxVDFaRmJsZjZrTC8ySnpiTFpZeHllWVVEQ3BtZ1lK?=
 =?utf-8?B?Snk3VHFWRzF0VW1kM1UzWGF4MHZmK0dLS3d0amxGMkFzek8rVHNBY21KdUVN?=
 =?utf-8?B?QmY0dWN1Zk1iRENXc0EvYnNuMlhwSmJsbldVd2VvYVROTHUvTnF3ZzRNWC9o?=
 =?utf-8?B?NXNLKzNFa3FHajRtcWs3dVhKTzVtWW9SZE9wNnNSMENJM3lRRXpVTWdRWEhO?=
 =?utf-8?B?Zjg4SDZaTDh2d0MzY0ZYMUpDOVVKNVpjWDBHcUJKbkJ1Nm50YkF2NmVFYXl5?=
 =?utf-8?B?bGtUNitoVURlRjk1NWo2eHplUHNEVFhIWGljL2M4OHNxOEUzbDQyejFtZUtk?=
 =?utf-8?B?L0ZzTytOTHorNCtDZHZTYW5xQWVFck9kK1ZNZzl5bFZ1ajBUeXhVb25OZkt0?=
 =?utf-8?B?Wks3ZzQ4SWsyb2NscTNFdE5GdUJTV2tKVHpNVmZmQkFoVkVJQndhYUVzVkY5?=
 =?utf-8?B?WGFXVVJNc0c5OTJ5Q29obGFWU1I4d2VEWkJ2b3lsZjZqRlN6Uk9JbVBxWHVw?=
 =?utf-8?B?WlVRYks4am1VWEJuLzVxT3Fkb3k0UE1ydUY3NWt3ZnZMRzlZOGc1emtqdmNt?=
 =?utf-8?B?d2xWVkduV1A3aHVLbWdRL3VOb2VHdkxITDAyUmwwTVh5YWJZNElrOFFONno0?=
 =?utf-8?B?NkdMNjMxU3RPRXVpWWRjUFhVakJJcStjeFRGZlo3eWRGMUo1MURZR2NZVEFE?=
 =?utf-8?Q?jYmVcLp/uAsfJq9o=3D?=
X-Exchange-RoutingPolicyChecked: aYfHQiWgOo0uufxz0tdWLZBLw1cX3SpyKIo8slcEZgD6tgn1cK/tWVtFsfaeLxSJzkyiX8M/EvMFUIqTAVQl8hQRMz4W+p95BGNwlTUw+2V95feUmsBZEkjgC0HLsIUU+kUIR8YmzB9mAe1kXp/l02w7I9UwbRD13bwHp29oU6xSlmlm5Re8jBO3pj4tSSmk8x6W/kokNnAeZKrjaliZcIgsAuRIHEO62f6oGnZnS15Io73cRu3+lBbMSV3dwIGjfUlqg322IAjVHRWbbRK/MNxUk6EzENz7ARsXhFbl8/RdEUlDhVxAwjcjch6509W/s/yXXJgNbmboQ1fqzBPz6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d86348f2-27d3-4410-6fab-08de9f3554cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 23:34:13.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 079fTUDrYMMT48NoehXjMs4jK4i7QJOnEHCGO/S0bxADK0l+QwngkqMENE8q4pAaTE+x76LozJ//QuvDi2XieYaiMsUYSlwvK02gRKTq3vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7892
X-OriginatorOrg: intel.com

Hi Babu,

On 4/20/26 3:59 PM, Moger, Babu wrote:
> On 4/20/2026 5:03 PM, Reinette Chatre wrote:
>> On 4/20/26 12:38 PM, Babu Moger wrote:

>>> The current mode change behavior is very restrictive.
>>>
>>> For example:
>>>
>>> # cat info/kernel_mode
>>>        inherit_ctrl_and_mon
>>>        [global_assign_ctrl_assign_mon_per_cpu]
>>>         global_assign_ctrl_inherit_mon_per_cpu
>>>
>>>
>>> # cat info/kernel_mode_assignment
>>>       ctrl1/mon1/
>>>
>>> In this state, we cannot change kernel_mode to inherit_ctrl_and_mon. The expectation, however, is that inherit_ctrl_and_mon should always map to the RDTCTRL_GROUP.
>>
>> Could you please provide details behind the "we cannot change kernel_mode to
>> inherit_ctrl_and_mon" statement? Why is this not possible?
>>
>> I do not see "inherit_ctrl_and_mon" to map to *any* group though. Expectation is
>> that when user changes mode to "inherit_ctrl_and_mon" then
>> info/kernel_mode_assignment would become invisible to user space.
> 
> Ok. That is fine.
> 
> 
> Sorry for not making it clear. Let’s consider the following scenario.
> 
> The system boots with these default settings:
> 
> # cat info/kernel_mode
> [inherit_ctrl_and_mon]
> global_assign_ctrl_assign_mon_per_cpu
> global_assign_ctrl_inherit_mon_per_cpu
> 
> 
> At this point, the interface info/kernel_mode_assignment is not visible.
> 
> Next, lets create a new control group:
> 
> # mkdir ctrl1
> 
> We want to designate this group as the new kernel-mode group.
> 
> First operation: Change the mode:
> 
> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
> 
> At this stage, only the kernel mode is being changed. However, there is no way to know which control group the user intends to assign to kernel mode. All we know here is the selected mode.
> 
> After this operation, the info/kernel_mode_assignment interface should become visible. But the question is: what should it contain or point to at this moment?

This was considered as part of original proposal per
https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/ 
(search for "default value") where the idea was that the group
should be initialized to the default group.

> 
> # cat info/kernel_mode_assignment
> ??

After
# echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
# cat info/kernel_mode_assignment
/

After
# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
# cat info/kernel_mode_assignment
//

(although this is where previous discussion comes in on how interface
can become inconsistent depending on what the previous kernel mode was)

> 
> Next operation: Assign the group
> 
> # echo "ctrl1//" > info/kernel_mode_assignment
> 
> 
> Now the intended control group (ctrl1) is explicitly specified for kernel mode. In summary, changing the kernel mode requires two distinct inputs:
> 
> - Selecting the kernel mode.
> - Specifying the control group to be used for that mode.
> 
> 
> Hope this makes sense.
> 
Understood. Could you please elaborate what the problem is with making it so?
Are you trying to eliminate one per-CPU register write? Is this something that
ends up being very expensive? I assumed that a register designed to support
modification during context switch should be fast. Or is it the IPI you are
concerned about? Please help me to understand what the actual problem is that
you are trying to solve.
I think it is reasonable to start with defaults when changing the mode which
I do not expect users to change often.

Reinette

