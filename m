Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626AEEC0;
	Mon, 29 Jun 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756694; cv=fail; b=Li5YxWkwZ8F+Q9H+Yvtr0rULOYzpdPHlZEnSIqOKTo+nt4D24z8WwcP6Aj+ZU8aqEF85ixyvRQK8A/CwOs8xMT17vNZsE0HUce5EfyhW3jKFKJtX8+1hyM1Z4Djfvt+ucpMZWOtcq8bBHdHzkeIT0lWD2gOVbrhki5sqzqNkrCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756694; c=relaxed/simple;
	bh=jnfW3XsCpccWgNd/79210U8SEIf97eOk4okkByT5ch8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMR+1oP27KMwoTg8xWMSHOUxCuuZtZBM26igmXsqQ0Y/SaOO6sLBDboJMVHZa/70nZr3dMPT0lsjYQjqSwRwXgmV7VprSfug6cn7aShnQgFLlx+3AP7tPqNKzJWcBHpb8ot7EWrPxVx5Ch6md0uw6Uo0CCumEy+si7HRzW2n3fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2RRq8Fv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2RRq8Fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782756693; x=1814292693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jnfW3XsCpccWgNd/79210U8SEIf97eOk4okkByT5ch8=;
  b=F2RRq8Fv51cq/Z+MpgwNNmzh5opEd7xDfNawAnKFdH/OqGW1t9fCIjn6
   OV8T+kZw/HjMzXEsV/O7kD8YYFZ67s7iUQy1s2kJ2Wbgcs9t+SH9knvCu
   pkTMKL8UD7HSMNktyICpf3IyhxCipIJ95efJ51qV9VCwYDkASmgmDBAQ6
   s6N9+daHluFbMMSr2M6cXMw6aUCmAfltH2jYzP/AQEQ8m5y6Eu/xPuK4k
   MYvOH0aaZl7Rv2cMoSk3J/7U4M/t4vH2ajlvDzoiMNKST4zo8YSKPb9DP
   m2VMR51PsDgPOAA6cFsVabA9XR95XqArx0qXlAavWF0aoWIW88y87JLgB
   A==;
X-CSE-ConnectionGUID: H60r3HUqSFio2A5XPcdizw==
X-CSE-MsgGUID: 5JCNKW20SE+MDAZg9nOv6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94113136"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94113136"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 11:11:32 -0700
X-CSE-ConnectionGUID: 4/xTlEysQ/e1a1Q1533PDw==
X-CSE-MsgGUID: 9HdJAXkfTqaoXhYQitXGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="253939160"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 11:11:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 11:11:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 11:11:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 11:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ+fEQbBNrKfj7M+2GXIdlrb0RqGpQ6W5DAecTT+92/1jRqq5oRlAY2WXb41sF6Jf0Qtby0Vc+1hVbXLm73tZDwOkckAcP1VVkYeG+T/55V03syh5JsmQorljOB1CutpZYZlVgfpF7+odNjZkTG6kW0vgZEVA+l2S0BslMiCzJxocBchsY49zew6bj9TuyVnezhKM8JYbOdKh0fXQVqO6qwd+s3UBcAT1pNPIranx4zgosbgEni83X+400jTlXsfpQOkiaskPOJEoHQtBssnlZ0DBlsHJHNk5pA4oMLAMMJ0mqDbQ6wWGDgG+TxhHmSnuZm/sSGhS/Z3juvhvauY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnfW3XsCpccWgNd/79210U8SEIf97eOk4okkByT5ch8=;
 b=omQMqLNl7Sh6n8DyKpDRLVXTXg8/yOnljEo2lV1sPLhHc6yCfqFpBw0LngToBa1FlJEdS9V4CiyFmjjBB9iJxq0UXDW/YwzXSDqEplRtmyy+7dUk0TVbZmc6pE6UiSMQHa+Xr1oBFgklsS+dA67Is1x1AeysRLwxmlUGlWquXQJ2dXobkcqrprBpcpaaHo2RaO4rRMqSj3uCfuc/EF8T94zhHTkoaK7JT0qfo1abkCN/a6rbjQSOK6U0FeB5tzU/6Ea/ePLtsbshvlyYz1HWQVhX4Ei4U6UfkJQP+pkUvaAZzyBrD2rmiHpNgkm8Urm8XVx5oDFzcRetoy+hV0LLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:11:27 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 18:11:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "djbw@kernel.org" <djbw@kernel.org>, "Fang, Peter" <peter.fang@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Thread-Topic: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Thread-Index: AQHc6aBCQK9jyx7Br0y5BNUfodkS4bY7u/SAgAIVtwCAGEB6AA==
