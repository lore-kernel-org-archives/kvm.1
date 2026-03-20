Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCD36EA8B;
	Fri, 20 Mar 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994290; cv=fail; b=cT28bKChFJQOulH+MTJYySBvGKS/IyB3c/wCh8TUoT3CiuJ6eFZCiXWovXR8gSP+sYxn16ppwD7t+I1H4OMSidHQncuKgFbr1GPU7+MqxTVWjhJuq9ghr/5IfDJi54ZmiB7LaWvbnCtHxlfGW0cRu50i82qST0jb/hual3UDdsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994290; c=relaxed/simple;
	bh=NDe1m5SYsw5VsGs4J75t+cKqNmL8VAgdh1L4P/WzI+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=STMA0knQTyIKRsn2+6Cqj7IvkTNECsprKdrFCfepph7Dv/RuB6EQdNmIg+O5dRbrjh+yAmCQrt1Vg/MIGqFGMjNJRr5BwQ2xwAfWKzYYozz0GNa1sB3bknocEuXdZTRfMuvLHgMN9vReZ33/Dxw8E1kPcr1UmKi+/AkfMaL9eqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a47I4j1o; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a47I4j1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994289; x=1805530289;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NDe1m5SYsw5VsGs4J75t+cKqNmL8VAgdh1L4P/WzI+g=;
  b=a47I4j1o0rdRY/1yo0sVMBneURjvLyhQiKibOZCQ5EdIxOBemxfkbKll
   F+UkFVW8b4xZddhr96A5gxQbkWrCjnOXRmfPirQG3smm6SgmxdrJ4M1Zl
   2anIh1BWm1Q7ymbB6rT+nZM+xpcrvnJ7+Y9HBw3080kQE0oVN68oxl/O7
   b21EYt0IyT9W+6U1MHTZI3p9Bo0R+UGdPf3330P/oB/8hzCo7BTtlhJnv
   T5QdG6BaQXbkSwyQTFkmBLQP1PNn08vhVvaKHj617N+6CYQRqn1CiFYYq
   WaW362KJH8YNREwJ4uj6XAA8Y2zISBlJFkefPwoG3Haa6HeneMxvynJwf
   Q==;
X-CSE-ConnectionGUID: 25EeFNA9QKmsXLv0SsFBXg==
X-CSE-MsgGUID: ftjWCPGQSyyJkqzcIAMsMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86438176"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86438176"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:11:28 -0700
X-CSE-ConnectionGUID: +Qwe/z16RdqLsTu1E8IKxg==
X-CSE-MsgGUID: OG4YxdIQSFy5TYzr8ark0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220579437"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:11:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:11:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:11:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBsGSeVQUzRilwA3ZhuDc3xBC30CU+Oq9O0sTlr9RnZI1bCq4Av7RdGHUPqEGJnSrNSc+eCQJ4sduwTqmhCCJ16cqRqMUQyiOF/dhXuxtzUGt9M3viPnxufOgs58fcP/H3W9w3y+qnRO1rsrQBJMIs0xEbHVcnvEggxeQ1otBzdBhOVrqfd04X5x1AoO4CHOMIwR5xZaBog5hRuq7avU0BznU1BVlLhyM39koOVRNqkQ7rdrjKMy7QoPc63OvTqbJoHoycM6WZAJebxxZ01v0sp43Z07k5wOQ1BsH7XXEFuI1bK3pSy2nRCWCnV/HnysO8SDpzgR9s86tWBhybpD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbKPfB2Q1KgcQQgO8B+zc2hCa369GwACQTAH5SQZX+g=;
 b=dvo3zTGyXf7u1q8RIigd+e7t2z8DJ/UfkwpksQ/DGgbJf6/65iRfQh9rS3Pzrdjyn879wZ0kmsjQEDZ4FTzewJE3g4atSRUv4PIBg3ql/HK7tYdt7dWpEjsNCOReitU+AjDMR+SKLuBkmUiXYb9zOdbpyM0bDLP7KjAJo0vTiQ6r1kQhmbCprSs1tjZDgiFxXDTgFn7KotYzvNSR99MPq22gkaUGC+eYAL22dws5prDa4yE6OPa4Hc9ZizFPs3vY1rcgVcvN3u2S9OR4N9eoKbFkcf8XCZoBSsXAWecu5tcrwYv4D3uH/MrhUxVzkMfN58rXPyMK+XKBy+frz4xpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Fri, 20 Mar
 2026 08:10:29 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:10:22 +0000
