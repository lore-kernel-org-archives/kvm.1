Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF020E702;
	Wed,  8 Apr 2026 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623549; cv=fail; b=qmG3PEy8eI03FlBfGHRDJLnMdrZyqU8hA9EitEGfyLMP5dq71fOcq/b4an/yJ82sB9nasIm4tGVMzM3g/rVlYAS2zFjd0iz//f+5v+bAVXIp11ccv5iMwmdv4H7GAax//Wf4iXogrVC9MopNkdqxF6IUQyvNEDpwn+tBws9y6Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623549; c=relaxed/simple;
	bh=4uDBy1RZQ7neaOD8K2AljZJAf7Khbfji/XrWuRSkiqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jIYc4l62AWIYvh4eQ4za1Rl89UzxJDW5LhnWabK2OruCJPVprxiY4DNXgHqF+UUHcO/nTWGLAV0vWPvmW8zrlqbYFpiWUQJRZr5CV+8Zb6V0VaN9iA1M3Zv6aebxpi1mcCWNxeRgNVfGlJUY3h/oWzPAXj7+IUkwSjOc06RLnqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmaN8NOT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmaN8NOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775623548; x=1807159548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4uDBy1RZQ7neaOD8K2AljZJAf7Khbfji/XrWuRSkiqo=;
  b=XmaN8NOTXAqapCI9W4uQfbvgJ3ODQ+c/Yolpn2OFRTJPysdt1Nqm9Say
   I98YuXyZXOi443/SqkE30wgL6udgzgOFMKBgAJLIpPYDZPre6NmhOilLd
   irrM1scdYU/2l34iOq5oAFk2ldf4OaqgPYihqe+Vp0T/juhH0KNa1DBrO
   voNQeEKiEooWWfDNt/VnYqC3pHHFCMGd86VIFxyFvhrgSmQEIx6Wb9Zqd
   DEbXaVG83fxKiyZOXLOhmu+fU7zT+cbNwViJH05vzkpIEQUzaVbIcpwft
   l7kfdaF3o3NiO2g5Wui8MnpMlovSjIhKKfVjTUJQcU+stqqHYNtH+Gw0U
   A==;
X-CSE-ConnectionGUID: IAnP+3tCRS+SQpli2owmRw==
X-CSE-MsgGUID: V1m8IITAQcC/jT+oyI124Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80457455"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="80457455"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:45:47 -0700
X-CSE-ConnectionGUID: 9P9jCMaWRyK105D+/eUjeQ==
X-CSE-MsgGUID: wrVVeX14Q+KBQO53jS7p7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="266350463"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:45:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:45:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 21:45:46 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCp934aDLa8vPOuOrYJeuzjH1rMnCB9BtZH9L8feIDcFc8dtGIUCU+cJp2saaRMaGskesgshhW0N8mkkhKwxBfRp3NqCBHTyfXpc0gWAFmzmQYmgqRojBrELwR2VN+QXBlqGv5DiMwiHRm6gE+HYG072yFVXvfTYOUPUk7L4py5VJSbdO5pETWMSO1Q6zVgTOQ91mc6JPxmv25Xxo6Z30mD41G8T1JvzwqW74xUMfp1XA3LS6+t4i3TkNmbWnHepuCskpM9YzbcdIPZebUUe50vmTRUHomcnjcFpEFvixv1CxDBzx7GPyxUrusIVrNG+EkDihT1g6qkdx2QfeMTaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUH1qCQgf1kr4IdE2BaBUmTdooHKq9WnqtYWkSp2ybQ=;
 b=BL9DSl1w9y6RAewdXxvVJKPBgti6Ygw/9ijZayWQ4/oAdMa8fJn09zfa9ce2tsOEJn2VHxCEuIB7BFOSaQ5+E33IJ2Ycwp1NKGgLdI+J26zL+Hb8PFketbmngsItXbc0WGWQml/ssZpjTkQf/5VW4tRCanHuEjRpOkTdakR2lv/AZQTLQJY4dcwylyy012Isb0COsp2LfCRnexhnQtqc7HjlSXjeVq/urHQUrgmU4bI0vWF+TZ+V1nTPf/F5UNPwRBvwOQF21XkUcozvRMrV5lFKCjh0iQ3vPA3Tzayq8BIMATOjnVlfg4DnsobGs22JUTNy6LnxTySM/+iWhjmirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 04:45:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 04:45:24 +0000
