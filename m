Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2A374725;
	Tue,  7 Apr 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584111; cv=fail; b=aE7CYWz2KxufPPVPEi7+kCyr4aSOkzRo87VbhRf88S4mNxa+3lW1lOOSwOyuP9UACb+yltSZgCBbGNK1rs+bVqh1JQFQjAVvHeoFKh+20GhGK6DL/gwRPv1kqvilSV8ZZRetqWM7eD0SXHy1nr78jxDVfWfQIQu7nELtvm49aek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584111; c=relaxed/simple;
	bh=K0cyl68nXHrznX+qbLaiqiM8r6BsWeT6oA/uYfUpKcg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPguYw3DiGhoxH7dxmEFQih8VqeBP5dlICsm53idZzrd5oyTGfhaJi0F2Rh4SCoUrPDkaQlsDdr1YpsDxpJbUNd3QXzJwCEka3ofUbdv2tWAk4cAVFGipOQXW662uF0fph1sVta/MXS0bXFRq6PCi5/DiceRlJVFUye4YPVciO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQA26Npp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQA26Npp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775584105; x=1807120105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0cyl68nXHrznX+qbLaiqiM8r6BsWeT6oA/uYfUpKcg=;
  b=bQA26NppdU678K8Um49nO4xNsGErJWB/4jmBDOFPRT/MZ+VR2VGJ1ilP
   rkBjy33Tu4KI8fRCRJbyZdLqYykIIZGNoVhTYpJShxS6mLP4rXtfZhpP2
   S1hT2NUKqBGh3mdrV9q1DOtaWdO7lY/ejaaQljlQPvClY7pm4BHbsWKC8
   yitcJ94zaVhRdelbjjRzzTfphAqwmDkf1vLD7w7cg8y48I7mMUi1MQDmc
   MMzJoHL03P9YOs7YRVUyW9sKsqOE6nHUnv4cBP4NfNTsZ6TFHWSW8oZpH
   hHdfbjSNPKxBjTBs/PE1JAikoC3/2PuwfVa86TFrdXvcNK0LIO0tZDh+K
   Q==;
X-CSE-ConnectionGUID: LLAIqSmYSui5YTPwtT6aVA==
X-CSE-MsgGUID: Yl/V4PzLQ0G7Dy1aYkWXyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="93944465"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="93944465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:48:23 -0700
X-CSE-ConnectionGUID: f7AchNkwTw+FudznhkJlKA==
X-CSE-MsgGUID: I/HQBZhFTBSREiqCYWHt4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="225479262"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:48:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:48:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 10:48:23 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4+ptjtlX2QrppzRUcOFXBzc32uX/GWiAtinW90yMqltejpTQWjR+/lyIaUITb0utyJ+VC+sE+O66VHXN279eZRxYZWNuAAUTVjWFZNiAB3MpSDMiJhpWQKHAJXKY2u5bbRq2d2R3yGArLEA0j9TXlALvV3AbTkasS3QqDZCi6MgiTXV4xtxMHkmpTKNu4HCRHsCaiwjqbkqzXAdQzmVgiUnW5jn/MV8Aen3V4pYVRgF7MLGIr0Btk2didbPQnTqIMQ+EYpJ305DKQhDBxKz/0PZ5+KDPIKeYIdD9bWZVCGAHJrrRPF/7Jot5phdzfdSz9UL9ZcK7BDKSXyPNcfzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIXRggW/ZGxHvtS6C7cyorQ31lTeJ04goWkyaJ62vZk=;
 b=Jsp56Sgrm5PVvgat3hsUyY+4UnuNyp0SmFVxLZJvLp0DT5OtEAuNVii9z6wRMuoH834khdihh8Mme5agx5IWSMG3knP/IHh4T/g5tvA0I6/RTuZFF/lbGMX8uGmiGJJyqWMtLd2x6gTCk7ILBf6RdTw3tz9UPKNE9Rhz2eqe7Ep5EaWI7tpagFO2gNL+3vKkhOpj48ij5ERaE8BIRIt+hA9s5yC1R8gOcXByi2vGm4WCar6sx7EJWSiNzu8m/pgH/yayl9m4IZZzoM0ELCRCQrwxrjCBEqA6aWn3r+qsp8FXjm6tPPsgk15KTGkZAiYUBhHUScYRH5KxFncqwvoYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 17:48:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 17:48:15 +0000
