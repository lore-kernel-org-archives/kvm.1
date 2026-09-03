Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6ED3839B7
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413170; cv=fail; b=f4yGfbFwoiYoMEJJCqX8ipZFQnr6szm9rjBR9KLhOiIYoPhBHa5/RTUY8mjycSGjzTOlJfPQoiV+TR7ODtPcCMjYsXX7Ti+AT2n+9RbFpgRypG8qJaIv4S2aUgbfFGSFwqDNzwTJ6WnvK25zPFvaOovoOHk0vAJCisZK7daOYFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413170; c=relaxed/simple;
	bh=vKGtJWtYXOJwgeh2MjI5CMmXuTb2KRFzrWbjMj7wAIY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FYGdIJjME8wrKZTuTir0cMZ/tDn1EtkhXbE8uB5lXcLT5R3k8T2kTV5grYehFb1ktt68iLO0kypStzNsz6fXn3qYfrW8h9l9diZTX25YEKUoToEqX43r5M/L7dG1mOYlN61Q1Uw3usoGz0DfX3J65R91IBGgUE1bmVvJn3vB25c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9U7Qghv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9U7Qghv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788413168; x=1819949168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vKGtJWtYXOJwgeh2MjI5CMmXuTb2KRFzrWbjMj7wAIY=;
  b=R9U7QghvZY4BOd9hexHBVmdKGS9CcnWWYe/Lw3yZoixr6H5BVFO5Qw3n
   KlBXMgZBZkWuK7Rb6rNKJIw3Tr0/XAoDai/ryUnmQ/fez3tJD6Sdzn8g+
   GeNSY2LBJkloYhU2sYzrhKk2kxQyKA2HRTz8EyCDly/z3GkpqlisLDrSo
   7cPMd+yQ0+q7TEzyBMmk//yAgmSF1th0uSvrMkpReia7OGv3AQKjjW6Eg
   w06nZ/ssBpHT3uNAp4ETDmI49/pQZrVMsV11Bx+sb2IGZaP+gTD9t+/xc
   tcTg58dg/dLuPIHscH02Ypd3ax5fBpMaQyrxpnvMt9O24pYaGDIAkbaH8
   A==;
