Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0B2DCF61;
	Wed,  8 Apr 2026 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664245; cv=fail; b=bKK5mdwG34HuECuu82ytEL/WJsVkUSbHjzfEfOc0uz+6xhESQC1nrHVczREc0GckV25f9xK2z07DSzkDJ2rQZtm4DGj9GDeNU0Lsw10alIOWmflEKWTxjrXbXRTRbO53ns7pF33NOZ1RayCO1bJO0reLqUID0AhFb4/oS4AvefY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664245; c=relaxed/simple;
	bh=9jEz9DwcFgSWzp7sGFpOq0nztcUc4mtk6dwSrhkXrd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXHtEgzVix1HG46NuG1Ao/oSukjOSYC2XRHeFv/me6iZ8/X0Jj/xqalT7VBdO3gDZXpuF2rtym9MAU/zMl7iKBWOJlQtN5bL7jb0G4sQlOqV+Gln9+e66ikMjTI2nh6eanFipNE4KdgpADfrQo2Y27uxhDiT32LvHRHc4mBO018=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPr/IoqH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPr/IoqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775664243; x=1807200243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9jEz9DwcFgSWzp7sGFpOq0nztcUc4mtk6dwSrhkXrd4=;
  b=mPr/IoqHdyiz/J3pM5P57+ldDg8gRTYMfb9r/6JNO6kvb3nv33h35a/9
   HD3vA0SaVmAD+STTPHLImmp4PKo449lGgrMJFtXBiTvtSqTM4OottO0xX
   g9R7qCefRZC0LsTMfqc3Dcjl/kjK/T69tcjXiGGxGywZEvgeLAcLHZlb1
   /X8Mh2SoHIQDhzuDEI7raqfrrMCZEby+JqH+gd2e6hWfermI/Qj3cEJm0
   jkAN4lzK5dUw+YKniXxNesgzyc74FHwNgyFKV40IdWQdpqhbNjPIiunnX
   yt2x5T7pD9kc7GKVAhkvys6XNIY6QxSgH3UN77K4TXCd2JbgeYq5aJeRr
   g==;
X-CSE-ConnectionGUID: PeYr9mG2SiSggKVyjj7fBw==
X-CSE-MsgGUID: R9PcjrLPRJmjCIygs+m7Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76530958"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76530958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:04:03 -0700
X-CSE-ConnectionGUID: aA4hmxgOTx6Sdbb5JlhWyQ==
X-CSE-MsgGUID: lnSnlEqyQNObjRVwClFIHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="266491021"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:04:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:04:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:04:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URlcstAZK+oylJaV/wqpmZLh2KDcYEXcg7779FUN6xh9FBkp9m7iaqZxzK5EFm9GRATCQPsbtAnQMxV6ktXU+6BoR1q6zmmpugRFL9mKQPX7eE0Kb6Rp65j2ue6pJ0vLSsTgBZqgF4fywkl/tyIR2IQC1NGBHMVkjhy/woxsRx159bYZgKxVvxI4H4/CdU9/tzaWYmoLZ8uhXnnAir07YwwlUu+CFNrKWrFg6kM4FSFNR1A1V5mMuYnqMSc9djXKK3SLWeOKclSNfvLe+QqhJCriFBvYhwaCJAQ7G7mBshHr9ewlHGAwSYtS+tmTb1+xx8zT2788D6tl8AA5TGMS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FySR8OPGuq477CU/RgxAJFRLt3MP96Os0tBThKh/UV4=;
 b=agsMXcAOeR6PN9lZGipqQD2QB9UKUS3tPAN30XR7cUfnwsdcebVm3w0buSw8DqWb6mrFNJOakdHzwM+0QozRbR13xMn8J7xP7bGQn6Ds6mTIPF2DlHhj/4CypBC+jLAUZ5pQCAE0cT7Lzsp5dLX0k/kgy6sqLa/kqn0nuY2VRkH3W7KF4iAgOqeapfqOLwdq6bJstcxImegtKD81pHW4t1TL01XPJ9HJXgvzq52kvK81xLsgLuDNp7pMd8mBLz+Aid+uE5oguFQ7wzRHXSWDZTs3kEg2Qv4vVL7Y1Ya/+Bemaf7gGo04jlY6Olo+p+5Kv2l3FUA0ATkKwa89emoAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 16:03:57 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 16:03:57 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	"Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>, "Niklas Schnelle" <schnelle@linux.ibm.com>
