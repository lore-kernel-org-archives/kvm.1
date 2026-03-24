Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DA33D6C7;
	Tue, 24 Mar 2026 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392821; cv=fail; b=oSm8UZAIKJ9p2HZ7p+vw88S/LtytdfhkncgtLscjnqvCbD/b7HqtpTYlqqDdbTcIQeEAIiSsnS3qtGevkGSRad2Q4Eu0a4kngzITMxLfiHnqQOSVz6Yc+P+QS+wq1Laag2tcDqa6mUfmWqMtOJZGefyWQbrz1hba8z2tfgTmbJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392821; c=relaxed/simple;
	bh=kkGtChZ5RMwPqrGby8VHgTbuqluT4NiIA/JGWqXcN+s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7JYPBp0yPzhzCA1mKo6WKoqH3c3Z5oKsa6tqMzCur1NcrQGfJjZEW6Vm+qxYn4jzq3Hf0Hv3Lp9NcQaya7bKFMYbneHCoio1ntqPRlG5nARlEQblDsFqIUOStLn4LCSAtFYVagox8ErbqUOgUZSeU2b3Kpgz7cArLYhI/b2ups=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRWYR7HN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRWYR7HN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774392820; x=1805928820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kkGtChZ5RMwPqrGby8VHgTbuqluT4NiIA/JGWqXcN+s=;
  b=NRWYR7HNO1RxF2ONDkXlY8JfHdnI1IMD+1OB3KYFegcqMeuMkjW2M2fr
   OIRU7sGpLN3HSX5wKVsWtjWqNWjjceCR9MlTWAIQcc5sgVLD2RgF9caKY
   9y9SLVTqHshTOAdO0eGvqEon0tp7Co8n5iIelHUYbniJXE650e7S+/tJF
   QJislGXx8nR7WqALvm5eJgDlO2b2WcR+WIofJK/arDES1hZyVNW045huF
   2cWJRC1l4ed/h7jbseSuIdVlBQ0q8R40i53P1kyfHhPsL3Ba65ZO7PNic
   O3Vhh/JHhJLTw5DusnkyGNXGMN7GaxEk/B4OZjrcVLb2j3Pg/dBBmTXAD
   w==;
X-CSE-ConnectionGUID: BNfmbzftRWiyIHgKJQi9Kw==
X-CSE-MsgGUID: b8LjynW4QXCwzhIfq9WJsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85733377"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="85733377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:53:39 -0700
X-CSE-ConnectionGUID: iLVlzHe6TtycLRQYsNqnrQ==
X-CSE-MsgGUID: ZKbhOvdLRuq1dmxL/pHleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="219625816"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:53:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:53:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 15:53:38 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzoUlDTUg5flNZ6b90ua1PDD0arUqlfbZU6ZlRARJG7Ycnh14aPztBY8KTZ4CXzU/n5X0JBhu57dVPKcemxSGVnsLJlD+2blbuZr36kYzEe7tlV17SEP3lWA6E36SORhsncXxXIPDX9dznr8fZWn2xcLIfMU+MaTMq7n5I9MqBPdAal4kC8dhIjkCRfL3hZqWRIdMOtQiGPFgryj3PAsDzWRcz5aVvfdm+lPpx6J8Ld1jXUDKOq+hiaixrA9Drlq+mBfT3y2HfnUtzeTyuURxeicmO6qClVZbHCp13XrzwFXlPCzxdb0XjHFAZ+6/iBsce7jKxjM5Vv/jM5Mq001cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G17J8DDjwRv2ViprkqS5IGGjhSspVTL9Z2Vus5sYPFA=;
 b=kfN+NEn7WHIP32270jpsSa4r/tNpBeMCeTH4cxmVLuTfdxgtkGvR4+KaPWgbIPi0FCcnJwAdl/tRTgHob0UE2/hVNuthYq/Nmb5iOLUBsyx5DoCqYdIdQmza5mgP01tni0ojDsvAj3BQlLOkkiWt3AK0miSAXjWvUm98IX2bZY2ujto9TVDTpAlxOaResiyrIZph/4zLHQ6hiL4Bvr0Vs+KHS3lPX/utXf6nPfL7I+gvW6uu0JWAyfJue6gP+wW7Hsie/GC4a+pupurqA3qpMpFJpvDy6qU971QYzXqQrTZQVrEKyBRWAL95iYTPEq61sKBVrLlZXheKQdQs9iRX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 22:53:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:53:28 +0000
