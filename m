Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37E4A0F06;
	Tue,  6 Oct 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309238; cv=fail; b=ZAw374nFkBU27bOUzkYdOO7Om/jjfpk8Z4bRrLKi6qMSbhHxlF2J2kNS8qoQFh6yZDHXph56oH6Xqpxd5SFwSEBjZ7z5CWTaQ2Xd6aXA06/m/kN3E8hqx7freu5hadt9kjzs7Yv8g6GYrwA6+nUu7O1W42VZshznXh1NIXhktJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309238; c=relaxed/simple;
	bh=a+Etom3flzjdPlx6JMNYTc/p1vVEVL6Ps3AmTZLpNJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3o7KpB+8X0wR+tjK8p1vc68ETspF6PSOZwqvXUbyPvDn9LQigs9iHwxda6sscsvprwo/5JzS10vL9svTvvDwXhDWQx489uJ4PrLhbdlXduU5RsMNjNc0g+ZzYtYX9Ho+/ZcSs5StOfJ5vMZAEwv+axkYq+fcnwTfulbnFG0dok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU3aNTxW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU3aNTxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791309233; x=1822845233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a+Etom3flzjdPlx6JMNYTc/p1vVEVL6Ps3AmTZLpNJU=;
  b=FU3aNTxW7nte3pilVtSb1/+G4kq5CgAyLRGwsI/AK4ZGjjnFkc3K9XVm
   TrroWSXzcydvVcdSBgP0rZMBpPCf4mT/YiAi93eMI/Fvq1/mxei/BtIy7
   eWpQG37t/nKjz7woQp95Bo9AoPn8D9UChqoO+H6ev7GYDLchvcVoDZByz
   axMP8UfZ3j5tugdLMcy6uSfsMvv6DN5u62UDzsTYhqABG1txWZMkBbk78
   DZbVGceD3MlboZ2Wo/yMk+JztQMxB9+rIVehqmh1hkjcJAgbr+vVfKmzP
   reqY81cCSHNnvGHlqqy0BVV0Ql5XQKsAil2ZV4InWwC21EE0zwrwqqz0O
   g==;
X-CSE-ConnectionGUID: T9AxsHbaSLGlyebvBwB6Zg==
X-CSE-MsgGUID: 204bF6DKTlWwIhFj9cv+Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="63634"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="63634"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:53:49 -0700
X-CSE-ConnectionGUID: UDUSzX+pQBS7yvtt2ugTQA==
X-CSE-MsgGUID: E+IUJ05AQxyfrNn1QZ+zGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="315239262"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:53:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:53:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 10:53:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg5cQBmBuysyCxt3EB5VS1BlrYh7umS83LB9n+4JUvUTUBI6arWS3FQXJWGxauZxHMn1MCgQ39Tpw4D4QzxfslEmrPN1Ad4DJMeGChYLtDL7QojZNbJ67u7PQZaXFEVoHh+SOZfoWRLPmZ4t0bRIXKZYAHdkmiHz/VrRHdaBBQwYp9d8jkMcUFpGFaedxC5MecvnbcdG+5Odrn7l1bY6CpheLdxujAbi0Gr/Shm5GG3BBr7KcIAFSBB9tAEvY8j9XlGzXyDXBa4lqxit/eZ7z5RjouqutSUVlacYfMF4DLn7CwC1y+1bB5xnw2JQ9jtpJazN9148OGVx+t6kGruO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz/QLAuNPbgglLpxzfwgpkGVVkQEVXWVLDiDn5LkfB8=;
 b=vvZVqq0L5J6gjPl9DAglxcZWdFB59OT+UDdVhHO+UYSScxE3j+slHIV5Hva4aa+OnhKGevsuK4gqVAqyad05Udy6a8xBpzHQpoEHkLsR2QIQMBcQiE9EyMbFhTB4eDRsbAPMxjd6QDxortIeuuKHx3zZicLyd46wRY5mgU9ilWLA1q2h9ahh3yMr9yI88NNs13sMDua8e0bjci/wXDJZ7dhUyk7LWYPbhUbkY3ELGqBDRIE5rIjWbwv84IAOWnSzGk0+AhGri+ZosU3IqS4HpU47RoCwNLBlL0aN8EPc+u9IUaNdslj5b7n+y0qHxnBosh+YLq3tkm2RQgmPZp5BbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 by IA4PR11MB9279.namprd11.prod.outlook.com (2603:10b6:208:561::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 17:53:45 +0000
Received: from IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6]) by IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6%6]) with mapi id 15.21.0451.024; Tue, 6 Oct 2026
 17:53:45 +0000
