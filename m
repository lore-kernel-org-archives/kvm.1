Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780B568FA1;
	Tue, 22 Sep 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094647; cv=fail; b=rwBVma5AHzrQ1fPi1EHrbKRCP5euj2PgWzrmkZJH6Ep4VLNTkQ1h0mkl1xyC36OU5uFSvlOHhjmW8XsHEJSeQzjbj1hMKr7/58VFPA5NtbmpKNV9nmujkMvnkY1TXEqjL4WF25eW8BO8TTDfqR29DLrP1NERpS364AyoWEJ57FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094647; c=relaxed/simple;
	bh=LgBUFa9Jgj2KNpReg01JCoPFvkupumtTAdHouIQCJsc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TQ+tjOiakIfWI/GqgWYlpkbsvXiYmlDzFsTT08Lhfrl2xJujYQuU+1N5aTPAq5kOFqbCclvYSVZ6Mj4rO7BobWMVSsa4fzjcL6ofPnWw9CeURVN9gSRsIKP1MD1WO5eiXBLPKfcmS+/u4C6A/892oiFQzD6VG4cUYS9JgCuvHew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN7hy4ae; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN7hy4ae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790094645; x=1821630645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LgBUFa9Jgj2KNpReg01JCoPFvkupumtTAdHouIQCJsc=;
  b=bN7hy4aebHP9Bgi95CRsD5laJ9tJpUymqkthhBYFoX52hRuU2awTQH8J
   SPytC4wXpa2Kyv6XiDeDesP8p7WAAiB5nWnuTbXuJlkdoHQKjIp9JPy1S
   HnzNOTV7YRxciLf50t8FdMakhHwF8bq8qbeoK/zDsagJWrdmQOjou82hi
   RpfS0jt47fwK8sx6SnLiScIit1Op2DwXM9HXLc6jmqW1YH4jRFmvhte36
   TJB/n6DOw5zN3/GBvWLIdhKRKyoQXLwF+qtTadUMIRLKih3Fiix46BLFh
   qn0/M1W+f7IZ8KnDcVZjDFTDRhsHhAIjMwS8PIbrUPv2nnqm7Lz0/AfYV
   A==;
