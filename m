Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64B3D45D5;
	Thu, 15 Oct 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075587; cv=fail; b=HUHfSptGlF1xU/T39C7IkaCJO6ahgXxrwBv1a3BO9eyH78u/P/9GnkKkq2rnQuZA9ptXp979GABvQgPZSiCfGZt3YAFJvcwYBKZV0WPbAT+WWSH+cGzpiG/CglS0DF4+hTCZickXC+TVrshdwY0jvumXxWY3akfDKmzGhX4Edt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075587; c=relaxed/simple;
	bh=KsJEdRgWlV7guI+23QOfTlFpEMtat12HKtslrX5W8Tc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rjjjlCQxNZttWuGVasKZTEO5wAvH4ix0CLCAb2kPoMY4Zbdb4QQ8mJTGDZdxtQZK6aPEOV9hlTKOA3FpKZBW5/1xU2Xpjs3hmqiHGWb1dCn7dhTBGhRzGVn9VbTV1moprpkpiGopF4T9jO7Hpkz1MJfcXitsYKMJs5zP/z7mrlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXnldm3l; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXnldm3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792075585; x=1823611585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KsJEdRgWlV7guI+23QOfTlFpEMtat12HKtslrX5W8Tc=;
  b=KXnldm3lcDFE85fcnWzmcf6wYceQWTGpveUJEYrvI0ayQ5AYws4iQTl3
   n9wDiQIfdCzETxsmLJc5SKBz/yt2/Xvrn+5IzpiDoIc66+0D/cCX/K7xI
   wQahwy5QCtJWUBMTty/Y8nuvq7fRSOt9iKczGRxSxC4qyi/l31YAHCnye
   FBqPfeXaSQneKd8XBmThJrNXmhzuNwzra/EbxgbXFR4JJhAKRBaOM2sLd
   jn8f/WtXOuF8Wm15LAqlfMdFu8Xl2NJBJUhgD+lm+B1zGf+MiQFJWLOI5
   yvSu3pLFaMSsdHZi0JzyQ4aP0bOUdGVHO5j166GDQucdMcQe0L4ao0IJF
   g==;
