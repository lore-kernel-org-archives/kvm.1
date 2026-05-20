Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454793FBEAB;
	Wed, 20 May 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301532; cv=fail; b=WmT4aYkj9zzINIs8VNnx1GgN9WXdQlZ1tChc+Hholqzj32DzAjbr9+ws9nFkktp04I1flPR47XlXsWEkhTDvAS/UvBpBwwEIoiKATZSbtfMLO76b3dO06frvrhZ95k8NpZzoVixHgQ5uen0yWU/ykqJ12dDFfzTNrW+7rrtYMto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301532; c=relaxed/simple;
	bh=N0XAlbcXYX1HgJ8iKId72qGBp6V4oBYSNTS0sFn0MG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X7cs6DkVHz00WBhJY54dsLkIYwhu0GzHkJdJJyxfhCx2e5uRv2sVnNbTM1LfKARtC/RfOuXYhYIb93/6kmJdjOX54chqzyyyRV5mwhLfcmxCHN8MuEB/sR6kYHCJbd5iSA2PLixoXShEyVeA8bCqgr8CcGbLi3mDSfEjI/tOIZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBpfu/m1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBpfu/m1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779301531; x=1810837531;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N0XAlbcXYX1HgJ8iKId72qGBp6V4oBYSNTS0sFn0MG8=;
  b=WBpfu/m1fN6NiAXhsgDUICEZwU81Jdk/5RX7KIHwor+ZclBYdYGsZdRw
   94v3s66UQg+2J8A1FMFYnmllK8oLGHzfRyotksG+sWXHko0rzIbTru1wk
   rQoIYv+D0WZeEcinSabgOBxM7cN7VpBMb1OoybuxBD2r3RVU+i5m22ggY
   I51kBk/LyyHkRuFYcbNivbDUWmAE2MlszB5desgCGZ0zAzWrVaU+tEXTY
   hx7rqxIqxJH0nphzTtH87oBldZprKoAwCiDLb45rypumFDWcT8HSAHaKs
   IJT5d0yzD9yV93ClNLyuo2xw2DSAoKeq3lmMsRWLOJSk3Y1//PjmPbjaB
   Q==;
X-CSE-ConnectionGUID: Ktgm1TJ7QsmlLkay4fUlWg==
X-CSE-MsgGUID: VUH0fNvjQ2a2pq7nhqjq3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="102888585"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="102888585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:25:31 -0700
X-CSE-ConnectionGUID: cCEYyZwhTI+GyP1miqa1Yg==
X-CSE-MsgGUID: 0txy5ddAShiGSDvMuotozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237664293"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:25:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 11:25:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 11:25:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 11:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNZt+o3QM0PhKEV4EyIIks+vdBPXPZX/7Sj6Xyvmp8N/0Vg2vHNFOdWWMh6fFbGTXNtyTbognh0Rbw64k2Trdqu8moZNsxgFKTTTXOGlY7XY08dhqBz84lmzk+jVJyHyvAY1U2dMNHxdlb/IOeCnCzfWk3o68d8XBwx9+VvCmoxEYVEK4fWD4WW3YKgxUBMZU8oMreYI7T8oCAI5dJ8S5sGWtEL9HXlOfQFTDxXNTkXPndh914HZuNk4GaPtMHQ9e3SEkp9+r3Nn++hxfcQaP2yol+CQd7ZZAC3+3ICPND+cgG36quatqi2srEoeKxNis8VchaHkbuDVEIJFLop3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPkD0oXEMB+J6nkyvfmAZC/IgUqP+0rDgQugLyFHWCM=;
 b=eZy69b1XiC+AJ+v6m0OxfosLgmaqLh+wwb62iGBxZffUt7sMbtgpGnbzon9e8gFicNiifKB8KDh2IdtExzFOyvCHEiEQCh7K3UsNjpkw53bChexNuzupUVG2pZRgbGZ2HIAMg3C9g4S+jz8b+6w8hTu6E7Ez/LwLN+mdh6BpSCCX9QBQIDhCXuVWAZDkhF9EIjWjWzyD8AaWcOeFwk6GK5nTRaCDUmkDEyVwghu+2ARd7o7TRM5AeBtum7RpdCuqvc7amRWf7gG2UZW7ZKJDSdwyOd/uLnOUxqP5WtZS6pK7Xpg6dMwLqLOweSGVf7ETn/JYIdHdAJSHFWnOsGxR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 18:25:21 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.21.0025.020; Wed, 20 May 2026
 18:25:21 +0000
