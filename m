Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B325372DC;
	Tue, 13 Oct 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923167; cv=fail; b=F4q8fWq7xiQ2XDCS9HMBCQo2GnrOQRTTdSjsAwk1WuaK/o61EFC22tQF1OzPkPgbYBPzsh3ZmIvRqUxgq0P+f69jzcDlhoW18MuBtMRbygsJNwqjF1Y3qS+2VGYTLksaP7sMJSIxC5GHZca30jSmnzgtO4IOoeYlV85bVaMPU8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923167; c=relaxed/simple;
	bh=RJqO1rziYIG7peN3q/q14TZjXvpcufKA3g+E2XlP+pQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKvCVOM4q+cbjvaTK5Y8GsB7dVAer+KtWZPftYKVMqe5ps1GInYMn9Szp3P12cnBdy1szSwXyPcL8uV46M1zal1j8WNmR9D25vhPG+LIF0IqoJm1QTkL/iIBwEbMks6Pjoyhz6xSjwk3PannUAmiJxN+3Lj/Gw0ImPRxRr/ZsgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJak/SMJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJak/SMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791923164; x=1823459164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RJqO1rziYIG7peN3q/q14TZjXvpcufKA3g+E2XlP+pQ=;
  b=eJak/SMJg0LDMZ1Bg8NrQVE1SKkqWrDYh51AQ1Cvtyu/RvJq6dytZrBA
   BgSb/y87zCXU9XgtWAFXycTMMp9ZasKz6cHz6ijtghJO7bjyc9l0CqNrW
   AZulW3qh5UltVQilpkdCrsFYKJrI6p/qHKDlI9jc1pAbgOsXFnk9fhlJ2
   IBEHqX9yUAwIXoP+hhQwmOX09tEnmVBgySupzolij0ZTMWcv1NG2P+hSy
   C/AUo0j1YWb+fVmTRbt33IZoo0/lBTDUTXhsbNsjHuRwlL8NpaNQm55ei
   Bd4drVNB2/5bfYxXcKbI0C2i5F3mn3eTyEC63kzlT5N2BraanD7Z2hErQ
   g==;
X-CSE-ConnectionGUID: Kvl/LArPT3GbwVZNW6YRYQ==
X-CSE-MsgGUID: qFQJlnbBTUSEAkMO70jORQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="668189"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="668189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:26:03 -0700
X-CSE-ConnectionGUID: LFyfIpH/QE+B4NkyyheUwQ==
X-CSE-MsgGUID: 8opbNrG2SraBdIJEEvL3tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1180144"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:26:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:26:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 13:26:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2ybm/JGCDlCzskl+3MoMUB/qHYyNlKwmYuVQlwObEHQ4EixsAAQKc7sHnDx0ioAOj/bTzdn8vy2RdX9AkX03WpMZXxbLLk9bAwTEFdpwJ76qjwT//7EYwD/g5G9SZeUoQ2a1oDebRSw8YLtjizFQkW/DX5HQgo2wz10TdytMuTsLZKkCG1rV46QhFekOWByObjjL9cDbkG0r/FUijz8Dc8D0hLcJaYcvQEOvF7onU8/fRQaaOkV+HHJM7zYEKKZvC14iWoFYyT0MJAG5OM3qflDzARk+dS+LuaUjY+QMsn4OiVMl05kD+pzXqXRRPiJOSj17VHuTddOHXZ2Ju3Zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV/pE74gML1l+/y7WteDsc1GooZfJ+z2cHvYBI0TEok=;
 b=u0Ag2bqd/Q9DiHYxSvntvfcYuFC0ddM+E8OYRzpA1UsdmGMOI27HWP4Q2nxNWlrcsX5LBOE7Cy/Qs18Jka8XoLzWIPYDhvX2nFQ3ihSurzFu/KLFgTs1sMruM+xG8v0YPLo5MOCUxeY02FE8YJ02jAaxaghAwYlWJVqCBJdswMsD139GQ7ogfrelsWo4Dgrp+hKsZH6FY/FoXgOSmnDPptL+TYwqbDcKPX18IJCGMRIi5mnrWSUcQNRvGkZ4sPDcf6R8j45AaOH6REb2hEgiR2Ey8ALjk6MPOGRMQBZJNVGTur6ISV1xnqZfPJzGsqHqeVq3kJx5+V1OEKJ7WiVOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 20:25:59 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 20:25:58 +0000