Message-ID: <3ef56c9c-cfe4-4e3c-8598-f2217e538c8c@intel.com>
Date: Tue, 24 Mar 2026 15:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] fs, x86/resctrl: Add architecture routines for
 kernel mode initialization
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <72315f83ddf35b0de53fb911f46623782d95f507.1773347820.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <72315f83ddf35b0de53fb911f46623782d95f507.1773347820.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: a883e3a1-47a1-447b-cee7-08de89f829b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info: ivJactal699GlcYeVSR88JlvcjSALBjIe8BzadMlKZcysBIqJ9YUviHsBthwnZ7r1ijB0PbTCPUi4cCn9KMdfV1jAApBE+/1KOdu2odSid4sdpx/S4YhJ94y5oroDoTNXhmKs/+VOCGMjpnXw9xhc79cGLsxDhm2DN3gBx4xGhDZkqfRxJsqpwbjsi2y6BrYk9qpPGxfr7Je6pl1aPQa5zJEaDTp1sz7X6swVkb5PcPEdCcvFU9erJ7tx06LADzV4AYLHrDNPZqItfYgpDfNbDEz755wMzNaNwKrBNuRQSG8UFMjbofpCVUbpYqAsvZRX8jabL12SAEVGaApZI1pYQWVz9XSqcwNhrhTPLGY1Ftfd7JzEiPxhZQsO5e3ka+OLd8wf02pd8cJEGL0B2OpahG1RL8YQ7bcykDN0uTyCdRRpT8bLCpZrLWRc13kWhMOGlerRIDu17ij5S9xd+On052HVzv48DKHUlwLOPqj4dN5JuaUki3pwdb0dMFjBUAyVWv7D2rldCjHRCitK0DzlUCx4ctM5wn2OI4wG61t1SYZm94K18+neuG1gsTRwf/Au/BuodvK9iKvimMnOJ666XgJWcwjIPQpXb+lauC0PXVPWUZUSz9nEeWUG6e5sWe9o65Gll7JGD0vHkQJYNVTbAO55iUVRctWuGZMqf4Og3DHB3Rp4o3Iw64s4uWPU3nd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNPdmJ5V3d3ZUxHUmdMZHRXYXpHdmFQWXQzdm1jU2NtU2lPVUxyOGtTWlgw?=
 =?utf-8?B?Vysra2tyemh0aTJ2dlcwVE1JSlVzNmlVWFUwZ0tBT1RMbWtvNUpBa1FnRzU0?=
 =?utf-8?B?QnFNME55R0oxQk40enFFdmQ2a0lrTnBxSzFwTkRybGhOcDc4WDdCUXBTZlhH?=
 =?utf-8?B?ZlJJZWJ6TWR2aHBWZVFsa2dQL0Q3RlI3NDYxVUhvdjMvSUc1a1BrYjdDT2Zk?=
 =?utf-8?B?TWZsUHA0Ymtla2J1aWJrdzNINjRSWTRnemkzM29sNE9TcUhjcnZDRHJYWmFk?=
 =?utf-8?B?U1pBYW9kMHNtWU9pNDMyOUFoRzRxUzF1MTBvR21GU3BuaytvZ2h6WEs2M3hD?=
 =?utf-8?B?bWx6bzFaWmhvL3UxS0RIcUxLSVFNaEo0T3VnYWQwQVNOMGh3MEtYeWlxWE14?=
 =?utf-8?B?Y1dmRG85OFQyMUVBUjMyc1VOSmxJb0ZPOHI5UUlTVmRwUHJlZUVVU3A1VFJH?=
 =?utf-8?B?UFlFb0ZRcE84OTRyeDFqQlh4ZERNVVljZ1B3Nm5aNW00NTY5RlJNdjNmMFpY?=
 =?utf-8?B?ajQ4VmJpbm53Q3luUndzVjhiMlk4THIwcXdUd3Q3YTJzcnh1NlFFQlQyVWYz?=
 =?utf-8?B?VXZybzZUVHFrS21ieTJZV091cFpSbEZaeEpmV1RHaUttUUpBMlNNL3hYaEpl?=
 =?utf-8?B?b0tuMDZzZEUzTDBiRkFIUEVObExOTXdJaFEyb1NGdERGZGsvWkUwKzFKTXd1?=
 =?utf-8?B?RFpSSWNRRDJIVjREMjZJU2UzaUNvOVhkNXIyZTY4ck96bGVIQk44Ym5XeE9a?=
 =?utf-8?B?TFZFL3FWUlNNdWYrK3ViRjVEdWd5S1N0TDYwSFlPd3pvVGhxMEtlRXBwSkhX?=
 =?utf-8?B?YUJSeHlRWWQvdFQ1bE9QeE9KbGJoUGE1OHI0aE1kT2UwSENmazN6ekhnSm1D?=
 =?utf-8?B?ZGJtdHl5aFEybCsrRW80QkxQNE1qNmZSSEFoa0Yra1ZLQ3pDL2tUdEVLMkdH?=
 =?utf-8?B?MjRIOGZWRDZrc1RRZUQyOXhWU2NaTW9NSTFiWDl4VVB3cDY5ZTI2WHB1YW4z?=
 =?utf-8?B?VHBBd0FqWE11emNKdFFoTVpwcUVrYTJjcXJxSnBIcko4UWdsTUtOQVlaOHhj?=
 =?utf-8?B?Z3h5Q1R1TkFWU0g1SVZvbnp2T1I4OFVORENmT2x5aUxQZ01NZEZnMnZkZFVM?=
 =?utf-8?B?Rms0bUM3MHU4Z1BTaS9LSU5uREZXbVIzdFhFMDBTaXN6UHhQbXdNQmYrYmJZ?=
 =?utf-8?B?SnByV1A2b3FjZmt5T3hNVTAzVWttV2dNaThGVWdyMlMzcUI5VXh0d0Rmdjd0?=
 =?utf-8?B?RGtJR1piQTJpdEhLNklhNlcrcENMQTZ5MEhvelF6MkQ1WGs4ODlVZGNZVEF4?=
 =?utf-8?B?RXFLdkxXNU1tNjNQd0pXWGdtS3o5eW42YjJBTmJNOUxkTERJZS9mNU9tVkRa?=
 =?utf-8?B?TXd3ZnFBYk9FdTNuRjhCMitYYzVkeEZDS3FiRWdWU3A3R0VPamFjclowZU1h?=
 =?utf-8?B?aXE0WGRrOFdnSnR5UGxMWWNMbFcxYXNRT0NiODFGeFBHYkNBNi90MmNWVWor?=
 =?utf-8?B?alJVM3U5anRzRWdIVWorSjJrdURaVFpOOHhxWXcwRmpBMFVhUzBzTUlDalVE?=
 =?utf-8?B?THEyck52OERHdFJDcGwyWjlaN2p6WStYZ292WE0xZWg1MXEvbm9La25zMyt6?=
 =?utf-8?B?UG10TmxSdWMyVHZUSm02VVgxZUFnOGh3cFJzaHpQYUFxTitCcExnRUJJQk5H?=
 =?utf-8?B?Q3FDcS9BWTRZeXA5Z0ZvUDdlcWEwY2Nwb21BckNPb3pUZzZCR09wOVlBNE1v?=
 =?utf-8?B?RjNoakF0YmNjYStZeFV0bVpEZnRVdHFINS9UNmlndzhhclZVQzRBbzc4dHZk?=
 =?utf-8?B?SXNNOXZKZURBeWpHRHRuakFCT3R2R0szOGZKcFZ3K0E3SXRXZU96a2pkWjJH?=
 =?utf-8?B?ZklBTlJzSG1OL1F3SGZmazhYRTdVTGpJOVZGVmJPUDFLVVp0R25Ud25laDdT?=
 =?utf-8?B?bHVoNDNBL2pNUTNoWHAvT2M5aW9CclVFemRoUWpIMlZ0ZVhsems4dkQrZUY3?=
 =?utf-8?B?VGppaGQ5MFVvdExGclRYL0MvRmV2TU90Nlh5Q2NmN0k5VFZhSFptS2dhdkgy?=
 =?utf-8?B?MkVzT2JFOWp6cmoraGNPSDlLMDRyUmVKaWYrRDJ3eEhNM1ByOS9BMVRsemlD?=
 =?utf-8?B?b2liemNjU0VzWmZERlNEdnI5Nmp1LzVHSkpXMHZwNHQ3dkhSNS8wMHdwdHVY?=
 =?utf-8?B?dnh0RjhVNTk4ek5TTGtoV0Z2VFRkYVI0aWhibzBydWZLaHROQmVtaGovdUVx?=
 =?utf-8?B?Z1dOaUU1YmhGYlBuZFhZa2pJblBmVjhycmg3M2Q4WGp4S1NVcDlSRWpGZklG?=
 =?utf-8?B?VlhoWTRidmR3WXBOdXBsZzdqODJkcDJtSUpudXhqTnlvQksvUk03UDI2K3k0?=
 =?utf-8?Q?U0kFmQlvA7bz5MkU=3D?=
