Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B14E50C4;
	Thu, 15 Oct 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073862; cv=fail; b=NHliocUXroXQgJSQrHtzos7KT+xiCUKuiFi/lmqSIZaCzkX5XpMNty0AlBKKQWYwAS8tIEI4YmfQTDgBggBLxAuFRA4BfsBzKl3UsH9ego6SZHxCSAiuOZVDnmlhBvhHYYGQw+odX5kgTEm7WMzYQU799oz3w7r34fcvBycmsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073862; c=relaxed/simple;
	bh=hA56RAJRx0GnYlWz5bX5zamk0syJOVUP4AcIJgV4yLM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFcdpf/2dnRUEbKAHKmChLKm007+w6S1Ee7GzQn1aCzUbFD1DkLHmZjLvvGQJzSKXhYIrAKb+gNcT76ONBZpqe+HigB9t0ty/1cRalyBp3wzh1HnyU5RFMssODsW3k1Ug7IfOkajK06aqKQWPOgCLUuYuZhPQg/YpazhKnX/irM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+2Yaxpu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+2Yaxpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792073862; x=1823609862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hA56RAJRx0GnYlWz5bX5zamk0syJOVUP4AcIJgV4yLM=;
  b=h+2YaxpuIC8L7emPY96iuhJQG6l2whMzwfbmyksliaEXgjh51Gt8e5jc
   1AzfdVvwf9tC1NsI/B3rgFz6ZQt+iAMq4WKK5ThbXKcatFDCe93l/Pb6r
   iNM7WPXAUrEMawDyAb9FzUmLeYcOCmsfQZ4OGr3lapu9AWF5RGVSVWwCR
   b0jfv8i2RIXwwc9biW9Dx2V8jMuhRIgHoBULOC1aItjqN3NVMttI/UDf0
   sXhCiSUKT2arU1br2jnV30bEfOMv73ayhrIcEZMorL6BwArlHURf0UYrO
   LTjO5/YcdOQNWmaFUAOlu6JArYXwt5sV69UEzA/d1V0u7Z+Ic7I0/EKmN
   w==;
X-CSE-ConnectionGUID: vwG0HCW4QNahxi53oL9xfg==
X-CSE-MsgGUID: i4pmHb39T3q5BCVlhNiwSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="846256"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="846256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:17:35 -0700
X-CSE-ConnectionGUID: fRP+NRpXTKyJ6Ahk4j5sDQ==
X-CSE-MsgGUID: vEW3fLVCQzCWBgmtYtj9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1671774"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:17:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:17:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:17:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fupF+PalhU65aKSTBsyeo5+hS0UzXjrhgnrSqDZtMRwhJ8rNvYXEfcWgmxg4/oXPJ36yZ4qTMrvDJw4LX4dhL5ycLJr6/94OHhuJaY6XmhbXxy91XRb4xWglB8Fdaw3VcugQLAecMWI5hgIJxanELUQSasLQ37xFRu8HKsP65yfn7o5FtwaXvADkODWz+bHA2W1pwHo62d+430l7dA8xwgPoOb/FgD73/YiTE7kL2FmRlf4huP9KL9cL/n/TE0vq3sOyrpzorsaZD+ytOy1OEj17Yx3hnvF34o6U18mqoW6bhMqMgVz8mmP6+JvQNfH05HSKcWsp3KjbkvfDkA+L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FyAvC7K9+hJvXC0zIk0oRezauA/X9ZHmN1U8dCRC1o=;
 b=B907ukul0/Lxeh51K5sGKLYcyOLFCxuJNSo7S8ReLh76aMnRKo6vnJ6COPxuaoWFpjTWhKjPZ9lM8d79FOTIOIG3WPR+0LHTH4a2EVq0tTwAUTYKTwRlCOGA/IEOT0b+GbAIbxSMs/aaIq2yGlYSAj+SH78HlcYyBxPsteBZp1j6FtMX2OBV3lZhNd8j2rIQpfxxX5MP2GOD0iaLSOdfcGilWTnx0KqDi9fxrdD1NRfIeLVkmAayt88hHUlCg+EpM5chVpKxJH4yllYOdwLf2cN5mBPBTtkNa8j/sQYuG/3Bk31Fy55h6gMZ/5fb+BZRLAh45hOz8MjhGusUeZciZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:17:26 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:17:26 +0000