Date: Mon, 29 Jun 2026 18:11:27 +0000
Message-ID: <d862b418cdbc9b55c453038184b7a438f34e4da8.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
	 <6a2c9d8b8bfe9_9b85510018@djbw-dev.notmuch>
	 <20260614075026.GE3200182@pedri>
In-Reply-To: <20260614075026.GE3200182@pedri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6344:EE_
x-ms-office365-filtering-correlation-id: 2ea3e4be-f7bb-4567-6c5f-08ded609d659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: gmyKDgjPeDmhIZ9DbT6cB+s8YZicv0il4IELiNCK86V/FBJfRE0qQHXhutXysCxtCfdGBuhfnksyGKQOGDQ29BpGo2TTfToGSLEkx0s6kTfQ8K5mk1+7mwro3LJyt5qe3F5RAJmwtWtUlkPqsVhTzjzBwPS7pOGWU/hy5TP21HnBXeZg6Igv0botzSG4vlzRMMYANr9K8f5G1oAxhrST7EjZ1xjMrRrUkQ7NflTMbBGXPZ1AMHTpmtw64cJ7Opm8l7WYSKSysGXVUtyk6/erhQqPqoV17Zzyz/wzSR3QnYpIOx/tty+NHn/KpRIAxMbIPDeLIrGHUQ8TGr/2rTGHSXyTWA4/2v3ufDfFkw08fq+sTNqjq/vbI4BkAwwGgFxFPrJjLH870Vla7u9NVmN8ktVklwCb1MftH6+k5tsAPHuaoyGnc24wNdYsQ90YbFnr1Motyb/+ZRA4X8GeLD6djTMFPwlBw5lZjQToT/SElj1l5ginVMxxjuuHi4/MPdl5rsLJz74OgR4kMKcv9bRPxXXWKRHf5SDpRnwr0aQWZx2Fg3yqGpgGXNL/ziooXA0nXbLfUWg0irIHl6BA5kD41Cjq2HAmjx/eGrNVnx85eTjwGfRVcAjZWlp7voiFRq76vZFaKFa1m4A/oMPAunFaqxhKGvyR1Z5gTGE6lNeJtkIKk4LYPpGG1gdlEAyE2vw+U9bzD2pcyJ7B7mF4AcjOAK6UNfQeynp+Yb5ykaj3xpM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWxCOGpEd0xTK2lWb0FIbUxybE1tRjNVL3dNNDh0eEFjSHhWLytueFdFa1pL?=
 =?utf-8?B?Q05DU1YrU1JWaXlGcFUySnNWdDMxRlZmUXU3V2ora054cndjRm1FbWdFYzNy?=
 =?utf-8?B?anJMaU1IN1czcjNNNFFJaHR1bEtCMGdOQmxweE5uOWlOYTFUN2RYbktxbzNq?=
 =?utf-8?B?WEd6TWVXbGpKNldVYmpkRjlDYVk0VGRUbUlZTDdZcTZWSytwVGNQWVdQdjVM?=
 =?utf-8?B?SDRXN2w4V3B6d0ZiRHdRK1hzMmdhcnZXNGR3bVFwUm9rZmF2SjcxNW8rQ0ZP?=
 =?utf-8?B?b3kvcEZ0VC9PNkxFM0lMbkd2SnRYK3pLeW5tSEJ1ZEs3cTNseFhRd3d0WUtj?=
 =?utf-8?B?RS9aUDJacFNBbG8zUWl4K2cwOHRHbDZFR2JQdnZqSkhpNmJydVpteExvSHBy?=
 =?utf-8?B?WmlpTjY4MHpUK1VkVkdPVHdSelJpMXh3RThRVklPYzdDeUhWUmhRYzAvTGJm?=
 =?utf-8?B?ZGszRndaUWhjdFMvREUyTndCSDhGcXg5bWRidS96VkgxdS83Z0dwbnFVVE1Y?=
 =?utf-8?B?MXp0bEN4Z2Q4bnQzOTBFSmhRRTdSZGs5RXI5Z3ZzV21QYlhZNUpnbHZ6aVdh?=
 =?utf-8?B?VjZqTnk0MFB3NWU4MnpYVk1IT0p5V2VRVkVuWnZyUlMraCswclZoVXJMb3ZX?=
 =?utf-8?B?ZDFXU1cxdnNLNk56TEJHRVVIQWxUam9ucGVDQVZJQnVwQVhEVlk3ZnJzT2J2?=
 =?utf-8?B?L3VpVkVndmdicU1EejV2RXZaWVFuNXdmNmVOUTNXUytPM1pLRDd4bEN5cENj?=
 =?utf-8?B?VHlFMGpMZXpnbU45aWhkUjM0anJ1YmRuVzljYWdtN2lOcHY2WTh6NDRmYW1l?=
 =?utf-8?B?NjUvRDdHV0ZmUnMrT3Zaa3RLem1hcWlFbmJMU09JNG1FcjZEaVRLL0RCZ3dC?=
 =?utf-8?B?aFE4VW9uZ1JrQXpzSGFGTkdXbHU0QlBsUUd4NDVxZmJmUE9DZ28rYnRJaGZy?=
 =?utf-8?B?eGwrcnc4dlRlRDdRSWFxSTVXUzZmQ09UOE1IU2t4NE9aZVNkRGV6UTVLeUtW?=
 =?utf-8?B?Q3dwUHpzdzc4bzFRUzg0b1FGTmJUYzJRdlFCeGhtTWZtSEZmTGFpaGU3UFdj?=
 =?utf-8?B?NXpKRUtiZzUxUVoxVHFoVTNmNC8wNWRvZGNmQm5MVGVMQ0x4TmpXMlJjRndv?=
 =?utf-8?B?SGJsRkRTR2dLMVZoY1Fsb2FYNXdpTGtmVUpGNU4wRjhndnJVRE1selNENHRR?=
 =?utf-8?B?NjZtT0tNa2NFdy96T2RVYS8yMDdCSnoyQUw4bkVuUk5LcXMzTTFvRVp1cDZz?=
 =?utf-8?B?aTU2cjRkVzlZcEhpMjlIYng0RUtteVZaYTlxTVFBVzc3NkM1YmMzK21PQ250?=
 =?utf-8?B?dFN3cmhuQ1p2WEx3ajNXc0laWUNFZm5UeUc4VTViUHorVkVkQ24xYy8vc20w?=
 =?utf-8?B?YTR5VVpwT2pVQVd6Vng4YlMrVW82OHdVQWFlUVZ3NVYrTUZVVFppVVRrT3Ja?=
 =?utf-8?B?RGdBcFdCSjJYay82S3RqaWdwamtjS3VPWCs5dys1b25YdlZ5L3lzQ3k2czBn?=
 =?utf-8?B?YW9NdnAyVHNtRllZV213aVpjeTZJOE9yRXdsWWhaTnNScHI1MzNhNHc3b3Q4?=
 =?utf-8?B?Y1hSUXFUaEFJZ21UTFY5UHVzRnNnSDNEaDVDaXVLN2NTMmx4dU1VdEl3ZlBJ?=
 =?utf-8?B?eS9UWFhWRWFjRXdGeTZHSW12SWVqM2ZlZm5xRi9HWXU2cnM5OWMzdGM0aDdW?=
 =?utf-8?B?dVJ5NFdDVy9wZ3V5aVY0T0kyMjU2RVVtTDA0TGoyZHNJbUE3cnVvM0l0OURT?=
 =?utf-8?B?aG1KekxDblhQR1RvQUlaSkJBSnlWRThtakkrUG1qYkxmeW1EcEJad2ZXOGdT?=
 =?utf-8?B?Q0tiYTBpR1BDZ3k3WUU0Nkt1SFFPUHJ3MHpvUVlKQlM3QVhlSnl4ekdOWXds?=
 =?utf-8?B?ZGhuQlB3UCtpWEJDUjhWVGdLMzl3eUxXU0R2SmV5aU9teGt5ZzJNY0RkTnls?=
 =?utf-8?B?S0REclNHQlkyUEp6aDI0YzBQQWM3VXFPSWV4VjA3dytqTzU1RWdUaXZmRDV2?=
 =?utf-8?B?b0EwS0tORGIrRkZZbFFHRGo1RVZTaFNtQkhJQmlhNUlCellSeVYyNzhqSk1p?=
 =?utf-8?B?RlliT2Nsd3FkeWtBbldTcytubDlURXVPeEJacTdZZEEwbnBVMWRFamhzcGxE?=
 =?utf-8?B?R2kya29oWnNPNXUzdVQwWlFzV3gvNWVNYU1YS2I1QjRNOHAzNEZLWlhvUGx1?=
 =?utf-8?B?QmhERSt0WERBU1J6MnU4T3gzaEhHNGlEM1NFZkdsOHdpMUdzNlY1cS9zZm5y?=
 =?utf-8?B?MmwyZXVxRVp0cEZvdDBIR1VGUDZ3Y2RvZHNLbzdYTEJwcXBYTTNHenlvRHNx?=
 =?utf-8?B?UlkrcHJ4VXpsMmlrN2R6azE3ZVlCNnJwdXdDTkhaNGI0MTA0eGVpT01ldHlI?=
 =?utf-8?Q?2EWILLQkIyAF25+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F285B6414F2B934ABCBD87565034830C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FYqWi3wp9CB6ZUowTFAZZPqDnGSHjBQLd1vR0wZcOUCFWIn4UqnZj+iwvfDXM/OmhcUd4Y6X0Dn3wTFjpdjkOMw4aR451ObdUSs+yMZbGWzSG2GABqjR/p+9pPJcfD0uX/x7KVo5Ii5UT0O0G3lkzbNUAIA+n8PwGmBl3eGdF3Nh8+9DoNA+FO3V/y4hY8Hxwgmy6nbfc3gYoNxKyBR8KIc0/cagUVOiGaJ088NzAT3DTakqGr2cItSh1YCfYtRmI1mxpzVODIJTNGGq1eedWdzlsnTMSSowGAWzmKuAHWcvJ6FLM/wpXIjmi0egm6mtVQxhvMH27rW3y7mLFSv1vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea3e4be-f7bb-4567-6c5f-08ded609d659
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 18:11:27.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0u1Y4SmpPUOS/HegZLLCy7hz2PajWaJFYjFKMKjQH/Qotd06iFZg8huRh653VfKxIkUo3jyhhvvyJQnKJKVzhEZqc3AQLeAWTTAXY3WbKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA2LTE0IGF0IDAwOjUwIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiA+
IElzIHRoaXMgbWljcm8tb3B0aW1pemF0aW9uIHdvcnRoIGl0PyBXaGF0IGFyZSB0aGUgY2xhc3Nl
cyBvZiBxdW90ZS1pbml0DQo+ID4gZmFpbHVyZXMgdnMganVzdCBtYWtlIHRoZSBwb2xpY3kgYmUg
YW55dGhpbmcgaW4gdGhlIG1vZHVsZSBtdXN0IGluaXQuDQo+IA0KPiBTaW5jZSB0aGVyZSBpcyBh
IGZhbGxiYWNrIG9wdGlvbiB0byBkbyB0aGUgUXVvdGluZyBpbiB1c2Vyc3BhY2UsIEkgdGhpbmsN
Cj4gaXQgaXMgcHJvYmFibHkgbm90IHdvcnRoIHNob290aW5nIGRvd24gVERYIGVudGlyZWx5IG92
ZXIgcXVvdGUtaW5pdA0KPiBmYWlsdXJlcy4NCj4gDQo+IFRoZSBxdW90ZS1pbml0IGZhaWx1cmVz
IGNhbiBjb21lIGZyb206DQo+IA0KPiDCoCAxLiBRdW90aW5nIGluaXQgU0VBTUNBTEwgZmFpbHVy
ZXMsIHdoaWNoIGxvb2sgcHJldHR5IG9wYXF1ZSB0byB0aGUNCj4gwqDCoMKgwqAga2VybmVsIGFu
ZCB0aGVyZSdzIG5vdCBtdWNoIGl0IGNhbiBkbyBhYm91dCBpdC4NCj4gwqAgMi4gUXVvdGluZyBi
dWZmZXIgYWxsb2NhdGlvbiBmYWlsdXJlcywgd2hpY2ggKmFyZSogdW5kZXJzdG9vZCBieSB0aGUN
Cj4gwqDCoMKgwqAga2VybmVsLCBhbmQgaXQgY291bGQgbWF5YmUgdHJ5IHNvbWV0aGluZyBlbHNl
LiBSaWdodCBub3csIHdlIGp1c3QNCj4gwqDCoMKgwqAgdHJlYXQgaXQgdGhlIHNhbWUgYXMgMS4N
Cj4gDQo+IFRoaXMgaXMgaGVscGZ1bCBiZWNhdXNlIEkgdGhpbmsgdGhlIHF1ZXN0aW9uIG9mICJ3
aGF0IGlmIHRoZSBRdW90aW5nDQo+IGV4dGVuc2lvbiBmYWlscyIgaGFzIGNvbWUgdXAgZW5vdWdo
IHRpbWVzIHRoYXQgaXQgd2FycmFudHMgc29tZQ0KPiBleHBsYW5hdGlvbiBpbiB0aGUgcGF0Y2gg
bG9nLiBUaGFua3MuDQoNCkkgdGhvdWdodCB3ZSB3ZXJlIGdvaW5nIHRvIGRvOg0KLSBJZiBxdW90
aW5nIGlzIG5vdCBzdXBwb3J0ZWQsIGRvbid0IHRyeSB0byBpbml0IHF1b3RpbmcsIGFuZCBkb24n
dCBmYWlsIGluaXQNCm92ZXIgaXQuDQotIElmIHF1b3RpbmcgaXMgc3VwcG9ydGVkLCBidXQgZmFp
bHMgdG8gaW5pdC4gSnVzdCBmYWlsIFREWCBpbml0aWFsaXphdGlvbiBmb3INCnNpbXBsaWNpdHku
DQoNClRoaXMgaXMgd2hhdCB3ZSBhcmUgZG9pbmcgZm9yIHRoZSBvdGhlciBmZWF0dXJlcy4NCg==
