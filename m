Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B783B8BC8;
	Wed, 18 Mar 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826593; cv=fail; b=IwJs3XHL3C+enyFen6mdMQgEKyBIqUVGPV5Fswx0jmROVKx1fQbOQ/hjLNw5mO+NlDPx7mReju8mMVb7cB95k3o7vKMucn/S2UgUP6Np5MQSbiGrf0tWNNwNZs4uO+V5RnL4a3s4LQ+brnntJsWfwIzEoDUVdnGCDJ8BI0dnAb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826593; c=relaxed/simple;
	bh=8r57ttRgOPxIc2pYl5FG+PAypHKlOzwykGwUR8nGVr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I+pmtfQ5+uI8zxlL0Mdva8DGJB49UUtUVv2jtLnxkQBynzbN27pv97z5+1gA8zvKr35O/hPu7qxqz48bjB4l59Kw9Dx2BgCHH+lN+yua3NnbW9J4B+MgLG9IuYdKzEClLEOnRYWx4U6viaJS9ldfG0g5kVSET3SALVYRrfzyWf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPPt2sV0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPPt2sV0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773826586; x=1805362586;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8r57ttRgOPxIc2pYl5FG+PAypHKlOzwykGwUR8nGVr4=;
  b=nPPt2sV0nlC+DH4K8d0siijJ4PFBDnSWQeTA2zOQAoROdUNZQj/+u6FP
   YSxyYfV41/GxV42r1qpDwcQI+Elx3PObmAVXwou/y0i42bT9+zwrwmqHm
   RzLtCT3dEAQanRPCJKCHCqcHAYnTtWPJOW3QqYv3BS14z0oytcK+VRX3j
   L9zsTp5xlhycXASvJqgPlMedtrs3KkYk3Bimv/6WkYSZgl55jW/M+NokN
   fCX0af3JMaCmAyV+iDfkmBGRRX4W4ba+dje64vklJpMU5aEYBHxyJN+hZ
   JVmup+tIm6cPVK7s4dHpOhyXWidUHmRk319zHP4Wum2b3aAAvm+/CglT2
   w==;
