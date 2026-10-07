Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2703955EF;
	Wed,  7 Oct 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411708; cv=fail; b=L5s1hQ3IMuIMIvR54VoR8P1pLePiYtO1BwlpQbfMHizcLvL/WvoW6wW5l9Mvpkg5aqJFQcDeF9JqIRrQiWKVGFMA0s86tkjNNzXwgktAdoCfHTSWis6613eyl3DKrJ/KmKSnFfLaJniNDGiw/07dqXGG1IM0UINzBxKedi41XgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411708; c=relaxed/simple;
	bh=+g1B+5+m19qZCfrZ9icN21pQdT+SjoCgRTAhqIAOjv0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6vFNXAtpFDPomMt/BVJDl9GqlUSSNskDPqOKbReS3u1jLFpzLLG8pcA/IIqYGBm1bS5LuQN6xJvPSm+TQOXsyNwN+hzY+RU6GHvsnWHoovxTnigqcLhXvSgdDZ/xSKLpuKIWpqUwc3+84dQ8BTAHMzpUex9OTaPQNquVjVxw/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jc1JbmHx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jc1JbmHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791411707; x=1822947707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+g1B+5+m19qZCfrZ9icN21pQdT+SjoCgRTAhqIAOjv0=;
  b=Jc1JbmHxFqLHCjSTIFeN5K5OBF+v575BqhMwK/xOm++EVSc0RLfbFT2R
   rwGHaBdcGeDJ2cKMxaGZHyN0h2l8mFvJLkFAXXMTqxCO8inc7LtHt0aqt
   QqP4buJKfyY6grtjLo3viqRx1JszCu8w8M00LwPINlCxOaw4SF9qTUUql
   dV0/0xNddP8BOtOnocjVHYE8KewUGSuOYCh0iL9cE03RAwYzmF46xJXGz
   uL10OFN1Kk9GJHqklZXqZDUFIcH5mx8eT82FICCHKIve7y6Z1LEDC9cwb
   zBSyxQOV5cmxA6HvU7Fyp6O4eOa+Ss7vRYFowcHZ3KgJERfE4rQnj2RL1
   A==;
X-CSE-ConnectionGUID: UVOl3wguTZSuj7mDjewCpQ==
X-CSE-MsgGUID: Km5G0WvDRf6Oz0kAM52Jsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="192480"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="192480"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:21:46 -0700
X-CSE-ConnectionGUID: f9ZQE8KcQb6DaFeGzUz4iA==
X-CSE-MsgGUID: xrghvoU8Qy640pHtWkPJXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="280777789"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:21:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:21:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 15:21:45 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKUlzh/OvhCNhH3ad2dkPTfqs/C2ihulMdst8DZjiQ4eVShki/ynTCgXzxuLqiUiNi+6QIHd+aQJiac77HLnKaOwVRi/+nWCP599mx199gAyQoLcUUJM0AsOF2ypBjL6lJLiOWYh7Hg01TSAbT3RiLuV9KZjeEVh+bkZ1yWmiK9ILLfkI2wA5W3UbpfQ20cLeoAfopyi6kp24QxkF0CSiA38ioyIus+/NZRbFTrlEExPLQRQ1g8iyH9ORehiPpXwyT+C0dR4F9aviV9wVpKZSIIcfvcUQDZm2jzZhWbvCixIvN/ojKQxOYHSJTWCsbs5mZu1Jlh9rkkchY6f9T4d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljOdc3+MbnGnripp6zJPLARDPFDZH34uojvLGZcYczk=;
 b=vSVONSUgdcozyfgtfcQy7zoAw50B7Y8d4F/9WTt6crnKl+DyKYy2jSErpJnOLUqzocP3vlQwlT0pRrzMKGYeTCU4D9RfNmmZoGKMSohV3N25TPDYhdu8ImPuZXtMoRVZzLOkcCAU6geaF4RyQ4A/XWsJ6Tl+PCjwC6ZMx3HZM9IeTB8EQroWAB/6Ymgn1K9PR4sK6+nQOaqD9CMA74wm8s5lJq6U8hylQybddej4tBPn7QWDSCzz2nLM6KTRlqf6FeYN8/LlSWa4freTGEYXOZ+lgeyCEBHCMV9ekrs5227WR8CZrEbJdJT3XMuYPXNO8+f2JEFza0mEQ0KsvvVk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 22:21:42 +0000