X-Exchange-RoutingPolicyChecked: Iq+yTevL6ff3uSEnsy7Kwj2RPd7KdnQzcbwQPy5FjaK/isc5Ly+/ymCWrHVFT2Ay1ssXVL/DP1TmGDtJ8l5kMp1kIsPZjOpwSUacPQtn98Z741ypmgvV0E2IcOEg//xArexkeBE4rynF536N7Pg229lIFkZ7pZUm0mI0+z/c6+p5iSeJCrSAaCyL4g9BbTvwLA73F4exoxnfJFmB9LNJ/jW3HEgVyVJneym6e4c8RrpfCpFfYEWgJvuiFb1I024i8/4sHcqA2O1ROb+ZwME/r5Ufmm+CNMsC/8lgQ3JuvQR/aMN4xjFW5GgFeFxsslJnTPiXIOBZD2T46OjrmYIl+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a883e3a1-47a1-447b-cee7-08de89f829b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 22:53:27.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdx3TJTbRLWpv2RTRdMQ33fzYTHjTik5stG3mlXRz2gnVk0Lb1GJqEHw2hmrxTGNqANVf5gaA/JxYbuhWhYq48d/CMEOH6Dy5hJoSCHc49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/26 1:36 PM, Babu Moger wrote:
> Implement the resctrl kernel mode (kmode) arch initialization.
> 
> - Add resctrl_arch_get_kmode_cfg() to fill the default kernel mode
>   (INHERIT_CTRL_AND_MON). This can be extended later (e.g. for PLZA) to set
>   additional modes.