Date: Wed, 20 May 2026 20:25:16 +0200
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: <zhaoguohan@kylinos.cn>, <kvm@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Yishai
 Hadas" <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
	"Kevin Tian" <kevin.tian@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Message-ID: <ag36468dHJmhqfGv@nostramo>
References: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
 <20260427012128.117051-1-zhaoguohan@kylinos.cn>
 <20260520112220.274025fa@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520112220.274025fa@shazbot.org>
X-ClientProxiedBy: VE1PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:803:104::46) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: dae09414-6e6e-4043-b6ff-08deb69d26d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 786NwGYv9srggmBTFsWQjAvigfyKl+sQM/wsTAMSVLg/uHqJDRDYZM4zr4WL0OLlGQ+wzd4sjProxKprfU7H3dW8mU8zQ0YE2UyXOKify+DuPTtZgvYRvXMRU0xFWAhnw+3tDGCSzs3kYzT7o5bt7QweTBsVVKswx25hIlLjP+OfAr4N0GkkhD9sta9aWbIvoZb6k/2DkqiXGc4/HgUUtWuG6JDKWPzG5N9W1U6pPxHwT4sENIMZWAYKkrN8Jv3TCRT/ysWqXrdExmefUVsXI2FDhIg4c2w6jfcTpQXBj/LeFZfUPHhmVP/O/lp5PuFSA64uqmX4q0rN5oX+GTJDCq7iapErYmf7IdkQVqW9eu70a5OmINevWARWTA0B9NEwrCs4ojYZ5k8pyBgnY0Qu4fkoxGKMSB8Z5tEad3e8ukhiZ16S/BEaaR1yE3QDaZWGVa0LJyIY2aEQvzIHQKoAqXRqcyyzOn+57zCieb4lfmqJA1udy9OHqIeLgudGVm5NQIgEeDWY0s0WcyoGGfBwxUUx7Nkp21j3NmK4xflfXS05HUxH9sV2UykXxzcE8oo9gfsIAOFOE7gwGNzQN1c0h5ZzhB4zHBt3A/XIWEVl9sYMjPvDuTPzDR40hpF1rM9YRK0dhMnUqUUh3Rh7SFqWvU9gZxWQ9SpSt8wJK4fO6Tz0CG+k2YVft9tRvPs9ZQKh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdYWTVNNHNLQVRoZ1FVTDN1eEluZkpvTzZDWTI5WXhNRjNMbmhPNGkySFNT?=
 =?utf-8?B?OXM0Mjd1b0VHSVNIQXRQb1ZDbkdzVUw5Ym1KQ1p3ekUvU0d1SDFxNGt3dGcx?=
 =?utf-8?B?RlVQWkxFS0paNE8vVlhqN3hkSSticUwzR0lGTmVDMVhQRC9xVVgvNTRPUUk1?=
 =?utf-8?B?b3l2U2ZtUlE3R3hQTEZsWi8rVU5KV3hvRVZsV2pJbmRFNWpwYjFzMUJ3clhE?=
 =?utf-8?B?VXBCUkNoWkxHeGQ5MkZ0RkphbTMrNkdIR0M3d0xaV0Y5K3A1MVg0cGMzRWdo?=
 =?utf-8?B?MVNIdksyd2VHK29wc0U0M2EzdTNvRFJOc1Y3ak9KckhMY0FTWmZSZzFyMzcy?=
 =?utf-8?B?TEVTMXRxckNnS05GQnhhaGRtVk02M0ZwcTAvZkZVb0ZPN0pGWTRKRXVhZ1oz?=
 =?utf-8?B?a0NzUTRQbUQzaGFLU3VjRXZYVHcvckpPVktEQ3pqcEE4dkFhckU5VkkvLzM1?=
 =?utf-8?B?V0V1VTVrV3FpWHBMRG9XeU44WG9vczE0VS9nNHR6UWFUc3RVYWh4VkUxWUNY?=
 =?utf-8?B?RHhCbUdDQVhzWjZBRHBwd0RkdmsxNWFDWmNqWGl3Yk5DSEEwZXVpZU5GMWFV?=
 =?utf-8?B?bXNwRGlBSUpkSWkzdWdoYUkzc2lkNnJ3dkg3TjFsWVdKSkxzQzJ4cXErOWVj?=
 =?utf-8?B?bGZIY1A4aGFKK2xadmlXVkg0WTk2MGxOODdmbFlpMG1tZzhIY0trZHlMYUlX?=
 =?utf-8?B?MGF4bnIzRENzUE5BWE9MM1k0RHlMOWdXbXZJcGJ2ODJXbE1QS0lKUUF0WURL?=
 =?utf-8?B?cjkvb25BVW1tMUVMalpWYUFiUWtaQ1AzN25HOXQyYThGTzA4OCtCRFd6RnF6?=
 =?utf-8?B?TC8zUFhicHhPczBCcHFJekp3UTliOHUyYnJ0ei8rVlJROWRVODFJeVh4SFc2?=
 =?utf-8?B?VlJMUUxSZWFZTWlHTXVsYnlZZllLLzZ1R0JBWEdWbmJTS2NlTTRuZHhkM2lN?=
 =?utf-8?B?OFFhRUFGZHBvTkQ2TEoxOURNVjNBSmJLWkt4d28xeUhuL0MreDk5eEp4QUd3?=
 =?utf-8?B?dUpjTVdPcXVyWHN3cVNIU21FMnNyRGJyQ1VJbE9tMTBoNXNGZUhKK09KQXpu?=
 =?utf-8?B?TTBtem1YWVZPS2R6dFFpQ3AzOHNVdkE3WXpsZ1dZWU1aUTRHN3NPSkptNlc0?=
 =?utf-8?B?UEJ5VDlYWWM3aXZTMmVsREV1Qm1Zcnk2Y05tTGUrdGNTY2dHTE53YVY0Nm1z?=
 =?utf-8?B?SFQvK3ZiY3c1aUZuaUxNa1drN0dYWm5MZW5NMVVOR29ybzB2THhWN01ZVWVy?=
 =?utf-8?B?ck5LZGFSOVdwRG80WVp2bG1HbjZQK3pLa0tGNHZhM2JYZ0ZOc2p2SzY4eDF4?=
 =?utf-8?B?R01BRU1aMzBYQzdxUjd6M1NldTRFZWh5SzZWZHR4OWZFSHBXUkJFdTMwN0l3?=
 =?utf-8?B?a05LcW9nMmMzaXNhUWZaeUhZV1lXMVFJUWs1Y2p5QTZJeDU0eG0zcFN2RU9z?=
 =?utf-8?B?ZEVBaStQRkFiMnA4VGlwRmUxMW03bSt2dHVPSDFOUEI1TnJGeHRhWHNFR29M?=
 =?utf-8?B?RmNPZWZ1enBoVUVXUWJsTitkN1dNdWxHZmFkOEcwVVpnajQ2bU90RGtRdElt?=
 =?utf-8?B?cGQyNys5dkVLMXZXdTl0RE1MSWhBcnFTZkVQTElwaHQ4Y200NktxRkpNa0ZO?=
 =?utf-8?B?NUVmbVdBeXFISUVxKy8rOStkT0x3SjlsUTdnK0t3L1I5WjBuaXplZXRaNFEv?=
 =?utf-8?B?T0Z6UGxvcHlqVk5RKzN6NkplOTBBMUs2clVSdkNxQXR4V0htbkEzeFVCTERF?=
 =?utf-8?B?bGtaWnloK1VrZmtnWURJQnRteHBsQ1JwOVRTemlzUVJwQmhJdC9aNi9DMTZ6?=
 =?utf-8?B?RUIyVDJaR3FKZVNrMGpMamFHOCtoTHp4bkc1TUJpOUZkNmxjRGVzNDZEajMz?=
 =?utf-8?B?N01zMEZLSU1xS1BVQVRKc1I4eFFzdjZtMDN3blVqZWFXbzNCRkJxUWhWL1ha?=
 =?utf-8?B?TmE3ZWloWW5sNVBiZld4Ym83UFJvQ3NscExEMVpwMG0xdE1uQmdEUk53S0I0?=
 =?utf-8?B?NHJjTTA1R3E0KzRqUXZsbVZnTVZoU0VESlpzeDJoSm05YnVkdkdrVG1NdjU1?=
 =?utf-8?B?dlVMazdhN2wwajlPSTZyVUlLampKaFBNbk92dE14UGVaRXplSTA1R2tJbkVM?=
 =?utf-8?B?V2lMVjI2Y1YvU3NGa3pPeGszRlU3dTRnMlhYQ3VZV0tNZVFOdHZxb0RlSVVM?=
 =?utf-8?B?blJSZ3hjZU9QWUZWcjZZS3FLcmxkM0RhRFdsRTliS2hGMWFJdmx5WGQxYWRJ?=
 =?utf-8?B?Q0hNMlJiQ05nMTlJbmhZeDgxckRzTTFvbDMxMDlrK20rczZJamtxR0FTbk1x?=
 =?utf-8?B?MzgwM3RPYXBraTNOS0x6bTl3NkFpVEdTcjk0ZFVWSXZGaW5EWGJ1dTgyNmQz?=
 =?utf-8?Q?sEvCg0nefdExF8FA=3D?=
