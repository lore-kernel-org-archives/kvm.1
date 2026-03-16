Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F42248A0
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631284; cv=fail; b=fIVhX/cAmoTqBamLDi//y6VMZFJsau+8NbnaZOTd6QH7owi9EVWLAOYI6n7xEfM/TGJo3XDOsxT1boFX4UquBNWLebC7Vor5dnUN9Q/gO/FjRmRTd0ysfWmdg0udmPrGSIQvr1HrdWtTlUX9URkXCu8WPK7B0qmgbFMKTxGn3/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631284; c=relaxed/simple;
	bh=KxnEqgrK8irVSDX7PGESc8wixroVCHiCBq6GZzT/l2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jIafmuE5+GwCblLpZvIWxKn6MvH/uvQX/ejA7Nmb3Kv5v3fm/VK/OMcm2XutFN7AGJj3hYrmTPg29e5Or0y3Vtjv+8xfztPHDeUtAvomVuflIRAYKRErUq0eyc2EiOl80aYLPN7ivLjUPy/Z7Q/Z/s36Z5e45a//8GWsepuVOzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYtpRrjM; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYtpRrjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773631281; x=1805167281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KxnEqgrK8irVSDX7PGESc8wixroVCHiCBq6GZzT/l2I=;
  b=IYtpRrjMx2uCDU389xKhF3eubDI68bhgnn1aKlEgd879i1VYKRTUnrpP
   Gnv+9QQ4Pd9uEeYLP5ZLoY895+OgD7NNf8gyD8/qqm0QH1ElmV7osjO3Z
   6zNOc2oN/uTAoduyhIPsEd+FivqJMSDOigdU9MCK00KotY4FaWvyx5Mzc
   sOfZ1oojqKgGb5TgpWAUKlb6g8tWAk9uEfi7As1WdcUonlqRq2dOfnr5U
   qpL1Fr9KD+5vl9sJ+1K1Pcvh8buSgUVMsyZB/aDffzjTd0JPWOK5X3Hoa
   0quSUEv1/3BEvJFmHhKlRCMiEqBlJ1oPwqf+xIJ8VVAX0y4EObFDztEO4
   Q==;
X-CSE-ConnectionGUID: yQngEM6+QpS4LIu93Jc4Zg==
X-CSE-MsgGUID: Pd/t5f0ZRbO0YKUoqtydoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74536352"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74536352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 20:21:21 -0700
X-CSE-ConnectionGUID: hFLXV72USXebwOx7ZX8OgA==
X-CSE-MsgGUID: 0q1i7TkQSEKukOodgxvT7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="224032159"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 20:21:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 20:21:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 20:21:19 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 20:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBAUWr1ssuG96t5MIk6m1JttAGFGTwA8EeFm0L6biU9d8LR4i9MPBlSjZA6k7CEvFfi4qfnhBdOPPcocmN7+ezLCYlNxPo4iNmWl6N++/wIeXzYmTKQ0vrKgkyYulaS2bnzWuQruXIYPA7wqXw2SeTx9/61z/TK/O64ismauufRJkTwXr1owYosknllWg61FqcHLuwo+wJhjZ4brW1Nq4m9VPc86GowxRmexXvXkhau0rbxsSE+Lb0vxYxTd0ZoxT8g1chpg+1/Lu03xPV/DLyIoeqoZQl/BymiLnhvfBAu9aBUynzpyQGafHFoIxeqqxA6cecvduSQxrtSv7h46sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIJp8tkBh9iUI1oYWSPofuyiZs/ayXf6g4muGJJFmgM=;
 b=VzCIAtoa8GYczZlYoBYLs6kN4bbSw+bhSnqU1mIA/wkw9oXDuuVuLxo4YB+qoHmOGuqONA6ILB4+u5jXRWglD/9z9mPX+u9dQ7tuxd+E7M4LZi8wCMr6bteNrKqFsJaM5G51Q43anLHKeuMbJwk2jBtBDeD4VoeThqMb/zal7DiSlCBx+klAZ4ZMqtYOjxwAT65qZB2DGZX+7hjkETWSRNidfhQLC8Jndxrp2LaWSHWClfBjo6M++w+gQ8oYvKZrCQVxXoBCFizQbS0KjKrYU6l8yBJ6Y1TgebqiIfaY5oqUqCVdNBbovkXgJ/Yb/+IUcqL7yG3GUZHJUp0sBTaCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 03:21:17 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 03:21:16 +0000