Message-ID: <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
Date: Tue, 7 Apr 2026 10:48:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6906da-9c28-4cb6-e5d6-08de94cdd8ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1895+ujAqXHLLtXFUqc66WP56S8lRaV3hFbR+81B+/YN2BXIBNe1ZeV9JbF48MwIXXUdBFOwsoPSUwY7Ol+fh8oxtvbOZLfvALcZrl3ZwYJ0du1DRwAiwy2UcKldXNbv/e4+zEhJQ8tb3DNzo24TiJL7/Ypyb0BzSJ5H5bqXvM6gk0y4Nf+RwtfbqrzhWlZwwqfB62QNdfxq/S7VCqnDQ/M1wIEhyW2a1EFucyGEjllAfMPOAq209T5gHCdBpJrkt20BIUlSNER7MraTfV7SIv7nU38SagAo7p1+9Bfv9YPrSSlDFDzOEd+jUNcowZmkS+LRhxW5tJu+3/5/yXfhoFv48nmXEaseDnJBVRl+EtdI9OMklQDVoSPnXf2Y0OPzC6Uuj6+Q6Fz4l7e4wFJT8CJf5dJ/kSN0Kp+jNbK9gDnE8x+GaQGQv+ptgPc0RQhNSqyXtmNUC0bl+Wk0UtjmqDSMVliAV1aBAKpCWnJ/dx/hHKvC7PkKwOmmLxnoVvjCx2CahciwOUFctEmZwH51pmZGkTJUgPT8EtNwOJlKsHJHcDbJWLbEzJrE9wNfJYJ7G3hH2Bfh4OUw50QcZ6f3Mo/P2wXpuw/NvuDf+DVvxGYco1H8yuJSKJCswCunBwu7QxgriDYJnB0IzZwu7r8C3p3O+MEFwLomnXZHZT0udwh5e7DZalUaMOqRvm5iD02mFC3W9cBBB1CIzh9GsJ1r2V7FyAOIQ/CFLvHjvmdnPZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enl2MCtuMDIxSDIrVjRWV2tDdFBjdGVLKzh1NHREelJmN0JheUxIMGlLTFE5?=
 =?utf-8?B?L1VNVUlsQUpEeEQ1Y2VvUUR5Tmt2SWZLSU1hRWhuWVNFUG1jN2U5TitzaTRC?=
 =?utf-8?B?TnpLVWFPRFNIUmE5RzdMQU1Dck5UREM3ZzNvWlB0Mk1lUURlb1kzTU1MVWJJ?=
 =?utf-8?B?VHhrRklNWkJjakFIcTdXbzRCMWtON3h2T3QxZjlHbTZyWjY2dWRhWGN4U1Vk?=
 =?utf-8?B?ZnhibGdrYVZxbXRhbWVMdlZGcDJzVWxob3ZBSGRMeEs4ZTFSUzhWZnpMWkFv?=
 =?utf-8?B?SUoyeExNdzhqaHZJUVJXQ3A3TGpsd28xaUNHNWM5cmQwMEJKS2pmenVWeEdV?=
 =?utf-8?B?S0pMc0xCMmhmNmphUXJlNVpEWUdNTHFlNStnNUtrbHo4NmhXNWZFRXF4S2lV?=
 =?utf-8?B?WHRiWDhvUDdTMzNLT0htbnJocHdyd0dGM1dHZGpGOGpTWnRCOFRyQW81NmpG?=
 =?utf-8?B?Y2llbUVBV21CU1hOSTNEVlZpbkFwK0lNdnVkZjRBYXhzVXhrd2sxSjYraVdI?=
 =?utf-8?B?K3dxNUVMSlU3RTJkVTQ1bnpoeFQwMDhLSGdZcE94OWJNa2NBY0g4aUtKSmtD?=
 =?utf-8?B?M2pURVRGbW10YzBqTXh3ODVBS1lFTU9pd0lEVTBJZHQ4anh1Ky9IWk1iYkZS?=
 =?utf-8?B?Y1FtU20zcy9yK052WUJkb2lvbmxRenlybGpYSVdaYXVnL3ZrWU1Qcm9QcU5v?=
 =?utf-8?B?TnF1TGpIcDNQNzNsdkhDSkx6bUkxajFrUndGMlFFb2hKd3NVSVR3elluZkNr?=
 =?utf-8?B?d0YzblFiLzBabUl4VmpBRmYwSi9oNURVQ05FVWdkdVlIenZOQ2N1VTFkNU8x?=
 =?utf-8?B?aHRKRm9WZFAyQmxtVWhqcE9IR1lnK3RUY1dxdnFlL1V2TTRvT1lCUnhmUlVC?=
 =?utf-8?B?OEdvOFFiOSszb1g4d1RDWlRveXlMSHJUdDFPNVNKYWI3NktHajhBRnhPWkJY?=
 =?utf-8?B?SmJCOC9lUHRYMDJvb3NFSDhhSjBJUzNMT2dkeEdKY21lVWNadlBaOEt3T1VW?=
 =?utf-8?B?RGlPeFNwbkNOYmlrbHh3MUdwNHlIOEMwVm94Njg5Rm9WeEFEUjlCYjExQjFS?=
 =?utf-8?B?OGdTNnhGcXhhUEZPZXkrNnlsTzV6RWM4S0RzaFhVYkRJVzBDRnMzelloQXhx?=
 =?utf-8?B?MFRBQkE1c0tTZWR4dDhTZFh4bm9zdWtqU1RnN2l0K0IxU0phM1FLcEdBN3I5?=
 =?utf-8?B?aEVwbGVYNXUxYzFldW54NU1lejBnVjNTcHpjSlJFMUtWcDJRY0xEQit4a0Rt?=
 =?utf-8?B?U3I5eW50aGNQdGhpVllYK21zVlo3MUdsb0M2QXZBNWFnazErWTJkRUIxdzVG?=
 =?utf-8?B?R09GMlptTTNPOHFQSlVPRG02ZE5vYnBUelkzZTBFWnhrNWltRUpLc1psSEky?=
 =?utf-8?B?dWp1dnQ1TnBNZWtNYm5ZWkVFdkV1Nk5GdENxeDMwZjkrdnowbk93TEhrRDUx?=
 =?utf-8?B?eTV2bU9DeHB3djQwTU1Nei9hMUFnVElmWDUrK1l0czVMd0p1NzFMYVBCS0Fl?=
 =?utf-8?B?V1F3QmpleGIrT0NwSzcvKzNoL1Fhakp2SVJObGNHWG9mSWphL3llNlR2M0pP?=
 =?utf-8?B?L29oZ3F1aW10QXJKeFlKMmpUb21YWnN5U2tvUmxGYkFKNFg0K2paN3l4WmVk?=
 =?utf-8?B?ZVpadlRlZ2tXTVgxMHE3VUxJRnlaU1hhMHA2WHF0Y2ZxZ1daM0lpT2Nqc2p1?=
 =?utf-8?B?cEZiYlBVN3Z4cW1EZlZkNWxEOGJmYkN6VURORmE4bXJKbHVRbFRqVE83ZGRQ?=
 =?utf-8?B?cFoyZFc0dXRsVlNHU3BqRWI3WlNCVnRDVW5rczQzb3ZreW1udG9oUmtFK3pI?=
 =?utf-8?B?MUI2VXNJL2tUTnYwUUJMZkJ1dnVxMkFsbjVlQmpCZlhlUkdneERqZW0vSlZv?=
 =?utf-8?B?ekk2R3dnR0pXZWRFK2NlY29CakttTi9nZU9Gd3pEL29KajMxN3g2Zm9OZllF?=
 =?utf-8?B?TCs0ek92NWhMTkFNeUk4RnVxY3hSV3ppN3lRd0R4ZjNOSEtTQnVMdkV0NHRs?=
 =?utf-8?B?TDhJLyt4dFdpYkJnT1VWekd4cW94aGxWdEgwbjRHTnBGWGk2N2RIQ2JxS2Zw?=
 =?utf-8?B?WjFqc1U3TjdlSFQ2UlZVaFZvZHVJbTF5L3BWZXYrQ2NZS0s0K29GM1NUR0ox?=
 =?utf-8?B?MG9Lb1Jmei9ZbHRLSytZN3lVckVzK2NmaEpXbVBUa2hDNFZrY3hjZzYweitH?=
 =?utf-8?B?bWVBekFYUjhlUzBJbnJFQ3FTZmVLcE5HaEZHYkwySytJcVVNNTVlcjVhMDRS?=
 =?utf-8?B?dGtSWlljdTM1SDBhcGljNDV4Wk5ScXJjUHBaeVZoRDJUbVNWWjBJS1JKazIx?=
 =?utf-8?B?c0ZmcGE2VWdyWWdxcHE4VzFOQ1lFVmZHdmRWU29LUnNZdm5zb2krTy9MZkIz?=
 =?utf-8?Q?5VFBNoMgI4k1WCAs=3D?=
