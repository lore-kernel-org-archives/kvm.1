Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941573C5558;
	Tue, 24 Mar 2026 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392683; cv=fail; b=Jb5NONQX2o1wWJVxm22I5sAfVXkiz/qJQHlKE6PPzr2c3j/AN+TiY11XwJFq8yNzQdeXbJRrwZIM5Fz/3vFfFVSDUVtUg3Q4hpAyYXA8tVzP7QZ4bWBiEGrpvhGYtErXSlVmPI1GBPBWNYm0bOoZQ6ISuKN8ZzkjZwAogg60Q7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392683; c=relaxed/simple;
	bh=qpHt+u/DrEFjZ2XyjNzvOaJJ3M5wpF1sihuZdlw1m5s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bw+xR8POqU5MQRSD36SE2wLkH622uWHXWmg8Ks++bzX5HrtCh58aVIbVZwXT2hCadehxxJ6jn6IOhZGfXnNONFgaDbqyqLKPJJmk/pdzCEHSdRsFBxr63zo2O4HL3VrL9132opnQpm+wiQz6t0Ahcc8yn67VLqbK77Yj2oGK4UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mhr7dTbY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mhr7dTbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774392682; x=1805928682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qpHt+u/DrEFjZ2XyjNzvOaJJ3M5wpF1sihuZdlw1m5s=;
  b=Mhr7dTbY7gvJ6syOfeUvKsLGPbiHqVDAjXc3tpsDTdlM9IQSyKPS/qlJ
   BFePof83VauaR3j98VBNCRjzizyvLwOj5aPxL6zh4WN5vmyfb4CPT3hiP
   spjfu+zxY5rvV7OU2LH6LsIy0B3Zm4ckF4bQYiP61zPYBauA2BlPM/LlI
   iialXY/h2fhY6JumjPUao29tgKTOgJexNW/CHd/TQ4hYXUcMjHzqkcm25
   oH5dzKeF9mBhlHhvEMOFQiGQCyJkOzDz6BGlZFTtlBOccM70XYOlaEUWb
   KYbJCC+oGPEqj+GF8FqUmVr5iV2s840BGYlXM5zoesGEjowMnd/yuJ7HR
   g==;
X-CSE-ConnectionGUID: YTIT8VxxSd2UYk1Pe5yJXg==
X-CSE-MsgGUID: Sp18xlAwQdWg7vC4J3IVtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86500041"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86500041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:51:21 -0700
X-CSE-ConnectionGUID: lHlujsK5TX21R+/7X87yIA==
X-CSE-MsgGUID: rcCQdKRySYm7FoxUiwo9og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221149943"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:51:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:51:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 15:51:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:51:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMJpgW/DX26yWZxuCsnvhn/2B3OsUAbI7o/yySXgyB5K1hT/aPfpbDtNBfudA6KZqsCh8BFmyxq/Z8UYqkpfm78RY1mJsU0VWqIHx5hoRxLB50lIS+4DFcGx7W28UVt7oiDxbI67rZm/d5acsYw+zUphA1BTJRih5fqvZiLHcOfi57rK6tMSSBXUtAzdBH4VY8hxfSiiKcyel5vkTA+76kox6es9ZmDEYuEyerD1HqyoVerMcQz9TQflid1ikhON96nakaoPmvGUIS7oo60lz/ilvf2TuTV0UOBDa3ckkkbATCaZPkCCHWsUreUFaYL5Yb4ntFUJDYCqhnGKEhzJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tsSc1oeGFfTRKoisRypT2wV0hsmCOOV6Rijq4CaOA4=;
 b=noq40pf75rw06x2qI0fYkIvDitIghvG65ZSF3geaheKGuSZF06LELDmRdrNYC6JMnCAstyMqVf4oZn/WDeS6MDdp2nr5YRBZpAdBn/5JnpQGtV1qrMsaC//3uI0Y/Op7i6SkOlwkygevkjlNlWaZKu8UYMkyqLKNjvybz0b2vmYvaLFGXtMz1JLkfObOe/QG1u3SeW6esk+iJkXk+Pf5Iw5upyLcjund048IC3zmEvB/hfojdo+GhVUG2OtVo6/3JX3tXVaFX6dtpqdHWtvvR+lztHJSllOssZpnOE0TbT4s0iRfEcPM30GXP4Vr/awrHLJFZBhbmA2tnKeUVNYUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 22:51:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:51:15 +0000