X-CSE-ConnectionGUID: 9bvi2hBrRcC3PJIXhaKK1w==
X-CSE-MsgGUID: hAnbaDDtTW6kvY5caFYjyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88805769"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88805769"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:26:07 -0700
X-CSE-ConnectionGUID: Wtw5xiNJQRmKMhVgLStq8Q==
X-CSE-MsgGUID: SQHU5y70TQK4xI8weX5W/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273370708"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:26:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 22:26:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 22:26:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 22:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYLU4Hs+BEvizl4o8IDtyNOIjeQ+vzzBeXPbewUbpN9D7CUB8CTYWqphzUw5vtw9lqa6oD+SwCsv3o8u08qu4gB58M7nTrFb9usk3oUcKTClg69z480udqeuqmfJKqQScfKWmIAYhKcONMXn4ADTOj1Pd1JP1huiBXdmCQu9/8/nQHd5TbsoW0duLPWOTDj4mA3ACudswyKRwvfkOADvm9gmg/UQauyM6/EZa5pTlAJoR9EeJkf1h4+yI3P1j9Akcd0JdqBkIjUDyQsqTZ4Vtj8t7FNnsiptfqkBrlKYPl1yBqYoPU9Cla41WLymuY/xWabX6v8W1IiIAynKwmRz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwpln9YaAmqbDhQjboYOtayR3IzyYA5XBeXZrebxA/Q=;
 b=VR+HwXzVevpWJ/vC2Fmzbrx8UTXIPcLACVv2MgivOyW9wtNIzOsaaHuFKDkQgehtR8KdsrWLiF1sHMEVC7JCwwDmJpjj0cWZ6hTLL5YlXAsIYL4coIKgcbDEWJma9PXwL7QxC4JOGmIxOdefLd1E7Hht8o+nxT+iZUO/l95v8R7k4HuRqqNqG2mYw9COLJp0DmLb22gVYY2qGgEAnmZUKEQmjabqIUpB7s3F9J1lPzHjlr1OrYZVtILBUhWlRwP9WnKYnQhw7VjoZgdIRGGYggEdHPz12BuwCN4eH3x8yc5lNtL22R/AnYDYdtmPRHFq2+3zqfiD0+d6449uIVAsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH7PR11MB6007.namprd11.prod.outlook.com
 (2603:10b6:510:1e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:26:03 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 05:26:03 +0000
Date: Wed, 2 Sep 2026 22:25:58 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <apkE5rj8ns5UEzoh@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <20260729125829.52EA71F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729125829.52EA71F00A3E@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH7PR11MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c18420-a2f8-4f80-3e53-08df097bd8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bovlw8IdiTTopSEQi5qxMyOIQWc5TakkYBrZOrZhh4/g+GlIB6+OfmUR8r4FgXhqYgnZ9A8UXt6T7Zc66AWrT7l8h9mKtHSB6nK1v3RS2wqq5L5ovJCoKoOaFKVRL6bo5sO54AT7lt47G2+d3Zv8EvZkcPor0faJeAV/ClBYqp15VMoVBNaApiTh/qPxxuex4UahLA8N06r7DidNWJuPc3MfMIe0A6XvVZgSPnFH28qrPE2crQk12JM/1q65PykkdWdZ+8vYInILXsPVwoZ89p6yxQueCj1uxkJhHBr7JgXVcjSZ8nf0TqfJ51+rNZPFmERKqhXiSaOHqm/Ch7Ai9TAvyaL8YNTJeSNKJD0bSU4igCo4UYM0nUJinDr1TOS3+sByKllvu4p1a91aqsQBOR3yF3TQNXir0lHc3NtZOcio0SMqHGOrJ8/0ExZNKW+hK81z4kKPAKM6rHtKWH/rn3rKacNbk12n9doYiVNCJVI+Ty9zPnTARTWHcAiKUvVTew9rL3eCLIWticAuN962GFQGx4yWF88GQ+8MD3uLSuPOe9mwNfs21Gf2ScfCNRS6qNmLZKme/o9OfxdRNJgvVu8ZGdSEDGMZNCZkXVIKrLTtgoWye74e5swnUppnaPhOTEsvEPg0ZDRWfKOE+XFW9x8CqF9hR9L5tq0zBfAVg1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+euPZKC0SsAMgh3YuvGu4+KEPl39Iy8OVzbL14wi6s1QlFbgeJd6NSsrS+xe?=
 =?us-ascii?Q?XZF+X9YLG2EDDJtRvmL8vPe7dOAsMYbnDk/zvwofnlSlPbhB4mcU0XbihdJp?=
 =?us-ascii?Q?8lZXaNRimwMTp07/EwC206EVjEXbKQxIoNFyocep+u04MUMMNXvqnspOrhKX?=
 =?us-ascii?Q?mCVuWzpUlg6hE4Sk8CtZMx4//dH5nkyOmSAuPm7QIUiNeO0C2/TIst8YBz24?=
 =?us-ascii?Q?UsOITX0roXuew4Zu6kKQVWQZlaKcbVqO21/S6D83+enmTDfWgimRlBk6swIG?=
 =?us-ascii?Q?ioEF7qM5269vWjPb14c/slPBbXi1sVsv/WhweLlR5Wwc2bWMHq65QMe48auj?=
 =?us-ascii?Q?DuOaUlWnTB92aVAQ6KMBMzXYr3JBNvTeid/YcY5abNxlfCEooQkzHX8hnabs?=
 =?us-ascii?Q?ciQlmAEzW38zfpI5GUe5JLLuaKVgwLaHvJuxfJFA9jzl81sHRFLUTvehPMy6?=
 =?us-ascii?Q?mThqU7zJGQdd3CJIPHCLxE80GUDrc2keHRHyzUT77R12LFWVuJD1FFI/V0/q?=
 =?us-ascii?Q?CwT+aTB8wlFbG2mVWRhbgyPU4DRXVDUoWLlewMh8wOCQGt5k40gANixxAir7?=
 =?us-ascii?Q?rvw13Rllp9C31AiB30jwhtM8iJG8TQt0QnTVB8P9OEJRNFiI/M7rkWaCxyOn?=
 =?us-ascii?Q?Z0iZs8bD54K4T3SA3eeaO1OhXHDv/M9Jq2HOBvljHEkldnmyaWWn7MkGuqh+?=
 =?us-ascii?Q?2ogFHL8Uc02ii/rckzOZ++8YCaUETXrs3H/mqOu6MSnCq8Q8QkNLPt1nM3eE?=
 =?us-ascii?Q?yK2uhaXWeoctRuoubfXRtqa+EPzrC5kSNi48THuxTjZ/70h+pYLc8h13Jw0+?=
 =?us-ascii?Q?ZsdtYi1X1UVM2qIZBT1BNrv69xv2/rixz1SUkjM7EKyM02rvRSnKxo6Km5v0?=
 =?us-ascii?Q?ghgjRuWsFI5MicDGLXfS/LDdWMj10dQNd+p7xeRMSSbCzXkyPj7OYOZxgUaU?=
 =?us-ascii?Q?KGYsapW1hxvTimATvadkwF176OOYnETQEXSIl54Wr79xggToGlpvrKbaL8Uc?=
 =?us-ascii?Q?mtG4B5LGg/UlvIeSQBp9P643I8VqZWa9OAYJf1HTcvppRJPlh8h2axSmgPep?=
 =?us-ascii?Q?P9s+oZqvd17yCt+f8GFVxhZ90XJB9v+EmMWc+uCLvHIaPbgI1GFKAaSNvQCi?=
 =?us-ascii?Q?Oa2Z6Q+ig/0dcebgfElUa+Xvvhw3UvmGruquPDrM+bhNST7954nqF+EYE+c0?=
 =?us-ascii?Q?2JdzUMnqg5U9eNr8PWPaxhXhDHdeKo5Bq/9HMif8/zwlYVijq88vrr8OWcoc?=
 =?us-ascii?Q?oTzvingb8NC1IbHjBi8NNh28vPo7ffqDvZs+QQMmMeGAFb6Xt8IvPiHDuIap?=
 =?us-ascii?Q?IrNeuzz6vDk+ArOqxgvB3XZJ5hPcnhpo7CYFILYV3cA+6+rciq9dOf1uWTx2?=
 =?us-ascii?Q?oOXSdzVjinp1dWYMhnQzAwfwVgev54e4kEz+kCABmkzki9eBz4FhJsONp7tF?=
 =?us-ascii?Q?wwD/4NUTpkXkWKLqq//KlKl3eFf8UEkc8r7fBH5oUmU1W0ooLCk1CtsHECKL?=
 =?us-ascii?Q?Hn+nJf9wwPyLLcGjuWD+Iw0c/1YFCVN0kSTfHkyQK4okbJpchDo589a/jnP2?=
 =?us-ascii?Q?g7n3g+0B/YOGysPHfxLEQcTUXEwH4SwkN2F408+8svMFLQeBrDFuKiTJUS0k?=
 =?us-ascii?Q?5la4Ys22CDXwrtcL0WnfE6wguoFJoOdUJar/4DqcjsDx4kH2iSRGTA3qUGIo?=
 =?us-ascii?Q?+ZcJHwmpHohgMlm+fwWXbuLfKLx0TFw6AKqwnI4YBFIJ7fzvli7ymC+OdBle?=
 =?us-ascii?Q?Z/ASKTH+rw=3D=3D?=
X-Exchange-RoutingPolicyChecked: mH+YHSxso5NHRQjKHPhmc2fSSOIn4e4mO1T07I38QtOA8mucwNdng+tkFCdKc6Zl8wSwpCV+VzVKjEyFjODwQEzg/7Wch0rbszR1+dKaQxeD+IuQUqK3AgOe6cA2rHlWC5pjZjL77PsgGljO2QPcR00aivfwlsZqGY+w/b/2InjFCnNCx/l+qbBB+rALMm5QjgJ0ZyIqFPWPD6thxCfS8JGeryR4uwpWrT1gmRyUXVV2cnQy3vCy41uYAOGnsEfRuv/FwWFr0hTsnSmAs2A/drGKfqkC9YqmlS1xru+yAkox7M8xcewZI1GkMGYlkFU/qwVShgZY/qJ7OTvx5JhphQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c18420-a2f8-4f80-3e53-08df097bd8ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 05:26:03.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVfveUwedz0YN23hPGzlp1S+d0VWcJXkk8kg/GRxJ6VEVLUquadmklH916Gj94oyhxRjRKOQ4FON+D6l1xm/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 12:58:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `wait_for_quote_completion` timeout logic is inverted due to an off-by-one error in the loop condition.
> --

This was already reported by Adrian Hunter and is on my todo list [1].

[1] https://lore.kernel.org/all/20260614115016.GA3417767@pedri/

> 
