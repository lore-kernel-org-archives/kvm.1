Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C0346AE1;
	Tue, 21 Apr 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809075; cv=fail; b=d2ta7wqbaaIbK8LkSJzg3/U1mIThmYBZ2cYr9XzvZRn9leKGBZt/QLk8KY1ti7ql3vzEv9xGiWLr/vRZzwAHNEu61e1+UPhk6ZRz6DRqu6Xv3vEPuZY+zmOOFadY/rsgkCPe3rPemNPGIKzGjPDIvJztElaG444kRJSGdiyXWWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809075; c=relaxed/simple;
	bh=1Y1xf0Y+TquZmTAwBTIjZHp9gSfQeTGa+FuIBbHyH8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XYCru5t7WOzeTZ1K646eFETObMUEJ2Bn0IrDN8w34GmFNsVfOKSRlk9ka9Vq2cuNL6Za7D4470/lRdaB6V8cqEzl6ibbqMFUPN4AWO6+KPH/EB1HVh113uW63TZc8yWbNg5D1vhCUDge/NTiEUMgd0aiao+g2yImFocBccOewZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kl67e94U; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kl67e94U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8oo/ehJdWWq1w7Gsi2DiOXLq/hL+eW/qf2JcNzyRp6zgTg/ZeFC+KEwVIDmb7TNKUiIRxrbxeGMwLIY9K7dRpDzgQqcw8ps1MatVXdV3gft2uclekhd5wIfwdlOmq9/RYo7cc1ee0XqAQHgX+0/pBrhJyi3LdZIkPYmYdqN1X0bwBK5SZwV2fCBhKBaUy1ybOKMfWbh5zktdvc2yeJWzNDfOvl1MO7oaj4TN+ekgQcIrljfhaUTQhSfj4oAPxlOvOvMiY8sAourl6m6LXb1wnlRIyykg4/oFDCf6r19kNZsDARfZzHVGc13ChMrQ0tUzAxA93Q0+8jHyADBIu7n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy9wbIoss1B5kCI9pZ/MOX/6xjJ83xEOUZVCy3c9Z14=;
 b=TbVE5AgBKmXN27/RAhUdT7YB6gWy4g0XHZFDsVjxxO2D9S+AHL91GR4srLeMwGZ4xUyKTU8T+mUw1uAXG59U8eX9s67J/YKuuBYyOxLTicBRxZUqdvFXGaMV2+eL9+2HDtQKRnEDM0cC2HR8aVpt6g5ZwDvrem+8YOT5bkG3F2yrkPH4k/4W3pcJcPFZemVJDvWuDxgJCDl+/gvQF2Qqb65f5SmRZ7je8vRcpoeQXrf3EjxW7och4vT2Somv/Wxn2mOIZ8Ms7sLCXj456qza03RJxiW9+lZKZUm+OSyuekn+PQlnwXpRfQLm/ru/eTitS6NWbnPkVW8RrObtXHhR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy9wbIoss1B5kCI9pZ/MOX/6xjJ83xEOUZVCy3c9Z14=;
 b=Kl67e94Udq+FYSBQax5dPA1xjM/jAjGZRM10EB7dJSNVnEgoPm5INRkbAjUckC92GpsK8B89wcJqY2Xu8UMqi19ivkM+PwWMVSIvdUstqF04WlzQ/p+YSPdtvvuq+20Dqjs5J0ohInbuTyuxJSJewyEOfXnmCew+4pAEJd4u3Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by DS7PR12MB5887.namprd12.prod.outlook.com
 (2603:10b6:8:7a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 22:04:28 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9818.017; Tue, 21 Apr 2026
 22:04:28 +0000
Message-ID: <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
Date: Tue, 21 Apr 2026 17:04:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>, "elver@google.com" <elver@google.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "safinaskar@gmail.com" <safinaskar@gmail.com>,
 "fvdl@google.com" <fvdl@google.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com"
 <tiala@microsoft.com>, "chang.seok.bae@intel.com"
 <chang.seok.bae@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eranian@google.com" <eranian@google.com>,
 "peternewman@google.com" <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
 <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:d3::20) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb9ea92-307d-4341-593d-08de9ff1f506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	5o4cvgHxqdU1BCSR0qv7fNTxiV7TpDy9h61wpbUxVol538126crWHgs6yyt+ArJHdnfmEwuq75IQ+jrrZMoVCFn7F8rDjhqTR5/QU56AdUakDJinOE7SytQEaRZ13UBwhymi717h1OtDddgezqisr/JUXZ4geCECIeKHOkGXdtJvl6Hr5RVuQp7NcVcHoZV73qoeXL/8ZtBUmuyjblf+5fDlYHkd3IfMKyatReL2bZUA5y6N2G/yf5o5KCG1VBkph1mJn8e+0jQ2+F9m44A5kBttMgfLr1PqYuPE5YB1wgNrs2HBOsbYHnHkxy1pzMo25l/2rmnyHkMjLCO1g1eCKaUp0qExl5WTp9f6UA+8VVe4Eykg3OIg5XGNb5RfVfWj811EzmBI6k/TT0jqSyzKP2wz8qRHds0SeAn6PqdGvxixRqp0mau78SnU7tqnqLAvw1XKBfoIIAWxu/Ika1F2J09s99O22kcyn8dVuUskjB7lM3bSvPrKlToVjkNA+XQqewHgU0tbAdJW4nzXa4+Z4FCzMgIqNxggdgFgNZIKlI3Gv8d0W+x6cX8qV3nHG8CrQefM2ur0twOr0E2OC1da/QbzrxTveL1FRPpa+1QZoeJt+6UgY/touMZqtLWMU8V4Q5ZTzk2fX99P1O7jP4Y6Wc9MRelFN5F1tfNJkEErblKnhMlHpn/RxakF1F5PqNQK6Vt6Ema7dBm9FbugZdvX4KGtC21qgn/PSKHBBKri3VrqxBRwKSR62D6AVsOOhLDpu64+FU/6r2hr6Bx10OlIMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZkZjBiYTRWVFZ1eXhKQlFZbUhLSTcrTUxEYXB3SGtSUHhaamkwYUczNDVL?=
 =?utf-8?B?UWdpVEpGVFRFMnFrbDJ3dWprOVNRNmJLLzJxYisxRWY4ekNzNmZNNk5YVmFs?=
 =?utf-8?B?dXRIQ0JZUkVVVVl5SEkvY0EwYkVRMW9LamliYk1kMFhvZE9ub2JiU1NmUHR4?=
 =?utf-8?B?RHMwUUdvbWJzT0ovdS9CczBYWHEvRWdXQVNSNXU2ajJIYkRaYWxGY3pLMVVM?=
 =?utf-8?B?YldyNDBvNFhCdFc3cVgzcXZDdGlYd0NXZmMweHF5djUzK2tZeEhKR0pnM21p?=
 =?utf-8?B?dmVjWjIrUm5oQ0tIalFqU3p0QytHU3lrb0hSUk8wUTdRTU1VdTdTdU9jWGZ6?=
 =?utf-8?B?U2prOGRGNGN0UURHS0hqaTl1VXcrVkFMTjRWRUNmS0hyR0xzb1kxb24vWFFo?=
 =?utf-8?B?OW9CRmtGVzZDaXRIendiNU93MDNIUm5kVFVlVnpYT1k0SGEwcGRZd2NicFZa?=
 =?utf-8?B?TDUzNW5lNGV2ZU5MSTJUYlJjRlY2d0tNOVVUK1N3VE1ydlNtL0ZTKzBScndP?=
 =?utf-8?B?WVRCZWlPSm9qWGdIV3pla3VLNml0b0ptUGFmcDVmRlJnTHp4cGkrSnl6ZDBa?=
 =?utf-8?B?UVlnNEkrWElZU3FZc3VLeVRYbm9ORkJOejNiMmladnlyUGFQY2p0MlVwdDQ1?=
 =?utf-8?B?dlNwQWt4eU1ZTnJXNmxNN2JTaDk1Wnp0eEp1ZHgzUTgwdGkrK2M1SytCdTdn?=
 =?utf-8?B?Q1poSGp6MWFZZXRFcCtyTEVEeHoyRE1JRytyK0xQOEdGc1pRZ1BGUWdoRmNx?=
 =?utf-8?B?VFJkU3BaYW9hUVQwd0U3WFJxUTRKVTVuNk4yN1BlbDM0S0dTNlZEL2MydFUr?=
 =?utf-8?B?MnNGYkpXZW5JRU5WcWdJYnRMeHNRd2pYZVFDRnkwZG9XVkZhUWcxN29rUHBJ?=
 =?utf-8?B?dHhrd3Q5cVE2dDU4amwzVmlwV2F1eFpwbStlUlhQWDcxTFR3NEhIZ044d0Vt?=
 =?utf-8?B?RTVPaVNOWEJ3RW5KMndSTmVHTVFTL3ZoYWpVUCtwNHJFK011aENMT2xzTUpq?=
 =?utf-8?B?YVpHbEdHOExuQWtNMFJNWjBYWUlrZ3l1UnQyRjlILzB0aGJyTGlkRTBNMzZh?=
 =?utf-8?B?R1B6NnBhcmdSVmUyam03Q1lyK0tNelFNVE1NU0RTTFJITy9xaDJtL1RhL3c2?=
 =?utf-8?B?U3VHeWdoN1NsVXZwc3BEdlhNZ29EamtxMzNuZHgxc0hDUDROdUdNbGRMdHlk?=
 =?utf-8?B?Vy9ZZHRnZE8zZW55c0dHdnBkSHNVUGZQYmRQNTROVFNKRmdyTUxDZGJaeFZr?=
 =?utf-8?B?VEZZbG4rSzMrUHpCMUxQdVpmN3FMd3JPTFBmTS9NMk9iS2F5a1E0dFNaMWU3?=
 =?utf-8?B?eUVlQ1VlWXQ1U2VxZno2VWZydWtFUGxUcFRuc1RxOVRIRlAzczBldzI0dnlO?=
 =?utf-8?B?U0l2Vkd6VnFkYmRqWGZtcjNPVkpwdUF4aUUwMzRoUTEzYkJxMEZVWThuTE5W?=
 =?utf-8?B?bVZQT01qaTNCNGd0WXk4YWpNV05rNFZ4ZGZGVG5jNThNVkRLTjVrZ2J6emMw?=
 =?utf-8?B?NmZ4U0F5WTFRcmJPcGJEaGFNclRhRWhjQkJrUWVaKzlhMlBkcGtRTU1BdUli?=
 =?utf-8?B?elpXNStoVXFFV21LY3hTYnpRbHhqWHVibDBVNnIyYVdtVGFHRmwxUHd3SUox?=
 =?utf-8?B?TXpVekxhQlJ5MVFRUnZQMkhKM21ONHdZS0VsSmJnY3RLbVQ0L2huQnk0OS9z?=
 =?utf-8?B?b3N4WWw4K2plQ0VPZWcxOUFaZnM2N0NFc0d5MDZMdkx0SHhlL25qbHNMdDhu?=
 =?utf-8?B?WE82NDlFN1QwZkpGTkY1cks2aEdnSmpqQm95M0o2SXhkQUlVeVBZYUwzb1RE?=
 =?utf-8?B?ZzJGUHd4RVA0UnpmMEg0RmdXYmlvUmNGeHJKV3Z1UWI3TWk4T1VUTC9Oektl?=
 =?utf-8?B?YU1nQk1Ddk1aMUhwU3dUejA1bjRRcmd2bnJlMWFTQmw2WHV3ZzU0c3NaU3h2?=
 =?utf-8?B?Sys3VHBtNVhBTTI3Nk5ncTFQRWt3UDMrOVI5RTVoMU80N21zYUhXbUtabDg1?=
 =?utf-8?B?VlNNaU5DMVlDa2NLSUQwMjNKR0UzKzVzT3VwblFCT0haM2NjSzJwTEw3ZUhL?=
 =?utf-8?B?TzEvNDAxTFBpR3J4RGFDY3lMamg5RWdBSTNyRFhBcmdidG9xRkpleWlwY0tQ?=
 =?utf-8?B?LzRrKyt0REJRQWhtMkxSZVBvMU9QQUFnKzdQdi8wbWNsSHpwVytRd2cydG0v?=
 =?utf-8?B?bE43MEJxY1ZOS2xKMVZjdXlXa2ljYzc4SlZKNTdCd09lcGxrUzdDSU0zdU16?=
 =?utf-8?B?TTVsaVhyR3dLNjRFQWpNeU5ldUVzT3RSQzJUYXVBV21YRGRrOUZMS05sU2NC?=
 =?utf-8?Q?FdD/iptEyBml6v543m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb9ea92-307d-4341-593d-08de9ff1f506
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 22:04:28.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LtZlI87mfToM8RuH+THjxoohEzUrlE0ex+7aRk9uRXPfAWvfZPUcHTenwn2cSEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