X-CSE-ConnectionGUID: 1urnQ22MSQ2DQFNkEqh5Qw==
X-CSE-MsgGUID: 5NJGoemmSruST+cADXnWlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100336038"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="100336038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:36:25 -0700
X-CSE-ConnectionGUID: TA3/z/KARsm5dwqH+VBzrA==
X-CSE-MsgGUID: PUaA7UI7TieZQTllnkeG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="220021561"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:36:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:36:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 02:36:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m09zTOWg7oD6+sUST5NiNa7P62O2t492G1zG0NWckVT/H1iLQk2tyhj6RzHZHnEurZgc1sYmzXwzCR9XUHvh+yFHaD+FVv4wZeJv/m3IB+OFAaE62vi/bMQXPO1bCFWnHERPVhkz2f1DXBwYWcAE5JMu+7qVutPGKCLwAOcGDO2nMNmS91oJxycqHupW/OpG9BhY9N0EqRLGYYXDWgNSuJJPJt1kRWJQKKboB95Roi/VAgFGT0/+OOELayvEsYe7fjMWqxL8tjY+5ypDEUDLP8DXFPcEKHZLZZ+gerXOBKw/60Z0qNhrLBomysBFsbC/hhphXjqNUhdMfFjA7kxNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvT9n1aEfR4zhlUPe82dcRFdXWndtBkF+D/f1rxmlA8=;
 b=lRQIzbZkE2i64LVIhtVQXw+uchx+0qXxC4dU+8TAH2raQHyIqU+NqHsPq1RwthubDVcdJloRFj3inEB1EUBdgIHs3+OmFe6sjKmF/P0lx6wjlIHjD1s0ew4mWhZsX046VGY64D0zMZ4vMEo0Hxvl1JkjE8ouJ4c4Ih9SsnRcBv4/zn3O9vWfKcqTVLBHpkWBgGqZp90FYhZF6UeOnS2CpRs1vIqwjjmDFIIwAByo9zPgXYRHFlJ4+GxmRfV6X0ELqGTJRi2C3XqTbNxzW0i2rr+2La1EU1JagqjZx+a2GejgZm66TCMaWjG8WcQ9zl2ZG8OS+dS70lW0hdTd4E+ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA0PR11MB7882.namprd11.prod.outlook.com (2603:10b6:208:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:35:09 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 09:35:08 +0000
Date: Wed, 18 Mar 2026 17:34:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, Farrah Chen <farrah.chen@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abpxvVk9XrEU6ssJ@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
 <935081ba-9f66-4bdf-a408-c19be32c6ad3@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935081ba-9f66-4bdf-a408-c19be32c6ad3@intel.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA0PR11MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: d238874e-7cf7-4181-5ef3-08de84d1a4a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: OsFh5B/EdMvFuG1CC7h0OekQ0sWRxt7L3yDshuoW3nkRfIWeNmWF+aH6sWezMPGt4zwiJl94kR03JdA+oPnJ8xeuxSXf9eDHlkbkmIufT9DgOSL+zl44jh6io/6IaAXKHQk/k7tBYKcE5atQkIU+8IS2SG1ubCultZ2jhk/PvuPBiJDI9zlmb7KmYtualaQ2Glru39d9rpt3bv6M25HSpBbzRiB40zKdmfQTNtdug+/muKQiSWiz4FT+cW+Ps18fR0wsmNEHIdws+1+jgmnKo99KJvoqv7BhteEYGXyB5W7TL68xI8km+A54Og7XkfiQckRa8VzuXip6qsB7Er2aAVBdn2Lqj3zZooywwVuFo8+6/nt6XWVh8WbNVOd5pG53k1TAraglsFGgQPafJOqZJ51wSKqC/dgkxeZPMXlUa3YHD+yItIdW/pj3MeoQxq6k2tnwE0vrmmoxyBe/96e448Ht88HpcElzOVUPebLozzq7TMWeCiqpkxcOBw4zA9jGU5WzdAske6SYS7FjhYAvt2uGVwouiYxyC/sCAH0ugNIZXgz6CgYgwWziu4R78puKP+sYcW8uSPB74ezGCmMT8D09/SCGGLGjEg6MQ92VWQY9IZDQm+XIUuQK18UO36OuVzUSo6PMC29U1Pd1th5/KMsrmiAu0/jrtfFcRPhV6YCZhjxMkhePXMYGy7tkzmC0xjPnESwOHxviF5s9s9rpJCsRU97ywgiI0GLfDpgVNa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QSLn9VNOQkzu39XXoGYrbYxkVN2zhj7/OCDkBH2YHJJKKpyLDJbIEZuH9/?=
 =?iso-8859-1?Q?V5WNzk9fo3jrgkDgGTECkmyyfsAhVMdnb6P2sU4BKEYRPG3HMLNElvCWix?=
 =?iso-8859-1?Q?UWLiwhAKIdqbbA9HwYQNIPZDA59O4CrezORLUm6NKMPV9QBMPzaeDzqQdc?=
 =?iso-8859-1?Q?xfSEb37rwj/mX9kZxVFgRlkzHRWRXexOBWyzlTxpd5EZrShF4HZSz9dE/6?=
 =?iso-8859-1?Q?vcD133matfdjvCOvyVGQ1VyEtmuNugHkkpsSM0fhT8O58K47XvsLeaJXr4?=
 =?iso-8859-1?Q?fEaCXc+BcI4L8DSrbE4EDQklzc/mXZklNlsQvnVADHbb9Pic1X7XHYEWrY?=
 =?iso-8859-1?Q?rkiogbrNoAuzqoSxLuNeBjUNdQiJ92HMJfFZ/Z+9DwgebE/sUvi9OHDBdf?=
 =?iso-8859-1?Q?FbSpolSHUYohsnIIHympc+MQt72uBL3GwzVI2BmDcSZq7Dj4ZHfyoAvUOI?=
 =?iso-8859-1?Q?LrAu3S549RZuqyq3YC5DR1fLp+kC9ApJ0M6t6AiFYoIQUD0K9d2TX2wtxK?=
 =?iso-8859-1?Q?dIGI1Ju2nJ5/0mKG4e0QsM1O8r0ac+3DxP3eUamxPY80LZfY8tU32uTSxL?=
 =?iso-8859-1?Q?6cMzyTIkAM5FjU75udiLEw4maagFaIqgYr2nnMqXdF8jhVRFcLSlUmPVk7?=
 =?iso-8859-1?Q?Pv7pGpU3IZXSrOwerdxSQqLOjj3nDTh7jhmHgySCXzSFmJ664cD5dOGQSl?=
 =?iso-8859-1?Q?1o23fKdqNiO9O3aysYwg6EXE240378ZlSv3PrVqzAI3fAgncoEHnyFs1wh?=
 =?iso-8859-1?Q?vpuLmXOjJrqJ53MFuPr5aH/+nqTVFM85uTSUSpPK6RaQxFBtFCTQO+I5mN?=
 =?iso-8859-1?Q?emo7bGhbvpKQ55Z5qypMsqwecLk2DmPs2TcOH9IoykndBMfrvtZvHT2pgK?=
 =?iso-8859-1?Q?NaFXkKbqvL7QUNYDo+wPVaVCzRe0/0CqL+Pem6nDmFG9hbdshyzZPSWRAV?=
 =?iso-8859-1?Q?Ynx1Xlzio+OBiX9T3+MT4Zpw//sTu8UXKCQ37ZkilUf5IJBVYhYQD00Mx7?=
 =?iso-8859-1?Q?1nb1jYKBSr0Mec/a76PM3a2PdNwWAeDFvZ7mfTSgKuOZJbIYGu5e3PBfqG?=
 =?iso-8859-1?Q?HJJF5GpwIqDZLvFGyS9NjAmCaaQ4Uk6uEI8Vbey8x0GH+o2AQb23CrE4+x?=
 =?iso-8859-1?Q?BPF4d9l5zgqfsoLQc555PWINQiBQ491WBJgSlv9My1lprIi6Jb8yJ7BWuO?=
 =?iso-8859-1?Q?5y3DdHEh4declrCb/aAJkTF8zTSuROn41sC+qWpGM8S3tPXS2rou6wVK3f?=
 =?iso-8859-1?Q?4eW1sS/c01yZgml1rzqvRid/GZJ+/mMxLXnA4Wd87WO1lazXT3BS5oM9ur?=
 =?iso-8859-1?Q?wILHQOQjG14IGWaMS9QRfvjeewXmoV6zCpK23wouPba4dxIPDf3YHyd+/r?=
 =?iso-8859-1?Q?7K4X49wTOVU/8ynpXbNf8B3rlR6k8i4ACEAaF9Je9q1+RBa7ka0bGrEfzT?=
 =?iso-8859-1?Q?M6to/toVLU028n4OuF20YCfTJnvBpK1O2VkUgA3Ta/d1jDIuZHl88KgWQe?=
 =?iso-8859-1?Q?pjUpldAWmhsclOFtkY533/2O3MdxKG9upF714kZ4TZffqMsnk07EXpCaUr?=
 =?iso-8859-1?Q?juzkZHCHsH07xDS1mwcVK3Z2YF7HKi66wNp/yUY2UEEI0X9V9DLG+CaktN?=
 =?iso-8859-1?Q?DsVHXldQsyHKJGOZQjayzRPB2M2Oe4j691VOAso0JQk5hKOMAXpKPs6EG/?=
 =?iso-8859-1?Q?lyxFM1KMljO3ypKdsznkmyAP36dlMXRwqQ8U3x9c5AO7ZCCm6MBA3xr5lr?=
 =?iso-8859-1?Q?TkMQ2tUw+KnO7+IxOKYpAZG4mnQxjldi5mC5ULFX/DHycqPEKtyEvxIbUq?=
 =?iso-8859-1?Q?U1HmsRaZhg=3D=3D?=
X-Exchange-RoutingPolicyChecked: mZUxid8GXsei2yPC+VaaAI09ZpJdxbNRkjGEoZaOahQ/vX3fcFYKYcPEnqmSfy0g4MGun9Fhi2n0H6o05b2p8y/XexTvHYH8CDlYG/Gb0VadJzBFMyNIq7uX0foKkhnjwr4T+OrJdqHYxv1h7JEi+JuOd9foLbcCZ0s4Jf8ge4qi1t1bBRorw/8M9FPr3ArFO31O/iut3Ll1Iq59kDz+eTKJ96Mz5B+RRtuXBe4GXykKkVDb9YE8HWpLv3AtpVp60PGZvYyTmEZHv5aRk2s68GVtM0NSHRc8rqCv/BMdVCqV0LUgg03ovEqFg1vcStVARzyzfYSuUs1hG0+iK4g9Yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d238874e-7cf7-4181-5ef3-08de84d1a4a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:35:08.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvgh0lIHFZt98hNa7xoJtZUAxlfHv+rXm1zDYd7NnmGGPslvrjuz6mzscYLRdWBorSqWNT+SPk/Gx80qqPe+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7882
X-OriginatorOrg: intel.com

On Wed, Mar 18, 2026 at 03:13:06PM +0800, Xiaoyao Li wrote:
>On 3/15/2026 9:58 PM, Chao Gao wrote:
>> The TDX architecture uses the "SEAMCALL" instruction to communicate with
>> SEAM mode software. Right now, the only SEAM mode software that the kernel
>> communicates with is the TDX module. But, there is actually another
>> component that runs in SEAM mode but it is separate from the TDX module:
>> the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
>> that communicates with it is the BIOS which loads the TDX module itself at
>> boot. But, to support updating the TDX module, the kernel now needs to be
>> able to talk to it.
>> 
>> P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
>> concurrency requirements. Add a P-SEAMLDR wrapper to handle these
>> differences and prepare for implementing concrete functions.
>> 
>> Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
>> ("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
>> callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
>> the kernel does not need to interact with it for runtime update.
>> 
>> For details of P-SEAMLDR SEAMCALLs, see Intel® Trust Domain CPU
>> Architectural Extensions, Revision 343754-002, Chapter 2.3 "INSTRUCTION
>> SET REFERENCE".
>
>SDM started to contain SEAMCALL definitions. How about just dropping this
>paragraph to avoid people from reading the old doc?

I didn't realize that. Thanks for the information.

But I don't think this is a stale reference. The SDM description is high-level
and points to the same spec for details:

  The details of such transitions are specified in the Intel® Trust Domain CPU
  Architectural Extensions.

>
>...
>
>> +static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
>> +{
>> +	guard(raw_spinlock)(&seamldr_lock);
>> +	return seamcall_prerr(fn, args);
>
>How about adding the reason of why choosing seamcall_prerr() instead of
>seamcall_prerr_ret() in the changelog?

Sure. Will add:

Use seamcall_prerr() (not '_ret') because current P-SEAMLDR calls do not use
any output registers other than RAX.
