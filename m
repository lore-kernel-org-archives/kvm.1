Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405556261A;
	Tue, 22 Sep 2026 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093201; cv=fail; b=NZo3Knd7RJE/oDLAbmT7EHXjz+IO8VY2dVc9jFT2F5dMM8FK0qCycqXpUWibgxYX4sfShVZZsq7GqoM/NHqbqTRPmA6n1xQYU7VGqCG54u4BKtqohlExvXLStQq3QLU3kWGXTV2BwvWJdmagR7m4/hMTjX0FSY08L2I/XvenpSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093201; c=relaxed/simple;
	bh=LfTfpASYEtyU+N9hHJD4m1mPZXIet89akgE5MiqYiOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=prI+17N3uglP4PW8F57Vznnz41ERh1TNxjnAsEzLZHs0+F0uirlO9NkorRHqIvLtaUCpsJbbnrsZu6sd0aUf96Ii46I2QrZs6i73hISg0RS/reJpizvVLIonUOmGcB0PokDn5htCKUxICOVN0X4novVan5oz3ViOXeXQ/R4OhmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASBwKddr; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASBwKddr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790093200; x=1821629200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LfTfpASYEtyU+N9hHJD4m1mPZXIet89akgE5MiqYiOw=;
  b=ASBwKddrb/EEYlO6pxyfF3brwk8O5Ci1qIIfFW3IxQ7qz/JaBj0aY5na
   d641RhCxYvyx4JWXU0qc13KxyhDnfaDYfRYeg6rfdaBRCbahPPW5RJkHv
   8RSqfswZR8uD36TNzRCyg6ShnGmwaw1P9nLRhKlFeydW88ANx26bvu0M+
   HomAKTgXE4DR4fzfWDH+xjDCWjXLiKg3fGgbicFGRlE7GdVvyEN4lC9TN
   /M4V/2tIw5xGfBwBLAYdkt8zH2ZS96bOrMeFeUlTmoYMNm3VDuQymzXNS
   Wc6MWDqXq1HYERRbnmNOBqs9saLoyyb4TZbI3A3nK1gabtwH3gBJcth3T
   Q==;