X-Exchange-RoutingPolicyChecked: u3rtcUsZ6hIB+6e09CszzW3nB28TKs7TQ8LIqpDZPhfzHhVmq/AR5I9BWMuDtyQfduxMo4ip+FNgNMggwqMCvMvcvfpz8WHBJd3Ko2y2rdZ8kLbhc0zG0UP+xOnUgMVlrnkhro7kJflEIEeSi1+8yIqXPsNG9S6l4ocOgHB9RAw3VVuqbLCwVLlqh5OKZQbqVoz7H2okUzjBJYFIk5XLTOzHm7/iH/LQKYWJoe4JDgv6T9PvbJyw44er1BDATZs4QckZ/0Ik5jaLkB2CKiWHxfp+ha1hTjGplzyOE7uy5dzuPlJVD0ZP8vlZFTO3jtxP4hk4jF8gTouhMob2RY4nDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6906da-9c28-4cb6-e5d6-08de94cdd8ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:48:15.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z02hARtlUBiTUdXOuhdkZjmATMmw+ekCRKCACu9bFpNXFnxXWTXGTcORTPnhn+4KFyGbgMJZCwE7MnHbRQTx7eiqHuHDDD9A87MakXXgs/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com

Hi Babu,

On 4/6/26 3:45 PM, Babu Moger wrote:
> Hi Reinette,
> 
> Sorry for the late response. I was trying to get confirmation about the use case.