Message-ID: <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
Date: Tue, 24 Mar 2026 15:51:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1773347820.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cda147-36a8-4792-e7da-08de89f7dada
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ROfY0l4gOl7rFEJJpgpl/vJlT2FKJpZQaDG+h4Yi+fM1eKNbVukon01Lb8KmGY/mGI2zCc95uLvUeOOd4GoWIETwuUzNioYENxFxR0BOhB3adzLh+/EOkTEbJhZHtt3Nawi9M2HVu3Cv1dBImuI2QRgtBsLPCxrG3aALUr6wgPzonMgca56NPFeFlp1YB97PxPYkhhr/svWP8RVJB1zchENPZzcts5M8TPPtBN5DU+kY7KzTIUkyR3OrTt5frxPN9u8318P4q5f4DeuniqOwYcSOU+prkieENuY7XwvKPoXd38Ub5ZKfKWWmTormxdqV08tVowmZdfoxsEaB7pf8sEJQLKEUoflHvJDl9K42KnxxwDw7PvYfxbd7hr2i4ccYLptR33nzf7Bur496zkMPyu37ApERCdfdhiSTSOidF5pr04tnmzpFbj+RsXobS+xpvoPFg7+E2fAFyd6loTG8RyqHRm/KJ3Lv3DBRzScHhOtLnLG/7ii3T4Pu7D2pvtBfYGrEQrcQB5E9aDQhyVHCTMoiOuHO6/4Fo9FSOFUfsiP1MKto/cfmWSBlhZcTR7A/mnTItB1mf8yO7L7Kme/MUXliEdTc2TsLjD2AAIQ95Mz48rGuJXENPJUlTJbNUFpakrcyVnEO6UNFhfpaf2oYgnfX3ImbBgDFDb64EGS3lH9hFqqOmrVR6uW/T7rDH4vH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18092099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lZa1RjeUgwenROSXZSTkRSUmpRbXBSeVRyMWVMYnhZQlNPYk9BQnBLNlhB?=
 =?utf-8?B?aFdXVVJGdFNVK05DYzQvNzd2bG9xK0RpazUxSnJDN1NjZ2JZYXBqdTJ0QUlY?=
 =?utf-8?B?Wis3aEVuK0JNZDYzbDhVaXEreXhiYWJnWE1FVitmcERhSEVIK0xRdDgxV04r?=
 =?utf-8?B?NTNjenl0elE1ZXI0SE00Ujh1YTUxc0ZOQ0dtY1ptME0xaG1HZlQ3ZlYxdkJL?=
 =?utf-8?B?WUora1EwKzZuaVFsRjMrK0R0S0JqWmVaMzJDTmVSVnU5TG9nbnU5ejhCZFd3?=
 =?utf-8?B?N0lxd01kSUFPUkpYVnZwTE53cDltZXpUZ2FDUWFqTmN6SFEwR2xoT3M1dFZI?=
 =?utf-8?B?cFlCWjdmSTEzNzIzNm9kaWFuMlVhQ2JmS1ZLNkMvbmplSVJtbFRiMld0RGNl?=
 =?utf-8?B?Tk8rODRQUm9NRmZXRm5Xb1hPOVF4eHVpUnNiZVh0Z1dCcmNCSTBpUkZyRHM5?=
 =?utf-8?B?ZWNad1dVYldxQ20wVDJZdXVmbnNWdXM1OWgrU3RUZ3RoVEhwZGNFM09VZm01?=
 =?utf-8?B?YUpaeEVrTnRwY1BSSE1uV2RMRHhycWFqOEgzM2NKUTRSeG9DQXFDcmlzMEZ6?=
 =?utf-8?B?NVVWNkQzekxxN2EvZ3VCeDVaRHFKNmovTWdIaG1ZRy9UWUQ3byt5elkxczhB?=
 =?utf-8?B?cnRvWktGOEJSM051djRpWjU1Z1NGaXNxdyt5OVJyTS9IdTFRcml1M3EyZWFY?=
 =?utf-8?B?MVlma1g3MFQ4YWcxOSt5a0ZWRU9YTTJvbzFaSCtuR0FMMzdBYno5KzNhMkVs?=
 =?utf-8?B?UG9wZGdqcmtVR0Nuc0tvMFRzdGoybWczV2Y3VWJkQjRXK3BSeC8rY0NUemFt?=
 =?utf-8?B?eG94dUttTjlKaHdqeVZ3dFlob0swNUZIS3FlY0VpYVpMSEh4MmVmYkl0c0No?=
 =?utf-8?B?bk5kemJKQngvcDBSTHpXRDZuSHNpS284bnVIazkzSExEMlhvVlFuMUlsdGtD?=
 =?utf-8?B?VE1lUVFGUnpFSkwwUGJHNDVSQUU5Zy9ESHRNRko0bWtpc1l1dTBYMHMrNnBQ?=
 =?utf-8?B?cUFOeXlmanNPQ2YrZkNMS2o2NkVzZ251VVdJQ2l4eGJpN0NkNzF0NWhKYzhV?=
 =?utf-8?B?L1pzdTJ3Z3k2SnNGdkdXRHBPb1lpK1ZMVzBJcDE2Sm81ZWNNTjkyMHRwa1pN?=
 =?utf-8?B?MTlzaTF5YVEwNWY4ZzU4a2RhamtSSUdTNThCTDhHQm9FK2EzV2VDZlJkNXJl?=
 =?utf-8?B?L1JkV2gzanpTSHp1bVhHNGtiaThtSGxoRDhDcGhiQmRpbWhIeGtBa2FtQzJV?=
 =?utf-8?B?Uk1kTzAxUkF5ck1MSTVBUlU5RkJ1akcrN0V0QkYva2IyY1Q1S2hGVHZzN2NM?=
 =?utf-8?B?Ti91Y2cwblA5V2lCdjdmVENNMm80b0RKL2NmRjdIdFVDZTN0ek1nTXN0NnpV?=
 =?utf-8?B?bjdDWG5OeTM3ZERMUDR1TWNyUG4rbUo5VHZ2UnFKbUVFbUd5bEwzTm9mc2s0?=
 =?utf-8?B?VGVoVS8rdEdEaHpXRUtwNDMvZi8xUjlyaDVvNTdjNWlveFNVLzVwNE5va1JK?=
 =?utf-8?B?R1ZKYnc5eTV1MDFIM0FKLy9wVCtmOEZlNEdlRGw5WEx6SzRIeXg0cVB0R0wz?=
 =?utf-8?B?QjE2S05BMk5OcXhUeWlDN2RiNUd5aTlnQUk2MmZiK0lTcFBFN3NZaG9BUnlN?=
 =?utf-8?B?Q0dKWU9oNDQ1OGFOb1pYN2ZMLytzZ1NSTExSL3ZLS0RsOGlsekVtNkwwL1Ba?=
 =?utf-8?B?YVRERUV1cmFiaE1hMUtoRWJWdFF1NTBxQWxqQTlaaVZqamVWeWxZVjN5RGVv?=
 =?utf-8?B?Q0lvMFAyVUVqbFRjZkUyOWRqTG5nbVprdHlhRFcyUS9ITFV5MVh6amFkeWUr?=
 =?utf-8?B?bkpsK1RZbGEwbkIxdGlQSnJJMno2aFJWQlp4b2hOb2RzdDcrT0IyZHpnbndt?=
 =?utf-8?B?cFRyN3B1dHlJMUFvQndPeHQrQ3JYU0RRb2VNK1ZhR2ZXYkhhbzFWZkUrSXBP?=
 =?utf-8?B?TjZaTTBmZFk5V0lwZE1hUkdpTU9sYkVUMklENXdJSkZvVnkzVEQ1NVNpcDJa?=
 =?utf-8?B?VExmYUdhbzZwaktqcEF2VW13QiswQkFKRXV4SytiSERjUHVlU2tySFMwVDlS?=
 =?utf-8?B?Vm4rUWJyYkdHMDNTb000anMzWm1xRGJ3RVgwSFN0bG9MK0d2WmxnSG9OT3Fm?=
 =?utf-8?B?TURRbUxJUjk1V3NTV2ZpVU5BcjdZSVEzLythN2lCb1NjblBBbEJuSEg1MkVM?=
 =?utf-8?B?NUlqcE9Lb2xnSFVFU0ZCakNJbmNacEE0YXZPWi8yTVVZaU90MUpESGtCYndi?=
 =?utf-8?B?emZvS0NoZU9hTWFIRjErT3dZQTB3SWJ6L1NHbFFTTWpSSjQzWVQrcExXWGl0?=
 =?utf-8?B?ZmhQczFreWtHcHZhZWovOU9QQnMzQ1pEejM4Z1BqWnh2RHlESHFUMkszTzFF?=
 =?utf-8?Q?Jjky5IKEFbJ/1hOM=3D?=