Message-ID: <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
Date: Tue, 7 Apr 2026 21:45:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
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
	"Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b4b272-06ec-41d8-cda9-08de9529a5ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nJfoc6e4ogsn7GCzyZVyWZoP5ziwzOG8fZltdY0UMPHSkTyWgRrwbR0qR+JgynJ88mCe0MZS0b3LQQoaNIMfFhY57DMdz/7QB4j1JQAcTTuIyfxVoV2sDZqHtNdK5TNP/lUyn5JlxHXX9CzKhiec4I90J+MGG21vGFOruqY8umW0ZUCJR0cqvUEkdJFfXBh6sNdqTmS0PNh8cexP6C9JXcr0iZhDfvCKDDwlyVImASjpqV/vZufp7KdRWQyQOyUbxvMGtmUeI134kVG8+8yowp2H8sDICISV6pVraHFAzCT1AeHb4FN+t/TVOpv12sAZ7mF7sUZiX5pjWmTdY+682JJqs4sK7lgceI9VUZHCnQWgpE37YXAacwQHcTrYE8NRFYJmNhKhlv30Pt0MVgIJ5QXqbBBbs8+33cHm3onqA8dVgPIeWKCeTPqC8SER63fxZUIMUlhKkJnee3oVlitq5MTKyG2NwsVabiK0rvXWQPp+fp+yqLGL73G1BhL3smrUmTMW9sbV7To0n1tT7KcHk/lHWmfvwjAERwjBgSi6iPxqj9f8Mubeg0hGoLocm/fuYnQMuk90ABRaRI7awkDSJ75NLyS0f8JY/S7shVc95DJyA7oLzYeFuTThTXhMoebX44ARpw/IE2a4b5ahyPxT6+EtwHdScECRN5eeyq8DuKks7Jl4mYw4VgzXYAcmJxWW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3F3MFpVYnpaZ29UaWlNRDRvL2lSMDF6YS9sVkpyYUVUTjE2eTA5YjZRL1p1?=
 =?utf-8?B?TklSQmdETVFlQStGYkdZV0NrT3ZmNnhUWm91cW5yeDB3RFJxelVaN2VSRTA1?=
 =?utf-8?B?Ymh0djJPVG4xY01CYjFxR0lpd2gzMFdvdnFSbnErSmVmVDdhQzZOTmFIS1hI?=
 =?utf-8?B?eDIzWlpuWjhQR21wM3g5a05WVEFrSkd2WUVRYkU4VWNYS2krZjM4VVBiWXA1?=
 =?utf-8?B?dEgxTTlHYUFROTc3dHNkRUM2Mi84MHB6UVVvYTBUZzl3d0E0YzZFT0gwUlgx?=
 =?utf-8?B?M3NLQU4rSWtERHJ5UnBMaGQ2ekRDUllOMy82bk1nMEk0UGFmQ3dhRXU0NGQz?=
 =?utf-8?B?VExvWWt6cGt5RDV0UHhMQy9wMi9oazVRa3VNaFk1RFZ6ZWNpVGFMUjJoRmJh?=
 =?utf-8?B?eEttVlZ5U0c4Slh3OUhvekJ2NlVKZVArN2V0RXF5akNWTUlpQUdMYlcrQTFt?=
 =?utf-8?B?RlhDcGVCdmhLQ2RBTDAwRDFGMitUZXpEbHBMb3A4U3FKSXhqRXNLbWoydExt?=
 =?utf-8?B?cmhhaXpLSVliQUlHMGtEY1RVam9MbGs0aHRCOU00RitEZVQ1aEl1amZiZ0dw?=
 =?utf-8?B?THA3OUZYWUhISS85K0IwWFhVR2pEaVVUVG40Uzk1Y2Fsejl0NENMNjUxYkJj?=
 =?utf-8?B?SHF0NEtEeU43cGUwMlJlZkZVR2NmMlI2YzNKZ0NOcjN0eG1mT21tSTRwTlFZ?=
 =?utf-8?B?YmZqUFJFTWEyUHdYNjN1VFdqWCtzajd0TXoyL0Z4WmZJejNUWEh3Yk5jWG5j?=
 =?utf-8?B?eis2NVlYNjQ3V09SR3NpV1czamtzd0RvT1J2V3gzSXQ3NEw3ZUJURzlLTWk3?=
 =?utf-8?B?NE1DSTZDRkhCZHNMVHVFWlVrS2EyMDRBS1oyVGdLSjdtSHJNeUFxUG4wNnI1?=
 =?utf-8?B?bGpVa3hod29STnMrN2ZmQ0NuMmJjVUExZ1B4ZmpmcDhqdFlVOW5IWHlDM2tR?=
 =?utf-8?B?LzlPOUs0UVJycjFzZHM1ZWcvK1B5VzU3Rnl3ZEFVakphMWFrZ3dlZk1pNmpZ?=
 =?utf-8?B?czUzV3R5Ukw5cytxRUtqZXVac2FjOHE2UE96Z0ZZUm02YjBMUW50dEJMb0d3?=
 =?utf-8?B?OFM0a3JubVpEbS9Eb0R6L3hnMVBxMC9HbUhiYlFIeTFmVjFYdi9NTDVJc1dz?=
 =?utf-8?B?aWxZcDB6Y0kyNXVFd2s1YWdiVTR5c1NuTGt4OGRWQmo2SGhFWXBDQ1hmZzdS?=
 =?utf-8?B?UVVnRENreDJOWVVuamEvbXoxdmIvUHlhVnJKazUvZmxISWRZZ2gxV3VHaXNa?=
 =?utf-8?B?dlFhVGRCNis5TlBYb3p4RzArakNyS05RLzVWek9BQXRtL1k3NmR1ekdOZFZ5?=
 =?utf-8?B?b3Vmdkd1YVJsN2lYRkYvQ1FVZXdnbEptOVBqU2VYMWFOUXdSQzRzRjZYcWZk?=
 =?utf-8?B?WXFrcUlFclRiNkdZUW5lT0sySk9iQ3ArY29aQ3lXdG9YZmFRMGFtQ2kxQkRV?=
 =?utf-8?B?WDViZkRwSk1IQ3lIUlFOTHZEZ2QvTVlGKzFIUXlSUnF2ZHM4dGpKeVliK0tC?=
 =?utf-8?B?cXRxM3hlNWM1SjYrSGc0T3dIamxjS3dMYmdOb1IrN2I4dVA0M0dRUVVmWTFG?=
 =?utf-8?B?eGdKN1RiUHEvVFgwNi8yRithMSttbHNsSXl0Q1QzbFc2dGw4eXJmNEdFUFF5?=
 =?utf-8?B?ZTFCZDgrbHc5a0x3VUYvdXVXVFI4eGQ2Zk5tUEpmc3JKQUwzajEva01xKzFn?=
 =?utf-8?B?Z0lCQjBIU2d3bjdvZGJ0eVIwMkpCZFJNT1JNQklSWnJleXNyaUdpTWY3ZWp1?=
 =?utf-8?B?Y2g1L0hicE1GYThQM01pT3VtdUJSaVVYWDJPMldyUDhITzRmSml4ak9ZVnNs?=
 =?utf-8?B?R2laOGhubGErRXpOeDgrQkxLcE15VTJwSkozWUJRaThQQjNSSEpVS2Q1RHhY?=
 =?utf-8?B?RkYvVzY0SmNkbW9LQWQ5N2ZCSzdTd3NCTzRBWE1yRkNuNnYxS2hySGFnbmdC?=
 =?utf-8?B?UjdGZFcrWGdQZUlocHpLVmxrV1lrR3pxektvTEhWN0V1M2JtdkQyNnF5Mkgx?=
 =?utf-8?B?NXRJQ3lTdXRuWUpoaEEyUHpTcHRQZ0hmdWxMd0VDclFkWnJTUkNpd0NOaElJ?=
 =?utf-8?B?K0NlY085aVMzN1phWGpZZzhUK25aSlpCNlNYTm5pSis3cmFKK0FiT0tWaXZK?=
 =?utf-8?B?ZUZabVgyckszcE82NGVLYVlwaHlIRllmNDBoWVN3ckRGRHNuQzQvaWNoRWV3?=
 =?utf-8?B?bUlFeEJuOTlQZlRTN1U0dEcyeFdxUGlqNWhvZXRXZVBHakRiSW9haWdWS2Ez?=
 =?utf-8?B?WEZ1SGk2S253RWVNMExoMElKZ0FndFdFWTFlVkcxZUVHQlR5NUNUaUkvUFl5?=
 =?utf-8?B?azhSS0txU2N0KzB1UktxdW9QUUkzZXFKVlBMd1E3VitqNVV1UVhxNi9TRVFn?=
 =?utf-8?Q?aa5unPTZzYAu1sIc=3D?=
