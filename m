Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940703;
	b=XSRnjhrk+NEIxbNY60QBIWN3Xyzd5yqcDxS+eok+uIlopKc5XdmsHgi4XQXGgGMfOMor
	 AT+XE/WcnjmcQcTn++ZQ3/NVI/HtkigCWFpS9+vqZ8tBu5KS9S21O8wWWQPOmNrdXo8Sn
	 0E4qZIztzkIB4cJYo28XClmv6EodCkYvb2KCFKw8HZ1FsUf6RPB+zqB4IPSdw6hkNTU1V
	 pXk3z/CBe9ZeSlU4tyFK8U2X4DKVqLmKSmdGdbXzbXzgT+/lJrjBZJho9Bj3Pe+au7CCd
	 oFKvvwqqfWHQ3sVkIIMtnzXGcDVbzWIsP7LIbCCYuC5+4C/QceAN+nZEyiyo+Do8I0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940703;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vIDlDRYNCAZpfL0b0fUIJKZ+CI/o7DOsLluCCUrt/0Y=;
	b=YcSmPhbop39PhMp/2PLKX9v2/w7YP9RsHgshBmhb3+P4umCEy7kC1BPvFNbsavzO4GeH
	 5rOgSU/ymN5jgig+nj9vC8atOtX/+nyg+jFvkxuXIXJhbRfVJNwOwa3rGxpFzpPeNyTLV
	 Z761peOQ/J1OAXah6soDiNiss2nxWmDGJXhr7DbPmSFacO0HXLbpAfrpLJJqQGNGOzo24
	 MyFJqXyxHSxgcuO9J2xqaCpDwyZosATssaeUHfxQ+uyRecpbWoVdAdXrwy1PWLHyw8UFe
	 4+AE6LK/XJicik4EsQAi83qr/ZYBd42LMa3aRfG9+pnsmPVmdztIsT4067pw7STMLAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HPQFACV2;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=hH38eT0A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D8606A31C;
	Tue, 17 Nov 2026 18:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HPQFACV2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=hH38eT0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940702; x=1826476702;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F4dh8XZRcAlSLa55V0SGgqfUUFUj68tXCJeYvDF5OYU=;
  b=HPQFACV2csgIVLSyId65KdbYsatb9Ntz5SSDMIo69GExMhJMgVAQ7jrM
   NsMMTcEnn5PncfYwehD0YkuMCPiZJ4zDoql0PXI4BMBMQulZ4YQzpRwz/
   VsaTp+8AtjS+rKQT8I57VlRVbY96FFlEiWCoA7Ga9BQ69m+ngAlLijJwS
   LiwbowN/1bnTanP3a7BMN6jxmyPn45rf/8FD4Gl4+OelNPKPk+BtdL3nI
   BmtWoPCOJlr/flfaL9FYPe6fgu6sLmmnJmhgPYbOqLGisVNNO5JpYkcRg
   s9EkzC8cY5q78s6MEWhxYW2Yg75e1LdPamQTYEGuPdN5LEooOrsF2/bRz
   w==;