X-Exchange-RoutingPolicyChecked: pQoH63FlMxA6MyaUX+a31G+BJfCX43KJAIQ9fD4+3lBm/Sijh3iqFLpCktW0ZOkEuTagSDfwx8WvofehtPuEjhDrywDLKMuK9M4/vwKzP+Tt8zYGn4kIZYClVqsLXj+2O598rtC2JMit0cJkTE160Y36iMu4RSyURLivhnQHGM1+m4PJuYyKYkB0Tv/L61bTNSi5xkJ19SsJO/EE3NBsg7SRwygmj7lyay3TV1edIY8cr/Feh/QdAJg3YnT1PUFIkkb+4Q8FF85Qp6GthGKPvG1/mTg/nlZE8ia3NY/C88FCuhTDeCOaNYAOWB90KXleWFe9JgPv7HW58b2HZ2rtRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cda147-36a8-4792-e7da-08de89f7dada
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 22:51:15.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZZREwQYJAhYbSkP44Y5SbDakxXA+K80kl1grESZmuu5rrqxg3fC27YbBGJVQgEnL/jj+qIm/LvZfB42hZqHRy62sB50FY3NsBX2CGgcG/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/26 1:36 PM, Babu Moger wrote:
> 
> This series adds support for Privilege-Level Zero Association (PLZA) to the
> resctrl subsystem. PLZA is an AMD feature that allows specifying a CLOSID
> and/or RMID for execution in kernel mode (privilege level zero), so that
> kernel work is not subject to the same resource constrains as the current
> user-space task. This avoids kernel operations being aggressively throttled
> when a task's memory bandwidth is heavily limited.
> 
> The feature documentation is not yet publicly available, but it is expected
> to be released in the next few weeks. In the meantime, a brief description
> of the features is provided below. 
> 
> Privilege Level Zero Association (PLZA) 
> 
> Privilege Level Zero Association (PLZA) allows the hardware to
> automatically associate execution in Privilege Level Zero (CPL=0) with a
> specific COS (Class of Service) and/or RMID (Resource Monitoring
> Identifier). The QoS feature set already has a mechanism to associate
> execution on each logical processor with an RMID or COS. PLZA allows the
> system to override this per-thread association for a thread that is
> executing with CPL=0. 
> ------------------------------------------------------------------------
> 
> The series introduces the feature in a way that supports the interface in
> a generic manner to accomodate MPAM or other vendor specific implimentation.
> 
> Below is the detailed requirements provided by Reinette:
> https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/