X-Exchange-RoutingPolicyChecked: Uaex5pO8PdOfSAy6o9fFfM2XX7PWuZHsAlz/b9y63ajsQqR+lG35VzJ7TYPKYEbIx9aOsdNO45CI4pHaGqIoV5xahUHwpo1aRHvHdaMPJDcg/76GtsljVgZJg85FD29xiJE5jt+bhI9dmVAhRnuyhDwIP5jl5ImFE79e9YEPnmQm3EvVzWOE+QZuB1+uEa0x2aD+M5/qxIk2qV9Ed/bbhV/iMIPoCocs7twfMZlNRbA6h48UqJBsz0MIW7aZbAvVuBCbcY/N3x+/ZfBaoJM/iJKFAittPbLK2pSOtRjS0+uIQ57xTYRfWLICMzZU6zlaVl8ZaVmPyUJnQr+gynqh1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b4b272-06ec-41d8-cda9-08de9529a5ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 04:45:24.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgXcSI8QFiKvSevoHyBo8MKe1dPvRCiKIsiMboQkax6RMIb4H0Zshm1U23mTOAe32cE/aFHBUiRHPMBDijOQ8mHw9jqvOl9HKr+mqD0S46c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com

Hi Babu,

On 4/7/26 6:01 PM, Babu Moger wrote:
> Hi Reinette,
> 
> On 4/7/26 12:48, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 4/6/26 3:45 PM, Babu Moger wrote:
>>> Hi Reinette,
>>>
>>> Sorry for the late response. I was trying to get confirmation about the use case.
>>
>> No problem. I appreciate that you did this so that we can make sure resctrl supports
>> needed use cases.
>>
>>>
>>> On 3/31/26 17:24, Reinette Chatre wrote:
>>>> On 3/30/26 11:46 AM, Babu Moger wrote:
>>>>> On 3/27/26 17:11, Reinette Chatre wrote:
>>>>>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>>>>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>>>>>> On 3/12/26 1:36 PM, Babu Moger wrote:
>>
>>>> can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
>>>> means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
>>>> to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?
>>>
>>> Yes.
>>
>> Above is about L3 scope ...
> 
> Yes. The scope for PQR_PLZA_ASSOC is L3.
> 
> Is that what you are asking here?