Message-ID: <5c10567d-0092-401b-9fd4-b0b85485dc44@intel.com>
Date: Thu, 15 Oct 2026 07:17:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/18] x86/resctrl: Add PLZA support to command-line
 options
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
 <bc2e144788fd42fdf2a3b4920e3d9a5b79c175fa.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <bc2e144788fd42fdf2a3b4920e3d9a5b79c175fa.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfb6700-00ff-448a-957a-08df2ac7099e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: W/SjMfsCx92fcxUV0apzAY2xuNFBw2K0kkep0Ivh6IU3aIzcs8XHMaAAL8ZHuERaGbpeSp7l2S8WZxKFGCWPrKnHDFMmap+RQ2yl9VLxc3jX0c7YPr7XBETPI9MEzcfNllO7y0nEaG95v2aiOuZwGjlc+wojkjC1QNA+9N9/FoNTMPlTnn5KO9wOZIKmQwJZonK6yxXI6Pw830FU9doCnF3M/xc3NGKvZD/Mx/J1mgm1VvJcb1u1ybVcKumPw393eVcSJHvmLn2hSJbBlFI5VWF2BH7/GEOV4a66ekOHxhmOieS9aLYLm5ARXPEc6tBN3s61ydvt0wSYRxYDPdyDkHIVy7QJwR3ut5W1s8oQk2wJld2z41ooACLXCHNMnmKhJIEOwNBDfXe7l/in+pCz8oMXrXBNucfm+IAs8iE5GayAlpS9UhgbQDjVkdyr2/WLhElkqPMDCVFInYPVDmcUaXalzTRUIZd/rPkA+8P3FwQIU+H/FhNEAxc6MNxXe00ftW0HfYO9h+5puu6QoVVx8Y9IvcQHtcOckJAGfdeq3pTiXvebaopTdxiFo+EQQkY2wgT0lliQiPUqhQDjtCPhv64n6L1Jm6RE63xvQn9fKUI1t4NAUP9FHs4k8EE6OGdMG/w9p4tjniTQjbz9eyIWCzoTs508im8ug0g7fBdYg9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Nta3pZT3lYOVZNcm1zckJxbTQ3QzlLamwrb29YYTNidmFoMGIyOVdNVnRr?=
 =?utf-8?B?ZWxzSVNhR2hpNFhleklqRzhpMnNjaFIvK2MwRnJQdnlqbERMNm5xbXRLalRr?=
 =?utf-8?B?UGNHR0NsSFp0UmRkV2hhaXBmQVVVTXdJZG5rM2thRW9Vc0JNb3owYUNVSU1Y?=
 =?utf-8?B?NnE5M2R1dC9CN3A3LzlGK3FlbTl1dktkSzQ3eGYrUk9zYVVpNHZSbm0wUkpz?=
 =?utf-8?B?RGZESmRNbjR4azlXMGdmMURxSzJ5RHYrbG1tQXRMRk5FQnVzZlBGQnVKWnFX?=
 =?utf-8?B?RjhCS2N1Y1dqbytJZTExRTFqQ1cxcVRrd0xHUFJJZzIxcVpHUHhhcTgyRFdY?=
 =?utf-8?B?ZnZTSW5lckk4NmZ6YmtWQnpHQnFLa0tXajBhenJhb0Z6RDRaaE1TbmNncnpP?=
 =?utf-8?B?ZnBiazdiL0o1TUxld09JTjU3bkxHOGNZVzVMOVYrbXVaMWExeDJZU2M1VWVq?=
 =?utf-8?B?M1hPWnNLZW1mUWxRUUFHWDFKTnVWdjZReGZxUUYxL3JpTTBtNkNGZGNldGFS?=
 =?utf-8?B?YXlPTklJNEhDSjFueldydmlMSS9QRHFDOU5sdFJMeWZZQkQ0WnlKUHExUnNs?=
 =?utf-8?B?MXlHYmVIREFNT25oS3A3NG9TTWdvQ25XK0tHaEtnamRucmJLYnFaLzhVckw1?=
 =?utf-8?B?L0ppZlp6djhvdmgrSk9CSExGYWlpMEF2ajdkbjBTUnRzZWtRTEhlM1BackpM?=
 =?utf-8?B?VCtpK2RvZlJNd1I3UEtydnkxOFJFV1lDMTR5WEo5cUo5bDN3N01JQXU2SjFv?=
 =?utf-8?B?bDNJOUY0SUVGVzVmejE0YWhQbmtmQ3lVNko3NEZyRFY4dzhPSzVGcW0remV5?=
 =?utf-8?B?TWRZRG5qcDFHNjVZb1J5ZWxhdEUyS2htandqRW5MN3FpNzFIL3dCYlZTazFl?=
 =?utf-8?B?T0EydForeU03SlN0bWpORkowZjdGbmREMk9YVnFWTXhHd0c4dWFrZHRDZDVU?=
 =?utf-8?B?QzdCS3hSUnNsMC95SXpEMDh6WC9aY1ZVdExDb0RpZ1VKVXJzUnNFZDVXNW1L?=
 =?utf-8?B?VzhZdFpBaHFHVkNtb013ZXo4TEw2T1VXZTBIN2xUM0pPYUJPZ3RPMUg3UGVF?=
 =?utf-8?B?NTVtNkorVHdiQ0YxS3JjTjZDcGRxWmFtVFBPd3dkUXY2VTg5OGsvcnBkUGlC?=
 =?utf-8?B?SnE4VkNTV3hkemxzRVhPUkd5N0RRK0lGVDl1SVlOSTk1Z1ZrS2dEcVRodnFR?=
 =?utf-8?B?UnFLYktzQ0JZQ1k4NWVvcVZzZVhENDdrdlZnTnpCTFdLVnFJaEtNNG9nMGsy?=
 =?utf-8?B?Ky9pQ21XSUlKd0Z1VGdmelptTEpHTitWYWdqQTdrN2VUWnluWHVueUtmeXBP?=
 =?utf-8?B?bjRZeXd2c1A2eGw4WmZmcFI4dWJsc1NSZ04zQTV0UTZSUGJ6M0NpejlZUGE2?=
 =?utf-8?B?Tm1UazRqRTZYOWEyK0pta3hadGl1NTNwL1hUelRZWUovSlFuTGhoUERuaGNN?=
 =?utf-8?B?SW1RSGQwY01kcnFadmVtbXltZy8zWVgwTjNYN3h4UUxhYUdtWTdKNzk2Y1Zu?=
 =?utf-8?B?NEZwYkZlUEJkRjFzSkxWV1htb2V4R2Q0WGRmN2UrOVhRR2Q4YTJ6QWM3NUtE?=
 =?utf-8?B?Z2MyWms1aWx1SWxCdC83NUZ4TnNGWHR1SWlKM09ONmVlcG1QOHNmWUNJSytF?=
 =?utf-8?B?YWpjdFA3UEdqRVZHRXczY3YzQllDbjZ5R1FBb1NQZlpjZlJ5UFZKUmo3QWd2?=
 =?utf-8?B?MHNkV2UrMStpdytWZFNOSUQ4VTkzWWFOQWpSWEQvRUcrT1lBOWo4aTRCaEpq?=
 =?utf-8?B?RzNXbnpKczM2UHE4eWVyd3VqZXhuY25FV3BndFV6TnNtRVpBUjB4RzhPOE02?=
 =?utf-8?B?M29XNzlYVmtUU3ZQTUx3U3FCejFOMEQxTFc4UGhhclZGaGhCdW5Db0FEV1d3?=
 =?utf-8?B?S3VPVGE5c3ZBYnlyRFYrMW5lemVxTy80TEpOeFBsbmRybnpabEVLaWNhMHRT?=
 =?utf-8?B?TWFxR2ovejB6VGxQNS9OM2l2R2dvNDgvNkkvTitHcllBUkFiQWZ3Mk5RY25m?=
 =?utf-8?B?d2ZmYnY5OStNWVRoU1BtK2tkZlpOM2F2NjBRRGtkUGVkWGlVcjNrRzV3bmJn?=
 =?utf-8?B?Rm1RMFJJd3p6bTladVlnbi9wK1YxSy9oMlhiZG9aclE1aVNSVThuZ08rMkZH?=
 =?utf-8?B?S3ROVkJQNHcvNWkyVmNVYlIwenF3RnFGUVU0YlZGck9tR2hDdmlBeHJmTjU3?=
 =?utf-8?B?U0hhUzI1WFlCbkZLbVpnUzBuN3RhTktvM1hzLy92c3dCUHlRTi94T0ZITHFU?=
 =?utf-8?B?M2REOGhpUDZmYUNpL1QyNHpEcVZDbkkwZGswQlpSaFZNUUpWTFNPWmtUVTYy?=
 =?utf-8?B?ekk4VXZucnV0dFFkM0ViUkQ5eVVoYmYvbjRuajdPSHY2UGxBZk1RWkJqelJk?=
 =?utf-8?Q?lVjiT1jFhgRO6mm0=3D?=