Message-ID: <9122d003-1e96-4790-ab32-3e06b0aa1148@intel.com>
Date: Mon, 16 Mar 2026 11:21:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
To: Zide Chen <zide.chen@intel.com>, <qemu-devel@nongnu.org>,
	<kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu
	<zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>, Xiaoyao Li
	<xiaoyao.li@intel.com>
CC: Dongli Zhang <dongli.zhang@oracle.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-13-zide.chen@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20260304180713.360471-13-zide.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA1PR11MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0b6ff8-915b-4358-0ca7-08de830b15b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aMBfYS36mEQP2IPHoe4oJcTxrMFCJYX2gyJcSzFDi9H0Xshdisxuc9TrrJz1mKTRSDotjBwaKkCAttwDoNYqvh019o3MWWS0Mpls7bC+uiv3mjP4+d9+puz5TWeAdObeLmxu07Uso1CaB9eYxexfainqIZt3n/f4A3RzhIkga9z0zhNfjRSKTh7moexhCjtOBMLZzSuxCzm1nfY/yzLEd5MlnLxdELd7AM/m5sAXqDC6tDuO8kIUuKaXRFc8GMsPYQWIu6+g94vKXHDgeMvtewoMYaHx0ZCHX3eD4PqIFQdx1blxhqzFVQD0wlnBxHS6cPkVrXPexaPJ6m10ZudKB4v52NTMc5Ng3xaVdxGm6Wq0E+lrEBItM3gv9VxeSh6J4XmRPL4V3ldpgbnFU9ywI9u1qWyi1GEKw1nhzqDJVO0YwJpBZyLUS1S4xrzrXEqVA0r4mqonFylP5CaS5c7I3dbLGMGo9240Z4KKePCRi1hna7Gs/nazXlBvF3630O2h7Em3x8J7+/dJ9eI60XEunf1gjxlzaHdusJ5Zx8ElEXQexf2TsfjOmIuinJ9mmyysacCpA5a8Sl7TC1EySVUv4QJR88G7xwh9ICsB2zqfg8y6rmn9Odn1u4K9Ny9ASpBTUO+4JcHF4hJsBVc7yd2eT6Y0l+dlo2TfH74t/whv+p/R4bsG8aIKKkmMMcT/Az3/c+ke6NZZ9QE9DhcrGYmMdyi4goxgIZLQeTAMbAY2Vcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGcrYmhweWthbW1IakZIUUUxTld3T0Jya295ek9rbExpaHFyVm0yeG5CMDRo?=
 =?utf-8?B?NUhQZnQ0Q3FKamxPVUZBNmlLVTFQZHhkMmg3d1pMZUVZQU5GYnJkZ3VwdG13?=
 =?utf-8?B?RXplbzI0aWRDeTFZTU9wbHp5TDB4U3ZWUkNuakdqdnQxVDB4Qmx1ODRrdmts?=
 =?utf-8?B?MUs3S016bGdQb3RGZnhHakFjR0dtV2VZaWRkeGcxU2RUL2h0RFJ6STZ1dXky?=
 =?utf-8?B?TU9OVElESUZFbFdYQUpsWE9VZGxUMmN5WW5nU0EzK3grUUNKUEM1S0NvYTBM?=
 =?utf-8?B?MzZ6S0Z1N2ViZVlTdlpMUlJ6TGRCcTlnVCtLUjg5a29qSzN3ZUx3SGVSeFRh?=
 =?utf-8?B?dExDWUxQK3Q0T1o4eWhCRlVBTXpzQzMzRW41S3kvZU9hT01ZWXJHZzNST1BE?=
 =?utf-8?B?RGI2Qi9GZ3BONnBWcS83NUtrVEFCTkhwcWs2YldHWXBwK3psRDZ5Uzg1T1ZE?=
 =?utf-8?B?dVFDVnlSV2hrVXgvZSt0SUxaV2Y2ODkrdmpBN2pXNFFKQlptYjU4YmEzakU4?=
 =?utf-8?B?eXQxUS85blNQWmhuNU1DK1N4SEFjNzRGVFFoWVliN0pUNmhzL0RYN1FZK0xa?=
 =?utf-8?B?bTR3Yyt2OXUzWXJYRGovUHhRZm1KU0hjZGQ3VTl5Q0VtSGRDWGEvdlJiYzZx?=
 =?utf-8?B?a3dleXRTckxqL0J6NXBueDVpSFI2N0ZZZFJMU244OHQvZ2pLbnJXZXFhQlcx?=
 =?utf-8?B?T3haZ3MxZTlmeFlIWUs2ZGxoNjdkdHpGbUROWnd4aVRxYWRVbjJPMzRoVGRu?=
 =?utf-8?B?U0k3cG1ScHd5bjhxNTdOWDlkVGhtcTVnd3ZQNjJkWDc2ajFRazlxb3hTbG81?=
 =?utf-8?B?MkpUbmtzVEwyRENzRE4wY1k4RTByamE0VXprMTZnbUxBMlN0T3ZQNFBQR2Va?=
 =?utf-8?B?RnpETWxrcFNBaHRFc0FSRk92WGlMTDd5RkFjWVZETlkyOVlnZUVWajZGeG1y?=
 =?utf-8?B?VGwxczVPcDVvMk9hSjRZUzhwbjNZMlJFSHlwRG4rSlhPdk0yZmhMMGQ2cDNG?=
 =?utf-8?B?blhzVWJUVTlzRitvRXIxbEQ0Wk1uTzR2Y292a3FwUUxqR05wRmJaMDlkTklG?=
 =?utf-8?B?NGFJM1ZQMWMxN3BLQUJGSmdLUDNuSFBoTGpmQTRFQWJtZmw3NlBKNFpqTEVK?=
 =?utf-8?B?NGpCOVM2MDZPN0ZTcS9QeVFZVnlnZ1RJMDg5dElXa2ZVSjNPVURmQzRyQXZr?=
 =?utf-8?B?TGpuL1JkN1JBai90SjJiUVBDRzBwUi9CdllCVUJzMXNwZFZQa1JVd3VYcUZ0?=
 =?utf-8?B?WEgzT1dQTytMYkJnRWdoK2JwUElGRWdad2tIbDdTbG5pLzNoUFFtMnJDNHR3?=
 =?utf-8?B?dG9ObnZJREpFQXg5SVZubWJHZE9OYzJDaWI5Sk9aRlBTQ3VqcjMxcXpvTlhq?=
 =?utf-8?B?QjdYQlYwVkFqcDdPdzY3TVlZUnNOU2hYQ08rVE12bjlvSGRkNThIWjB2czZO?=
 =?utf-8?B?TzdwR2JYL0RGVjJ4MFlGN3Q1M280cTY3dXFUQ1dzV1dQT1hBUDU0VXlQNXdM?=
 =?utf-8?B?NzJGU21hcElvNEtlWEFNYU5FMVd3N0l2RnNhMHA1SFNBYjJPUmQ5VTVVYjdw?=
 =?utf-8?B?c0NNeEVOQ3NCZG1iNEVyUCt2ZDQ5L1JmUmtMWjVwc2ZjTnMyM0VPZmhtZ2U1?=
 =?utf-8?B?bVpJQ213Z1poRGllQllUZi9qQklLblBtTFNJSVVsalhxYVQ4RmVhRU9XcVVo?=
 =?utf-8?B?aCthT3BXTjdsYjh5ZDZXLytJVkljdXBjTXl3N2xWaSs1RjM5ZjdyYnZkeHN3?=
 =?utf-8?B?a0E0ZG5YZHNZcVJ4N1NMdDdqVHNLL2wvd0FsTzVIbUpJN3N0ZytXRHUwYlQr?=
 =?utf-8?B?UXE4cTBBbnMyVHh4bTVHbW9kRWFsYk04OTRaQUdCaXVaTGFCR1VYMHhFK1ZF?=
 =?utf-8?B?aU1TaUMrRTBMcE1CdG8waEd6aFVoU09MUTFNUkxhOUtneHcrWVd3bGU5bVZ0?=
 =?utf-8?B?SzR3NGljb1V1MHljYkZ6aW5pVWMydWZ5a2g4REliaFNqZmFLUFZFK1g0WlBa?=
 =?utf-8?B?K2xxOHpHd0N4T21IVlVvUGxXbG9DYXEvMW92M3dlS0tpcmhZaHZSNHdSTVJR?=
 =?utf-8?B?NHFaOUp4Z1dPbHRYUW0vdFJBNnpuSEMzbWxXR3g0ZW5teHRzaUlVVFJyQUFm?=
 =?utf-8?B?SWNLOG1OWUszZnc3VU9ueEtKMU5aRC83dldTS1V3a0dyVXlaZ3EvbmNUS3pO?=
 =?utf-8?B?ZVYyaUpKVk1qVFljakI0OGp0cjI4NEV1UDN3dy9YYkp0bHlPdVJoemQydC9q?=
 =?utf-8?B?UUloZHIwSzdQUmtPUHZ4VUtlTFF2ZUd4L29naElVdDFqZHo3WVBxMGpoOWdL?=
 =?utf-8?B?UllTQ1Y1b2FudGxFcHB6WlY2K3R1NUdob0o4Q0Q5QVR2YmhGUTlVZz09?=
