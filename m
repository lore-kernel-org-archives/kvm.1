Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3B3AA4F1;
	Tue,  7 Jul 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406728; cv=fail; b=JarknCzJ0dFIid769fjHNkl/cWVlr/I69ifXCnmVHDsqfge04/0Gfw83AyM/ev3PcTBsUHvfWfd4DZI2f3fJIaIgSrL6QdRmqAK5OphzY3yJDn8GyTjTNILz7T5plBoZlF/PtbNP8DEUc8tjGYsrlv/1dqwyQBk5gi15uNkCEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406728; c=relaxed/simple;
	bh=UfJAECGemRoO0igm3n0H4yTkdUNt1vXiAlqMbhOfYiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8S+OgWxiGiVwoHNDH9za54imkZzCMI7eOfgcYA3MB/3SBIt1brsQ4jqHdWsjIyqSLydMkWL88juN6irdMhfCcXSZ7YXqrUAv6/5VzPMH11AVo8CxlXDEnjqxpAG1PsvrRHoOASfcLm1xlMensHg8lnludlRsyid2D35+13HHdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdkBHUv+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdkBHUv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783406726; x=1814942726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UfJAECGemRoO0igm3n0H4yTkdUNt1vXiAlqMbhOfYiY=;
  b=AdkBHUv+6cqTe8RGMQ4zAp1qqwxKpaX2uo44RTirkiEpHlS9bp1gimb4
   rq1DE7x//+n+S+dlASnmprMgeGi2TqyHvSi6Srt9xzFlOf9+BD5UUMI6h
   2YQZbV7sJMNHxFtXF2BcIvYDJQBq7SWfro0JL94FQ8qwM5vxM1qHPxqOg
   038F4f8O0FXIzJu2aTwSYb/WOvt/63AsQXFGqDD0trvqnsraHMU9TVk/A
   J/oWxrm1rGqC9y5NXI+gVMty4T2uQ4+hIsULmnue7IDnhloqzL7PZTnq7
   F8DO3Tl0riUZzBKAzPEPjBQDxU3hdetTqjqOEWj2IBHeglQak5Fmt6+70
   A==;
X-CSE-ConnectionGUID: 4UTAgBtLQ0uR4u8Ii35cMw==
X-CSE-MsgGUID: MFCT54d9SymMB3Q4nGzFFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84166329"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84166329"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:45:26 -0700
X-CSE-ConnectionGUID: y1v+D8qGQt+PC5F3MqdBuQ==
X-CSE-MsgGUID: Gt6RjgffTzyfRM89kMwHng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277128075"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:45:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:45:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 23:45:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:45:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxgDvRx23PtijqfeHP6nuPLjQeyECQN0g+9E452FzhoPG1FaGPrifMDj1nIRV1Pkyp+iqv31xeWYNM0BixaGSUlQeatyF/AKkVzgCxHmouq5dfI6R7QJpx3uqNb7Ecrx2Ym4uzTiLQv4tIDvskz3cFBUwh8gJrY4Fjry264P2arSQdaAZr+JjxbJ84Gpqu0739QViDMkIDB/TLcETa81IIuuvpZ9irVV4EGYWvUfAu7HPnA30yRlfD8SoxDQGEZ2modS+NZ12r0RpKMMP+7hLnt1AuCNd7vjYFvSBIxKtdR5KYYjNEnrSyTB2Q5ZwKEN4rCllkKQQtqkMgd17malHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGJ6oslaMzCsJJZA+pZA/j4Ep/dYULpI5IIfTJk2SfA=;
 b=BiMan1lNMt+Jm56cJMUh8qLZXXKm8phNge5+NZgKczlhBGLtbKyOoPFPj+B0RO2xgDVIXvi5nAQBnrlCNxW2ESdqeJPU8qj2BNiJJUMNzGTxgBblUL5oOFYWzxsCbw0aa+D4YcwohZR90zwBZm5NCLTVcZ2UQnOnys/jOSpDwn8hGxcPuP7f34dboqlA8iql9py4aFs/616CUHP7X1RTq0Bi1pQqLT6TasobQy7dyx4MrzDXdJM6lKjHHuFFSnxqmUl3cigJ5SfoygiGEavrpeuGRKnpopUrCh1JDDpoplAAeG4Sf50LkGCmXA4I+FUq0QPAkCodwr/bVoeWwMuzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:45:22 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 06:45:21 +0000