Our discussion considered how resctrl could support PLZA in a generic way while
also preparing to support MPAM's variants and how PLZA may evolve to have similar
capabilities when considering the capabilities of its registers. 

This does not mean that your work needs to implement everything that was discussed.
Instead, this work is expected to just support what PLZA is capable of today but
do so in a way that the future enhancements could be added to.

This series is quite difficult to follow since it appears to implement a full
featured generic interface while PLZA cannot take advantage of it.

Could you please simplify this work to focus on just enabling PLZA and only
add interfaces needed to do so?

> 
> Summary:
> 1. Kernel-mode/PLZA controls and status should be exposed under the resctrl
>    info directory:/sys/fs/resctrl/info/, not as a separate or arch-specific path.
> 
> 2. Add two info files
> 
>  a. kernel_mode
>     Purpose: Control how resource allocation and monitoring apply in kernel mode
>     (e.g. inherit from task vs global assign).
> 
>     Read: List supported modes and show current one (e.g. with [brackets]).
>     Write: Set current mode by name (e.g. inherit_ctrl_and_mon, global_assign_ctrl_assign_mon).
> 
> b. kernel_mode_assignment
> 
>    Purpose: When a “global assign” kernel mode is active, specify which resctrl group
>    (CLOSID/RMID) is used for kernel work.
> 
>    Read: Show the assigned group in a path-like form (e.g. //, ctrl1//, ctrl1/mon1/).
>    Write: Assign or clear the group used for kernel mode (and optionally clear with an empty write).
> 
> The patches are based on top of commit (v7.0.0-rc3)
> 839e91ce3f41b (tip/master) Merge branch into tip/master: 'x86/tdx'
> ------------------------------------------------------------------------
> 
> Examples: kernel_mode and kernel_mode_assignment
> 
> All paths below are under /sys/fs/resctrl/ (e.g. info/kernel_mode means
> /sys/fs/resctrl/info/kernel_mode). Resctrl must be mounted and the platform
> must support the relevant modes (e.g. AMD with PLZA).
> 
> 1) kernel_mode — show and set the current kernel mode
> 
>    Read supported modes and which one is active (current in brackets):
> 
>      $ cat info/kernel_mode
>      [inherit_ctrl_and_mon]
>      global_assign_ctrl_inherit_mon
>      global_assign_ctrl_assign_mon
> 
>    Set the active mode (e.g. use one CLOSID+RMID for all kernel work):
> 
>      $ echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>      $ cat info/kernel_mode
>      inherit_ctrl_and_mon
>      global_assign_ctrl_inherit_mon
>      [global_assign_ctrl_assign_mon]
> 
>    Mode meanings:
>    - inherit_ctrl_and_mon: kernel uses same CLOSID/RMID as the current task (default).
>    - global_assign_ctrl_inherit_mon: one CLOSID for all kernel work; RMID inherited from user.
>    - global_assign_ctrl_assign_mon: one resource group (CLOSID+RMID) for all kernel work.
> 
> 2) kernel_mode_assignment — show and set which group is used for kernel work
> 
>    Only relevant when kernel_mode is not "inherit_ctrl_and_mon". Read the