Received: from CH3PR11MB8384.namprd11.prod.outlook.com
 ([fe80::5e40:8c87:950c:993e]) by CH3PR11MB8384.namprd11.prod.outlook.com
 ([fe80::5e40:8c87:950c:993e%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 22:21:42 +0000
Message-ID: <a174730e-147e-4b7b-a8f8-e62f5709fef1@intel.com>
Date: Wed, 7 Oct 2026 15:21:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1790976400.git.babu.moger@amd.com>
 <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
 <4afdd80e-45cd-4d42-b871-fb25e1fd5fa9@intel.com>
 <d40a16dd-2e3f-49b4-a36e-33b0ca8adf3f@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d40a16dd-2e3f-49b4-a36e-33b0ca8adf3f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To CH3PR11MB8384.namprd11.prod.outlook.com
 (2603:10b6:610:176::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8384:EE_|DM3PPFCBDC4B878:EE_
X-MS-Office365-Filtering-Correlation-Id: 75662f60-211a-47a0-5e02-08df24c15d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4PX31lFtn1BxzNhLiMtKaPWdivBUpLUVmFpx7/ajGgBmAOAu4w7e8vcSbwI6eL4fgYAThr2kDaLpRuGZZt5Dhr8ABhwZiZyGUDe9mR3amjQnpau3CRit6q437nUFJYkp8BXB/XsD2AqoFHLycWyx8Bjg9cVyB6wNcScvqFvw/7Hzi1LMStv5Jg7NGvMat0/F42CReq9ACU8JdQbxf85LxZ6wSYmo9Ty2eOBOHJs46z9fcan/4nooGlxYWNd3TJbchWYtgs2w8C2LRRpBtUYyewQHZgE4K3sGLbg2xohtf2c1y7DdXhC133hR5jcNg4QM4EiaKILW8oPTce/GEST4KtKpro4RqTlco7ILuf6DK5SJe9PwG6P5fcPl83AtNZ/k7LrMaVCgwG9jP8j5Cb1NWcXV+sJvoGbHu9IoWHLONhh3N42bGKe/6ndQAbDiTZxJBVPl3+5fAlVCZ7uu669JC5OhHFqLRuCEG+lKsVXLdMyoi7frgqV7I2YAqnJyxvgkat0zPjcSVJRvnghglFSNtKfT7LxjmJRH/+JMGy/s6MkJyHBYrKnwCnLQsyJm4GMCnpolFA9Ry2ccVLzomaJD8eeQpSwnt/FE+2L9E2B243oK98H5nd9LIucxIN1RLgDzWn3lD4Ij+ik2o6XDvUl36Tr9O80z/ff0amJ38OM2XRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHFPc3BoSDVBQ3dGaWE0ZDZCR3JuNG1MOWRoeTduY0x2WCtndjFLOGh0dlQ0?=
 =?utf-8?B?T3BSYUJjcUNIMllKOXVRWTNOU3NJVVEwS3VuY1V3ZmpwWWovQ3JGTzUzVEQ4?=
 =?utf-8?B?bS9aSUQ0TWdTVEw2V0R0dUpqbHFYVUgrUFNnKzhPQ3hYN0U0bWxSbzRNeENQ?=
 =?utf-8?B?V0RFcHU4OUVvNEZ6NGtOVzI1UDJ2YkxjTERJUmlrS09pZzB3UkhvME5IWmtn?=
 =?utf-8?B?WXN3dCtaM2FGRHhUc2xZMVUwMHFQR1RRc3BrSmVJbng5aEp3c0FZK1BLVU9E?=
 =?utf-8?B?TFUwMHFtNWt3QjJTQWE5aUlHWlVNSFErcTJNYTBmM3c2RXBYck5RU2VwaG4r?=
 =?utf-8?B?VnRKc2RGWXI5c0VQOFc3Y3dqdFFpYjd5RmhmUnRUMDJqUHQ0eXcwaTcwOXZK?=
 =?utf-8?B?NUpZQlpFdTJxUi9NU0U3dUw2RlVqNGY3Um5pajdYekF1Nng0Y2pLZzZVMG41?=
 =?utf-8?B?RGZWbDZRVHpIc3RPOUk4TkJrNi94OEgrUlJkdlFGcmxrMDNhcHN6Q29EUnFR?=
 =?utf-8?B?NTRnTTl1K1hWbDJIY2hob3JjOHBOZ2YwUjJSTURwSC9xTGNMQzlMODVWekpW?=
 =?utf-8?B?MzBra3pTeUJESklSWURWV28yTHNKTjRuc1NZSnJaWEJJTERmSDU2Vzhrc3p4?=
 =?utf-8?B?dTV3cXVjcmsrRUxodEY0WVhlNmtBL0ZVdEF5ZTA0ZVJCUllBajFLUHZrbHh0?=
 =?utf-8?B?dHhNaXN4akxjOVBBQm16TVhhcFh0NXFlL3hUUUluOHp3ejVVVU8yWXJBZHor?=
 =?utf-8?B?Z0ZiUVg0ZmZpSHFaRXdKUG1Wd3k0ZDRaZDNzMlpDZmdTdm5jWjdrOXA0QlpT?=
 =?utf-8?B?UFZWWGxUeGVueFYwQlpaS3orNDVzUjZuanYyQ0lmdVZ6eHk0dEJtdjgrdExn?=
 =?utf-8?B?eFZVdU42TXNJemdkTVVRZEU3K2ZrUWdjNnE1TXpZaUpJQk1zQndrZ0xxQy9v?=
 =?utf-8?B?Z3lsSzh5akp3WWJNSjNwcU8xTmRWOHQ5UXNUMG8vSk1pRHBMNWwxdkF1b252?=
 =?utf-8?B?L2hBUVJzVk11eWJkRDFFRk82YkRtNHRFUEdPNEFYc2FiN0t1TSt6bkNUd1NJ?=
 =?utf-8?B?akhRMExrRnFxTnBwZDREVkZad0RyRW5RU2UzTlNSL2trbE54M0hPRVljV1pQ?=
 =?utf-8?B?T25HOFZvNkZrT1VLZ3J6MXVOVnlBaHVWT0NodTJyYlp3S3VyZHlpTjVJR1Js?=
 =?utf-8?B?RWdKZlc1d2tDNVhHalVBYVRrOUxTV1AwT0IrdFU0THFDVnBoZlRvaGhMTDJM?=
 =?utf-8?B?SEVMd3Zacks2c1dLN01BdTlKYWZFSE02ei9IQ284Z3VoU0l1eEptOTBLTUg4?=
 =?utf-8?B?VGNTeWM2cnJZb0k0S3dpNm5JK3g1eFIxNkNKOE5mNlp0bkRIWmpMVmdYSlF3?=
 =?utf-8?B?SHNBTjJmL1l3VHJVdGZxRU12clpPSE96N3BkbDE3Uld4b3lnQmlObWs0dXMv?=
 =?utf-8?B?RDZDdXlQSlpETzFRTVk1NWl4eG12OWNNaWFXWEgxKzZZNW5YTUxwOE9rWmNK?=
 =?utf-8?B?ZExYWE9uSlc0YVV6cWpMR2xaY0ZWdHE3OFRZOE9nTS9qS1pIM2FIbzF1dkFS?=
 =?utf-8?B?MG0yM1pLcmpSMEI3b0ZISko0NEhSaU9qR1ZlaHUveGVXS2EzQnZDQSt4RCsz?=
 =?utf-8?B?d1V6UDdsNWNLQmRzamxqOHJTM0c5TkMwVytId21NaW9WeDJ1K2hmN3RkdkpT?=
 =?utf-8?B?VzZJM0pJZWEzOEEzeFE4TzdhMyt5YUFqU0tQQUxjR3NlbUFaa1NNaldBWCtZ?=
 =?utf-8?B?UGN0SDh0N3hkUm5qVkdIMXQvSzFRMnFEbnFBam5CK3hROHBvQnN1WWNNOENY?=
 =?utf-8?B?dVB4S2FhZTVSYWR6K2Y5czMrUmVCZFRaRDFJaWs3empMZ1FZRUYyM0RCK3Er?=
 =?utf-8?B?emdRZGgzejBlcFBFVENlcllkOGxRTmhGSU5idFhOajF0eUxmVmNHbXQ4Rmh6?=
 =?utf-8?B?bjhsd0pjcERZY2JvajFZc1RoeFpsUnVpYm44c2xqL3MrTzZNUHo0cVpxVU1S?=
 =?utf-8?B?YmovSWwvcXB1MUZFZGMrTVJaS0ZVelpsNkhuT3Q2Y2xjU3BBS2F1TG9Objgr?=
 =?utf-8?B?ODRMUXhqYnRmanBLWkE2aG85VXR5NjU2MC84ckwzRHY0ZzA3eDJTaHQraTlo?=
 =?utf-8?B?dDVFY0NjTjRaTnJ2SWVFakVTUlJJQ1Z3TUgzbC9SVnh6WXFLOEZHdCt2RUtl?=
 =?utf-8?B?aTZQOXBLK3FKTGVmUE1ySkJ6SmRZeUtRcDV2MFV0Mm1oWThkR1JJQmQrMUxW?=
 =?utf-8?B?U3VGbHpickZVNU1WTmFkTDFudHE2UGNZcS9tQ3FaTm9JMmJlRXRab3E2NHox?=
 =?utf-8?B?RjhycXF3ZEVPMk9CdVNUL3BBcDVzTzYwN0J0V3VpYzlVcEwxZytHWCtTUzZo?=
 =?utf-8?Q?32B0BflS+078EpPw=3D?=
X-Exchange-RoutingPolicyChecked: xOr4pKz6TWKTa6+ehfONTqL/OZiY5seK+EReP9PBvBcVOjvDId8OFdUXbXGJWaKGuHw0/UXjO/NoUr0JcSpnYazUaHguGEwkJIqOiEVmiw475yhhZ8Qw7J4r7FPmMWZapoxu76FchcMNsbQK6ygav0ldbRyf7G/br6b2JE5zgpOcdQWsGYZ7VEaP5vrlG2i7nUiBaKUfpqi0W7HvuXTiOn5rU/gTe6Nvqnm5TXID9eFnXlJv/ZovvmeCwq+4r0jGdalUFH/z94FZNZK6lfb1Y717hFppz+nJ0LlKB3J9ULnSjS8DlTfb28HER16I5NJur9cvfT417ebRfjuDqcRGFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75662f60-211a-47a0-5e02-08df24c15d36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:21:42.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8ThpkIqFYJNvahW27q+1V/ACEw2wmdRptOKXT9L7S29OkgGvGdLgFYZN5P418BR6XnubsX+x3vnzPh7uRanazxR8y2ycTtC+b0QDf5bRPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

Hi Babu,

On 10/7/26 11:16 AM, Babu Moger wrote:
> How about this?
> 
> /*
>  * rdtgroup_assign_cntrs() - Assign counters to MBM events.
>  *
>  * Each group can accommodate two counters per domain: one for the total
>  * event and one for the local event. Assignments may fail due to the limited
>  * number of counters. However, it is not necessary to return failure.

This drops the original motivation for why an error is not returned, leaving 
the claim that "it is not necessary" to return a failure without an explanation
why.

An example that adds a motivation:

 /*
  * rdtgroup_assign_cntrs() - Assign counters to enabled MBM events of a
  *                         resource group
  *
  * Each group can accommodate two counters per domain: one for the total
  * event and one for the local event. Assignments may fail due to the limited
  * number of counters.
  *
  * Intended to be called in auto assignment scenarios ("mbm_assign_on_mkdir"
  * enabled in "mbm_event" counter assignment mode) where counter assignment is
  * not required to succeed. Thus no failure is returned. Users can modify the
  * counter assignments afterwards if needed.
  */


>  * Users have the option to modify the counter assignments later if needed.
>  */
Reinette