Message-ID: <200d21ee-3041-40f2-9032-18e8544a7030@intel.com>
Date: Tue, 6 Oct 2026 10:53:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1790976400.git.babu.moger@amd.com>
 <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To IA0PR11MB8379.namprd11.prod.outlook.com
 (2603:10b6:208:488::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8379:EE_|IA4PR11MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ba8429-0057-4d58-29f7-08df23d2c47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|10067099003|3023799007|260925021911599003|4143699003|260925021311599003|260925022911599003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 0RGXbuN7ZixBXw0No7SmD6f+wXAMG+LKdVUaaHe+bmeWHdiSuPZvMoSrQu5sfdxl9so2GzoRVaPewqLrVIp+5RsAwarZDg9OTaKhLhJA9qFAS8lfVi5+WC260zMgwOLr5V4Ab1NgKfumYft8jAtDQzzGVZIKNeILQ+Z2mQJs7HPyn40oUp5lj+OWdn/1jAohwxh+89zvU+cMqpcqiXDYIeCyZu51FV5IhkndN5oU8eVzjaXo9nRxvzyc6b9QH8KQBYhPlWmAqXWF9+daAFAZHSkO9rcFDmUwjmqiSnoWHLTPzsEGNYY3P9PPyhPekbVxOa36a5wTbRu6rrTRBpLA1f5BAZIwBwyzJHRotkbO+QRxVvTTh/jyKHix5aj/kAdkxqqPqfloTDxgYYdsK0Tk/KzJ6RnyvYa5oDJrAGaL5ZCAh7D9cvLCX6iEZEzSzAv/7SJmDOH2vO51FvmiS64Sy7byK59WkjveBHoBLW4Q3k/5NB2DvL7fi80BS0nsOi5TlJQnTLMQY1Ci9budj7aG1n4F3104E1zyk5f2cSGW837pjzyJt+Ribe4hv+RI7QK5aVsOAlnH7gHu1WBU0YMh/5BNhsVJdbDSdG3fzmyjjssxX76gK/TPfmqDR29et8CFuzCCP3yZyEU0RPhvkrkjPMC72SFtXCWQPxO6KWsiWmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8379.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(260925021911599003)(4143699003)(260925021311599003)(260925022911599003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJ4bmR1YjdsTk1oaG5nTFdtYnRnSFgxMlRIK0pwbWFDZUYwV29ORmdxYUpT?=
 =?utf-8?B?L3RqcUN4eFRaOGFKMDlxeFpCQ2hUbzF0WHlIMG9uWUJxcTVmR0Q1YVVycXcx?=
 =?utf-8?B?K1lXa2ZJNHQ3Z0l6cE5JVkRyUlFJcW81bmRkYS80ay9KNGNFYmZmR1FMcVEz?=
 =?utf-8?B?ZndNNWZvbmMyTnhQVnprS2dHMU9UTG52QlkzZkRUbDBDVVFxdUg2UTB5Mm1Y?=
 =?utf-8?B?SFNOcFduRzVVSDdpUmQyZmo4N2gzTDlENEF6MmdZZ25Vamd6K1RtMTZtUEp4?=
 =?utf-8?B?WHF2eFdMYWFCMFVQTjk1citMb1V0Mkkvc2VBVjJlV0c2d2VDOHdYQ2NWZnFa?=
 =?utf-8?B?YUdNZUFSdjc4dWlLMUNBdDFqSDVkOVpPVmhIazNrKzErd296ZTdWRk1HcDFh?=
 =?utf-8?B?QjJoZ0E5cE5XUTltcEFLMnBEMitjSTROaXk2bllPY0FTaVlHT3BZZ2RFVG8v?=
 =?utf-8?B?ejhIWkllOWNRWUl5N21VTE5Ea2pRSThRUnJ4SEZyY01lZjlOZS84WWs0Q01L?=
 =?utf-8?B?NjhwVFlpZmpVbWJtelFHeDdYVms1S3ZBU0VOZW5qdDNwUm5vdjdOdGo2cVE0?=
 =?utf-8?B?UkE2OEh0Y1ZSQkNhMGNNT3ZkRUxCUkxiRnFmellJUDlLaVF4cGVHUkZmMGJG?=
 =?utf-8?B?OU16allXdUdmTlJzcFdjQ3NZN2hNRTNlSkZjaHBIbWNpaXNReW4rTndxY2tx?=
 =?utf-8?B?NWJPQzEvZExqTDJjSVh2eDluOU9IVXErdnJncktLQ1NLcE5GM3Z0c1gxV1lv?=
 =?utf-8?B?TzZwRVhVUGhBWGpOVlBxSTNvdmV5ang3U0FlZzlEOVF1eFI0c1BCMUpVS3ZC?=
 =?utf-8?B?R3cvQW1EZDVha2V1dFh5cHQySXF1cEJacHI3SmszV3d6S0pkSklnRFpFVG1a?=
 =?utf-8?B?NHc5QldXT2JrMy9BeTRZRFEvN3g5NERVQjNYZUVvRjJyeE9CT1JxOXN5TTcz?=
 =?utf-8?B?eERtYmQ1Qlc4ajNLSUNsUnVPbHhwYXNKY2dHU2F4ekc4N3M0VnE5UzdHeDVL?=
 =?utf-8?B?akY1ZEk3dnN3SmRCMGNPZkFFZmUrRk51RmpSQVB0djFWdHp2ZFBwa0FRWnky?=
 =?utf-8?B?eFJBTmRWaHNKWS9MTTRIeHRQUzI4czBrU0xyblY3VEdtcHczMlhPc29EWmF6?=
 =?utf-8?B?YmxDb2JrTTFoZlFITzhneE96STBybjhBV1ZWbU5ZTU5Cc0dpck5JdWxRSHdk?=
 =?utf-8?B?N0U0SWQzSm44U2JyRUF4MUR3THVjYkNTM3ZxMElTYzN4blNkTjZTTE1TZXFI?=
 =?utf-8?B?b2VDTTBOeFB6clE5elVTTTNpR1pDeXFTSnJuU1d4VTVNaWk4dnQvNmtzbHZK?=
 =?utf-8?B?NVk2bmtiSTBLQXRjSlFMbXVYWHVPNk1Gdk1pTjdSTVRpZ2s4OE54NFRSRG1l?=
 =?utf-8?B?MnJGaXRGaEhYMGU2Yjg2MlJTRlh6VzhpYjUwNGhyby9DaEtFT1JOenl2Skd5?=
 =?utf-8?B?dEFacFFpRmp3QlBRdTVqVCtUbEw0VnN4SE84UVZ4QTVuWFV3R21XcU4ydlJS?=
 =?utf-8?B?eFk1Ni9EMDVWSEl6UjdySlJjWnZPbDIxTDhDeFJSL2d6c2RFWTNPc1ZHREFW?=
 =?utf-8?B?TG5rajlmYmNjazdlTG14NlZqVnE3TW5aTWFlYWRaSDZNN0lTYS90L3JBbHZQ?=
 =?utf-8?B?WXhJNit1VWNxMWxzRTZpdkQwSmJPS3hXcEFIbjU5aXZtZVNjUjZtYkMxaHk3?=
 =?utf-8?B?dkJOTmJHOG1nd2xocjJIV0dDVXFMd0ovdkk1ZytMSzZKc01CYUNkRmlkMFYv?=
 =?utf-8?B?R0RzRnhNNmg1S3B6ckhIY25nRm0zK205Q3VyWHlzOFZJSm1lTlNuK1JQNDIx?=
 =?utf-8?B?QWFVMTJYRW1wNnpkK0U0OW5Eb3FhVm9JYkRLWkZtVEk3bXdrQXBxdXhnTTlC?=
 =?utf-8?B?aTRJd2kzbXhncitoeU94SG1xTzdRbXA4UHRFK0FyRUIveVBYd0ZqRXc0T25r?=
 =?utf-8?B?cGJOQjYwcTNrVVNlb3JEOGJFQTJiWmVsTytCSkNwYmZhVE5YYW1WY20wSnh4?=
 =?utf-8?B?YXk3WlQyc3RSVFpWNU53Q0NybGE1dlhDaHphSllhTHFodmgzaFhoRnE1cEgy?=
 =?utf-8?B?dFhOVTBITkNzdmxRYklhbGVBWHM0Z0RBb25yelNDTzlSM2JHWkFHWk9iNUZX?=
 =?utf-8?B?MkJRMXNmVVp4MnFBcFIwOG9PMTZYRW51UVkzWTRJT3VtbGhnMUlNZWR4ZWNy?=
 =?utf-8?B?ODJpSUxqM21yU2ExZ041NlF6QmJKNmNpMHM2MytQS3YyUGRmRHAzMlBaajBF?=
 =?utf-8?B?b3ZQajc4cUQ4SEFabE1jVlkva1ExTFZtRnlJSHF0Yk1LSERQbEFlMTBwYWVK?=
 =?utf-8?B?RXhYR1cwV3pwRmJRRmYvSGJWekpqSUFkTTdobXJkWStIQzZHYzRwYlYxVnNo?=
 =?utf-8?Q?wOxzcLwmyqrWDTwE=3D?=
X-Exchange-RoutingPolicyChecked: cTB6OC6reMU5Uo/zz2nnCZw58CHYRUfNT/Io0UIiW9IViieW7CC4TfhjiX4Nq5QiGRhyqW2Molj5vpYFt/z28Y7L+2JPjDGe/lAt+ey9e0NuTDhHG6yeuCQw5bA7WtwgASPH7R02n1/QVI3ahA4rvS2xpwSLQON6BxA9PFRrf3E5Gefxh455pkgQSpRN7SSO4Ekgcr67Bf1kjngS47vTsUWsx5GDl77ZCxTZGaOeRsiRe4K5Ms0gjyICuyBn8cfVzRTYJR2Szga2wcClhL11GVyIHpXHgUu5W1w/E00LsMBQrNOPl+1nVsKQaiK/BxYgwklJQdUSE3hIA6aUyi/fRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba8429-0057-4d58-29f7-08df23d2c47d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8379.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:53:45.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6oLX06X3RhQyeUnCJJzJQAZBLaDwGKa8wRqd8UmOIoJ5rCgu2GFWfGCiyrrUrL3IFe77dWQEhPTc+v/fLFL5hS9MAMqAKtseTO9+na7dBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9279
X-OriginatorOrg: intel.com

Hi Babu,

On 10/2/26 2:26 PM, Babu Moger wrote:
> The "mbm_event" mode assigns hardware MBM counters to RMID/event pairs.
> It is intended for deployments that need to manage counter assignment on
> platforms where the number of monitoring groups exceeds the available
> hardware counters. Hardware counters are scarce, so mbm_event mode suits

"Hardware counters are scarce" -> "Hardware counters are scarce on these platforms"
(to make it specific to the context and not a general statement)

> workflows that monitor a subset of groups at a time and rotate
> assignments as needed.
> 
> resctrl enables the "mbm_event" mode by default on hardware that
> supports it. That breaks the pqos tool [1], which assumes the historical
> default mode. pqos treats a non-numeric event read as zero bandwidth. It
> creates 16 or more monitoring groups and uses two counters per group.
> On a platform with 32 counters per domain, that consumes the pool, so
> further groups read "Unassigned" and pqos reports 0 MB/s for them:
> 
>   $sudo pqos -m all:0-4
>   CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>      0        0.69         16k       192.0         0.0         0.0
>      1        0.40          3k         0.0         0.0         0.0
>      2        0.44          1k        64.0         0.0         0.0
>      3        0.39          1k        64.0         0.0         0.0
>      4        0.43          1k         0.0         0.0         0.0
> 
> Leave mbm_assign_mode in "default" mode during initialization. Default
> mode uses one counter per monitoring group. On existing AMD platforms
> that pool is 64 counters and may be larger on newer hardware. The
> "mbm_event" mode uses two counters per group, so 32 counters cover only
> 16 groups.
> 
> Deployments within that pool receive accurate bandwidth measurements
> with default mode. The hardware supports 4096 monitoring groups. Beyond
> that pool, readings may be misleading or "Unavailable", with no

At this point I am lost because the word "pool" is used to mean three
different things. It is used for the number of "ABMC counters" as well  
as the number of "non-ABMC counters" that exist on the same platform,
above it seems to be used for number of RMIDs (number of monitoring
groups) also. Could you please add some context at beginning of
changelog to introduce the various counts applicable to the description,
associate unique terms to these counts at that time, and then use
those unique terms in the rest of the changelog?

> user-visible indication.
> 
> Default mode is still limited once the number of monitoring groups
> exceeds that counter pool. After hardware re-allocates a counter, a
> read may return "Unavailable". pqos still treats "Unavailable" as zero.
> Successive reads can be a count, "Unavailable", then another count.
> pqos treats those jumps as wraparound and can report an inconsistent
> rate:
> 
>   $sudo pqos -m all:0-4
>   CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>   0        0.76         60k        32.0         0.0         0.0
>   1        0.45          1k        32.0         0.0         0.0
>   2        1.57        107k        64.0         0.0 17592186044184.9
>   3        1.62        276k      4928.0         3.2         0.5
> 
> Users that need stable measurements beyond that pool should use
> "mbm_event" mode and rotate assignments as needed.
> Enable it with:
> 
>   $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
> Closes: https://github.com/intel/intel-cmt-cat/issues/311
> Link: https://github.com/intel/intel-cmt-cat # [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Babu Moger <babu.moger@amd.com>

See "Ordering of commit tags" in Documentation/process/maintainer-tip.rst

> ---
>  Documentation/filesystems/resctrl.rst | 48 ++++++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
>  2 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c8507580474a..2efc99223bdc 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -354,8 +354,8 @@ with the following files:
>  	::
>  
>  	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> -	  [mbm_event]
> -	  default
> +	  [default]
> +	  mbm_event
>  
>  	"mbm_event":
>  
> @@ -363,6 +363,9 @@ with the following files:
>  	pair and monitor the bandwidth usage as long as it is assigned. The hardware
>  	continues to track the assigned counter until it is explicitly unassigned by
>  	the user. Each event within a resctrl group can be assigned independently.
> +	mbm_event mode uses one counter per event of one RMID. A monitoring group
> +	can use two counters, one for mbm_total_bytes and one for mbm_local_bytes.
> +	For example, 32 counters can monitor 16 groups.

This addition looks redundant to me. "mbm_event mode uses one counter per event of one RMID."
just repeats earlier "...assign a hardware counter to an RMID, event pair ...", no?
The example being added ("A monitoring group can use two counters ...") also looks
to be specific to AMD's usage and including platform specific example as part of generic
introduction seems unnecessary.

>  
>  	In this mode, a monitoring event can only accumulate data while it is backed
>  	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and MON
> @@ -376,20 +379,37 @@ with the following files:
>  	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
>  	assignment states of all monitoring groups.
>  
> -	The mode is beneficial for AMD platforms that support more CTRL_MON
> -	and MON groups than available hardware counters. By default, this
> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
> -	Monitoring Counters) capability, ensuring counters remain assigned even
> -	when the corresponding RMID is not actively used by any processor.
> +	It is intended for deployments that need to manage counter assignment on
> +	platforms where the number of monitoring groups exceeds the available
> +	hardware counters. Hardware counters are scarce, so mbm_event mode suits

"Hardware counters are scarce" -> "Hardware counters are scarce on these platforms"?

> +	workflows that monitor a subset of groups at a time and rotate assignments
> +	as needed. The mode is beneficial for AMD platforms that support more

Text from "The mode is beneficial for AMD ..." does not seem necessary here
since it just duplicates the text added below?

> +	CTRL_MON and MON groups than available hardware counters. The mbm_event
> +	mode ensures counters remain assigned even when the corresponding RMID is
> +	not actively monitored.
>  
>  	"default":
>  
>  	In default mode, resctrl assumes there is a hardware counter for each
> -	event within every CTRL_MON and MON group. On AMD platforms, it is
> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
> -	events between reads resulting from hardware re-allocating counters. This can
> -	result in misleading values or display "Unavailable" if no counter is assigned
> -	to the event.
> +	event within every CTRL_MON and MON group. This mode is enabled by default.
> +
> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
> +	counters, hardware dynamically shares a smaller pool of counters among
> +	RMIDs. One counter from this pool is used per monitoring group and counts
> +	every MBM event of that group's RMID. The size of the pool is not
> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
> +	much larger. For example, 64 counters in this pool monitor 64 groups.
> +	Newer hardware may provide a larger pool.
> +
> +	While the number of monitoring groups does not exceed that pool, a counter
> +	stays attached to each RMID and readings remain accurate. Creating more
> +	groups than the pool can cause hardware to re-allocate those counters
> +	between successive reads of an event. Bandwidth values may then be
> +	misleading, or a read may return "Unavailable" if no counter is allocated
> +	to the RMID. There is no user-visible indication when this begins.
> +	Users who need stable readings beyond that pool should switch to mbm_event
> +	mode, if supported, and assign counters to the groups of interest
> +	(rotating assignments as needed).
>  

Above usage of "pool" looks ok since it only uses the term for the "non-ABMC hardware
counters" while using the accurate terms for the other counts.

>  	* To enable "mbm_event" counter assignment mode:
>  	  ::
> @@ -1787,11 +1807,9 @@ View the llc occupancy snapshot::
>  Examples on working with mbm_assign_mode
>  ========================================
>  
> -a. Check if MBM counter assignment mode is supported.
> +a. Check if MBM counter assignment mode is supported and enabled.
>  ::
>  
> -  # mount -t resctrl resctrl /sys/fs/resctrl/
> -
>    # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>    [mbm_event]
>    default
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5d0d3b18f9b8..a6a9090c4808 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
>  		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  		/* cntr_id is 12 bits and can only encode 4096 counters. */
>  		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
> -		hw_res->mbm_cntr_assign_enabled = true;
>  	}
>  
>  	r->mon_capable = true;

Rest looks good to me.

Reinette
