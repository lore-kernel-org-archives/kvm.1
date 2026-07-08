Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A63F871B;
	Wed,  8 Jul 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502042; cv=fail; b=q1IqhxUVOpKgeinL27OgNFIxuyAVzd0xbM5gvFzbmwDzxQFxTqYJfeXWnihBugA9wBRVAo1xg9vUf5WaNRa2PydpGfBaZ0mD+pYy2KsFuPIPGgKBiAO9r7C61YRv9buv5BTa3nD2FFQ1cMsnSlvOrLrCsE/3iKB9yM+PiihFgyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502042; c=relaxed/simple;
	bh=Tksst/CjqsQmHNQCFdN1itsXNL85X4BziPjWTLWEw2g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TH3388W7U+/DdRFU70hzuRu1eb1WMYI9Y51dvbPbaqIlBFYGpNuruDmudjH804h77FAQ/EGQbRnm/ReZaI+/FjVgYEJohZ0jz6Eo1hK+WLaz/hxX58ancgG5eRlk8CO0bsNtgQOr3cMLwFXAxNjzuKZ0B2sibmmWYwBAYhv9YGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1bhGkmM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1bhGkmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783502040; x=1815038040;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Tksst/CjqsQmHNQCFdN1itsXNL85X4BziPjWTLWEw2g=;
  b=j1bhGkmMRKBp/jgHxLp3EyTbqBbnNIFCP3O1y/woQ9cnGt3kIc5wpVXv
   I/a8ZaU97TrlXuFx+CMYY/oSwaKn0ZqvdZQBU9fxnDr/1r3QmjG0r1K4n
   ubHYdF+ETqj/yFVmY72dl/39P2Uex+v6C0RamX/ZTBiQa2UpDV12GdBbe
   QGFf67eSIsOwNuVM9WhMjKbpzp2BMhA224g+qZlXyqIgwndkDTzDboU+9
   YK+Iig0gYbYopsQtspbBogbL439MTm93+46izvz5NY2DI+SuZLmXl8zl2
   00EUGdEaZRNkVO17iJx1+n+Q4ni+2uKnbZC1TOEZxfqjToTbnaHx8eHDL
   Q==;
X-CSE-ConnectionGUID: 8SmJErxBTXqnwUYN1Xyi2g==
X-CSE-MsgGUID: qNdQEgeOSMaxaU2q0JskBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94765555"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94765555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:14:00 -0700
X-CSE-ConnectionGUID: qm/6oZAVTTqeEEQM3SD4mw==
X-CSE-MsgGUID: R0wXHLUYRp+HWK6/vlF7ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277444559"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:13:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 02:13:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 02:13:59 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 02:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx+j9OBU4wxUNOYGc6LgFgGEwsr1VhepcYuMCdsT51zOxQlMgQ2Yj4dE0z5Ck9K7YJ5r0CoueQMQZNO12DiyVW210JAfezD2SRtkQ6micG5HJCg4X7w6mDSuLngzx5QLOzEkBbfikwNTiaf33ItyGH5LAlsCMhyJUWST4sDNhPtknW9zVqbrxia2FQuuawqJFTIWOXlrOzbxRGYVfEjHkX6M1j3KaFwp7jCyzRSnIrag5rsH7zOGkJVguzx0V8W5L83aGbmszOexAajBGJ3pIUpTr+35qaO5MAgQEltKtH/HdTMESqwifMzVps9Rl4mBeLiYHOlcEs+XlWDw1AUO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBuF7q8eBO+n9h524DhBdzt42ruzIOPzHwmRZ2bU+uk=;
 b=IuDOl8MmFwSVGqv7RFTkEOT0ZYbYuMLjNbJ6hH3bMILL3EYx3XYNAXZup9k/I8BePCbzpWZ8dP6vIBSPxrll/xUFfgctLaSCgvKBBj4vz2VT9M27ImH88qNIEpLgQ0UCogyFFtQc5ICnuo/6Ug4/Uw+RTjHXehknq07Cx60W9S522YC3jnwKFgK7sKQtU2zDgiYg/Ltcb0ApvTXJfpi2zlBwE5cR37PT75avkK49+IYWwRxoQTYZYPw7yMsII2ExKcnfmDzOhty4+4zE1W8/HiG10NLntR2Rzfib9XcIYJrULIIo8YVpkPKBF8QI7bJel1+1la5EEa7oqkJ15X9/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 09:13:51 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 09:13:51 +0000