No problem. I appreciate that you did this so that we can make sure resctrl supports
needed use cases.

> 
> On 3/31/26 17:24, Reinette Chatre wrote:
>> On 3/30/26 11:46 AM, Babu Moger wrote:
>>> On 3/27/26 17:11, Reinette Chatre wrote:
>>>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>>>> On 3/12/26 1:36 PM, Babu Moger wrote:

>> can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
>> means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
>> to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?
> 
> Yes.

Above is about L3 scope ...
 
>>
>> This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
>> resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
>> the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?
> 
> Yes. that is correct. It should not be attached to one resource. We need to change it to global scope.

Can I interpret "global scope" as "all online CPUs"? Doing so will simplify
supporting this feature. It does not sound practical for a user wanting to assign
different resource groups to kernel work done in different domains ... the guidance should
instead be to just set the allocations of one resource group to what is needed in the different
domains? There may be more flexibility when supporting per-domain RMIDs though but so far
it sounds as though the focus is global. We can consider what needs to be done to support
some type of "per-domain" assignment as exercise whether current interface could support it
in the future.

...

>>> There are multiple ways this feature can be applied. For simplicity, the discussion below focuses only on CLOSID.
>>>
>>>
>>>       1. Global PLZA enablement
>>>
>>> PLZA can be configured as a global feature by setting |PQR_PLZA_ASSOC.closid = CLOSID| and |PQR_PLZA_ASSOC.plza_en = 1| on all threads in the system. A dedicated CLOSID is reserved for this purpose,
>>
>> Also discussed during v1 is that there is no need to dedicate a CLOSID for this purpose.
>> There could be an "unthrottled" CLOSID to which all high priority user space tasks as
>> well as all kernel work of all tasks are assigned.
>> If user space chooses to dedicate a CLOSID for kernel work then that should supported and
>> interface can allow that, but there is no need for resctrl to enforce this.