X-CSE-ConnectionGUID: rJA+718CTZWOVWv/WXMddQ==
X-CSE-MsgGUID: zwLIq+G/T/WimESeyx9w/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="880243"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="880243"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:46:23 -0700
X-CSE-ConnectionGUID: jhOxyVdxSNWHIMVDwkQhpQ==
X-CSE-MsgGUID: MPnc3KAtR7O1I50IAXzXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1624150"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:46:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:46:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:46:22 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtTccqdE36JRUS5JC0qJy0nG7esZPa5wmeIhyYKqyOtnAhhT1LeGWrbYJnw+6M39hy3Z4GmCFxEmq6Vrl7opNqbmnRi6thB4/DICwpwcH9rmPPzhNBeoKyXtrkdoArqzlozerP/VV9qWmspylFESPxywNX8l92iE2RgBNI7oILfnO0/zX3bCJMFTKLQOecGoGPmlwjvtWYTMR/BVDgT3kNLdwwz6BwF8Qm+Rxirhb53NElDpkFbd85G83cvVEwDKAPT1ZldFa/hFO6FgyeCTb/9Pm6vmooN5n0dlmzWVwwECk2/SOE/cvtCeUo7P/JKSUw71shyyh/HC4xSmfa83Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLd+0Xhfk8XyV0aFuoiaHsApX1sAivxsInPwQB/Z+sA=;
 b=mcohhlIB86mUiX9cbmMhDjlYdWmK9wt5BB139vKShodqLsiquidFO5Cl75nYl6EK06e8NLiFGdwh8tI0AZSbRGVwsGxj4nR3vCGed2d5Cb6eNUw7k3fDox2A3oaJz5VNhY8odU+bqSfc0ZI+XYNwYXPEQl9OE4mFyxbaf96mNNW0GVQHY7VNJusqO8RO/4B+Q8kWna6+NcBNIXnqNQMucUonSYDD4zdz8F2prCUp6YanagLTiwGTlKNSGD3zqWFZ3Ug1Um4XVabZc9Pb+0O/rL0kLfLUxgwMINFThdyEsTwTbbMSQPM4BTl2UpillXBPoKO2Fk9hRUArdTXwLkqLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by LVXPR11MB9780.namprd11.prod.outlook.com (2603:10b6:408:387::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 14:46:19 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:46:19 +0000
Message-ID: <b3f44e74-dbb6-428d-a746-618b7288df5c@intel.com>
Date: Thu, 15 Oct 2026 07:46:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/18] x86/resctrl: Register
 RESCTRL_GLOBAL_ENABLE_PER_CPU when PLZA is available
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
 <05717f15f11f9e11f6b2a2737f4ed2f01fd9733b.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <05717f15f11f9e11f6b2a2737f4ed2f01fd9733b.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|LVXPR11MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: f469a17b-9f8d-48dd-a0e9-08df2acb12ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261009223027099003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: W/Q7uHL1Dl9KPf9IgnR3CjjubJYzWSxv4yGWheSYif9120itWkVWt+VKC1i1fv36nyS3NcNNlXLVbhkM1ss4i1+z9dGGNMhL4hfddRCJg23PaarL+0JsW1sYxTTlAYK8Q0yscObf/Y/l2ddSJz5Yv2djSWCrhTU0ngXzvnLDKpCr7k3uvrYn6Kk3vZolLD3Ftt4wfur//sa1V5eCoebHJONc8rkcxP0ODVNw/1mPiiE3UX3DhmApBpVa5lV/mbCCg44MzyDL5DHdqmNQCAzKWe5FNRwNd/Z8hG6h2KJ5uDb4QVdZpZ9lOBlmmnjqap+OKeq9XtUAg9CQA2aic/U9uaKJu8MsLl4763X4/5WS8llkwok5w3N3Ouwe+VzUWaeRGGOjoBWBRv/+0DgfVjTc9dpbKC0XGfAPlDPzG1lO7xDSXYvZl0FP+8WjMUf6R+OQNk40ORZ3w11qFc5Czb90I/S+KuoZ+SmxfgoexxvRp0Ktwt6a0NCxR7CQQjVxCdO0FbbMvvvcs7XOmRn6zsg8yizGDC7Ysgea7SW8pjMCKVrbbU4CYrwMcUTOPMCTQxUgZ9SGTLqGMXvpY8WZmMnddR06XOF0uvHoEieDsALgTiro2K2Nnlh8U3/UwK1p2dYhLqU+DoSs4MGwuR6hbjM8dY6B3FsnnBSWWdxPFwWdbws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261009223027099003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lRYmFSRWgzR0JDdU1IUGVORU1YWWo0RCtTd1l6TDFwV2g4M0tGV0xrbmo2?=
 =?utf-8?B?SGs3U25xWkNnR2hqakhTL0JOTllDWW9sMGZ2T0Z6Y1EzNjJjT204WWNyamVS?=
 =?utf-8?B?UFBCb1VTK1kyMmdzVWVRL2NYWENEWjE2QzM1S2NEOUxXejJZM250ZDRaS0pX?=
 =?utf-8?B?b1RCajdFM1VsUjZRYlpSTVhBLzhLM1lNeTFDY1JlMm42ZXVDVlZsVjRtRHkx?=
 =?utf-8?B?NzBtN24xTWNSY3YxQWpJaGg5andtUDFGL0MxWVNsbExJdHhFZ1JZL3ZKcUps?=
 =?utf-8?B?Vkl4eTFGZkhiMC90azRwMllrRDYzaGxQS0FZNGM5aDl3WnJjS1NDdGdJQUxP?=
 =?utf-8?B?czFvc3hBS3BSMkFxK2VWYWt0MGwveU42THlLaTZBODlybjhKNSswM25YK282?=
 =?utf-8?B?ZHczSXdmSG51WUFITXhZRmhSWGwxbk9mSFhNdnNWLzYyYmxwWmRjMjRUQ0lw?=
 =?utf-8?B?RjFQL2RkSGV2aWlBNjJWL1YyZ3lRUEZEa2VNQlErT0R2eFVIMWFMZ3NNTytr?=
 =?utf-8?B?aVB0ODg4Z2J3clVGZFVrUCtKb01XMTcvODBjcm13dG4zc3JKWUN6WElTTEVj?=
 =?utf-8?B?QzhEeTY4UnV4MFBlUUtLUVdrckRrU210MTZxOUQ2MmtqUVpjMDNxa0ZMQXNJ?=
 =?utf-8?B?bDhTY0VZQlVuMEZybnlwQndDL2RGQWxkWDJQOFhEb3RLUi8zRUdqYytUc0pQ?=
 =?utf-8?B?RFRnMWl5SUhNWFRLNlBLMVVhY3lDUVNwZUVrb05ZeGxIRlRsalVwcnduY3Zj?=
 =?utf-8?B?bG1SMXhHZnk5bFJjOE03dmdTMzNXajAwdEpqYTYwWStPRE80VnFGZ21Ja0Vs?=
 =?utf-8?B?eUpxSUlsT0UxeVMyU1dQeVlkVkYwTzVDK0o4V2UxQ0NxcEk0SDI0RGZyQ0Jn?=
 =?utf-8?B?dmtMUGMxanJ0VzkvRHE2cURzWituSXFaRXJ0eVBpV1lXU3JBZktCOEZ2Z0Qx?=
 =?utf-8?B?amExYWk3UUFXdVpNUi9SZDdoUXJ2eWdKMGlEZFNKd2ZLWDAyMWFVMmJneDdz?=
 =?utf-8?B?ZGZZYU1sNXN3bWZsNm5DZXBwenJwMDBuNlQreDF4ZnlKVlRpS3daNDQ3d2FV?=
 =?utf-8?B?Tmx4MEZER1VESGJrK2tPMDZIaGJvSzgzN0k3VGwzeEhET3ExNkQ4Z0tXbzBO?=
 =?utf-8?B?UUZmS2pjc0ZINDZQanY3aGJRMnZyakdkdm9LV1B5WUlHN2diSXhCUTFGN2Jl?=
 =?utf-8?B?OS9Tbzg3cUR6TW9nZktoU1RuVk1Tb2ZnUkwrOHVJUFFjbUE4Q244VFNpTEtt?=
 =?utf-8?B?cDg1TkFQNFIvd0tja0FPa2J0eW1tRDNyS21Wak1Tc3d6dWlkeDdBcXFtdGVs?=
 =?utf-8?B?VW5mODgyQ0VoYzI3bVl4emVKMVlZSzBwU0hLRXpaVVdRWkNLL3E2ZFBBb3dz?=
 =?utf-8?B?T3IwSTNYZ2lsejNsbXZhYmZhWjRWVmJhemE4a3JXL09JRzRQd1pEdUplK0M3?=
 =?utf-8?B?NUNnR2RkRXVNS2t4R2h5K3Zxc2pEU0o4TFkvY1VXbjJLL29YZ0NFSXgwSzBz?=
 =?utf-8?B?UmsxZWZ4NGVKMWkwQWdxN0R3b0VTdGZNanNSZ0VkZmJCcVRVMzAxVko0Nk9H?=
 =?utf-8?B?Snd5RGF5OU9RZXdlVElaeFRIc2hmK2JEdEp6RWtIWXhZNW9QdmZ3K3llbkFn?=
 =?utf-8?B?ZnRKK2t5T2FHNWprQm80dlYrN2tuRVErOUtEMGFYbXh3R2t5RTg1RzE1cmhC?=
 =?utf-8?B?bURsamh4WVlUNXlTbWJxczhpaEJFV2RoTUdKVkJucjhBSEpBWnEzQk1saE4w?=
 =?utf-8?B?Wm4yYkpxN1Vlak4xZXJ3b1ZnVkZyWVBEQys0QSsrWXJiWkdBY3ovckllV283?=
 =?utf-8?B?OWR5dFBOSHVZZjRxaC9HZXlEVXE1Q2o3L3oyMS9taXpQdER1bkRLVFdqVlFM?=
 =?utf-8?B?VDU3Zm5uVUJ2UC9aVUlHMDNrTFk2aVhtQW9MdDh0emxJR0U5bUtBL3ptTTkw?=
 =?utf-8?B?M0NMd3A1Qm1OdzVrYzJKL3piOSs0Zkg2cUlnTXAreThsaEJyWnpOQjRDTGpO?=
 =?utf-8?B?aFdCb2o0cVhRc0g0K3IrWjB3VlN0T09uNzBpUnBMZkJZUlBETU5Fb0VRdGEw?=
 =?utf-8?B?RU1pbTFYeXM1MENkVWRkVE40NDhhY2hwWVBFUFdGOHFNMGNVUUZOQ1B6c1pG?=
 =?utf-8?B?aEFZMGZtaE1XN0VpWXNEMFg3RGxkc1hTcGJYdE0yT21KSjJZbjV0TmtURVkw?=
 =?utf-8?B?cWkvNEoyRWtUaEJqUHc5WlFyWGlNbmhscCs0WlFwRXA1b0RwQWFGclFYSjhk?=
 =?utf-8?B?LzN1MmwwdVlKbTFtL1N5clpmYlhKVUJjOS91dk5PR1pxS0s5Ui9BYURaYXQx?=
 =?utf-8?B?UExRZzFwWTdjelROQ29PalNCUjRranFvOC8ya1ZPRVBqTXA5WktnL1I4OFM5?=
 =?utf-8?Q?2Ztps92GbTMpg8r0=3D?=
