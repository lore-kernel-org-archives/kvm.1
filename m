Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1635366806;
	Tue,  7 Jul 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396789; cv=fail; b=Uy9PeSMlbl5Imhzf8LUPxB+38BmykgfaVv7ACxiQeV+N8mkQWiVMtkctBPPiLPoo8KNLLPf+PC+XfPmw4T3zNdjaa+042jOy3mwPvUfU+V9APoPX01gv7w+aOWLBNMBY2syXVnhe0nfYBmcVnoOUQGQ/T1DBFiD+tg0xn++9tHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396789; c=relaxed/simple;
	bh=d1R7/0QLESWiII5H2CI77xj4JFZU/uslPYmxMrRiu88=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWgT+rwwW6ZdrIvKugEdOEojS6iOI7vaE8udjLO09F50weDcgqZ8J94q977rcC6QCE279LyWM9f6rdUm4nSuc31jnh/zxWD0mJt2vZqcq+mwYEc/8FsA5uhTaG45CbcqSiP4ynbCLe5hRBTz6OmYHmDc3oBdMtnLfPiiVWSIwZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQduFpgF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQduFpgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783396788; x=1814932788;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=d1R7/0QLESWiII5H2CI77xj4JFZU/uslPYmxMrRiu88=;
  b=nQduFpgFJo3FWPzh12hoS2rCAU/I/AQwxHeXpMlCSoG3csuYrK2epkis
   RtUTAFsov8bMyvj4+aiqRTHnYnCzQ55H9sZwsHjUmP1UgZIO98xUUWdkK
   +bb71U5vIiX1qNdH1eK1HgPqx4SZnw7G7k+/WoW2+blsuFU8I3GMj9qUL
   Wkpexrk5JZ5iOXixpp/dG1bi4pDW88+5ehZQzGAd5T09H1rzWxsEq5ts2
   N1sY9JAlVO5YPEWDUwXaz8kGoqF6XdlA9/BbNMS//m2muHw6tW/jL1JN5
   HLUTVon4/5UILo4P1xRW3ppF2Fn1gnm/LkiSDu71h5SHBgUhluuT/5nK4
   g==;
X-CSE-ConnectionGUID: r+cDJf1sQZSaUDKDoecYCA==
X-CSE-MsgGUID: CROZVi+PSX65TDxLFI9frA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="106836092"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="106836092"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:59:48 -0700
X-CSE-ConnectionGUID: LxFnYWRJSp27gneZwTqixg==
X-CSE-MsgGUID: TQqcABCrSL6lSdBKM6FJCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="292055481"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:59:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:59:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 20:59:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfgi9SkyWGS22YWTnwU3RX4SLpMpJ2Ibw4hK0Zqos8GibbpxzxF/F3nrjdNyazn9Imn4+bkfDE6PEsoRcB6X/iAEFZ6L91l8Ts17u3zfcI3y4ax9/Urg+0QtLZPMqe0AELURws3CQzb9DASvoMOkmjb4ZRjTYXsB8KLMBugiNH675/+ryBTXpTC9/oUAhyfO6YMwAAAUkEBPB1K+pG0+rADF61Ab/rno/IaYmEDYUYalyfId9UaEno5/yc1AvFa73D6I1vHufaBzZmEgXl1+T45SzRweHz7zytYKoC07Ok2jddZLbkt8VsCWbXZIh11BEDuOY1sxct4/tIEz/ASeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L7dLTTmUMQN1moeuU35ahFM+BDPCUPMt6TTBsrn0Jk=;
 b=ujeZp6FeJHxob0s0vup0m29Rlv8qBqzrQkkzQ2WWIcrj61jRvkMbdcm2EeFYHKc2CXQIX6Br62jcP5aziwTHs+lT8f0naRUiYDNF3kDmu0iuChBSNibHwNipvnuXH4faIfoOHaXhgQ5JG6T9dNRV43Lh5Us+jV7Tozyp58KGQXsbhmNsaylhsMFSI0yg/1Vi2NeBZG/WqAqZlewsZ5uLSkuXqJnYaDYzX8ZoKPRT0ZNa4EuN3jwktO4mUpJiZsCRRfBWunpS1CXV+pjef66rhaYWGYBYQzdFD/CkoVEULDxV5x6igPYL7PeAos9u8yxyWOQCk1/2UxdGj+IwfZRhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 03:59:39 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 03:59:39 +0000