Date: Tue, 7 Jul 2026 14:45:06 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <akygcunMgpsK4mnE@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-7-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KL1PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:820:f::7) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 0233a779-ccb7-427a-3205-08dedbf350fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j8trP0YwHScX0TJEqeo+99M7VcgCGFT/mNQl/EC6T4D8w6VskikulRRAbLfI/xT+HKD7es9qhTs/JcUyE84/EIfCHsKGmvoauUFxBTeR+52/9+Rf+iJDgQwysfEtS/wjOiRqmy5RvLo4k1tYXjbb6Ju3RKSyjoR5eLnDGauG4B2mMMN8+8wTbZuU9zoBX3gFnQrULncubr/XYzIZcW0KzusJDq3BVHroIT0If0jz7XjS3tHQrmrnMaMnvCB9rLqfdepc7v+WhOptataB6K+zHxvqRaH6Cpw1ZM4UF/5w+Crs9Qgdjn4MmfsY4urU/er/w4nZhiuuVjrdptPN9+UbczXLFbxdYYjbcK3TBAFsF+SZE6oH5NUxfn/BW7GZMxumsJykcND1JCe8pcrv7IvLURL6DEDDMKakxqPnl4spW229kHY6FafAbuieyY5KapvMcWbv1W5eUamji0EdsLfwSa9fqZApFS3mlkH4ScRtu0skQ6ewCdw2p5SNYKgO/LPcfGDBfoE0ARqzmSmlPC5Nq2gXgduhjGWrRF+CRn/dsr3fa47a4a7CiTtP4LgZwEWcxpnomlH7cOX01duVph86vd+hUrHXW58rCe1owqf94C+GpGH8s30AEjs4rqV/Rs2f7YAh5gK9VckSj4aD4o3SxaRAQtpSJHBtQoujmZaxQ7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TzvngXuVDFVgDZ/+/qHDrpedOXDhMR5KbfgS2RHTgKb33Q73RGtCofGFYA0+?=
 =?us-ascii?Q?G2pTRGpulsa70YoNYvr2cO5ZHEoF8ORkMvXhqlC32VfHRZM7XCF6sXTGzxQi?=
 =?us-ascii?Q?CvBZKL6XGcCvBEbh/lqdneN218SlmpAABdSFZLWMbAhl/fd5eb6KiEMj33uD?=
 =?us-ascii?Q?1/Gfw5I1laGznRH12pmbU1DKNFGTmpol/MPitgdtKqdeE96RWT2MuSSFa2oW?=
 =?us-ascii?Q?yzw24nJk7rmv8QnCAgH5W2yQiRMCCYrpLEI4MfiN81qU6kl+gFqBZLVplORI?=
 =?us-ascii?Q?XO+ommSqg1RA8zgzUP7LCz7fx6++7+uLnc98gO3vEHuA52Y5t+3BOOkjjaBz?=
 =?us-ascii?Q?GLvAvFGoSfyv4qkclxqfz9l0Ad/UYNYZhufU8ELtNDYh0w+ILdKtHiHCifnd?=
 =?us-ascii?Q?DUNAlCmyyhgpwqUvndo+6oxUeOkat/SUxrex50OfvJO4nXVC9wpBbdbdtAQV?=
 =?us-ascii?Q?X7N3jx5nm46dSgmrXb/Oh6XusoDwONepS65zP1u5m8dsbUtVPZuWgN25MJRf?=
 =?us-ascii?Q?d8ILQGnOn3n8yQvwusx1lpWgCml8GaRCknVqaclIQb5W4dcqhxqotLbTBdpi?=
 =?us-ascii?Q?Soz8u6M6+F5ZkBxvgCaoyd3VCmEjx0mtNKchuPsHAoTmMByzNXSpdUsqoy4c?=
 =?us-ascii?Q?9hHRx2bftHypcRLcEFoGKfXXvjIoQBV7PnXOgnjYxs0qfrYoe3UWysmaqSpO?=
 =?us-ascii?Q?RDgwB2LIKysqtMwZRb9rUTX6yFiOCM5zn+Xh2UGK8GgLjcSvvsP3kDDo+phR?=
 =?us-ascii?Q?q8gv6qQ+NDUMqkYsJZZ4FWGcXySVmJuzyrJzEXOEfMAof938KeU8DbyN8/YQ?=
 =?us-ascii?Q?zJ+d0M//cQSF+7OxQN74sC4b/2tXSyLwdSq+QcnSw2d7w/apLyRiKIoLdOxI?=
 =?us-ascii?Q?ZBrWf1jwbjJFcX0NdY0mbKJGJ3Jr3Ds6g0KC+Cqov4mos02Kwic6OxXfZUtE?=
 =?us-ascii?Q?Ij+ou9JVzziAzK4EcTvDwZQiCONf6spCno/6BKjQgr/SkQ3GNgwaUFVmzwIe?=
 =?us-ascii?Q?EUbesB/xG3XaWc5+QDtE9QA1RWcQ+3FRkPoNHlBQfZ7RTWUyyJqKIFeZOBEd?=
 =?us-ascii?Q?77GGd1Io9vWGB/KHPhhaD/DpyFCYp+hlKTnwVYrrXUUCqXBnXdOz6Yh7ZOCH?=
 =?us-ascii?Q?V+twhPva6aNqQmyWBSfg7KUDR6JA3A82UB2Pe3xRb5GBctjbXxKIRg3ncNv8?=
 =?us-ascii?Q?vXvEAs1rkEhoaN64ca6Xgjb389zl8MrslDnVqNq63o1OU6X/MUvMwkHQZfCD?=
 =?us-ascii?Q?UovOJqivEIIVizgQvZySwbt5OE8RPynHptTUWhS34Zhc/7aZR50K36czMpOK?=
 =?us-ascii?Q?yzF+59+46t5smNMTLTxueHprZHGwuzE0u31d4rK0J/QKZpASHMv5c24WsPO8?=
 =?us-ascii?Q?FqwDyK+5rvB+dWEHi5ap7EbAcrdasuJ8ftVk1EnVp0kcAxW6OgevwqqlfVxB?=
 =?us-ascii?Q?f7pqBCaDL2Wx7zZM/3T7cqmSV2s597n3kK+xtT4Q0ZYIlnIM4kA1ywxamIxr?=
 =?us-ascii?Q?xxGnonxZcfudTlUeMJuxk8N0htouovlm3rcjuv1676VWrCsrcbaG7qFJaU/L?=
 =?us-ascii?Q?En70mkb0IoBjTMdV4lRtTw9OP8kAly3H5GER0zL4Z7NfpjsKPRg31n9JspIy?=
 =?us-ascii?Q?sagUpECEKVNDGnkulveY1myQPIDnvDcE9KkGpn+HvPk8Gy2RSh3Z+AhuXYGC?=
 =?us-ascii?Q?7iK3lvTCEMKsOStxotQAty31hOOguhDDBzyP+3tVhdeX3onQsir9t2Sdv/XV?=
 =?us-ascii?Q?L8+zGeJ/cQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: O/MlVrrowMVKkxhaMbLq46n492wGr8Xue5WDAcMcMAZxz5RPD0JQ1s8Mtqv6lXPadDXFlt/40e0GsTs6mmHZAphxcAgwzDue45tK0saOkTwWzMXNT6AEwfL2fk6Avpx1WTo1xIaQBkaTgL9mH6XphfxChOEZOdfSb3XMzoZcUGkm7ZNG+QNz2uLGUPRjeScwHx6Au8CWXbFpFoR53JY8iTTenXZKPGzuh7w9EteBCJoLo4GWUE3uMsgtoVYVnZJZjqJ8MtT/yIzubrIx3MiOzVojmxfkSJGUihgvukxf6wbdCWU2/Gqc4/p1R87J71GyY8ME85Sp8w4KgwwY6Ztvgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0233a779-ccb7-427a-3205-08dedbf350fb
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:45:21.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeNoznpWix7EfElcKC6KUqhTEMadEA1T8j84LGh006npBxHJ4ZkgwIZTpPQCIXIPCrVmm976WNAvvEM3ZCgGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:10PM -0700, Rick Edgecombe wrote:
>@@ -2057,32 +2057,50 @@ static int tdx_pamt_get(kvm_pfn_t pfn)