To help with future usages please connect visibility of this file with the mode in
info/kernel_mode. This helps us to support future modes with other resctrl files, possible
within each resource group.
Specifically, kernel_mode_assignment is not visible to user space if mode is "inherit_ctrl_and_mon",
while it is visible when mode is global_assign_ctrl_inherit_mon or global_assign_ctrl_assign_mon.

>    currently assigned group (path format is "CTRL_MON/MON/"):

The format depends on the mode, right? If the mode is "global_assign_ctrl_inherit_mon"
then it should only contain a control group, alternatively, if the mode is
"global_assign_ctrl_assign_mon" then it contains control and mon group. This gives
resctrl future flexibility to change format for future modes.

We should also consider the scenario when it is a "monitoring only" system, which can
happen independent from what hardware actually supports, for example, if user boots
with "rdt=!l3cat,!l2cat,!mba,!smba". In this case I assume CLOS should just always be
zero and thus only "default control group" is accepted?

> 
>      $ cat info/kernel_mode_assignment
>      //
> 
>    "//" means the default CTRL_MON group is assigned. Assign a specific
>    group instead (e.g. a CTRL_MON group "ctrl1", or a MON group "mon1" under it):
> 
>      $ echo "ctrl1//" > info/kernel_mode_assignment
>      $ cat info/kernel_mode_assignment
>      ctrl1//
> 
>      $ echo "ctrl1/mon1/" > info/kernel_mode_assignment
>      $ cat info/kernel_mode_assignment
>      ctrl1/mon1/
> 
>    Clear the assignment (no dedicated group for kernel work):
> 
>      $ echo >> info/kernel_mode_assignment
>      $ cat info/kernel_mode_assignment
>      Kmode is not configured

This does not look right. Would this not create a conflict between info/kernel_mode
and info/kernel_mode_assignment about what the current mode is? The way I see it
info/kernel_mode_assignment must always contain a valid group.

> 
>    Errors (e.g. invalid group name or unsupported mode) are reported in
>    info/last_cmd_status.
> 
> ---
> 
> v2: 
>      This is similar to RFC with new proposal. Names of the some interfaces
>      are not final. Lets fix that later as we move forward.
> 
>      Separated the two features: Global Bandwidth Enforcement (GLBE) and
>      Privilege Level Zero Association (PLZA).
>  
>      This series only adds support for PLZA.
> 
>      Used the name of the feature as kmode instead of PLZA. That can be changed as well.
> 
>      Tony suggested using global variables to store the kernel mode
>      CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>      coming from rdtgroup structure with the new interface. Accessing
>      them requires holding the associated lock, which would make the
>      context switch path unnecessarily expensive. So, dropped the idea.
>      https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>      Let me know if there are other ways to optimize this.