Date: Wed, 8 Jul 2026 17:13:44 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Message-ID: <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-8-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW5PR11MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da4d77d-7075-47a8-360d-08dedcd139e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 1bSO9QuzwXpRNcRd3Eam7lAzuiVETxjfRjIvW7BuAuEtMa/2XAbZSKYWrvSeAX7w0lRD6BqEFAsUEO/7PLIL52tsFuYd9IfaL+PVBB35QJTcnBmGcx1EiMgN+xLCnJT0bl4EudShdD/WtLXJIQi8I9Y8Otj+1xLM/YnUzbsDY2Lu2F/cf0CnkMZWBBoIwx+ZCYCRYYK2GgVZiXKtBkdktA44CcamsP8/lxXYpje0LmUIqfih0KZokixD+LMGOSUnRMKKzp1sKACO0+kKKU9hc3ymb0Exy79+vRrpCMVt12wtd79H6glyHPlMimNrEKAaHSqYcTq+qWWJU8LhvAiS8UakmAChncZPDcLH8TnhS+/PRDXAA24HnYVyWim+RJBqjAY7E+e+9vKPIoVmrEcyNfuCO+C6Zl34noy5Klbar0gfH2tEJeqWRZxWzdYlEl7C1uF0/nzIjAUCwXeZcQFK6fQA3tHUlHPBXBAftyVIVzL9b5xPXJfeFSj5xYBBK7oRlOTdQ0WuOgpXPBo8jjTl3iRFsxGboDkpUnSFXjN+YOhfacrA9u2xRjLwXNbP+aJ0+7L+FhIjcixh394rsKte+ZZZU8z+fr0AQx+SeQI0JQXEA9a3P2ke62xI6QtlPGWPhKY4Y6A3H3MHHXpj4W8qOURwxUTUuXWhYAokDCPU6Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziDyZhLClR0Pn8iY9cEZsfQukLkxHf2glvJntUBfaW8KQm5HdHj8Pa0yFuR2?=
 =?us-ascii?Q?RLo2Yfgyg01io68kkWSQ2sFDMyjPhmyFHpcPTrTCQxCPNL0SzlfXvaolMPYT?=
 =?us-ascii?Q?EUTOD4NN1oLpD6ju2HjgA3D7G6ZyqKFLCheM1UovLp9/5LLqsY+0+VPfhv9x?=
 =?us-ascii?Q?xUZABS9LVZXm4u4TB/usj0iegrV070Bxx4fAzJl4B5MMzac4xelFj2Z4XJ3o?=
 =?us-ascii?Q?p598I8ExcOH6dDBzcf2E3UFKODBS/kIGF6xpKJL3PmS/NEa2s/8Fgk9oWoq1?=
 =?us-ascii?Q?vHu3ay0Al5ZO1y4NNc5p+3gcuuv7LLmG/07RuUAVSIhKloU8f6ym9lwSRxVE?=
 =?us-ascii?Q?kP1rypS0HZKgebF0zk0TTXS7V5qRHLk21py/5IOk+rVaCbGq61bVFadJbt8V?=
 =?us-ascii?Q?/s2JPElgufPJDCAFVyaXI6dwpBr/bet3xp9t4UBMngwjXshycGkC5+3+jGzK?=
 =?us-ascii?Q?QYvnb7ei1z2+pDIv3x4PJxuOAVNDEGGyzQ1hYmNbJNPgcZvaIAGvJAMm+VfW?=
 =?us-ascii?Q?zMYa8uuuz4lm0CNY+mzni3D5MXAirlTRU3Bx4Z9bTgVDkJ8znvvcJImAQqv6?=
 =?us-ascii?Q?i3LCwlH0Z0LNuStBmCOKBsq+VI2MR62RRWQDk+PhGNDH8w2gbxuskjeKeb1g?=
 =?us-ascii?Q?1qaVPzi6oqySethRZ0xwVqHv5PoZsjOHMvKvOfqPMIluLB4tqN1dltCbnYCM?=
 =?us-ascii?Q?zVolgB1ilfTBL287K4OHZ1o/fkjQ0b0+j6Pzv+nkAqqlXZpluo+1qGJujtM4?=
 =?us-ascii?Q?JMdLwlEFNUJGdU53eFZIC4GAgLMvKzry9qyfJustAHWpEMlGRQWQoO7nocaU?=
 =?us-ascii?Q?XZDjnNaC+E4hu1qieH28ujnul8jpkNMWRUhgB8GL+dm73F0uQxQgI0zShZeI?=
 =?us-ascii?Q?WIZtylFCkkKICdhcruHsgpPF2uMrp6mMBWUe8gVPG9TKWRbD+fdM+j+Fel0M?=
 =?us-ascii?Q?4aYnDBXFbkqAR/DhmaXNvSsCSYBrgjfr2pnFwUMc65LrUvRog0h654NyBdJo?=
 =?us-ascii?Q?ItkDQPSv1EMoxPB0dJ188CUSD9NodNtYBiOcX3I7Mg9+RgBFkAgXs9LgAAkF?=
 =?us-ascii?Q?2ceezpBV+lyKTJK42sBYtQB/KdA1n3pChNuega2nFNJd+nW5XbE2svLuhRJq?=
 =?us-ascii?Q?VAzJe13LyHJupSiZUhUenL4pc2bI+hv3RMv22TMg3VieKCYL2mt/MYESro6U?=
 =?us-ascii?Q?j5OcZyszCXyViuGP1f3oADbwUY8QJPtaME/MjKcrkYiwef3RPhWvNkRHNiAm?=
 =?us-ascii?Q?hZpY/YNA/16gJIRjrjfcit/LCxanB0gUJudBRMkqZxslMv5yIgTVvZb269Cm?=
 =?us-ascii?Q?n2mTozvXSIH9mRCdjv/bNQ58B/esACqTIzvyBvDNsTIe7qOfP2qlNM2GraUW?=
 =?us-ascii?Q?h1xwc0dUzrM1Sye9YVnWKpZm+p2K0NEGQSxO0d3skN3RlFGqH1C/6XlKflnc?=
 =?us-ascii?Q?BDvIzesBeXu4q48EmpO+Kg+3saZvYeXud09YQrIKtv68uhG+r/6GLsGi/Cof?=
 =?us-ascii?Q?sXPP8AOZntigY+Qafg0V+rF934KUF4HSYWPNkKYIbahI36aY14sYx41iK/tF?=
 =?us-ascii?Q?mo8oOKlElsKKKirLF7eVtzhBeFBFC9YB6zjjduivC+uNfq0U7Vd6TdVZ1g2O?=
 =?us-ascii?Q?kXAkM3Ww6zv72vewebtqAjCJjbe6fPlb8LVqKXvD5YOvB8dOSxcrrxU+2dhq?=
 =?us-ascii?Q?rpp5h/SnLiloPLzpm9xz48uZTakqLlt79S6ekuCg6HXjD1kK8rorDOMenNOD?=
 =?us-ascii?Q?UXJ9OvmOkw=3D=3D?=