X-Exchange-RoutingPolicyChecked: ojegegy/TdrdRgOgWKGeqvf1ucHGubn2BD5b+Qt8bj6ushuoZ0XuA1Y+ejnKQkrPfhYhFAy8lcXvdlpAilGxxswk+tFvokUClB1Rk07z0Fo2KNCKcTItgI0EKbBVnUxSUOht24V1/YS/EbA8oQw52zFUGz1XcrdjGQQTYyA2lOvm4ntgl3YNmRqy0aEqYbY4jDwp7DqZquPmcLBtrfOb/IZk9Ah0JODjIp0ezIbbmgItKwKRdQ4+eOxPEgp6Kd2e03CazbdpZfzggD733sxxjkIQSiVKtL8yea2XSiyMTqJwMW6866VSr8tZXGDk0W9AqRRYRDFhuHeSAylZKVPjKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfb6700-00ff-448a-957a-08df2ac7099e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:17:25.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pom6S5/c2c0Ctz6Z1Eb7gBGLt6w8/MHDVumSXnk7ekhPgZ1Pi8FGvC9HChUoyfGvGtBC4WQQfNgOEX/baUHMwB8bX/QIfQ/5X/A6mKPuvAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> Add a kernel command-line parameter to enable or disable the exposure of
> the PLZA (Privilege Level Zero Association) feature to resctrl.
> 
> This allows administrators to control PLZA visibility at boot time via the
> rdt= option (e.g. rdt=plza or rdt=!plza).
> 

Apologies for not being clear in previous review. This changelog has a
lot of repetition. Above two paragraphs are redundant, paragraph below is
sufficient by itself. One possible change would be to spell out PLZA in
the paragraph below. Spelling PLZA out may not be necessary since it is
spelled out in the patch self, so up to you.

> Add "plza" to the rdt= command-line parameter so PLZA exposure to resctrl
> can be enabled or disabled at boot. PLZA is exposed by default when
> supported; rdt=!plza suppresses it.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

With first two paragraphs of changelog removed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