Hi Reinette,

On 4/21/2026 3:57 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/21/26 11:19 AM, Babu Moger wrote:
>> On 4/21/26 12:35, Reinette Chatre wrote:
>>> On 4/21/26 9:46 AM, Babu Moger wrote:
>>>> On 4/21/26 11:15, Reinette Chatre wrote:
>>>>> On 4/21/26 8:08 AM, Babu Moger wrote:
> 
> 
>>>>>>
>>>>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>>>>
>>>>>> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.
> 
> Here you question why "inherit_ctrl_and_mon" is needed ...
> 
>>>>>>
>>>>>>
>>>>>> System boots up with following options if PLZA is supported.
>>>>>>
>>>>>> # cat info/kernel_mode
>>>>>>          global_assign_ctrl_assign_mon_per_cpu
>>>>>>          global_assign_ctrl_inherit_mon_per_cpu
>>>>>>
>>>>>> No groups are associated with kernel mode at this point.
>>>>>
>>>>> To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
>>>>> above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
>>>>> we will need to add documentation that describes to user space how this file should be interpreted.
>>>>> It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?
>>>>>
>>>>> I think something like below will be more intuitive and not need much additional
>>>>> documentation to understand (I am just adding the "uninitialized" as an example to match text
>>>>> printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
>>>>> the lack of "/" could be used to make it clear what this means?):
>>>>>
>>>>>       # cat info/kernel_mode
>>>>>       [inherit_ctrl_and_mon]
>>>>>       global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>>>>       global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized
>>>>>
> 
> Above I share considerations when thinking whether to keep "inherit_ctrl_and_mon" or not ...
> 
>>>>
>>>> Sounds ok to me.
> 
> ... to which you seem to agree ...
> 
>>>>
>>>>
>>>>> I also think an interface like this would be simpler for user space to use as it (user space) switches
>>>>> between PLZA capable and non-PLZA capable systems since user space need not associate existence of
>>>>> the file with some kernel mode state in addition to actual content of the file when it does exist.
> 
> 
> ... more considerations from me when thinking whether to keep "inherit_ctrl_and_mon" or not ...


My bad. My only motivation was to keep the mode listing display consistent.

That said, I agree we need to support this. Without it, we won’t be able 
to move the group from PLZA to non-PLZA.

# cat info/kernel_mode
     inherit_ctrl_and_mon:
     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
     [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/

# echo "inherit_ctrl_and_mon:group=ctrl1/mon1/" > info/kernel_mode

# cat info/kernel_mode
     inherit_ctrl_and_mon:
     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
     [global_assign_ctrl_assign_mon_per_cpu]:group=uninitialized

Thanks
Babu