X-Exchange-RoutingPolicyChecked: 4W8rWeQ9VhmQO4XKcwHcC56HhT4huD+j7xpi7cIdTlv/npWsEpZ8CAcAWbIMXflx9rXL0ED/SwIWvey5d+HUZkK92inXjYBbQaeAF1TYdJa/VOg1ftr89C8bBrodEN0EzUrzcMuGRL+Tpub0FnDQQB5cgXGNXucqHd9FaeMj8Bmq4wDjL58kNfnLY/MkiEcyGZ1LyRz7i7EbVFX3Tpm1ZTcGWNYs7AgCHkazh0fUBQbXp7ZrMAVJZiXjXixvm1/Zx2jORm7bIoXyvEQS6Vcdiqkq4ct0oprP4JOLHkMziZzLvXTT/vBGZQH3M/QuQIJe22dCE+0QoKruNhwTLVJK3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f469a17b-9f8d-48dd-a0e9-08df2acb12ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:46:19.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9utDxf2io67nRo8yGmukHNLt7CEpvjrxsVP60R6XeA8W60gDco9iUuuGrCQRpeJtwmJsxtexkGkX7OHtNtnPLInFBVCakjBiCIsu6hDgUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9780
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> PLZA (Privilege Level Zero Association) provides the global per-CPU kernel
> mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allowing kernel work to use allocation
> and monitoring associations that differ from user tasks.
> 
> Add x86 support for this kernel mode and make it available through the

nit: This patch does not add any support, it just registers the mode
with resctrl fs (as the subject already indicates). Didn't patch #5 already
claim to add support?

> resctrl kernel-mode infrastructure.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reinette