X-CSE-ConnectionGUID: KP+NJIoIQTKpxaWqgR6jSw==
X-CSE-MsgGUID: jg3sqdimQqeC2OeDJZ7X7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90734908"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90734908"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:06:38 -0700
X-CSE-ConnectionGUID: xyl58sd1TnqQhuokPRi+ig==
X-CSE-MsgGUID: DkYFdzOzQlGCLmJvXjZtOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4273837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:06:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:06:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 09:06:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOzluCIXQQlt+rgDePq/TbdRxpphuFpqxJuhI4SS0QpeyK2xAT7ERT3M6jRQ6KY4k/D7oChe25ynl5gmtDm4MsacLxWAH0L6MdPyMJeZN9a3Q176mHEPoanT5/YuwITsS0TtgLqwmVNdrCTgGouCqk9jrjzy4w4ByyLB3E7Q5Zx7ejEFXYUjZ+9JXQCjm/9IgyXShfI6mu/GazA8HSeFn0W2ny03F4PeTngOtVuGzFmEQFd4LeAwtamOTzpPAhRN4c8/2rA2zuNUVO9lVvrJ2cWYG6vsJpetV5oDnhhmkCnFNEWPPceB8nXTVo2Ob5MNEMuLpubHrRUMSralRYSm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD4HefXBKwWlTSy2VB96f/o9Enya2QtibgtYXd+xc6Q=;
 b=rvO8Dlptah6S5gAssxhjLCISnLsIMFZ7yNnlq/YGgwGs8qV8ktdFKvogu6QlI6TBQAhiokJrwpaj4cFzRuHaFBef6HAFreFlC+KLaZYxDbi7xWgAIbat21vVngek6c12nnU+USwIdJyRLHqoahy8ad48aPHUoDFXgaDP4XsNR4qTsQx7rCDhvhqcJw7xXIDxEhMqz3ZGZEy4KUzNgw9h4wbLxHXymihu3BEGZ6eswHqxirHSmKOKyqWnnJueV80N66HpI+8EhvorjUm2KhhIVZjK5p2V3AJxi16jrzm+/pkN6aQQl1zGrabs3+nXkzCwUKsCS9DM/JkJYRrwVKpzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by IA3PR11MB8920.namprd11.prod.outlook.com
 (2603:10b6:208:578::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 16:06:33 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 16:06:33 +0000
Date: Tue, 22 Sep 2026 09:06:31 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 1/4] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <arKnh9HSI91jktvS@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-2-peter.fang@intel.com>
 <a4a562cf-f195-47fb-a402-e7bba06937ef@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4a562cf-f195-47fb-a402-e7bba06937ef@intel.com>
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|IA3PR11MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b5f82b-bac5-4e63-e944-08df18c378de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zoApNcWws7KkPKU+Yxfwg0WkldR69KuHcCddMjg3/9Qi4O+VYXYGV9/RIvvMSH+pwz9EJExfUH46TpDbal3zTrSVfouHBPyxHR75p6o1jcXAXHr2jMCeXuYBDUhluDE9dzTD5qE4DXV8f/JZHsrggLjGhXqEgzGbXpuydKg8sZK97UgE4/t9z4p1JM+h6xXIRNzESVlYXVQYAWidoGWG2AOsLFoQ9gHpVruofgShv0mMXxNluvDjjyiEogTI0Gtp3pqZIwmwXEwJ3gd7ZV101bO87H2KtlxZClnBxGd57FhsA/7GFxupFml5lgNPyMvHqgO0Hi6K0wMtNGHjKUmDcJcPYu6yx13RoljwMoS5wY7vzVEwAnvFFAELUAtVZPSeVNVRoUhe+1rRcT/NZ/FOqo8fxBqGjiOv4sd210K9Ddej9OymWMxa2lRh2Ow1XrxtrvQlAzUrXTspisS3vnkAxQwm3QB7bPeiqDK1wdvFYQ4xfx6V96fWac0tfjd/2d4Uq73PdyR4ud6k7iTAZO28zxAu7yv6EnCqOYuLeuCaonp1qQdjifBuD1h4m0nJ8paV4kdnXt/l3rSVDcdY6VOLPoJxbKQTWLBS1569efFdYtvAorIFKthx/qrhJbNYpi9JfcFcTFETLnSiG8yAJvsv9AT/Ef/r3LNM8hho/99CbzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0wlhP5Xr5Nx5cU2tzPg4uqZZglUrY7N0pyqlf6BlU2Gs7+UjEPM46pGhx81?=
 =?us-ascii?Q?MTLunRzDR6PPDQ2omo4jH5kRc27bDqHwr2C80jXiefQhDXXjM2vuq01uUVxf?=
 =?us-ascii?Q?mP5miT9H7CAEqpnVlra1zy6MdV4Cqe6ZkDkl0XuOLTFTiPp/fL7ElQvQ3Z4k?=
 =?us-ascii?Q?JqM2lijpy6YpA6FdJljVoR8DXogwW8s4nxkhFwxkvuZbdhcvkYrzEYIM7hiZ?=
 =?us-ascii?Q?CCdtX/yDtSOZmBlIjuNT2Lr405WKMXl/d5wyzh6QHPVstoUb2HpOfwc8ES2W?=
 =?us-ascii?Q?X1ransXiZ+jUCB3SCudZ3KhbUEQAuR0d6LdO8Y0YU6X6oVH/0AoKbbw6xfsH?=
 =?us-ascii?Q?hrdBwiqKqhuV6S8xfqN2m0Z0S+AJ8gLSQ/OPe572pSbewgs0Ot2eIXy4oXoC?=
 =?us-ascii?Q?W88bEcAwNwiUaq/UVv/Md3wgRwQDNNJWdhj8pSxnuaFbAC2tuIe+BLxxY9o6?=
 =?us-ascii?Q?d3awzeZ0kuNvVOTJc91eIjkANkJQeEmwVLk7dAIE41POFVRGmEKvGmzP50tw?=
 =?us-ascii?Q?eFy2riBKJoGYctnYzwEVS0VT/J9b6nvHrWHoy/b8dT3Geg3kShFf1KrMigaR?=
 =?us-ascii?Q?hH94XAxsdL7jqvKGY89MsWUzxdqVRwlgMtC9F4wda/+Cp2JInBHm6CyFKFaE?=
 =?us-ascii?Q?UAlVRnxhaQDWWIhPp0REoqQjUK5G+wHatmpVVgDL9YSjA/bhplDrQO0qmvah?=
 =?us-ascii?Q?XDmYJvyoqiN5lq1cFsYDbNyolBYnBrG+niRyrfBYAz5zmHdrtDFPmYG4kcsA?=
 =?us-ascii?Q?UpIFpfrCnCc90AlIBkuICAWTnMbM2615pMB2u59vDnzVpXlv49J1jUuMWCOm?=
 =?us-ascii?Q?3pFGjf2MNR1oL3dHYSzzgfrydQ6ZBhMLz/fg5F5XTThLZIZP6cPDTE+TeVjF?=
 =?us-ascii?Q?niTzgP7KP3yLgFXsOdNbnMyb7HxgUfRApRyOqIG3gwI1CeHFyDlh9soQen9W?=
 =?us-ascii?Q?UXwh6LHCNOC6e454PqqKtCYj4xpdlKuXCh//15TcsXuCCp/tjjX0566s5+8D?=
 =?us-ascii?Q?Mall4XEVEwZjZ4Rl/ixy/8GFb6aNcofFRFkPfHhTEEiZRYovWw3T/9iNjZPv?=
 =?us-ascii?Q?cX71MMy4SxCBZxfAscJSWuDOuV/A+hKfpiyd9DWmo+oCWmKJyNktU+FgKouL?=
 =?us-ascii?Q?rSaAL8aZyPizSsfcWGzk03nI/N25kl4MMRtMAXDA9kr6JdE/AD6VHaHYe1MD?=
 =?us-ascii?Q?p64PdlpFI2HA/5+am5KJjW+Bk2QStxMzuXvbYlBSKKt3bJQ4l9+a3QBohOZc?=
 =?us-ascii?Q?FdsJhm1bZyuoT54CSJLXqHCwfHAy7wqSu2BJMJtvAvocAQK2d2EBgFRXnR2D?=
 =?us-ascii?Q?HN9j56gjnrwQyaYS89uU6XvZimhuko+f6Kp/F9VNdd5Rz+1kLkw3aksf+GFk?=
 =?us-ascii?Q?T4B4L3qsGTs9JnEQ8Pr501UnaH+u8R6zdwz0cB1BDbF3YAKpKB1ULSTQXaa5?=
 =?us-ascii?Q?y/7Hbiy/774eP3WFrt76fT0XyOXYo97B4qbYs8b3GbekDhhx/F4RZfcVKUJW?=
 =?us-ascii?Q?sjK8+EVfQkcZ5DEWJzzTMtE/eZK/5RA/Oq1vEkJPFXY9n3gagRfJl2tj9Hbx?=
 =?us-ascii?Q?4D9cv1JriPqW/031UPejNtiToLfH5uNplDdK/h6MBRUR759hYp7L2lC8uQb0?=
 =?us-ascii?Q?5YLKah3KdSS355WEmgkx9lnrw6frTxzzDe6GHGd4eXN7cVMP01i88FOFXnlv?=
 =?us-ascii?Q?M4feY83yJDk7Ugwvk1VUjOc6h0tY11oeHH0iz5nF4b1d+gsbHwYOv7fXPkw7?=
 =?us-ascii?Q?VOTq2dZEZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: VCU3gCYbzX7ml3yJh0yL6Lkr0mfN2HCLcmFVgkU6T4c78l7EVr0Q936/bNm77Aihy3E3KxuOsIJ/9M1vHX5zXcBMP8ynj5t3UK/BVU6+vXG+2R7YIOycWZA2uRUNrPc6V6+5+OnX7eEvprZGvVQx5BYZC/oF5o5oLmDoARwPYgRmkQa9TCk2KQKzVB2AEPbxHK7LUwMTB/zyoicMiLFw1k402HQ984oQwJTZ705NLSkK1JeoGvEiwDNVazz6mCQ+YjA/lONcclz2QWo8I18VSAI/P79R/BBs3x+j3xUN5pEg01c4rz6rAzdGKFBdt4fpn27jXoiGg5nzx3qXNXgnqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5f82b-bac5-4e63-e944-08df18c378de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:06:33.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6esZkYpP2ngTG7/xPMe4iZBlBe7UX12J4dWiU2Ru6wZTmE6OjWyrgdKbjWErJzw4VPusoJPrTswr8hVNTuvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 03:14:49PM -0700, Dave Hansen wrote:
> On 9/15/26 02:26, Peter Fang wrote:
> > +/**
> > + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> > + *
> > + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> > + * guest driver uses it to size the buffer for Quotes. Older TDX modules do not
> > + * support this field and return an error.
> > + *
> > + * The reported size covers every Quote type supported by the platform,
> > + * including SGX-based Quotes.
> > + *
> > + * A runtime TDX module update does not change the reported size.
> > + *
> > + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> > + */
> > +u32 tdx_get_max_quote_size(void)
> > +{
> > +	u64 val, ret;
> > +
> > +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> > +
> > +	return ret ? 0 : (u32)val;
> > +}
> > +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> 
> This is an awful lot of stuff I'm not fond of like packed in very few
> lines of code.
> 
> 1. An unscoped, unmentioned, uncommented export
> 2. Ternary form
> 3. Casting
> 4. A kerneldoc comment that is quite verbose and restates the TDX specs
> 5. kerneldocs for something that's not a widely-used API
> 6. Comments that say the same thing as the function name
> 7. Multiple variables declared on one line
> 
> Rather than start trying to cram failure codes into the return code,
> just do:
> 
> /*
>  * Ask the TDX module what the largest possible quote might be.
>  */
> int tdx_get_max_quote_size(u64 *max_quote_size)
> {
> 	int ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, max_quote_size);

I confirmed that no casting is needed here. Even though it's defined as
a 32-bit field, the TDX module should make sure that the upper 32 bits
are zero. So using u64 makes everything cleaner.

> 
> 	/* Old modules do not support this. Tell the caller. */
> 	if (ret)
> 		return -EINVAL;
> 
> 	return 0;
> }
> 
> That's the normal pattern. Or, heck, just return a long and return
> -errnos in there.

I'll rewrite this and trim down the comment. Thanks!