X-Exchange-RoutingPolicyChecked: rAtOshOnYaowkwDbD+kJIVkWprx0yRlxJY8cFhfCgdtLU4GkGpyQVjMklq1KVeaCp5G0EItfSrEqt7WRc71oWP73+pK5Q6Ot2IwjmU+GezdnQ4klEFxN9UCqkO9aXKY+ODGS5nH99C093n8VdyxZu5aA/ad8PCw9skI8CSl8yCLl0/fbuO1y17PuivX7YArkb9g7vpu6T4DFW0ZqEjLWQe1N6zokYOTZhMwu6umt7ELvAX9YjoxtOe17qJk4FJQgXbRHnD8FPUu7Y2T7DSkJJsUzuAQokQJDJ3wN6EJam4s2sDbPvFSIoXplDkL9t8xdwpvoxbYSKzN43qtTRn2htQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da4d77d-7075-47a8-360d-08dedcd139e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:13:51.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Iz0HM2tjG8FP3sODfT4FTrFCAJq3LApjlylCewd7QD8e3P52I4cwvhT/Wnb9BkcBEXdCIDDm4A+7IM0pn8WEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:11PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Use control page helpers for allocating and freeing TD control structures,
> such these operations can work for Dynamic PAMT.
> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
Nit: It records this state in the PAMT ?

> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So the kernel must install PAMT backing for each 4KB
How about
"..., only the backend to hold the 4KB page size state is allocated
dynamically" ?

> page before gifting it to the TDX module, and tear it down after the page
> is reclaimed.
How about
"So the kernel must check whether it is necessary to install/remove PAMT
backing for each 4KB page, and do so when necessary before gifting the page
to the TDX module or after it is reclaimed." ?

> TD-scoped control pages (TDR, TDCS) and vCPU-scoped control pages (TDVPR,
> TDCX) are all handed to the TDX module at 4KB page size and are therefore
> subject to this requirement. Replace the raw alloc_page()/__free_page()
> calls for these pages with tdx_alloc/free_control_page().
> 
> Switching between special Dynamic PAMT operations or normal page
> alloc/free operations is handled internally in
> tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
> calls. Just call them unconditionally. Similarly, drop the NULL checks
> before freeing, as tdx_free_control_page() handles NULL internally.
> 
> No functional change intended when Dynamic PAMT is not in use.

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
 