[snip]

>+	/*
>+	 * Unlike tdx_pamt_put() which uses atomic_dec_and_lock() to
>+	 * atomically handle the 1->0 transition, the get side has no
>+	 * equivalent combined primitive for 0->1. Recheck under the
>+	 * lock since another get may have already done the 0->1
>+	 * transition after both saw atomic_inc_not_zero() fail.
>+	 */
>+	if (atomic_read(pamt_refcount)) {
>+		atomic_inc(pamt_refcount);
>+		spin_unlock(&pamt_lock);
>+		goto out_free;

spin_unlock() can be moved to out_free to avoid repeating it before
each 'goto out_free'.

> 	}
> 
>+	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
>+	if (tdx_status == TDX_SUCCESS) {
>+		/*
>+		 * The refcount is zero, and this locked path is the
>+		 * only way to increase it from 0->1.
>+		 */
>+		atomic_set(pamt_refcount, 1);
>+	} else {
>+		WARN_ON_ONCE(1);
>+		ret = -EIO;
>+		spin_unlock(&pamt_lock);
>+		goto out_free;
>+	}

Reduce indentation for the normal path:

	if (tdx_status != TDX_SUCCESS) {
		WARN_ON_ONCE(1);
		ret = -EIO;
		spin_unlock(&pamt_lock);
		goto out_free;
	}

	/*
	 * The refcount is zero, and this locked path is the
	 * only way to increase it from 0->1.
	 */
	atomic_set(pamt_refcount, 1);


The rest looks good to me.

Reviewed-by: Chao Gao <chao.gao@intel.com>