I was trying to point out that there appears to be a mismatch between the actual scope and
the planned implementation. As highlighted below during the discussion about "global" this is
fine with me and I just wanted to confirm that this matches your intentions.

> 
>>  
>>>>
>>>> This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
>>>> resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
>>>> the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?
>>>
>>> Yes. that is correct. It should not be attached to one resource. We need to change it to global scope.
>>
>> Can I interpret "global scope" as "all online CPUs"? Doing so will simplify
> 
> Yes. That is correct.
> 
> 
>> supporting this feature. It does not sound practical for a user wanting to assign
>> different resource groups to kernel work done in different domains ... the guidance should
>> instead be to just set the allocations of one resource group to what is needed in the different
>> domains? There may be more flexibility when supporting per-domain RMIDs though but so far
>> it sounds as though the focus is global. We can consider what needs to be done to support
>> some type of "per-domain" assignment as exercise whether current interface could support it
>> in the future.
> 
> Yes. Makes sense.
> 
>>

...

>>> The PLZA MSR is updated when user changes the association to the
>>> file. No context switch code changes are needed. This will be
>>> dedicated group. The current resctrl group files, "cpus, cpus_list
>>
>> Why does this have to be a dedicated group? One of the conclusions from v1
>> discussion was that the "PLZA group" need *not* be a dedicated group. I repeated that
>> in my earlier response that I left quoted above. You did not respond to these
>> conclusions and statements in this regard while you keep coming back to this
>> needing to be a dedicated group without providing a motivation to do so.
>> Could you please elaborate why a dedicated group is required?
> 
> If the same group applies identical limits to both user and kernel
> space, it essentially behaves like a current resctrl group. In that
> sense, it’s not really a PLZA group. PLZA’s key value is the ability
> to separate allocations between user space and kernel space. A

The plan has never been to force identical allocations for user and kernel
space since that would go against this feature entirely. Even so, just as
user and kernel space cannot be forced to have identical allocations they
also cannot be forced to have different allocations. Specifically,
a task *can* use the same CLOSID for user and kernel space work just as easily
as it can use *different* CLOSID for user and kernel space work. There
should not be any CLOSID reserved just for kernel work. Or am I missing something?