I do not think this is something that the architecture should set, at least
at this time. Every mode has different requirements and this just lets the arch set
it without any support for what configurations it implies. For example, if
arch sets a different default mode than INHERIT_CTRL_AND_MON then PQR_PLZA_ASSOC
needs to be programmed as the CPUs come online and this does not seem to
accommodate this. This implementation appears to have significant assumptions on
what architecture will end up setting since it is only considering PLZA.

> 
> - Add global resctrl_kcfg and resctrl_kmode_init() to initialize default
>   values.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
>     https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
> ---
>  arch/x86/kernel/cpu/resctrl/core.c |  7 +++++++
>  fs/resctrl/rdtgroup.c              | 10 ++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7667cf7c4e94..4c3ab2d93909 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -892,6 +892,13 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
>  	}
>  }
>  
> +void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg)
> +{
> +	kcfg->kmode = INHERIT_CTRL_AND_MON;
> +	kcfg->kmode_cur = INHERIT_CTRL_AND_MON;
> +	kcfg->k_rdtgrp = NULL;
> +}

I already commented on the arch vs filesystem settings.

When using an arch helper this forces all architectures to support this helper. Is a
helper required? Is it perhaps possible for arch to set a property instead? For example,
how enumeration is handled? 
I think the assumption here is that INHERIT_CTRL_AND_MON is the default and expected to
be supported by all architectures. I do not see why arch should set this as default but
instead this should be from resctrl fs. At the same time it is expected that the
architecture supports this mode so there needs to be a failure if an architecture does
not support this mode?

I'm going to stop here. I think the comments so far may result in major changes already
making further detailed review of patches unnecessary.

Reinette