I do not see why the context switch path needs to be touched at all with this
implementation. Since PLZA only supports global assignment does it not mean that resctrl
only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
info/kernel_mode_assignment?

Consider some of the scenarios:

resctrl mount with default state:

	# cat info/kernel_mode
	[inherit_ctrl_and_mon]
	global_assign_ctrl_inherit_mon
	global_assign_ctrl_assign_mon
	# ls info/kernel_mode_assignment
	ls: cannot access 'info/kernel_mode_assignment': No such file or directory

enable global_assign_ctrl_assign_mon mode:
	# echo "global_assign_ctrl_assign_mon" > info/kernel_mode

Expectation here is that when user space sets this mode as above then resctrl would
in turn program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.closid=0
	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1

I do not see why it is necessary to maintain any per-CPU or per-task state or needing
to touch the context switch code. Since PLZA only supports global could it not
just set MSR_IA32_PQR_PLZA_ASSOC on all online CPUs and be done with it?
Only caveat is that if a CPU is offline then this setting needs to be stashed
so that MSR_IA32_PQR_PLZA_ASSOC can be set when new CPU comes online.

The way that rdtgroup_config_kmode() introduced in patch #11 assumes it is dealing
with RDT_RESOURCE_L3 and traverses the resource domain list and resource group
CPU mask seems unnecessary to me as well as error prone since the system may only
have, for example, RDT_RESOURCE_MBA enabled or even just monitoring. Why not just set
MSR_IA32_PQR_PLZA_ASSOC on all CPUs and be done?

To continue the scenarios ...

After user's setting above related files read:
	# cat info/kernel_mode
	inherit_ctrl_and_mon
	global_assign_ctrl_inherit_mon
	[global_assign_ctrl_assign_mon]
	# cat info/kernel_mode_assignment
	//

Modify group used by global_assign_ctrl_assign_mon mode:
	# echo 'ctrl1/mon1/' > info/kernel_mode_assignment

Expectation here is that when user space sets this then resctrl would
program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
	MSR_IA32_PQR_PLZA_ASSOC.rmid=<rmid of mon1>
	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1

Enable global_assign_ctrl_inherit_mon mode:
	# echo "global_assign_ctrl_inherit_mon" > info/kernel_mode

Expectation here is that when user space sets this mode then resctrl would
program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
	MSR_IA32_PQR_PLZA_ASSOC.closid=0
	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1

	# cat info/kernel_mode
	inherit_ctrl_and_mon
	[global_assign_ctrl_inherit_mon]
	global_assign_ctrl_assign_mon
	# cat info/kernel_mode_assignment <==== returns just a ctrl group
	/

Modify group used by global_assign_ctrl_inherit_mon mode:
	# echo ctrl1 > info/kernel_mode_assignment

Expectation here is that when user space sets this then resctrl would
program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
	MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1

	# cat info/kernel_mode_assignment <==== returns just a ctrl group
	ctrl/

Enable inherit_ctrl_and_mon mode:
	# echo "inherit_ctrl_and_mon" > info/kernel_mode

Expectation here is that when user space sets this mode then resctrl would
program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
	MSR_IA32_PQR_PLZA_ASSOC.closid=0
	MSR_IA32_PQR_PLZA_ASSOC.closid_en=0
	MSR_IA32_PQR_PLZA_ASSOC.plza_en=0

At this point info/kernel_mode_assignment is not visible anymore:

	# ls info/kernel_mode_assignment
	ls: cannot access 'info/kernel_mode_assignment': No such file or directory

From what I understand above exposes and enables full capability of PLZA. All the other
per-task and per-cpu handling in this series is not something that PLZA can benefit from. 
If this is not the case, what am I missing? Could this series be simplified to just support
PLZA today? When next hardware with more capability needs to be supported resctrl could be
enhanced to support it by using the more accurate information about what the hardware is
capable of.

We also do not really know what use cases users prefer. This may even be sufficient.

Reinette