Date: Fri, 20 Mar 2026 16:10:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Message-ID: <ab0A4K4eCFFdb2w6@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-10-chao.gao@intel.com>
 <abv2PWj4jBwm6zKO@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abv2PWj4jBwm6zKO@thinkstation>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ2PR11MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 4286897e-e3cd-4080-dab4-08de86582252
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lA0HnE8CystCZj1SVlgSrzWrg63KCeqwPn7Oslxyn/P4huN7/Pso4woCJR/gti6Q3mPeXuqQYuWH9QJZx82jkuoRkFBStrXEuhnaiM6eiW2r5162/YcDhEUOLxS9sdMXugwsUyWOlEGUXX03CPp8O15x3ZjygglHfI0hZKDNvPiUxyRbuXwrO/XDkd+H0Wi9TcHS6gaWcHW5bk0iZtfZozxxdB95C6lqm7Jw9Yj2IBcqcpAKT2jlbx90Rq2wqI4ZAzS6XlNYOOFRZclgGrQugKT79ePa9QWTky++Aw6+zFjMyGBoST3XKjvW+ifvUK92UmQgak8Xrgg0XOYO2iJBzi71icthYJKpp8ay7r37U6U9Aee2mXMqsoRerx48hVzC1v2zbUA8BumYQOSE3ztz/zquLpKnioX0LWkVYCLCtG/tfCLI9umnFwJJvUd+cXJej44Lp779kmmIzlxQ8I+Don+AKupIP8fEbV1BNtXeLTIYQbmDkZUCH56+FX1OHLu6uyEeDoP9/MQ1KL0nbJR76aGuuuzQu87ZwF0ZROxjRKBqFDl5gZpIp7wgTGWLLD/fXeRvbCfPA7qV34H+wtPSSfCKWjK5rRfgH8WOBXP52SIGsltnFUGBWx7ntoPqiUuXCoCk19pmzQZCDrPmwTfMVSW2u6UtKakd6uDjEGbgCbjLbeZnBXnfHtnQs8flHVQu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0N3J2u6nhh6F5YIvsIEMPxxNbWmd0oxWUpv9rRDSWyuDBASJctREtpnEevGo?=
 =?us-ascii?Q?agRDjbJTh2MUQl6bf53NBrWgjW3685sDVg5yibVMsrZWydWmujyA0adZeb6I?=
 =?us-ascii?Q?BQgTy+M9AeP631+C4A1kE0Uz1YtoLkUfd+wpsAz4z6xa8aP8ivYR1BGx/cLB?=
 =?us-ascii?Q?utMjqxrGsmalKdrWLDBVTXGQJx9VotwegKk4UwweNY35lWcUprE98mTYvt1j?=
 =?us-ascii?Q?1sB4nwUy6CkaTiDmIzJlAkMhcx8hoP631etVFhvWBmgTHqqRTjV4OLmzgDad?=
 =?us-ascii?Q?roFnSif9fFRQsKTmrSOB4dO4AVbzoMqNIGMRFHXP3/Ol+OXvdScpUJtDYqA1?=
 =?us-ascii?Q?jAflBTs51tEzROFSDAne70Hh35TnbLbQ4M2SIFw6f4s8o1e33/wi6AEvJ5GY?=
 =?us-ascii?Q?hlsvFCk8kkcOcEdqg/YZFVAeGcFqvODuZqMIQGAbGdSCIG5iJzKKPatwICam?=
 =?us-ascii?Q?gFUxsRL/ow/uymE54O/1JnnidjoBzJK8kUsehlCrny9MO+z7errLb8ZTjebf?=
 =?us-ascii?Q?fCKI1cVF97FwZwauZd29R2/HLc9kpn2M7sZdlQOmeeppbCGWEGMZX7n5+lAN?=
 =?us-ascii?Q?lBvvJVs7PTfJHXT7A4a88aD+g1X/4gkb64PDHJAh59i60+3a5QyqCC0KSMgE?=
 =?us-ascii?Q?WE8K9fPfSyZvjm72LZ2zoSwwNtCwc/VwKVoHh/1sqYqtNccIbzgz6E4hfb9X?=
 =?us-ascii?Q?7RFqmAmLj4Zoc8DEv7W0qANGEmQKa8DN72uOJK/2QHEcecIyxOvJbl/Rf4Iz?=
 =?us-ascii?Q?8F6bu28JJIftmiaY0c0VW+wVzECdEs9dLb8DVfEnaELDOfRAzr1JL3scBAtj?=
 =?us-ascii?Q?mXaQObWcJL5HIn3ly95HZ/sKKNvROCqHrKsP+NHv2VpYLcaJ8BseZaNy5nTr?=
 =?us-ascii?Q?kOJc+9huLE8w6l2zpYGXa4UCWyZz8zM8+4fdYWrv4gx2waUUceb3uEDElkM3?=
 =?us-ascii?Q?XptOLF+aC2BAggMXYod5rzKh7QHR8wnNUrQ3plY9qhNcyNq+zfr27Y101pWy?=
 =?us-ascii?Q?NCqDQiiNJ3CcysQGaf+8Sy+N6VqH6vJA5q6JyWE6p/6GnkMJXqfhUnU4Xm4g?=
 =?us-ascii?Q?U1eGjlrngfLDB3jJqeTMv7XRYE+WFHrCoG0kdhvbjIsK6RCDSsQQRYvOzVPS?=
 =?us-ascii?Q?AhWEEkSwCohE51l1xqJFOy6UOEyHhXS60V5bPOGeIkKTiNDOxNlXTOtZkSWi?=
 =?us-ascii?Q?LpaP2+Cm+/dk7yWq7l5jdFoMkluL338TFV5zDqAzhYOiXcqhOyZtkvV4vjfm?=
 =?us-ascii?Q?m8PQcE8FALhdqquYWb7p944ZbCgagpKUovPWo3Hb+2ltN1IT817h+mhKvCka?=
 =?us-ascii?Q?1n6ULKhGnNfLZSjy8Wp4CEcSliyfufKCm6X29+i0yLLlJv1uel5TMB67abtp?=
 =?us-ascii?Q?FutoUD9L+W0oURQE2R++hOpYuY/2qKtTRqjMQEupp8HXMvKVLAMEeQ2AMMXx?=
 =?us-ascii?Q?L8vRaNkgPHWLrXfkg0RERFr3bchfOV3T7yPdltWc1yYiktqktCPGw776RLIs?=
 =?us-ascii?Q?Thj0U6ZvlOKDUyFBgy4279qZp/w1kH89lKQpd9RH7gA9J2Xyj6H2POEDWnTW?=
 =?us-ascii?Q?wGUxMpaevgU+dejX3AOFUjd1+JndmJp4tn59CqR2OfWeIADkMNtTebPGM1D4?=
 =?us-ascii?Q?HA+1ZrPxNtGSSlGN/N65I9xYdHqbXkz8Vdbi2KDbWhway5DQJjhdnxmal0Ny?=
 =?us-ascii?Q?fzKwkFSoO1lM4WayzEsI6nmmAnURgiqoYZ4PkCaAobmSfj1DgnCxOlFAXkQN?=
 =?us-ascii?Q?ZfdSfCkfOA=3D=3D?=