X-Exchange-RoutingPolicyChecked: d4gicEmsr7K9x7R4ZrKVhMeGxX9F5QPv2vqiNdv7tJKLz4xtJxEjyc1ieWkS2EJtqBPWaET7jEfsmoR+ujKEmrA4xg8yl75T+UB44Iiy39BP1ABHt9GlAKFuJT6M6e3Y6ymxdfF0MUt7EQQ+qGXyJKsoLvDGDm/9xt6+ihbuG/8W7SQgqpqaqJpkg85QKQ1tFzSoOfnCqbSrYmzN7I5hAXR1ekXKZGQtW6rAAVi44z0IEP73NApwx01Axq4ATDL5DgYye0iuEP5xyjnVOkvp5+48J2cyFiiF9q6AKWj78hL+IgXESV1R+10jp7adZPMvoaKP5USZecwwxlOXJvJFcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0b6ff8-915b-4358-0ca7-08de830b15b4
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:21:16.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjZQx8Ba/B4neRs9LOmaAAoKGDMf4IevHCEfIaxAo+M8IK65w2uzOoUeLvvv0ZUlZrq02AqtaetdbdTWBZauEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com



On 3/5/2026 2:07 AM, Zide Chen wrote:
> - 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
> - When PMU is disabled, Debug Store must not be exposed to the guest,
>   which implicitly disables legacy DS-based PEBS.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3:
> - Update title to be more accurate.
> - Make DTES64 depend on DS.
> - Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
> - Clean up the commit message.
> 
> V2: New patch.
> ---
>  target/i386/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2e1dea65d708..3ff9f76cf7da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
>          .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
>          .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
>      },
> +    {
> +        .from = { FEAT_1_EDX,               CPUID_DTS},
> +        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
> +    },
>      {
>          .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
>          .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
> @@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>          }
>  
> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
>          env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;

This change, along with the original CPUID_7_0_EDX_ARCH_LBR clear, will also affect the configuration for TD VMs. 
For a TD VM, enable_pmu controls TDX_TD_ATTRIBUTES_PERFMON, CPUID_DTS is fixed to 1, and arch_lbr is controlled by XFAM[15].
These features' configuration do not have dependencies on each other. So how about skipping the TD VM case like:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98e95d0842..458bfb07b9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9736,8 +9736,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }

-        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
-        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
+        if (!is_tdx_vm()) {
+            env->features[FEAT_1_EDX] &= ~CPUID_DTS;
+            env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
+        }
     }

     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {



>      }
>  