X-Exchange-RoutingPolicyChecked: T0dv1w+NCmByk4mt3zGz5MD8UKCEcLaborY9mLM4yr/YskWaW6ok9GIYoFsI64YVvGzX9PWSTTQ7U1d1IO1JMKYfBLe/AJMoM9A0L9N7rmTS4Ej29pFRsRDapkUXbgxuQtBZGCIQ4/vZ3VvKMtOA3y4j00fL0o/HjKJ3jvqHOy1WbsCP3FM+JjNgg7EPFlP7MUDHF36nFbpIBaP3ckvQ9j1SAOoXThFZEYA+BQfYQ0HBEEBEP/DnYYNL9p9rHUgVmZmNZd/6FBzg6posHCvVyqEJpg0hm/kH7hnxYHLNi7l9BlxX5jKaI8Ovks4cZ/7bEDm7RU/rSTZXCqRwniaJMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dae09414-6e6e-4043-b6ff-08deb69d26d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:25:21.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woqT2QArSTQKk8l03qupOn4FAnHIo8QC1ENSuf7e8OLdQ0guOxy69gIPFIBfTKkommBHPifzc/nSelBIl26cICuCXosdMRtJLCpN9yxK1cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

On Wed, May 20, 2026 at 11:22:20AM -0600, Alex Williamson wrote:
> On Mon, 27 Apr 2026 09:21:28 +0800
> zhaoguohan@kylinos.cn wrote:
> 
> > From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> > 
> > xe_vfio_pci_reset_done() sets deferred_reset and, when it manages to
> > acquire state_mutex itself, hands the cleanup off to
> > xe_vfio_pci_state_mutex_unlock().
> > 
> > That helper already clears deferred_reset and runs xe_vfio_pci_reset()
> > before dropping the mutex. Calling xe_vfio_pci_reset() again right
> > afterwards repeats the reset handling unnecessarily.
> > 
> > Fixes: 1f5556ec8b9e ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
> > Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> > ---
> > v2:
> > - Correct the Fixes tag to point to 1f5556ec8b9e
> 
> 
> Michał, any objection?  I'd prefer to include this with your ack.
> Thanks,

Hi,

No objections.

Acked-by: Michał Winiarski <michal.winiarski@intel.com>

Thanks,
-Michał

> 
> Alex
>  
> >  drivers/vfio/pci/xe/main.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> > index 4ecadbbfd86e..cbff5af385ef 100644
> > --- a/drivers/vfio/pci/xe/main.c
> > +++ b/drivers/vfio/pci/xe/main.c
> > @@ -135,8 +135,6 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
> >  	}
> >  	spin_unlock(&xe_vdev->reset_lock);
> >  	xe_vfio_pci_state_mutex_unlock(xe_vdev);
> > -
> > -	xe_vfio_pci_reset(xe_vdev);
> >  }
> >  
> >  static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
> 