X-Exchange-RoutingPolicyChecked: MpdV04/FtJc43sAdIBJ+d9P+e6cR43+eRPKabXuCzoMCuGIGp9ohsWMZLx59yetuu821mfidPUyeJkgxcD+IdiY8DlzuIhv3PudJxkaLiAZbSvaW0575AJ7sOljnALNk+l8sp9+pYxM0h/j/BQ5J1iV+8PA+yb7NLXpQ859nYoMMM3g/z7IrCe72cJRGibZvcH8zwVXCm3iXI2WCG/nALcB0VBpBlXTPgaFYY6qHcCKq8gJFG8N4NaDp6eS/vbLC1OJzxThg5rYKGP6WbDNwRZZ4OCEUAHMR6dUXV3L20OXAXz5UVy4dkBf09uDYq7UQBs7EhbqBxMcabg5jtedtlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4286897e-e3cd-4080-dab4-08de86582252
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:10:22.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxK8JZsN1uM9GIPD8bbubtoRmocx1zxTCojTnIALSg3+Wi6NFaMYqpNtXKWciLJZaCZTn4GjiSuVvCCTJU17JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

>> +static struct {
>> +	enum module_update_state state;
>> +	int thread_ack;
>> +	/*
>> +	 * Protect update_data. Raw spinlock as it will be acquired from
>> +	 * interrupt-disabled contexts.
>> +	 */
>> +	raw_spinlock_t lock;
>> +} update_data = {
>> +	.lock = __RAW_SPIN_LOCK_UNLOCKED(update_data.lock)
>> +};
>
>multi_stop_cpu() used atomic_t for thread_ack insead of spinlock.
>Any particular reason you took different direction?

I switched from atomic_t to spinlock in v5 after Dave complained [*] that using
atomic_t and memory barriers is "overly complicated".

Testing both approaches showed no scalability issues, so I chose spinlock for
better readability.

*: https://lore.kernel.org/kvm/abP%2F2nPh9qkElV4L@intel.com/