> single CPU can belong to two groups: one group manages the user-
> space allocation for that CPU, while another manages the kernel-mode
> allocation.

Exactly. This is why it is important to have two files for this CPU association
within a resource group. The cpus/cpus_list file continues to be used as today
while the new kernel_mode_cpus/kernel_mode_cpus_list is used for kernel work.
With this a task can be associated with any resource group for its user space
allocations but when it runs on one of the CPUs within kernel_mode_cpus then
its kernel work will be done with allocations of the resource group the
kernel_mode_cpus file belongs to, which may or may not be the same
resource group that the user space task belongs to.

> This approach also simplifies file handling, which is another reason
> I prefer it.

I *think* we have different interpretations of "dedicated group":
It sounds as though you interpret "dedicated group" as a way that enforces
the same allocations to user space and kernel work.
I interpret "dedicated group" essentially as a CLOSID reserved for kernel
work. Since I do not see that resctrl should dedicate a CLOSID/resource group
for kernel work I have been pushing against such "dedicated group". 

> That said, I’m open to not having a dedicated group if we can still support all the features that PLZA provides without it.

I find that enabling user space to share CLOSID/RMID between user space
and kernel space to indeed support what PLZA provides. I think I am missing
something here since below proposal again attempts to isolate a resource group
(CLOSID) for kernel work.

>>> Add a file, "info/kmode_monitor", to describe how kmode is monitored.
>>>
>>> # cat info/kmode_monitor
>>> [inherit_ctrl_and_mon] <- Kernel uses the same CLOSID/RMID as user. Default option for the "global"
>>> assign_ctrl_inherit_mon <- One CLOSID for all kernel work; RMID inherited from user.
>>> assign_ctrl_assign_mon <- One resource group (CLOSID+RMID) for all kernel work. Default option for "cpu" type.
>>
>> My first thought is that the naming is confusing. resctrl has a very strong relationship between
>> "RMID" and "monitoring" so naming a file "monitor" that deals with allocation/ctrl/CLOSID is
>> potentially confusion.
>>
>> Apart from that, while I think I understand where you are going by separating the mode into
>> two files I am concerned about future complications needing to accommodate all different
>> combinations of the (now) essentially two modes. My preference is thus to keep this simple by
>> keeping the mode within one file.
>>
>> Even so, when stepping back, it does not really look like we need to separate the "global"
>> and "per CPU" modes. We could just have a single "per CPU" mode and the "global" is just
>> its default of "all CPUs", no?
> 
> Yes. That correct.
> 
>>
>> Consider, for example, the implementation just consisting of:
>>
>>     # cat info/kernel_mode
>>     [inherit_ctrl_and_mon]
>>     global_assign_ctrl_inherit_mon_per_cpu
>>     global_assign_ctrl_assign_mon_per_cpu
>>  
>>>
>>> Rename “kernel_mode_assignment” to “kmode_group” to assign the specific group to kmode. This file usage is same as before.
>>>
>>> #cat info/kmode_groups (Renamed "kernel_mode_assignment")
>>> //
>>
>> Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
>> specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
>> mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
>> "kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".
>>
>> In summary, I think this can be simplified by introducing just two new files in info/ that enables the
>> user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
>> global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu.
>> global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
>> global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.
>>
>> The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
>> "kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
>> it will be all online CPUs. The resource group can continue to be used to manage allocations of and
>> monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.
>>
>> A user wanting just "global" settings will get just that when writing the group to
>> info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
>> info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
>> files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
>> expected to inherit both CLOSID and RMID from user space for all kernel work.
> 
> After further consideration, I don’t think the info/kernel_mode file
> is necessary. There’s no need to enforce a specific mode for all the
> PLZA groups. Avoiding this constraint makes the design more
> flexible, particularly as we move toward supporting multiple PLZA
> groups in the future. MPAM already appears capable of handling more
> than one group—for example, one group could use
> inherit_ctrl_and_mon, while another could use
> global_assign_ctrl_inherit_mon_per_cpu.

You are looking ahead at future capabilities for which we do not know all requirements
at this time. I think it is very good to consider how things may progress and your example
of MPAM is of course on point. I believe the current design does consider this progression.
Please see https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/ 
(search for "per_group_assign_ctrl_assign_mon"). In that exploration per-group assignment
is actually accomplished with global files. I thus think we should not make such a big
architectural decision that does not benefit the immediate feature using partial information.
As it is, a "info/kernel_mode" gives the flexibility to expand to, if needed, configuration
files within a resource group. That is why the intention is to associate the mode within
info/kernel_mode with the presence/absence of info/kernel_mode_assignment (search for
"Visibility depends on active mode in info/kernel_mode" in linked email) since in the
future resctrl may need to enable a mode that needs configuration files within each
resource group and when enabling such mode the per-resource group files will appear
instead of the global info/kernel_mode_assignment.