Subject: [PATCH 2/2] vfio/xe: Add a missing vfio_pci_core_release_dev()
Date: Wed, 8 Apr 2026 18:03:40 +0200
Message-ID: <20260408160340.866784-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408160340.866784-1-michal.winiarski@intel.com>
References: <20260408160340.866784-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF0000021A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8d6) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7016b8e2-debd-4e38-da6e-08de958870f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: l7fhgnkW4i2ehPEsLGg2O9Be2BCqKQY8UBB1aAAMWceUW3buXNj9ZQSTAK5zgybldYilcJnuwi9ziVKls0URM7d9koLV83q4Gtlp2ewY/nL70X1lDL+WCWkgVO21WrR5AX2ITu9PwCf9HmFuTa2eGaJSSabIUi2/lU/jHO3gt2P7PLdcMEaKL3bsOgC8KXq3BQdwOdPm8mV9UuPxoU4olCnwc+TuTDqgHysKuKIXUjdEmTAH3eHetDcE3Y2D7fHHZB5+xhnafXSOA4CJHz9wcOKh+Xtkpg1RqFPAMumZP7EMRgocQ46Yzc4443mnZy7ybQY7cZBgFchQ/eJWJUYXqPgzWENSq1yrLPGLMp+XfDqiqQxlT64ghSxW2QhwaDFI+HUOMWhT9OJu1sJ4j1fEpRRF6GUKnpbGMgQFy52RyWvmEEB/t7/ZHM/Za5eLK2ntubqjVDiLDtt2May2nGY6oWX30Ir9F3Jy/kanjQrXweobYascEBxSAUO5miwqDgdevc8LibMb8lbe+KVptu38wnCH3VxzA06TpIw0r4jMkh237csJA7mrL3Q3KAcLcpLPzzievrH0ZwBRlEYekJa8aFcHlIELakXImDtqfsncu9/o1qq6FmqpRBZ+2TIcdBBz4lMpkrQXLmjvueIgD5YLxGv3wibZ+b5ZuQ0Q//7Xkp5I3dVv5XSEiLC/dVrwHT280gBGn6/tqxSoTUHeNXrDq4sE4wrC9E7O/bg7P5YMkiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGJDYjQ2bTdmUGpic0xYOUlEaXJKVGVKKytidnpjQjNTVXdYUHZpLzVRZ0h2?=
 =?utf-8?B?aXZVMlJGVVR6V2xqV3JpNnhJZTBleWxZOThtMXNTTGp6R3FoTGZQVUtoQ2Rp?=
 =?utf-8?B?ampETFluRUlJV2htUzR5L1FjYWZ6akhneUsrUmwrc2ZLemhXMFlzZ0w5QWd6?=
 =?utf-8?B?MXVtUnNTT0crZmw2cXdwSU13djhybWNlMVJkUXNzSk16WHFGdnRKVm0wMTBm?=
 =?utf-8?B?OWNLR2FwS3ZtZFh4VTFMcE81VWRPUWtSR0hVMk9ySWtYWUJIOG1GSGRwVGxT?=
 =?utf-8?B?cnNsVFZwSW5VaVRGa01hYmlIVGFhQ01HQnhQNG1JWFdmOGloZXV3NmlVSXk2?=
 =?utf-8?B?UjFJTjgxZjZra21ZL2JVL3FZbm52T1g1Zkxqb2lWZHAwYVMwZHhDUVpKMFg1?=
 =?utf-8?B?U1ZMUzljLzQ1a1BQNjU3RnJMeGRlT0NzTHdndkl0MnZiWWRrb2ZyTWxvQVB2?=
 =?utf-8?B?Um85ajV0bUg1eENtUVVTOVcyZExGT1RCaVJJZVdOSTdQV1RBUkNFcXdPdFJW?=
 =?utf-8?B?RDdMaEo5bG52QTBxNzhYYlgyTWtRS3BTZDdSZmUxcXlnd3BHa3N1Wi85NFBa?=
 =?utf-8?B?MnYyL3dldSswZW9tSUtMVUVySklzaEZBbmVXMU5KQXRoek52Nzl1UkVaQWtB?=
 =?utf-8?B?S3IvRE5oRSs4TnpwVUozdWdpeEV1Wm11Rkw2cDlCRlBvaWtIbVpZNXpZN1Uy?=
 =?utf-8?B?Ty9lMXFSdUVLUGV1dFZKdlJ1MXFHUXVGeXFHVi9UVDBBRldLSXR6cUVQM2RK?=
 =?utf-8?B?RUdkZnYwcWhSTDlUclBISFg1eWZ5WjYwZUNpR3lpMFZ4YnRpS3lOaS9FWWN0?=
 =?utf-8?B?RGNuTkhFcWRzMkt1cHVzOGI0TFZXaUJyTmlrcUREYTUzNzA2YkdpdlNjK1d1?=
 =?utf-8?B?d2hOeC9mRVk2UFlJMDM5aWI1Q3hHcDhyMnZNWnRuR0Mybm1Yd2pmd2laK1c3?=
 =?utf-8?B?dFl2UzlmTnoxMFZRVC9LcU9uVmEvL0xKbHBPRzkrTHNmbVVHWGp6eWJkZll6?=
 =?utf-8?B?cUNoY0F1cHJoVlRhaU9EYXFQU2pBams2aEp1d2lxdlpLekdubk1XMUxOeXh0?=
 =?utf-8?B?QXBGcUJBdStLWnlFTkswZTA3a1NwL3dVNldCa0UyRmFuOFVyMWV2SHM2KzYz?=
 =?utf-8?B?SHNIbWRla2VQTTdxdjdkdTFIS2JSbHYzM3RMNHpueVhmUnJxZUplWWlENDBR?=
 =?utf-8?B?Z0cwaWE4VUJzd2w1VW5zWDk0QVhEbXdxak00dEdTOFN4WGU1UFRFdXBSKzVC?=
 =?utf-8?B?NVBaemxnTXI5MTg4Q2xQZlduWVNPY2gvY0Q4UzJoVTVFK2dQY1hlQ0tFUDI0?=
 =?utf-8?B?QXZ1MzNVNUdKbk9JWFFZdnBCNHllL0VYeUhubHVzWjlJZnI0Ym1hN2JiVTRM?=
 =?utf-8?B?aXUxdGgrVnRiSGdqcmYrSjIwaVdnTUtueHliUCswS1B6U1BIQ1hqR053YlV2?=
 =?utf-8?B?ejR0UzFUaHFvYUpEeEs2cExIcE9WNlNWbDdydDNHSW5zbUZZTU9EU3NKSzNE?=
 =?utf-8?B?cExGTmsvMWVHcmpvaWppdXcvbkRJazZqNXhtV1YvYi80b202VzVuNjlEck9m?=
 =?utf-8?B?ZFRmR1dpSWNJUkVWQTZDNmRYaXNhSmtaWjN0Rnk0dTI1WDZzaG5uUHp4TGNQ?=
 =?utf-8?B?eWJwRVpqTzM3QkhwbmRYWEI0VXpjSXJtb3hNZ05yODJrNGV0S25OZWQyR3N4?=
 =?utf-8?B?Z0ZOSUlrN2cwaVJHUjh2RnpVTFZVUlVWM3haNGpRZkZqa3hYdC81NUlXcFJT?=
 =?utf-8?B?ek53eXVhYi94elE0NDlpQit1eGNCcWJacFpvV1kxbmYxazBlSHNRRHVvKzR2?=
 =?utf-8?B?aFF1dEc5azBHb2czQzIxUGdEbUxJdUg2dUx5eHVrN0tOeGhWVzIzVUVTZE9r?=
 =?utf-8?B?YlZ3ckw4cFJOajF0LzFNVVFCWE5tYTgvZWtIcjNtV2czbEpBbGpuTmduWnBG?=
 =?utf-8?B?dlRza3AzWDFxcVNYOEZIS2FGQXlyRlNsbTlwcC9nTW5RZXdoempvbzhwUitJ?=
 =?utf-8?B?ZVJWMnBXSzdnb21YT1NhUE1sWEdwYkNBZmt0Q1dIYWhjV1FzbVZ5OWt4c05Q?=
 =?utf-8?B?N1VUaXl4Q294c1BBTGJQVDhhZ08wNEVMaWZJRFp2U1o5TnNnWHJPZXdaajRT?=
 =?utf-8?B?ekRwZUdLblJITHgxa3FyR1BmSlh3Kzc5VmFlRDlmR3ZJVGduV3FOSWdaTVQw?=
 =?utf-8?B?aEkrWC9mbzVXRjhjZkF2bjlnaTR0L1dNdllzTEJJQklxdHlGbDdwNmRjRFFn?=
 =?utf-8?B?ZDlqTjFPcDF0NDBOWnIxSDJlblZhaTZJaUZqZ0FTK01kS0xZYjJqTndpaWQx?=
 =?utf-8?B?aU1NNW1LOXp3NGo3YjBFbzB1U2pQdXk3OU1jWkFkTzM5Z1pxbjZENWNyMkEw?=
 =?utf-8?Q?SWp8LgkvSjikgOZg=3D?=