X-CSE-ConnectionGUID: vbGBiBdrS62XqsitHRtjCA==
X-CSE-MsgGUID: HlRozNRlTESXtkOluvZQ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3577481"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3577481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:38:21 -0800
X-CSE-ConnectionGUID: rDs/7Yc0RnqsjjK5tc/P4w==
X-CSE-MsgGUID: PVgZ/CJlTs+bmTKwUuR2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9974862"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:38:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 10:38:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 10:38:21 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 10:38:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKQriVn8o/Za12d5iAT89NDPPmnXpND/IT3Ha6fKj1L0HWzqjbBLkpSfw3AjUV3r/x1HPhDDs9yx6Eiw7NULVfefnCwfS3LK6M9Roi7mD9GvdKTb0vEHGLyMGjEoGVRYlodygWdffOsMiLcBSbLVl3a9vRXINU9OVg5OErZn/Vk21F7+caOsLReQL2gqnOfH76nNLRBBRA1S+kH2KAnpIS7SUMePHU8qbvJ6HLRm1Tn5X4i0GS9VMqLTqP2fJJAi2R2GihT75Lz3j8HbRQDPWV+tcDOFPqgYeMDcEubdBYhcD9KOV2oXPkm42NFDaX1EglypP/TvtAQq1vjW86jQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIDlDRYNCAZpfL0b0fUIJKZ+CI/o7DOsLluCCUrt/0Y=;
 b=uC9xCtyIM7GljrzEuQ5AhGEvWz24mBW3xnos6lK7EKpHAHsIakoJC5emfUysAJ7tI6EVbkJKfJrdW0UqDcSt6n2Thz4oZs8jyKDOEiPIL+eaEq+ghnZqvCSeShftLGaCnaO6btMBToby4qWTvCkXnQfcwm02ApGzFai2jRK8Uuk0/r7Ng/31DPlASypOD8sATg2F6KUnFGIk4AOv+nBPlOFEedlJ+jUdryLyEKz/ZFfqaaM1O4TuRR1+cszs2RiYE6AMki/h1CIyGbSqgiIUwy/9KU8uYewyLJLb19XSTxq6+QN/TQxCn46qy3TWxCvaKeY55xiLVcNq1qJAxDiiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIDlDRYNCAZpfL0b0fUIJKZ+CI/o7DOsLluCCUrt/0Y=;
 b=hH38eT0AcZz9orsBRS3a5MZuFqTVnWIQAL9zGpzaTtaj0weKPI1BSxXvXdhASh8CBSxeCN1R6JIjXpn8CmsgRmDeq7iIveloEBc6/iah5p53Wpy8hRLuCRqCwr3oqM5XaxJ+PZlnO579GJaj5o0LcQfGcGGk/8bEI9HXj35E5jA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by LVUPR11MB9859.namprd11.prod.outlook.com
 (2603:10b6:408:38b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:38:13 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 18:38:12 +0000
Message-ID: <0e87373f-1f2d-4b2d-99f4-4072f3d14b66@intel.com>
Date: Tue, 17 Nov 2026 10:38:10 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
To: Jim Mattson <jmattson@google.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-13-chang.seok.bae@intel.com>
 <CALMp9eS_NHtj--citTS_PhrSSfUG=nfLNLDcDFBX9rhY2CqF=A@mail.gmail.com>
 <CALMp9eSZ7V=rOByRveQqCgAgnj_AwRKFa19X4_+4xRJh88H4sQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eSZ7V=rOByRveQqCgAgnj_AwRKFa19X4_+4xRJh88H4sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|LVUPR11MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: fc77c85e-6b08-4350-ec5c-08df44d9ef72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|3023799007|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: W0KbmAmIZvh3Wz7OqN8djqw7e4F99JqUZszOWfUBDflzbz++RRuDcjSb/3lVk8a/oUxHFq/SVBHWLU1iTZxzxacDtbfZm9d/NUusQp8vevBTt8OQwKBCVzxT8IT5msyWtw7Kh7o4xUP4FlnSMOs96/di0+okSJuN7aLBttGdslGLOyha+86TdPN9s82txzyymoMTVCjxQMdweThnhu1mjyac0BrGWsMftMzvUuiIxTMzyPDzHg8OkIbSSGTrqzQExDN3Dakm4g24klKnYQoX2GK+ls+A5jkeO9fWEsC4SPkW+cjnoxhpf5fspxO4/so40Yf5Q0eOnuauBda60KIeJUHc8+1QY0nO4OPAxM68n+CkWk8AMs5rpoCSYJqSZI0+FTfhBc/eag/rvwuqS/cOr6SHhQYZ3mg5u5H3Cch2GnoS/MvKXIvodPDSjkJiHonPY40WW2ltgZLuRps19eG2tnFCoWnpJarpn+4638tiUTRz0/veWMoNKGE8/v94cyHTW4fEs9tgi5b4CDenaWl/geenStCssFu7C/pptD6sfdSk3UUbazcqgR9rK0Lt5sMHNrrjT9EQXlcLwJxyfGzIZKIBpj7yWNrOV9rkehlCtnS8tqeMW1GKYlJISaNHoI6rJXbU68dxXLYnxZ4UBBH+hCZ0pC13rvQnQMQy/5qLglM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1vVjhxQkVCa3lCc3hUK3Y3TFppZFVMTm1uNUF0blBWVFluV1FaN3BRWkFD?=
 =?utf-8?B?N1pqSVFwZWR2V0JlRTJBSUFKZmNJRW4yY2JNd2xUdGsxWnYvTFZWdFdydzM3?=
 =?utf-8?B?VWJ5cXpmRkw0QWNRVVY4NFowRDhrMlcxYndWRWNoSjhPQWZtR0FrelliNkI2?=
 =?utf-8?B?TmExV0h0Rkw5SndOVWw4QmRHUmxzNzdURVJsZlFxZmtUdXNuK1A5YTdBNUFu?=
 =?utf-8?B?ZDJqNkFmMjZGZU9nMllRek14K21JVHRXQVBuTnBaQXhNTE94R3pVMW0zdmVQ?=
 =?utf-8?B?RmVNdEF1eXNzYTVFRmVWbzdHNy81K25KS3BOSkxOZnRvbzdwZFMrM1h5b1p5?=
 =?utf-8?B?N2VJMVNwdUE3TURiUzhwSlpNM0kwNGVUaldUSHM2OVBUelA0K3ZKMnlaZlVN?=
 =?utf-8?B?SkwzRUhPMkFmeGJ3VzMyMFYxd2ZWS3NLTWYzS3lJZ21nbERvNWdiOGI4NE1l?=
 =?utf-8?B?V0VDYWovbHNUWTBmNmR3UHQ4cGVKOHRPK01LQmd3N05QVnB2cWJGMlUzYkhu?=
 =?utf-8?B?WHJUZlFJUWlIU3Y1dkFMS24rRHJsQm4ycWF3S0dMV3F6cnZ4ZElGZkdJV2FY?=
 =?utf-8?B?OWlpOWVoMEh5azlia0JVSVB2ZlBTZ0x3QlVCQ3lpejh6S0JtdjZCYmxaU1h0?=
 =?utf-8?B?VHVuMmJNQUxHZkZ5ZXdObUhUNlpOd3JYUlpTVS81MEs1b3ROYjlVK21WcXMv?=
 =?utf-8?B?NVUwRzVobVZkZ01WbCtJell4NjlIc1ZUL2V3ZExGUzVkalQ1TWdXWWZhSEsv?=
 =?utf-8?B?QSt1YStFUDVENFQ4cXpjdWFpSmJBYkdmZWxBQ1pSSThsUTFZYXhyZHBaMUp1?=
 =?utf-8?B?ejB0WHVlczYwZytqQ3R3bG9wTUZ4aGE0ektCVE9qdDYybEdWK3JPcDFqNEZh?=
 =?utf-8?B?djJTYTh3TGtwMmxKd01vNG9NUFc0SzRRSzZQZ0VqcFRleUREQ05FNVlPeWM3?=
 =?utf-8?B?NkNSQUJSUG5VOG43R1BCNlBpenBRejhmLzNhQ21OeGJ5ZTM3b3lYUXFHaFM2?=
 =?utf-8?B?SUFjcmM2TERrbmp6NE5GUmppbCt3YmtmUjZYVG8yZFNZQ29TeG9GYTJVUDFR?=
 =?utf-8?B?TXJqNUdvZXJ2bDRpTjlmaE9XaHBHTEpFdjFYdUd6TlN2NVRreXNad08rRlVW?=
 =?utf-8?B?U3QvOEtnaHltRWY1d3B5TVVSZ1NwRXZVMTFtUE9peFFzdjc0aHIwVHpoNHpF?=
 =?utf-8?B?UWJCUVJLTkdlb3JCMGhmdDFPSC9SUGhsY3JNcHQrRmo4UitTZkdEdHl5RWx2?=
 =?utf-8?B?OTZtalhaWHlJdlJIRHhNdGZQcU9xR0hwL2FUc1FCQ0RsZUVPak1uNWZWcXNq?=
 =?utf-8?B?QkU3ZDhMbEVRWXF6N1AvbjZsMHh4dERtMXhmUlgwSFdJcmZVaVc2V0t3b3Za?=
 =?utf-8?B?ZktuRm13MHpmdEhlaWdqOEFOeW0vRjlJUUtRMXJPUTFzS25sdDBJbXUwOThT?=
 =?utf-8?B?Sms4UkZkMElKRWdFcXJrdVRJT3VONkFRODRBUlZ3NDd5OWpEdVl5RVJwVjB6?=
 =?utf-8?B?eUpOaUhuQ3l5bVNrSUN1SEN1aGkrN3dyek9WdzN3QWdWNWJiUzBOemJhWVp2?=
 =?utf-8?B?bzNkd0ZoZ1Vic2d0WDhhdDBkSGJrL1ljbUJlVC9NU3Y3dkpFL3hTdFlYSlRm?=
 =?utf-8?B?MTAzdWtQVEc0ZGFtZFpOUjdZSGw1T2tBVjhseW15MVVKUTBOaFFQMWl0UW5F?=
 =?utf-8?B?dmlMN2tZVHBrQ2NWUHNFUTJJREUvaDBuSkdhT013U3RuSit3Y1l1aFJ3bk93?=
 =?utf-8?B?d1JlL1ZOeThMeldoRElQS0xyNnJqZTZJSWtEZ2QyWkt0U081UmJoRFdkUGht?=
 =?utf-8?B?WVdnVmI3dWpKTS9ibW1HcHlLNU93Uy9DNUtwNGIxV0FhRmlrQ2cvckZENkNy?=
 =?utf-8?B?dzBmZ3RRTjRXbXpYT0VKVHFPWmdQc1lHa2NLSGxNVzJIS1VPTmE0STAxRzlU?=
 =?utf-8?B?NENscC8rTTArOGJuWFNoekZMWFY0cTZXZnFDYk02MFQ1d3BnWVhXUEFqRHE3?=
 =?utf-8?B?dmlJTTNjZHhIdmNSK3l2ME95T2tFVlYxZjVxNVZHbHgwdzV4YTlNRHpZekt6?=
 =?utf-8?B?dnUzbkcwQVN0Q2JjMDBQM3ZUQ2FhUkI1V0k5UUpuZzJCTXczZ0hRcWNTU1pH?=
 =?utf-8?B?SkNrTUFnd2kzQVkxeVRPOTBTWENtcitJbEcvTWRmbnFkYy9xcGh1UmhPSkMx?=
 =?utf-8?B?M0E3R24rdWVBNWJJNU1MMC9zdWFaZTIrUjJoRHRNeHhrQlpGZ0MvZjZoY1ZN?=
 =?utf-8?B?YWhtemt0SFpVMlJHc05VOU0rREw5aW9UTWt1bE1GMENpL1VOZFBlUXVFa1ly?=
 =?utf-8?B?WE9HbWRUSVpKYXo2UTBadDNwOXZya0JVYS9PZW92cTZWQnlVQm5XZz09?=
X-Exchange-RoutingPolicyChecked: PY+dr378LdOwKxFH5FMaQUCevBX9BNFLdo5ox9eH5AlCBGbmbxenGlRBiRVAUKJxbEcZlcoYiBFnfOKU+w6+djLvsFnKAF7iNGFmuZAd8aUZ7XokP2fYu15yLAr+eStK13T0itu9t03ldMGctHf4m/ukZY0jFGVBAFRyKLuX+/gTXXCHSFy46Y450hAuC5eul7ox8eEDfmKeVllZbFgNESOh18NTJaqa/sxcctp0iM8McxdbpuCER5XKqNcxBg5j0/I+Oh+ISMRB2pC480Uv7OaeySl5dl9geuj0kcOI/Ni5jXNvUSyrbSt9FRsiH+Q4jE6aK1T9eL2mIIU2m31/iA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc77c85e-6b08-4350-ec5c-08df44d9ef72
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:38:12.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydqatsa3mWyoZPf+dpl/BpFgrRR/Ui4/1BGlTI33OjVqhSgozmdNnGNzIvckTL9R2FJgJp+iqPgdFkM3BeihY24gjPc5HLFSQtUvnj4s8hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com

On 11/6/2026 6:07 AM, Jim Mattson wrote:
> On Thu, Nov 5, 2026 at 8:48 PM Jim Mattson <jmattson@google.com> wrote:
>>
>> "ud" is defined as I(SrcNone, emulate_ud), and SrcNone is 0. Jumping to
>> done_modrm with opcode.flags == 0 sets ctxt->d = 0, which then hits:
>>
>>          /* Unrecognised? */
>>          if (ctxt->d == 0)
>>                  return EMULATION_FAILED;
>>
>> before ctxt->execute is ever set. As a result, rex2_invalid() always
>> returns EMULATION_FAILED instead of injecting #UD.
> 
> Once again, on EMULATION_FAILED,  x86_emulate_instruction() will raise #UD.
> 
> That leaves only this question on this patch...

So I add the Undefined tag explicitly here:

   -static const struct opcode ud = I(SrcNone, emulate_ud);
   +static const struct opcode ud = I(SrcNone | Undefined, emulate_ud);

>> Does hardware raise #UD on 0x48 0x66 0xD5, or does the intervening legacy
>> prefix nullify the REX prefix as in legacy encodings?

Yes, it is nullified and this behavior should be preserved, I think. I 
was also able to verify this on an APX-prototyped system.

> 
> The text clearly permits 0x48 0x66 0xD5, since the REX prefix doesn't
> *immediately* precede the REX2 prefix. The table is unclear.

I'll pass this documentation feedback along to the relevant folks.

Thanks,
Chang