Date: Tue, 7 Jul 2026 11:59:33 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Message-ID: <akx5pdOgoaGzsw/u@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-3-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KU2P306CA0052.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd6dd31-ac07-44ee-a453-08dedbdc2b0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: rvMvqrNtsKzRb3qy7hf/AHdgTOPmqW7lCDBw60KjEbWMpuDz2onG626izz2s7PjuPAlOzLMud38bCz0YK6NP2jt97zdbX90YQxEs4fBbKHm1xBlrtWAKRw3PwrDLWhvmVMpF2zwrukewClCc1GcRRhwMZ2AkOAO3qIBQSAKi8Dgtp/Qtpneb2GNh0M8TAT3VsIw0V5qvkibFNzts/leNhXqafM8+d7fGS+UHOQvF8cVinUWGWqREAzR3nTIcARvNhODEDpArtHnPRenQUoZJHJN8f9N2Lw01QFVB/plnpL2hAFq+z9UqgUX95Dn/iTfJX+twZrc2GBmEEMN7Pp6Rkj8UprC7Ahh9/7YaF27rsZHLXuS2QV3Lh/Ew1q++oOMu6K2LyxIFU4JK9YsQZLE+Of+HocBPN3zhfbhEdcN/u6KAqLnGOTazxWyTRZ3so+/Q+P/xd++CnrreS8GPBk9QdqJom/XfhIc7F8ri/P5Fe8J841NNvF4hnKuy3XxmiIYSgihxEtiz0tGzXbmYeazsZ3cdpiZ6ro55i2AvotfC60/Kub36Qvf9GWILDcVQVvXOUIIR74wXJ4kZygBA9G+jkMxiKhkYL9pHvj12VzCSX7bnGLL5RDH3sV/fkPxBdo74rHXNRvnPPFvUyqWO20EeuqlPPYtTP9So3mOfBQpUt8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N98NIJ1xk1DZaqPpx/ZKwTUi+6Uu64xIXaHcvrPN3mCPGTurHj+f58TIJyLz?=
 =?us-ascii?Q?/U1/TbF99N5TzcAG4KpNoN4AnR0GWg6xMRLvvzJ+SD23WVCnEgKbrJuTtjWz?=
 =?us-ascii?Q?7roeGYO66YVK8Xn2pm2Rryq9VXO5vtpjC7uVdNvlSCsI6qg9u1UoB6OyNnQI?=
 =?us-ascii?Q?hHhVG+veD2t5JXs0d9P47N2aeAbi9qJgNBRLoyVms7a9kFfNY/j6i4sDv586?=
 =?us-ascii?Q?dbEUU9077qoUvN1ckZGxx2pJ8hmYw6eIGqXVxyEOFuEngi+jWioQjU0m3eLs?=
 =?us-ascii?Q?+HRlE1C2uo/Lgj0z1WliohgUFpyLm1PLb4ecFGbpZHtccqa5/qdDdoCY4LK2?=
 =?us-ascii?Q?PViPkJ81elgh6o3w0/7P9ugrWclEd5c7I8jJgIV+EiMijxuCuBE0glnF8nZd?=
 =?us-ascii?Q?UBSi39OcouIYu2tVY8JUxgnM2JOJcT0dWe8TLWv3AX1mN176oQ5dqm5fhkEQ?=
 =?us-ascii?Q?UihGFY9kguorBAAWPI0FQZUQTrJhgWWX6p+8qFI0sOb6r0gy6DuOe51rOtO2?=
 =?us-ascii?Q?XRaL3SVYHtEmMXfJkS2eE/GTjjOyx/3rc1JcH0tJ+ENSu56vRYjpFTQg0YCH?=
 =?us-ascii?Q?DQq2jje9xtR88ycKMeaHUD6S63rgN6YRNb4eWmh197fXYdYbdUVk3DOnBrHL?=
 =?us-ascii?Q?LdZ8TUi7yJ566xdYUT5lMA8Wn8afoTUyoYqaOjJTJdwpey3MemLJFIcuJvsK?=
 =?us-ascii?Q?quuj0d1j0WryxsPOWrS2zYBOgSrnuO+E5vf/VuemnADBlUZ5y03Zg2+bnoox?=
 =?us-ascii?Q?EI99JQOexzBfqvmzlOOMQgHIj0LHzfcQE5NLqEQ3XPFfVmQGjyOW/7IE1stG?=
 =?us-ascii?Q?tvMev+w+0GDwba3AEcPyRYgTcQ2ZcFr/HM4ziBY5EcvvvDgm4Q+KBpKRypNp?=
 =?us-ascii?Q?/tVTD0pdiTri8qOOwVnnKfsd46ejzqcgjuBSeIDLY+uGGYGwoWdwP9E/lMFF?=
 =?us-ascii?Q?7Jtf3+GumwJihDuhsoS5TImIf3RoAkFzAlS7fNd/JIA4Y6HYFuTEWzmc89Et?=
 =?us-ascii?Q?Rmr5753OpFy2PgpK6yr5ApHT8N50+x+Toc6sJLJFaZ7qTzZFSZQL9MAOyFeH?=
 =?us-ascii?Q?lHVuMXTezNKIgvgI5Glt/UKsHEZ5vMXWAN35Xz2V6xTBbQjuG0KLdBfBlSf4?=
 =?us-ascii?Q?KSoE/or7RowEAVXUE1WrTexg6RmgvNJ5kgYPoQHQPELwExo7IS2mcU20s0/o?=
 =?us-ascii?Q?DnIzd4xp0STKuDFkyR5PMs1/Y3QhqNxyY4nH1eTdEaIvGdemAjyMevhXZTu3?=
 =?us-ascii?Q?fmVLYkDfqFpGcyKUsQwyQ1kkgnwJ2avI3OjrfiC78nFSJ3SiyNi1QXDjbfyA?=
 =?us-ascii?Q?4i9P4//KFTHZWRXY9UnDmGdmGXXPhpt6stonJIYS+m9YbvXVSGlxrES6dvlA?=
 =?us-ascii?Q?TZb2lpUUzprRHe9krsLkQJa9GRgIiADRw7BkmKaBOwrE3txqojPvLBDeN+hs?=
 =?us-ascii?Q?yzScFiF+kgrU/YOoeUeHX6hd1meg4YLNp9I+YaOHucImAKqFFJ/sb6Ewy9of?=
 =?us-ascii?Q?46WzveJ3bSx1b+XZI1n6frx8k0O7y21og1LGFEmmy0wPBS8A2uJoyJaMT2QA?=
 =?us-ascii?Q?xzpJa7ECacp3EheUYHxsjfUnqe8u74agbmYEBrVvB24ctJY3jLrvpjGO4E/Y?=
 =?us-ascii?Q?d7tqnn7xm9H7ZYcjd3YlnerWtmgum5LbS7JTDmbM46GlS07HgJz0aTlEMVhx?=
 =?us-ascii?Q?zEStePgO4vGUPDIki1ndUj6IC/Hx9XDhm3Vjo7Y38PzHFdaYWJmEqONqzhka?=
 =?us-ascii?Q?OfnDZORpWw=3D=3D?=
