Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E328469A;
	Fri, 20 Mar 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995007; cv=fail; b=Bw93kMOdFeXHWn02pGX/hNuXOl7XF9vj4qZjQNvt6vs0+cjyVf/5keMRlXUmaLy24AGGIknQ39yWURjyW2ZwCUI3py0NkGpNUvCjuG/e+e7yqGoYBIQz1BapnAE9l2ID+gKQaO9hnpk7vTPaU498c/ilm87jdPSz1BvceD9AxrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995007; c=relaxed/simple;
	bh=EuPTrdNiXhgZ2mTkhhXcL66uMPnC8YtyBkeAHbPYmjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AuUGTLHFKqWE4+p6ecosuQFoem3CMJMWVR+Vv6nGt0PuZnxsP4UYFnzMa85DTE8CBMJAVtVyzHY8TuOHdAK2FBau+CNDtjOxCsq25Gnb/DVG8YEEoIYYlLytX10IW02rOr5j61Bri1Fpdv1TWr2Aqq4l6OSdXye34GuewfuDGJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2/+d+4y; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2/+d+4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773995006; x=1805531006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EuPTrdNiXhgZ2mTkhhXcL66uMPnC8YtyBkeAHbPYmjw=;
  b=J2/+d+4ylcdwuj0K4R7E2eYc7h1upzv1TCbuA4MEOU418rk0muDAg2cp
   03PxB8TJa6brH8DD3oSPuE1vZY+CAI5QChRPf3IAEexNB1B8J7x5wNT+i
   bmD8d2fCy/P5sUsc5K3Ia4y5aeroanIuvRxZi0/DRgt+pPm9HQIcPCci+
   twM5prTk5dltfgAtpd45Ckt8fwngz31EZqJGDyXsSkQPvk7Y3IcjMMsA2
   GgTjAs8tcMCeP6cH80+c/E87ftmTBXdWarlMYBUA5o8xVOpHt24qB1NFk
   UgBHbmyO32HQ9Cqxk5at0cks5X87BIJAcsh/KfRnbWrJaA0pvN9mdDiEo
   w==;