X-CSE-ConnectionGUID: J/HmTPL3SvmTqILbMNgulQ==
X-CSE-MsgGUID: zgPnMOwpQpukKuP1GqKL3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90585590"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90585590"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:30:42 -0700
X-CSE-ConnectionGUID: C1/TMb5hQTOhKXVJRNOFAQ==
X-CSE-MsgGUID: 74nXuntJQNqVtkymD0nnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="301103202"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:30:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:30:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 09:30:42 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1Ijun0MuAMroSEF1HvnVRe8DOVCIRW7DTygQIRcRarj6zB9i/obsMABdmDAgkDVWeGOCpqdS646K8oWsM+CRe3ubINzAPioXa6TxKWEqkEA/VI5Tv1fxKxzaKkmMHuGtvWQarqx/6O58AzerROSQHN/2fHnziaKJ0ZQlZXX9ACFllKuClwl/D5PElwMdUSE9vgNHH5g5ycJIIgHRZUS/f3KouP+6ASdokqP5fTikUNq4lv2OlIjpHwEnP5ABY07cZejv8fgQ/Ap/UFQB2rrd6EF1ohAkJjAKbWyFE7f5nJnqqxeHl6j438nJCWrLsbca9Z/EkvGzKDx/QPpJk59QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQjjj46Danef1Th3jZq7IU+UZPLTzzCnHv6tNmvlneI=;
 b=SDT2Sx9SD/79bpDOlkecwNq7JEvTZcIdilmB0lBCIsY5SsXStR1Yf17pnWePn/aijyrMcTXsF321ef45414r+Q5dpTlEaxhTP28CXHKNHUkBbnyNmnSXFI1g/DgdSAX8mAqcPrM/OV3Ji8nGRAH3c/04p06fTckXMnflETlpVU54r8OG+gYd0NRbKfthkQNhxd/DC16EhStvzyMLCPa9ZsOJ7Q0M+1rjIZSeLOq9uA4eFhIeqd5VWIOEoI7wA46bzfczu7y7OCBWdSFwow3uvL1mSNsPrrBTzgi/A9ej4SiZDUU9OR/05XO3pKZ/VPowVqCkIbxbaMKba/91YjPwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SJ0PR11MB6768.namprd11.prod.outlook.com
 (2603:10b6:a03:47f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:30:38 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 16:30:33 +0000
Date: Tue, 22 Sep 2026 09:30:31 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <arKtJxNMYHYSfXuO@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-4-peter.fang@intel.com>
 <620e7e38-4287-431c-8285-575c84aa1f6a@intel.com>
 <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: e8284070-84e7-4c4e-4057-08df18c6d344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: gPcaJKqDPXRNbuF+Lum1MF1E/+nyKCh+lIKqjtclSFO1WQBpk5MPEXB5YhQDg/Q26DItIG6uuzrSpmvywhrsJpVr6sjj+OtaSvKrpgHd9WF8nPZVQzBVl+ydA5GGpJCEJqHE1j/mObj0R3zT0nYFB3YI3F2nFNSG65MmugyL2KxEx0lQt7SztB1Okek9vpPCzlSOiLMgR2w3XwAKgv1nqNjZHTKI3UayY8z0r83pys8PUtOX+MZbUa9NcI9AkfekaZ3Wv0AOTXGkVajTRHmiryIknfd0c32cXjIUJ+t0S6JMzEMrWYyhRGIE+7y2JUEZGsgsKxM7o3fZ1ho3OodhWcnjjm/3JaCG7eAs1YCy7WJ6AAOQcXBA0QdDQmRLZ3SwjCD5+qzjh3XjglFEqOuxHYD+4KBeBuzw3VpCdvK+/JrfCKZmL6F1OviZ1qNtW5/oexBdawmHAWY/XOiU6kRkKbJYBMcJG+SpEaHtH+hwUzcpNFhyew4ErUjaudsH786/Ht80Dfyprvw9XFxqHnH8WtiK22/8evK9ZJIeeRYfLWM0KXQ8YeYvO39XdxCL9o2WtqnXvpxEBv70hXk6g0jpqrD5dnxqsYxcG02rNfGeL8wLJc4eqwxKnB8zuNex3ZMudFYRpoeYV5sq91D2EkoI6TlAVycjdXg1SxkltG8j0Wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVjlyPmqOSqyQzty9cd/2h3CgRwKdw4RT3i+GbiSbh16yNIW0/kUIDHB4C1P?=
 =?us-ascii?Q?J4zOs0kujGua4keg5bEMmt1T/8Gjt21nqbTUzqjOm66EEizp9dzyjTyGt8hn?=
 =?us-ascii?Q?uFge9f9mdIQDjtTj/ksLVVEAzFYJHgmmkfb1EHPhl0R2DZMxxyR9H7U7RmHr?=
 =?us-ascii?Q?3oU9yVOPnaj9HfmbJ1bDeBtKrA9JZgGNQHwlFq5MF1QNpeXhBauF2eJBMs/p?=
 =?us-ascii?Q?RP9h+wm698pv6fV7sF2RdWLizquSdIbEO6N+Mcjnee/98zWNy+2oIK76oyii?=
 =?us-ascii?Q?AHLZnhZI3Z7lOQaT0BjhYKiBmDNIvBCO9gcRUGQmXQFqFdlKGQuC+Lf8ALt/?=
 =?us-ascii?Q?RUpO706yayYAxI1YNO7NXBYFQk6M5h7fSlk/31dXYq62KsEvptU0HLDlU36R?=
 =?us-ascii?Q?pLXgV1+c2u4QfR5Uattvn26Dd1me6YMiYnPDLle1IJmnk46HYSMA3wHtzntj?=
 =?us-ascii?Q?sOXl12p4gsT1sv4j2ZB6UolC2dyYAcRSwUuTUdWJoec+Eymr5ICBPto0/pvM?=
 =?us-ascii?Q?CEGCTOMgBKSSoQjG9Uk17LzaAt8qeZ+Zy1JUjIfPKByQGDCb2Bbz5XaJqtMS?=
 =?us-ascii?Q?hPfjYnXogiecvAYwjEtIgwcdeJh3UL3dg0ElivxKHqpLOS2jwyiD2HEy+p/U?=
 =?us-ascii?Q?+8y1SFOjjTWdxUjoST/FLij2yB1cvLcioWVgf+blzLn6UiqvoXKAy/+LpFWV?=
 =?us-ascii?Q?1wKYwzaMHh06rowu3EqSvehsARpaxPsQZEXuq8Gy2ASqAtBFrCOzL6dFc6j4?=
 =?us-ascii?Q?ys+6v6ZQk2bvfbNPZSVP4VdFPKALAuRA9HBh6nXkFbAHuwbT9jaO6mtlA1rn?=
 =?us-ascii?Q?TyHvEldV6Rzru6nI15Ub3vVfoCJQHGgSWdk1L5D2lL0wRdVq9U+rvs5J50Uw?=
 =?us-ascii?Q?01qxEH0wSha1s4nBBD9t9oz1+VH3C5YNKgOQ3L+2g2GTjgoghhncUhllPy8N?=
 =?us-ascii?Q?eXjrsPXYGGh9Qhg5mhLC2zeQtosOqC9THN+JERFKYaljQQggDA+FKBZq+hvf?=
 =?us-ascii?Q?+nROhDT+xZ8ZoqmrYniidIgriHkNwZmXBMzyfvFDqWvLTLdm/Cda+jB/zdNX?=
 =?us-ascii?Q?G6mPmVnEg/z+SA+wGQhrlWs+fbC8pxuRMvvpTGJLtqzsMG4fr/15CmXZl4aK?=
 =?us-ascii?Q?wF92LUrs7ia/1wXWXKwwT6pxfddJL2ZWDOpAF3tBv8ITQsEwOncmaW4YSZhF?=
 =?us-ascii?Q?O91uGUVrhcTqgFftqGhnyPPQuX6F3WHwU04HH9kcBpmeTx9CwHf5aMIz0Lwv?=
 =?us-ascii?Q?fzRunxOkDVb0unCQXlJxWL5yABKH0APKEzl6rPj5BPtAx3GpnaBAogICJ6+8?=
 =?us-ascii?Q?dVJkUjRsgE80v4LYt45NLsCMZluZBYPjpwJuAzlNgw8a5kdhN0I5NLYRSw7r?=
 =?us-ascii?Q?7ThmH8DOc0T3a0DkcgzGa4LnybnO3504aBnGuDrzRXyCbEblBDGdBlZDxQmJ?=
 =?us-ascii?Q?xdzOdu71pTwhyK6qw70G5zJfFEqeUy5P+TN8JYNui4zVF71mAgtvH1NQ9ogb?=
 =?us-ascii?Q?rFrxl3D2aDPdfH9j4VjN44ijBBTeaULPJIoWzLSpgPYVfI+yz7cNWkCo8VnV?=
 =?us-ascii?Q?qBmqfdDJgIUT+ufrWeGrVbTY5qW3NRiWEOfZ2Fcw0a1UGWF8qJGjBC4wc3Ql?=
 =?us-ascii?Q?GT5QaxHwYV8pQP5/AsXN8rkghTApysEXeJHkeTrV+GnVS1E4Uo2s5NXut4UA?=
 =?us-ascii?Q?fdMULHNZ4CoB65jkHuepYsqQLFGb44MIiABAObOYf01VzZCsTzbYcmJR3cZO?=
 =?us-ascii?Q?8pwwr6Ckeg=3D=3D?=
X-Exchange-RoutingPolicyChecked: G/juqPudWIcaAhRdjWv4oHtHZej/c+yQJrVSZrIIgFPR6tKYAeH0K/owPCS8TbZ2kQeFB2r1TJnhcpg1XBePZIjoFI9sxUoDcfdxZtI5azuBjuP8o5PZi8gDgSzFkyrd7xym1ikzym4fLR2lEPPopxiJcINGWYyXQP12Kud0iY6ylOjW23npTjH7rMYKoTeeyrdlbgHXyEJtc4W6fFuh2CjJSudNVIb9y2toQFpxbsyvRta0S9mQoXlsM9hFxlTFGeAfTaWpdsHI/r4SgKkCHDEoiQpnMDQ9587GMzPn4KcXYzoR0/HJTpubCgGbc0NcLdxbcS1uM1c8qpkfXeYH/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8284070-84e7-4c4e-4057-08df18c6d344
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:30:33.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV9zlayv8sKkvry2BBjQZg2rDUOjApKIP4pvyI55+CihA5vyx45fkQD+H/vF+WP7sCTaEcZmOOX+eBA2fRNspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 07:59:55AM -0700, Dave Hansen wrote:
> On 9/22/26 03:05, Xiaoyao Li wrote:
> >> @@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
> >>  	if (ret)
> >>  		goto deinit_mr;
> >>  
> >> -	quote_data = alloc_quote_buf();
> >> +	quote_data_len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> >> +	quote_data = alloc_quote_buf(quote_data_len);
> > since quote_data_len is a global variable, it looks no need to pass it around.
> > 
> > Same for free_quote_buf()
> 
> It's not the end of the world, but... global variable == bad. Plus,
> handing global variables around can actually make the code flow more clear.
> 
> I'd much rather have a quote_data_len() with a static function variable.
> Oh, and, btw... "quote_data_len" is the wrong name. It's literally *not*
> "the length of the quote data" itself because it has the header metadata
> included in there.

Thanks. I'll apply the static function variable pattern suggested in
patch 4, and think of a better name.

The pointer to this buffer is "void *quote_data" which probably needs a
better name too.