X-Exchange-RoutingPolicyChecked: g7yWLQ1TeqvsoLNltApiU0jIETJtCpBZ++BB3lsHXqUw8oRy2FGS8WvX6EROYZalry3Tlk3FJZjtMEBjUSL7Mormti2XzTvroe/id1G0CerxCgi2oj2dIe1LL1QbNBoSFDBPvteIIdBN93VWj573+ArvEUvHAqwfirW6yDgbfraoj3PGNpJOaFKbQAt0MqLs84/wyRpLYLv7reZTGXh8sbtl8Cb+ty9pngXa4+qbHNl2TiRKGS5AO9FeHhawJ5U1XrQHZwxfXgN2sTAL0XRT2pEVbFAkQRDMwtK/1tE9OAXbHBnZpcXZ5wmob3whnhoeGLYLVuocKC/Mo2QORIObQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd6dd31-ac07-44ee-a453-08dedbdc2b0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:59:39.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SK/cpb17buCnQMeHSVh9HPOIJS/9m72W5bzC6HgCpGW7Bk19xangjcJ/iotEUUBjkZjZKDRAzTSH9ieurJ8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:06PM -0700, Rick Edgecombe wrote:
> +static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
> +{
> +	return false; /* To be enabled when kernel is ready */
> +}
> +
Nit:
Would the following style be better, though the comment will soon be removed?

static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
{
	 /* To be enabled when kernel is ready */
	return false;
}

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