X-Exchange-RoutingPolicyChecked: jR6X4apckDp9BTVayeMtzhkZlUAjGLc3iRb18MTG1TjwKW4OAuIWjopuZHmTGho5A2PjalYJdamxDR9gGb8y8GuGJkdDF33L0t9AtDJpFnaOQBOfW93yN6KZA6bAU+5EbN1HdE9Z95AHTQw52CKjD9zjkBBjLU0TrT30M1IPJorLOXVAvFr+glsTPhkaLwK6beR8U4AeJm/CSahFZWU9/Bq+UK3Pqh423TBK+O84GV8TD53N9PNzCaBGBaB2cnbxdATPS0iUiLimQ4Bq6yWCeAtlDrid02xONOTet7BIHSyKs/8YgIGxagXC7WmyeS0v1ztDdlzx4oIuQQoIVwAIBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016b8e2-debd-4e38-da6e-08de958870f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:03:57.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uevFDPtoYBefm3CNMtn9duhzhWk6EQKqZFxZ4JrStykahVLt8bsKf+ycclIcDEt1r+aZ2FrsOJJUaSHikpG6E1TM+YnD60TfP5f0/k0/cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

The driver is implementing its own .release(), which means that it needs
to call vfio_pci_core_release_dev().
Add the missing call.

Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Closes: https://lore.kernel.org/kvm/408e262c507e8fd628a71e39904fedd99fa0ee8e.camel@linux.ibm.com/
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/vfio/pci/xe/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 40ea73234dcf2..af95a011ed111 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -528,6 +528,7 @@ static void xe_vfio_pci_release_dev(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
 
 	xe_vfio_pci_migration_fini(xe_vdev);
+	vfio_pci_core_release_dev(core_vdev);
 }
 
 static const struct vfio_device_ops xe_vfio_pci_ops = {
-- 
2.53.0