> 
> The mode can simply be determined on a per-group basis. We can introduce two new files—kernel_mode_cpus and kernel_mode_cpus_list—within each resctrl group when kmode (or PLZA) is supported.

I think having these files in every resource group is confusing since user can only interact
with these files in one resource group for current PLZA. Why not *just* have the files in the
resource group that matches the group in info/kernel_mode_assignment?
 
> 
> The info/kernel_mode_assignment file would indicate which resctrl
> group(or groups) is used for PLZA. The files—kernel_mode_cpus and
> kernel_mode_cpus_list would indicate how the plza is applied which
> each group.

The "how PLZA is applied" should be learned from info/kernel_mode where user
space learns whether RMID is inherited or not. While I find kernel_mode_cpus
and kernel_mode_cpus_list to be just for configuration and just found in the
resource group listed in info/kernel_mode_assignment.

> 
> Files and behavior:
> - cpus / cpus_list:
> 
> CPUs listed here use the same allocation for both user and kernel space.

Both user and kernel space?
Monitoring would depend on info/kernel_mode_assignment ("inherit_mon")
and kernel space allocation would depend on whether the CPU on which the task runs
can be found in kernel_mode_cpus, no?


> There is no change to the current semantics of these files.
> If these files are empty, the group effectively becomes a PLZA-dedicated group.

I do not see it this way. If the cpu/cpus_list files are empty then it means that the
tasks in the group will use their own CLOSID/RMID for user space allocation and
monitoring. What allocations/monitoring is used by tasks when in kernel mode depends
on whether the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
file. If the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
file then it will inherit whatever the PQR_PLZA setting of that CPU which is the allocation
associated with the resource group to which that kernel_mode_cpus/kernel_mode_cpuslist belongs.
If the CPU the task is running on cannot be found in kernel_mode_cpus/kernel_mode_cpuslist
then its kernel work will inherit its user space allocations and monitoring.

> 
> - kernel_mode_cpus / kernel_mode_cpus_list:
> 
> These files determine whether a separate kernel allocation is applied.
> If empty, user and kernel share the same allocation.
> If non-empty, the kernel uses a separate allocation.
> 
> The group can be CTL_MON or MON group. Based on type the group the CLOSID and RMID will be used to enable PLZA. If it is MON, then rmid_en = 1 when writing PLZA MSR.

This will be difficult to get right since CTRL_MON groups also have RMID assigned.

> Here’s the proposed flow:
> 
> # mount -t resctrl resctrl /sys/fs/resctrl/
> # cd /sys/fs/resctrl/
> # cat info/kernel_mode_assignment
> //
> 
> By default, the root (default) group is PLZA-enabled when resctrl is mounted. All CPUs use CLOSID 0 for both user and kernel-mode allocation.
> 
> # cat cpus_list
> 1-64
> # cat kmode_cpus_list
> 1-64
> 
> Next, create a new group for PLZA:
> 
> # mkdir plza_group
> 
> # echo "plza_group//" > info/kernel_mode_assignment
> 
> At this point, plza_group becomes the new PLZA-enabled group, and the PLZA-related MSRs are updated accordingly.

It really looks like you are getting back to trying to dedicate a resource group to
kernel work and that is not something that resctrl should enforce.

> 
> # cat plza_group/cpus_list
> <empty>
> 
> # cat plza_group/kmode_cpus_list
> 1-64
> 
> The user can then update kmode_cpus_list to apply PLZA only to a specific subset of CPUs, if desired.
> 
> 
> What do you think of this approach?

It is difficult to predict how the "next" PLZA will actually end up looking like and I find resctrl creating a complicated
interface to support this to be risky. Instead I would prefer to focus on efficiently supporting what PLZA can do today
and make it extensible. Apart from that I find the implicit interface, "If it is MON, then rmid_en = 1" to be too
architecture specific for a generic interface while also not able to accurately capture user's intent (i.e. user may
indeed, for example, want "a CTRL_MON group to have rmid_en = 1"). Finally, I am just so confused about why the implementations
keep needing to dedicate a resource group/CLOSID to kernel work.

Reinette