(above is comment about dedicated group - please see below)

 
> Yes. I agree. The changes in context switch code is a concern.
> 
> You covered some of the cases I was thinking(xx_set_individual).
> 
> How about this idea?
> 
> I suggest splitting the PLZA into two distinct aspects:
> 
> 1. How PLZA is applied within a resource group
> 
> 2. How PLZA is monitored

I think I see where you are going here. While the "How PLZA is monitored" naming 
refers to "monitoring" I *think* what you are separating here is (a) how PLZA is configured
(CLOSID and RMID settings) and (b) how that PLZA configuration is assigned to tasks/CPUs,
not just within a resource group but across the system. Please see below.


> Introduce a new file, "info/kmode_type", to describe how kmode applies in the system.

ack. "in the system" as you have above, not "within a resource group" as mentioned
before that.

> 
> # cat info/kmode_type
> [global] <- Kernel mode applies to the entire system (all CPUs/tasks)
>   cpus   <- Kernel mode applies only to the CPUs in the group
>   tasks  <- Kernel mode applies only to the tasks in the group
> 
> The "global" option is the default right now and it is current common use-case.
> 
> The "info/kmode_type -> cpus" option introduces new files
> "kmode_cpus" and "kmode_cpus_list" for users to apply kmode to
> specific set of CPUs. This lets users change the CPU set for PLZA.
Where were you thinking about placing these files in the hierarchy?

> The PLZA MSR is updated when user changes the association to the
> file. No context switch code changes are needed. This will be
> dedicated group. The current resctrl group files, "cpus, cpus_list

Why does this have to be a dedicated group? One of the conclusions from v1
discussion was that the "PLZA group" need *not* be a dedicated group. I repeated that
in my earlier response that I left quoted above. You did not respond to these
conclusions and statements in this regard while you keep coming back to this
needing to be a dedicated group without providing a motivation to do so.
Could you please elaborate why a dedicated group is required?


> and tasks" will not be accessible in this mode. This option give

These files can continue to be accessible. 

> some flexibility for the user without the context switch overhead.

Dedicating a resource group to PLZA removes flexibility though, no?

> 
> The "info/kmode_type -> tasks" option introduces a new file,
> "kmode_tasks", for users to apply kmode to specific set of tasks.
> This requires context switch changes. This will be dedicated group.
> The current resctrl group files, "cpus, cpus_list and tasks" will
> not be accessible in this mode. We currently have no use case for
> this, so it will not be supported now.

Thank you for confirming. This is a relief.

> 
> 
> Add a file, "info/kmode_monitor", to describe how kmode is monitored.
> 
> # cat info/kmode_monitor
> [inherit_ctrl_and_mon] <- Kernel uses the same CLOSID/RMID as user. Default option for the "global"
> assign_ctrl_inherit_mon <- One CLOSID for all kernel work; RMID inherited from user.
> assign_ctrl_assign_mon <- One resource group (CLOSID+RMID) for all kernel work. Default option for "cpu" type.

My first thought is that the naming is confusing. resctrl has a very strong relationship between
"RMID" and "monitoring" so naming a file "monitor" that deals with allocation/ctrl/CLOSID is
potentially confusion.

Apart from that, while I think I understand where you are going by separating the mode into
two files I am concerned about future complications needing to accommodate all different
combinations of the (now) essentially two modes. My preference is thus to keep this simple by
keeping the mode within one file.

Even so, when stepping back, it does not really look like we need to separate the "global"
and "per CPU" modes. We could just have a single "per CPU" mode and the "global" is just
its default of "all CPUs", no?

Consider, for example, the implementation just consisting of:

	# cat info/kernel_mode
	[inherit_ctrl_and_mon]
	global_assign_ctrl_inherit_mon_per_cpu
	global_assign_ctrl_assign_mon_per_cpu
 
> 
> Rename “kernel_mode_assignment” to “kmode_group” to assign the specific group to kmode. This file usage is same as before.
> 
> #cat info/kmode_groups (Renamed "kernel_mode_assignment")
> //

Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
"kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".

In summary, I think this can be simplified by introducing just two new files in info/ that enables the
user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu. 
global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.

The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
"kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
it will be all online CPUs. The resource group can continue to be used to manage allocations of and
monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.

A user wanting just "global" settings will get just that when writing the group to
info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
expected to inherit both CLOSID and RMID from user space for all kernel work.

Reinette