X-CSE-ConnectionGUID: K1rFs1b3QSOLPVvswmrfvg==
X-CSE-MsgGUID: yFhZjVB6R/yeNnSRyAGkzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74959042"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74959042"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:23:20 -0700
X-CSE-ConnectionGUID: JufVDqZBT8m2Alio2u6QDw==
X-CSE-MsgGUID: EHmkFcTBQreqcRGRMbO6Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220582114"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:23:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:23:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:23:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBN6/38GkEisgTp6FyQ1ulg2MlSZN5WF026wJ/8ZAVeHcEbMbAk8F28NZnHmjNPNgPPaXTdsOPRmp88/pcFX6iJ1TdMfzURVk7QOIcqOE4JeX4UokiCkYz88RaY2QIKHTaKDAsejOS4ZJyNKNizRu2d/MD8cWslVF0bIbnz5hv8PUPQxB4wRZhFf8MPYe1E7OaEg3FHGq359a/GTyTbSAXLq8qMfhvBPEk1tOeHieacQOsnqbvX0CGVlNLpTfIuZkBmrpAjoVVZVSfqwbRsY+w91W2twVPqMaefbPvYBMhS/BeSOTIO/CZG81roYgZ4Pr0nYX9AxVslAzXfpGvqOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyTKw3865ectfRRNhH1kacRuASnuE4KG9/YuvS9QNzM=;
 b=iq2msB6XzekXN00NnvltV5SByiZ6hKlHPRjr1FExfzMHc/dANKnt9EaxT7kJktXcoHvPfdFxtxZUW8w4CjzKRAjaM5XD6Skc/f7ObXQEsEfBbZ1rgjy1WlPzZ/RzaBeATdjjc5zvKxx0bJAAJqE07ZkxEpR+oqNu5BA7dC4LxZTwQR+u7bJTMg1d1JeAnRPA6juPks+32EGmWxMmn7aUfBIv4z5ztM5f2WtOwUm5l6kaNcs6kqWM+ygzcP0e4eWyVfIbaBHO9ApgmOuMZjWJLdC6bl/PC03o6TuLmKGPsdxJCeKLtFQ88e6qb9qvnLOonewMalv4EG5qlX1a1+rALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB8668.namprd11.prod.outlook.com (2603:10b6:8:1b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 08:22:10 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:22:10 +0000
Date: Fri, 20 Mar 2026 16:21:56 +0800
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
Subject: Re: [PATCH v5 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <ab0DpDNQ35/xD6hS@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-12-chao.gao@intel.com>
 <abv4OWfqDOOLR9XT@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abv4OWfqDOOLR9XT@thinkstation>
X-ClientProxiedBy: KU0P306CA0076.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::7) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 27caf4c4-c727-405d-c4e0-08de8659c80f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vfoS806M2rWMb/yVdfiYMANwifvRtTkGucsmylYaT5yOIFJeQMPPJZ9YhXRgC2yVlu+/p3PEKzZOiU/kJ8I2HIDrrWjNcsj3isHq8hOup9oJS0YCFE/6cKCRUPq9gDtfd9QyXpII5KhzSB5PFW9FXF2qse62yr7KDPGeaPatZJjRMhP/R7N9ocJseGg3/t2LFTwrkG9XYvMgSjHPOECA7XteoWLbs4jhtpRq6aDAdmTi9JSP/CaFikSKCrp99FKaarcggYP+8BUtmwcmIzfyHk1OIeqpiZg5IS3zi5M64397/Lea6dBKWahkp0sgWnaEehw5/l6PriuVFxsK7lDxHOdoCfykZ6hFoLg/UTd9NXnw/SLCoeR6Jtpr910HaZuWXblvRmXVWe4QruFLfpbqYLxn2A6tWgNJlmblJNizwNuXgRBvw7IgK+cu0NyXecEBojZXyMH8aB3+rWpQxqUGQj9gCEHbhZnREGt7I5lzefbP5dinwYRqr1lU9KZuJX0LnaXNzHMPSSrcJvh952J8z8gsTH1hEMvn+GzKku5E5Ps7UmVyaDH/xJ8DR6QBdzz81B4p6YdYLU9isaEcniGx6Wh7x9TpJumnoTpmVD7o4XSdwqpaxhWaMj8bYFOY8u2ktr0FX5jSahqr76kv3fws1HcdNIxSXd6p2Bii+bZsT3SDV1UWqN2z/Pn6IUMmziVEuxCNwTwNyzn5o4XMHzzQw+IyKYNe2gds9pstMpGf+HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knwlPKTXgwY4U24G2Sr0Iqg9ur5dDkHR4Q00BRMwyCJDbQr8ANOASB3LeROe?=
 =?us-ascii?Q?bz4Yh3+NRMozSr7C6WRuBddi/ER8VgmYcWiiQrBPOjdDBJ7CrwTjnqY9R/sr?=
 =?us-ascii?Q?dACtmvaM/4w9TxpkpsbtkejgAqKgefP1HLlwrXO5E+rkDj+EMZP6o//tPTjQ?=
 =?us-ascii?Q?hiSgTQIhR0yRhX3L1WTOdkyXV9ln1k5Wnl4KfeKXDQM75VBAlxOxo2FeYlkx?=
 =?us-ascii?Q?pQXn3xLS+dKu9kZuNdA0PhIGwjTmU14gmiQuxnlWIC/qj7VF0mYvjJzKwsn4?=
 =?us-ascii?Q?kDU5RfncYt8/BIcLdmSWL1W2Q9BK6Ino04rKAuef4kwjj0MxYrvq+bBK/gwk?=
 =?us-ascii?Q?3LBz5JdNJFnMa+uOjJq0u7jyxxvWqITWZpoMP7Hj4AviFXqUA+/U3xqRZPO0?=
 =?us-ascii?Q?oxDf49NWc44B5/Nl+7K8IRgLAIkse1QNI6lCQt4VgxiSB3f1HKX9u1zlWUop?=
 =?us-ascii?Q?gnUU2fzhVoMoheiywvvXANKxQIf7aaSN6UnAL49zH/EMefjHDJ9R214dgFeQ?=
 =?us-ascii?Q?tzIxcxQZwsbZM4vVfKhNHeOJtqHyx0WewlnO2qV8LOzzqNBa46kLS8DYxs/M?=
 =?us-ascii?Q?V/UBMloKVlC1pi5XVjW6Y2SZ7KAotvdWVh65lNqhaZWbW+yLDBMfKYQP4sE2?=
 =?us-ascii?Q?Z2O5fRp9b4QC3NvcOloNeXqWgjMX5VIvrk/xtqmCOMZ0G4ANsmbgmH2Ie7kq?=
 =?us-ascii?Q?S66cnPaX/53pAeViYzadajtf2p3rn6qisHqb+RPVEKT9YOhzgkxhOyRFUJ+6?=
 =?us-ascii?Q?8KjwOr1VebEwzM2z+QGBVt9hZ43cylKDn3iC04do7sDFlvXwXzwnVFg9FFbs?=
 =?us-ascii?Q?nP3h17YGFRrNBzDeZr8t1yobQr1KWWgZaLjPpYKKwJpwJJD6nMM36riTO/Dx?=
 =?us-ascii?Q?94A9RNGs+1/pzVmAFtR0gfvy+fERDQ118eM4IdmNfT3xdymKkOxkzn7TTKrc?=
 =?us-ascii?Q?SzTGCIKdlX8Sy/VKP0ha6dVpfkEOOxLEjAD5eJn/Z9c/S6m0/kU4V0JboDPN?=
 =?us-ascii?Q?TQHER/7PMkYTYnuYsy5KX8WHcIjH9Z17XljSVXKeGZgP/XEQfiY3G19Z19To?=
 =?us-ascii?Q?655CgzPlwqtKs6tPRpLB48XspPy+3bYVhu+dkpGnHcC/lOQuL+Oyvi/youS3?=
 =?us-ascii?Q?h0LN0zTIuAsvuzAWy0bx1gsF291Y1hN2CEhgRLPatm7m/HnYec9P4zdQxPbB?=
 =?us-ascii?Q?DbZoAavhu/rr6ewxLC/8dQW9LfTYFtyK/jfXTQ2gLRim8i2KDq35t5U7oEhf?=
 =?us-ascii?Q?4E7Ue43PR8urEi9moAnmH7jH/mmeh2Xxv2I5Sfrz8UXmuCHFZkRbdiSqLFyF?=
 =?us-ascii?Q?78W+kcExM87hpRz3dbeheBtK+JTWGfVNJNlSdn7vyX91BfiGw7phWEtYkHZ+?=
 =?us-ascii?Q?CC3d/og7/Y+ocXwL2erYMV6RjuBuLjpj58UQJ8TpHlaYAGP9oq4D3SWZsWlS?=
 =?us-ascii?Q?YH7m0HfUIONdFYgPUfjddM9HeCdJFzPX39ohAY4U+FViQ7dKBzt5LqBcp22/?=
 =?us-ascii?Q?QGOFBpewbJJzbD+qE71u0hIxL4Uf0T1Mt9TY3k0quoz/LJNATQ3mBzLOpSJ9?=
 =?us-ascii?Q?vwPwWtVq29i0jHUKfmqH3+QmvwnYSRgAKvyYbJccRNBIh/Jhz2YZsly4cLNR?=
 =?us-ascii?Q?gTcwkZcZ0AN1eStI2BzqONZcObn37Idiz0B7mCftytqzKtPkRUia1pCoUuG1?=
 =?us-ascii?Q?/kIzxZuVm40AHI1qT7PL6/u4Z+DHygn21+UUeRoRZLMDyx9cjqy/HcBYgkg3?=
 =?us-ascii?Q?gSPHpkY0/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: iWwH48EFeM05O7QPB3VkdgDuJrewdH8FWc9XYnQ8H9/otsRlNQWFsAgUFsijjZNkBZnbP7zXIgAZOxppuOaZMUxBuJUlSIJQ2xlE5UfEoochAzk3lYF0WVlxUOHa2bD5M+JLD5Uk/Umxd42+Fu1Jby7q79r7gFqxI/EX9BokqiZxCnJpVB9KvhXp1IKa3tM3i4PWgzeCdXbwTNwUIctSAfFmjmB0LJx48AQ+k+FwPy/5kal8XIz2e4f2FvvG+a/RZQ+jca/YeXMNI+gV143LYkqXUZIgnr1HAcKe8xTtT/EZ5uMXIqIJN7dCyUljIk3cefx18+tVcU3l+Yi4lGbpyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27caf4c4-c727-405d-c4e0-08de8659c80f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:22:10.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etUTmQnkq5fVTLi+WAoVLNf9OU8b/AzKFJSn8vP0KVULUWviKs+ESAPby9ZoSYO0eNPbGw+MDe+cfqI7/gkbAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8668
X-OriginatorOrg: intel.com

>> +static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
>> +{
>> +	int ret = 0;
>> +	u64 val;
>> +
>> +	if (!ret && !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
>
>!ret check is redundant as well as the ret initialization above.

Ok. Will remove them:

static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
{
	int ret;
	u64 val;

	if (!(ret = read_sys_metadata_field(0x8900000100000000, &val)))
		sysinfo_handoff->module_hv = val;
	return ret;
}