Message-ID: <e91c9cc1-02cf-41ad-b636-8356e93b5dcc@intel.com>
Date: Tue, 13 Oct 2026 13:25:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
 <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
 <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
 <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|MW3PR11MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df71fa5-abec-4e84-d9d7-08df29683122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|260925021911599003|260925021311599003|260925022911599003|22082099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: vCGQPM4axU3/HkDUBDFqKIR+5Iw0O11ibfwCFCyV3whhuy/CGtRqow+55OhwIGgXAAv8Z1tUaGOT7lrglIWBw9z2Kc1NLL9QlJUbx7cV16kcS6078Nqb8rd79AQqzy4sfmtt6a6klHIE0unlayE1JwNhHhZKXtmaJQUmmg9uH8ociA3UwDbdh3iOSI28k9IBC2HKhGOvg3mjzpsUapVoB6ZLXZY3VCJpBjEh2HRUJuw5HG+CKb9kIBaeKv8YiUYkJ21iyU5nDnAq7MvV3xZD5j0r0ACTFXHRX/dcLuRqygguw+Em7gCkga14uHiz07u3TZ49bt6yM85e7K4WdX+emk0L5Oj3tXb/0pgmeGucREbn2X8z4HKJKL4UUwrX7zK3E6lu6UqVVfqxtF1aT5n8mRHqeP4p7DKY/eNTRQK49xbLYCs/aFNDKBXj6GGFvMOQbBvb0pXSz+44hCjNcdok52edMXte9ACfHsul5rloxUsp0ojI4tv0qPX2O0FF1rxIJeTzc6NDBBxbfadaAKxaeTZothXBjUStjr49KXRuRgFMdaY77rFi/4Fe0ZQepyo2YLX/fOPp7AtZfUyeD64mrAjwKfdzAdpIV86U1lzgJJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003)(22082099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFBTW91R1hiNklQTDJxRkNQS2F2NGNVN3ZXcjBTeWphTUxHU3ovSTFybUw5?=
 =?utf-8?B?WW9FeHMzRWxGb05yUkR3REdUM20zY3ZxU000dWE3S2s3cnNpamp4N3pDS3lz?=
 =?utf-8?B?VlhmbmJLcEpkTjJTVmxoNk8xMHpHNksvYUF0dFJWYXlET0F0QlhxR2N6SHgz?=
 =?utf-8?B?dGhlbUpRL25VUW9MY3V0RHhWL0h2V0xIRzVObG5rMUJkNGxPUlhCVDArcTFR?=
 =?utf-8?B?d3JUeFdRQmYvMmFIOVlTRDNBWTh4UjB6c0gxamJOcGhkME5BVWt6SEg1RkFD?=
 =?utf-8?B?Ny9YQ2haVjMveVN0eGprZTBmUXJWK2pTMFhRYVZ1TE00N1JjdnBkUG5SMDM2?=
 =?utf-8?B?SzUrcnhjM3pyTEJ3UnlKWmV6My94U29VTVU0TzdBZXh2a3VscjV4ZUZ6bVAx?=
 =?utf-8?B?QlRyTS9LMHNXZ04yVVNFNGpqZktSWGQrOUlQWWV4S0twbkRQY3JIZ3FWSW8w?=
 =?utf-8?B?U1RjbnFtRG03Nk5NRWFxMXlBbGtEeDVYNEpxVC9JZzlYSEZFKzB6MlcwdGFV?=
 =?utf-8?B?MVJDdFpMMVQrMGNaYTIxOFBIbXVKOXlLZUs5eHZYODZXK0pkMFZLc3FLSmt5?=
 =?utf-8?B?Tk9TaURqT0V6ZEsxZGV5UmQ5d1VyNmVKSjlyUDA0U21DMURJRVZqK1paT0sz?=
 =?utf-8?B?TWcyOWVrenJrSkM1Ylk1S2xzcG9NNS9YejFuZnExTlZPMkZIYmNKYVVDbDVF?=
 =?utf-8?B?ajVCMmVhcnM5Z2ZrN2RlODBkbnZWOTlUa0thTXIvZDBwdXp5YzlkWnhrS010?=
 =?utf-8?B?bkVRaDJMeWxoMmx4MWdrMHkyTWg1V1h6QzRFcU90ZDZmQlRvZnpidE1Yb0dr?=
 =?utf-8?B?eFo5a244VEFnZnZyTCtaejYzMkw2UkNYbGowR2hWd3dwT2tFZmRNaXVvSDBr?=
 =?utf-8?B?ZDZ3WWlkRm56MDFEZSt0Y0dNSkFUWkIxREhrVDJuOU5QQ2dzQ0tJVjgzeGEy?=
 =?utf-8?B?dHliVTN0dFd4SlMreXBmSkhUaDN1dzVnTTZ6emdmREtJMTRQbVRyQWF6cUNI?=
 =?utf-8?B?akYybHEya0FNNiszaWI0NFJCZkJQTjdycE1XdTBtZDJoWjRMaWhyQjVkYzFU?=
 =?utf-8?B?aWZIS29yOTVHMUJvRzlZTEJMVDBUUlB4Q283NWE3NGVOY1JBMWJVdk4wOUlj?=
 =?utf-8?B?UmRFdGEzTVQyeEk1dUhRS1RyQk5ZcnN0QnBWOWtHUFhMTWpkZlc0bFlQb3hQ?=
 =?utf-8?B?STJ0SGNSa3MrTzFBK3Z4enJVZExVWGpFY1hvaUF1cVdGVndWSE9PZkthYWV1?=
 =?utf-8?B?aWc1TkZQdUFaUkVRdFRKamFuZ05uUWVUVE1RZXErZkFtUGtXclZqeGI4d1gr?=
 =?utf-8?B?YmlUaGpGdUZkY0tHNXNoTTgxWHNWQURLOXFacUc3c3p3bjFlZW5yUGp6NStJ?=
 =?utf-8?B?VUV3U0RZWlo3TE50NEw3OG5Dc2RXMTZPNk5NSTUrUDRiN3I5T3B5YkVlYVRq?=
 =?utf-8?B?bkFENHFhdUFQME94YnMvUnpaTGQ4MUtIK1dhbWl4SGZMN215Sk14L2tDZnhl?=
 =?utf-8?B?Mm9uQjlqM0RmdngzUU44VTRsZzNCTjRqZjVmWm9yMkEybExCQUZudGwzWkVS?=
 =?utf-8?B?R29UQlhPUWwvcDNoTWR6WCt5QUlvOUVCMTFmK2RzOVpheXMzL0hnWjI4Z3pM?=
 =?utf-8?B?K0N5TU0xNkJBQ2tjekY3UEFkVmZJYkdva0JST3lUaWgvRm14aEFFWWFXQXUr?=
 =?utf-8?B?Njd0anJHeUZueWlEQU9ZdnJoWmY4MHUzSnFRNlZ1TFNlbGc3bGR1RStqaGRN?=
 =?utf-8?B?RVhrby9VeUY0NlV6NkhGeGluUkNXVDFpcllXellsekJ4cW1ablN4UnUyNVo2?=
 =?utf-8?B?YlRTVXdxZUFaVmNYZ3RYMGV4bmZPZmlDcmhMSGVhdGtsWmNCV0NtR1FBdzZI?=
 =?utf-8?B?QWhsaU9zamFQZWovUXlRUC8xQ0dpdUs1SFh4U3ZiYmd2amxHMkVxQ29KRjMy?=
 =?utf-8?B?NUNMUzFmVUJEQmhJZVFIbVd5bERXdkFvR1ZRL3FxUHBEczRDMlVPTEp4bEhY?=
 =?utf-8?B?THZxSTNJWDk0enRaNUtrenhVYTZHZDBBUkNXb2hhdVg3Q2U2VTVHd1BhK0N6?=
 =?utf-8?B?V3lLa1ZObzh2OC8wTHBTcUJzdkF0ZUQ4TTlkTVprVGhnZmVuQW5RYUszMVdp?=
 =?utf-8?B?ZFFLb0hhZTJDUVp6MG5XbldiQTlKVEJNRlZsOXAvOXdIbUdKNnA2M0Qrdnlq?=
 =?utf-8?B?MmxXKzlUQWUvTHBFbFErbTgrYnJjY2ljWjFjTGlUT2ZkSmlyMytleUxHejh4?=
 =?utf-8?B?Z0w2bStzZ2hvS1AxaTNubzRoUGFpQnFjMUJCb0NnUVVGc2pEUFIxSFJVNmNJ?=
 =?utf-8?B?aFZuWXlqai9rN3p3VzZqZ2RPTDFTb3BuNjhxckVNK2xDS25vMm5NWjlpQWlS?=
 =?utf-8?Q?xE6yhTz6yurd01wU=3D?=
X-Exchange-RoutingPolicyChecked: ypbaZKmpT0EmwNuzPNP6Jei1nCwhNXu/5My5WeUi2Mim3/ud6nKHwSDnz1imX6EfBfxnJ/aGonp6Hbm8USeZoatmBHefb2u0dE+jWb/jHRO9RTZYI4zY8inyU0V/iYn9/oxB1iZkZn3UUjcKvKus3V1OOBdmS3w1Qjyex8t00zhns5okcELYfwqkCeCfWj4jOVLzEb5QTEl3D01OZCmLoI2j2fBBPyPJLIQzcB6RZvKajcXP6X21Pa0wKOKxsTc3y1mS4OrN+95u6c0g8Ko87JWLFIBNgzNVzjuWhDyn1iRc8RkaLOU5nAWBCTxwlMKTLq2HZSJDN4D/jA3mJnvsYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df71fa5-abec-4e84-d9d7-08df29683122
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:25:58.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/LEiAo7UASY5LP3MbnttRP6/I0POUf/19NoCSEzP1qIpkK5oHU0xjvyPxTU26hQG3Asg1UhuhUUD7j5g82fMKGhW+Ijn9Mhz32MLtcXkMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/13/26 11:52 AM, Babu Moger wrote:
> On 10/13/26 13:22, Reinette Chatre wrote:
>> On 10/13/26 9:51 AM, Babu Moger wrote:
>>> On 10/13/26 10:57, Ben Horgan wrote:
>>>> On 10/10/2026 00:44, Babu Moger wrote:
>>>>> When the user switches counter assignment mode by writing "mbm_event" to
>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>>>> exposed to user space as mbm_assign_on_mkdir.
>>>>>
>>>>> Even though counter auto-assignment is enabled, groups that already exist
>>>>> at the time of the switch, including the default group created at mount,
>>>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>>>> assigns a counter by hand.
>>>>>
>>>>> Walk every existing CTRL_MON and its MON children after the reset and
>>>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>>>> same per-group state that auto-assignment would have produced. There may be
>>>>> fewer available counters than MBM events across the existing groups; in
>>>>> that case stop assignment when no counters remain. Events in the remaining
>>>>> groups read "Unassigned", matching the behavior of creating a group when no
>>>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>>>> comments to account for the new callers.
>>>>>
>>>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>> v4: Changelog update (Reinette's input).
>>>>>       Function comment update for rdtgroup_assign_cntrs().
>>>>>
>>>>> v3: Changelog update.
>>>>>       Code comment cleanup.
>>>>>       Added Cc to stable.
>>>>>       Added Reported-by and Closes tags.
>>>>>
>>>>> v2: New patch.
>>>>>       This patch addresses the Sashiko comment about documentation issue where
>>>>>       counters are not assigned automatically when mode is switched to mbm_event.
>>>>>       https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>       In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>>>       monitoring groups should be assigned counters whenever counters are available.
>>>>>       This provides a smooth transition between modes and aligns the behavior with
>>>>>       the existing auto-assignment mechanism.
>>>>
>>>>
>>>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>>>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>>>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>>>> domain is brought back online.
>>>>
>>>> For illustration on an MPAM model I see:
>>>>
>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>> mbm_total_bytes:2=e;3=e
>>>>
>>>> # offline one domain
>>>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>> mbm_total_bytes:3=e
>>>>
>>>> # bring the domain back online
>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>>>
>>> Interesting.
>>>
>>> We don't know the previous state. What if it looked like this before the CPU was taken offline?
>>>
>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>> mbm_total_bytes:2=_;3=e
>>>
>>> In that case, forcing auto-assignment may not be the right thing to do.
>>> Since we don't know the previous state, we can only speculate.
>>>
>>> It may be best to leave this decision to the user.
>> I think this raises an important point. To get a better idea I looked back at the original
>> bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
>> that bug.
>>
>> Let me elaborate ...
>>
>> The bug reported by Sashiko was in response to the patch that added a step to
>> "Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
>> mode. The rest of the example was not changed to accommodate the assign mode change
>> and the documentation thus reflected the state of a system that was in mbm_event mode when
>> the resource groups were created, not in the new default mode.
>>
>> In this new version of the series the documentation change looks different - it does
>> not imply that the system started out in default mode and thus does not imply any
>> mode under which those resource groups were created.
>>
>> I agree with your final statement "It may be best to leave this decision to the user.".
>> It is not possible for resctrl to know how user intends to assign counters. Why not just
>> leave them all unassigned when switching to mbm_event mode?
>>
> 
> That is a good point. We can do that.
> 
> Should we treat the default group as a special case and handle it differently?
I am missing why the default group is special here. As I understand user space
can allocate counters to the events belonging to the default group just the same
as any other group. Could you please elaborate what sets the default group apart here?

Reinette



